function mplot3(tx,ty,tz,vx,vy,vz)
hold on;
plot3(tx,ty,tz);
for i=1:min([length(tx),length(ty),length(tz)])
    if mod(i-1,1000)==0
%         [x y]=meshgrid(tx(i)-0.2:0.1:tx(i)+0.2,ty(i)-0.2:0.1:ty(i)+0.2);
%         z=(-ax(i)*(x-tx(i))-ay(i)*(y-ty(i)))/az(i)+tz(i);
%         surf(x,y,z); % surfnorm(x,y,z);
        plot3([tx(i) tx(i)+vx(i)],[ty(i) ty(i)+vy(i)],[tz(i) tz(i)+vz(i)]);
%         plot3([tx(i) tx(i)+vx(i)],[ty(i) ty(i)],[tz(i) tz(i)]);
%         plot3([tx(i) tx(i)],[ty(i) ty(i)+vy(i)],[tz(i) tz(i)]);
%         plot3([tx(i) tx(i)],[ty(i) ty(i)],[tz(i) tz(i)+vz(i)]);
        text(tx(i),ty(i),tz(i),num2str((i-1)/1000));
    end
end
hold off;
end