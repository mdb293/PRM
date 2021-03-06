% This script goes through the data, subject-by-subject, and analyzes them. 
% This analyzes the data in a data structure form by default, but you can
% change it to analyze the cell array or other data if you have it

clear;
close all;

% Create a path to the text file with all the subjects
path='subjects.txt';
% Make an ID for the subject list file
subjectListFileId=fopen(path);
% Read in the number from the subject list
numberOfSubjects = fscanf(subjectListFileId,'%d');

%How many real trials. Throw out particpants who have fewer
numTrials=120;

% Cell array that stores the struct for each worker as an element
AllWorkers={};

%keep track of subjects who meet inclusion criteria (referred to by number)
goodSubjects=[];
%keep track of subjects who should get bonuses (Subject ID)
toBonusWorkerId={};
toBonusAssignmentId={};

%Arrays to store statistics on each subject
%for practice
numPractice=zeros(1,numberOfSubjects);

%for detection task
hitRatesDet=zeros(1,numberOfSubjects);
hitRatesCongDet=zeros(1,numberOfSubjects);
hitRatesCongDet1=zeros(1,numberOfSubjects);
hitRatesCongDet2=zeros(1,numberOfSubjects);
hitRatesInCongDet=zeros(1,numberOfSubjects);
hitRatesInCongDet1=zeros(1,numberOfSubjects);
hitRatesInCongDet2=zeros(1,numberOfSubjects);
faRatesDet=zeros(1,numberOfSubjects);
faRatesCongDet=zeros(1,numberOfSubjects);
faRatesCongDet1=zeros(1,numberOfSubjects);
faRatesCongDet2=zeros(1,numberOfSubjects);
faRatesInCongDet=zeros(1,numberOfSubjects);
faRatesInCongDet1=zeros(1,numberOfSubjects);
faRatesInCongDet2=zeros(1,numberOfSubjects);
dPDet=zeros(1,numberOfSubjects);
dPCongDet=zeros(1,numberOfSubjects);
dPInCongDet=zeros(1,numberOfSubjects);
cDet=zeros(1,numberOfSubjects);
cCongDet=zeros(1,numberOfSubjects);
cInCongDet=zeros(1,numberOfSubjects);

%for memory task
hitRatesMem=zeros(1,numberOfSubjects);
hitRatesCongMem=zeros(1,numberOfSubjects);
hitRatesCongMem1=zeros(1,numberOfSubjects);
hitRatesCongMem2=zeros(1,numberOfSubjects);
hitRatesInCongMem=zeros(1,numberOfSubjects);
hitRatesInCongMem1=zeros(1,numberOfSubjects);
hitRatesInCongMem2=zeros(1,numberOfSubjects);
faRatesMem=zeros(1,numberOfSubjects);
faRatesCongMem=zeros(1,numberOfSubjects);
faRatesCongMem1=zeros(1,numberOfSubjects);
faRatesCongMem2=zeros(1,numberOfSubjects);
faRatesInCongMem=zeros(1,numberOfSubjects);
faRatesInCongMem1=zeros(1,numberOfSubjects);
faRatesInCongMem2=zeros(1,numberOfSubjects);
dPMem=zeros(1,numberOfSubjects);
dPCongMem=zeros(1,numberOfSubjects);
dPInCongMem=zeros(1,numberOfSubjects);
metadPMem=zeros(1,numberOfSubjects);
cMem=zeros(1,numberOfSubjects);
cCongMem=zeros(1,numberOfSubjects);
cInCongMem=zeros(1,numberOfSubjects);

%correct rate on mem task when coherence is during delay
correctRateCong=zeros(1,numberOfSubjects);
correctRateInCong=zeros(1,numberOfSubjects);


% For loop that loops through all the subjects
for i = 1:numberOfSubjects
    
    % Read the subject ID from the file, stop after each line
    subjectId = fscanf(subjectListFileId,'%s',[1 1]);
    % Print out the subject ID
    disp(['Subject ' num2str(i)]);
    fprintf('subject: %s\n',subjectId);
    
    % Import the data
    Alldata = load([pwd '/Data/structure_data_' subjectId '.mat']);
    % Data structure that contains all the data for this subject
    d = Alldata.data;
    AllWorkers{i}=d;
    
    %how much practice she did
     %numPractice(i)=length(returnIndicesIntersect(d.practice, 1, d.descriptive_trial_type, 'rdk4'));
%     disp(['Number of rounds of practice ' num2str(numPrac)])
    
    
    %graphing separate staircases for different congruence conditions
    %seperately
    %toPlotCongDet = graphStaircase(d,'rdk3','coherence', 1,i);
    %toPlotInCongDet = graphStaircase(d,'rdk3','coherence', 0,i);

    
 
% %   
    
       index=returnIndices(d.descriptive_trial_type,'qcoh');
       index=index(end+1-numTrials:end);
       %copying remember data
       d.remember(index)=d.remember(index-5);
       [hitRatesDet(i), hitRatesCongDet(i), hitRatesCongDet1(i), hitRatesCongDet2(i), hitRatesInCongDet(i), hitRatesInCongDet1(i), hitRatesInCongDet2(i), faRatesDet(i), faRatesCongDet(i), faRatesCongDet1(i), faRatesCongDet2(i), faRatesInCongDet(i), faRatesInCongDet1(i), faRatesInCongDet2(i), dPDet(i), dPCongDet(i), dPInCongDet(i), cDet(i), cCongDet(i), cInCongDet(i)] = sdAnalyze(d,index,'y','n',false);

%     %turning to AB part
%      disp('AB task')
      
      %graphing individual staircases
      %toPlotCongMem = graphStaircase(d,'rdk4','angle', 1,i);
      %toPlotInCongMem = graphStaircase(d,'rdk4','angle', 0,i);
     
     id= returnIndicesIntersect(d.descriptive_trial_type, 'rdk4', d.practice, 0);%looking at rdk4 now
     %only use last 120 entries
     id=id(end+1-numTrials:end);

     idConf=returnIndicesIntersect(d.descriptive_trial_type, 'qconf', d.practice, 0);
     idConf=idConf(end+1-numTrials:end);
     %copying correct and correct_response to conf
     d.correct(idConf)=d.correct(id);
     d.correct_response(idConf)=d.correct_response(id);
     %copying remember data
     d.remember(id)=d.remember(id-7);
     [hitRatesMem(i), hitRatesCongMem(i), hitRatesCongMem1(i), hitRatesCongMem2(i), hitRatesInCongMem(i), hitRatesInCongMem1(i), hitRatesInCongMem2(i), faRatesMem(i), faRatesCongMem(i), faRatesCongMem1(i), faRatesCongMem2(i), faRatesInCongMem(i), faRatesInCongMem1(i), faRatesInCongMem2(i), dPMem(i), dPCongMem(i), dPInCongMem(i), cMem(i), cCongMem(i), cInCongMem(i), metadPMem(i) ] = sdAnalyze(d,id,'a','b',true,idConf,2);
     
     %looking for differences in correct rates on memory task when no
     %coherent motion during delay
     [correctRateCong(i), correctRateInCong(i)] = correctRateMem(d);

     
     %who to bonus?
     
     assignmentId=d.assignmentId{1};
     if i==1
         toBonusWorkerId{i}=subjectId;
         toBonusAssignmentId{i}=assignmentId;
     elseif isBetterThan(metadPMem(i),metadPMem(i-1))
         toBonusWorkerId{end+1}=subjectId;   
         toBonusAssignmentId{end+1}=assignmentId;
     end

     
     %Keep track of subjects who meet inclusion criteria
     %if hitRatesDet(i) > 0.6 && faRatesDet(i) < 0.4 && hitRatesDet(i) < 0.9 && hitRatesMem(i) > 0.6 && faRatesMem(i) < 0.4
     if hitRatesDet(i) > 0.6 && faRatesDet(i)>0.05 && faRatesDet(i)<0.4 &&  hitRatesMem(i) > 0.6 && hitRatesMem(i)<0.9 && faRatesMem(i) < 0.4
        goodSubjects(end+1)=i;
     end
     
end % End of for loop that loops through each subject



% calculate average statistics
% detection task
avgHitRatesDet=mean(hitRatesDet(goodSubjects));
avgHitRatesCongDet=mean(hitRatesCongDet(goodSubjects));
avgHitRatesCongDet1=mean(hitRatesCongDet1(goodSubjects));
avgHitRatesCongDet2=mean(hitRatesCongDet2(goodSubjects));
avgHitRatesInCongDet=mean(hitRatesInCongDet(goodSubjects));
avgHitRatesInCongDet1=mean(hitRatesInCongDet1(goodSubjects));
avgHitRatesInCongDet2=mean(hitRatesInCongDet2(goodSubjects));
avgFaRatesDet=mean(faRatesDet(goodSubjects));
avgFaRatesCongDet=mean(faRatesCongDet(goodSubjects));
avgFaRatesCongDet1=mean(faRatesCongDet(goodSubjects));
avgFaRatesCongDet2=mean(faRatesCongDet(goodSubjects));
avgFaRatesInCongDet=mean(faRatesInCongDet(goodSubjects));
avgFaRatesInCongDet1=mean(faRatesInCongDet(goodSubjects));
avgFaRatesInCongDet2=mean(faRatesInCongDet(goodSubjects));

%getting rid of infinities
dPDet(dPDet==Inf)=NaN;
dPCongDet(dPCongDet==Inf)=NaN;
dPInCongDet(dPInCongDet==Inf)=NaN;
avgDPDet=nanmean(dPDet(goodSubjects));
avgDPCongDet=nanmean(dPCongDet(goodSubjects));
avgDPInCongDet=nanmean(dPInCongDet(goodSubjects));

%t-tests
[~,pHit]=ttest(hitRatesCongDet(goodSubjects),hitRatesInCongDet(goodSubjects));
[~,pFA]=ttest(faRatesCongDet(goodSubjects),faRatesInCongDet(goodSubjects));
[~,pHit2]=ttest(faRatesCongDet2(goodSubjects),faRatesInCongDet(goodSubjects));


% memory task
avgHitRatesMem=mean(hitRatesMem(goodSubjects));
avgHitRatesCongMem=mean(hitRatesCongMem(goodSubjects));
avgHitRatesInCongMem=mean(hitRatesInCongMem(goodSubjects));
avgFaRatesMem=mean(faRatesMem(goodSubjects));
avgFaRatesCongMem=mean(faRatesCongMem(goodSubjects));
avgFaRatesInCongMem=mean(faRatesInCongMem(goodSubjects));

dPMem(dPMem==Inf)=NaN;
dPCongMem(dPCongMem==Inf)=NaN;
dPInCongMem(dPInCongMem==Inf)=NaN;
avgDPMem=nanmean(dPMem(goodSubjects));
avgDPCongMem=nanmean(dPCongMem(goodSubjects));
avgDPInCongMem=nanmean(dPInCongMem(goodSubjects));
avgMetadPMem=nanmean(metadPMem(goodSubjects));

%graph staircases averaged
forStaircase=cell([1,length(goodSubjects)]);
for i=1:length(goodSubjects)
    forStaircase{i}=AllWorkers{i};
end
%for detection task
%graphAveStaircase(forStaircase,'rdk3');
%graphAveStaircaseOld(forStaircase,'rdk3');


%for memory task
graphAveStaircase(forStaircase,'rdk4');

%for memory task congruent condition
%graphAveStaircase(forStaircase,'rdk4','angle',1);
%for memory task incongruent condition
%graphAveStaircase(forStaircase,'rdk4','angle',0);

%Write data to output file
fileID = fopen('Results.txt','w');
fprintf(fileID, 'Results\n\n');

fprintf(fileID,'Total number of subjects: %i\n',numberOfSubjects);
fprintf(fileID,'Number of subjects who meet inclusion criteria: %i\n\n',length(goodSubjects));

%Detection task results
fprintf(fileID, 'Detection task results \n');
fprintf(fileID,'Mean Hit Rate: %f\n',avgHitRatesDet);
fprintf(fileID,'Mean Hit Rate Congruent: %f\n',avgHitRatesCongDet);
fprintf(fileID,'Mean Hit Rate Congruent Remember 1: %f\n',avgHitRatesCongDet1);
fprintf(fileID,'Mean Hit Rate Congruent Remember 2: %f\n',avgHitRatesCongDet2);
fprintf(fileID,'Mean Hit Rate Incongruent: %f\n',avgHitRatesInCongDet);
fprintf(fileID,'Mean Hit Rate Incongruent Remember 1: %f\n',avgHitRatesInCongDet1);
fprintf(fileID,'Mean Hit Rate Incongruent Remember 2: %f\n',avgHitRatesInCongDet2);
fprintf(fileID,'Mean False Alarm Rate: %f\n',avgFaRatesDet);
fprintf(fileID,'Mean False Alarm Rate Congruent: %f\n',avgFaRatesCongDet);
fprintf(fileID,'Mean False Alarm Rate Congruent Remember 1: %f\n',avgFaRatesCongDet1);
fprintf(fileID,'Mean False Alarm Rate Congruent Remember 2: %f\n',avgFaRatesCongDet2);
fprintf(fileID,'Mean False Alarm Rate Incongruent: %f\n',avgFaRatesInCongDet);
fprintf(fileID,'Mean D-Prime: %f\n',avgDPDet);
fprintf(fileID,'Mean D-Prime Congruent: %f\n',avgDPCongDet);
fprintf(fileID,'Mean D-Prime Incongruent: %f\n',avgDPInCongDet);
fprintf(fileID,'P-value for Paired T-test on Hit Rate (Congruent vs Incongruent): %f\n',pHit);
fprintf(fileID,'P-value for Paired T-test on Hit Rate (Congruent Remember 2 vs Incongruent): %f\n',pHit2);
fprintf(fileID,'P-value for Paired T-test on False Alarm Rate: %f\n\n',pFA);

%Memory task results
fprintf(fileID, 'Memory task results \n');
fprintf(fileID,'Mean Hit Rate: %f\n',avgHitRatesMem);
fprintf(fileID,'Mean Hit Rate Congruent: %f\n',avgHitRatesCongMem);
fprintf(fileID,'Mean Hit Rate Incongruent: %f\n',avgHitRatesInCongMem);
fprintf(fileID,'Mean False Alarm Rate: %f\n',avgFaRatesMem);
fprintf(fileID,'Mean False Alarm Rate Congruent: %f\n',avgFaRatesCongMem);
fprintf(fileID,'Mean False Alarm Rate Incongruent: %f\n',avgFaRatesInCongMem);
fprintf(fileID,'Mean D-Prime: %f\n',avgDPMem);
fprintf(fileID,'Mean D-Prime Congruent: %f\n',avgDPCongMem);
fprintf(fileID,'Mean D-Prime Incongruent: %f\n',avgDPInCongMem);
fprintf(fileID,'Mean Meta-D-Prime: %f\n',avgMetadPMem);


fclose(fileID);

%for bonusing purposes
fileID2 = fopen('Bonusing.txt','w');
fprintf(fileID2, 'WorkerID,AssignmentID \n');
for i=1:length(toBonusAssignmentId)
    fprintf(fileID2,'%s,%s\n',toBonusWorkerId{i},toBonusAssignmentId{i});
end
fclose(fileID2);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Your analysis here %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%grouped bar plot of mean hit rates and mean FA rates by condition
y = [avgHitRatesCongDet avgHitRatesInCongDet;avgFaRatesCongDet avgFaRatesInCongDet];
err = [std(hitRatesCongDet(goodSubjects)) std(hitRatesInCongDet(goodSubjects)); std(faRatesCongDet(goodSubjects)) std(faRatesInCongDet(goodSubjects))]/sqrt(length(goodSubjects));

figure;
hold on;

[hBar] = barwitherr(err,y);
xlabel("Hit Rates                                                   False Alarm Rates")
legend('Congruent','Incongruent')
set(gca,'XTick',[])
title(['Mean Hit and False Alarm Rates by Congruence Condition, n=' num2str(length(goodSubjects))])
hold off;


%look at difference in false alarm rates congruent and incongruent trials and
%see if it correlates with meta-d'
congruencyEffects=faRatesCongDet-faRatesInCongDet;

%look at difference in criteria bias c on congruent and incongruent trials and
%see if it correlates with meta-d'
congruencyEffects=cCongDet-cInCongDet;

betterSubjects=goodSubjects(metadPMem(goodSubjects)>0);

%metadP
[r,p]=corrcoef(congruencyEffects(goodSubjects),metadPMem(goodSubjects),'Rows','complete');
%log(metadP/d')
graphCongruencyEffect(congruencyEffects(betterSubjects),log(metadPMem(betterSubjects)./dPMem(betterSubjects)));

forCorr=betterSubjects(~isinf(congruencyEffects(betterSubjects)));
[r2,p]=corrcoef(congruencyEffects(forCorr),log(metadPMem(forCorr)./dPMem(forCorr)),'Rows','complete');



