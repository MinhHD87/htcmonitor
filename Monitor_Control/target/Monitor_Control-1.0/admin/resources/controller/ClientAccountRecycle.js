var app = angular.module('recycleClientAccApp', ['ui.bootstrap']);
app.controller('recycleClientAccCtrl', function ($scope, $http, $filter) {
    $scope.reloadFilter = function (str) {
        $.blockUI({message: '<img src="' + context + '/admin/images/indicator_48.gif" />'});
        $http({
            method: "POST",
            url: urlBase + "/admin/client-account/rest/recycle-data",
            params: {crPage: $scope.crPage, maxRow: $scope.maxRow, agencycode: $scope.agencycode, username: $scope.username, telephone: $scope.telephone, status: $scope.status}
        }).then(function Succes(resp) {
            if (resp !== undefined && typeof resp === "object") {
                $scope.result = resp.data.result;
                if ($scope.result.code === nologin) {
                    location.href = context + adm_login_uri;
                } else {
                    $scope.datas = resp.data.datas;
                    $scope.totalRow = resp.data.totalRow;
                    $scope.roles = resp.data.roles;
                    if (!angular.isUndefined(str) && str !== '') {
                        $scope.result.message = str;
                    }
                    blink_text('callback_info', 5000);
                    $.unblockUI();
                }
            }
        }, function Error(response) {
            $.unblockUI();
            $scope.message = response.message;
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
    $scope.deleteforEver = function (id) {
        jConfirm('<b style="color:red">Bạn chắc chắn muốn xóa Tài Khoản này?</b>', 'Confirm', function (r) {
            if (r) {
                $http({
                    method: "POST",
                    url: urlBase + "/admin/client-account/rest/deleteForEver",
                    params: {id: id}
                }).then(function Succes(resp) {
                    if (resp !== undefined && typeof resp === "object") {
                        $scope.result = resp.data;
                        if ($scope.result.code === -1) {
                            location.href = context + adm_login_uri;
                        } else {
                            $scope.reloadFilter($scope.result.message);
                        }
                    } else {
                        console.log("process deleteForever Error")
                    }
                }, function Error(response) {
                    $scope.message = response.message;
                });
            }
        });
    };
    $scope.undoDelete = function (id) {
        jConfirm('<b style="color:red">Bạn chắc chắn muốn khôi phục Tài Khoản này?</b>', 'Confirm', function (r) {
            if (r) {
                $http({
                    method: "POST",
                    url: urlBase + "/admin/client-account/rest/undo-account",
                    params: {id: id}
                }).then(function Succes(resp) {
                    if (resp !== undefined && typeof resp === "object") {
                        $scope.result = resp.data;
                        if ($scope.result.code === -1) {
                            location.href = context + adm_login_uri;
                        } else {
                            $scope.reloadFilter($scope.result.message);
                        }
                    } else {
                        console.log("process undoDelete Error")
                    }
                }, function Error(response) {
                    $scope.message = response.message;
                });
            }
        });
    };
    $scope.formatDateTime = function (date) {
        if (!angular.isUndefined(date) && date !== null)
            return $filter('date')(new Date(date), 'dd/MM/yyyy HH:mm:ss')
        else
            return "";
    };
});