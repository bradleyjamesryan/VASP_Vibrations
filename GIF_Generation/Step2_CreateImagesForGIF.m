clear; clc;
CONTCARPATH =  '/home/anon/Documents/GraduateSchool/DFT/VASP_Vibrations/Raman/Raman_Calculation/Step3_Raman';
cd(CONTCARPATH);

if exist('intensities','dir')
    results = dlmread([CONTCARPATH '/intensities/results/results.txt']);
    calibrate = @(x) 0.951.*x + 49.2; % Calibration for silicon nanosheets. You might need to change (or remove) this!
else
    results = dlmread([CONTCARPATH '/vasp_raman.dat'],'',1,0);
    results = results(:,[1 2 5]);
    results(:,3) = normalize(results(:,3));
    calibrate = @(x) 0.996.*x + 3.94; % Calibration for silicon nanosheets. You might need to change (or remove) this!
end

fid = fopen('CONTCAR');
WavelengthRange = [350 5000]; %Skip all vibrational modes outside this range. Units are cm^{-1}
nstep = 10; %Number of discrete steps for each mode. 
scale = 1; %Amplification factor for visualizing vibrational mode. Amplitude of displacement will get multipled by "scale"
zz = 1;

%% Read extracted data from the "extractedForMatlab.m" file that was generated from "ExtractFTIRModes_FromOUTCAR.sh"
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

element = split(regexprep(data2{6}{1},' +',' '),' ');
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

freq = calibrate(freq);

mkdir('GIFImages')
cd('GIFImages')
[X,Y,Z] = sphere;
for gg = 1:length(freq)
    if ((freq(gg) < max(WavelengthRange)) & (freq(gg) > min(WavelengthRange)) & (results(gg,3) > 0.00999))
        disp(['Saving mode ' num2str(gg) '/' num2str(zz) ' (' num2str(freq(gg)) ' cm^-1)'])
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
        if (freq(gg) > max(WavelengthRange))
           disp(['Skipping mode ' num2str(gg) '/' num2str(zz) ' (Above user-defined wavenumber range)'])
        end
        if (freq(gg) < min(WavelengthRange))
            disp(['Skipping mode ' num2str(gg) '/' num2str(zz) ' (Below user-defined wavenumber range)'])
        end
        if (results(gg,3) <= 0.00999)
            disp(['Skipping mode ' num2str(gg) '/' num2str(zz) ' (Intensity very low)'])
        end
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


function output = normalize(x_z)
if size(x_z,2) > 1
    output(:,1) = x_z(:,1);
    output(:,2) = (x_z(:,2) - min(x_z(:,2)))./(max(x_z(:,2)) - min(x_z(:,2)));
else
    output = (x_z - min(x_z))./(max(x_z) - min(x_z));
end
end
