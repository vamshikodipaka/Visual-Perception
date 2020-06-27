%% MAIN FILE: RUN IT TO OBSERVE THE OUTPUT
% This file contains all the three projects and corresponding results are 
% displayed in command window and plotted accordingly

clc; clear all; close all;

%% project I

% Given data to train the network
training_data1 = [1 1 0 0; 1 0 0 0;0 0 0 1; 0 0 1 1];       % 4X4 matrix

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
%after running this section we get weights 650X2 matrix

% test the network with given test data
testing_data1 = [0 0 0 0.9; 0 0 0.8 0.9;0.7 0 0 0; 0.7 0.9 0 0];  %4X4 matrix
kohonen_test( testing_data1, weights, project_num ); 

%% Project II

% data to train the network
training_data2 = load('./control.txt');               % 20X650 matrix of patient data
training_data2 = [training_data2; load('./patient.txt')]; % 20X650 matrix of control data

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
% after running this project we get weight vector of 650X2

%% Project III

% test the network with given test_six_vamshi.txt test data
testing_data2 = load('./test_six_vamshi.txt');    % 4X650 matrix  test
disp('***********************************************************');
disp('Project III results :');
kohonen_test( testing_data2, weights, project_num, cluster_control );
disp('***********************************************************');

%% this part of code is to visualize the weights and data as histograms
figure(3)
subplot(2,3,1)
bar(weights(:,1))           % 650 X 2 matrix weights
title('weights cluster 1') 

%plot test data2 first row all columns
subplot(2,3,2)
bar(testing_data2(1,:))     % 4X650 matrix test data
title('data1');
ylabel('data');
xlabel('iter');

%plot test data2 second row all columns
subplot(2,3,3)
bar(testing_data2(2,:))
title('data2');

subplot(2,3,4)
bar(weights(:,2))
title('weights cluster 2')

%plot test data2 third row all columns
subplot(2,3,5)
bar(testing_data2(3,:))
title('data3');

%plot test data2 fourth row all columns
subplot(2,3,6)
bar(testing_data2(4,:))
title('data4');