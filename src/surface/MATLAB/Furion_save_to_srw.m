function  Furion_save_to_srw( meri,sag,data,address)
%���������ݱ���ΪSRW��ʽ����srw������Ե�������
               x=sag;   %xΪ������
               y=meri;   % yΪ������
                fid=fopen(address,'wt');%��һ���ļ�
                fprintf(fid,'%g\t',0);
                for i=1:length(x)-1
                    fprintf(fid,'%g\t ',x(i));
                end
                fprintf(fid,'%g\n',x(end));  % ��ʾ�������ꣻ

                data2 = [y data]; % ����ʸ����󶨵����������ϣ�
                [m,n] = size(data2);
                for i = 1:m
                    for j = 1:n  
                      if j == n
                        fprintf(fid,'%g\n',data2(i,j));
                      else
                        fprintf(fid,'%g\t',data2(i,j));
                      end
                    end
                end
                fclose(fid);
end

