%% 3 Körperproblem in MatLab mit ODE45.
%
%      F = - G* m0 m1 ( p0 - p1 ) / |p0 - p1|^3
%      m0 p0'' = - G * m0 m1 ( p0 - p1 ) / |p0 - p1|^3 
%                - G * m0 m2 ( p0 - p2 ) / |p0 - p2|^3
%
%      m1 p1'' = - G * m1 m0 ( p1 - p0 ) / |p1 - p0|^3 
%                - G * m1 m2 ( p1 - p2 ) / |p1 - p2|^3
%
%      m2 p2'' = - G * m2 m0 ( p2 - p0 ) / |p2 - p0|^3 
%                - G * m2 m1 ( p2 - p1 ) / |p2 - p1|^3
%
%      y1 = p0(x)
%      y2 = p0(y)
%      y3 = p0'(x)
%      y4 = p0'(y)
%
%    Es können 12 Gleichungen erster Ordnung angeschrieben werden
%    Gleichungen 1 - 4
%
%      y1' = y3
%      y2' = y4
%      y3' = - (m0/m2) * ( y1 - y5  ) / |(y1,y2) - (y5,y6) |^3 
%            - (m1/m2) * ( y1 - y9  ) / |(y1,y2) - (y9,y10)|^3
%      y4' = - (m0/m2) * ( y2 - y6  ) / |(y1,y2) - (y5,y6) |^3 
%            - (m1/m2) * ( y2 - y10 ) / |(y1,y2) - (y9,y10)|^3
%
%
clear 
close all
clc
  global m0 m1 m2 G n
  fprintf ( 1, '  Herzlich Willkommen zum 3-Körper Simulator\n ' );
  fprintf ( 1, 'Bitte wählen Sie den Simulationsmodus:\n' );
  fprintf ( 1, '0.: System Sonne-Erde-Mond im Maßstab\n' );
  fprintf ( 1, '1.: Allg. 3-Körperproblem\n' );
  fprintf ( 1, '2.: System Sonne-Erde-Mond ohne Maßstab\n' );
  fprintf ( 1, '3.: gleichseitiges Dreieck gleiche Masse und Geschwindigkeit\n' );
  n = input('Modus wählen: ');
  p = input('\nAnimation einschalten: 1: EIN / 0: Aus   ');

  switch n
   case 0
%% System Sonne-Erde-Mond
       disp('System Sonne-Erde-Mond')
  m0    = 1.989e30;                 % Masse Sonne
  m1    = 5.972e24;                 % Masse Erde
  m2    = 7.349e22;                 % Masse Mond
  G     = 6.67408e-11;      % Gravitationskonstante m^3/(kg *s^2)
  
  xes   = 1.496e11;                 % Entfernung Erde - Sonne
  xem   = 3.844e8;
  xsm   = xes - xem;            % Startbedingung Entfernung Sonne - Mond
  
  SP = (xes * (m0)/(m0+m1));           % Schwerpunkt zw. Sonne und Erde
  SPm = (xem)*m1/(m1+m2);      % Schwerpunkt zw. Erde und Mond
  
  yr = 1;                                % Jahre
  t1 = 0;                                % Startzeit
  T = sqrt((4*pi^2*SP^3)/(G*(m0+m1)));  % Umlaufzeit
  Tm = sqrt((4*pi^2*SPm^3)/(G*(m2+m1)));  % Umlaufzeit
  t_final = yr * T;                      % Endzeit
  t_range = linspace(t1, t_final, yr*1000);
  
  % Achsen
  l= -1.5*xes;                      % Achsenlange -x
  r=  1.5*xes;                      % Achsenlange x
  u= -1.5*xes;                      % Achsenlange -y
  o=  1.5*xes;                      % Achsenlange y
  
 % Startpunkte
  X0x = 0.0;
  X0y = 0.0;
  X1x = xes;
  X1y = 0.0;
  X2x = xsm;
  X2y = 0.0;
  
  % Startgeschwindigkeit
  V0x = 0.0;
  V0y = -(2*pi/(T))*(xes-SP);
  V1x = 0.0;
  V1y = (2*pi/(T))*SP;
  V2x = 0;
  %V2y = 31000;
  V2y = V1y + (2*pi/(Tm))*xem;
%           
   case 1
%% Allgemeines 3-Körperproblem   
       disp('Allgemeines 3-Körperproblem')
  m0    = 25;               % Masse 1
  m1    = 15;               % Masse 2 
  m2    = 1;               % Masse 3
  G     = 1; 
  % Startpunkte
  X0x = -3;
  X0y = -3;
  X1x = 0.5;
  X1y = -2.0;
  X2x = 3.0;
  X2y = 0.0;
  
  % Startgeschwindigkeit
  V0x = 1;
  V0y = 0;
  V1x = -1;
  V1y = 1;
  V2x = 0;
  V2y = 2;
  
  t_initial = 0.0;
  t_final = 10.0;
  t_range = linspace(t_initial, t_final, 25*t_final);
  
  max_x = max( [X0x, X1x, X2x, X0y, X1y, X2y] );

  l     = -1.5*max_x;
  r     =  1.5*max_x;
  u     = -1.5*max_x;
  o     =  1.5*max_x;
  
%            
    case 2
%% Sonne-Erde-Mond ohne Maßstab
    disp('Sonne-Erde-Mond im Maßstab')
  m0    = 200;
  m1    =  10;
  m2    = 0.01;
  G     = 6.67408e-11;      % Gravitationskonstante m^3/(kg *s^2) 
  
  % Startpunkte
  X0x = 0;
  X0y = 0;
  X1x = 10;
  X1y = 0;
  X2x = 9.0;
  X2y = 0.0;
  
  SP = (X1x * (m0)/(m0+m1));           % Schwerpunkt zw. Sonne und Erde
  SPm = (X1x - X2x)*m1/(m1+m2);      % Schwerpunkt zw. Erde und Mond
  
  t_initial = 0.0;
  u = 1.5;                    %Umdrehungen
  T = sqrt((4*pi^2*SP^3)/(G*(m0+m1)));
  Tm = sqrt((4*pi^2*(SPm)^3)/(G*(m2+m1)));
  t_final = u*T;
  t_range = linspace( t_initial, t_final, u*1000);
  
  % Startgeschwindigkeit
  V0x = 0;
  V0y = -(2*pi/T)*(10-SP);
  V1x = 0;
  V1y = (2*pi/T)*SP;
  V2x = 0;
  %V2y = 8;
  V2y = V1y + (2*pi/Tm)*(SPm);
  
  max_x = max( [X0x, X1x, X2x] );
  max_y = max( [X0y, X1y, X2y] );
  
  % Achsen
  l     = -1.5*max_x;
  r     =  1.5*max_x;
  u     = -1.5*max_x;
  o     =  1.5*max_x;
   %
    case 3
%% Gleichseitiges Dreieck bei gleicher Masse
       disp('Gleichseitiges Dreieck bei gleicher Masse')
  m0    = 10;
  m1    = 10;
  m2    = 10;
  G     = 1;  
  
  a = 5;                        % Kantenlänge 5
  ha=sqrt((a^2-(a/2)^2));
  ri = ha/3;
  
  % Startpunkte
  X0x = -a/2;
  X0y = -ri;
  X1x = a/2;
  X1y = -ri;
  X2x = 0.0;
  X2y = (ha-ri);
  
  % Startgeschwindigkeit
  V0x = 1.0;
  V0y = 0.0;
  V1x = -0.5;
  V1y = sqrt(1^2-V1x^2);
  V2x = -0.5;
  V2y = -sqrt(1^2-V1x^2);
  
  t_initial = 0.0;
  t_final = 40.0;
  t_range = linspace( t_initial, t_final , 10*t_final);
  
  max_x = max( [X0x, X1x, X2x, X0y, X1y, X2y] );

  l     = -1.5*max_x;
  r     =  1.5*max_x;
  u     = -1.5*max_x;
  o     =  1.5*max_x;
%      
    otherwise
  end 
  
%% Übergabe Orts- und Geschwindigkeitswerte für ODE45 Funktion
  x_initial = [ X0x;  X0y;   V0x;   V0y;
                X1x;  X1y;   V1x;   V1y;
                X2x;  X2y;   V2x;   V2y];
%%  Fehlertoleranz
  options = odeset ( 'RelTol', 1.0e-10, 'AbsTol', 1.0e-10 );
  %options = odeset ( 'RelTol', 1.0e-5, 'AbsTol', 1.0e-5 );
%%  ODE Funktion
 [ T1, Y1 ] = ode45 (@simple_f, t_range, x_initial, options );
 %[ T1, Y1 ] = ode45 (@simple_f, t_range, x_initial );
%
%% Funktionsaufruf Animation
anim(Y1, p, l, r, u, o)
%
%%  Plot-Funktionen
figure ( 2 )
    hold on
    axis([l r u o])
    plot ( Y1(:,1), Y1(:,2),'r','LineWidth',1)
    plot ( Y1(:,5), Y1(:,6),'b','LineWidth',1 )
    plot ( Y1(:,9), Y1(:,10),'g','LineWidth',1 )
    axis square
    grid on
switch n
    case 0
    title ( 'System Sonne-Erde-Mond' )
    legend ('Sonne', 'Erde' , 'Mond')
 
    case 1  
    title ( 'Allg. 3-Körperproblem')
    legend ('Körper 1', 'Körper 2' , 'Körper 3')
    
    case 2
    title ( 'System Sonne-Erde-Mond ohne Maßstab' )
    legend ('Sonne', 'Erde' , 'Mond')
    
    case 3
    title ( 'gleichseitiges Dreieck gleiche Masse und Geschwindigkeit')
    legend ('Körper 1', 'Körper 2' , 'Körper 3')
    otherwise
end
%% Funktionsaufruf Zero-velocity Plot nur für Sonne - Erde - Mond System ohne Maßstab
if n == 2 
zerov(m0, m1, 6) 
else
end
%
   fprintf ( 1, '  Normal end of execution.\n' );