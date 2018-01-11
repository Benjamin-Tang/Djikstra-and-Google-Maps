function [path, distance] = dijkstra(mat, start, last)


n=size(mat,1);
indices(1:n) = 0; 

dist(1:n) = inf;   
prev(1:n) = n+1; 

dist(start) = 0;

while sum(indices)~=n
    curr=[];
    for i=1:n
        if indices(i)==0
            curr=[curr dist(i)];
        else
            curr=[curr Inf];
        end
    end
    [num index]=min(curr);   %find min distance
    
    indices(index)=1;
    for j=1:n    %calculate minimum distances to neighbors
        if(dist(index)+mat(j,index))<dist(j)
            dist(j)=dist(index)+mat(j,index);
            prev(j)=index;
        end
    end
end

path = [last];
while path(1) ~= start
    if prev(path(1))<=n
        path=[prev(path(1)) path];
    else
        error;
    end
end;
distance = dist(last);
