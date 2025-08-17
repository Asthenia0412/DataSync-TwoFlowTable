## sync-worker 数据库设计 (21张表)

### 基础主表 (1张)

**university_core**

- university_id, name_std, country_code, data_source, original_id, status, last_merge_time

### 三方接口表 (10张)

1. **university_ranking_3rd**
   - id, university_id, qs_rank, the_rank, subject_rank, year, sync_time
2. **program_3rd**
   - id, university_id, program_name, degree_type, duration, language, description
3. **scholarship_3rd**
   - id, university_id, name, amount, currency, deadline, eligibility
4. **fee_3rd**
   - id, university_id, tuition_fee, accommodation_fee, currency, year
5. **admission_3rd**
   - id, university_id, admission_rate, avg_gpa, gre_required, intl_ratio
6. **requirement_3rd**
   - id, university_id, ielts_min, toefl_min, degree_reqs, documents
7. **faculty_3rd**
   - id, university_id, name, dean, research_field, website
8. **campus_3rd**
   - id, university_id, location, latitude, longitude, facilities
9. **partner_3rd**
   - id, university_id, partner_name, agreement_type, start_date, end_date
10. **event_3rd**
    - id, university_id, event_type, title, start_time, end_time, location

### 已有数据库同步表 (10张)

1. **consult_legacy**
   - id, student_id, university_id, content, consult_time, consultant_id
2. **application_legacy**
   - id, student_id, university_id, program_id, apply_time, status
3. **payment_legacy**
   - id, student_id, order_no, amount, payment_channel, payment_time
4. **contract_legacy**
   - id, student_id, contract_no, contract_type, sign_time, status
5. **review_legacy**
   - id, student_id, university_id, rating, comment, review_time
6. **favorite_legacy**
   - id, student_id, university_id, create_time, status
7. **document_legacy**
   - id, student_id, file_type, file_name, upload_time
8. **notification_legacy**
   - id, receiver_id, message_type, title, send_time
9. **audit_legacy**
   - id, operator_id, operation_type, operation_time, ip
10. **student_legacy**
    - id, name, gender, birth_date, email, phone

## TPI数据库 (10张表)

1. **qs_ranking_data**
   - id, university_name, qs_rank, the_rank, year, created_at
2. **program_data**
   - program_id, university_id, program_name, degree_type, duration
3. **scholarship_data**
   - scholarship_id, university_id, name, amount, deadline
4. **fee_data**
   - id, university_id, tuition_fee, accommodation_fee, year
5. **admission_data**
   - id, university_id, admission_rate, avg_gpa, intl_ratio
6. **requirement_data**
   - id, university_id, ielts_min, toefl_min, documents
7. **faculty_data**
   - faculty_id, university_id, name, research_field
8. **campus_data**
   - id, university_id, location, latitude, facilities
9. **partner_data**
   - id, university_id, partner_name, agreement_type
10. **event_data**
    - event_id, university_id, event_type, start_time

## 已有业务数据库 (10张表)

1. **legacy_consult**
   - id, student_id, university_id, consult_time
2. **legacy_application**
   - id, student_id, university_id, apply_time
3. **legacy_payment**
   - id, student_id, order_no, amount
4. **legacy_contract**
   - id, student_id, contract_no, sign_time
5. **legacy_review**
   - id, student_id, university_id, rating
6. **legacy_favorite**
   - id, student_id, university_id, create_time
7. **legacy_document**
   - id, student_id, file_type, upload_time
8. **legacy_notification**
   - id, receiver_id, message_type, send_time
9. **legacy_audit**
   - id, operator_id, operation_type, operation_time
10. **legacy_student**
    - id, name, gender, birth_date
