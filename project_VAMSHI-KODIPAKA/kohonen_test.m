function kohonen_test( testing_data, weights, project_num, cluster_control )
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %kohonen_test function is used to test the given data and to identify the
% cluster
%
% INPUTS:
%     test_data           data to test the cluster
%     weights             weights calculated by kohonen_train function
%     proj_num            This variable is only to print proper cluster
%                         for project type and not related to algorithm
% OUTPUTS:
%     Identity of cluster of given test data
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example
% test_data = [0 0 0 0.9; 0 0 0.8 0.9;0.7 0 0 0; 0.7 0.9 0 0];
% weights obtained from kohonen_test function
% kohonen_test( test_data, weights, 1 )

% this part of code is to define cluster according to project
if project_num == 1
    cluster_1 = 'class I';
    cluster_2 = 'class II';
    disp(['test data 1 is ','[ ',num2str(testing_data(1,:)),' ]']);
    disp(['test data 2 is ','[ ',num2str(testing_data(2,:)),' ]']);
    disp(['test data 3 is ','[ ',num2str(testing_data(3,:)),' ]']);
    disp(['test data 4 is ','[ ',num2str(testing_data(4,:)),' ]']);
else
    %this part of code is to define which cluster is patient and control
    if cluster_control == 1
        cluster_1 = 'control';
        cluster_2 = 'patient';
    else
        cluster_1 = 'patient';
        cluster_2 = 'control';
    end
end

for nsub = 1:size(testing_data,1)
    
    % to compute euclidean distnace b/w test data and weights of training
    % network
    distance1 = norm(testing_data(nsub,:)-weights(:,1)')^2;
    distance2 = norm(testing_data(nsub,:)-weights(:,2)')^2;
    
    % to compare euclidean distnace of two clusters and decide class with
    % minimum distnace
    if distance1 < distance2
        disp(['test data ',num2str(nsub),' belongs to ',cluster_1]);
    else
        disp(['test data ',num2str(nsub),' belongs to ', cluster_2]);
    end
end

end

