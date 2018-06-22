module Model.Table exposing (Table, init, setRowCount, populateColumn, getRows, getColumns)

{-| In this datatye, the table is a List of Lists, where each List is non-empty;
that is, the smallest it can get is a 1x1 table.
We need to keep the width of the table and the length of the columnTypes list consistent.
-}


type Table a b
    = Table
        { rowCount : Int
        , columnCount : Int
        , columnTypes : List a
        , rows : List (List b)
        }


init : a -> b -> Table a b
init initialColumnType initialCellValue =
    Table
        { rowCount = 1
        , columnCount = 1
        , columnTypes = [ initialColumnType ]
        , rows = [ [ initialCellValue ] ]
        }


setRowCount : Int -> b -> Table a b -> Result String (Table a b)
setRowCount rowCount initialValue (Table table) =
    let
        newTable =
            (List.take rowCount table.rows)
                ++ (List.repeat
                        (max 0 rowCount - (List.length table.rows))
                        (List.map (always initialValue) table.columnTypes)
                   )
    in
        if rowCount < 0 then
            Err "Row count must be >= 1"
        else if rowCount > 1000 then
            Err "Row count must be <= 1000"
        else
            Ok (Table { table | rowCount = rowCount, rows = newTable })


populateColumn : (Int -> b) -> Int -> Table a b -> Table a b
populateColumn generator columnIndex (Table table) =
    Table <|
        { table
            | rows =
                List.indexedMap
                    (\i row ->
                        (List.take columnIndex row)
                            ++ [ generator i ]
                            ++ (List.drop (columnIndex + 1) row)
                    )
                    table.rows
        }


getRows : Table a b -> List (List b)
getRows (Table table) =
    table.rows


getColumns : Table a b -> List a
getColumns (Table table) =
    table.columnTypes
