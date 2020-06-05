%% MAIN FILE: RUN IT TO OBSERVE THE OUTPUT
% This file contains all the three projects and corresponding results are 
% displayed in command window and plotted accordingly

clc; clear all; close all;

%% project I

% Given data to train the network
training_data1 = [1 1 0 0; 1 0 0 0;0 0 0 1; 0 0 1 1];

% settingg intital learning rate 
learning_rate = 0.6;

% Here to print appropriate cluster data
project_num = 1;

% train the network and calculation of weights
% the convergence of weights as a function of number of iterations is
% plotted and the results of converged weights are shown in command window
disp('*****************************************************************');
disp('Results for Project I:');
weights = kohonen_train( training_data1, learning_rate, project_num );

% test the network with given test data
testing_data1 = [0 0 0 0.9; 0 0 0.8 0.9;0.7 0 0 0; 0.7 0.9 0 0];
kohonen_test( testing_data1, weights, project_num );

%% Project II

% data to train the network
training_data2 = load('./control.txt');
training_data2 = [training_data2; load('./patient.txt')];

% intital learning rate
learning_rate = 0.6;

% to print appropriate cluster data
project_num = 2;

% train the network and calculation of weights
% the convergence of weights as a function of number of iterations is
% plotted and the results of converged weights are shown in command window
disp('************************************************************');
disp('Project II results :');
[weights,cluster_control] = kohonen_train( training_data2, learning_rate, project_num );

%% Project III

% test the network with given test_six_vamshi.txt test data
testing_data2 = load('./test_six_vamshi.txt');
disp('***********************************************************');
disp('Project III results :');
kohonen_test( testing_data2, weights, project_num, cluster_control );
disp('***********************************************************');

%% this part of code is to visualize the weights and data as histograms
figure(3)
subplot(2,3,1)
bar(weights(:,1))
title('weights cluster 1')

subplot(2,3,2)
bar(testing_data2(1,:))
title('data1');
ylabel('data');
xlabel('iter');

subplot(2,3,3)
bar(testing_data2(2,:))
title('data2');

subplot(2,3,4)
bar(weights(:,2))
title('weights cluster 2')

subplot(2,3,5)
bar(testing_data2(3,:))
title('data3');

subplot(2,3,6)
bar(testing_data2(4,:))
title('data4');