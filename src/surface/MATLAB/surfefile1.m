classdef surfefile1 < no_surfe
    %   һά   
    properties
        meri_X;         %���緽������
        sag_Y;          %��ʸ��������
        V;              %���͸߶�ֵ
    end
    
    methods 
        function obj = surfefile1(address)
            data = importdata(address);        %���������ļ� .dat��ʽ ���� һά���ݣ������������ 2���������            
            obj.meri_X=data(:,1);              %�����һ��Ϊ��������
            obj.V     = data(:,2);             %����ڶ��������͸߶����ֵ
        end
    end
    
    methods
              function Vq=value(obj,meri_X,~)     %�����Ͷ����в�ֵ��ȡ��Ӧ�����ֵ������һά������ֻ��Ҫ�ṩ���緽�������λ��ֵ      
                   Vq = interp1(obj.meri_X,obj.V,meri_X,'PCHIP',0); %���ắ������ȡ��Ӧλ�õ�ֵ    
              end
     end   
end

