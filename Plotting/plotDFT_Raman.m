% This is to be used in conjunction with DFT FTIR simulations
% Data are fit to a Lorentzian distribution with a FWHM defined by the FWHM variable
clear; clc;
set(0,'defaultAxesFontName', 'Arial');
axLineWidth = 1.5; plotLineWidth = 2; LabelSize = 24; AxisNumberSize = 22; 

FWHM = 30; x = [0:0.25:4000]; gamma = FWHM./2; count = 0;
data = dlmread('path/to/vasp_raman.dat','',1,0);

clf(figure(1)); hold on; f = figure(1);  f.Position = [1 34 959 970];
Lorentzian = zeros(1,length(x));
for jj = 1:size(data,1)
    I = data(jj,5);        
    xo = data(jj,2);
    Lorentzian =  Lorentzian + I.*[normalize([(gamma.^2)./((x - xo).^2 + gamma.^2)]')]';
end
plot(x,(Lorentzian')+count,'r')
data2 = (data(:,5));

for ii = 1:size(data,1)
   plot([data(ii,2) data(ii,2)],[0 data2(ii)],'b') 
end

xlim([0 1200]);
set(findall(gca, 'Type', 'Line'),'LineWidth',plotLineWidth);
set(gca,'linewidth',axLineWidth,'XMinorTick','on','YMinorTick','on','fontsize',AxisNumberSize,'tickdir','out','MinorGridLineStyle','-');
xlabel('Raman Shift (cm^{-1})','FontSize', LabelSize, 'fontweight','b','color','k','FontName','Arial Bold');
ylabel('Raman Scattering (Arb. Units)','FontSize', LabelSize, 'fontweight','b','color','k','FontName','Arial Bold');
box on; grid off; ax = gca; ax.XColor = 'k';ax.YColor = 'k';



