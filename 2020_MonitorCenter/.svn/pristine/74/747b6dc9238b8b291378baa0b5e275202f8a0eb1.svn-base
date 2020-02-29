<%@page contentType="text/html; charset=utf-8" %><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            <a href="<c:url value="/admin/index"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> 
            <a cl href="<c:url value="/admin/client-account/list"/>" class="tip-bottom">Quản lý Client Account</a>
            <a cl href="<c:url value="#"/>" class="current">Xem chi tiết Client Account</a>
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
                        <form:form  id="addCliAccfrm" action="" modelAttribute="clientAcc" method="post">
                            <input type="hidden" name="id" value="${clientAcc.id}"/>
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <td class="span3">Mã Đại Lý(Khách Hàng)</td>
                                        <td>
                                            <input type="text" value="${clientAcc.agency_code}" name="agency_code" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">UserName</td>
                                        <td>
                                            <input type="text" value="${clientAcc.username}" name="username" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">Mã Tài Khoản</td>
                                        <td>
                                            <input type="text" value="${clientAcc.accountCode}" name="username" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">Giới Hạn Thời Gian gọi</td>
                                        <td>
                                            <input type="text" value="${clientAcc.quota}" name="quota" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">Địa Chỉ</td>
                                        <td>
                                            <input type="text" value="${clientAcc.address}" name="address" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">EMAIL</td>
                                        <td>
                                            <input type="text" value="${clientAcc.email}" name="email" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">TELEPHONE</td>
                                        <td>
                                            <input type="text" value="${clientAcc.telephone}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">NOTE</td>
                                        <td>
                                            <textarea class="span7" name="note" disabled="">${clientAcc.note}</textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">Số Dư</td>
                                        <td>
                                            <input type="text" value="${clientAcc.balance}" name="balance" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">Kiểu Tài Khoản</td>
                                        <td>
                                            <form:select path="type" disabled="true">
                                                <form:option value="0">Khách Hàng</form:option>
                                                <form:option value="1">Đại Lý</form:option>
                                            </form:select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Thanh Toán Dịch
                                            <form:select path="prepaid" disabled="true">
                                                <form:option value="0">Trả sau</form:option>
                                                <form:option value="1">Trả trước</form:option>
                                            </form:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Trạng thái</td>
                                        <td>                
                                            <form:select path="status" disabled="true">
                                                <form:option value="${status.ACTIVE}">Kích hoạt</form:option>
                                                <form:option value="${status.UNACTIVE}">Chưa kích hoạt</form:option>
                                                <form:option value="${status.LOCK}">Khóa</form:option>
                                            </form:select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            API
                                            <form:select path="lockAPI" disabled="true">
                                                <form:option value="${status.ACTIVE}">Kích hoạt</form:option>
                                                <form:option value="${status.LOCK}">Khóa</form:option>
                                            </form:select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            LOGIN
                                            <form:select path="lockLogin" disabled="true">
                                                <form:option value="${status.ACTIVE}">Kích hoạt</form:option>
                                                <form:option value="${status.LOCK}">Khóa</form:option>
                                            </form:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">CREATE BY</td>
                                        <td>
                                            <input type="text" value="${clientAcc.createBy}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">CREATE AT</td>
                                        <td>
                                            <input type="text" value="${clientAcc.createAt}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">UPDATED BY</td>
                                        <td>
                                            <input type="text" value="${clientAcc.updateBy}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">UPDATED AT</td>
                                        <td>
                                            <input type="text" value="${clientAcc.updateAt}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">DELETED BY</td>
                                        <td>
                                            <input type="text" value="${clientAcc.deleteBy}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="span3">DELETED AT</td>
                                        <td>
                                            <input type="text" value="${clientAcc.deleteAt}" name="telephone" class="span7" disabled=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="img-center" colspan="2" align="center">
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
    </div>
</div>
<script src="<c:url value='/admin/js/jquery.min.js'/>"></script>
<script src="<c:url value='/admin/js/bootstrap.min.js'/>"></script>