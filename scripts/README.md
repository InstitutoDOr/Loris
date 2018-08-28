# REQUIREMENTS

Python 3.*
Module openpyxl

Obs: Only tested in *Windows 10*

# HOW PREPARE
Install lib openpyxl

    ```bash
    pip install openpyxl
    ```
    
# USAGE
1. Adjust excel file to match columns with the names:

    COLS = {
        'table'      : 'Table',
        'column'     : 'Column',
        'label'      : 'Label',
        'valueLabel' : 'ValueLabel',
        'value'      : 'Value',
    }
    
2. Drag and drop excel file to "xls_to_linst.py" file or run the command:

    ```bash
    python xls_to_linst.py <EXCEL_FILE>
    ```