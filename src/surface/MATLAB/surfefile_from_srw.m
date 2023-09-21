classdef surfefile_from_srw < no_surfe
    %  import surface from SRW    
    properties
%         meri_X;%�����������
%         sag_Y;%��ʸ��������
%         V;%�߶��������ֵ
    end
    
    methods 
        function obj = surfefile_from_srw(address)           %��ʼ������
            obj.adress=address;
             raw_data = textread(address);%��SRW�е�������
            first_row = raw_data(1,:);%ȡ����һ��
            sag = first_row(2:end);%��һ��ȥ����һ����Ϊ��ʸ����
            first_column = raw_data(:,1);%ȡ����һ��
            meri = first_column(2:end);%ȡ����һ����Ϊ��������
            obj.V =raw_data(2:end,2:end)';%��ȡ����һ�к͵�һ����������;���              
            [Xd,Yd]=meshgrid(meri, sag); %���ò�ֵ�����С
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
%             obj.V     = data;%�߶�������ͨ������ϵ�����ı�߶����ֵ
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,X,Y,'cubic',0); 
                   %ͨ����ֵȡ���̶�λ�õĺ���ֵ        
              end
     end   
end

