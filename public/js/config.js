'use strict';

angular.module('graphqapp')
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.otherwise({
				redirectTo: '/'
			});
	}])

	.config(['$controllerProvider', function($controllerProvider) {
		$controllerProvider.allowGlobals();
	}])

	.config(['$locationProvider', function($locationProvider) {
		$locationProvider.hashPrefix('!');
	}])

	;