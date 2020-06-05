function [weights, cluster_control] = kohonen_train( training_data, learning_rate, project_num )
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %kohonen_training function is used to train the network with the given data
% %   It calculates the synaptic weights depending on the train data
% %   with a given learning rate and following a exp decay learning rate
%
% INPUTS:
%     train_data          data to train the network
%     learn_rate          initial learn rate
%     proj_num            This variable is only to print proper cluster
%                         for project type and not related to algorithm
% OUTPUTS:
%     weights             Synaptic weights after convergence
%     clu_control         this output is to know which cluster is control/patient
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example
% training_data = [1 1 0 0; 0 0 0 1;1 0 0 0; 0 0 1 1];
% learning_rate = 0.9;
% weights = kohonen_train( training_data, learning_rate, 1 );

%% definig  variables required for training
%to make two clusters of training data
cluster = 2;

%learning rate
alpha = learning_rate;

%intial random synaptic weights between (0,1)
weights = rand(size(training_data,2),cluster);

% these variable used to calculate convergence error
weights1 = [];
j=2;

%number of cycles of training
n_iter = 100;

%% start of training
for i = 1:1:n_iter
    for nsub = 1:size(training_data,1)
        
        % to calculate distnaces of node and data
        distance1 = norm(training_data(nsub,:)-weights(:,1)')^2;
        distance2 = norm(training_data(nsub,:)-weights(:,2)')^2;
        
        % to claculate nearest node and update weights accordingly
        if distance1 < distance2
            weights(:,1) = weights(:,1) + alpha*(training_data(nsub,:)' - weights(:,1));
            if nsub == 1
                cluster_control = 1;
            end
        else
            weights(:,2) = weights(:,2) + alpha*(training_data(nsub,:)' - weights(:,2));
            if nsub == 1
                cluster_control = 2;
            end
        end
    end
    
    %to exponential decay learning rate in cycles of training
    alpha = alpha * exp(-i/n_iter);
    
    %% this part of code is to calculate the convergence error
    %and if error is less than certain threshold training cycles stops
    weights1 = [weights1 weights];
    if i ~= 1
       
        %to claculate convergence error
        error =  sum(sum(weights1(:,j-1:j) - weights1(:,j+1:j+2))); 
        
        % this part of code is to change the figure for two projects
        figure(project_num)
        
        %to plot the error vs iterations
        scatter(i-1,error,'b*')
        xlabel('iterations'),ylabel('weight convergence error')
        title(['weight convergence of project ',num2str(project_num)]);
        hold on;
        pause(1e-6);
        j = j + 2;
        
        %to check if error is less than a selected low threshold
        if error < 1e-35
            disp(['Synaptic weights converged after ',num2str(i),' iterations']);
            if project_num == 1
                disp(['The synaptic weights after convergence is',10]);
                disp(weights);
            end
            break;
        end
    end
end



end

