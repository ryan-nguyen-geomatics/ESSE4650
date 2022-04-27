% Q3
temp = [34.26 34.26 34.26 34.2 33.35 32.25 31.43 31.39 ...
    31.14 27.49 25.53 21.88 21.85];

sal = [31.67 33.46 33.46 33.2 33.02 32.87 32.69 32.47 ...
    31.33 30.28 30.04 31.15 31.08];

dep = [0 10 20 85 150 175 300 550 725 1150 1200 1500 2000];

figure(1)
plot(temp, dep)
set(gca, 'YDir','reverse')
set(gca, 'XAxisLocation', 'top')
title('Temperature Profile')
xlabel('Temperature (°C)')
ylabel('Depth (m)')

annotation(figure(1),'textbox',...
    [0.131208333333333 0.315680166147456 0.773479166666667 0.313603322949117],...
    'String',{'Thermocline Region'},...
    'FontSize',48,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 0.411764705882353 0.16078431372549], ...
    'FaceAlpha', 0.5);

figure(2)
plot(sal, dep)
set(gca, 'YDir','reverse')
set(gca, 'XAxisLocation', 'top')
title('Salinity Profile')
xlabel('Salinity (ppt)')
ylabel('Depth (m)')

annotation(figure(2),'textbox',...
    [0.130729166666667 0.435098650051921 0.775520833333333 0.49221183800623],...
    'String',{'Halocline Region'},...
    'FontSize',48,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 0.411764705882353 0.16078431372549], ...
    'FaceAlpha', 0.5);


% Q4
x = [];
for i = 1:13
    if temp(i) >= -2 && temp(i) <= 24.5 && dep(i) >= 0 && dep(i) <= 1000 && sal(i) >= 30 && sal(i) <= 42
        x(1,i) = 1492.9 + 3*(temp(i)-10) - 0.006*(temp(i)-10)^2 - 0.04*(temp(i)-18)^2 ...
            + 1.2*(sal(i)-35) - 0.01*(temp(i)-18)*(sal(i)-35) + 0.016*dep(i);
        
        x(2,i) = 1;
        
    elseif temp(i) >= 0 && temp(i) <= 35 && dep(i) >= 0 && dep(i) <= 1000 && sal(i) >= 0 && sal(i) <= 45
        x(1,i) = 1449.2 + 4.6*temp(i) - 0.055*temp(i)^2 + 0.00029*temp(i)^3 + ...
            (1.34 - 0.01*temp(i))*(sal(i)-35) + 0.016*dep(i);
        
        x(2,i) = 2;
        
    elseif temp(i) >= 0 && temp(i) <= 30 && dep(i) >= 0 && dep(i) <= 8000 && sal(i) >= 30 && sal(i) <= 40
        x(1,i) = 1448.96 + 4.591*temp(i) - 0.05304*temp(i)^2 + 0.0002374*temp(i)^3 + ...
            1.34*(sal(i)-35) + 0.0163*dep(i) + 1.675*10^-7*dep(i)^2 - ...
            0.01025*temp(i)*(sal(i)-35) - 7.139*10^-13*temp(i)*dep(i)^3;
        
        x(2,i) = 3;
    end
end

figure(3)
plot(x(1,:), dep)
set(gca, 'YDir','reverse')
set(gca, 'XAxisLocation', 'top')
title('Speed of Sound in Sea Water')
xlabel('Mean Sound Speed (m/s)')
ylabel('Depth (m)')

c = x(1,:);

gi = [];
ci = [];
for i = 1:12
    gi(i) = (c(i+1)-c(i)) / (dep(i+1)-dep(i));
    ci(i) = c(i+1) / c(i);
    
    bot(i) = (1/gi(i))*log(ci(i));
end

ch = 2000 / sum(bot);