'use strict';

angular.module('graphqapp')
	.controller('convertController', ['$scope', 'Convert', '$modal', 'Utils', function($scope, Convert, $modal, Utils) {

		var init = function() {
			$scope.url = url;
			$scope.duration = 2;
			$scope.error = '';
			$scope.output = '';

			$scope.completed = true;
		};

		$scope.startConvert = function() {
			$scope.completed = false;
			$scope.output = '';
			$scope.error = '';

			Convert.convert({
				url: $scope.url,
				duration: $scope.duration
			}).$promise
				.then(function(result) {
					$scope.completed = true;
					$scope.output = result.url;
				}, function(err) {
					$scope.completed = true;
					$scope.error = 'Error occured. Please check whether the URL exists.';
				});
		};

		init();
	}]);