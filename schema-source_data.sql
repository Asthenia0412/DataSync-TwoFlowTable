
CREATE DATABASE `source_data` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

use source_data;
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

-- 创建已有业务数据库表 legacy_consult
CREATE TABLE legacy_consult (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    consult_time DATETIME COMMENT '咨询时间',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_consult_time (consult_time)
) COMMENT '已有业务咨询表';

-- 创建已有业务数据库表 legacy_application
CREATE TABLE legacy_application (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    apply_time DATETIME COMMENT '申请时间',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_apply_time (apply_time)
) COMMENT '已有业务申请表';

-- 创建已有业务数据库表 legacy_payment
CREATE TABLE legacy_payment (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    order_no VARCHAR(50) NOT NULL COMMENT '订单号',
    amount DECIMAL(15,2) COMMENT '支付金额',
    INDEX idx_student_id (student_id)
) COMMENT '已有业务支付表';

-- 创建已有业务数据库表 legacy_contract
CREATE TABLE legacy_contract (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    contract_no VARCHAR(50) NOT NULL COMMENT '合同编号',
    sign_time DATETIME COMMENT '签署时间',
    INDEX idx_student_id (student_id),
    INDEX idx_sign_time (sign_time)
) COMMENT '已有业务合同表';

-- 创建已有业务数据库表 legacy_review
CREATE TABLE legacy_review (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    rating INT COMMENT '评分',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id)
) COMMENT '已有业务评论表';

-- 创建已有业务数据库表 legacy_favorite
CREATE TABLE legacy_favorite (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    university_id BIGINT NOT NULL COMMENT '学校ID',
    create_time DATETIME COMMENT '创建时间',
    FOREIGN KEY (university_id) REFERENCES university_core(university_id),
    INDEX idx_student_id (student_id),
    INDEX idx_university_id (university_id),
    INDEX idx_create_time (create_time)
) COMMENT '已有业务收藏表';

-- 创建已有业务数据库表 legacy_document
CREATE TABLE legacy_document (
    id BIGINT PRIMARY KEY,
    student_id BIGINT NOT NULL COMMENT '学生ID',
    file_type VARCHAR(50) COMMENT '文件类型',
    upload_time DATETIME COMMENT '上传时间',
    INDEX idx_student_id (student_id),
    INDEX idx_upload_time (upload_time)
) COMMENT '已有业务文档表';

-- 创建已有业务数据库表 legacy_notification
CREATE TABLE legacy_notification (
    id BIGINT PRIMARY KEY,
    receiver_id BIGINT NOT NULL COMMENT '接收者ID',
    message_type VARCHAR(50) COMMENT '消息类型',
    send_time DATETIME COMMENT '发送时间',
    INDEX idx_receiver_id (receiver_id),
    INDEX idx_send_time (send_time)
) COMMENT '已有业务通知表';

-- 创建已有业务数据库表 legacy_audit
CREATE TABLE legacy_audit (
    id BIGINT PRIMARY KEY,
    operator_id BIGINT NOT NULL COMMENT '操作者ID',
    operation_type VARCHAR(50) COMMENT '操作类型',
    operation_time DATETIME COMMENT '操作时间',
    INDEX idx_operator_id (operator_id),
    INDEX idx_operation_time (operation_time)
) COMMENT '已有业务审计表';

-- 创建已有业务数据库表 legacy_student
CREATE TABLE legacy_student (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT '学生姓名',
    gender VARCHAR(10) COMMENT '性别',
    birth_date DATE COMMENT '出生日期',
    INDEX idx_name (name)
) COMMENT '已有业务学生表';