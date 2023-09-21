classdef surfefile4 < no_surfe
    %  ������ά�������    
    properties
        meri_X;%�����������
        sag_Y;%��ʸ��������
        V;%�߶��������ֵ
    end
    
    methods 
        function obj = surfefile4(address)           %��ʼ������
             raw_data = importdata(address);%��SRW�е�������
            first_row = raw_data(1,:);%ȡ����һ��
            sag = first_row(2:end);%��һ��ȥ����һ����Ϊ��ʸ����
            first_column = raw_data(:,1);%ȡ����һ��
            meri = first_column(2:end);%ȡ����һ����Ϊ��������
            obj.V =raw_data(2:end,2:end);%��ȡ����һ�к͵�һ����������;���  
            
%             data1 = importdata(address);  
%             data=data1(2:end,2:end);%�ӵ�ַ�������ݣ���ʽΪ .dat��ʽ
%             x  =-0.015:0.0002:0.015;                
%             y  =-0.15:0.0002:(0.15-0.0002);
            [Xd,Yd]=meshgrid(meri',sag); %���ò�ֵ�����С
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
%             obj.V     = data;%�߶�������ͨ������ϵ�����ı�߶����ֵ
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,Y,X,'cubic',0);  %ͨ����ֵȡ���̶�λ�õĺ���ֵ        
              end
     end   
end

