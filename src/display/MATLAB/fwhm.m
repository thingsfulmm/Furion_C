function f= fwhm( x,y )
% input 
% x ���ߵĺ�����
% y ���ߵ�������
epsilon=abs(max(diff(y)));
p=max(y);
mid = p/2;
f0=x(abs(y-mid)<epsilon);
f=max(f0)-min(f0);
end

