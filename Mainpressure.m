%Created on October 2020.

%@author: Mahshad Lotfinia <mahshad.lotfinia@alum.sharif.edu>
%https://github.com/mahshadlotfinia/
%%


clear all
clc
close all



%% 01 - From 5.77 to 0 Backward (and Forward: Uncomment the upper q formula and comment the lower one)

h1=input('Enter First Thickness: ');
h2_577=input('Enter Last Thickness: ');%h2
R_577=input('Enter Radios Of Roller: ');
phi=acosd(1-((h1-h2_577)/(2*R_577)));
p_577=input('Enter friction coefficient: ') ;
strainrate=input('Enter Strain Rate: ');
fi_577=phi:-0.01:0; %fi
h_577(1)=h2_577+(2*R_577*(1-cos(pi()*(fi_577(1)/180)))); %h0
sigma_577(1)=input('Enter Yield Point Stress: ');%sigma0
k_577(1)=sigma_577(1)/(3^.5); %k0
q_577(1)=2*(sigma_577(1)/(3^.5)); %q0


%% ANN
xneural=xlsread('xneural.xlsx');
yneural=xlsread('yneural.xlsx');
x = xneural';
t = yneural';
trainFcn = 'trainlm'; 
hiddenLayerSize = 6;
net = fitnet(hiddenLayerSize,trainFcn);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,x,t);
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);
view(net);
%%


for i=2:numel(fi_577)
    h_577(i)=h2_577+(2*R_577*(1-cos(pi()*(fi_577(i)/180))));
    ept_577(i)=log(h_577(i)/h_577(1));
    epw_577(i)=-ept_577(i);
    epbar_577(i)=((2/3)*((ept_577(i))^2+(epw_577(i))^2))^.5;
    
    sigma_577(i)=net([ epbar_577(i);strainrate]);
    k_577(i)=sigma_577(i)/((3)^.5);
%    q_577(i)=(((4*k_577(i-1)*R_577*fi_577(i-1)*(pi()/180))-(2*p_577*R_577*q_577(i-1)))*((fi_577(i)-fi_577(i-1))*(pi()/180))/h_577(i-1))+(2*k_577(i))+q_577(i-1)-(2*k_577(i-1));
    q_577(i)=(-1)*((((4*k_577(i-1)*R_577*fi_577(i-1)*(pi()/180))-(2*p_577*R_577*q_577(i-1)))*((fi_577(i-1)-fi_577(i))*(pi()/180))/h_577(i-1))+(2*k_577(i-1))-q_577(i-1)-(2*k_577(i)));
end


%% 02 - From 0 to 5.77 Forward (and Backward: Uncomment the lower q formula and comment the upper one)

h2_0=h2_577; %h2
R_0=R_577;
p_0=p_577;
fi_0=0:0.01:phi; %fi
h_0(1)=h2_0+(2*R_0*(1-cos(pi()*(fi_0(1)/180))));%h0
ept_0(1)=log(h_0(1)/h_577(1));
epw_0(1)=-ept_0(1);
epbar_0(1)=((2/3)*((ept_0(1))^2+(epw_0(1))^2))^.5;
sigma_0(1)=net([epbar_0(1);strainrate]); %sigma0
k_0(1)=sigma_0(1)/(3^.5); %k0
q_0(1)=2*(sigma_0(1)/(3^.5)); %q0

for i=2:numel(fi_0)
    h_0(i)=h2_0+(2*R_0*(1-cos(pi()*(fi_0(i)/180))));
    ept_0(i)=log(h_0(i)/h_577(1));
    epw_0(i)=-ept_0(i);
    epbar_0(i)=((2/3)*((ept_0(i))^2+(epw_0(i))^2))^.5;
    sigma_0(i)=net([epbar_0(i);strainrate]);
    k_0(i)=sigma_0(i)/((3)^.5);
%    q_0(i)=(((4*k_0(i-1)*R_0*fi_0(i-1)*(pi()/180))+(2*p_0*R_0*q_0(i-1)))*((fi_0(i)-fi_0(i-1))*(pi()/180))/h_0(i-1))+(2*k_0(i))+q_0(i-1)-(2*k_0(i-1));
    q_0(i)=(-1)*((((4*k_0(i-1)*R_0*fi_0(i-1)*(pi()/180))+(2*p_0*R_577*q_0(i-1)))*((fi_0(i-1)-fi_0(i))*(pi()/180))/h_0(i-1))+(2*k_0(i-1))-q_0(i-1)-(2*k_0(i)));

end
%%

%% mean pressure

numberq=numel(q_577);
numberfi=numel(fi_577);

mean=0;
for mm=1:numberq
    for nn=1:numberfi
        mean=mean+q_577(mm).*fi_577(nn);
    end
end 
mean;
mean_pressure=mean/phi;
%%



%% 02 - Visualization

   figure('units','centimeters','outerposition',[5 5 12.5 12.5],'color','w','paperpositionmode','auto','resize','off','visible','on','PaperType','A4','PaperOrientation','Portrait','PaperUnits','Centimeters','PaperPosition',[2.5, 2.5, 10, 18],'PaperPositionMode','auto'); 
                 set(gca,'fontname','Times New Roman','FontSize',12,'LineWidth',0.8,'box','off','color','none');
                 xlim([0, 6]);
                 ylim([0, 2000]);
                 set(gca,'XAxisLocation','bottom','XDir','normal','XScale','linear','XColor','k','XGrid','on','XMinorTick','on','XMinorGrid','on');
                 set(gca,'YAxisLocation', 'left' ,'YDir','normal','YScale','linear','YColor','k','YGrid','on','YMinorTick','on','YMinorGrid','on');
                 set(gca,'xtick',[0, 1.5, 3, 4.5, 6],'xticklabel',{'0.0', '1.5', '3.0', '4.5', '6.0'});
                 set(gca,'ytick',[0, 500,   1000,    1500,    2000],'yticklabel',{'0',     '500',     '1000',     '1500',     '2000'});
				 set(gca,'TickDir','in','TickLength',[0.02, 0.01]);
                 set (gca,'GridLineStyle','-','GridColor','k','GridAlpha',0.6);
              
                 set(gca,'MinorGridLineStyle',':','MinorGridColor','k','MinorGridAlpha',0.3); 
                 xlabel('Fi [Degree]','color','k','fontname','Times New Roman','fontsize',13,'fontweight','bold'); 
                 ylabel('q [-]','color','k','fontname','Times New Roman','fontsize',13,'fontweight','bold');  
                 hold on;
                 P1=plot(fi_577,q_577,'LineStyle','-','color','b','LineWidth',1.5); hold on;
                 P2=plot(fi_0,q_0,'LineStyle','-','color','r','LineWidth',1.5); hold on;
                 leg=legend([P1, P2],{'5.77 to 0.00', '0.00 to 5.77'},'Location','northwest','Orientation','vertical','TextColor','k','fontname','Times New Roman','fontsize',13,'box','on','Color','w','EdgeColor','k');

            
