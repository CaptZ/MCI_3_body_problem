function anim(Y1, p, l, r, u, o)
%%  Plot--Animation 
global n
if p == 1 
[a,b]=size(Y1); 
switch n
    case 0
    figure(1)
    for i=1:1:a  
    hold on
    grid on 
    x1 = Y1(i,1);
    y1 = Y1(i,2);
    plot (x1,y1,'r.')
    x2 = Y1(i,5);
    y2 = Y1(i,6);
    plot (x2,y2,'b.')
    x3 = Y1(i,9);
    y3 = Y1(i,10);
    plot (x3,y3,'g.')
    axis([l r u o])
    drawnow
     if i == 2 
    title ( 'System Sonne-Erde-Mond im Maßstab' )
    legend ('Sonne', 'Erde' , 'Mond')
     else
    end 
        end

    case 1
   figure(1)
     for i=1:1:a  
    hold on
    grid on 
    x1 = Y1(i,1);
    y1 = Y1(i,2);
    plot (x1,y1,'r.')
    x2 = Y1(i,5);
    y2 = Y1(i,6);
    plot (x2,y2,'b.')
    x3 = Y1(i,9);
    y3 = Y1(i,10);
    plot (x3,y3,'g.')
    axis([l r u o])
    drawnow
    pause(0.1);
    if i == 2
    title ( 'Allg. 3-Körperproblem')
    legend ('Körper 1', 'Körper 2' , 'Körper 3')
    else
    end
     end
        
    case 2
        for i=1:1:a  
    figure(1)     
    x1 = Y1(i,1);
    y1 = Y1(i,2);
    plot (x1,y1,'r-o','MarkerSize',25,'MarkerFaceColor',[1,1,0])
    hold on
    grid on 
    x2 = Y1(i,5);
    y2 = Y1(i,6);
    plot (x2,y2,'b-o','MarkerSize',10,'MarkerFaceColor',[0,0,0.5])
    x3 = Y1(i,9);
    y3 = Y1(i,10);
    plot (x3,y3,'g-o','MarkerSize',5,'MarkerFaceColor',[0.5,0.5,0.5])
    axis([l r u o])
    drawnow
    hold off
     if i == 2 
    title ( 'System Sonne-Erde-Mond ohne Maßstab' )
    legend ('Sonne', 'Erde' , 'Mond')
else
     end
        end

    case 3
    figure(1)
    for i=1:1:a  
    hold on
    grid on 
    x1 = Y1(i,1);
    y1 = Y1(i,2);
    plot (x1,y1,'r.')
    x2 = Y1(i,5);
    y2 = Y1(i,6);
    plot (x2,y2,'b.')
    x3 = Y1(i,9);
    y3 = Y1(i,10);
    plot (x3,y3,'g.')
    axis([l r u o])
    drawnow
      if i==2  
    title ( 'gleichseitiges Dreieck gleiche Masse und Geschwindigkeit')
    legend ('Körper 1', 'Körper 2' , 'Körper 3')
      else
      end
    end
      
      otherwise
        end    
          else        
end