CREATE DATABASE `sync_worker` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

use sync_worker
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

-- 创建三方接口表 university_ranking_3rd
CREATE TABLE university_ranking_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    qs_rank INT COMMENT 'QS排名',
    the_rank INT COMMENT 'THE排名',
    subject_rank VARCHAR(255) COMMENT '学科排名',
    year INT COMMENT '年份',
    sync_time DATETIME COMMENT '同步时间',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_year (year)
) COMMENT '第三方学校排名表';

-- 创建三方接口表 program_3rd
CREATE TABLE program_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    program_name VARCHAR(255) NOT NULL COMMENT '项目名称',
    degree_type VARCHAR(50) COMMENT '学位类型',
    duration INT COMMENT '学制（月）',
    language VARCHAR(50) COMMENT '授课语言',
    description TEXT COMMENT '项目描述',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_program_name (program_name)
) COMMENT '第三方项目信息表';

-- 创建三方接口表 scholarship_3rd
CREATE TABLE scholarship_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    name VARCHAR(255) NOT NULL COMMENT '奖学金名称',
    amount DECIMAL(15,2) COMMENT '奖学金金额',
    currency VARCHAR(10) COMMENT '货币单位',
    deadline DATE COMMENT '申请截止日期',
    eligibility TEXT COMMENT '申请条件',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_deadline (deadline)
) COMMENT '第三方奖学金信息表';

-- 创建三方接口表 fee_3rd
CREATE TABLE fee_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    tuition_fee DECIMAL(15,2) COMMENT '学费',
    accommodation_fee DECIMAL(15,2) COMMENT '住宿费',
    currency VARCHAR(10) COMMENT '货币单位',
    year INT COMMENT '年份',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_year (year)
) COMMENT '第三方费用信息表';

-- 创建三方接口表 admission_3rd
CREATE TABLE admission_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    admission_rate DECIMAL(5,2) COMMENT '录取率',
    avg_gpa DECIMAL(4,2) COMMENT '平均GPA',
    gre_required BOOLEAN COMMENT '是否需要GRE',
    intl_ratio DECIMAL(5,2) COMMENT '国际学生比例',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id)
) COMMENT '第三方录取信息表';

-- 创建三方接口表 requirement_3rd
CREATE TABLE requirement_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    ielts_min DECIMAL(3,1) COMMENT '雅思最低分',
    toefl_min INT COMMENT '托福最低分',
    degree_reqs TEXT COMMENT '学位要求',
    documents TEXT COMMENT '所需材料',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id)
) COMMENT '第三方入学要求表';

-- 创建三方接口表 faculty_3rd
CREATE TABLE faculty_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    name VARCHAR(255) NOT NULL COMMENT '院系名称',
    dean VARCHAR(100) COMMENT '院长姓名',
    research_field TEXT COMMENT '研究领域',
    website VARCHAR(255) COMMENT '网站链接',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_name (name)
) COMMENT '第三方院系信息表';

-- 创建三方接口表 campus_3rd
CREATE TABLE campus_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    location VARCHAR(255) COMMENT '校区位置',
    latitude DECIMAL(9,6) COMMENT '纬度',
    longitude DECIMAL(9,6) COMMENT '经度',
    facilities TEXT COMMENT '设施描述',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_location (location)
) COMMENT '第三方校区信息表';

-- 创建三方接口表 partner_3rd
CREATE TABLE partner_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    partner_name VARCHAR(255) NOT NULL COMMENT '合作机构名称',
    agreement_type VARCHAR(50) COMMENT '协议类型',
    start_date DATE COMMENT '开始日期',
    end_date DATE COMMENT '结束日期',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_partner_name (partner_name)
) COMMENT '第三方合作关系表';

-- 创建三方接口表 event_3rd
CREATE TABLE event_3rd (
    id BIGINT PRIMARY KEY,
    university_id BIGINT NOT NULL COMMENT '学校ID',
    event_type VARCHAR(50) COMMENT '事件类型',
    title VARCHAR(255) NOT NULL COMMENT '事件标题',
    start_time DATETIME COMMENT '开始时间',
    end_time DATETIME COMMENT '结束时间',
    location VARCHAR(255) COMMENT '地点',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_university_id (university_id),
    INDEX idx_start_time (start_time)
) COMMENT '第三方事件信息表';

-- 创建已有数据库同步表 consult_legacy
CREATE TABLE consult_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    content TEXT COMMENT '咨询内容',
    consult_time DATETIME COMMENT '咨询时间',
    consultant_id BIGINT COMMENT '咨询顾问ID',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_consult_time (consult_time)
) COMMENT '已有咨询记录表';

-- 创建已有数据库同步表 application_legacy
CREATE TABLE application_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    program_id BIGINT COMMENT '项目ID',
    apply_time DATETIME COMMENT '申请时间',
    status VARCHAR(20) COMMENT '申请状态',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    FOREIGN KEY (program_id) REFERENCES program_3rd(id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_apply_time (apply_time)
) COMMENT '已有申请记录表';

-- 创建已有数据库同步表 payment_legacy
CREATE TABLE payment_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    order_no VARCHAR(50) NOT NULL COMMENT '订单号',
    amount DECIMAL(15,2) COMMENT '支付金额',
    payment_channel VARCHAR(50) COMMENT '支付渠道',
    payment_time DATETIME COMMENT '支付时间',
    INDEX idx_student_id (student_id),
    INDEX idx_payment_time (payment_time)
) COMMENT '已有支付记录表';

-- 创建已有数据库同步表 contract_legacy
CREATE TABLE contract_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    contract_no VARCHAR(50) NOT NULL COMMENT '合同编号',
    contract_type VARCHAR(50) COMMENT '合同类型',
    sign_time DATETIME COMMENT '签署时间',
    status VARCHAR(20) COMMENT '合同状态',
    INDEX idx_student_id (student_id),
    INDEX idx_sign_time (sign_time)
) COMMENT '已有合同记录表';

-- 创建已有数据库同步表 review_legacy
CREATE TABLE review_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    rating INT COMMENT '评分',
    comment TEXT COMMENT '评论内容',
    review_time DATETIME COMMENT '评论时间',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_review_time (review_time)
) COMMENT '已有评论记录表';

-- 创建已有数据库同步表 favorite_legacy
CREATE TABLE favorite_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    create_time DATETIME COMMENT '创建时间',
    status VARCHAR(20) COMMENT '收藏状态',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_create_time (create_time)
) COMMENT '已有收藏记录表';

-- 创建已有数据库同步表 document_legacy
CREATE TABLE document_legacy (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    file_type VARCHAR(50) COMMENT '文件类型',
    file_name VARCHAR(255) NOT NULL COMMENT '文件名',
    upload_time DATETIME COMMENT '上传时间',
    INDEX idx_student_id (student_id),
    INDEX idx_upload_time (upload_time)
) COMMENT '已有文档记录表';

-- 创建已有数据库同步表 notification_legacy
CREATE TABLE notification_legacy (
    id BIGINT PRIMARY KEY,
    receiver_id BIGINT NOT NULL COMMENT '接收者ID',
    message_type VARCHAR(50) COMMENT '消息类型',
    title VARCHAR(255) NOT NULL COMMENT '消息标题',
    send_time DATETIME COMMENT '发送时间',
    INDEX idx_receiver_id (receiver_id),
    INDEX idx_send_time (send_time)
) COMMENT '已有通知记录表';

-- 创建已有数据库同步表 audit_legacy
CREATE TABLE audit_legacy (
    id BIGINT PRIMARY KEY,
    operator_id BIGINT NOT NULL COMMENT '操作者ID',
    operation_type VARCHAR(50) COMMENT '操作类型',
    operation_time DATETIME COMMENT '操作时间',
    ip VARCHAR(45) COMMENT '操作IP地址',
    INDEX idx_operator_id (operator_id),
    INDEX idx_operation_time (operation_time)
) COMMENT '已有审计记录表';

-- 创建已有数据库同步表 student_legacy
CREATE TABLE student_legacy (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '学生姓名',
    gender VARCHAR(10) COMMENT '性别',
    birth_date DATE COMMENT '出生日期',
    email VARCHAR(255) COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '电话',
    INDEX idx_name (name),
    INDEX idx_email (email)
) COMMENT '已有学生信息表';