% A simple hands-on tutorial
% Browse the code to get the basics of how-to utilize this VMM tool
clc
clear all

global T

verbose = 0;
m = 0;
k =18; % smoothing factor
delay = 0; %starting point delay in coding


for T = 2;
    m = m + 1;
    n = 0;
    for ds = 18;
        n = n + 1;
        epis = 1; % FF = 1, SF = 2, RE = 3;
        [seqTD, seqASD]=readDataSeqKdx(ds, T, epis, k, delay);
        
        createParams;
        
        % use AB with size = 5
        disp('---------------------------------------------------');
        if (verbose == 1), disp('working with AB={A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P }'); end
        disp('---------------------------------------------------');
        s = 3;
        % 3. run each of the VMM algorithms
        %%the name of the VMM algorithm; one of the followings: {'LZms', 'LZ78', 'PPMC', 'DCTW', 'BinaryCTW', 'PST'}
        if (verbose == 1), disp(sprintf('Working with %s', 'PPMC' )); end
        %     disp('--------')
        
        jVmmTD_full = vmm_createNew(map(ab, seqTD),  ALGS{s}, paramsTD);
        
%         for ()
        
        disp(sprintf('Pr(A | A) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'A'))));
        disp(sprintf('Pr(B | A) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'A'))));
        disp(sprintf('Pr(C | A) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'A'))));
        disp(sprintf('Pr(D | A) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'A'))));
        disp(sprintf('Pr(A | B) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'B'))));
        disp(sprintf('Pr(B | B) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'B'))));
        disp(sprintf('Pr(C | B) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'B'))));
        disp(sprintf('Pr(D | B) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'B'))));
        disp(sprintf('Pr(A | C) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'C'))));
        disp(sprintf('Pr(B | C) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'C'))));
        disp(sprintf('Pr(C | C) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'C'))));
        disp(sprintf('Pr(D | C) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'C'))));
        disp(sprintf('Pr(A | D) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'D'))));
        disp(sprintf('Pr(B | D) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'D'))));
        disp(sprintf('Pr(C | D) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'D'))));
        disp(sprintf('Pr(D | D) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'D'))));

                
        disp(sprintf('Pr(A | AA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'AA'))));
        disp(sprintf('Pr(B | AA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'AA'))));
        disp(sprintf('Pr(C | AA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'AA'))));
        disp(sprintf('Pr(D | AA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'AA'))));
        disp(sprintf('Pr(A | AB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'AB'))));
        disp(sprintf('Pr(B | AB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'AB'))));
        disp(sprintf('Pr(C | AB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'AB'))));
        disp(sprintf('Pr(D | AB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'AB'))));
        disp(sprintf('Pr(A | AC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'AC'))));
        disp(sprintf('Pr(B | AC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'AC'))));
        disp(sprintf('Pr(C | AC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'AC'))));
        disp(sprintf('Pr(D | AC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'AC'))));
        disp(sprintf('Pr(A | AD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'AD'))));
        disp(sprintf('Pr(B | AD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'AD'))));
        disp(sprintf('Pr(C | AD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'AD'))));
        disp(sprintf('Pr(D | AD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'AD'))));
        disp(sprintf('Pr(A | BA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'BA'))));
        disp(sprintf('Pr(B | BA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'BA'))));
        disp(sprintf('Pr(C | BA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'BA'))));
        disp(sprintf('Pr(D | BA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'BA'))));
        disp(sprintf('Pr(A | BB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'BB'))));
        disp(sprintf('Pr(B | BB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'BB'))));
        disp(sprintf('Pr(C | BB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'BB'))));
        disp(sprintf('Pr(D | BB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'BB'))));
        disp(sprintf('Pr(A | BC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'BC'))));
        disp(sprintf('Pr(B | BC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'BC'))));
        disp(sprintf('Pr(C | BC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'BC'))));
        disp(sprintf('Pr(D | BC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'BC'))));
        disp(sprintf('Pr(A | BD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'BD'))));
        disp(sprintf('Pr(B | BD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'BD'))));
        disp(sprintf('Pr(C | BD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'BD'))));
        disp(sprintf('Pr(D | BD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'BD'))));
        disp(sprintf('Pr(A | CA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'CA'))));
        disp(sprintf('Pr(B | CA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'CA'))));      
        disp(sprintf('Pr(C | CA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'CA'))));
        disp(sprintf('Pr(D | CA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'CA'))));
        disp(sprintf('Pr(A | CB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'CB'))));
        disp(sprintf('Pr(B | CB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'CB'))));
        disp(sprintf('Pr(C | CB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'CB'))));
        disp(sprintf('Pr(D | CB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'CB'))));
        disp(sprintf('Pr(A | CC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'CC'))));
        disp(sprintf('Pr(B | CC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'CC'))));
        disp(sprintf('Pr(C | CC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'CC'))));
        disp(sprintf('Pr(D | CC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'CC'))));
        disp(sprintf('Pr(A | CD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'CD'))));
        disp(sprintf('Pr(B | CD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'CD'))));    
        disp(sprintf('Pr(C | CD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'CD'))));
        disp(sprintf('Pr(D | CD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'CD'))));
        disp(sprintf('Pr(A | DA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'DA'))));
        disp(sprintf('Pr(B | DA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'DA'))));
        disp(sprintf('Pr(C | DA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'DA'))));
        disp(sprintf('Pr(D | DA) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'DA'))));
        disp(sprintf('Pr(A | DB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'DB'))));
        disp(sprintf('Pr(B | DB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'DB'))));
        disp(sprintf('Pr(C | DB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'DB'))));
        disp(sprintf('Pr(D | DB) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'DB'))));
        disp(sprintf('Pr(A | DC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'DC'))));
        disp(sprintf('Pr(B | DC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'DC'))));
        disp(sprintf('Pr(C | DC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'DC'))));
        disp(sprintf('Pr(D | DC) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'DC'))));
        disp(sprintf('Pr(A | DD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'A'), mapS(ab,'DD'))));
        disp(sprintf('Pr(B | DD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'B'), mapS(ab,'DD'))));    
        disp(sprintf('Pr(C | DD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'C'), mapS(ab,'DD'))));
        disp(sprintf('Pr(D | DD) = %f', vmm_getPr(jVmmTD_full, mapS(ab,'D'), mapS(ab,'DD'))));
   
    end
end