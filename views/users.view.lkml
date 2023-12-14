# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bigquery-public-data.thelook_ecommerce.users` ;;

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.email ;;
  }

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Age" in Explore.

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    type: sum
    sql: ${age} ;;  }

  measure: average_age {
    description: "Average age"
    type: average
    sql: ${age} ;;
    value_format: "0.##"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name_v2 ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_name}, ' ' , ${last_name}) ;;
    label: "Name"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: geo_coordinates {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
  }

  dimension: street_address {
    type: string
    sql: ${TABLE}.street_address ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  measure: distinct_post_codes {
    type:  count_distinct
    sql: ${postal_code} ;;
  }

  measure: total_users {
    type: count
  }

  measure: median_age {
    type: median
    sql: ${age} ;;
    label: "Age (median)"
    description: "URL to what median means"
    value_format: "##.0"
  }

  measure: distance_from_median {
    type: number
    description: "Actual description this time"
    sql: ${median_age} - MAX(${age}) ;;
    value_format: "#.0"
  }
}
