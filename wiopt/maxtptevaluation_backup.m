
link_cap=6;

% Use BFS search to find the max throughput in a channel assignment
% Input ga as gateways
% Input mesh nodes
% Input interference matrix R_i

% Link_matrix each rows: nodes, layer, upper nodes, bands
clear link_matrix
link_matrix=zeros(4,(numel(ga)+numel(mesh_nodes)));
link_matrix(:,1:numel(ga))=[ga;zeros(size(ga));zeros(size(ga));zeros(size(ga))];
cnt=numel(ga);
all_nodes=[ga mesh_nodes];
%mesh_demand_mul=rand(2,numel(all_nodes))
load test

for bfs_current=1:numel(all_nodes)
    current_node=all_nodes(bfs_current);
    
   for bfs_next=bfs_current:numel(all_nodes)
       next_node=all_nodes(bfs_next);
       for band_i=1:numel(bands)
           if(act_link(current_node,next_node,band_i)==1);
               link_matrix(1,cnt+1)=next_node;
               link_matrix(2,cnt+1)=link_matrix(2,bfs_current)+1;
               link_matrix(3,cnt+1)=current_node;
               link_matrix(4,cnt+1)=band_i;
               cnt=cnt+1;
           end
           
       end
    
    
    
   end    
end

sum_tpt=0;
sum_previous=1;
out_sum=[];
act_cap=act_link*link_cap;
routing_link=zeros(size(act_link));

for demand_amnt=1:size(mesh_demand_mul,1)
    
    
    
    while(sum_tpt~=sum_previous || sum(mesh_demand_mul(demand_amnt,:))==0)
        sum_previous=sum_tpt
current_demand=mesh_demand_mul(demand_amnt,:)
for tpt_i=1:max(link_matrix(2,:))+1
   lay_idx=find(link_matrix(2,:)==tpt_i-1);
   sub_matrix=link_matrix(:,lay_idx);
   
   if(tpt_i-1==0)
       sum_tpt=sum_tpt;
       
   else
       % Demand less than capacity
       lay_served=[];
       lay_unserved=sub_matrix(1,:);
       
       
       while(numel(lay_served)<numel(sub_matrix(1,:)))
           
           % Rank link in the same layer
           process_temp=lay_unserved;
           for rank_i=1:numel(lay_unserved)
               current_node=lay_unserved(rank_i);
               tmp_idx=find(sub_matrix(1,:)==current_node);
               upper_node=sub_matrix(3,tmp_idx);
               current_band=sub_matrix(4,tmp_idx);
               process_temp(2,rank_i)=sum(sum(routing_link(:,:,current_band).*reshape(R_i(current_node,upper_node,:,:,current_band),size(routing_link(:,:,current_band)))))+sum(sum(routing_link(:,:,current_band).*reshape(R_i(current_node,upper_node,:,:,current_band),size(routing_link(:,:,current_band)))));
           
           
           end
           
           process_temp=sortrows(process_temp',2)'
           
           
           
           
           
           
           
           
           current_node=process_temp(1,1)
           tmp_idx=find(sub_matrix(1,:)==current_node)
           upper_node=sub_matrix(3,tmp_idx)
           current_band=sub_matrix(4,tmp_idx)
           current_demand
           
           act_sparse=sparse(act_link(:,:,current_band));
           for path_i=1:numel(ga)
               [Dist,Path]=graphshortestpath(act_sparse,ga(path_i),current_node,'Method','Dijkstra');
               
               if numel(Path)>1
                   temp_min=act_cap(1,2,current_band);
                   for pi=2:numel(Path)
                       temp=used_cap(Path(pi-1),Path(pi))+mesh_demand(j);
                       
                       if (act_cap(Path(pi-1),Path(pi),current_band)>current_demand(current_node))
                           used_cap(Path(pi-1),Path(pi))=temp;
                           
                           
                           
                       else
                           %link_limit=link_cap-used_cap(Path(pi-1),Path(pi));
                           used_cap(Path(pi-1),Path(pi))=link_cap;
                       end
                   end
               end
           end
           
           
           
           
           
       if(act_cap(current_node,upper_node,current_band)>current_demand(current_node))
           % Assign current demand to total tpt
           sum_tpt=sum_tpt+current_demand(current_node)
           % Update demand info
           current_node
           mesh_demand_mul(demand_amnt,current_node)=0
           % Update act_cap
           act_cap(current_node,upper_node,current_band)=act_cap(current_node,upper_node,current_band)-current_demand(current_node);
           act_cap(upper_node,current_node,current_band)=act_cap(upper_node,current_node,current_band)-current_demand(current_node);
           % Update interference nodes
           tmp_idx=find(R_i(current_node,upper_node,:,:,current_band)==1);
           act_cap(tmp_idx)=act_cap(tmp_idx)-current_demand(current_node);
           tmp_idx=find(R_i(upper_node,current_node,:,:,current_band)==1);
           act_cap(tmp_idx)=act_cap(tmp_idx)-current_demand(current_node);
           % Update routing link
           routing_link(current_node,upper_node,current_band)=1;
           routing_link(upper_node,current_node,current_band)=1;
           % Update served node
           lay_served=[lay_served,current_node];
           lay_unserved(find(lay_unserved==current_node))=[];
           
       else
           
           % Assign current demand to total tpt
           sum_tpt=sum_tpt+act_cap(current_node,upper_node,current_band);
           % Update demand info
           mesh_demand_mul(demand_amnt,current_node)=mesh_demand_mul(demand_amnt,current_node)-act_cap(current_node,upper_node,current_band)
           % Update act_cap
           act_cap(current_node,upper_node,current_band)=0;
           act_cap(upper_node,current_node,current_band)=0;
           % Update interference nodes
           tmp_idx=find(R_i(current_node,upper_node,:,:,current_band)==1);
           act_cap(tmp_idx)=act_cap(tmp_idx)-act_cap(current_node,upper_node,current_band);
           tmp_idx=find(R_i(upper_node,current_node,:,:,current_band)==1);
           act_cap(tmp_idx)=act_cap(tmp_idx)-act_cap(current_node,upper_node,current_band);
           % Update routing link
           routing_link(current_node,upper_node,current_band)=1;
           routing_link(upper_node,current_node,current_band)=1;
           % Update served node
           lay_served=[lay_served,current_node]
           lay_unserved(find(lay_unserved==current_node))=[]
           
           
           
       end
       
       
       end
       
   end
   
   
   
    
end
sum_tpt
sum_previous
    end
    
out_sum=[out_sum sum_tpt];

end