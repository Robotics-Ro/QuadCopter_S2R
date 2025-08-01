%% 0) If you need Setup Domain ID
setenv('ROS_DOMAIN_ID','42');      % turtlesim이 0이면 생략 가능

ipaddress = '192.168.50.175';
device = ros2device(ipaddress,'ren','12341234');
device.ROS2Folder = '/opt/ros/humble';
device.ROS2Workspace = '~/Dev/ros2_ws_test';

%% 1) Node & Publisher
node = ros2node("/matlab_turtle");
pub  = ros2publisher(node, "/turtle1/cmd_vel", "geometry_msgs/Twist");

%% 2) Message Templete
msg = ros2message(pub);

%% 3) 10 Hz, Running way Circuit Trajectory on 20 Second (v=1 m/s, ω=1 rad/s)
rate = rosrate(10);
for k = 1:200
    msg.linear.x  = 1.0;   % [m/s]
    msg.angular.z = 1.0;   % [rad/s]
    send(pub, msg);        % <-- turtlesim이 바로 받아서 움직임
    waitfor(rate);
end

%% 4) 정지
msg.linear.x  = 0;
msg.angular.z = 0;
send(pub,msg);

clear pub node
