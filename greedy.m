% Author: Pengfei Cui
% Date: Aug 7, 2013
% For simulation of a fairness algorithm for multiband multihop evaluation

   
% Function:
    % Implement Greedy Algorithm

% Process:
    



clear all
close all

% Generate 7x7 regular grid
x=1:500:500*7;
y=1:500:500*7;
[mm,m]=size(x);
[nn,n]=size(y);

for i=1:m
    for j=1:n
        Node((i-1)*n+j,1)=x(i);
        Node((i-1)*n+j,2)=y(j);
    end
end

% Single band communicate threshold & interference threshold
C_th=550;
CI_th=1000;

% Initialize the gateway and potential nodes
Gateways=[3001,2001];




% Function Greedy
% Need to make the following code works as an function


% Greedy algorithm that find the best next adding node location based on the existing placement
[m,n_p]=size(Node);
[m_gateway,n_g]=size(Gateways);
poten_nodes=Node;
[m_poten,n_p]=size(poten_nodes);
m_pf=1;
% Delete the existing Gateways from portential nodes
while((m-m_gateway)~=m_poten)
    flag=0;
    for k=1:m_gateway
        if(Gateways(k,1)==poten_nodes(m_pf,1) && Gateways(k,2)==poten_nodes(m_pf,2))
            poten_nodes(m_pf,:)=[];
            flag=1;
        end
    end
    if(flag==0)
        m_pf=m_pf+1;
    end
    
    [m_poten,n_p]=size(poten_nodes);
end


[m_poten,n_p]=size(poten_nodes)
N_cnt=1;

while(m_poten>0)
    capacity_g(N_cnt)=0;
    for i=1:m_poten
        temp_placement=[Gateways;poten_nodes(i,:)];
        temp_cap=capacity_cal(Node,temp_placement,C_th,CI_th);
        if(capacity_g(N_cnt)<temp_cap)
            capacity_g(N_cnt)=temp_cap;
            max_placement=temp_placement;
            p_node_cnt=i;
        %    placement(g_num,:)=Gateways;
        end
    end
    poten_nodes(p_node_cnt,:)=[];
    Gateways=max_placement;
    N_cnt=N_cnt+1;
    [m_poten,n_p]=size(poten_nodes);
    capacity_g
end



