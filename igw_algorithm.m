% Matlab scritp to test Model from Dr. Rajan
% Use a 5x5 regular grid, 25 mesh nodes
% Use Arbitrary Demand generated randomly
% Use Arbitrary link capacity randomly

clear all
close all

%  N_x=1;
%  N_y=5;
ga_fl=1;
for N_x=1:1
    for N_y=2:15
% % Load Demand
% 
% clear MN_loc;
% clear R_link;
% clear demandu;
% clear demandd;
% clear excu;

demandu=ones(1,N_x*N_y);
%save 'D_rj.mat' demand;
%load D_rj;
demandd=demandu*2;
demandu=demandu*1.5;

% Generate grid and capacity according to distance
[X,Y]=meshgrid(1:500:500*N_x,1:500:500*N_y);



f_c=1;
for i=1:N_x
    for j=1:N_y
        MN_loc(f_c,1)=X(1,i);
        MN_loc(f_c,2)=Y(j,1);
        f_c=f_c+1;
    end
end

MN=1:(N_x*N_y);

% Define single link capacity and threshold
l_cap=6;
d_thre=500;

% Generate Adjacency matrix

for i=1:length(MN_loc(:,1))
    for j=1:length(MN_loc(:,1))
        dis_temp(i,j)=sqrt((MN_loc(i,1)-MN_loc(j,1))^2+(MN_loc(i,2)-MN_loc(j,2))^2);
        if(i==j)
            R_link(i,j)=0;
        elseif(dis_temp(i,j)<=d_thre)
            R_link(i,j)=l_cap;
        else
            R_link(i,j)=0;
        end
    end
    
end

% Above are input

Ad_d1=R_link;
Ad_d1(Ad_d1>0)=1;
rs_demand_d=demandd;
rs_demand_u=demandu;
ga=zeros(1,numel(MN));






% Generate Adjacency matrix degree 2
[m,n]=size(Ad_d1);
Ad_d2=Ad_d1;
for i=1:m
    for j=1:n
        if(Ad_d1(i,j)==1)
            Ad_d2(i,:)=Ad_d2(i,:)+Ad_d1(j,:);
        end        
    end
    Ad_d2(i,i)=0;
end
 


while((sum(rs_demand_u)+sum(rs_demand_d))>0)

tshar=zeros(numel(MN));
% Calculate the 
iwg2=sum(Ad_d2);

[mavalue,gw_temp]=max(iwg2)

% Select max value as gateway,1.delete the demand of the selected gateway
% 2. Assign the capacity to nearest neighbors to reduce the hop count
% 3. Shrink the Adj matrix with deleting the gateway, 
gw_temp=gw_temp(1);
ga(gw_temp)=1
rs_demand_d(gw_temp)=0
rs_demand_u(gw_temp)=0
traf_d=R_link.*0;
traf_u=R_link.*0;


index=find(Ad_d1(gw_temp,:)>0);

[minvalue,temp]=min(iwg2(index));
md_satisfy=index(temp);

     gw_cap1=0.*(R_link(gw_temp,:));
     gw_cap1(md_satisfy)=R_link(gw_temp,md_satisfy)*(1-tshar(gw_temp,md_satisfy))

[gw_cap,rs_demand_d,rs_demand_u,traf_d_out,traf_u_out,tshar]=traffic_interation(Ad_d2,tshar,Ad_d1,rs_demand_d,rs_demand_u,R_link,gw_temp,iwg2,traf_d,traf_u,index,md_satisfy,gw_cap1,temp)


% traf_d=traf_u_out;
% traf_u=traf_d_out;


if(sum(gw_cap)>0 && (sum(rs_demand_d)+sum(rs_demand_u))>0)
    
    for i=1:numel(index)
        gw_next=index(i);
        index_hop2=find(Ad_d1(gw_next,:)>0);
        
        [minvalue,temp]=min(iwg2(index_hop2));
        md_satisfy=index_hop2(temp)

        gw_cap1=0.*(R_link(gw_next,:));
        gw_cap1(md_satisfy)=sum(gw_cap)
        
        tshar_prev=tshar;
        
        [gw_cap,rs_demand_d,rs_demand_u,traf_d,traf_u,tshar]=traffic_interation(Ad_d2,tshar,Ad_d1,rs_demand_d,rs_demand_u,R_link,gw_next,iwg2,traf_d,traf_u,index_hop2,md_satisfy,gw_cap1,temp)
        
        traf_d_out=traf_d_out+traf_d;
        traf_u_out=traf_u_out+traf_u;
        
        tshar_dif=tshar-tshar_prev;
        tshar(gw_temp,gw_next)=tshar(gw_temp,gw_next)+tshar(gw_next,md_satisfy)*R_link(gw_next,md_satisfy)/R_link(gw_temp,gw_next)
        
        
    end
    
end


Ad_d2(gw_temp,:)=0;
Ad_d2(:,gw_temp)=0;

end

ga
ga_store(ga_fl)=sum(ga);
ga_fl=ga_fl+1;

    end
end