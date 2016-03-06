<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <sec:csrfMetaTags />
    <!--
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
    -->

    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Spring Boot CSRF Sample</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <link rel="stylesheet" href="styles/styles.css">
</head>
<body>

<div class="container">
    <div class="header clearfix">
        <nav>
            <ul class="nav nav-pills pull-right">
                <li role="presentation" class="active"><a href="#">Home</a></li>
                <li role="presentation"><a href="#">About</a></li>
                <li role="presentation"><a href="#">Contact</a></li>
            </ul>
        </nav>
        <h3 class="text-muted">Project name</h3>
    </div>

    <c:url var="postUrl" value="/post"/>
    <c:url var="uploadUrl" value="/upload"/>

    <div class="row marketing">
        <div class="col-lg-4">
            <h4>POST without CSRF-token</h4>
            <p>No CSRF-token</p>
            <form action="${postUrl}" method="post">
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>

    <div class="row marketing">
        <div class="col-lg-4">
            <h4>POST with CSRF-token</h4>
            <p>We add token explicitly</p>
            <form action="${postUrl}" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <div class="col-lg-4">
            <h4>POST with token on URL</h4>
            <p>We put CSRF token on the POST URL</p>
            <form action="${postUrl}?${_csrf.parameterName}=${_csrf.token}" method="post">
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <div class="col-lg-4">
            <h4>POST using csrfInput tag</h4>
            <p>We add token explicitly</p>
            <form action="${postUrl}" method="post">
                <sec:csrfInput />
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <div class="col-lg-4">
            <h4>POST using Spring's form-tag</h4>
            <p>CSRF token is added by the jsp tag</p>
            <sf:form action="${postUrl}" method="post">
                <button type="submit" class="btn btn-primary">Submit</button>
            </sf:form>
        </div>

    </div>

    <div class="row marketing">
        <div class="col-lg-4">
            <h4>Ajax POST with CSRF-header</h4>
            <p>We add token as HTTP header</p>
            <button id="btnAjaxMeta" type="submit" class="btn btn-primary">Submit</button>
        </div>
    </div>

    <div class="row marketing">
        <div class="col-lg-4">
            <h4>Upload form with CSRF 1</h4>
            <p>We put the token in the URL</p>
            <form action="${uploadUrl}?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
                <input type="file" name="file">
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

        <div class="col-lg-4">
            <h4>Upload form with CSRF 2</h4>
            <p>We put the token in input hidden</p>
            <form action="${uploadUrl}" method="post" enctype="multipart/form-data">
                <sec:csrfInput />
                <input type="file" name="file">
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>

    <div class="row marketing">
        <div class="col-lg-12">
            <h4>Info</h4>
            <dl>
                <dt>Session Id:</dt>
                <dd><c:out value="${pageContext.request.session.id}" /></dd>
            </dl>
            <dl>
                <dt>_csrf.token:</dt>
                <dd><c:out value="${_csrf.token}" /></dd>
            </dl>
            <dl>
                <dt>Session scope:</dt>
                <dd><c:out value="${sessionScope}" /></dd>
            </dl>
        </div>
    </div>


</div> <!-- /container -->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

<script>

    $(function () {
        var csrfToken = $("meta[name='_csrf']").attr("content");
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");

        /*
        var csrfToken = $.cookie('CSRF-TOKEN');
        var csrfHeader = $.cookie('CSRF-HEADER');
        */

        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        });
        /*
        */

        $("#btnAjaxMeta").click(function () {
            var headers = {};
            //headers[csrfHeader] = csrfToken;

            $.ajax({
                url: "<c:url value="/post" />",
                method: "POST",
                headers: headers
            }).done(function (data) {
                alert("Response: " + data);
            }).error(function (data) {
                alert("Error: " + JSON.stringify(data));
            });
        });
    });

</script>
</body>
</html>