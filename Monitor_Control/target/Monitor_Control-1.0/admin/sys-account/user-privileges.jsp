<%@page contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link href="<c:url value='/admin/css/bootstrap-toggle.min.css' />" rel="stylesheet" type="text/css"/>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
            <a href="<c:url value="/admin/sys-account/list"/>" class="tip-bottom">Quản lý tài khoản Quản trị</a>
            <a href="#" class="current">Quyền của User</a>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                    <h5>Tìm kiếm Module</h5>
                    <h4 style="text-align: center;margin: 0;padding: 6px">Quyền của tài khoản: <span style="color: red">${sysAcc.username}</span> <span style="margin-left: 15px;color: fuchsia">${result.message}</span></h4>
                </div>
                <div class="widget-content nopadding">
                    <form id="from-list-module" action="${pageContext.request.contextPath}/admin/sys-account/user-privileges?id=${id}" method="POST" class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label">Tên Module </label>
                            <div class="controls">
                                <input type="hidden" name="id" value="${id}"/>
                                <select class="span3" id="_moduleId" name="moduleId">
                                    <option value="">--- Tất cả ---</option>
                                    <c:forEach var="m" items="${modules}">
                                        <option value="${m.modulId}">${m.name}</option>
                                    </c:forEach>
                                </select>
                                &nbsp;&nbsp;
                                <input type="submit" name="Tìm kiếm" value="Tìm kiếm" class="btn btn-success"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <c:forEach var="oneRole" items="${groupRole}" varStatus="loop">
                    <div class="span6" style="min-height: 192px;margin-left: ${(loop.index%2)==0?"0":"2.5%"}">
                        <div class="widget-box">
                            <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                                <h5>Phân Quyền cho: &nbsp;&nbsp; <span style="color: fuchsia;">${oneRole.get(0).moduleName}</span></h5>
                                <div class="fr" style="padding: 7px;color: blue">
                                    <input data-width="20" data-height="13"  data-style="ios" onchange="checkAllRole('${sysAcc.accId}', '${oneRole.get(0).moduleId}')" data-toggle="toggle" id="special-${oneRole.get(0).moduleId}" type="checkbox" value="0" />&nbsp;&nbsp;<b>Cấp Full Quyền</b>
                                </div>
                            </div>
                            <div class="widget-content" style="min-height: 94px">
                                <!--start-->
                                <div class="row-fluid">
                                    <div class="span12" style="float: left"><c:forEach var="rAct" items="${oneRole}" varStatus="loop">
                                            <c:if test="${loop.index==0}"><div class="span3 checkbox" style="margin-top: 10px;float: left"></c:if>
                                                    <label style="min-width: 240px">
                                                        <input data-width="20" data-height="13"  data-style="ios" 
                                                               onchange="changeRole('${sysAcc.accId}', '${rAct.actionId}')" data-toggle="toggle" ${rAct.role?"checked":""} 
                                                        id="role${rAct.actionId}" type="checkbox" value="${rAct.role?1:0}" /><b style="min-width: 160px">&nbsp; ${rAct.name}</b>
                                                </label>
                                                <c:if test="${(loop.index+1)%3==0 && (loop.index!=(actList.size()-1))}"></div><div class="span3 checkbox" style="margin-top: 10px"></c:if>
                                                <c:if test="${loop.index==(oneRole.size()-1)}"></div></c:if>
                                            </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/admin/js/jquery.min.js'/>"></script>
<script src="<c:url value='/admin/js/bootstrap-toggle.min.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.ui.custom.js'/>"></script>
<script src="<c:url value='/admin/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/admin/js/select2.min.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.alerts.js'/>"></script>
<script type="text/javascript">
function checkAllRole(accid, mid) {
    var status = $("#special-" + mid).is(":checked");
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: "<%=request.getContextPath()%>/admin/sys-account/rest/role-check-all",
        data: {mid: mid, status: status, accid: accid, _: Math.floor(Math.random() * 10000)},
        success: function (data) {
            if (data.result != 'undefined' && data.result.code === nologin) {
                location.href = context + '/admin/login';
            } else {
                location.reload(true);
            }
        }
    });
}
function changeRole(accid, actId) {
    var status = $("#role" + actId).is(":checked");
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: "<%=request.getContextPath()%>/admin/sys-account/rest/role-check-one",
        data: {accid: accid, status: status, actId: actId, _: Math.floor(Math.random() * 10000)},
        success: function (data) {
            if (data.result != 'undefined' && data.result.code === nologin) {
                location.href = context + '/admin/login';
            } else {
                $(".callback_info").text(data.result.message);
                blink_text('callback_info', 5000)
            }
        }
    });
}
$(document).ready(function () {
    $("#_moduleId").select2({
        matcher: customMatcher,
        placeholder: "Chọn một module cần thêm path",
        formatSelection: function (item) {
            return (item.text);
        },
        allowClear: true
    }
    ).select2("val", "");
});
</script>