from typing import Dict

from pandas import DataFrame
from sqlalchemy.engine import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """
    for table_name, df in data_frames.items():
        # Usa to_sql para cargar el DataFrame como tabla en la base de datos
        df.to_sql(table_name, con=database, if_exists='replace', index=False)
        
    # TODO: Implement this function. For each dataframe in the dictionary, you must
    # use pandas.Dataframe.to_sql() to load the dataframe into the database as a
    # table.
    # For the table name use the `data_frames` dict keys.
    raise NotImplementedError
