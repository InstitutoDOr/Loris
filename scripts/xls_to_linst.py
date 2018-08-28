'''
IDOR
by Bruno Melo <bruno.melo@idor.org>
'''
import glob, os, csv, sys, datetime, numpy, re
from openpyxl import Workbook, load_workbook

COLS = {
    'table'      : 'Table',
    'column'     : 'Column',
    'label'      : 'Label',
    'valueLabel' : 'ValueLabel',
    'value'      : 'Value',
}

# START POINT
def main():
    if len(sys.argv)>1: #Getting filename
        xlsFile = sys.argv[1]
    insts = Instrument.extract_insts( xlsFile )
    for inst in insts:
        inst.to_linst()

def unique(elems):
    seen = set()
    seen_add = seen.add
    return [x for x in elems if not (x in seen or seen_add(x))]


class Instrument:
    @staticmethod
    def extract_insts( xlsFile ): # Identifies and generates an array with all instruments
        wb = load_workbook(filename = xlsFile)
        insts = []
        for sheet in wb:
            insts.append( Instrument.find_insts(sheet) )
        return insts

    @staticmethod
    def find_insts(sheet): # Receives a sheet and identifies all instruments
        header = sheet['1:1'];
        # TO DO, change to work with different spreadsheets
        ws_data = {
            'labels'     : [c.value for c in sheet['A'][1:]],
            'column'     : [c.value for c in sheet['B'][1:]],
            'valueLabel' : [c.value for c in sheet['C'][1:]],
            'value'      : [c.value for c in sheet['D'][1:]],
        }
        
        inst = Instrument( sheet.title, name=sheet.title )
        
        # Treating each column
        for colKey in unique(ws_data['column']):
            if not colKey: # Avoiding empty values
                continue
                
            idx = [i for i, x in enumerate(ws_data['column']) if x == colKey]
            colLabel = ws_data['labels'][idx[0]]          
            if len(idx) > 1 or isinstance(ws_data['value'][idx[0]], (int, float) ):
                labels = [ws_data['valueLabel'][i] for i in idx]
                values = [ws_data['value'][i] for i in idx]
                value = dict(zip(values, labels))
            else:
                value = ws_data['value'][idx[0]]
                
            # Insert new column
            col = InstrumentColumn( colKey, colLabel, value )
            inst.columns.append(col)
            
        return inst
        
    def __init__(self, table, name='', columns=None):
        self.table = table
        self.name = name
        self.columns = [] if columns is None else columns        
    
    # Function that generates a linst file using a instrument configuration dictionary
    def to_linst(self):
        if not self.name:
            self.name = input('Instrument Name: ')
        max_year = datetime.datetime.now().year + 5;
        min_year = max_year - 15;
        
        # TEMPLATE HEAD
        linstContent = (\
        "table{{@}}{0}\n" + \
        "title{{@}}{1}\n" + \
        "date{{@}}Date_taken{{@}}Date of Administration{{@}}{2}{{@}}{3}\n" + \
        "static{{@}}Candidate_Age{{@}}Candidate Age (Months)\n" + \
        "static{{@}}Window_Difference{{@}}Window Difference (+/- Days)\n" + \
        "select{{@}}Examiner{{@}}Examiner{{@}}NULL=>''\n"\
        ).format(self.table, self.name, min_year, max_year)
        
        for col in self.columns:
            linstContent += col.to_linst() + "\n"
            
        # Writing linst file
        filename = self.table + ".linst"
        with open(  filename, "w") as text_file:
            text_file.write(linstContent)
            print( 'Generated file "%s"' % filename )
    
# Subclass
class InstrumentColumn:
    def __init__(self, key, label, value=''):
        self.key = key
        self.label = label
        self.type = type
        self.set_value(value)
    
    def set_value( self, value ):
        if isinstance(value,dict):
            self.type = 'select'
        else:
            value = str(value)
            # Value will define the type
            if value[0] == '#':
                self.type = 'numeric'
                lims = re.findall(r'[-+]?\d+\b', value)
                if len(lims) == 2:
                    value = '@'.join(lims)
                else:
                    value = ''
            else:
                self.type = value
                value = ''
            
        # Finishing column setup
        self.value = value
            
    def to_linst(self):
        value = self.value
        if isinstance(value,dict):
            value = "NULL=>''{-}" +\
                    "{-}".join(["'%s'=>'%s'" % (key, value) for (key, value) in value.items()]) + \
                    "{-}'not_answered'=>'Not Answered'"
        else:
            value = str(value)
        text = '{@}'.join([self.type, self.key, self.label, value])
        
        # Including 'Not Answered' option when is not a select field
        if self.type is not 'select':
            text = text + "\nselect{{@}}{0}_status{{@}}{{@}}NULL=>''{{-}}'not_answered'=>'Not Answered'".format(self.key)
        return text


if __name__ == "__main__":
    main()