classdef Furion_plane_Mirror<w_oe
    %ƽ�淴�侵    
    properties   
 
    end
    
    methods
        function obj= Furion_plane_Mirror( beam_in,ds,di,chi,theta,surface,grating)              
                 obj=obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;%�������������    
                 %��ʼ������Ĳ��������� �����������ѧԪ�������߷���������ǡ���ࡢ���              
                 %------------------------------------------
                 obj.grating = grating;
                 obj.reflect();
        end
    end   
    
    methods %��ѧ׷��
        function tracing(obj)
           obj.g_mirror = g_Furion_plane_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,no_surfe(),obj.grating);
        end
    end
      methods   % ���첨������ �����ǻ��䣬�����ӵ���λֱ�Ӽ���ԭ������λ��Ӧ��λ��֮�ϣ�
        function  wbeam_out=creat_w_beam(obj,s_surface)     % ������ѧԪ���������ӵ���λ�������Ǿ�����䣩��
        if obj.grating.m ==0          
            wbeam=obj.beam_in;
            Phase = obj.g_mirror.Phase + s_surface ;
            phase1 = reshape(Phase,[wbeam.N, wbeam.N]);                             % �����ӵ�ɢ����λת��Ϊ��ά���������λ      ��
            Field_new = abs(wbeam.field).*exp(1i*(wbeam.phase_field+phase1));       % ͨ�����ӵ���λ�����µĹ�ı����������ֲ�    ��
%             Field_new( isnan(Field_new))=0;
            wbeam_out = beam(wbeam.X,wbeam.Y,Field_new,wbeam.wavelength);                 % �����µĹ���                              ��
        else
            Cff = obj.g_mirror.Cff;
             X_ =obj.g_mirror.X_;Y_ =obj.g_mirror.Y_;
            Phase =obj.g_mirror.Phase+s_surface;
            beam_in = obj.beam_in;
            phase_0 = Phase' + beam_in.phase_field(:);                        % ��λ����
            if obj.chi ==0 || obj.chi ==180
                X=beam_in.XX*Cff;
                Y=beam_in.YY*Cff;
            else
                 X=beam_in.XX*Cff;
                 Y=beam_in.YY*Cff;
            end
                    F = scatteredInterpolant(X_',Y_',phase_0);                    % ��λԭ�����ֵ
                    F.Method = 'nearest';
                    F.ExtrapolationMethod='nearest';
                    phase_interp = F(X',Y');                            %��׷����������ֵ׷��ǰ����λ
                    F1 = scatteredInterpolant(X_',Y_',abs(beam_in.field(:)));              %��׷����������ֵ׷��ǰ��ǿ��ֵ
                    F1.Method = 'nearest';
                    F1.ExtrapolationMethod='nearest';
                    field_interp =   F1(X',Y');%delta_h = obj.surface.value(obj.a.Z2,obj.a.X2);
                    
          
            phase1 = reshape(phase_interp,[beam_in.N, beam_in.N]); % һά����ת��Ϊ��ά����
            field1 = reshape(field_interp,[beam_in.N, beam_in.N]); % һά����ת��Ϊ��ά����
            Field_new = abs(field1).*exp(1i*(phase1))./sqrt(obj.g_mirror.Cff);     %    ͨ����ֵ����������λ��ϳ��µĸ����� 
            X_new=reshape(X,[beam_in.N, beam_in.N]);
            Y_new=reshape(Y,[beam_in.N, beam_in.N]);
            wbeam_out = beam(X_new,Y_new,Field_new,beam_in.wavelength);  %�����µĹ���      
        end
        end
    end
end

