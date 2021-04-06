/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.recife.edu.ifpe.controller.tags;

import br.recife.edu.ifpe.model.classes.Grupo;
import br.recife.edu.ifpe.model.repositorios.RepositorioGrupo;
import java.io.IOException;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author Arcantus
 */
public class CarregaGruposTag extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException, IOException {
        super.doTag(); //To change body of generated methods, choose Tools | Templates.
        List<Grupo> g = RepositorioGrupo.getCurrentInstance().readAll();
        getJspContext().setAttribute("grupos", g, PageContext.PAGE_SCOPE);
        
    }
}
