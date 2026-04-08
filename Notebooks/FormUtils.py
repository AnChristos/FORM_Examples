import os
import subprocess
import re
from IPython.core.magic import register_cell_magic

# Get the current directory 
notebook_dir = os.getcwd()
# Go up one level to the project root and into /scripts
script_dir = os.path.abspath(os.path.join(notebook_dir, '..', 'scripts'))
# Create the director if it doesn't exist
os.makedirs(script_dir, exist_ok=True)


@register_cell_magic
def pyForm(line, cell):
    """
    Magic to run FORM from a cell
    """
    filename = line.strip() if line else "temp"
    frm_path = os.path.join(script_dir, f"{filename}.frm")
    out_path = os.path.join(script_dir, f"{filename}.out")

    # Save the input script
    with open(frm_path, 'w') as f:
        f.write(cell)

    # Run FORM 
    result = subprocess.run(['form', frm_path], capture_output=True, text=True)

    # Check Return Code (RC) for safety
    if result.returncode != 0:
        error_msg = result.stderr if result.stderr else result.stdout
        print(f"--- FORM ERROR (RC {result.returncode}) ---\n", error_msg)
        return None

    print(result.stdout)


def capture_physics_expr(filename="tmp.txt"):
    """
    Read saved FORM C-style output and return it.
    """
    try:
        with open(filename, 'r') as f:
            content = f.read().replace('\n', '').replace(' ', '').strip()
            content = content.rstrip(';')        
            return content
            
    except FileNotFoundError:
        print(f"Error: {filename} not found.")
        return None
