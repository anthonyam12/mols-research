function BothOps (B, rep_number)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%permutes the symbols of a latin square from an isotopy group
% to generate all normalized ltin squares.

% UPDATE AS OF 9-1-14:
% This function takes in an isotopy class representative of order five,
% applies both operations, and prints the result to a file. To make this
% order 6 a few tweaks will need to be made. The script eq_ls.m must be run
% to weed out repeats of Latin squares. The documentation in eq_ls.m is
% decent so it shouldn't be too hard to use.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%open file containing permutation of order 4
fid = fopen ( 'S6.dat' );

%read in number of permutations
n = fscanf(fid, '%u',1);

%open file for writing
filename = strcat('isotopyclass',int2str(rep_number));
filename = strcat(filename,'.dat');

fid2 = fopen(filename, 'w');

m=n;
i = 0;
while ( i < factorial(n) )
    A = B;
    %read in permutation
    sigma = fscanf ( fid, '%u', n);
    for j=1:m
        for k=1:n
            x = A(j,k);
            if x == 1
                A(j,k) = sigma(1);
            elseif x == 2
                A(j,k) = sigma(2);
            elseif x == 3
                A(j,k) = sigma(3);
            elseif x == 4
                A(j,k) = sigma(4);
            elseif x == 5 
                A(j,k) = sigma(5);
            else
                A(j,k) = sigma(6);
            end
        end
    end
    C = normalize_ls_6(A);
    
    %get squares created from permuting rows and columns of C
    D = getSquares(C);
       
    [z12,z13,z14] = size(D);
    
    for i_last=1:z14
        C = D(:,:,i_last);
        %print out latin square
        fprintf(fid2, '%u %u %u %u %u %u ', C);
        fprintf(fid2, '\n');
    end
    
    i = i+1;
end

fclose(fid);
fclose(fid2);