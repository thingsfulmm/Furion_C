classdef Furion_cylinder_ellipse_Mirror<w_oe
    %������ѧԲ����  
    properties
        r; %Բ���������ʰ뾶  
        r1;
        r2;
        flag;
    end
    
    methods
        function obj=Furion_cylinder_ellipse_Mirror( beam_in,ds,di,chi,theta,surface,r1,r2,grating,flag)   
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %��ʼ������  optical_element�Ĳ���      
           obj.r1=r1; %���
            obj.r2 =r2;%���
            obj.flag=flag;
            obj.reflect;%�������   
            
        end
    end   
    
      methods %���ͷ���,׷��
        function tracing(obj)
           obj.g_mirror = g_Furion_cylinder_ellipse_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,obj.surface,obj.r1,obj.r2,obj.grating)   ;
        end
      end
    
      methods   % ���첨������ �����ǻ��䣬�����ӵ���λֱ�Ӽ���ԭ������λ��Ӧ��λ��֮�ϣ�
        function  wbeam_out=creat_w_beam(obj,s_surface)     % ������ѧԪ���������ӵ���λ�������Ǿ�����䣩��
%         if obj.grating.m ==0          
%             wbeam=obj.beam_in;
%             Phase = obj.g_mirror.Phase + s_surface ;
%             phase1 = reshape(Phase,[wbeam.N, wbeam.N]);                             % �����ӵ�ɢ����λת��Ϊ��ά���������λ      ��
%             Field_new = abs(wbeam.field).*exp(1i*(wbeam.phase_field+phase1));       % ͨ�����ӵ���λ�����µĹ�ı����������ֲ�    ��
% %             Field_new( isnan(Field_new))=0;
%             wbeam_out = beam(wbeam.X,wbeam.Y,Field_new,wbeam.wavelength);                 % �����µĹ���                              ��
%         else
            
             X_ =obj.g_mirror.X_;Y_ =obj.g_mirror.Y_;
            Phase =obj.g_mirror.Phase+s_surface;
            beam_in = obj.beam_in;
            phase_0 = Phase' + beam_in.phase_field(:);                        % ��λ����
           
                X=beam_in.XX;
                Y=beam_in.YY;      
                   
                    F = scatteredInterpolant(X_',Y_',phase_0);                    % ��λԭ�����ֵ
                    F.Method = 'linear';
                    F.ExtrapolationMethod='linear';
                    phase_interp = F(X',Y');                            %��׷����������ֵ׷��ǰ����λ
                    F1 = scatteredInterpolant(X_',Y_',abs(beam_in.field(:)));              %��׷����������ֵ׷��ǰ��ǿ��ֵ
                    F1.Method = 'linear';
                    F1.ExtrapolationMethod='linear';
                    field_interp =   F1(X',Y');%delta_h = obj.surface.value(obj.a.Z2,obj.a.X2);
                    
          
            phase10 = reshape(phase_interp,[beam_in.N, beam_in.N]); % һά����ת��Ϊ��ά����
            field10 = reshape(field_interp,[beam_in.N, beam_in.N]); % һά����ת��Ϊ��ά����
            X_new1=reshape(X,[beam_in.N, beam_in.N]);
             Y_new1=reshape(Y,[beam_in.N, beam_in.N]);
             if (obj.flag ==0)
                 Field_new = abs(field10).*exp(1i*(phase10)); 
                  wbeam_out = beam(X_new1,Y_new1,Field_new,beam_in.wavelength);  %�����µĹ��� 
             else
            %
            L=max(max(beam_in.X))-min(min(beam_in.X));
              x = linspace(-L/2,L/2,10001);                                        %���²���x�᷽��
            y = x';                                                             %���²���Y�᷽��
            [X_r,Y_r] = meshgrid(x,y);   
             phase1 = interp2(X_new1,Y_new1,phase10,X_r,Y_r,'cubic',0); 
             field1 = interp2(X_new1,Y_new1,field10,X_r,Y_r,'cubic',0); 
            %
            Field_new = abs(field1).*exp(1i*(phase1)); %    ͨ����ֵ����������λ��ϳ��µĸ����� 
%             X_new=reshape(X,[beam_in.N, beam_in.N]);
%             Y_new=reshape(Y,[beam_in.N, beam_in.N]);
            wbeam_out = beam(X_r,Y_r,Field_new,beam_in.wavelength);  %�����µĹ��� 
             end
        end
        end
%       end
end

