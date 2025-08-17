package io.github.asthenia0412.mocktpi.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan({"io.github.asthenia0412.mocktpi.mapper","io.github.asthenia0412.mocktpi.dao"})
public class MyBatisConfig {
}
