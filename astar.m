function [total_path path_cost]= astar(mat,start, goal)
    n=size(mat,1);
    heurisdist(:)=mat(:,goal); %heurisitc distances calculated from start (goal node) 
                               %to each node assuming top row is start point

    closedSet(1:n)=1;
    openSet(1:n)=1;
    openSet(start) = 0;

    prev = containers.Map('KeyType','int32','ValueType','int32'); % an empty map

    Inf_vec(1,1:n)=Inf;
    dist = containers.Map([1:n],Inf_vec);
    dist(start) = 0;
    
    dist2goal = containers.Map([1:n],Inf_vec);
    dist2goal(start) = heurisdist(start);

    while ~isempty(openSet)
        distances=cell2mat(values(dist2goal));
        [num index]=min(distances)
        current=index; %the node in openSet having the lowest dist2goal[] value
        if (current==goal)
            total_path=reconstruct_path(prev, current);
            path_cost=dist(goal);
            return;
        end
        openSet(current)=NaN;
        closedSet(current)=0;
%         neighbors=1:445; %(mat(:,current));
        neighbors=find(mat(:,current)<=140);
        for i=1:size(neighbors)
            tentative_dist = dist(current) + mat(current, neighbors(i));
            if (closedSet(neighbors(i))==0)&&(tentative_dist>=dist(neighbors(i)))   %check if neighbor in closed set
                continue;		
            end
            if (openSet(neighbors(i))==1)||(tentative_dist<dist(neighbors(i)))	% check if neighbor not in open Set
                prev(neighbors(i)) = current;
                dist(neighbors(i)) = tentative_dist;
                dist2goal(neighbors(i)) = dist(neighbors(i)) + heurisdist(neighbors(i));
                if(openSet(neighbors(i))==1)
                    openSet(neighbors(i))=0;
                end
            end
        end
    end
end

                       
function [total_path]=reconstruct_path(prev, current)
    total_path=[current];
    count=2;
    while isKey(prev,current)
        current = prev(current);
        total_path(count)=current;
        count=count+1;
    end
%     return total_path
end
