function phase_unwrap = Furion_phase_unwrap2(in_Field)
%% ************************************************************************** %%
% This function is used to unwrap the phase of 2-D complex field. 
% ���ܣ�ʵ�ֶ�ά�������λУ�����ɲο�matlab��unwrap������˵��
% ������P��matrix of the radian phase angles ;
%       tol: jump tolerance instead of the default value(pi)
% ����ֵ��У�������λ����
% ��Ҫ˼·����ʹ��һάУ������unwrapУ���м��һ�У�Ĭ����Ϊ�м��һ���ǱȽϱ�׼�ģ���
%           Ȼ��ʹ��unwrap����У���õ�һ��У������Ȼ��ʹ���������У���˾���õ������
% ���÷�����ͬunwrap�������÷����������ṩdim������
% ���ڣ�2011/7/21
% author: GJ
% http://blog.sina.com.cn/s/blog_6163bdeb0102drb2.html
%% ************************************************************************** %%
phase_field = angle(in_Field);

[M, N] = size(phase_field);
mid = round(M/2);
unwrapmid = unwrap(phase_field(mid, :));  % У���м�һ��
unwrapP = unwrap(phase_field);            % ����У��ȫ����
unwrapPmid = unwrapP(mid, :);
miderr = unwrapPmid - unwrapmid;
miderrM = repmat(miderr, M, 1);
phase_unwrap = unwrapP - miderrM;
end