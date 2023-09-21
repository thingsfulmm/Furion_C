function Furion_plot_Resolution(X,Y,Phi,Psi ,n)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    [X0,Y0,~,~] = Furion_angle_To_angle( X,Y,Phi,Psi);
    
    X1 = X0*1e6;%ƥ�䵥λ ��ʾ��λΪ[um]
    Y1 = Y0*1e6;%ƥ�䵥λ ��ʾ��λΪ[um]
    x_Std = std(X1); %X�����׼��
    y_Std = std(Y1); %Y�����׼��
    
    x_Mean = mean(X1); %X��ƽ��ֵ
    y_Mean = mean(Y1); %Y��ƽ��ֵ
    x_Scale = [x_Mean-4*x_Std x_Mean+4*x_Std]; %X�ķ�Χ
    y_Scale = [y_Mean-4*y_Std y_Mean+4*y_Std]; %Y�ķ�Χ
    
    ks =0.618*0.8;
    xs =0.1;
    ys =0.1;       %����ͼƬ��С
    text_start =ys+ks+ks*0.515+0.01;
    text_step =0.051;
  %-----------------------------------------------------------------------------------------------  
    figure1 = figure;
    
    set(gcf,'Units','centimeters','Position',[2 3 20 20]); 
    axes1 = axes('Parent',figure1,...
    'Position',[xs ys ks ks],  'Tag','PlotMatrixScatterAx');
    
    
     
      plot(X1(1:n)',Y1(1:n)','Parent',axes1,'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0.91 0.71 0.78]); 
     hold on;
   plot(X1(n+1:2*n)',Y1(n+1:2*n)','Parent',axes1,'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0.19 0.64 0.33]); 
    hold on%���ڶ�������ɢ�㵽ͼƬ��
    plot(X1(2*n+1:3*n)',Y1(2*n+1:3*n)','Parent',axes1,'MarkerSize',3,'Marker','.','LineStyle','none',...
    'Color',[0.19 0.2 0.5]); 
     hold on;%����һ������ɢ�㵽ͼƬ��

    xlabel('X($\mu$m)','interpreter','latex');
    ylabel('Y($\mu$m)','interpreter','latex');
    xlim(x_Scale);
    ylim(y_Scale);
    box(axes1,'on');
    view(2);  
    set(gca,'FontSize',14); 
    hold on ;
    
      axes2 = axes('Parent',figure1,...
    'Position',[xs ys+ks+0.01 ks ks*0.618],  'Tag','PlotMatrixScatterAx');
    h2 = histogram(X1',150);
    xlim(x_Scale);  
    h2.EdgeColor = 'none';
    h2.FaceColor = [0.8 0.8 0.8];
%    h2.BinWidth = 1.67;
    ylabel('Intensity');%X����ͶӰ������
    
%   X historam
 set(gca,'FontSize',14,'Xtick',[]); 
    axes3 = axes('Parent',figure1,...
   'Position',[xs+ks+0.01 ys ks*0.6187 ks],  'Tag','PlotMatrixScatterAx');
    ht = histogram(Y1',150,'Orientation','horizontal');
    width=ht.BinWidth;              %
    ht.EdgeColor = 'none';
    ht.FaceColor = [0.8 0.8 0.8];
    x_profile=ht.Values;
    y_profile= ht.BinEdges(1:end-1);
    alpha(0.5);
    hold on;    
    plot(x_profile',y_profile','LineStyle','-','color','r','LineWidth',1)
    hold on
    set(gca,'FontSize',14,'Ytick',[]); %X����ͶӰ
    
   
    
 
% %****************************************************************************
%��ʾ�����ı�����ͼƬ��
    
    text_X_FWHM = strcat('FWHM-X:',32,32,num2str(x_Std*2.3548),'\mum');
    text_Y_FWHM = strcat('FWHM-Y:',32,32,num2str(y_Std*2.3548),'\mum');
    text_X_std = strcat('Std-X:',32,32,32,32,32,32,32,32,num2str(x_Std),'\mum');
    text_Y_std = strcat('Std-Y:',32,32,32,32,32,32,32,32,num2str(y_Std),'\mum');
    text_X_mean = strcat('Mean-X:',32,32,32,32,num2str(x_Mean),'\mum');
    text_Y_mean = strcat('Mean-Y:',32,32,32,32,num2str(y_Mean),'\mum');
   
    
    annotation('textbox',[xs+ks+0.01 text_start               ks*0.618 .05],'String',text_X_FWHM,'FontSize',14);
    annotation('textbox',[xs+ks+0.01 text_start-text_step     ks*0.618 .05],'String',text_Y_FWHM,'FontSize',14);
    annotation('textbox',[xs+ks+0.01 text_start-2*text_step   ks*0.618 .05],'String',text_X_std,'FontSize',14);
    annotation('textbox',[xs+ks+0.01 text_start-3*text_step   ks*0.618 .05],'String',text_Y_std,'FontSize',14);
    annotation('textbox',[xs+ks+0.01 text_start-4*text_step   ks*0.618 .05],'String',text_X_mean,'FontSize',14);
    annotation('textbox',[xs+ks+0.01 text_start-5*text_step   ks*0.618 .05],'String',text_Y_mean,'FontSize',14);
    %*******************************************************************
    
     h=histogram(Y1(1:n)',150,'Orientation','horizontal');
    h.FaceColor = [0.91 0.71 0.78];
    h.EdgeColor = 'none';
     h.BinWidth = width;
    ylim(y_Scale);
    xlabel('Intensity');
    hold on              %��һ������ʾ��hist��
    
    
    h_add=histogram(Y1(n+1:2*n)',150,'Orientation','horizontal');
    h_add.FaceColor = [0.19 0.64 0.33];
    h_add.EdgeColor = 'none'; 
     h_add.BinWidth = width;
    hold on            %�ڶ�������ʾ��hist��
       
            h3=histogram(Y1(2*n+1:3*n)',150,'Orientation','horizontal');
    h3.FaceColor = [0.19 0.2 0.5];
    h3.EdgeColor = 'none';  
      h3.BinWidth = width;
    hold on %����������ʾ��hist��

   
    
    line_y =max(ht.Values)*0.5;%����߿��ϵ�����
    line([line_y,line_y],[-100,100],'linestyle','--','color','w','LineWidth',3);   
    
   end

