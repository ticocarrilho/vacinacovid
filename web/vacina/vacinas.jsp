<%-- 
    Document   : vacinas
    Created on : Mar 3, 2021, 11:41:21 PM
    Author     : Arcantus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.RepositorioVacina"%>
<%@page import="br.recife.edu.ifpe.model.classes.Vacina"%>
<%@page import="java.util.List"%>
<%@taglib prefix="ifpe" uri="br.recife.edu.ifpe.customtags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vacinas</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>    </head>
</head>
<body>
    <div class="container">
        <a href="index.html">Página Inicial</a>
        <h1>Vacinas Cadastradas</h1>
        <h4><c:out value="${msg}"/></h4>
        <c:remove var="msg" scope="session"/>
        <ifpe:carregavacinas />
        <table class="table">
            <tr>
                <th>Codigo</th>
                <th>Nome</th>
                <th>Fabricante</th>
                <th>Tempo entre Aplicacoes</th>
                <th>Quantidade</th>
                <th>Ações</th>
            </tr>
            <c:forEach var="v" items="${vacinas}">
                <tr>
                    <td>${v.id}</td>
                    <td>${v.nome}</td>
                    <td>${v.fabricante}</td>
                    <td>${v.tempoEntreAplicacoes}</td>
                    <td>${v.quantidadeAplicacoes}</td>

                    <td>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="VacinaServlet?codigo=${v.id}&redirect=visualiza">Visualizar</a>
                                <a class="dropdown-item" href="VacinaServlet?codigo=${v.id}&redirect=edita">Editar</a>
                                <a class="dropdown-item" href="VacinaServlet" onclick="deleteVacina(${v.id})">Deletar</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cadastroModal">
            Cadastrar Vacina
        </button>
        <div class="modal fade" id="cadastroModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Edição' : 'Cadastro'} de Vacina</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <jsp:include page="cadastravacina.jsp" />
                </div>
            </div>
        </div>
        <div class="modal fade" id="vacinaModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Vacina</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <jsp:include page="visualizarvacina.jsp" />
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var produtoModal = document.getElementById("vacinaModal");
    $("#cadastroModal").on("hide.bs.modal", function () {
        window.location.href = 'VacinaServlet'
    });
    <%            String redirect = request.getParameter("redirect");
        if (redirect != null) {
            if (redirect.equals("visualiza")) {
    %>
    $('#vacinaModal').modal('show');
    <%
    } else if (redirect.equals("edita")) {
    %>

    $('#cadastroModal').modal('show');

    <%
            }
        }
    %>

    function deleteVacina(id) {
        fetch("VacinaServlet?id=" + id, {method: 'delete'}).then((res) => location.reload());
    }
</script>
</html>
