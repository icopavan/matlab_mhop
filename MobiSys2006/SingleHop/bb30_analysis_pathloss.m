%BB30_ANALYSIS.M
%This script analyzes the pathloss characteristics of all measurements with
%a baseball bat antenna at 30' (5-10 and 5-17 measurements). It outputs the
%following plots:
%Received power versus distance, theoretical and empirical
%Shadowing distribution, with Gaussian density fit
%Pathloss exponent versus obstruction (looking for correlation)
%Pathloss exponent distribution

clear all;
close all;

dir='';
results=[];
results_l=zeros(4,24)
load('reference')
for i=1:4    %Enviromnet
 %   cend=4;
    if(i==1)
        file=[dir,'dedman_s'];
        load(file);
    elseif(i==2)
        
        file=[dir,'bishop_s'];
        load(file);
    elseif(i==3)
        
        file=[dir,'mstreet_s'];
        load(file);
    elseif(i==4)
 %       cend=3;
        file=[dir,'downtown_s'];
        load(file);        
    end
    for j=1:4 %Bands
        if(j==1)
            c_c=c_2;
        elseif(j==2)
            c_c=c_5;
        elseif(j==3)
            c_c=c_7;
        elseif(j==4)
            c_c=c_9;
        end
        
        
%%% Crrect the distance

    if(i==2)  %Bishop
        for di=1:size(c_c)
            if(c_c(di,2)==25)
                c_c(di,2)=30.1137818810506;
            elseif(c_c(di,2)==50)
                c_c(di,2)=54.8375233402927;
            elseif(c_c(di,2)==100)
                c_c(di,2)=106.399672951546;
            elseif(c_c(di,2)==150)
                c_c(di,2)=163.872017936435;
            elseif(c_c(di,2)==200)
                c_c(di,2)=205.180705818252;
                
            end
        end
    end
        
    if(i==3)  %Mstreet
        for di=1:size(c_c)
            if(c_c(di,2)==25)
                c_c(di,2)=27.928267747719;
            elseif(c_c(di,2)==50)
                c_c(di,2)=50.5753367199863;
            elseif(c_c(di,2)==100)
                c_c(di,2)=102.113521675313;
            elseif(c_c(di,2)==150)
                c_c(di,2)=155.866175983084;
            elseif(c_c(di,2)==200)
                c_c(di,2)=196.739093494942;
                
            end
        end
    end        
 
   if(i==4)  %Downtown
        for di=1:size(c_c)
            if(c_c(di,2)==25)
                c_c(di,2)=26;
            elseif(c_c(di,2)==50)
                c_c(di,2)=65;
            elseif(c_c(di,2)==100)
                c_c(di,2)=130;
            elseif(c_c(di,2)==150)
                c_c(di,2)=170;
            elseif(c_c(di,2)==200)
                c_c(di,2)=220;
                
            end
        end
    end        
    
    
    
        
        sig = c_c(:,6:195);%[sig1; sig2] - 60;%signal power corrected to make units same as reference units
        sig=sig(:);
        sigvar = zeros(size(sig));%c_c(:,7);%[sigvar1; sigvar2];
        dist=[];
        for dd=1:(max(size(sig))/min(size(c_c)))
        dist = [dist,c_c(:,2);];
        end
        dist=dist(:);
        for k=1:3 %Reference power
            
            P0 = c_ref(i,j,k); %reference power, was -2
            if(i==1)
                d0 = 10.01; %reference distance
            elseif(i==2)
                d0 = 14.7323297687844;
            elseif(i==3)
                d0=10.3811352911814;
            elseif(i==4)
                d0=18;
            end
            
            
        
        











% map = imread('pecan_park_map.tif');
% rmat = map(:,:,1); %peel apart the color layers
% gmat = map(:,:,2);
% bmat = map(:,:,3);
% intmap = rgb_2_num(rmat,gmat,bmat); %convert colors to integers
% %obstruction is numbers 1,2,3,4,5 or 7
% los_indices = find((intmap == 0)|(intmap == 6)); %either green space or unclassified
% binmap = ones(size(intmap)); %preallocate a binary map
% binmap(los_indices) = 0; %place zeros where there is no obstruction present





%  [sig1, sigvar1, udp1, udpvar1, N1, W1, Nstat1, Wstat1] = measurement_results_5_10_05(0);
%  [sig2, sigvar2, udp2, udpvar2, N2, W2, Nstat2, Wstat2] = measurement_results_5_17_05(0);




% 
% L1 = length(N1); %number of measurements
% L2 = length(N2); %number of measurements

% udp = [udp1; udp2];
% udpvar = [udpvar1; udpvar2];
% 
% [xstat1,ystat1] = gps_2_xy(Nstat1,Wstat1);
% [xstat2,ystat2] = gps_2_xy(Nstat2,Wstat2);
% 
% obsvec1 = zeros(L1,1);
% obsvec2 = zeros(L2,1);
% dist1 = zeros(L1,1);
% dist2 = zeros(L2,1);
% xvec1 = zeros(L1,1);
% yvec1 = zeros(L1,1);
% xvec2 = zeros(L2,1);
% % yvec2 = zeros(L2,1);
% 
% for n = 1:L1
%     distvec1(n) = gps2dist(N1(n),W1(n),Nstat1,Wstat1);
% %     [xvec1(n),yvec1(n)] = gps_2_xy(N1(n),W1(n));
%     %obsvec1(n) = obs_frac(xvec1(n),yvec1(n),xstat1,ystat1,binmap);
% end
% 
% L2 = length(N2); %number of measurements
% for n = 1:L2
%     distvec2(n) = gps2dist(N2(n),W2(n),Nstat2,Wstat2);
% %     [xvec2(n),yvec2(n)] = gps_2_xy(N2(n),W2(n));
%     %obsvec2(n) = obs_frac(xvec2(n),yvec2(n),xstat2,ystat2,binmap);
% end

% xvec = [xvec1; xvec2];
% yvec = [yvec1; yvec2];
% 
% obs = [obsvec1; obsvec2];


distmat = [dist dist dist];
distvec = distmat(:);

sigmat = [(sig-sigvar) sig (sig+sigvar)];
sigvec = sigmat(:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pathloss Exponent Section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha = get_plexp(distvec(:),sigvec(:),d0,P0);

index = find (alpha < 6);
alpha = alpha(index); %remove outliers

index = find (alpha > 0);
alpha = alpha(index); %remove outliers

mualpha = mean(alpha);
mualphastr = num2str(mualpha);
sigmaalpha = std(alpha);
sigmaalphastr = num2str(sigmaalpha);
sigvec_th = rxpower_vs_dist(distvec(index),mualpha); %theoretical signal powers
diffvec = sigvec_th - (sigvec(index)); %difference between theoretical and actual powers
mu = mean(diffvec);
mustr = num2str(mu);
sigma = std(diffvec);
sigmastr = num2str(sigma);


results=[results,mualpha,mu];

        end
        results_l(i,(6*(j-1)+1):(6*j))=results(:);
        results=[];
    end
end





















%%%%%%%%%%%%%%%%%%%%%%%%%
% Received Power Curves %
%%%%%%%%%%%%%%%%%%%%%%%%%





% dvec = 1:max(distvec);
% lospvec = P0 - 10*2*log10(dvec/d0); %line of sight prediction
% pvec = P0 - 10*mualpha*log10(dvec/d0);
% figure
% hold on
% scatter(distvec,sigvec)
% plot(dvec,lospvec,'k')
% plot(dvec,pvec,'b--')
% plot(dvec,pvec+sigma,'g-.')
% plot(dvec,pvec-sigma,'g-.')
% plot(dvec,pvec+2*sigma,'r:')
% plot(dvec,pvec-2*sigma,'r:')
% legend('Measurements','Free Space','Mean','+1 Stdev','-1 Stdev','+2 Stdev','-2 Stdev')
% xlabel('Distance (m)')
% ylabel('Received Signal Power (dBm)')
% %gtext(['Pathloss Exponent = ' mualphastr ', Shadowing Std = ' sigmastr])
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Received Power Distribution %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if 1
% figure
% histfit(diffvec)
% xlabel('Received Signal Power Deviation From Mean (dBm)')
% ylabel('Number of Instances')
% text(0,max(hist(diffvec))-5,['Standard Deviation = ' sigmastr]);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Pathloss Exponent Distribution %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if 1
% figure
% hist(alpha(index))
% xlabel('Pathloss Exponent Value')
% ylabel('Number of Instances')
% text(0,max(hist(alpha(index)))-5,['Mean Pathloss Exponent = ' mualphastr ', Pathloss Exponent Std = ' sigmaalphastr])
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Pathloss Versus Obstruction %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if 1
% obsmat = [obs obs obs];
% obsvec = obsmat(:);
% 
% % alphamat = [alpha(index) alpha(index) alpha(index)];
% % alphavec = alphamat(:);
% 
% figure
% scatter(obsvec(index),alpha(index))
% xlabel('Fraction of Obstruction')
% ylabel('Pathloss Exponent')
% xlim([0 1])
% 
% end
% 