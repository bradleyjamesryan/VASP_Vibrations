clear; clc;
CONTCARPATH =  '/home/anon/Documents/GraduateSchool/Data/Group IV/DFT/2021_06_02_SiD_Vibrations/2020_12_16_TwoInsertedOxygen4x4/Config2';
cd(CONTCARPATH);
results = dlmread([CONTCARPATH '/intensities/results/results.txt']);
fid = fopen('CONTCAR');
WavelengthRange = [350 5000]; %SKill all vibrational modes outside this range. Units are cm^{-1}
nstep = 10; scale = 1; zz = 1;

%% OUTPUT of extractedForMatlab goes here
 extractedForMatlab

%% End of extractedForMatlab goes here
disp(['Total of ' num2str(zz) ' modes'])
count = 1;
tline = fgetl(fid);
data2{count} = {tline};
while ischar(tline)
    count = count +1;
    tline = fgetl(fid);
    data2{count} = {tline};
end
fclose(fid);

element = split(regexprep(data2{1}{1},' +',' '),' ');
count = 1;
for ii = 1:length(element)
    if isempty(element{ii})
    else
        newelement{count} = element{ii};
        count = count+1;
    end
end
element = newelement;
number_of_elements = [str2num(regexprep(data2{7}{1},' +',' '))];
vectors = [str2num(data2{3}{1}); str2num(data2{4}{1}); str2num(data2{5}{1}); ];
mag_a = sqrt(sum(vectors(1,:).^2));
mag_b = sqrt(sum(vectors(2,:).^2));
mag_c = sqrt(sum(vectors(3,:).^2));

calibrate = @(x) 0.951.*x + 49.2;
freq = calibrate(freq);

mkdir('GIFImages')
cd('GIFImages')
[X,Y,Z] = sphere;
for gg = 1:length(freq)
    if ((freq(gg) < max(WavelengthRange)) & (freq(gg) > min(WavelengthRange)) & (results(gg,3) > 0.00999))
        disp(['Saving mode ' num2str(gg) '/' num2str(zz) ' (' num2str(freq(gg)) 'cm^-1)'])
        mkdir(strrep(num2str(freq(gg)),'.','pt'))
        cd(strrep(num2str(freq(gg)),'.','pt'))
        
        newcount = 1;
        for hh = [1:(nstep+1) nstep:-1:2]
%             clf(figure(1)); 
            f = figure('visible','off'); clf(f);
            hold on; axis equal;
            set(gca,'visible','off')
            plotvectors(vectors)
            count = 1;
            for ii = 1:length(number_of_elements)
                for jj = 1:(number_of_elements(ii))
                    if element{ii} == 'H'
                        colorz = [1 1 1]-0.05;
                        sizez = 0.3;
                    elseif element{ii} == 'O'
                        colorz = [1 0 0];
                        sizez = 0.54;
                    elseif element{ii} == 'Si'
                        colorz = [0 0 1];
                        sizez = 1;
                    end
                    h = surf(...
                        X*sizez + data{gg}(count,1)+scale*(data{gg}(count,4)*(hh-1)/nstep),...
                        Y*sizez + data{gg}(count,2)+scale*(data{gg}(count,5)*(hh-1)/nstep),...
                        Z*sizez + data{gg}(count,3)+scale*(data{gg}(count,6)*(hh-1)/nstep),...
                        'FaceColor',colorz,'EdgeColor','none');
                    count = count+1;
                end
            end
            light; 
            lighting gouraud;
            namecount = [num2str(newcount)];
            
            if newcount < 10
                namecount = [num2str(0) num2str(newcount)];
            end
            saveas(f, [strrep(num2str(round(freq(gg),2)),'.','pt') '_top_' namecount '.png'])
            
            view(0,0);
            saveas(f, [strrep(num2str(round(freq(gg),2)),'.','pt') '_side_' namecount '.png'])
            
            view(0,-90);
            saveas(f, [strrep(num2str(round(freq(gg),2)),'.','pt') '_bottom_' namecount '.png'])
            newcount =newcount+1;
            close(f)
        end
        cd ..
    else
        disp(['Skipping mode ' num2str(gg) '/' num2str(zz) ' (intensity very low or outside user-defined wavenumer range)'])
    end
end

function plotvectors(vectors)
plot3([0 vectors(1,1)],[0 vectors(1,2)],[0 vectors(1,3)],'k-')
plot3([0 vectors(2,1)],[0 vectors(2,2)],[0 vectors(2,3)],'k-')
plot3([0 vectors(3,1)],[0 vectors(3,2)],[0 vectors(3,3)],'k-')

plot3([0 vectors(2,1)]+vectors(1,1),[0 vectors(2,2)]+vectors(1,2),[0 vectors(2,3)],'k-')
plot3([0 vectors(3,1)]+vectors(1,1),[0 vectors(3,2)]+vectors(1,2),[0 vectors(3,3)],'k-')

plot3([0 vectors(1,1)]+vectors(2,1),[0 vectors(1,2)]+vectors(2,2),[0 vectors(1,3)],'k-')
plot3([0 vectors(3,1)]+vectors(2,1),[0 vectors(3,2)]+vectors(2,2),[0 vectors(3,3)],'k-')
plot3([0 vectors(3,1)]+vectors(1,1)+vectors(2,1),[0 vectors(3,2)]+vectors(1,2)+vectors(2,2),[0 vectors(3,3)],'k-')

plot3([0 vectors(1,1)],[0 vectors(1,2)],[0 vectors(1,3)]+vectors(3,3),'k-')
plot3([0 vectors(2,1)],[0 vectors(2,2)],[0 vectors(2,3)]+vectors(3,3),'k-')
plot3([0 vectors(2,1)]+vectors(1,1),[0 vectors(2,2)]+vectors(1,2),[0 vectors(2,3)]+vectors(3,3),'k-')
plot3([0 vectors(1,1)]+vectors(2,1),[0 vectors(1,2)]+vectors(2,2),[0 vectors(1,3)]+vectors(3,3),'k-')
end