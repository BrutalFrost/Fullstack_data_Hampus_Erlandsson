from utils.query_database import QueryDatabase
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st 

# Class to display the trend of views over time
class ViewsTrend:
    def __init__(self) -> None:
        self.df = QueryDatabase("SELECT * FROM marts.views_per_date").df
        print(self.df)

    def display_plot(self):
        fig = px.line(self.df, x="Datum", y="Visningar")
        st.markdown("## Antal visningar under senaste månaden")
        st.plotly_chart(fig)

# Class to display the distribution of viewers by gender
class GenderDistribution:
    def __init__(self) -> None:
        self.df = QueryDatabase("SELECT * FROM marts.viewer_genders").df

    def display_plot(self):
        fig = px.pie(self.df, names="Tittarnas kön", values="Visningar (%)")
        st.markdown("## Kön distribution")
        st.plotly_chart(fig)
        
# Class to display the distribution of viewers by age
class AgeDistribution:
    def __init__(self) -> None:
        self.df = QueryDatabase("SELECT * FROM marts.viewer_ages").df

    def display_plot(self):
        st.markdown("## Ålder distribution")
        columns = [col for col in self.df.columns if col not in ["Tittarnas ålder", "Genomsnittlig visningslängd"]]
        selected_column = st.selectbox("Värden", columns)
        
        fig = px.pie(self.df, names="Tittarnas ålder", values=selected_column)
        
        st.plotly_chart(fig)

# Class to display the trend of views and subscribers over time
class ViewsAndSubscribers:
    def __init__(self) -> None:
        self.df = QueryDatabase("SELECT * FROM marts.views_and_subscribers").df
        
    def display_plot(self):
        st.markdown("## Visningar och prenumeranter")
        
        self.df['Totala prenumeranter'] = self.df['Prenumeranter'].cumsum()
        
        option = st.checkbox("Visa Totala prenumeranter")
        
        fig = px.line(self.df, x="Datum", y=["Visningar", "Prenumeranter"])
        if option:
            fig.add_bar(x=self.df["Datum"], y=self.df["Totala prenumeranter"], name="Totala prenumeranter")
        
        st.plotly_chart(fig)