<%@page contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"><a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
            <a href="<c:url value="/admin/client-account/list"/>" class="tip-bottom">Quản lý Client Account</a>
            <a href="#" class="current">Tài khoản Client Account đã xóa</a></div>
    </div>
    <div class="container-fluid">
        <div ng-app="recycleClientAccApp" ng-controller="recycleClientAccCtrl" class="row-fluid" ng-init="maxRow = '20'; crPage = 1;agencycode = '${valueDef}'; username = ''; telephone = ''; status = '${status.ALL}';">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5 style="color: red">Tìm kiếm tải khoản đã xóa</h5>
                        <span class="fr" style="padding: 9px"><a href="<c:url value="/admin/client-account/list"/>" style="color: #0088cc;font-weight: bold;">Danh sách tài khoản <img width="16" src="<c:url value="/admin/images/list.png"/>"></a></span>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="cateConfFrm" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label"> Client Account UserName</label>
                                <div class="controls">
                                    <input class="text-input" ng-model="username" type="text">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Client Account Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <select style="width: 150px;vertical-align: middle" ng-model="agencycode">
                                        <option value="${valueDef}" >====Tất cả====</option>
                                        <c:forEach var="c" items="${agency}">
                                            <option value="${c.code}" >[${c.code}]  ${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Client Account Telephone</label>
                                <div class="controls">
                                    <input class="text-input" ng-model="telephone" type="text">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Trạng thái&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <select style="width: 150px;vertical-align: middle" ng-model="status">
                                        <c:forEach var="s" items="${lstatus}">
                                            <option value="${s.val}">${s.desc}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <div ng-click="reloadFilter()" class="btn btn-success">Tìm kiếm</div>
                                    &nbsp;&nbsp;&nbsp;
                                    <input type="reset" ng-click="resetForm()" class="btn btn-warning" name="Reset Form" value="reset"/>
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
                                    <th>STT</th><th>Mã Đại Lý</th><th>Tìa Khoản</th><th>Địa Chỉ</th><th>Email</th><th>Số Điện Thoại</th><th>Người Tạo</th><th>Ngày Tạo</th><th>Người Xóa</th><th>Ngày Xóa</th><th>Trạng thái</th><th>Undodel/Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="cliAcc in datas">
                                    <td class="img-center">{{($index + 1)}}</td>
                                    <td>{{cliAcc.agency_code}}</td>
                                    <td>{{cliAcc.username}}</td>
                                    <td>{{cliAcc.address}}</td>
                                    <td>{{cliAcc.email}}</td>
                                    <td>{{cliAcc.telephone}}</td>
                                    <td>{{cliAcc.createBy}}</td>
                                    <td>{{cliAcc.createAt}}</td>
                                    <td>{{cliAcc.deleteBy}}</td>
                                    <td>{{cliAcc.deleteAt}}</td>
                                    <td class="img-center">
                                        <img ng-if="cliAcc.del" width="24" src="<c:url value="/admin/images/recycle.png"/>" alt="recycle">
                                        <img ng-if="cliAcc.status === ${status.ACTIVE}" width="24" src="<c:url value="/admin/images/active.png"/>" alt="active">
                                        <img ng-if="cliAcc.status === ${status.UNACTIVE}" width="24" src="<c:url value="/admin/images/inactive.png"/>" alt="inactive">
                                        <img ng-if="cliAcc.status === ${status.LOCK}" width="24" src="<c:url value="/admin/images/lock.png"/>" alt="block">
                                    </td>
                                    <td style="width: 70px">
                                        <a ng-click="undoDelete(cliAcc.id)" href="" title="undoDel" >
                                            <img width="24" src="<c:url value="/admin/images/redo-128.png"/>" alt="Undo">
                                        </a>
                                        <a ng-click="deleteforEver(cliAcc.id)" href="" title="Delete">
                                            <img src="<c:url value="/admin/images/remove.png"/>" alt="Delete">
                                        </a> 
                                    </td>
                                </tr>
                                <tr ng-if="totalRow > maxRow"> 
                                    <td colspan="13">
                                        <div class="pagination aalternate fr">
                                            <ul uib-pagination total-items="totalRow" ng-change="pageChanged()" ng-model="crPage" max-size="maxRow" items-per-page="maxRow" class="" boundary-links="true" num-pages="numPages"></ul>
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
<script src="<c:url value='/admin/controller/ClientAccountRecycle.js'/>"></script>