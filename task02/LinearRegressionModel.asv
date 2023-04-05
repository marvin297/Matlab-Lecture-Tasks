classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model

    %------------------------------------------------------------------
    % LinearRegressionModel - a class representing an implementation of 
    % linear regression model
    %
    % LinearRegressionModel properties:
    %   optimizer: optimizer object that's used for model training
    %   trainingData: object contains the training data
    %   theta: vector of coefficients for the model
    %   thetaOptimum: vector of optimum model coefficients
    %
    % LinearRegressionModel Methods:
    %   LinearRegressionModel - instance of the class
    %   costFunction          - cost functoin calculation
    %   hypothesis            - calc hypothesis values
    %   showOptimumInContour  - display optimum value in a contour plot
    %   showCostFunctionArea  - display the cost function area in a 3-dim plot
    %   showTrainingData      - display the training data in a plot
    %   showModel             - display the trained model in a plot
    %   setTheta              - Set theta vector
    %   setThetaOptimum       - Set optimum theta vector
    %
    %------------------------------------------------------------------

    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            % perform the varargin
            for i = 1:nargin
                if strcmp(varargin{i},'Data')
                    obj.trainingData = varargin{i+1};
                elseif strcmp(varargin{i},'Optimizer')
                    obj.optimizer = varargin{i+1};  
                end
            end
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % compute the costs
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J
            J = (1/(2*m)) * sum((obj.hypothesis() - obj.trainingData.commandVar).^2);
            
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code
           hValue = X * obj.theta;
            
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            [theta0, theta1] = meshgrid(theta0_vals, theta1_vals);
            J_vals = zeros(length(theta0_vals), length(theta1_vals));
            for i = 1:length(theta0_vals)
                for j = 1:length(theta1_vals)
                    obj.setTheta(theta0(i), theta1(j));
                    J_vals(i,j) = obj.costFunction();
                end
            end
            % plot the costs with the contour command
            contour(theta0, theta1, J_vals, 20);
            
            % add x and y label
            xlabel('theta_0'); 
            ylabel('theta_1');
            title('Optimum Contour');

            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            hold on
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2)
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the surf command
            % add x and y label
            %[theta0, theta1] = meshgrid(theta0_vals, theta1_vals);
            J_vals = zeros(length(theta0_vals), length(theta1_vals));
            for i = 1:length(theta0_vals)
                for j = 1:length(theta0_vals)
                    obj.setTheta(theta0_vals(i), theta1_vals(j));
                    J_vals(i,j) = obj.costFunction();
                end
            end
            surf(theta0_vals, theta1_vals, J_vals);
            xlabel('\theta_0');
            ylabel('\theta_1');
            zlabel('Cost Function');
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % add the final trained model plot to the figure ('b-')
           hold on;
           x_values = linspace(min(obj.trainingData.feature), max(obj.trainingData.feature), 100);
           y_values = obj.thetaOptimum(1) + obj.thetaOptimum(2) * x_values;
           plot(x_values, y_values, 'b-', 'LineWidth', 2);
           % update the legend
           legend('Training Data', 'Trained Model');

        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end


