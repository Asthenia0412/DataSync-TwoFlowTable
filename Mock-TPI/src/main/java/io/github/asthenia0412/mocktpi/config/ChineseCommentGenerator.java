package io.github.asthenia0412.mocktpi.config;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.*;
import org.mybatis.generator.internal.DefaultCommentGenerator;
import org.mybatis.generator.internal.util.StringUtility;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ChineseCommentGenerator extends DefaultCommentGenerator {

    private static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public void addFieldComment(Field field,
                                IntrospectedTable introspectedTable,
                                IntrospectedColumn introspectedColumn) {
        if (StringUtility.stringHasValue(introspectedColumn.getRemarks())) {
            field.addJavaDocLine("/**");
            field.addJavaDocLine(" * " + introspectedColumn.getRemarks());
            field.addJavaDocLine(" * 数据库字段: " +
                    introspectedTable.getFullyQualifiedTable() + "." +
                    introspectedColumn.getActualColumnName());
            field.addJavaDocLine(" */");
        }
    }

    @Override
    public void addClassComment(InnerClass innerClass,
                                IntrospectedTable introspectedTable) {
        String remarks = introspectedTable.getRemarks();
        if (!StringUtility.stringHasValue(remarks)) {
            remarks = introspectedTable.getFullyQualifiedTable().getIntrospectedTableName();
        }

        innerClass.addJavaDocLine("/**");
        innerClass.addJavaDocLine(" * " + remarks);
        innerClass.addJavaDocLine(" * ");
        innerClass.addJavaDocLine(" * @作者 " + System.getProperty("user.name"));
        innerClass.addJavaDocLine(" * @日期 " + LocalDateTime.now().format(DATE_FORMATTER));
        innerClass.addJavaDocLine(" * @表名 " + introspectedTable.getFullyQualifiedTable());
        innerClass.addJavaDocLine(" */");
    }

    @Override
    public void addGetterComment(Method method,
                                 IntrospectedTable introspectedTable,
                                 IntrospectedColumn introspectedColumn) {
        method.addJavaDocLine("/**");
        method.addJavaDocLine(" * 获取" + introspectedColumn.getRemarks());
        method.addJavaDocLine(" * @return " + introspectedColumn.getActualColumnName() + " - " + introspectedColumn.getRemarks());
        method.addJavaDocLine(" */");
    }

    @Override
    public void addSetterComment(Method method,
                                 IntrospectedTable introspectedTable,
                                 IntrospectedColumn introspectedColumn) {
        method.addJavaDocLine("/**");
        method.addJavaDocLine(" * 设置" + introspectedColumn.getRemarks());
        method.addJavaDocLine(" * @param " + introspectedColumn.getJavaProperty() + " " + introspectedColumn.getRemarks());
        method.addJavaDocLine(" */");
    }
}