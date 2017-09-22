function zerov_nr(Ms, Me, Mk, max_height) 
% Funktion für Berechnung des Kraftvektors im Gravitationssystem
% Erweiterung um einen dynamisch veränderlichen Schwerpunkt des Gesamtsystems
clear c 
global m0 m1 m2 R0x R0y R1x R1y R2x R2y G n 

% Hauptschwerpunkt Sonne Erde
MU = Ms / (Me + Ms); 
r_eb_mag = 1 * MU;              % Entfernung Sonne - Schwerpunkt in AU
r_mb_mag = (1-r_eb_mag);        % Entfernung Erde - Schwerpunkt in AU 

r_sb = r_eb_mag * [ -1 0 0]';   % Vektor Sonne zum Schwerpunkt (AE) 
r_eb = r_mb_mag * [ 1 0 0]';   	% Vektor Erde zum Schwerpunkt (AE) 

 x=-2:.05:2;                    % Bereich für Plot in x-Richtung
 y=-2:.05:2;                    % Bereich für Plot in y-Richtung

for i=1:length(x) 
for j=1:length(y) 
rho=[x(i) y(j) 0]'; 

r1 = r_sb + rho;                 % Abstand Sonne zu Punkt X
r1_mag = norm(r1); 
r2 = r_eb + rho;                 % Abstand Erde zu Punkt X 
r2_mag = norm(r2); 

v(j,i) =-(x(j)^2 + y(i)^2 + 2*(1-MU)/r1_mag + 2*MU/r2_mag); % Effektives Potential 
if v(j,i)>max_height 
v(j,i)=max_height; 
end 
if v(j,i)<-max_height 
v(j,i)=-max_height; 
end 
end
end 
%% Erstellung von Höhenlinien
l = 25;                                 % Anzahl Höhenlinien
csize=size(v); 
data=reshape(v,[1 csize(1)*csize(2)]); 
[numbinned, centers]=hist(data,l);    
contourlist=linspace(-4, -1, 2*l); 
% 
%% Fig. 3 Kombinierte Höhenlinien mit effekt. Potential
figure(3)
[a b]=contour(x,y,v,contourlist); 
hold on
surf(x1,y,v,'FaceColor','none',...
    'EdgeColor','flat'); 
grid on
xlabel('x'); 
ylabel('y'); 
zlabel('Effekt. Potential');
title({'Höhenlinien'},'FontWeight','bold','FontSize',18);
%
%% Fig. 4 Höhenlinien
figure(4)
[a b]=contour(x,y,v,contourlist); 
grid on
xlabel('x'); 
ylabel('y'); 
title({'Höhenlinien'},'FontWeight','bold','FontSize',18);
%
%% Fig. 5 Höhenlinien für effekt. Potential
figure(5)
[a b]=contour3(x,y,v,contourlist); 
xlabel('x'); 
ylabel('y'); 
zlabel('Effekt. Potential'); 
title({'Höhenlinien für effekt. Potential'},'FontWeight','bold','FontSize',18);
%
%% Fig. 6 Effektives Potential
figure(6)
surf(x,y,v,'FaceColor','none',...
    'EdgeColor','flat'); 
xlabel('x'); 
ylabel('y'); 
zlabel('Effekt. Potential');
title({'Effektives Potential'},'FontWeight','bold','FontSize',18);


