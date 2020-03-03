<%@page contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"><a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
            <a href="<c:url value="/admin/sys-account/list"/>" class="tip-bottom">Quản lý tài khoản Quản trị</a>
            <a href="#" class="current">Tài khoản Quản trị đã xóa</a></div>
    </div>
    <div class="container-fluid">
        <div ng-app="recycleAccountApp" ng-controller="recycleAccountCtrl" class="row-fluid" ng-init="maxRow = '20'; crPage = '1'; key = ''; phone = ''; email = ''; status = '${mystatus.ALL}';">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5 style="color: red">Tìm kiếm tải khoản đã xóa</h5>
                        <span class="fr" style="padding: 9px"><a href="<c:url value="/admin/sys-account/list"/>" style="color: #0088cc;font-weight: bold;">Danh sách tài khoản <img width="16" src="<c:url value="/admin/images/list.png"/>"></a></span>
                    </div>
                    <div class="widget-content nopadding">
                        <form class="form-horizontal" action="">
                            <div class="control-group">
                                <label class="control-label">Username/Full Name </label>
                                <div class="controls">
                                    <input data-original-title="" data-title="A tooltip for the input" class="text-input tip" ng-model="key" placeholder="Username Full Name" type="text">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Số điện thoại
                                    <input class="text-input" ng-model="phone" type="text">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Email </label>
                                <div class="controls">
                                    <input class="text-input" ng-model="email" type="text">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Trạng thái
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <select style="width: 150px;vertical-align: middle" ng-model="status">
                                        <c:forEach var="s" items="${lstatus}">
                                            <option value="${s.val}">${s.desc}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <div ng-click="reloadFilter()" type="submit" class="btn btn-success">Tìm kiếm</div>
                                    &nbsp;&nbsp;&nbsp;
                                    <input type="reset" class="btn btn-warning" name="Reset Form" value="reset"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
                        <h5 style="color: red">Danh sách tài khoản đã xóa <span id="result_model" class="callback_info">${result.message}</span>
                            <span class="callback_info">{{result.message}}</span></h5>
                        <div class="fr" style="padding: 3px">
                            Hiển thị 
                            <select ng-model="maxRow" ng-change="updateMaxRow()">
                                <option value="20">20 dòng</option>
                                <option value="50">50 dòng</option>
                                <option value="100">100 dòng</option>
                            </select>
                        </div>
                    </div>
                    <div class="widget-content nopadding">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Username</th>
                                    <th>Full Name</th>
                                    <th>Mô tả</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>Create Date</th>
                                    <th>Create By</th>
                                    <th>Trạng thái</th>
                                    <th ng-if="roles.restore || roles.delEver">Undodel/Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="recycle in datas">
                                    <td>{{$index + 1}}</td>
                                    <td>{{recycle.username}}</td>
                                    <td>{{recycle.fullName}}</td>
                                    <td>{{recycle.description}}</td>
                                    <td>{{recycle.phone}}</td>
                                    <td>{{recycle.email}}</td>
                                    <td ng-bind="formatDateTime(recycle.createDate)"></td>
                                    <td>{{recycle.createBy}}</td>
                                    <td class="img-center">
                                        <img ng-if="recycle.status === ${status.ACTIVE}" width="24" src="<c:url value="/admin/images/active.png"/>" alt="active">
                                        <img ng-if="recycle.status === ${status.UNACTIVE}" width="24" src="<c:url value="/admin/images/inactive.png"/>" alt="inactive">
                                        <img ng-if="recycle.status === ${status.LOCK}" width="24" src="<c:url value="/admin/images/lock.png"/>" alt="block">
                                    </td>
                                    <td ng-if="roles.restore || roles.delEver" style="width: 70px">
                                        <a ng-if="roles.restore" ng-click="undoDelete(recycle.accId)" href="" title="undoDel" >
                                            <img width="24" src="<c:url value="/admin/images/redo-128.png"/>" alt="Undo">
                                        </a>
                                        <a ng-if="roles.delEver" ng-click="deleteforEver(recycle.accId)" href="" title="Delete">
                                            <img src="<c:url value="/admin/images/remove.png"/>" alt="Delete">
                                        </a> 
                                    </td>
                                </tr>
                                <tr ng-if="totalRow > maxRow">
                                    <td colspan="13">
                                        <div class="pagination aalternate fr">
                                            <ul uib-pagination total-items="totalRow" ng-model="crPage" ng-change="pageChanged()" items-per-page="maxRow" boundary-links="true" num-pages="numPages"></ul>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/admin/js/angular.min.js'/>"></script>
<script src="<c:url value='/admin/js/ui-bootstrap-tpls-2.1.3.min.js'/>"></script>                                      
<script src="<c:url value='/admin/js/jquery.min.js'/>"></script>
<script src="<c:url value='/admin/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/admin/js/maruti.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.alerts.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.blockUI.js'/>"></script>
<script src="<c:url value='/admin/controller/SysAccountRecycle.js'/>"></script>