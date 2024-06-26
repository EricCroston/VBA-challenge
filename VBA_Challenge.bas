Attribute VB_Name = "VBA_Challenge"
Sub Stock_Analysis()

'Loop through each worksheet in the workbook
Dim ws As Integer
Dim wsCount As Integer

wsCount = ActiveWorkbook.Worksheets.Count
For ws = 1 To wsCount


    'Display Column Titles
    Sheets(ws).Cells(1, 9).Value = "Ticker"
    Sheets(ws).Cells(1, 10).Value = "Yearly Change"
    Sheets(ws).Cells(1, 11).Value = "Percent Change"
    Sheets(ws).Cells(1, 12).Value = "Total Stock Volume"
    
    'Define the variables
    Dim evalCell As Object
    Dim compCell As Object
    Dim comp2Cell As Object
    Dim i As Long
    Dim outRow As Integer
    Dim intPrice As Double
    Dim endPrice As Double
    Dim yrChng As Double
    Dim pctChng As Double
    Dim stVol As Double
    Dim condRange As Range
    Dim maxRow As Integer
    Dim maxInc As Double
    Dim maxDec As Double
    Dim maxVol As Double
            
    'Set counter variable start values
    i = 2
    outRow = 2
    Set evalCell = Sheets(ws).Cells(i, 1)
    'MsgBox (evalCell)
    'Set compCell = Sheets(ws).Cells((i + 1), 1)
    'MsgBox (compCell)
    'Set comp2Cell = Sheets(ws).Cells((i - 1), 1)
    'MsgBox (comp2Cell)
    
    'Create a loop that cycles through all the rows and stops at the end of the data
    'Record the opening price at the beginning of a given year to the closing price at the end of that year
    'Display the yearly change and percent change
    'Calculate and Display total volume
    Do Until IsEmpty(evalCell)
        Set evalCell = Sheets(ws).Cells(i, 1)
        Set compCell = Sheets(ws).Cells((i + 1), 1)
        Set comp2Cell = Sheets(ws).Cells((i - 1), 1)
        
        If evalCell <> comp2Cell Then
            intPrice = Sheets(ws).Cells(i, 3).Value
            stVol = Sheets(ws).Cells(i, 7).Value
            i = (i + 1)
        ElseIf evalCell = compCell Then
            stVol = stVol + Sheets(ws).Cells(i, 7).Value
            i = (i + 1)
        Else
            Sheets(ws).Cells(outRow, 9).Value = evalCell
            endPrice = Sheets(ws).Cells(i, 6).Value
            yrChng = endPrice - intPrice
            Sheets(ws).Cells(outRow, 10).Value = yrChng
            pctChng = (yrChng / intPrice) * 100
            Sheets(ws).Cells(outRow, 11).Value = pctChng
            stVol = stVol + Sheets(ws).Cells(i, 7).Value
            Sheets(ws).Cells(outRow, 12).Value = stVol
            i = (i + 1)
            outRow = outRow + 1
        End If
        
    Loop
    
    
    'Display the ticker and value for the greatest % increase, greatest & decrease and greatest toatl volume
    Sheets(ws).Cells(1, 16).Value = "Ticker"
    Sheets(ws).Cells(1, 17).Value = "Value"
    Sheets(ws).Cells(2, 15).Value = "Greatest % Increase"
    Sheets(ws).Cells(3, 15).Value = "Greatest % Decrease"
    Sheets(ws).Cells(4, 15).Value = "Greatest Total Volume"
    
    'Display the ticker and value for the greatest % increase
    i = 2
    maxRow = 2
    Set evalCell = Sheets(ws).Cells(i, 10)
    maxInc = Sheets(ws).Cells(i, 10).Value
    Do Until IsEmpty(evalCell)
    
        Set evalCell = Sheets(ws).Cells(i, 10)
        
        If maxInc < Sheets(ws).Cells(i + 1, 10).Value Then
            maxInc = Sheets(ws).Cells(i + 1, 10).Value
            i = i + 1
            maxRow = i
        Else
            i = i + 1
        End If
        Sheets(ws).Cells(2, 16).Value = Sheets(ws).Cells(maxRow, 9).Value
        Sheets(ws).Cells(2, 17).Value = maxInc
           
    Loop
    
    'MsgBox (maxRow)
    
    'Display the ticker and value for the greatest % decrease
    i = 2
    maxRow = 2
    Set evalCell = Sheets(ws).Cells(i, 10)
    maxDec = Sheets(ws).Cells(i, 10).Value
    Do Until IsEmpty(evalCell)
    
        Set evalCell = Sheets(ws).Cells(i, 10)
        
        If maxDec > Sheets(ws).Cells(i + 1, 10).Value Then
            maxDec = Sheets(ws).Cells(i + 1, 10).Value
            i = i + 1
            maxRow = i
        Else
            i = i + 1
        End If
        Sheets(ws).Cells(3, 16).Value = Sheets(ws).Cells(maxRow, 9).Value
        Sheets(ws).Cells(3, 17).Value = maxDec
           
    Loop
    
    'MsgBox (maxRow)
    
    'Display the ticker and value for the greatest total Volume
    i = 2
    maxRow = 2
    Set evalCell = Sheets(ws).Cells(i, 12)
    maxVol = Sheets(ws).Cells(i, 12).Value
    Do Until IsEmpty(evalCell)
    
        Set evalCell = Sheets(ws).Cells(i, 12)
        
        If maxVol < Sheets(ws).Cells(i + 1, 12).Value Then
            maxVol = Sheets(ws).Cells(i + 1, 12).Value
            i = i + 1
            maxRow = i
        Else
            i = i + 1
        End If
        Sheets(ws).Cells(4, 16).Value = Sheets(ws).Cells(maxRow, 9).Value
        Sheets(ws).Cells(4, 17).Value = maxVol
           
    Loop
    
    'MsgBox (maxRow)
    
    
    'MsgBox (evalCell)
    'MsgBox (intPrice)
    'MsgBox (i)
    'MsgBox (maxRow)
    
    'Set Column widths
    Sheets(ws).UsedRange.EntireColumn.AutoFit
        
    'Format Yearly Change values so positive values are green and negative are red
    Set condRange = Sheets(ws).Range("J2").EntireColumn
    condRange.FormatConditions.Delete
    condRange.FormatConditions.Add(xlCellValue, xlGreater, "0").Interior.Color = RGB(0, 255, 0)
    condRange.FormatConditions.Add(xlCellValue, xlLess, "0").Interior.Color = RGB(255, 0, 0)
    'Format Percent Change values so positive values are green and negative are red
    Set condRange = Sheets(ws).Range("K2").EntireColumn
    condRange.FormatConditions.Delete
    condRange.FormatConditions.Add(xlCellValue, xlGreater, "0").Interior.Color = RGB(0, 255, 0)
    condRange.FormatConditions.Add(xlCellValue, xlLess, "0").Interior.Color = RGB(255, 0, 0)
    Sheets(ws).Range("J1, K1").FormatConditions.Delete
    

'MsgBox (ActiveWorkbook.Worksheets(ws).Name)
Next ws
End Sub

. D.                                   ��w�$   /. E.                                   ���$   /. E.              �                    0�w�$   1. 3.                                    �w�$   1. 9.                                    �w�$   1. B.                                   ��w�$   1. J.                                   P�w�$   1J'D              �                      �w�$   D. 3.                                   �w�$   D. D. 