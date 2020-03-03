<%@page contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!--<style>
    .widget-box,.widget-content{
        border: none
    }
    .span3 input {
        width: 100%;
        margin-bottom: 30px
    }
    .span3 select {
        width: 100%;
        margin-bottom: 30px
    }
    .span9 textarea {
        width: 100%;
        margin-bottom: 30px
    }
</style>-->
<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
            <a cl href="<c:url value="/admin/client-account/list"/>" class="tip-bottom">Quản lý Tài Khoản Đại Lý(Khách Hàng)</a>
            <a cl href="<c:url value="#"/>" class="current">Cập nhật Tài Khoản Đại Lý(Khách Hàng)</a>
        </div>
    </div>
    <div class="container-fluid" ng-app="editClientApp" ng-controller="editclientCtrl">
        <div class="row-fluid">
            <div class="span12" style="padding-top: 5px">
                <c:if test="${result!=null && result.code!=1}">
                    <div id="alert alert-error" class="alert"><button class="close" data-dismiss="alert">×</button><strong>Error!</strong> ${result.message}</div>
                </c:if>
                <div class="widget-box">
                    <div class="widget-content nopadding">
                        <form:form  id="addCliAccfrm" action="" modelAttribute="clientAcc" method="post" >
                            <input type="hidden" name="id" value="${clientAcc.id}"/>
                            <table class="table table-bordered table-striped"> 
                                <tbody>
                                    <tr>
                                        <td>Mã Đại Lý(Khách Hàng)</td>
                                        <td>    
                                            <form:select style="width: 370px" id="agencyCode" path="agency_code" cssClass="span2" >
                                                <form:option value="" >============Tất cả============</form:option>
                                                <c:forEach var="c" items="${agency}">
                                                    <form:option value="${c.code}" >[${c.code}]  ${c.name}</form:option>
                                                </c:forEach>
                                            </form:select>
                                        </td>
                                        <td>Tài Khoản</td>
                                        <td><form:input style="width: 350px" type="text" id="username" path="username" cssClass="span2" /></td>
                                    </tr>
                                    <tr>
                                        <td>Mật khẩu truy cập</td>
                                        <td>
                                            <form:input style="width: 350px" type="password" id="passLogin" path="passLogin" />
                                        </td>
                                        <td>Mật khẩu API </td>
                                        <td><form:input style="width: 350px" type="password" id="passAPI" path="passAPI" cssClass="span2" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Địa Chỉ</td>
                                        <td>
                                            <form:input style="width: 350px" type="text" id="address" path="address"     />
                                        </td>
                                        <td>Email</td>
                                        <td>
                                            <form:input style="width: 350px" type="text" id="email" path="email" cssClass="span2"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Số điện thoại</td>
                                        <td>
                                            <form:input style="width: 350px" type="text" id="telephone" path="telephone"/>
                                        </td>
                                        <td> Ghi chú </td>
                                        <td><form:textarea style="width: 350px" class="span4" id="note"  path="note"></form:textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td >Thanh Toán Dịch</td>
                                            <td>
                                            <form:select style="width: 370px" path="prepaid" id="prepaid">
                                                <form:option value="0">Trả sau</form:option>
                                                <form:option value="1">Trả trước</form:option>
                                            </form:select>
                                        </td>

                                        <td> Trạng Thái </td>
                                        <td>  <form:select style="width: 350px" path="status" id="status">
                                                <form:option value="${status.ACTIVE}">Kích hoạt</form:option>
                                                <form:option value="${status.UNACTIVE}">Chưa kích hoạt</form:option>
                                                <form:option value="${status.LOCK}">Khóa</form:option>
                                            </form:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>API</td>
                                        <td>
                                            <form:select style="width: 370px" path="lockAPI" id="lockAPI">
                                                <form:option value="${status.ACTIVE}">Kích hoạt</form:option>
                                                <form:option value="${status.LOCK}">Khóa</form:option>
                                            </form:select>
                                        </td>
                                        <td>
                                            LOGIN
                                        </td>
                                        <td>
                                            <form:select style="width: 350px" path="lockLogin" id="lockLogin">
                                                <form:option value="${status.ACTIVE}">Kích hoạt</form:option>
                                                <form:option value="${status.LOCK}">Khóa</form:option>
                                            </form:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="img-center" colspan="16" align="center">
                                            <input value="Tạo Client Account" type="submit" id="btnSubmit" class="btn btn-success" name="submit" />
                                            &nbsp;&nbsp;&nbsp;
                                            <input value="Quay lại" class="btn btn-danger" onclick="location.href = '<c:url value="/admin/client-account/list" />'" type="button">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
        <script src="<c:url value='/admin/js/jquery.min.js'/>"></script>
        <script src="<c:url value='/admin/js/bootstrap.min.js'/>"></script>
        <script type="text/javascript">
$(document).ready(function () {
$("#agency_code").select2({
matcher: customMatcher,
placeholder: "Chọn một đại lý khách hàng",
allowClear: true
});
var codeRegex = /^[a-zA-Z0-9_\.]{3,32}$/;
var selectRegex = /^(?!\.*127).*$/;
//                                                    var pasReg = /^(?=.*[0-9])(?=.*[!@#$%^&*()])(?=.*[A-Z])[a-zA-Z0-9!@#$%^&*]{8,30}$/;
var pasReg = /^(?=.*[0-9])(?=.*[!@#$%^&*()])(?=.*[A-Z])[a-zA-Z0-9!@#$%^&*]{6,30}$/;
var pasPhone = /^\+(?:[0-9] ?){6,14}[0-9]$/;
$("#addCliAccfrm").validate({
//                                                        ignore: 'input[type=hidden]',
rules: {
address: "required",
username: {
required: true,
        minlength: 3,
        maxlength: 32,
        regex: codeRegex
},
agency_code: {
required: true,
        valueNotEquals: " "
},
passLogin: {
required: true,
        minlength: 6,
        maxlength: 30,
        regex: pasReg
},
passAPI: {
required: true,
        minlength: 6,
        maxlength: 30,
        regex: pasReg
},
email: {
required: true,
        email: true
},
telephone: {
required: true,
        regex: pasPhone
},
},
messages: {
agency_code: {
required: "Trường đại lý là bắt buộc",
        valueNotEquals: "Bạn phải chọn mã đại lý"
},
        prepaid: {
        required: "Trường thanh toán là bắt buộc",
                regex: "Hãy chọn trạng thái cho Thanh toán"
        },
        type: {
        required: "Trường loại tài khoản là bắt buộc",
                regex: "Hãy chọn trạng thái cho Loại tài khoản"
        },
        quota: {
        required: "Trường này là bắt buộc",
                regex: "Trường này phải là số"
        },
        username: {
        required: "Trường username là bắt buộc",
                regex: "Trường user yêu cầu tối thiểu 3 ký tự, không khoảng trắng"
        },
        passAPI: {
        required: "Trường password API là bắt buộc",
                minlength: "Trường password API yêu cầu 6-30 ký tự",
                maxlength: "too max length",
                regex: "Mật khẩu API phải bao gồm chữ hoa chữ thường, ký tự đặc biệt và số Ex: Abcd1&"
        },
        passLogin: {
        required: "Trường password Login là bắt buộc",
                minlength: "Trường password Login yêu cầu 6-30 ký tự",
                maxlength: "too max length",
                regex: "Mật khẩu Login phải bao gồm chữ hoa chữ thường, ký tự đặc biệt và số Ex: Abcd1&"
        },
        email: {
        email: "Hãy nhập đúng định dạng email"
        },
        telephone: {
        required: "Trường đại lý là bắt buộc",
                regex: "Hãy nhập đúng định dạng phone"
        },
},
submitHandler: function (form) {
form.submit();
}
});
jQuery.validator.addMethod("regex", function (value, element, regexpr) {
return regexpr.test(value);
});
});
</script>