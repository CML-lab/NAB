%make trial tables for blinded NAB

NTablePairs = 1;  %generate this many PAIRS of tables
NPracticeTables = 1;  %generate this many pairs of practice tables
Items = { [1:20]; [21:41] };  %each cell is a subgrouping of items (i.e., high vs low conflict)
PracticeItems = [41:45];
ItemDuration = 3000; %time that the item is displayed, in msec

rng('shuffle'); %reset the random number generator

%make the test trial tables
for a = 1:NTablePairs
    
    %randomly shuffle the items in the list
    i1list = randperm(length(Items{1}));
    i2list = randperm(length(Items{2}));
    
    %group the first half of the two lists and the second half of the two lists
    listA = [i1list(1:ceil(length(i1list)/2)) i2list(1:floor(length(i2list)/2))]; 
    listB = [i1list(ceil(length(i1list)/2)+1:end) i2list(floor(length(i2list)/2)+1:end)]; 

    %do the same for each pair of subjects:
    for b = 1:2
        
        %we will generate 2 versions, one with vision and one without
        %vision
        for c = 0:1
        
            if c == 0
                visstr = 'NVF';
            elseif c == 1
                visstr = 'VF';
            end
            
            %randomize the lists
            listA = listA(randperm(length(listA)));
            listB = listB(randperm(length(listA)));
                        
            %print out the lists. if c == 0, no vision; if c == 1, vision
            fid = fopen(sprintf('tbl%d-%d_list%s_%s.txt',a,b,'A',visstr),'wt');
            for d = 1:length(listA)
                fprintf(fid,'%d %d %d %d\n',c,listA(d),ItemDuration,1); %note, for "practice" flag, logic is inverted
            end
            fclose(fid);
            
            fid = fopen(sprintf('tbl%d-%d_list%s_%s.txt',a,b,'B',visstr),'wt');
            for d = 1:length(listB)
                fprintf(fid,'%d %d %d %d\n',c,listB(d),ItemDuration,1); %note, for "practice" flag, logic is inverted
            end
            fclose(fid);
        end
    end
end


        
%make the practice trial tables
for a = 1:NPracticeTables
    
    %randomly shuffle the items in the list
    listA = randperm(length(PracticeItems));
    listB = randperm(length(PracticeItems));
    
    %randomize the lists
    listA = listA(randperm(length(listA)));
    listB = listB(randperm(length(listA)));
    
    %print out the lists. if c == 0, no vision; if c == 1, vision
    fid = fopen(sprintf('practice%d_%s.txt',a,'VF'),'wt');
    for d = 1:length(listA)
        fprintf(fid,'%d %d %d %d\n',c,listA(d),ItemDuration,0); %note, for "practice" flag, logic is inverted
    end
    fclose(fid);
    
    fid = fopen(sprintf('practice%d_%s.txt',a,'NVF'),'wt');
    for d = 1:length(listB)
        fprintf(fid,'%d %d %d %d\n',c,listB(d),ItemDuration,1); %note, for "practice" flag, logic is inverted
    end
    fclose(fid);
end
        