'use strict';

angular.module('graphqapp')
	.directive('ngReturn', function () {
	return function (scope, element, attrs) {
		element.bind("keydown keypress", function (event) {
			if(event.which === 13) {
				scope.$apply(function (){
					scope.$eval(attrs.ngReturn);
				});

				event.preventDefault();
			}
		});
	};
})
.directive('ngInitialFocus', ['$timeout', function ($timeout) {
  return function (scope, element, attrs) {
    $timeout(function() {
      $timeout(function() {
        var $element = angular.element(element);
        $element.click();
        $element.focus();
      }, 750);
    });
  };
}])