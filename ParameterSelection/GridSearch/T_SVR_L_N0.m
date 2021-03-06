%% Cross-validation of SVR with linear kernel
LoadData

Result=zeros(60,20);
% A list of alternative C
SelectC=[0.05,1.25,31.25,60,100,156.25];

for k=1:6  %variable
    for i=0:6 %number of interval
        for j=1:6 % different C
            CValue=SelectC(j);
            eval(['x=TrainingDataset_',num2str(i),';',]);
            [x,mux,sigmax]=zscore(x);
            t=TrainingTem(:,k);
            [t,mut,sigmat]=zscore(t);
            mdl = fitrsvm(x,t,'KernelFunction','linear','KernelScale','auto','Standardize',true,'BoxConstraint',CValue,'CrossVal','on');
            
            Result((k-1)*10+j,i+10)=mdl.Trained{k,1}.KernelParameters.Scale;
            Result((k-1)*10+j,i+1)=kfoldLoss(mdl,'mode','average')     
        end
    end
end

save T_SVR_L_N0.mat Result;