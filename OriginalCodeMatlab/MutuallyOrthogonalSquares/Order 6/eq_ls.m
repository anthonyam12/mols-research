function eq_ls (filename) %filename without extension1!!!!!!!!!!
% this function compares files of latin squares to find out which ones
%appear more than once. If the ls has not appeared it is output to another
%file.

write_file = strcat (filename,int2str(2));
write_file = strcat(write_file,'.dat');

%open file to write normalized ls to
fid2 = fopen(write_file, 'w');

filename = strcat(filename, '.dat');
fid = fopen(filename);

%read in first ls
A = fscanf(fid, '%u', [5 5]);

B(1,:,:) = A;
i = 1;
while ( ~feof(fid) )
    %read in LS
    A = fscanf(fid, '%u', [5 5]);
   
    if size(A) ~= 0
        %get size of array
        [m, n, o] = size(B);
 
        %re-initialize flag to "not in array"
        flag = 0;
    
        %loop through array and compare with current LS
        for j=1:m
            for k=1:5
                C(k,:) = B(j,k,:);
            end
       
            %if they are equal,
            if isequal(A,C)==1
                %set flag not to put in array,
                flag = 1;
                %and break from the loop
                break;
            end
           
        end
        i = i + 1
        %if the LS was not found in the array already put it into the array
        if flag == 0;
            B (m+1,:,:) = A;
        end
    end
end

%get final size of B array
[m,n,o] = size(B);

%write all LS in array B into a file
for i=1:m
    fprintf(fid2,'%u %u %u %u %u ', B(i,:,:));
    fprintf(fid2,'\n');
end

fclose('all');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%dont read in all values into an array, read in value, check if its in an array, and put it into
%the array if its not