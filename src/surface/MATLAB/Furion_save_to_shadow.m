function Furion_save_to_shadow( meri,sag,data,address )
%FURION_SAVE_TO_SHADOW �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

            fid=fopen(address,'wt');
            x = meri';%�������� ������
            y = sag;%��ʧ���� ������
            fprintf(fid,'%g ',length(y));
            fprintf(fid,'%g\n',length(x));% ��ʾ�к������� ��һ�У�

           for i=1:length(x)-1
             fprintf(fid,'%g ',x(i));
           end
           fprintf(fid,'%g\n',x(end));  % ��ʾ�������ꣻ ���� 
           
           data2 = [y data]; % ����ʸ����󶨵����������ϣ�
             [m,n] = size(data2);
                for i = 1:m
                    for j = 1:n  
                      if j == n
                        fprintf(fid,'%g\n',data2(i,j));
                      else
                        fprintf(fid,'%g  ',data2(i,j));
                      end
                    end
                end
           fclose(fid);
        end



