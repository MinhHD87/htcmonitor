var app = angular.module('ClientAccountApp', ['ui.bootstrap']);
app.controller('ClientAccountCtrl', function ($scope, $http, $filter) {
    $scope.reloadFilter = function (str) {
        $.blockUI({message: '<img src="' + context + '/admin/images/indicator_48.gif" />'});
        $http({
            method: "POST",
            url: urlBase + "/admin/client-account/rest/data",
            params: {crPage: $scope.crPage, maxRow: $scope.maxRow, agencycode: $scope.agencycode, username: $scope.username, number: $scope.number, status: $scope.status}
        }).then(function Succes(response) {
            if (response !== undefined && typeof response === "object") {
                $scope.result = response.data.result;
                if ($scope.result.code === nologin) {
                    location.href = context + adm_login_uri;
                } else {
                    $scope.datas = response.data.datas;
                    $scope.totalRow = response.data.totalRow;
                    $scope.roles = response.data.roles;
                    if (!angular.isUndefined(str) && str !== '') {
                        $scope.result.message = str;
                    }
                    blink_text('callback_info', 5000);
                    $.unblockUI();
                }
            }
        }, function Error(response) {
            $.unblockUI();
            $scope.message = response.status;
        });
    };
    $scope.resetForm = function (str) {
        console.log('vaof resetForm');
        $scope.datas = $scope.initial;
        $scope.username = '';
        $scope.number = '';
        $scope.status = 127;
        $scope.agencycode = str;
        $scope.reloadFilter();
    };
    $scope.$watch('crPage + crPage', function () {
        $scope.reloadFilter();
    });
    $scope.pageChanged = function () {
        $scope.crPage = this.crPage;
    };
    $scope.delete = function (id) {
        $("#result_model").text('');
        jConfirm('<b style="color:red">Bạn chắc chắn muốn xóa Tài Khoản này?</b>', 'Confirm', function (r) {
            if (r) {
                $http({
                    method: "POST",
                    url: urlBase + "/admin/client-account/rest/delete",
                    params: {id: id}
                }).then(function Succes(resp) {
                    if (resp !== undefined && typeof resp === "object") {
                        $scope.result = resp.data.result;
                        if ($scope.result.code === nologin) {
                            location.href = context + adm_login_uri;
                        } else {
                            if ($scope.result.code === success) {
                                $scope.reloadFilter($scope.result.message);
                            }
                        }
                    }
                }, function Error(response) {
                    $scope.message = response.status;
                });
            }
        });
    };
    $scope.updateMaxRow = function () {
        $scope.crPage = 1;
        $scope.reloadFilter();
    };
    
    $scope.setId = function (id, user) {
        $scope.id = id;
        $scope.user = user;
    };
    
    $scope.formatDate = function (date) {
        if (!angular.isUndefined(date) && date !== null)
            return $filter('date')(new Date(date), 'dd/MM/yyyy HH:mm:ss')
        else
            return "";
    };
});