
CREATE DATABASE `mock_tpi` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

use mock_tpi;
-- 创建基础主表 university_core
CREATE TABLE university_core (
    university_id BIGINT PRIMARY KEY,
    name_std VARCHAR(255) NOT NULL COMMENT '标准化学校名称',
    country_code VARCHAR(10) NOT NULL COMMENT '国家代码',
    data_source VARCHAR(50) COMMENT '数据来源',
    original_id VARCHAR(50) COMMENT '原始ID',
    status VARCHAR(20) COMMENT '状态',
    last_merge_time DATETIME COMMENT '最后合并时间',
    INDEX idx_name_std (name_std),
    INDEX idx_country_code (country_code)
) COMMENT '学校核心信息表';

-- 创建TPI数据库表 qs_ranking_data
CREATE TABLE qs_ranking_data (
    id BIGINT PRIMARY KEY,
    university_name VARCHAR(255) NOT NULL COMMENT '学校名称',
    qs_rank INT COMMENT 'QS排名',
    the_rank INT COMMENT 'THE排名',
    year INT COMMENT '年份',
    created_at DATETIME COMMENT '创建时间',
    INDEX idx_university_name (university_name),
    INDEX idx_year (year)
) COMMENT 'TPI学校排名表';

-- 创建TPI数据库表 program_data
CREATE TABLE program_data (
    program_id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    program_name VARCHAR(255) NOT NULL COMMENT '项目名称',
    degree_type VARCHAR(50) COMMENT '学位类型',
    duration INT COMMENT '学制（月）',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_program_name (program_name)
) COMMENT 'TPI项目信息表';

-- 创建TPI数据库表 scholarship_data
CREATE TABLE scholarship_data (
    scholarship_id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    name VARCHAR(255) NOT NULL COMMENT '奖学金名称',
    amount DECIMAL(15,2) COMMENT '奖学金金额',
    deadline DATE COMMENT '申请截止日期',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_deadline (deadline)
) COMMENT 'TPI奖学金信息表';

-- 创建TPI数据库表 fee_data
CREATE TABLE fee_data (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    tuition_fee DECIMAL(15,2) COMMENT '学费',
    accommodation_fee DECIMAL(15,2) COMMENT '住宿费',
    year INT COMMENT '年份',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_year (year)
) COMMENT 'TPI费用信息表';

-- 创建TPI数据库表 admission_data
CREATE TABLE admission_data (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    admission_rate DECIMAL(5,2) COMMENT '录取率',
    avg_gpa DECIMAL(4,2) COMMENT '平均GPA',
    intl_ratio DECIMAL(5,2) COMMENT '国际学生比例',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id)
) COMMENT 'TPI录取信息表';

-- 创建TPI数据库表 requirement_data
CREATE TABLE requirement_data (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    ielts_min DECIMAL(3,1) COMMENT '雅思最低分',
    toefl_min INT COMMENT '托福最低分',
    documents TEXT COMMENT '所需材料',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id)
) COMMENT 'TPI入学要求表';

-- 创建TPI数据库表 faculty_data
CREATE TABLE faculty_data (
    faculty_id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    name VARCHAR(255) NOT NULL COMMENT '院系名称',
    research_field TEXT COMMENT '研究领域',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_name (name)
) COMMENT 'TPI院系信息表';

-- 创建TPI数据库表 campus_data
CREATE TABLE campus_data (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    location VARCHAR(255) COMMENT '校区位置',
    latitude DECIMAL(9,6) COMMENT '纬度',
    facilities TEXT COMMENT '设施描述',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_location (location)
) COMMENT 'TPI校区信息表';

-- 创建TPI数据库表 partner_data
CREATE TABLE partner_data (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    partner_name VARCHAR(255) NOT NULL COMMENT '合作机构名称',
    agreement_type VARCHAR(50) COMMENT '协议类型',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_partner_name (partner_name)
) COMMENT 'TPI合作关系表';

-- 创建TPI数据库表 event_data
CREATE TABLE event_data (
    event_id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    event_type VARCHAR(50) COMMENT '事件类型',
    start_time DATETIME COMMENT '开始时间',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_start_time (start_time)
) COMMENT 'TPI事件信息表';
