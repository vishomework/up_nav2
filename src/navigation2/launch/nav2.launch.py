import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    #=============================1.定位到包的地址=============================================================
    my_navigation2_dir = get_package_share_directory('navigation2')
    nav2_bringup_dir = get_package_share_directory('nav2_bringup')
    # mid360_launch_dir = get_package_share_directory('livox_ros_driver2')
    # ms200_launch_dir = get_package_share_directory('oradar_lidar')
    # rs_launch_dir = get_package_share_directory('rslidar_sdk')
    
    #=============================2.声明参数，获取配置文件路径===================================================
    # use_sim_time 这里要设置成true,因为gazebo是仿真环境，其时间是通过/clock话题获取，而不是系统时间
    use_sim_time = LaunchConfiguration('use_sim_time', default='false') 
    map_yaml_path = LaunchConfiguration('map',default=os.path.join(my_navigation2_dir,'maps','map.yaml'))
    nav2_param_path = LaunchConfiguration('params_file',default=os.path.join(my_navigation2_dir,'param','nav2.yaml'))
    rviz_config_dir = os.path.join(nav2_bringup_dir,'rviz','nav2_default_view.rviz')

    #=============================3.声明启动launch文件，传入：地图路径、是否使用仿真时间以及nav2参数文件==============
    nav2_bringup_launch = IncludeLaunchDescription(
            PythonLaunchDescriptionSource([my_navigation2_dir,'/launch','/bringup_launch.py']),
            launch_arguments={
                'map': map_yaml_path,
                'use_sim_time': use_sim_time,
                'params_file': nav2_param_path}.items(),)

    # mid360_launch = IncludeLaunchDescription(
    #             PythonLaunchDescriptionSource([mid360_launch_dir,'/launch_ROS2','/rviz_MID360_launch.py']),
    #             launch_arguments={'use_sim_time': use_sim_time}.items(),)
    
    # rs_launch = IncludeLaunchDescription(
    #             PythonLaunchDescriptionSource([rs_launch_dir,'/launch','/humble_start.py']),
    #             launch_arguments={'use_sim_time': use_sim_time}.items(),)    


    # ms200_launch = IncludeLaunchDescription(
    #             PythonLaunchDescriptionSource([ms200_launch_dir,'/launch','/ms200_scan.launch.py']),
    #             launch_arguments={'use_sim_time': use_sim_time}.items(),)
    
    tf_launch = IncludeLaunchDescription(
                PythonLaunchDescriptionSource([my_navigation2_dir,'/launch','/tf.launch.py']),
                launch_arguments={'use_sim_time': use_sim_time}.items(),)

    # rviz_node =  Node(
    #         package='rviz2',
    #         executable='rviz2',
    #         name='rviz2',
    #         arguments=['-d', rviz_config_dir],
    #         parameters=[{'use_sim_time': use_sim_time}],
    #         output='screen')
    
    
    return LaunchDescription([
        nav2_bringup_launch,
        # rviz_node,
        # mid360_launch,
        # ms200_launch,
        # rs_launch,
        tf_launch,
        ])
