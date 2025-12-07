# microgo_codegen.nim - Generate C code from AST
import microgo_parser
import strutils

proc generateC*(node: Node, context: string = "global"): string =
  case node.kind
  of nkProgram:
    result = "" # Start empty!

    # Track what we find
    var hasCMain = false
    var hasMicroGoMain = false
    var topLevelCode = "" # For #includes, C functions, etc.

    # First pass: analyze what we have
    for funcNode in node.functions:
      if funcNode.kind == nkCBlock:
        let cCode = generateC(funcNode, "global")
        topLevelCode &= cCode & "\n"
        if "int main()" in cCode:
          hasCMain = true
      elif funcNode.kind == nkFunction:
        if funcNode.funcName == "main":
          hasMicroGoMain = true
        result &= generateC(funcNode, "global") & "\n"

    # Build output in correct order:
    # 1. Top-level C code (includes, function definitions)
    result = topLevelCode & result

    # 2. Generate main() if needed
    if not hasCMain and not hasMicroGoMain:
      # No main() found anywhere, add default
      result &= "\nint main() {\n"
      result &= "  // Auto-generated entry point\n"
      result &= "  return 0;\n"
      result &= "}\n"
  of nkPackage:
    # Package declaration - just ignore for C output
    result = "// Package: " & node.packageName & "\n"
  of nkFunction:
    # Generate function declaration
    if node.funcName == "main":
      result = "int main() {\n"
    else:
      result = "void " & node.funcName & "() {\n"

    # Generate function body
    result &= generateC(node.body, "function")

    # Add return for main
    if node.funcName == "main":
      result &= "  return 0;\n"

    result &= "}\n"
  of nkAssignment:
    # For now, just generate assignment
    result =
      generateC(node.target, context) & " = " & generateC(node.value, context) & ";\n"
    if context == "function":
      result = "  " & result
  of nkReturn:
    # Generate return statement
    if node.callArgs.len > 0: # Assuming return has callArgs for value
      result = "return " & generateC(node.callArgs[0], context) & ";\n"
    else:
      result = "return;\n"
    if context == "function":
      result = "  " & result
  of nkBlock:
    result = ""
    for stmt in node.statements:
      let stmtCode = generateC(stmt, context)
      if context == "function":
        result &= "  " & stmtCode
      else:
        result &= stmtCode

      # Ensure statements end with newline if needed
      if stmtCode.len > 0 and stmtCode[^1] != '\n':
        result &= "\n"
  of nkCBlock:
    # Handle C blocks differently based on context
    var cCode = node.cCode

    # Clean up the C code
    cCode = cCode.strip(leading = false, trailing = true)

    # Check if this looks like a function definition
    let looksLikeFunction =
      (
        " int " in cCode or " void " in cCode or " char " in cCode or " float " in cCode or
        " double " in cCode
      ) and "(" in cCode and "){" in cCode

    # Function definitions must be at global scope
    if looksLikeFunction and context != "global":
      echo "Warning: Function definition inside function at line ", node.line
      echo "This may not compile in standard C."
      echo "Consider moving to top level:"
      echo "  @c { ... }  # Instead of inside func ... { @c { ... } }"

    result = cCode
    if result.len > 0 and result[^1] != '\n':
      result &= "\n"

    # Add indentation if inside a function
    if context == "function":
      result =
        "  " & result.replace("\n", "\n  ").strip(leading = false, trailing = true) &
        "\n"
  of nkVarDecl:
    result = "int " & node.varName & " = " & generateC(node.varValue, context) & ";\n"
    if context == "function":
      result = "  " & result
  of nkBinaryExpr:
    result =
      generateC(node.left, context) & " " & node.op & " " &
      generateC(node.right, context)
  of nkIdentifier:
    result = node.identName
  of nkLiteral:
    result = node.literalValue
  of nkStringLit:
    var escaped = ""
    for ch in node.literalValue:
      case ch
      of '\n':
        escaped &= "\\n"
      of '\t':
        escaped &= "\\t"
      of '\r':
        escaped &= "\\r"
      of '\\':
        escaped &= "\\\\"
      of '"':
        escaped &= "\\\""
      else:
        escaped &= ch

    result = "\"" & escaped & "\""
  of nkCall:
    var callCode = ""

    if node.callFunc == "print":
      callCode = "printf("

      if node.callArgs.len == 0:
        callCode &= "\"\\n\""
      else:
        let firstArg = node.callArgs[0]
        case firstArg.kind
        of nkStringLit:
          let str = firstArg.literalValue

          # Simple warning for obvious issues
          var percentCount = 0
          for ch in str:
            if ch == '%':
              inc(percentCount)

          # Rough estimate (doesn't handle %% correctly, but okay for warning)
          if percentCount > 0 and node.callArgs.len == 1:
            echo "Warning at line ", node.line, ":"
            echo "  String has ", percentCount, " % characters"
            echo "  But print() has only 1 argument"
            echo "  Did you forget arguments for the format specifiers?"

          callCode &= generateC(firstArg, context)
          for i in 1 ..< node.callArgs.len:
            callCode &= ", " & generateC(node.callArgs[i], context)
        else:
          callCode &= "\"%d\", " & generateC(firstArg, context)

      callCode &= ");\n"
    else:
      # Regular function call
      callCode = node.callFunc & "("
      for i, arg in node.callArgs:
        if i > 0:
          callCode &= ", "
        callCode &= generateC(arg, context)
      callCode &= ");\n"

    # Apply indentation if in function context
    if context == "function":
      result = "  " & callCode
    else:
      result = callCode
