classdef surfefile3 < no_surfe
    %  ������ά�������    
    properties
%         meri_X;%�����������
%         sag_Y;%��ʸ��������
%         V;%�߶��������ֵ
    end
    
    methods 
        function obj = surfefile3(address)           %��ʼ������
             obj.adress=address;
            data = importdata(address).*0.1;              %�ӵ�ַ�������ݣ���ʽΪ .dat��ʽ
            x  =-20e-3:0.2e-3:20e-3;                 
            y  =-400e-3:0.25e-3:400e-3;
            [Xd,Yd]=meshgrid(x,y); %���ò�ֵ�����С
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
            obj.V     = reshape(data,size(Xd,1),size(Xd,2));
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,Y,X,'cubic',0);  %ͨ����ֵȡ���̶�λ�õĺ���ֵ        
              end
     end   
end

