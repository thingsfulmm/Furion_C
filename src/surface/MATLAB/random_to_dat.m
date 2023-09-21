classdef random_to_dat<handle  
     properties 
         meri;%���緽��
         V;%�����������
         name;%�ļ���
     end
     
     methods
             function  obj = random_to_dat(h_Error_rms,s_Error_rms,n_Upper,name) %����һά�������ݣ���2�У���ʽ��CSV ������Furion �� SRW ��һά���
                   [l_Mirro,f_Error,~] = Furion_figure_error(h_Error_rms,s_Error_rms,n_Upper);              %����ԭʼ���ݣ���ʽ��CSV
                    obj.meri = l_Mirro';
                    obj.V = f_Error';
                    obj.name = name;                    
             end
     end  
     
     methods%%�����.dat��ʽ�����Ը�Furion ��srw ʹ��
         function save_to_furion_and_srw_1d(obj)
             data = [obj.meri,obj.V];
                   [m,n] = size(data);                              %�õ����ݵ�����������
                       fid=fopen([obj.name,'.dat'],'wt');                   %����dat ����
                       for i = 1:m
                          for j= 1:n  
                              if j==n
                                 fprintf(fid,'%g\n',data(i,j));%ÿһ�У�����
                              else
                                 fprintf(fid,'%g\t',data(i,j));%����֮����tab������
                              end
                           end
                        end %�����ң����ϵ��£�һ����д����
                      fclose(fid);%�ر��ļ�              
         end
     end
     
     methods
           function save_to_srw_2d(obj)   %����Ϊsrw���Զ�ȡ��ģʽ
               sag  = (-0.03:0.01:0.03)';   
               data=repmat(obj.V,1,length(sag));
               Furion_save_srw( obj.meri,sag,data,[obj.name,'_srw.dat']);
               
           end
     end
         
      methods
          function save_to_shadow_2d(obj)%����Ϊshadow���Զ�ȡ��ģʽ
              sag  = (-0.03:0.01:0.03)';   
              data=repmat(obj.V,1,length(sag))';
              Furion_save_to_shadow( obj.meri,sag,data,[obj.name,'_shadow.dat'])
           end
     end 
     
  
end
 