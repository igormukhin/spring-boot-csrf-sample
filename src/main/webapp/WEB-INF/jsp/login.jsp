<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
</head>
<body onload="document.f.username.focus();">
<div class="container">
    <div class="content">
        <c:if test="${param.logout}">
            <p class="alert">You have been logged out</p>
        </c:if>
        <c:if test="${param.error}">
            <p class="alert alert-error">There was an error, please try again</p>
        </c:if>

        <h2>Login with Username and Password</h2>

        <c:url var="postUrl" value="/login"/>
        <form name="form" action="${login}" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <fieldset>
                <input type="text" name="username" value="" placeholder="Username" />
                <input type="password" name="password" placeholder="Password" />
            </fieldset>
            <input type="submit" id="login" value="Login" class="btn btn-primary" />
        </form>
    </div>
</div>
</body>
</html>