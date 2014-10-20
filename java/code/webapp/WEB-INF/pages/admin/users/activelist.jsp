<%@ taglib uri="http://rhn.redhat.com/rhn" prefix="rhn" %>
<%@ taglib uri="http://rhn.redhat.com/tags/list" prefix="rl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>


<html>
<head>
</head>
<body>
<rhn:toolbar base="h1" icon="header-user" imgAlt="users.jsp.imgAlt"
 helpUrl=""
 creationUrl="/rhn/users/CreateUser.do?account_type=into_org"
 creationType="user">
  <bean:message key="activelist.jsp.title"/>
</rhn:toolbar>
<c:set var="pageList" value="${requestScope.pageList}" />

<rl:listset name="userListSet">
<rhn:csrf />
<rhn:submitted />


<!-- Start of active users list -->
<rl:list dataset="pageList"
         width="100%"
         name="userList"
         styleclass="list"
         emptykey="activelist.jsp.noUsers"
 		 alphabarcolumn="userLogin">

	<!-- User name column -->
	<rl:column bound="false"
	           sortable="true"
	           headerkey="username.nopunc.displayname"
	           attr="userLogin"
	           filterattr="login">
		<c:out value="<a href=\"/rhn/users/UserDetails.do?uid=${current.id}\">${current.userLogin}</a>" escapeXml="false" />
	</rl:column>

	<!-- Real name column -->
	<rl:column bound="false"
	           sortable="true"
	           headerkey="realname.displayname"
	           sortattr="userLastName">
		<c:out value="${current.userLastName}, ${current.userFirstName}" />
	</rl:column>

	<!--  Roles column -->
	<rl:column attr="roleNames"
	           bound="true"
	           sortable="true"
	           headerkey="userdetails.jsp.roles"
	            />

	<!-- Last logged in column -->
    <rl:column attr="lastLoggedIn"
			   sortattr="lastLoggedInDate"
	           bound="false"
	           sortable="true"
	           headerkey="userdetails.jsp.lastsign">
        <rhn:formatDate humanStyle="from" value="${current.lastLoggedInDate}"
                       type="both" dateStyle="short" timeStyle="long"/>
    </rl:column>

</rl:list>
<rl:csv dataset="pageList"
	name="userList"
	exportColumns="userLogin,userLastName,userFirstName,email,roleNames,lastLoggedIn"/>
</rl:listset>
</body>
</html>
