import streamlit as st
import pandas as pd
import altair as alt
import builtins
import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col
from snowflake.snowpark.context import get_active_session

# Get snowflake session
session = get_active_session()

# Load data from CHURN_RAW schema
df = session.table("RAW.CUSTOMER_CHURN_RAW").to_pandas()

# Sidebar with filters
with st.sidebar:
    st.header("🔍 Filtry")
    selected_gender = st.multiselect("Płeć", df["GENDER"].unique(), default=list(df["GENDER"].unique()))
    selected_geo = st.multiselect("Kraj", df["GEOGRAPHY"].unique(), default=list(df["GEOGRAPHY"].unique()))

# Data Filtering
filtered = df[
    df["GENDER"].isin(selected_gender) &
    df["GEOGRAPHY"].isin(selected_geo)
]

# Visualize KPI
col1, col2, col3 = st.columns(3)
col1.metric("👥 Customers", len(filtered))
col2.metric("🚪 Churn %", f"{100 * filtered['EXITED'].mean():.2f}%")
col3.metric("💰 Avg. Balance", f"{filtered['BALANCE'].mean():,.0f} €")

st.markdown("---")

# Gender Churn
churn_chart = (
    alt.Chart(filtered)
    .mark_bar()
    .encode(
        x=alt.X("GENDER:N", title="Gender"),
        y=alt.Y("count():Q", title="Customers Count"),
        color=alt.Color("EXITED:N", title="Churn", scale=alt.Scale(scheme="set2")),
        tooltip=["GENDER", "EXITED", "count()"]
    )
    .properties(title="🚻 Churn - Gender", height=300)
)
st.altair_chart(churn_chart, use_container_width=True)

# Balance histogram
balance_hist = (
    alt.Chart(filtered)
    .mark_bar()
    .encode(
        x=alt.X("BALANCE:Q", bin=alt.Bin(maxbins=40), title="Balance (€)"),
        y='count()',
        tooltip=['count()']
    )
    .properties(title="💳 Balance Distribution", height=300)
)
st.altair_chart(balance_hist, use_container_width=True)

# Age vs Credit Score
sample = filtered.sample(n=builtins.min(2000, len(filtered)), random_state=42)
scatter = (
    alt.Chart(sample)
    .mark_circle(size=60)
    .encode(
        x="AGE:Q",
        y="CREDITSCORE:Q",
        color=alt.Color("EXITED:N", title="Churn", scale=alt.Scale(scheme="category10")),
        tooltip=["CUSTOMERID", "AGE", "CREDITSCORE", "EXITED"]
    )
    .properties(title="🎯 Age vs CreditScore", height=300)
    .interactive()
)
st.altair_chart(scatter, use_container_width=True)

# 🧾 Data Table
with st.expander("📋 Raw Data"):
    st.dataframe(filtered.head(30))
