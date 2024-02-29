CREATE TABLE `PERMISSION` (
    `PERMISSION_ID`      SERIAL,
    `USER_ID`            BIGINT UNSIGNED NOT NULL,
    `CONTENT_ID`         BIGINT UNSIGNED,
    `FILE_ID`            BIGINT UNSIGNED,
    `PERMISSION_READ`    BIT(1) NOT NULL DEFAULT 0,
    `PERMISSION_WRITE`   BIT(1) NOT NULL DEFAULT 0,
    `PERMISSION_ARCHIVE` BIT(1) NOT NULL DEFAULT 0,
    `PERMISSION_DELETE`  BIT(1) NOT NULL DEFAULT 0,
    CONSTRAINT UNIQUE (`USER_ID`, `CONTENT_ID`, `FILE_ID`),
    CONSTRAINT CHECK (
        (`CONTENT_ID` IS NOT NULL AND `FILE_ID` IS NULL) OR
        (`CONTENT_ID` IS NULL AND `FILE_ID` IS NOT NULL)
    ),
    CONSTRAINT CHECK (
        NOT (
            (NOT `PERMISSION_READ` AND `PERMISSION_WRITE`) OR
            (NOT `PERMISSION_ARCHIVE` AND `PERMISSION_DELETE`)
        )
    ),
    PRIMARY KEY (`PERMISSION_ID`),
    FOREIGN KEY (`USER_ID`) REFERENCES `USER`(`USER_ID`),
    FOREIGN KEY (`CONTENT_ID`) REFERENCES `CONTENT`(`CONTENT_ID`) ON DELETE CASCADE,
    FOREIGN KEY (`FILE_ID`) REFERENCES `FILE`(`FILE_ID`) ON DELETE CASCADE
);
