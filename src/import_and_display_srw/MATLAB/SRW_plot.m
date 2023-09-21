shift_Y =31.714;                                        %�ֿ������ľ���
addpath(genpath('..\display'));
b1=import_beam('1nm_M1_M5_rough_intensity.dat');        %�����һ��������ǿ��ֵ
b1.import_phase('1nm_M1_M5_rough_phase.dat');           %�����һ����������λֵ
b1.coordinate_transform(650,-650,60,-60);               %�������ݣ��ó���Ӧλ�õĹⳡ
b1.coordinate_diffraction(0,0);                         % �Թ��������������         

b2 = import_beam('1nm-_M1_M5_rough_intensity.dat');     %����ڶ��������Ĺ���
b2.import_phase('1nm-_M1_M5_rough_phase.dat');
b2.coordinate_transform(650,-650,60,-60);
b2.coordinate_diffraction(0,-shift_Y);

b3=import_beam('1nm+_M1_M5_rough_intensity.dat');       %��������������Ĺ���
b3.import_phase('1nm+_M1_M5_rough_phase.dat');
b3.coordinate_transform(650,-650,60,-60);
b3.coordinate_diffraction(0,shift_Y);

b4=import_beam('1nm+_M1_M5_rough_intensity.dat');       %����������ʾ��ͬһ��ͼ�ϣ��Ӷ����Բ鿴�ֱ���
b4.X = b1.X;
b4.Y = b1.Y;
b4.field = b1.field + b2.field +b3.field;
b4.intensity_plot();