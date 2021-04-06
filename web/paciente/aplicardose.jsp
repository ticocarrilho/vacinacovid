<%-- 
    Document   : aplicardose
    Created on : Mar 4, 2021, 6:04:07 PM
    Author     : Arcantus
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.*"%>
<%@page import="br.recife.edu.ifpe.model.classes.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            List<ProfissionalEnfermagem> en = RepositorioProfissionalEnfermagem.getCurrentInstance().readAll();
            List<Vacina> va = RepositorioVacina.getCurrentInstance().readAll();
        %>
        <form method="post" action="PacienteServlet">
            <div class="modal-body">
                <div class="form-group row">
                    <label for="aplicador" class="col-2 col-form-label">Aplicador</label>
                    <select class="form-control col-9" name="aplicador" id="aplicador" required>
                        <% if (en.size() != 0) { %>
                        <%
                            for (ProfissionalEnfermagem p : en) {
                        %>
                        <option value="<%=p.getId()%>"><%=p.getNome()%></option>
                        <% }
                        } else { %>
                        <option>Nao tem enfermeiro cadastrado.</option>
                        <% }%>
                    </select>
                </div>
                <div class="form-group row">
                    <label for="vacina" class="col-2 col-form-label">Vacina</label>
                    <select class="form-control col-9" name="vacina" id="vacina" required>
                        <% if (va.size() != 0) { %>
                        <%
                            for (Vacina v : va) {
                        %>
                        <option value="<%=v.getId()%>"><%=v.getNome()%></option>
                        <% }
                        } else { %>
                        <option>Nao tem vacina cadastrado.</option>
                        <% }%>
                    </select>
                </div>
                <div class="form-group row">
                    <label for="descricaoVacina" class="col-2 col-form-label">Descricao Vacina</label>
                    <div class="col-10">
                        <textarea class="form-control" type="text" name="descricaoVacina" required id="descricaoVacina"></textarea>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                <button type="submit" value="cadastrar" class="btn btn-primary">Vacinar Paciente</button>
            </div>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'aplicar') ? 'aplicar' : ''}" value="aplicar"/>
            <input type="hidden" name="${(param.redirect != null && param["redirect"] eq 'aplicar') ? 'codigo' : ''}" value="${(param.redirect != null && param["redirect"] eq 'aplicar') ? paciente.id : ''}"/>
        </form>


    </body>
</html>
