function [ generation ] = fitness( generation,population_count,service_count )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
load('datasetnormal.mat')
load('w.mat')
for r=1:population_count
    Response_Time=0;
    Availability=1;
    Throughput=0;
    Successability=1;
    Reliability=1;
    Compliance=1;
    Best_Practices=1;
    Latency=0;
    Documentation=1;
    
    for c=1:service_count
        Response_Time=Response_Time+datasetnormal(generation(r,c),1);
        Availability=Availability*datasetnormal(generation(r,c),2);
        Throughput=Throughput+datasetnormal(generation(r,c),3);
        Successability=Successability*datasetnormal(generation(r,c),4);
        Reliability=Reliability*datasetnormal(generation(r,c),5);
        Compliance=Compliance*datasetnormal(generation(r,c),6);
        Best_Practices=Best_Practices*datasetnormal(generation(r,c),7);
        Latency=Latency+datasetnormal(generation(r,c),8);
        Documentation=Documentation*datasetnormal(generation(r,c),9);
        
    end
    generation(r,service_count+1)=w(1)*Response_Time+w(2)*Availability+w(3)*Throughput+w(4)*Successability+w(5)*Reliability+w(6)*Compliance+w(7)*Best_Practices+w(8)*Latency+w(9)*Documentation;
end
generation=sortrows(generation,[-(service_count+1)]);


end


% function [ generation ] = fitness( generation,population_count,service_count )
% %UNTITLED3 Summary of this function goes here
% %   Detailed explanation goes here
% 
% load('dataset.mat')
% load('w.mat')
% 
% datasetmax(1:9)=0;
% datasetmin(1:9)=0;
% for q=1:service_count
%     datasetmax(1,q)=max(dataset(:,q));
%     datasetmin(1,q)=min(dataset(:,q));
% end
% generation(1:population_count,service_count+1)=0;
% for r=1:population_count
%     qws(1:9)=1;
%     
%     qws(1)=0;qws(3)=0;qws(8)=0;
%    
%     for q=1:9
%         
%         if (q==1 ||q==3||  q==8)
%             for c=1:service_count
%                 qws(q)=qws(q)+dataset(generation(r,c),q);
%             end
%         else
%             for c=1:service_count
%                 qws(q)=qws(q)*dataset(generation(r,c),q);
%             end
%             
%         end
%         if (q==1 ||  q==8)
%             
%             qws(q)= w(q)*((datasetmax(1,q)-qws(q))/datasetmax(1,q)-datasetmin(1,q));
%         else
%             qws(q)=w(q)*(( qws(q)-datasetmin(1,q))/datasetmax(1,q)-datasetmin(1,q));
%         end
%         generation(r,service_count+1)=generation(r,service_count+1)+qws(q);
%     end
% end
% generation=sortrows(generation,[-(service_count+1)]);
% end
% 
% 


