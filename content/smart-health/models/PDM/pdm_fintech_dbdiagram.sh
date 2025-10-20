// =====================================
// SMART HEALTH - 7 ENTITY MODEL (DBML) - UPDATED
// Includes explicit user relations (created_by_user_id)
// =====================================

Table patient {
  patient_id int [pk, increment]
  name varchar
  birth_date date
  sex varchar
}

Table physician {
  physician_id int [pk, increment]
  name varchar
  license_number varchar
}

Table user {
  user_id int [pk, increment]
  username varchar
  role varchar
}

Table appointment {
  appointment_id int [pk, increment]
  patient_id int [ref: > patient.patient_id]      // patient has appointments
  physician_id int [ref: > physician.physician_id]// physician attends appointments
  created_by_user_id int [ref: > user.user_id]    // user creates appointments
  appointment_date date
  status varchar
  reason varchar
}

Table clinical_record {
  clinical_record_id int [pk, increment]
  appointment_id int [ref: > appointment.appointment_id] // appointment generates records
  patient_id int [ref: > patient.patient_id]
  created_by_user_id int [ref: > user.user_id]    // user registers clinical_records
  record_type varchar
  summary_text text
  created_at datetime
}

Table insurance_policy {
  policy_id int [pk, increment]
  patient_id int [ref: > patient.patient_id]      // patient holds policies
  created_by_user_id int [ref: > user.user_id]    // user creates insurance_policies
  policy_number varchar
  insurance_company_name varchar
  start_date date
  end_date date
  status varchar
}

Table audit_log {
  audit_log_id int [pk, increment]
  user_id int [ref: > user.user_id]               // user logs actions
  entity_name varchar
  entity_id int                                   // id of the entity instance audited
  action varchar
  timestamp datetime
}

// =====================================
// RELATIONSHIP COMMENTS (explicit)
// =====================================
// patient has appointments
// physician attends appointments
// user creates appointments
// appointment generates clinical_records
// user registers clinical_records
// patient holds insurance_policies
// user creates insurance_policies
// user logs audit_logs (audit_log references entity_name + entity_id)
