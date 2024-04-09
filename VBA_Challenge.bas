Attribute VB_Name = "VBA_Challenge"
Sub Stock_Analysis()
    'Display Column Titles
    Cells(1, 9).Value = "Ticker"
    Cells(1, 10).Value = "Yearly Change"
    Cells(1, 11).Value = "Percent Change"
    Cells(1, 12).Value = "Total Stock Volume"
    
    'Define the variables
    Dim evalCell As Object
    Dim compCell As Object
    Dim comp2Cell As Object
    Dim i As Integer
    Dim outRow As Integer
    Dim intPrice As Double
    Dim endPrice As Double
    Dim yrChng As Double
    Dim pctChng As Double
    Dim stVol As Double
            
    'Set counter variable start values
    i = 2
    outRow = 2
    'Set evalCell = Cells(i, 1)
    'MsgBox (evalCell)
    'Set compCell = Cells((i + 1), 1)
    'MsgBox (compCell)
    'Set comp2Cell = Cells((i - 1), 1)
    'MsgBox (comp2Cell)
    
    'Create a loop that cycles through all the rows and stops at the end of the data
    'Record the opening price at the beginning of a given year to the closing price at the end of that year
    'Display the yearly change and percent change
    'Calculate and Display total volume
    Do Until IsEmpty(evalCell)
        Set evalCell = Cells(i, 1)
        Set compCell = Cells((i + 1), 1)
        Set comp2Cell = Cells((i - 1), 1)
        
        If evalCell <> comp2Cell Then
            intPrice = Cells(i, 3).Value
            stVol = Cells(i, 7).Value
            i = (i + 1)
        ElseIf evalCell = compCell Then
            stVol = stVol + Cells(i, 7).Value
            i = (i + 1)
        Else
            Cells(outRow, 9).Value = evalCell
            endPrice = Cells(i, 6).Value
            yrChng = endPrice - intPrice
            Cells(outRow, 10).Value = yrChng
            pctChng = (yrChng / intPrice) * 100
            Cells(outRow, 11).Value = pctChng
            stVol = stVol + Cells(i, 7).Value
            Cells(outRow, 12).Value = stVol
            i = (i + 1)
            outRow = outRow + 1
        End If
        
    Loop
    MsgBox (evalCell)
    MsgBox (intPrice)
    MsgBox (i)
End Sub


Sub not_equal_check()
    Dim evalCell As Object
    Dim compCell As Object
    
    Set evalCell = Cells(1, 1)
    Set compCell = Cells(2, 1)
    
    If evalCell <> compCell Then
        MsgBox ("not equal")
    Else
        MsgBox ("idk")
    End If
End Sub
zP.Data.ErrorGroup0 � zP.Data.FirstTimeStamp0 � zP.Data.Trackback0 �   V   V         V   V      	   W   W         W   W      	   X   X         X   X      	   Y   Y         Y   Y      	   