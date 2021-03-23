%Preprocess
%Run the program to preload all the data needed
%% Global variable
clc
clear
close all
dt = 0.001;
t = 0:dt:30;
t1 = 0:dt:60;
x = t';
x1 = t1';

%% Kata1
%Test1
y1 = zeros(1,1/dt);
y2 = 0:90/(4/dt):90;
y3 = 90*ones(1,5/dt-1);
y4 = 90:-180/(10/dt):-90;
y5 = -y3;
y6 = -fliplr(y2);
y7 = y1;
y = [y1,y2,y3,y4,y5,y6,y7]'*pi./180;
t1_1 = x;
y1_1 = y;


%% Test2
close
y1 = zeros(1,1/dt);
y2 = 0:90/(4/dt):90;
y3 = 90*ones(1,5/dt-1);
y4 = 90:-180/(5/dt):-90;
y5 = [-y3,-y3,-90];
y6 = -fliplr(y2);
y7 = y1;
y = [y1,y2,y3,y4,y5,y6,y7]'*pi/180;

t1_2 = x;
y1_2 = y;

%% Kata2
%  Test1 & 2
close
y1 = zeros(1,1/dt);
y2 = 0:0.006:pi/6;      %maximal Lenkrat 6 rad/s  == 0.006 rad / ms
y3 = pi/6*ones(1,15/dt+1);
y4 = pi/6:-0.006:0;
n = length([y1,y2,y3,y4]);
y5 = zeros(1,30000-n+1);
y = [y1,y2,y3,y4,y5]';

t2_1 = x;
y2_1 = y;
t2_2 = x;
y2_2 = -y;

%% Test3 & 4
close
y1 = zeros(1,1/dt);
y2 = 0:0.006:pi/3;      %maximal Lenkrat 6 rad/s  == 0.006 rad / ms
y3 = pi/3*ones(1,15/dt+1);
y4 = pi/3:-0.006:0;
n = length([y1,y2,y3,y4]);
y5 = zeros(1,30000-n+1);
y = [y1,y2,y3,y4,y5]';

t2_3 = x;
y2_3 = y;
t2_4 = x;
y2_4 = -y;

%% Test5 &6
close
y1 = pi/6*ones(1,1/dt);
y2 = pi/6:-0.006:-pi/6;
y3 = -pi/6*ones(1,15/dt+1);
y4 = -pi/6:0.006:pi/6;
n = length([y1,y2,y3,y4]);
y5 = pi/6*ones(1,30000-n+1);
y = [y1,y2,y3,y4,y5]';

t2_5 = x;
y2_5 = y;
t2_6 = x;
y2_6 = 2*y;

%% Test7
y1 = zeros(1,1/dt);
y2 = 0:0.006:pi/6;
y3 = pi/6*ones(1,14/dt+1);
y4 = pi/6:-0.006:-pi/6;
y5 = -pi/6*ones(1,14/dt+1);
y6 = -pi/6:0.006:pi/6;
y7 = y3;
y8 = y4;
y9 = y5;
y10 = -pi/6:0.006:0;
n = length([y1,y2,y3,y4,y5,y6,y7,y8,y9,y10]);
y11 = zeros(1,60000-n+1);
y = [y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11]';

t2_7 = 0:dt:60;
y2_7 = y;

%% Kata3
%  Test1
close
t0 = 0:0.001:9.99;
y0 = zeros(1,5/dt);
y1 = 15-15*cos(2*pi/20*t0);
t1 = 10:0.001:38;
y2 = 30*sin(2*pi*0.125*t1);
y3 = -fliplr(y1);
n = length([y0,y1,y2,y3]);
y4 = zeros(1,60000-n+1);
y = [y0,y1,y2,y3,y4]'*pi/180;

t3_1 = x1;
y3_1 = y;

%%  Test2
close
t0 = 0:0.001:8.99;
y0 = zeros(1,5/dt);
y1 = 15-15*cos(2*pi/18*t0);
t1 = 9:0.001:37;
y2 = 30*sin(2*pi*0.25*t1);
y3 = fliplr(y1);
n = length([y0,y1,y2,y3]);
y4 = zeros(1,60000-n+1);
y = [y0,y1,y2,y3,y4]'*pi/180;

t3_2 = x1;
y3_2 = y;

%%  Test3
close
t0 = 0:0.001:9.99;
y0 = zeros(1,5/dt);
y1 = 30-30*cos(2*pi/20*t0);
t1 = 10:0.001:38;
y2 = 60*sin(2*pi*0.125*t1);
y3 = -fliplr(y1);
n = length([y0,y1,y2,y3]);
y4 = zeros(1,60000-n+1);
y = [y0,y1,y2,y3,y4]'*pi/180;

t3_3 = x1;
y3_3 = y;

%%  Test4
close
t0 = 0:0.001:8.99;
y0 = zeros(1,5/dt);
y1 = 30-30*cos(2*pi/18*t0);
t1 = 9:0.001:37;
y2 = 60*sin(2*pi*0.25*t1);
y3 = fliplr(y1);
n = length([y0,y1,y2,y3 ]);
y4 = zeros(1,60000-n+1);
y = [y0,y1,y2,y3,y4]'*pi/180;

t3_4 = x1;
y3_4 = y;
