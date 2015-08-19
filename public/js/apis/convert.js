'use strict';

angular.module('graphqapp')
	.factory('Convert', ['$resource', function($resource) {
		return $resource('/convert', {
		}, {
			convert: {
				method: 'POST',
				url: '/convert'
			}
		});
	}]);