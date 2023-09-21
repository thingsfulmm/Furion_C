classdef surfefile_from_shadow < no_surfe
    % ����shadow���������
    properties
%         meri_X;
%         %�����������
%         sag_Y;
%         %��ʸ��������
%         V;
%         %�߶��������ֵ
    end    
    methods 
        function obj = surfefile_from_shadow(address)  
            %��������
            obj.adress=address;
            data=textread(address);                       
            %�ӵ�ַ�������ݣ���ʽΪ .dat��ʽ  
            data1=data(2:end,:); 
            %ȥ����һ�����ݵõ��µ�����
            x0=data1(1,:);          %�õ���������
            x=x0(1:end-1);%ȥ�����һ����
            data2=data1(2:end,:);  %��ȥ��һ������
            y=data2(:,1)';         %�õ���ʧ����  
            data3=data2(:,2:end)';%ȥ����һ��
            [Xd,Yd]=meshgrid(x,y); %���ò�ֵ�����С
            obj.meri_X=Xd;         %���緽��
            obj.sag_Y=Yd;          %��ʧ����
            obj.V= data3';
            %����reshape
        end
    end
    
      methods
         function Vq=value(obj,X,Y)           
             Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,X,Y,'linear',0);  
             %ͨ����ֵȡ���̶�λ�õĺ���ֵ        
        end
     end   
end

