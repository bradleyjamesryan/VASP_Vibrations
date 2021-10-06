% This is to be used in conjunction with DFT FTIR simulations
% Data are fit to a Lorentzian distribution with a FWHM defined by the FWHM variable
clear; clc;
set(0,'defaultAxesFontName', 'Arial');
axLineWidth = 1.5; plotLineWidth = 2; LabelSize = 24; AxisNumberSize = 22; 

FWHM = 50; 
x = [0:0.25:4000]; gamma = FWHM./2; count = 0;

data = dlmread('/path/to/Step2_FTIR/intensities/results/exact.res.txt');

calibrate = @(x) 0.951.*x + 49.2; % This might be specific to silicon  nanosheets
data(:,2) = calibrate(data(:,2));

clf(figure(1)); hold on;
f = figure(1);  f.Position = [1 34 959 970];
Lorentzian = zeros(1,length(x));
for jj = 1:length(data)
    I = data(jj,3);        xo = data(jj,2);
    Lorentzian =  Lorentzian + I.*[normalize([(gamma.^2)./((x - xo).^2 + gamma.^2)]')]';
end 
Lorentzian = 10.^(-(normalize([Lorentzian]').*1 - 2));
plot(x,normalize(Lorentzian)+count,'r')

data2 = normalize(data(:,3));

for ii = 1:length(data)
   plot([data(ii,2) data(ii,2)],[1 1-data2(ii)],'b') 
end



set(findall(gca, 'Type', 'Line'),'LineWidth',plotLineWidth);
set(gca,'linewidth',axLineWidth,'XMinorTick','on','YMinorTick','on','fontsize',AxisNumberSize,'tickdir','out','MinorGridLineStyle','-');
set(gca,'xtick',[500 1000 1500 2000 2500 3000 3500 4000]);
set(gca,'xticklabel',{'500' '1000' '' '2000' '' '' '' '4000'});
ax = gca; ax.XAxis.MinorTickValues = [600:100:900 1100:100:1400 1600:100:1900 2100:100:2400 2600:100:2900 3100:100:3400 3600:100:3900];
set(gca,'xdir','reverse','ytick',''); set(gca,'xscale','log');
xlim([500 4000]);
xlabel('Wavenumber (cm^{-1})','FontSize', LabelSize, 'fontweight','b','color','k','FontName','Arial Bold');
ylabel('Transmittance (Arb. Units)','FontSize', LabelSize, 'fontweight','b','color','k','FontName','Arial Bold');
set(gca,'ytick','')
box on; grid off; ax = gca; ax.XColor = 'k';ax.YColor = 'k';

function output = normalize(x_z)
if size(x_z,2) > 1
    output(:,1) = x_z(:,1);
    output(:,2) = (x_z(:,2) - min(x_z(:,2)))./(max(x_z(:,2)) - min(x_z(:,2)));
else
    output = (x_z - min(x_z))./(max(x_z) - min(x_z));
end
end
