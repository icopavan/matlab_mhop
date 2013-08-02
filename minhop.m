% Author: Pengfei Cui
% Date: Aug 2, 2013
% For simulation of a fairness algorithm for multiband multihop evaluation

   
% Function:
    % Implement the MinHop algorithm 

% Process:
    % Have regular grid
    % Need a start placement
    % Need a transship implementation for function add(s), generate
    % function add
  
    
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

% Generate gateway placement

Gateways_start=[1,501]
test=[1501,1501]
Gateways=[Gateways_start;test]
temp_cap=capacity_cal(Node,Gateways,C_th,CI_th)

% for g_num=1:1%m*n
%     g_temp=nchoosek(1:m*n,g_num);
%     [tm,tn]=size(g_temp);
%     max_cap(g_num)=0;
%     for i=1:tm
%         Gateways=Node(g_temp(i,:),:);
%         temp_cap=capacity_cal(Node,Gateways,C_th,CI_th);
%         if(max_cap(g_num)<=temp_cap)
%             max_cap(g_num)=temp_cap
%             Gateways
%         %    placement(g_num,:)=Gateways;
%         end
%     end
%     
%     
% end


