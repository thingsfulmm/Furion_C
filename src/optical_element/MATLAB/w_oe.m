classdef w_oe < handle
    %��ѧԪ�������� �����й�ѧԪ�����Ĺ�ͬ����
    properties
        beam_in;  % �����������
        chi;      % ��ѧԪ�������߷���
        ds;       % ��ƽ�� ����ѧԪ�����ľ��루��ࣩ��λ [m]
        di;       % ��ѧԪ������ ��ƽ��ľ��� ����
        theta;    % ����������Ƕ� [mrad]
        beam_out; % ���������
        surface;  % ��ѧԪ�������Ͷ���
        g_mirror; % ׷�����ѧ���ξ���
        gbeam_in;
        grating;
    end    
    
    methods %��ʼ��
        function obj = w_oe( beam_in,ds,di,chi,theta,surface,grating)         
          obj.chi =chi;
          obj.ds= ds;
          obj.di =di;
          obj.theta =theta;
          obj.beam_in =beam_in;  
          obj.surface=surface;  
          obj.grating =grating;
          %*********************����ʼ��
        end         
    end   
    
    methods
        function reflect(obj)
              obj.create_g_beam();%�������ι���              
              obj.tracing();%����׷��
              g = obj.g_mirror;             
              delta_h = obj.surface.value(g.Z2,g.X2);                 % �����ѧԪ������ͬλ�����Ͷ�Ӧ�ĸ߶� ��
              phase_s = -2*2*pi/obj.beam_in.wavelength.*delta_h.*g.cos_Alpha; % sin(\theta)=-1a.M1;ͨ�����͸߶ȼ����������λ�� ��
              %-------------------------�� �� �� ------------------�����������
              obj.beam_out=obj.creat_w_beam(phase_s);             
              % ���������͹�ѧԪ������ɵ���λ���뵽ԭ�����У��γ��µĹ�����
                  %�Ӳ��������������ι���
            % obj.transform_coefficient(g.Cff);
             
        end
    end 
    
    methods % ׷���Ĺ�ѧԪ����
        function tracing(obj)
           
        end
    end
    
    methods  %���ͻ���
        function  transform_coefficient(obj,Cff)
            if obj.chi ==0 || obj.chi == 180
            obj.beam_out.X = obj.beam_out.X;
            obj.beam_out.Y = obj.beam_out.Y ;
            else
                obj.beam_out.X = obj.beam_out.X;
                obj.beam_out.Y = obj.beam_out.Y ;
            end
        end
    end
    
     methods %�Ӳ��������������ι���      
        function create_g_beam(obj)  
         beam= obj.beam_in;
         Phase_field = Furion_phase_unwrap2(beam.field);          % ��λ�����        
         optical_path= Phase_field/(2*pi)*beam.wavelength;        % ��λת��Ϊ��� ��λ[m]
         dx = mean(diff(beam.X(1,:)));                            % X ����ļ��  ��λ[m]
         dy = mean(diff(beam.Y(:,1)));                            % Y����ļ�� ��λ[m]
         [Fx,Fy] = gradient(optical_path,dx,dy);                 % ��X�����Y������ݶ�
         theta_x = -atan(Fx);                                    % ���ݶȼ���Ƕ�
         theta_y = -atan(Fy);                                    % ���ݶȼ���Ƕ�                                
         obj.beam_in.phase_field =Phase_field;                           %��λ���ֲ�
         
         phi = theta_x(:)';                       % x'    x ����Ƕ�                                       
         psi = theta_y(:)';                       % y'    y ����Ƕ�
         XX = beam.X(:)';                          %����X����ת����ɢ������
         YY =beam. Y(:)';                          %����Y����ת����ɢ������ 
         lambda = beam.wavelength;                 % ���������ͼ��β�����ͬ
         obj.gbeam_in = g_beam(XX,YY,phi,psi,lambda);    %�������ι���
         obj.beam_in.XX =XX;
         obj.beam_in.YY =YY;
        end         
     end
    
       methods   % ���첨������ �����ǻ��䣬�����ӵ���λֱ�Ӽ���ԭ������λ��Ӧ��λ��֮�ϣ�
        function  wbeam_out=creat_w_beam(obj,s_phase)     % ������ѧԪ���������ӵ���λ�������Ǿ�����䣩��
       
          
            wbeam=obj.beam_in;
            Phase = obj.g_mirror.Phase + s_phase ;
            phase1 = reshape(Phase,[wbeam.N, wbeam.N]);                             % �����ӵ�ɢ����λת��Ϊ��ά���������λ      ��
            Field_new = abs(wbeam.field).*exp(1i*(wbeam.phase_field+phase1));       % ͨ�����ӵ���λ�����µĹ�ı����������ֲ�    ��
%             Field_new( isnan(Field_new))=0;
            wbeam_out = beam(wbeam.X,wbeam.Y,Field_new,wbeam.wavelength);                 % �����µĹ���                              ��
        end
    end
end

