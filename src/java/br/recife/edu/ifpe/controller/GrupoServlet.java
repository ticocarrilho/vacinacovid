/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.recife.edu.ifpe.controller;

import br.recife.edu.ifpe.model.classes.Grupo;
import br.recife.edu.ifpe.model.repositorios.RepositorioGrupo;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Arcantus
 */
@WebServlet(name = "GrupoServlet", urlPatterns = {"/GrupoServlet"})
public class GrupoServlet extends HttpServlet {

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doDelete(request, response); //To change body of generated methods, choose Tools | Templates.
        int id = Integer.parseInt(request.getParameter("id"));
        Grupo f = RepositorioGrupo.getCurrentInstance().read(id);
        RepositorioGrupo.getCurrentInstance().delete(f);

        HttpSession session = request.getSession();

        session.setAttribute("msg", "O Grupo " + f.getDenominacao() + " foi deletado com sucesso.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codStr = request.getParameter("codigo");
        if (codStr != null) {
            int codigo = Integer.parseInt(codStr);
            Grupo f = RepositorioGrupo.getCurrentInstance().read(codigo);

            request.setAttribute("grupo", f);
        }
        getServletContext().getRequestDispatcher("/grupo/grupos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String denominacao = request.getParameter("denominacao");
            int idadeMinima = Integer.parseInt(request.getParameter("idademinima"));
            int idadeMaxima = Integer.parseInt(request.getParameter("idademaxima"));
            String editar = request.getParameter("editar");
            
            Grupo f = new Grupo();
            f.setDenominacao(denominacao);
            f.setIdadeMinima(idadeMinima);
            f.setIdadeMaxima(idadeMaxima);

            HttpSession session = request.getSession();
            if (editar == null) {
                RepositorioGrupo.getCurrentInstance().insert(f);
                session.setAttribute("msg", "Grupo " + f.getDenominacao() + " cadastrado com sucesso.");
            } else {
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                f.setId(codigo);
                RepositorioGrupo.getCurrentInstance().update(f);
                session.setAttribute("msg", "Grupo " + f.getDenominacao()+ " editado com sucesso.");
            }
            response.sendRedirect("GrupoServlet");

        } catch (Exception e) {
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
