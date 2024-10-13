clc
clear all 
close all

%statistics
datas = readtable('measurements.csv');
data=datas{:,:};
%measures at 3 4 5 6 7 8 9 10 11 12 13 14 15 cm (total of 13 columns)
position = linspace (3,15,13);

for i=1:size(data,1)
    for k =1:size(position,2)
        error(i,k)=data(i,k)- position(k);
    end
end

Y=[5.681165078508955,-0.24863724989546546,7.11364989402561,-0.7167873125262891];
syms x
calibration_curve= @(x) Y(1)*exp(Y(2)*x)+Y(3)*exp(Y(4)*x); %%inserire parametri curva di calibrazione
der_cc= inline(diff(calibration_curve,x),'x');

for k=1:size(position,2)
    m(k)= mean(abs(error(:,k)));
    %inaccuracy(k)= max((abs(error(:,k))./position(k))*100); %inacurracy in function of distance
    % ho dei dubbi sui valori assunti da questa inaccuracy: a 3 cm il
    % dispositivo sbagliava di poco, quindi errore più piccolo, a 9 cm
    % sbagliava di molto quindi errore più grande. Dato che si divide per
    % la distanza ovviamente un certo numero è più grande di un certo
    % numero7) ma come lo interpreto?
    inac(k)= max((abs(error(:,k))./(15-3))*100);
    s(k)= std(abs(error(:,k)));
    precision(k)=std(data(:,k));
    sensitivity(k)= der_cc(position(k)); 
end
%% 
m_general=mean(abs(error),'all');
s_general=std(abs(error),0,'all');
kurt= kurtosis(abs(error),1,'all'); %if <0 hypo, if=0 norm, if >0 hyper
% in this case hyper
skew= skewness(abs(error),1,'all'); %if >0 right asymmetry, if<0 left asymmetry
%in this case right
%inaccuracy_worst = max(inaccuracy); %non so quanto abbia senso poichè non ho
%chiara l'interpretazione di inaccuracy (vedi commenti sopra)
inac_tot = max(inac);

%%
figure() 
histogram(error(:),10);
title('distribution of error')
xlabel('error')
ylabel('probability')

figure()
plot(position,m(1,:), 'ob', 'LineWidth',2); %error bar
hold on
errorbar(position,m(1,:),s(1,:),'b');
title('error mean and standard deviation in function of distance')
xlabel('distance[cm]')
ylabel('error')
xticks(position)
% hold on
% plot(position,zeros(size(position,2)),'r')
