'use strict';

angular.module('graphqapp')
	.controller('convertController', ['$scope', 'Convert', '$modal', 'Utils', function($scope, Convert, $modal, Utils) {

		var init = function() {
			$scope.url = url;
			$scope.duration = isNaN(time) ? 2 : time;
			$scope.play_graphiq = play_graphiq;
			$scope.download = download;
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