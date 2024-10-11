import streamlit as st 
from frontend.kpi import ContentKPI
from frontend.graphs import ViewsTrend, GenderDistribution, AgeDistribution, ViewsAndSubscribers

# device_kpi = DeviceKPI()
content_kpi = ContentKPI()
views_graph = ViewsTrend()
gender_graph = GenderDistribution()
age_graph = AgeDistribution()
views_and_sub_graph = ViewsAndSubscribers()

def layout():
    st.markdown("# The data driven youtuber")
    st.markdown("Den här dashboarden syftar till att utforska datan i min youtubekanal")
    content_kpi.display_content()
    views_graph.display_plot()
    
    gender_graph.display_plot()
    
    age_graph.display_plot()
    
    views_and_sub_graph.display_plot()

if __name__ == "__main__":
    layout()