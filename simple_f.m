function ydot = simple_f ( t, y )
%*************************************************************************
%% SIMPLE_F returns the right hand side of the three body ODE system.
%    Input, Zeit T.
%    Input, real Y(12)
%    Output, real YDOT(12), die Ableitung der aktuellen Lösung
%
  global m0 m1 m2 G n

switch n
    case 0
  r0 =  6.95e8;
  r1 =  6.371e6;
  r2 =  1.737e6;
  
    case 1
  r0 =  5e-3;
  r1 =  5e-3;
  r2 =  5e-3;
  
    case 2
  r0 =  5e-3;
  r1 =  5e-3;
  r2 =  5e-3;   
  
    case 3
  r0 =  5e-3;
  r1 =  5e-3;
  r2 =  5e-3;
    otherwise
end
                
  x0 = y(1:2);
  x1 = y(5:6);
  x2 = y(9:10);

  ab12 = norm (x2-x1);
  ab02 = norm (x2-x0);
  ab10 = norm (x0-x1);
  
  if ab12<r1+r2
      ab12=r1+r2;
  end 
  
  if ab02<r0+r2
      ab02=r0+r2;
  end
  
  if ab10<r0+r1
      ab10=r1+r0;
  end
  
  d0 = ( x2 - x1 ) / (ab12^2 * norm (x2-x1));
  d1 = ( x0 - x2 ) / (ab02^2 * norm (x2-x0));
  d2 = ( x1 - x0 ) / (ab10^2 * norm (x0-x1));

 %{
  ydot(1:2) = y(3:4);
  ydot(3:4) = G * (m1 * d2 - m2 * d1);
  ydot(5:6) = y(7:8);
  ydot(7:8) = G * (m2 * d0 - m0 * d2);
  ydot(9:10) = y(11:12);
  ydot(11:12) = G * (m0 * d1 - m1 * d0);

  ydot = ydot(:);
%}
  
  ydot(1:2) = y(3:4);
  ydot(3:4) = G * (m1 * d2 - m2 * d1);
  ydot(5:6) = y(7:8);
  ydot(7:8) = G * (m2 * d0 - m0 * d2);
  ydot(9:10) = y(11:12);
  ydot(11:12) = G * (m0 * d1 - m1 * d0);

  ydot = ydot(:);

  return
end
