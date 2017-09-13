clear all
format short
load('dataset.mat')
datasetmax(1:9)=0;
datasetmin(1:9)=0;
for c=1:9
    datasetmax(1,c)=max(dataset(:,c));
    datasetmin(1,c)=min(dataset(:,c));
  	p=datasetmax(1,c)-datasetmin(1,c);
    if (c==1 ||  c==8)
    for r=1:2507
                 datasetnormal(r,c)= (datasetmax(1,c)-dataset(r,c))/p;
    end
    else
       for r=1:2507
                datasetnormal(r,c)= (dataset(r,c)-datasetmin(1,c))/p;
       end

    end
end
datasetnormal(1:2507,10)=sum(datasetnormal,2);

tic
a=3;
root_count=10;
service_count=10;
act_root=1;
chicken_count=a*a*root_count;
hen_count=a*root_count;
population_count=root_count+hen_count+chicken_count;
generation(population_count,service_count+1)=0;
execution_count=500;
generation = randi(2057,population_count,service_count);
generation=fitness( generation,population_count,service_count );
best_fit(execution_count)=0;
for f=1:execution_count
    %root
    for i=1:act_root
        select_column=randi(service_count);
        generation(randi([root_count,hen_count]),1:select_column)=generation(randi(root_count),1:select_column);
        select_column=randi(service_count);
        generation(randi([root_count,hen_count]),select_column:service_count)=generation(randi(root_count),select_column:service_count);
    end
    %     hens
    for i=1:root_count
        for r=1:a
            count=0;
            b=0;
            while count<(service_count/10) && b<=service_count
                c=randi(service_count);
                if generation(r+root_count+((i-1)*a),c)~=generation(i,c)
                    generation(r+root_count+((i-1)*a),c)=generation(i,c);
                    count=count+1;
                else
                    b=b+1;
                end
            end
        end
    end
    %  chicken
    for i=1:hen_count
        for r=1:a
            for c=1:service_count/10
                select=randi(service_count);
                generation(root_count+hen_count+r+((i-1)*a),select)=generation(root_count+i,select);
            end
            for c=1:service_count/10
                if generation(root_count+hen_count+r+((i-1)*a),c)~=generation(root_count+i,c)
                    generation(root_count+hen_count+r+((i-1)*a),c)=randi(2507);
                end
            end
        end
        for ra=1:ceil(service_count/10)
            generation(root_count+hen_count+randi(population_count-(root_count+hen_count)),randi(service_count))=randi(2507);
            
        end
    end
    
    generation=  fitness( generation,population_count,service_count );
    best_fit(f)=generation(1,service_count+1);
end

toc
generation(1,service_count+1)

beep