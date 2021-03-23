clc,clear;
close all;

init_sim_lookup_tables;
SteeringParameter;

simin_list = {
    %'PT.Control.Motor.Trq_trg'; 
    %'PT.Control.Motor1.Trq_trg';
    'Steer.MAColTrq';
    'Steer.Rack.LFrc';
    'Steer.Rack.RFrc';
    'DM.Steer.Ang';
    };

% {'elfpp.ppc_2019_10_28_15_35_27.mat',   270,    300}; % 2.4727,8.9019;
% {'elfpp.ppc_2019_10_28_15_48_33.mat',   64,     74};  % 1.545, 5.562;
% {'elfpp.ppc_2019_10_28_15_48_33.mat',   107,    127}; % 1.8543,6.6757;
% {'elfpp.ppc_2019_10_28_15_55_05.mat',   360,    372}; % 1.676, 6.0336;
% {'elfpp.ppc_2019_10_25_11_09_42.mat',   288,    304}; % 1.4648,5.2734;
% {'elfpp.ppc_2019_10_25_11_09_42.mat',   347,    355}; % 0.002351,0.008464;
% {'elfpp.ppc_2019_10_28_15_37_02.mat',   479,    494}; % 1.4107,5.0787;
% {'elfpp.ppc_2019_10_28_15_37_02.mat',   454,    474}; % 2.4876,8.9555;
% {'elfpp.ppc_2019_10_25_11_03_09.mat',   115,    140}; % 0,0;

% Neue Messdaten, Geschwindigkeit=0, 
% Im Ordner „la2_in_la1_out? ist nur der obere (Lenkaktor 2) eingekoppelt und in Betrieb,
% N:\09_Abschlussarbeit\ji,Keyu\MA_Ji\lenkvalidierung\messungen\la2_in_la1_out
% mit ** markierter Daten zur Parameter Estimation, andere zur Validierung
% der Parameter

% {'20210210_Lenkvalid_Kata1_Test01_01.mat',   80,    120}; % 0,0; **
% {'20210210_Lenkvalid_Kata1_Test01_03.mat',   30,    70}; % 0,0;

% {'20210210_Lenkvalid_Kata1_Test02_02.mat',   20,    60}; % 0,0; 

% {'20210210_Lenkvalid_Kata3_Test01_01.mat',   80,    150}; % 0,0; **
% {'20210210_Lenkvalid_Kata3_Test01_02.mat',   30,    90}; % 0,0;

% {'20210210_Lenkvalid_Kata3_Test02_02.mat',   35,    90}; % 0,0;

% {'20210210_Lenkvalid_Kata3_Test03_01.mat',   30,    90}; % 0,0;
% {'20210210_Lenkvalid_Kata3_Test03_02.mat',   30,    90}; % 0,0;
% {'20210210_Lenkvalid_Kata3_Test03_03.mat',   50,    120}; % 0,0;
% {'20210210_Lenkvalid_Kata3_Test03_04.mat',   30,    90}; % 0,0;

% {'20210211_Lenkvalid_Kata2_Test01_01.mat',   60,    80}; % 0,0; **
% {'20210211_Lenkvalid_Kata2_Test01_02.mat',   30,    70}; % 0,0;
% {'20210211_Lenkvalid_Kata2_Test01_03.mat',   30,    50}; % 0,0;

% {'20210211_Lenkvalid_Kata2_Test02_01.mat',   50,    90}; % 0,0;
% {'20210211_Lenkvalid_Kata2_Test02_02.mat',   40,    70}; % 0,0;
% {'20210211_Lenkvalid_Kata2_Test02_03.mat',   40,    70}; % 0,0;

% {'20210211_Lenkvalid_Kata2_Test03_01.mat',   50,    80}; % 0,0;
% {'20210211_Lenkvalid_Kata2_Test03_02.mat',   200,   230}; % 0,0;

% {'20210211_Lenkvalid_Kata3_Test04_01.mat',   60,   120}; % 0,0;
% {'20210211_Lenkvalid_Kata3_Test04_02.mat',   550,  600}; % 0,0;
% {'20210211_Lenkvalid_Kata3_Test04_03.mat',   25,   75}; % 0,0;



% Neue Messdaten, Geschwindigkeit=0, 
% Im Ordner „la2_in_la1_in? ist nur der obere (Lenkaktor 2) eingekoppelt und in Betrieb,
% N:\09_Abschlussarbeit\ji,Keyu\MA_Ji\lenkvalidierung\messungen\la2_in_la1_in

% {'20210211_Lenkvalid_Kata1_Test01_01.mat',   140,   190}; % 0,0; **
% {'20210211_Lenkvalid_Kata1_Test01_02.mat',   20,   60}; % 0,0;
% {'20210211_Lenkvalid_Kata1_Test01_03.mat',   20,   60}; % 0,0;

% {'20210211_Lenkvalid_Kata1_Test02_01.mat',   135,   175}; % 0,0;
% {'20210211_Lenkvalid_Kata1_Test02_02.mat',   15,   55}; % 0,0;
% {'20210211_Lenkvalid_Kata1_Test02_03.mat',   15,   55}; % 0,0;

% {'20210211_Lenkvalid_Kata3_Test01_02.mat',   190,   250}; % 0,0; **
% {'20210211_Lenkvalid_Kata3_Test01_03.mat',   40,   100}; % 0,0;
% {'20210211_Lenkvalid_Kata3_Test01_04.mat',   20,   80}; % 0,0;

% {'20210211_Lenkvalid_Kata3_Test02_03.mat',   25,   85}; % 0,0;
% {'20210211_Lenkvalid_Kata3_Test02_04.mat',   25,   80}; % 0,0;

% {'20210211_Lenkvalid_Kata3_Test03_03.mat',   30,   90}; % 0,0;

% {'20210211_Lenkvalid_Kata3_Test04_02.mat',   25,   80}; % 0,0;
% {'20210211_Lenkvalid_Kata3_Test04_03.mat',   25,   80}; % 0,0;



cm.messdaten_path = 'C:\Users\lenovo\Desktop\MA_Ji\lenkvalidierung\messungen\la2_in_la1_out';
%cm.messdaten_path = 'N:\01_SmartLoad\03_Messdaten_Analyse\Messdaten\13_Messungen\Messdaten\20191028';   
%cm.messdaten_name = 'elfpp.ppc_2019_10_28_15_37_02.mat'
cm.messdaten_name = '20210210_Lenkvalid_Kata3_Test01_01.mat';

[messdaten, messdaten_name] = load_messdaten([cm.messdaten_path, '\', cm.messdaten_name]);

t_from = 80;
t_to = 150;
t_index = find(messdaten.X(133).Data>=t_from & messdaten.X(133).Data<=t_to);%index 133 is steering angle sensor
idx_start = t_index(1);
idx_end = t_index(length(t_index));

ts_for_model = get_timeseries4simin(simin_name_pairs, simin_list, messdaten, idx_start, idx_end);
simin = timeseries(ts_for_model.Data(:,1:3), ts_for_model.Time);


% für die Offset der Totalkraft
force_offset= timeseries((simin.Data(:,2)-simin.Data(:,3)),simin.Time);
force = timeseries(force_offset.Data-force_offset.Data(1,:),simin.Time);
simin.Data(:,4)=force.Data;
% simin.Data(:,1) = simin.Data(:,1)-simin.Data(1,1);
m_out = timeseries(ts_for_model.Data(:,4), ts_for_model.Time);
Est_Offset = 0;
Est_Offset_m = 0;
%% Validate Forceoffset
subplot(3,1,1)
plot(simin.Time,simin.Data(:,1)+ Est_Offset_m)
subplot(3,1,2)
plot(simin.Time,ts_for_model.Data(:,4))

subplot(3,1,3)
plot(simin.Time,simin.Data(:,2)-simin.Data(:,3)+ Est_Offset)
%%
figure('Name','Lenkungsvalidierung','NumberTitle','off')
subplot(4,1,1)
plot(simin.Time,simin.Data(:,1) )
hold on
plot(Steer_WheelTrq,'--')
xlabel('Time(s)')
ylabel('Lenkungsmoment(Nm)')
legend('Messdaten','Simdaten')
title('Lenkungsvalidierung')

subplot(4,1,2)
plot(m_out)
hold on
plot(Steer_WhlAng,'--')
ylim([-6 6])
xlabel('Time(s)')
ylabel('Lenkungswinkel(rad)')
legend('Messdaten','Simdaten')

subplot(4,1,3)
plot(simin.Time,simin.Data(:,4))
xlabel('Time(s)')
ylabel('Totalkraft ohne offset(N)')
legend('Messdaten')

subplot(4,1,4)
plot(force_offset)
xlabel('Time(s)')
ylabel('Totalkraft mit offset(N)')
legend('Messdaten')
title('')

