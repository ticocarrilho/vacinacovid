<%-- 
    Document   : grupos
    Created on : Mar 4, 2021, 12:10:39 PM
    Author     : Arcantus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.RepositorioGrupo"%>
<%@page import="br.recife.edu.ifpe.model.classes.Grupo"%>
<%@page import="java.util.List"%>
<%@taglib prefix="ifpe" uri="br.recife.edu.ifpe.customtags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grupos</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>    </head>
</head>
<body>
    <div class="container">
        <a href="index.html">Página Inicial</a>
        <h1>Grupos Cadastradas</h1>
        <h4><c:out value="${msg}"/></h4>
        <c:remove var="msg" scope="session"/>
        <ifpe:carregagrupos />
        <table class="table">
            <tr>
                <th>Codigo</th>
                <th>Denominacao</th>
                <th>Idade Minima</th>
                <th>Idade Maxima</th>
                <th>Ações</th>
            </tr>
            <c:forEach var="g" items="${grupos}">
                <tr>
                    <td>${g.id}</td>
                    <td>${g.denominacao}</td>
                    <td>${g.idadeMinima}</td>
                    <td>${g.idadeMaxima}</td>

                    <td>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="GrupoServlet?codigo=${g.id}&redirect=visualiza">Visualizar</a>
                                <a class="dropdown-item" href="GrupoServlet?codigo=${g.id}&redirect=edita">Editar</a>
                                <a class="dropdown-item" href="GrupoServlet" onclick="deleteGrupo(${g.id})">Deletar</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cadastroModal">
            Cadastrar Grupo
        </button>
        <div class="modal fade" id="cadastroModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Edição' : 'Cadastro'} de Grupo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <jsp:include page="cadastragrupo.jsp" />
                </div>
            </div>
        </div>
        <div class="modal fade" id="grupoModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Grupo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <jsp:include page="visualizagrupo.jsp" />
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var grupoModal = document.getElementById("grupoModal");
    $("#cadastroModal").on("hide.bs.modal", function () {
        window.location.href = 'GrupoServlet'
    });
    <%            String redirect = request.getParameter("redirect");
        if (redirect != null) {
            if (redirect.equals("visualiza")) {
    %>
    $('#grupoModal').modal('show');
    <%
    } else if (redirect.equals("edita")) {
    %>

    $('#cadastroModal').modal('show');

    <%
            }
        }
    %>

    function deleteGrupo(id) {
        fetch("GrupoServlet?id=" + id, {method: 'delete'}).then((res) => {
            console.log(res)
            location.reload()
        });
    }
</script>
</html>
