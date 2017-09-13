clear all
tic
gen_count=10;
population_first=10;
population_count=130;
mutation_count=0.1;
crossover_count=(population_count-population_first-(population_count-population_first)*mutation_count)/2;
execution_count=500;
generation(:,gen_count+1)=0;
generation=randi(2507,population_first,gen_count);
generation=fitness( generation,population_first,gen_count );
best_fit(execution_count)=0;

for j=1:execution_count
    f=generation(1:population_first,gen_count+1)./sum(generation(1:population_first,gen_count+1));
    f=cumsum(f);
    last_row=population_first;
    for i=1:crossover_count
        select_father=find(rand<=f,1,'first');
        select_mother=find(rand<=f,1,'first');
        select_gen=randi(gen_count);
        last_row=last_row+1;
        generation(last_row,:)=generation(select_father,:);
        generation(last_row,select_gen:gen_count)=generation(select_mother,select_gen:gen_count);
        last_row=last_row+1;
        generation(last_row,:)=generation(select_mother,:);
        generation(last_row,select_gen:gen_count)=generation(select_father,select_gen:gen_count);
    end
    for i=1:ceil((population_count-population_first)*mutation_count)
        select_father= find(rand<=f,1,'first');
        last_row=last_row+1;
        generation(last_row,:)=generation(select_father,:);
        generation(last_row,randi(gen_count))=randi(2507);
    end
    generation=fitness( generation,population_count,gen_count );
    best_fit(j)=generation(1,gen_count+1);
end


toc
generation(1,gen_count+1)
beep