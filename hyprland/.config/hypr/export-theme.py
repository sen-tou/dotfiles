import sys
import regex
import os.path

def main():
    if len(sys.argv) < 3:
        sys.exit("""
    Usage:
        export-theme.py file_path outputfile [...outpufiles]

    Supported file output filetypes:
        css
    """)

    filename = sys.argv[1]
    output = sys.argv[2:]

    print(sys.argv)

    with open(filename) as file:
        lines = [line.rstrip() for line in file]

    variables: dict[str,str] = dict() 
    for line in lines:
        # each line needs the pattern $var = value or var
        result = regex.search(r'(\$[a-zA-Z-_]+)\s+=\s+(\$.*|.*)', line)
        if result:
            validate_defined_variables(result, variables)
    
    for output_filepath in output:
        write_outputfile(output_filepath, variables)

    return

def validate_defined_variables(result: regex.Match[str]|None, variables: dict[str,str]):
    if not result:
        return
    
    groups = result.groups()
    var = groups[0][1:]
    value = groups[1]
    
    # variable is aliased
    if value.startswith("$"):
        value = value.replace("$", "")
        if value in variables.keys():
            value = variables[value]
        else:
            sys.exit(f"Tried to assign {value} to {var}, not defined")
    variables[var] = value

    return

def write_outputfile(filename: str, variables: dict[str,str]):
    extension = os.path.splitext(filename)[1][1:]
    
    if extension == "css":
        write_css(filename, variables)
        return
    if extension == "css_waybar":
        write_css_waybar(filename, variables)
        return

    sys.exit(f"Cant handle {extension}")


def write_css(filename: str, variables: dict[str, str]):
    def row(var: str, value: str) -> str:
        return f"--{var.replace("_", "-")}: {value};\n" 

    def template(content: str) -> str:
        return f"""
:root {{
{content}    
}}
        """ 

    content = ""
    for var, value in variables.items():
        content += row(var, value)  

    file_content = template(content)

    with open(filename, 'w+') as f:
        f.write(file_content)

    return

def write_css_waybar(filename: str, variables: dict[str, str]):
    def row(var: str, value: str) -> str:
        return f"@define-color {var.replace("_", "-")} {value};\n" 

    content = ""
    for var, value in variables.items():
        content += row(var, value)  

    with open(filename, 'w+') as f:
        f.write(content)

    return

main()
