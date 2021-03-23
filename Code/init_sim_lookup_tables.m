simin_name_pairs = {
    % NameInCarMaker, NameInMessdaten;
    'Vhcl.FL.Trq_Drive', 'Motor_Drive_FL_Torque_Actual_Nm_UsbFlRec';
    'Vhcl.FR.Trq_Drive', 'Motor_Drive_FR_Torque_Actual_Nm_UsbFlRec';
    'DM.Gas', 'M_x_target_Nm_UsbFlRec'; % RC_channel_2_throttle_0_1_UsbFlRec
%     'DM.Steer.Ang', 'delta_steering_target_rad_UsbFlRec';
    'DM.Steer.Ang','steering_angle_sensor_delta_steering_angle_rad_UsbFlRec';
    'DM.Steer.Trq', 'M_torque_sens_Nm_UsbFlRec';
%     'DM.Steer.Trq','steering_motor_2_Torque_Actual_Nm_UsbFlRec';
    'Driver.ReCon.Speed', 'v_x_mps_UsbFlRec';
    'PT.Control.Motor.Trq_trg', 'M_drive_FL_after_sat_Nm_UsbFlRec';
    'PT.Control.Motor1.Trq_trg', 'M_drive_FR_after_sat_Nm_UsbFlRec';
    'PT.Control.Motor.rotv_trg', 'Motor_Drive_FL_w_actual_radps_UsbFlRec';
    'PT.Control.Motor1.rotv_trg', 'Motor_Drive_FR_w_actual_radps_UsbFlRec';
    'PT.Motor.Trq', 'Motor_Drive_FL_Torque_Actual_Nm_UsbFlRec';
    'PT.Motor1.Trq', 'Motor_Drive_FR_Torque_Actual_Nm_UsbFlRec';
    'PT.Motor.rotv', 'Motor_Drive_FL_w_actual_radps_UsbFlRec';
    'PT.Motor1.rotv', 'Motor_Drive_FR_w_actual_radps_UsbFlRec';
    'Ul','Motor_Drive_FL_U_Bat_V_UsbFlRec';
    'Il','Motor_Drive_FL_I_Bat_A_UsbFlRec';
    'Ur','Motor_Drive_FR_U_Bat_V_UsbFlRec';
    'Ir','Motor_Drive_FR_I_Bat_A_UsbFlRec';
    'Steer.MA1ActTrq','CA_M_LA1_Nm_UsbFlRec';
    'Steer.MA2ActTrq','CA_M_LA2_Nm_UsbFlRec';
    'Steer.MA1ColTrq','steering_motor_1_Torque_Actual_Nm_UsbFlRec';
    'Steer.MA2ColTrq','steering_motor_2_Torque_Actual_Nm_UsbFlRec';
    % steering_motor_2_Torque_Actual_Nm_UsbFlRec / CA_M_LA2_Nm_UsbFlRec
%     'DM.Steer.Trq','data2actuators_M_LA1_target_Nm_UsbFlRec';
%     'Steer.MA2ActTrq','data2actuators_M_LA2_target_Nm_UsbFlRec';
    'Steer.Rack.LFrc', 'force_sensors_F_tie_rod_left_N_UsbFlRec';
    'Steer.Rack.RFrc', 'force_sensors_F_tie_rod_right_N_UsbFlRec';
    'Steer.MAColTrq','M_torque_sens_Nm_UsbFlRec';
    'Car.vx', 'v_x_mps_UsbFlRec'; 
    % ...
    };

simout_name_pairs = {
    % NameInCarMaker, NameInMessdaten;
    'Car.vx', 'v_x_mps_UsbFlRec'; 
    'Car.RollVel', 'IMU_Bosch_w_x_radps_UsbFlRec'; %%%
    'Car.YawVel', 'IMU_Bosch_w_z_radps_UsbFlRec';
    'Car.ax', 'IMU_Bosch_a_x_mps2_UsbFlRec'; %%%
    'Car.ay', 'IMU_Bosch_a_y_mps2_UsbFlRec';
    'Car.az', 'IMU_Bosch_a_z_mps2_UsbFlRec'; %%%
    'PT.Motor.Trq', 'M_drive_FL_after_sat_Nm_UsbFlRec';
    'PT.Motor1.Trq', 'M_drive_FR_after_sat_Nm_UsbFlRec';
    % Motor_Drive_FR_Torque_Actual_Nm_UsbFlRec 
    % --> eff=0.98 will be calculated in CarMaker
    'Steer.WhlAng', 'steering_angle_sensor_delta_steering_angle_rad_UsbFlRec';
%     'Steer.WhlTrq', 'M_torque_sens_Nm_UsbFlRec';
%     'Steer.WhlAng', 'delta_steering_target_rad_UsbFlRec';
    'Steer.WhlTrq','steering_motor_2_Torque_Actual_Nm_UsbFlRec';
    'PT.Motor.rotv', 'Motor_Drive_FL_w_actual_radps_UsbFlRec';
    'PT.Motor1.rotv', 'Motor_Drive_FR_w_actual_radps_UsbFlRec';
    'PT.WFL.rotv', 'Motor_Drive_FL_w_actual_radps_UsbFlRec'; %%% Ratio 16
    'PT.WFR.rotv', 'Motor_Drive_FR_w_actual_radps_UsbFlRec'; %%% Ratio 16
    'Steer.MA2ActTrq', 'CA_M_LA2_Nm_UsbFlRec';
    'Steer.MA2TrqIst', 'steering_motor_2_Torque_Actual_Nm_UsbFlRec';
    'Steer.MA1ColTrq','steering_motor_1_Torque_Actual_Nm_UsbFlRec';
    'Steer.MA2ColTrq','steering_motor_2_Torque_Actual_Nm_UsbFlRec';
    'Steer.Rack.LFrc', 'force_sensors_F_tie_rod_left_N_UsbFlRec';
    'Steer.Rack.RFrc', 'force_sensors_F_tie_rod_right_N_UsbFlRec';
    'Steer.MAColTrq_trg','M_torque_sens_Nm_UsbFlRec';
    };

simin_list = {
    % NameInCarMaker;
    'PT.Control.Motor.Trq_trg'; 
    'PT.Control.Motor1.Trq_trg';
% %     'PT.Control.Motor.rotv_trg';
% %     'PT.Control.Motor1.rotv_trg';
%     'PT.Motor.Trq';
%     'PT.Motor1.Trq';
%     'PT.Motor.rotv';
%     'PT.Motor1.rotv';
%     'Driver.ReCon.Speed';
%     'Driver.ReCon.Speed';
%     'DM.Gas';
%     'DM.Gas';
%     'Vhcl.FL.Trq_Drive';
%     'Vhcl.FR.Trq_Drive';
% %     'Ul';
% %     'Il';
% %     'Ur';
% %     'Ir';
    'DM.Steer.Ang';
%     'Steer.MAColTrq_trg';
%     'DM.Steer.Trq';
%     'Steer.MA1ActTrq'
%     'Steer.MA2ActTrq'
%     'Steer.MA1ColTrq'
%     'Steer.MA2ColTrq'
%     'Steer.Rack.LFrc';
%     'Steer.Rack.RFrc';
    };

simout_list = {
    % NameInCarMaker;
    'Car.vx'; 
    'Car.RollVel';
    'Car.YawVel';
    'Car.ax';
    'Car.ay';
    'Car.az';
    'PT.Motor.Trq';
    'PT.Motor1.Trq';
    'Steer.WhlAng';
    'PT.Motor.rotv';
    'PT.Motor1.rotv';
%     'PT.WFL.rotv';
%     'PT.WFR.rotv';
%     'Steer.MA2ActTrq';
%     'Steer.MA2TrqIst';
%     'Steer.MA1ColTrq'
%     'Steer.MA2ColTrq'
%     'Steer.Rack.LFrc';
%     'Steer.Rack.RFrc';
%     'Steer.MAColTrq_trg';
%     'Steer.WhlTrq';
    };