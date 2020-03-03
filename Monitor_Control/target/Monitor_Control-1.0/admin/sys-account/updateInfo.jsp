<%@page contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
            <a cl href="<c:url value="/admin/sys-account/edit-account?id=${sysAcc.accId}"/>" class="current">Cập nhật thông tin Tài khoản</a>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span10" style="padding-top: 5px">
                <c:if test="${result!=null && result.code!=1}">
                    <div id="alert alert-error" class="alert"><button class="close" data-dismiss="alert">×</button><strong>Error!</strong> ${result.message}</div>
                </c:if>
                <div class="widget-box">
                    <div class="widget-content nopadding">
                        <form:form id="editForm" method="post" modelAttribute="sysAcc"  action="">
                            <input type="hidden" name="accId" value="${sysAcc.accId}"/>
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <td>Tên đăng nhập</td>
                                        <td>
                                            <input readonly="true" value="${sysAcc.username}" type="text" class="span10" name="username"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Mật khẩu cũ</td>
                                        <td><input autocomplete="off" name="password" class="text-input span10" size="25" value="" type="password"></td>
                                    </tr>
                                    <tr>
                                        <td>Mật khẩu mới</td>
                                        <td><input autocomplete="off" name="newPassword" class="text-input span10" size="25" value="" type="password"></td>
                                    </tr>
                                    <tr>
                                        <td>Nhập lại mật khẩu mới</td>
                                        <td><input autocomplete="off" name="reNewPassword" class="text-input span10" size="25" value="" type="password"></td>
                                    </tr>
                                    <tr>
                                        <td>Tên đầy đủ</td>
                                        <td>
                                            <input value="${sysAcc.fullName}" class="text-input span10" size="55" name="fullName" type="text">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Điện thoại</td>
                                        <td><input value="${sysAcc.phone}" type="text" class="span10" name="phone"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <td><input name="email" value="${sysAcc.email}" class="text-input span10" size="25" type="text"></td>
                                    </tr>
                                    <tr>
                                        <td>Địa chỉ</td>
                                        <td>
                                            <textarea class="span10" name="address">${sysAcc.address}</textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" class="img-center">
                                            <input id="btnSubmit" class="btn btn-success" name="submit" value="Cập nhật tài khoản" type="submit">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <!--</form>-->
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/admin/js/jquery.min.js'/>"></script>
<script src="<c:url value='/admin/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/admin/js/jquery.alerts.js'/>"></script>