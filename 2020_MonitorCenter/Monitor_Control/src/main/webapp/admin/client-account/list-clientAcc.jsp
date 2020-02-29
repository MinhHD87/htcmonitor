<%@page language="java" contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css" >
    /*    @import "https://fonts.googleapis.com/css?family=Raleway";*/
    /** { box-sizing: border-box; }*/
    /*    body { 
            margin: 0; 
            padding: 0; 
            background: #333;
            font-family: Raleway; 
            text-transform: uppercase; 
            font-size: 11px; 
        }*/
    #topupFormQuota h3{ margin: 0; }
    #topupquota { 
        -webkit-user-select: none; /* Chrome/Safari */        
        -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* IE10+ */
        /*margin: 4em auto;*/
        width: 30px; 
        height: 30px; 
        line-height: 30px;
        /*background: teal;*/
        color: white;
        font-weight: 700;
        text-align: center;
        cursor: pointer;
        border: 1px solid white;
    }

    #topupquota:hover { background: #666; }
    #topupquota:active { background: #444; }

    #topupFormQuota { 
        display: none;

        border: 6px solid #49cced; 
        padding: 2em;
        width: 400px;
        text-align: center;
        background: #fff;
        position: fixed;
        top:50%;
        left:50%;
        transform: translate(-50%,-50%);
        -webkit-transform: translate(-50%,-50%)

    }

    #topupFormQuota input {
        margin: .8em auto;
        font-family: inherit; 
        text-transform: inherit; 
        font-size: inherit;

        display: block; 
        width: 280px; 
        height: 35px;
        padding: .4em;
    }
    #topupFormQuota textarea { 
        margin: .8em auto;
        font-family: inherit; 
        text-transform: inherit; 
        font-size: inherit;

        display: block; 
        width: 280px; 
        padding: .4em;
    }

    #topupFormQuota textarea { height: 80px; resize: none; }

    #topupFormQuota .formBtn { 
        width: 140px;
        display: inline-block;

        /*background: teal;*/
        color: #fff;
        font-weight: 100;
        font-size: 1.2em;
        border: none;
        height: 30px;
    }
    .select2-container .select2-choice > .select2-chosen {
        margin-right: 0px;
    }

    .select2-container .select2-choice span {
        margin-right: 0px;
    }
</style>
<style type="text/css" >
    /*    @import "https://fonts.googleapis.com/css?family=Raleway";*/
    /** { box-sizing: border-box; }*/
    /*    body { 
            margin: 0; 
            padding: 0; 
            background: #333;
            font-family: Raleway; 
            text-transform: uppercase; 
            font-size: 11px; 
        }*/
    #topupFormBlanace h3{ margin: 0; }
    #topupbalance { 
        -webkit-user-select: none; /* Chrome/Safari */        
        -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* IE10+ */
        /*margin: 4em auto;*/
        width: 30px; 
        height: 30px; 
        line-height: 30px;
        /*background: teal;*/
        color: white;
        font-weight: 700;
        text-align: center;
        cursor: pointer;
        border: 1px solid white;
    }

    #topupbalance:hover { background: #666; }
    #topupbalance:active { background: #444; }

    #topupFormBlanace { 
        display: none;

        border: 6px solid #49cced; 
        padding: 2em;
        width: 400px;
        text-align: center;
        background: #fff;
        position: fixed;
        top:50%;
        left:50%;
        transform: translate(-50%,-50%);
        -webkit-transform: translate(-50%,-50%)

    }

    #topupFormBlanace input {
        margin: .8em auto;
        font-family: inherit; 
        text-transform: inherit; 
        font-size: inherit;

        display: block; 
        width: 280px; 
        height: 35px;
        padding: .4em;
    }
    #topupFormBlanace textarea { 
        margin: .8em auto;
        font-family: inherit; 
        text-transform: inherit; 
        font-size: inherit;

        display: block; 
        width: 280px; 
        padding: .4em;
    }

    #topupFormBlanace textarea { height: 80px; resize: none; }

    #topupFormBlanace .formBtn { 
        width: 140px;
        display: inline-block;

        /*background: teal;*/
        color: #fff;
        font-weight: 100;
        font-size: 1.2em;
        border: none;
        height: 30px;
    }
    .select2-container .select2-choice > .select2-chosen {
        margin-right: 0px;
    }

    .select2-container .select2-choice span {
        margin-right: 0px;
    }
</style>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"><a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
            <a href="<c:url value="/admin/client-account/list"/>" class="current">Quản lý Tài Khoản Đại Lý(Khách Hàng)</a></div>
    </div>
    <div class="container-fluid">
        <div ng-app="ClientAccountApp" ng-controller="ClientAccountCtrl" class="row-fluid" ng-init="maxRow = '20'; crPage = 1; agencycode = '${valueDef}'; username = ''; telephone = ''; status = '${status.ALL}';">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"><i class="icon-align-justify"></i> </span>
                        <h5>Tìm kiếm Tài Khoản Đại Lý(Khách Hàng)</h5>        
                        <span class="fr" style="padding: 9px"><a href="<c:url value="/admin/client-account/recycle"/>" style="color: red;font-weight: bold;">${Lang['generic.deleted']} <img width="16" src="<c:url value="/admin/images/recycle.png"/>"></a></span>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="cateConfFrm" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">Tài Khoản </label>
                                <div class="controls">
                                    <input class="text-input" ng-model="username" type="text">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Mã Đại lý&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <select style="width: 250px;vertical-align: middle" ng-model="agencycode">
                                        <option value="${valueDef}" >====Tất cả====</option>
                                        <c:forEach var="c" items="${agency}">
                                            <option value="${c.code}" >[${c.code}]  ${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Số điện thoại</label>
                                <div class="controls">
                                    <input class="text-input" ng-model="telephone" type="text">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    Trạng thái&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <select style="width: 250px;vertical-align: middle" ng-model="status">
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
                                    <input type="reset" ng-click="resetForm('${valueDef}')" class="btn btn-warning" name="Reset Form" value="Làm mới"/>
                                    &nbsp;&nbsp;&nbsp;
                                    <input class="btn btn-primary" onclick="location.href = '<c:url value="/admin/client-account/create" />'" value="Thêm mới" type="button">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                        <h5>Danh sách Tài Khoản Đại Lý(Khách Hàng) <span id="result_model" class="callback_info">${result.message}</span>
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
                                    <th>STT</th><th>Mã Đại Lý</th><th>Tài Khoản</th><th>Email</th><th>Điện Thoại</th><th>Số Phút Gọi(m)</th><th>Số Dư</th><th>Kiểu Tài Khoản</th><th>Thanh Toán</th><th>Trạng thái</th><th>Sửa/Xóa</th><th>Chi Tiết</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="cliAcc in datas">
                                    <td class="img-center">{{($index + 1)}}</td>
                                    <td>{{cliAcc.agency_code}}</td>
                                    <td>{{cliAcc.username}}</td>
                                    <td>{{cliAcc.email}}</td>
                                    <td>{{cliAcc.telephone}}</td>
                                    <td ng-if="cliAcc.prepaid === 0">{{cliAcc.quota}} (m) <span id="topupquota" ng-click="setId(cliAcc.id, cliAcc.username)" ><img width="16" src="<c:url value="/admin/images/plus.png"/>" alt="Nạp thêm"></span></td>
                                    <td ng-if="cliAcc.prepaid === 1"></td>
                                    <td ng-if="cliAcc.prepaid === 0"></td>
                                    <td ng-if="cliAcc.prepaid === 1">{{cliAcc.balance}} VND <span id="topupbalance" ng-click="setId(cliAcc.id, cliAcc.username)" ><img width="16" src="<c:url value="/admin/images/plus.png"/>" alt="Nạp thêm"></span></td>
                                    <!--<td>{{cliAcc.quota}} <span id="topupquota" ng-click="setId(cliAcc.id, cliAcc.username)" ><img width="16" src="<c:url value="/admin/images/plus.png"/>" alt="Nạp thêm"></span></td>-->
                                    <!--<td>{{cliAcc.balance}} VND <span id="topupbalance" ng-click="setId(cliAcc.i{cliAcc.quota}d, cliAcc.username)" ><img width="16" src="<c:url value="/admin/images/plus.png"/>" alt="Nạp thêm"></span></td>-->
                                    <td>{{cliAcc.type === 1 ? "Đại Lý" : "Khách Hàng"}}</td>
                                    <td>{{cliAcc.prepaid === 1 ? "Trả Trước" : "Trả Sau"}}</td>
                                    <td class="img-center">
                                        <img ng-if="cliAcc.del" width="24" src="<c:url value="/admin/images/recycle.png"/>" alt="recycle">
                                        <img ng-if="cliAcc.status === ${status.ACTIVE}" width="24" src="<c:url value="/admin/images/active.png"/>" alt="active">
                                        <img ng-if="cliAcc.status === ${status.UNACTIVE}" width="24" src="<c:url value="/admin/images/inactive.png"/>" alt="inactive">
                                        <img ng-if="cliAcc.status === ${status.LOCK}" width="24" src="<c:url value="/admin/images/lock.png"/>" alt="block">
                                    </td>
                                    <td style="width: 70px">
                                        <a href="${pageContext.request.contextPath}/admin/client-account/edit?id={{cliAcc.id}}" >
                                            <img src="<c:url value="/admin/images/edit.png"/>" title="Edit"/>
                                        </a>
                                        &nbsp;
                                        <a ng-click="delete(cliAcc.id)" href="" title="Delete">
                                            <img src="<c:url value="/admin/images/remove.png"/>" title="Delete"/>
                                        </a> 
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/client-account/detail?id={{cliAcc.id}}" >
                                            <img src="<c:url value="/admin/images/detail_1.png"/>" title="Chi tiết">
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

                        <!--Popup Topup vào tài khoản-->
                        <div id="topupFormBlanace">

                            <h3>Nạp tiền vào tài khoản!</h2>
                                <h4>Cho tài khoản <span style="color: #7bc321">{{user}}</span></h4>

                                <form method="POST" action="<%=request.getContextPath() + "/admin/client-account/topupbalance"%>" onSubmit="return confirmAction()">
                                    <input id="id" name="id" type="hidden" style="height: 0" ng-value="id" required />
                                    <input id="userReceive" name="userReceive" type="hidden" style="height: 0" ng-value="user"  required />
                                    <input id="amount" name="amount" placeholder="Số tiền nạp" type="number" min="0" max="10000000000" required />
                                    <!--<textarea placeholder="Ghi chú" name="note" required ></textarea>-->
                                    <input class="formBtn" style="background: teal" type="submit" value="Topup"/>
                                    <input class="formBtn btn-warning" type="reset" value="Reset"/>
                                </form>
                        </div>
                        <!--Popup Topup vào tài khoản-->

                        <!--Popup Topup vào tài khoản-->
                        <div id="topupFormQuota">

                            <h3>Giới Hạn Số Phút Gọi!</h2>
                                <h4>Cho tài khoản <span style="color: #7bc321">{{user}}</span></h4>

                                <form method="POST" action="<%=request.getContextPath() + "/admin/client-account/topupquota"%>" onSubmit="return confirmAction()">
                                    <input id="id" name="id" type="hidden" style="height: 0" ng-value="id" required />
                                    <input id="userReceive" name="userReceive" type="hidden" style="height: 0" ng-value="user"  required />
                                    <input id="amount" name="amount" placeholder="Giới hạn phút goi" type="number" min="0" max="10000000000" required />
                                    <!--<textarea placeholder="Ghi chú" name="note" required ></textarea>-->
                                    <input class="formBtn" style="background: teal" type="submit" value="Topup"/>
                                    <input class="formBtn btn-warning" type="reset" value="Reset"/>
                                </form>
                        </div>
                        <!--Popup Topup vào tài khoản-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value='/admin/js/angular.min.js'/>"></script>
<script src="<c:url value='/admin/js/ui-bootstrap-tpls-2.1.3.min.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.min.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.alerts.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.blockUI.js'/>"></script>
<script src="<c:url value='/admin/controller/ClientAccount.js'/>"></script>
<script type="text/javascript" language="javascript">
$(document).ready(function () {
    $(document).on("click", "#topupbalance", function () {

        // contact form animations
        $('#topupFormBlanace').fadeToggle();
        $(document).mouseup(function (e) {
            var container = $("#topupFormBlanace");

            if (!container.is(e.target) // if the target of the click isn't the container...
                    && container.has(e.target).length === 0) // ... nor a descendant of the container
            {
                container.fadeOut();
            }
        });
    });
    $(document).on("click", "#topupquota", function () {

        // contact form animations
        $('#topupFormQuota').fadeToggle();
        $(document).mouseup(function (e) {
            var container = $("#topupFormQuota");

            if (!container.is(e.target) // if the target of the click isn't the container...
                    && container.has(e.target).length === 0) // ... nor a descendant of the container
            {
                container.fadeOut();
            }
        });
    });
});
function confirmAction() {
   return confirm("Bạn có chắc chắn không?");
}
</script>

