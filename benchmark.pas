program MatrixMultiplication;

uses
    SysUtils, Time;

const
    M_SIZE = 400;

var
    i, j, k              : LongInt;
    start_time, end_time : TDateTime;
    time1, time2         : Double;
    m1, m2, m3           : array[1..M_SIZE, 1..M_SIZE] of LongInt;
    result1, result2     : QWord;

begin

    (* ---------------------------------------------------- *)
  
    start_time := Now;

    result1 := 0;
    for i := 1 to 100 do
        for j := 1 to 1000000 do
            result1 := result1 + j;

    end_time := Now;
    time1 := (end_time - start_time) * 24 * 60 * 60; // Convert from days to seconds

    (* ---------------------------------------------------- *)

    start_time := Now;

    for i := 1 to M_SIZE do
        for j := 1 to M_SIZE do
            begin
                m1[i, j] := i + j;
                m2[i, j] := i + j;
            end;

    for i := 1 to M_SIZE do
        for j := 1 to M_SIZE do
            begin
                m3[i, j] := 0;
                for k := 1 to M_SIZE do
                    m3[i, j] := m3[i, j] + m1[i, k] * m2[k, j];
            end;

    result2 := 0;
    for i := 1 to M_SIZE do
        for j := 1 to M_SIZE do
            result2 := result2 + m3[i, j];

    end_time := Now;
    time2 := (end_time - start_time) * 24 * 60 * 60; // Convert from days to seconds

    (* ---------------------------------------------------- *)
  
    WriteLn(Format('Pascal  : Result= %d, Time= %10.6f sec, Result= %d, Time= %10.6f sec', [result1, time1, result2, time2]));

end.
