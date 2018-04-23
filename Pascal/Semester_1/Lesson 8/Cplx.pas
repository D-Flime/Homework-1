Unit Cplx;

Interface
  Uses Crt;
  Const 
    /// ��������� ��������
    eps = 0.000001;
  Type 
    ///- complex(Re, Im)
    /// ����������� ����� ���� (Re + i * Im)
    complex = record
      Re, Im: real;
    end;
  /// ���������� ���� ������������ ����� z � ������ � ������������ (x, y)
  Procedure ReadC( x, y: integer; Var z: complex);
  /// ������� ����������� ����� z �� ����� � ������ � ������������ (x, y)
  Procedure WriteC(x, y: integer; z: complex);
  /// ����������� ����������� ����� z
  Procedure Inv(z: complex; var w: complex);
  Procedure Code(z: complex; var w: complex);
  /// ���������� ����������� ���� (0, 0)
  Function Zero(): complex;
  /// ���������� ����������� ������� (1, 0)
  Function One(): complex;
  /// ���������� ��������� �������� ���� ����������� ����� u � v
  Function Add(u, v: complex): complex;
  /// ���������� ��������� ��������� ���� ����������� ����� u � v
  Function Sub(u, v: complex): complex;
  /// ���������� ��������� ������������ ���� ����������� ����� u � v
  Function Mult(u, v: complex): complex;
  /// ���������� ��������� ������������ ������������� ����� a � ������������ ����� z
  Function Prod(a: real; z: complex): complex;
  /// ���������� ��������� ������� ���� ����������� ����� u � v
  Function Division(u, v: complex): complex;
  /// ���������� ������ ������������ ����� z
  Function Modul(z: complex): real;
  /// ���������� ��������� ���������� ������������ ����� z � ������� degree
  Function Pow(z: complex; degree: integer): complex;
  /// ���������� ���������� ������������ ����� z
  Function ExpC(z: complex): complex;
  /// ���������� ������� ������������ ����� z
  Function CosC(z: complex): complex;
  /// ���������� ����� ������������ ����� z
  Function SinC(z: complex): complex;
  
Implementation

  Procedure ReadC( x, y: integer; Var z: complex);
  begin
    GoToXY(20, 20); Write('Enter the z.Re: '); Readln(z.Re);
    GoToXY(x, y); Writeln('z = (', z.Re:6:2, ', ');
    GoToXY(20, 20); Write('                              ');
    
    GoToXY(20, 20); Write('Enter the z.Im: '); Readln(z.Im);
    GoToXY(x + 12, y); Writeln(z.Im:6:2, ')');
    GoToXY(20, 20); Write('                              ');
  end;

  Procedure WriteC(x, y: integer; z: complex);
  begin
    GoToXY(x, y);
    Writeln('(', z.Re:6:2, ', ', z.Im:6:2, ')');
    GoToXY(20, 20);
  end;

  Procedure Inv(z: complex; var w: complex);
  Var znam: real;
  begin
    znam := sqr(z.Re) + sqr(z.Im);
    w.Re := z.Re / znam;
    w.Im := -z.Im / znam;
  end;

  Procedure Code(z: complex; var w: complex);
  begin
    w.Re := z.Re;
    w.Im := -z.Im;
  end;

  Function Zero(): complex;
  Var w: complex;
  begin
    w.Re:= 0;
    w.Im:= 0;
    Zero:= w;
  end;

  Function One(): complex;
  Var w: complex;
  begin
    w.Re:= 1;
    w.Im:= 0;
    One:= w;
  end;

  Function Add(u, v: complex): complex;
  Var w: complex;
  begin
    w.Re := u.Re + v.Re;
    w.Im := u.Im + v.Im;
    Add := w;
  end;

  Function Sub(u, v: complex): complex;
  Var w: complex;
  begin
    w.Re := u.Re - v.Re;
    w.Im := u.Im - v.Im;
    Sub := w;
  end;

  Function Mult(u, v: complex): complex;
  Var w: complex;
  begin
    w.Re := u.Re * v.Re - u.Im * v.Im;
    w.Im := u.Re * v.Im + u.Im * v.Re;
    Mult := w;
  end;

  Function Prod(a: real; z: complex): complex;
  Var w: complex;
  begin
    w.Re := a * z.Re;
    w.Im := a * z.Im;
    Prod := w;
  end;

  Function Division(u, v: complex): complex;
  Var z: complex;
  begin
    z.Re:= (u.Re * v.Re + u.Im * v.Im) / (sqr(v.Im) + sqr(v.Re));
    z.Im:= (u.Im * v.Re - u.Re * v.Im) / (sqr(v.Im) + sqr(v.Re));
    Division:= z;
  end;
  
  Function Modul(z: complex): real;
  begin
    Modul := sqrt(sqr(z.Re) + sqr(z.Im));
  end;
  
  Function Pow(z: complex; degree: integer): complex;
  Var i: integer;
      a: complex;
  begin
    a := z;
    for i := 2 to degree do a := Mult(a, z);
    Pow := a;
  end;
    
  Function ExpC(z: complex): complex;
  Var k: integer;
      P, S: complex;
  begin
    k:= 0; P:= One(); S:= One();
    while Modul(P) >= eps do
    begin
      k:= k + 1;
      P:= Mult(P, z);
      P:= Prod(1/k, P);
      S:= Add(S, P);
    end;
    ExpC:= S;
  end;
    
  Function CosC(z: complex): complex;
  Var k: integer;
      z2, P, S: complex;
  begin
    z2:= Pow(z, 2);
    k:= 0; P:= One(); S:= One();
    while Modul(P) >= eps do
    begin
      k:= k + 2;
      P:= Mult(P, z2);
      P:= Prod(1/k/(k-1), P);
      S:= Add(S, P);
    end;
    CosC:= S;
  end;
    
  Function SinC(z: complex): complex;
  Var k: integer;
      z2, P, S: complex;
  begin
    z2:= Pow(z, 2);
    k:= 1; P:= z; S:= z;
    while Modul(P) >= eps do
    begin
      k:= k + 2;
      P:= Mult(P, z2);
      P:= Prod(1/k/(k-1), P);
      S:= Add(S, P);
    end;
    SinC:= S;
  end;

End.