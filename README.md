<h1 align='center'> 
  Clinic Database System
</h1>

<p align="center">
  Project built with <img src="https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white">
</p>
<br/>

## About The Project
The group project was developed as part of the COMP1168 - Database Management course, and the purpose was to design a database system for a walk-in clinic located in a metropolitan city in Canada. Based on the problem description, as part of the process, the project requirements were at first creating a conceptual data model, defining the entities and their relationship. The second task was to create the physical data model using MySQL workbench, considering the conceptual model. The last major task was to create the queries as described on the project handout. 

Throughout the process, it was understood that there are different ways to do the build the system using MySQL workbench, and each decision was made by the group team, considering our own experience and the real word environment.

## Database Design Process
The database design process was developed based on the “steps for designing a data structure” described by Joel Murach. During the conceptual data model development, we focused on the steps to “identify the data elements” and “subdivide each element into its smallest useful components”. The first part was to understand the specifications for the walk-in clinic system based on the synopsis and identify possible entities, data elements and relationships, as a brainstorm, to align the process with the project description. 

The process of identifying the data elements, and organizing the entities in data blocks, was based on our own experience, but also searching possible forms and other specific documents for each entity, to build our own entities for each table. All the data was separated into four major categories: patient data, clinic data, billing data, and patient visit data. 

The physical data model is the process of building the database using MySQL workbench and had as steps: “Identify the tables and assign columns, identify the primary and foreign keys, review whether the data structure is normalized, and identify the indexes”. This process was developed based on the conceptual model, and we could expand the column information, defining the data type and any constraints. As part of the physical data model, we added the data to the table, and this part also takes into consideration the queries we need to create, making sure that the data entered would satisfy the information that needs to be found when running the queries.

### Conceptual Data Model
<p align="center">
  <img src="/.img/conceptual_model_database_project.png" width=780>
</p>

### Logical EER Model
<p align="center">
  <img src="/.img/clinic_eer_model.png" width=780>
</p>

## Conclusion
The data modeling project helped us to build a strong comprehensive about the database management process, not just the design itself, but also the whole process of a database, such as the modification, and retrieval of specific data from a table, following the required instructions. 

Throughout the process we were able to reflect on the relationship between two or more tables and have an understand about data architecture. Equally important, we also had to go through errors, debugging each one, and come up with solutions. To summarize, this hands-on project helped us to build a foundation knowledge on data model, and also to develop the ability to work with MySQL workbench. 
