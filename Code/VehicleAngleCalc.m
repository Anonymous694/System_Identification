clear;
import com.*

% choose and load messdaten
uigetfile_start_folder = '.';
[messdaten_name, messdaten_folder] = uigetfile('*.mat','Open Messdaten',uigetfile_start_folder);
if messdaten_name == 0
    disp '--- No selected file ---';
    return
end
messdaten = load_messdaten([messdaten_folder, messdaten_name]);

% TIME SET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_from = 847;
t_to = 860;
t_index = find(messdaten.X(1).Data>=t_from & messdaten.X(1).Data<=t_to);
idx_start = t_index(1);
idx_end = t_index(length(t_index));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data from messdaten
mess.imu.ax = get_item_from_messdaten_idx(messdaten, idx_start, idx_end, 'IMU_Bosch_a_x_mps2_UsbFlRec');
mess.imu.ay = get_item_from_messdaten_idx(messdaten, idx_start, idx_end, 'IMU_Bosch_a_y_mps2_UsbFlRec');
mess.imu.az = get_item_from_messdaten_idx(messdaten, idx_start, idx_end, 'IMU_Bosch_a_z_mps2_UsbFlRec');
mess.imu.wz = get_item_from_messdaten_idx(messdaten, idx_start, idx_end, 'IMU_Bosch_w_z_radps_UsbFlRec');
mess.vx = get_item_from_messdaten_idx(messdaten, idx_start, idx_end, 'v_x_mps_UsbFlRec');

g = -9.81; % [m/s^2]


%% Calculate vehicle angle
fx = mess.imu.ax.data;
fy = mess.imu.ay.data;
fz = mess.imu.az.data + g;
ax = fx;
ay = fy;
az = fz; 

axle.roll = atan(smoothdata(ay)./(smoothdata(az)));
axle.pitch = -asin(smoothdata(ax)/g); 
axle.yaw = cumtrapz(mess.imu.wz.time, mess.imu.wz.data);

len = length(az);
slope.rad = zeros(1,len);
vn = zeros(3,len);
nv = zeros(3,len);
for i=1:len
    ang.roll  = axle.roll(i);
    ang.pitch = axle.pitch(i);
    ang.yaw   = axle.yaw(i);
    TransMat = getTransMat(ang.roll, ang.pitch, ang.yaw);
%     vn(:,i) = TransMat\[mess.vx.data(i), 0, 0]';
%     nv(:,i) = TransMat\[0, 0, 1]';
    slope.rad(i) = calcRoadSlope(getTransMat(0,0,0)\TransMat);
end
slope.deg = rad2deg(slope.rad);

%% Plots
figure;
subplot(2,1,1), plot(mess.vx.time, slope.deg, mess.vx.time, mess.vx.data);legend('slope (deg)','vx (m/s)');
subplot(2,1,2), plot(mess.vx.time, axle.roll, mess.vx.time, axle.pitch);legend('axle.roll (rad)','axle.pitch (rad)');
% figure;
% mplot3(cumtrapz(mess.vx.time,vn(1,:)),cumtrapz(mess.vx.time,vn(2,:)),cumtrapz(mess.vx.time,vn(3,:)),vn(1,:),vn(2,:),vn(3,:));grid on;

