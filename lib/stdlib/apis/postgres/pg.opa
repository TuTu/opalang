/*
    Copyright © 2011-2012 MLstate
    
    This file is part of Opa.
    
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    
*/
// WARNING: This file has been generated by apigen.opa, DO NOT EDIT.
// Date: Tue Nov 13 2012 11:46:37
// Config file: pg_config
// Module name: Pg
// Endianness: be
// Style: Classic
/** Pg module
 * 
 * This file generates low-level messages for the Postgresql API
 * 
 * Packing functions are named "pack_<message_name>"
 * Unpacking functions are named "unpack_<message_name>"
 * 
 * You probably won't need to use the packing/unpacking functions,
 * there are message send and receive functions provided which use these.
 * 
 * The sending functions are: start, password, query, parse, bind, execute,
 * describe, closePS, sync and flush.
 * 
 * The only receive function is reply which handles all incoming messages from PostgreSQL.
 * 
 */
import stdlib.core
import stdlib.apis.apigenlib
@private U = Pack.Unser

Pg = {{

/**
 * A Bind command.
 * @param destination_portal (string): The name of the destination portal (an empty string selects the unnamed portal).
 * @param source_statement (string): The name of the source prepared statement (an empty string selects the unnamed prepared statement).
 * @param codes (unsigned short list): The parameter format codes. Each must presently be zero (text) or one (binary).
 * @param parameters (binary list): The parameters in the format indicated by the associated format code.
 * @param result_column_codes (short list): The result-column format codes. Each must presently be zero (text) or one (binary).
 */
  pack_Bind((destination_portal,source_statement,codes,parameters,result_column_codes)) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="B"},
     {Reference=length},
     {Cstring=destination_portal},
     {Cstring=source_statement},
     {List=([{Short=0; signed=false; le=false}],List.map((s -> [{Short=s; signed=false; le=false}]),codes)); size={S}; le=false},
     {List=([{Binary=Binary.create(0); size={L}}],List.map((b -> [{Binary=b; size={L}}]),parameters)); size={S}; le=false},
     {List=([{Short=0; le=false}],List.map((s -> [{Short=s; le=false}]),result_column_codes)); size={S}; le=false}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * Cancel request.
 * @param processid (long): The process ID of the target backend.
 * @param secret_key (long): The secret key for the target backend.
 */
  pack_CancelRequest((processid,secret_key)) =
    [
     {Long=16; le=false},
     {Long=80877102 /** The cancel request code. The value is chosen to contain 1234 in the most significant 16 bits, and 5678 in the least 16 significant bits. (To avoid confusion, this code must not be the same as any protocol version number.) */; le=false},
     {Long=processid; le=false},
     {Long=secret_key; le=false}
    ]

/**
 * A Close command.
 * @param S_or_P (char): 'S' to close a prepared statement; or 'P' to close a portal.
 * @param name (string): The name of the prepared statement or portal to close (an empty string selects the unnamed prepared statement or portal).
 */
  pack_Close((S_or_P,name)) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="C"},
     {Reference=length},
     {Char=S_or_P},
     {Cstring=name}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * COPY data.
 * @param data (binary): 
 */
  pack_CopyDataF(data) =
    [
     {Char="d"},
     {Binary=data; size={L}}
    ]

/**
 * A COPY-complete indicator.
 */
  pack_CopyDoneF() =
    [
     {Char="c"},
     {Long=4; le=false}
    ]

/**
 * A Describe command.
 * @param S_or_P (char): 'S' to describe a prepared statement; or 'P' to describe a portal.
 * @param name (string): The name of the prepared statement or portal to describe (an empty string selects the unnamed prepared statement or portal).
 */
  pack_Describe((S_or_P,name)) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="D"},
     {Reference=length},
     {Char=S_or_P},
     {Cstring=name}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * An Execute command.
 * @param portal_name (string): The name of the portal to execute (an empty string selects the unnamed portal).
 * @param rows_to_return (long): Maximum number of rows to return, if portal contains a query that returns rows (ignored otherwise). Zero denotes "no limit".
 */
  pack_Execute((portal_name,rows_to_return)) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="E"},
     {Reference=length},
     {Cstring=portal_name},
     {Long=rows_to_return; le=false}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * A Flush command.
 */
  pack_Flush() =
    [
     {Char="H"},
     {Long=4; le=false}
    ]

/**
 * A function call.
 * @param objectid (unsigned long): Specifies the object ID of the function to call.
 * @param codes (unsigned short list): The argument format codes. Each must presently be zero (text) or one (binary).
 * @param arguments (binary list): Argument, in the format indicated by the associated format code.
 * @param result_code (unsigned short): The format code for the function result. Must presently be zero (text) or one (binary).
 */
  pack_FunctionCall((objectid,codes,arguments,result_code)) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="F"},
     {Reference=length},
     {Long=objectid; signed=false; le=false},
     {List=([{Short=0; signed=false; le=false}],List.map((s -> [{Short=s; signed=false; le=false}]),codes)); size={S}; le=false},
     {List=([{Binary=Binary.create(0); size={L}}],List.map((b -> [{Binary=b; size={L}}]),arguments)); size={S}; le=false},
     {Short=result_code; signed=false; le=false}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * A Parse command.
 * @param name (string): The name of the destination prepared statement (an empty string selects the unnamed prepared statement).
 * @param query (string): The query string to be parsed.
 * @param objectids (long list): Object IDs of the parameter data type. Placing a zero here is equivalent to leaving the type unspecified.
 */
  pack_Parse((name,query,objectids)) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="P"},
     {Reference=length},
     {Cstring=name},
     {Cstring=query},
     {List=([{Long=0; le=false}],List.map((l -> [{Long=l; le=false}]),objectids)); size={S}; le=false}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * A password response. Note that this is also used for GSSAPI and SSPI response messages (which is really a design error, since the contained data is not a null-terminated string in that case, but can be arbitrary binary data).
 * @param password (string): The password (encrypted, if requested).
 */
  pack_PasswordMessage(password) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="p"},
     {Reference=length},
     {Cstring=password}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * A simple query.
 * @param query (string): The query string itself.
 */
  pack_Query(query) =
    length = ServerReference.create([{Long=0-1; le=false}])
    data = 
    [
     {Char="Q"},
     {Reference=length},
     {Cstring=query}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data)-1; le=false}])
    data

/**
 * The SSL request code. The value is chosen to contain 1234 in the most significant 16 bits, and 5679 in the least 16 significant bits. (To avoid confusion, this code must not be the same as any protocol version number.)
 */
  pack_SSLRequest() =
    [
     {Long=8; le=false},
     {Long=80877103; le=false}
    ]

/**
 * Auxiliary type, simple name-value pair of strings.
 * @param name (string): Name.
 * @param value (string): Value.
 */
  pack_name_value((name,value)) =
    [
     {Cstring=name},
     {Cstring=value}
    ]

/**
 * Startup message.  NOTE: No byte code in this message (historical reasons, apparently).
 * @param version (long): The protocol version number. The most significant 16 bits are the major version number. The least significant 16 bits are the minor version number.
 * @param parameters (name_value list): One or more pairs of parameter name and value strings.
 */
  pack_StartupMessage((version,parameters)) =
    length = ServerReference.create([{Long=0; le=false}])
    data = 
    [
     {Reference=length},
     {Long=version; le=false},
     {List=([{Pack=pack_name_value(("",""))}],List.map((v -> [{Pack=pack_name_value(v)}]),parameters)); null={B}}
    ]
    do ServerReference.set(length,[{Long=Pack.Encode.packlen(data); le=false}])
    data

/**
 * A Sync command.
 */
  pack_Sync() =
    [
     {Char="S"},
     {Long=4; le=false}
    ]

/**
 * Termination.
 */
  pack_Terminate() =
    [
     {Char="X"},
     {Long=4; le=false}
    ]

/**
 * An authentication request.
 */
  unpack_AuthenticationOk(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(8,0))} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationOk"}
    | {~failure} -> {~failure}

/**
 * An authentication request.
 */
  unpack_AuthenticationKerberosV5(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(8,2))} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationKerberosV5"}
    | {~failure} -> {~failure}

/**
 * An authentication request.
 */
  unpack_AuthenticationCleartextPassword(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(8,3))} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationCleartextPassword"}
    | {~failure} -> {~failure}

/**
 * An authentication request.
 * @return salt (binary): The salt to use when encrypting the password.
 */
  unpack_AuthenticationMD5Password(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.long_be,U.fixed_binary(_,4)) with
    | {success=(input,(12,5,salt))} -> {success=(input,salt)}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationMD5Password"}
    | {~failure} -> {~failure}

/**
 * An authentication request.
 */
  unpack_AuthenticationSCMCredential(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(8,6))} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationSCMCredential"}
    | {~failure} -> {~failure}

/**
 * An authentication request.
 */
  unpack_AuthenticationGSS(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(8,7))} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationGSS"}
    | {~failure} -> {~failure}

/**
 * An authentication request.
 */
  unpack_AuthenticationSSPI(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(8,9))} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationSSPI"}
    | {~failure} -> {~failure}

  unpack_AuthenticationGSSContinue(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.long_be,U.binary_no_prefix(_)) with
    | {success=(input,(_,8,data))} -> {success=(input,data)}
    | {success=_} -> {failure="Bad constant in unpack_AuthenticationGSSContinue"}
    | {~failure} -> {~failure}

/**
 * Cancellation key data. The frontend must save these values if it wishes to be able to issue CancelRequest messages later.
 * @return processid (long): The process ID of this backend.
 * @return secret_key (long): The secret key of this backend.
 */
  unpack_BackendKeyData(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.long_be,U.long_be) with
    | {success=(input,(_,processid,secret_key))} -> {success=(input,(processid,secret_key))}
    | {~failure} -> {~failure}

/**
 * A Bind-complete indicator.
 */
  unpack_BindComplete(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_BindComplete"}
    | {~failure} -> {~failure}

/**
 * A Close-complete indicator.
 */
  unpack_CloseComplete(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_CloseComplete"}
    | {~failure} -> {~failure}

/**
 * A command-completed response.
 * @return tag (string): The command tag. This is usually a single word that identifies which SQL command was completed.
 */
  unpack_CommandComplete(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.cstring) with
    | {success=(input,(_,tag))} -> {success=(input,tag)}
    | {~failure} -> {~failure}

/**
 * COPY data.
 * @return data (binary): 
 */
  unpack_CopyDataB(input:Pack.input) =
    match U.binary(Pack.bigEndian, {L}, input) with
    | {success=(input,data)} -> {success=(input,data)}
    | {~failure} -> {~failure}

/**
 * A COPY-complete indicator.
 */
  unpack_CopyDoneB(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_CopyDoneB"}
    | {~failure} -> {~failure}

/**
 * COPY-failure indicator.
 * @return error_message (string): An error message to report as the cause of failure.
 */
  unpack_CopyFail(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.cstring) with
    | {success=(input,(_,error_message))} -> {success=(input,error_message)}
    | {~failure} -> {~failure}

/**
 * Start Copy In response. The frontend must now send copy-in data (if not prepared to do so, send a CopyFail message).
 * @return is_textual (byte): 0 indicates the overall COPY format is textual (rows separated by newlines, columns separated by separator characters, etc). 1 indicates the overall copy format is binary (similar to DataRow format).
 * @return column_codes (unsigned short list): The format codes to be used for each column. Each must presently be zero (text) or one (binary). All must be zero if the overall copy format is textual.
 */
  unpack_CopyInResponse(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.octet,U.list(U.ushort_be, Pack.bigEndian, {S}, _)) with
    | {success=(input,(_,is_textual,column_codes))} -> {success=(input,(is_textual,column_codes))}
    | {~failure} -> {~failure}

/**
 * Start Copy Out response. This message will be followed by copy-out data.
 * @return is_textual (byte): 0 indicates the overall COPY format is textual (rows separated by newlines, columns separated by separator characters, etc). 1 indicates the overall copy format is binary (similar to DataRow format).
 * @return column_codes (unsigned short list): The format codes to be used for each column. Each must presently be zero (text) or one (binary). All must be zero if the overall copy format is textual.
 */
  unpack_CopyOutResponse(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.octet,U.list(U.ushort_be, Pack.bigEndian, {S}, _)) with
    | {success=(input,(_,is_textual,column_codes))} -> {success=(input,(is_textual,column_codes))}
    | {~failure} -> {~failure}

/**
 * Start Copy Both response. This message is used only for Streaming Replication.
 * @return is_textual (byte): 0 indicates the overall COPY format is textual (rows separated by newlines, columns separated by separator characters, etc). 1 indicates the overall copy format is binary (similar to DataRow format).
 * @return column_codes (unsigned short list): The format codes to be used for each column. Each must presently be zero (text) or one (binary). All must be zero if the overall copy format is textual.
 */
  unpack_CopyBothResponse(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.octet,U.list(U.ushort_le, Pack.bigEndian, {S}, _)) with
    | {success=(input,(_,is_textual,column_codes))} -> {success=(input,(is_textual,column_codes))}
    | {~failure} -> {~failure}

/**
 * Data row.
 * @return arguments (binary list): Column values, in the format indicated by the associated format code.
 */
  unpack_DataRow(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.list(U.binary(Pack.bigEndian, {L}, _), Pack.bigEndian, {S}, _)) with
    | {success=(input,(_,arguments))} -> {success=(input,arguments)}
    | {~failure} -> {~failure}

/**
 * Response to an empty query string. (This substitutes for CommandComplete.)
 */
  unpack_EmptyQueryResponse(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_EmptyQueryResponse"}
    | {~failure} -> {~failure}

/**
 * @return code (unsigned byte): A code identifying the field type; if zero, this is the message terminator and no string follows.
 * @return msg (string): The field value.
 */
  unpack_code_msg(input:Pack.input) =
    match U.tuple2(input,U.uoctet,U.cstring) with
    | {success=(input,(code,msg))} -> {success=(input,(code,msg))}
    | {~failure} -> {~failure}

/**
 * An error response.
 */
  unpack_ErrorResponse(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.ntlist(unpack_code_msg, {B}, _)) with
    | {success=(input,(_,error_messages))} -> {success=(input,error_messages)}
    | {~failure} -> {~failure}

/**
 * Function call result.
 * @return results (binary): The value of the function result, in the format indicated by the associated format code.
 */
  unpack_FunctionCallResponse(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.binary(Pack.bigEndian, {L}, _)) with
    | {success=(input,(_,results))} -> {success=(input,results)}
    | {~failure} -> {~failure}

/**
 * No-data indicator.
 */
  unpack_NoData(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_NoData"}
    | {~failure} -> {~failure}

/**
 * @return code (unsigned byte): A code identifying the field type; if zero, this is the message terminator and no string follows.
 * @return notice (string): The field value.
 */
  unpack_code_notice(input:Pack.input) =
    match U.tuple2(input,U.uoctet,U.cstring) with
    | {success=(input,(code,notice))} -> {success=(input,(code,notice))}
    | {~failure} -> {~failure}

/**
 * A notice.
 */
  unpack_NoticeResponse(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.ntlist(unpack_code_notice, {B}, _)) with
    | {success=(input,(_,notice_messages))} -> {success=(input,notice_messages)}
    | {~failure} -> {~failure}

/**
 * A notification response.
 * @return processid (unsigned long): The process ID of the notifying backend process.
 * @return channel_name (string): The name of the channel that the notify has been raised on.
 * @return payload (string): The "payload" string passed from the notifying process.
 */
  unpack_NotificationResponse(input:Pack.input) =
    match U.tuple4(input,U.long_be,U.ulong_be,U.cstring,U.cstring) with
    | {success=(input,(_,processid,channel_name,payload))} -> {success=(input,(processid,channel_name,payload))}
    | {~failure} -> {~failure}

/**
 * A parameter description.
 * @return objectids (unsigned long list): Object IDs of the parameter data type.
 */
  unpack_ParameterDescription(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.list(U.ulong_be, Pack.bigEndian, {S}, _)) with
    | {success=(input,(_,objectids))} -> {success=(input,objectids)}
    | {~failure} -> {~failure}

/**
 * A run-time parameter status report.
 * @return name (string): The name of the run-time parameter being reported.
 * @return value (string): The current value of the parameter.
 */
  unpack_ParameterStatus(input:Pack.input) =
    match U.tuple3(input,U.long_be,U.cstring,U.cstring) with
    | {success=(input,(_,name,value))} -> {success=(input,(name,value))}
    | {~failure} -> {~failure}

/**
 * Parse-complete indicator.
 */
  unpack_ParseComplete(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_ParseComplete"}
    | {~failure} -> {~failure}

/**
 * A portal-suspended indicator. Note this only appears if an Execute message's row-count limit was reached.
 */
  unpack_PortalSuspended(input:Pack.input) =
    match U.long_be(input) with
    | {success=(input,4)} -> {success=(input,{})}
    | {success=_} -> {failure="Bad constant in unpack_PortalSuspended"}
    | {~failure} -> {~failure}

/**
 * ReadyForQuery is sent whenever the backend is ready for a new query cycle.
 * @return status (char): Current backend transaction status indicator. Possible values are 'I' if idle (not in a transaction block); 'T' if in a transaction block; or 'E' if in a failed transaction block (queries will be rejected until block is ended).
 */
  unpack_ReadyForQuery(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.char) with
    | {success=(input,(5,status))} -> {success=(input,status)}
    | {success=_} -> {failure="Bad constant in unpack_ReadyForQuery"}
    | {~failure} -> {~failure}

/**
 * Individual row description data.
 * @return name (string): The field name.
 * @return table_id (unsigned long): If the field can be identified as a column of a specific table, the object ID of the table; otherwise zero.
 * @return table_attribute_number (unsigned short): If the field can be identified as a column of a specific table, the attribute number of the column; otherwise zero.
 * @return type_id (unsigned long): The object ID of the field's data type.
 * @return data_type_size (short): The data type size (see pg_type.typlen). Note that negative values denote variable-width types.
 * @return type_modifier (long): The type modifier (see pg_attribute.atttypmod). The meaning of the modifier is type-specific.
 * @return format_code (short): The format code being used for the field. Currently will be zero (text) or one (binary). In a RowDescription returned from the statement variant of Describe, the format code is not yet known and will always be zero.
 */
  unpack_row_desc(input:Pack.input) =
    match U.tuple7(input,U.cstring,U.ulong_be,U.ushort_be,U.ulong_be,U.short_be,U.long_be,U.short_be) with
    | {success=(input,(name,table_id,table_attribute_number,type_id,data_type_size,type_modifier,format_code))} -> {success=(input,(name,table_id,table_attribute_number,type_id,data_type_size,type_modifier,format_code))}
    | {~failure} -> {~failure}

/**
 * A row description.
 * @return descriptions (row_desc list): List of row descriptions.
 */
  unpack_RowDescription(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.list(unpack_row_desc, Pack.bigEndian, {S}, _)) with
    | {success=(input,(_,descriptions))} -> {success=(input,descriptions)}
    | {~failure} -> {~failure}

/**
 * Unpack two int32 values
 * Used by nested coding parser for Authentication
 */
  unpack_two_int32s(input:Pack.input) =
    match U.tuple2(input,U.long_be,U.long_be) with
    | {success=(input,(size,code))} -> {success=(input,(size,code))}
    | {~failure} -> {~failure}

/**
 * Empty parser for Ok Authentication submessage
 */
  unpack_Ok(input:Pack.input) =
    {success=(input,{})}

/**
 * Empty parser for KerberosV5 Authentication submessage
 */
  unpack_KerberosV5(input:Pack.input) =
    {success=(input,{})}

/**
 * Empty parser for CleartextPassword Authentication submessage
 */
  unpack_CleartextPassword(input:Pack.input) =
    {success=(input,{})}

/**
 * Empty parser for MD5Password Authentication submessage
 */
  unpack_MD5Password(input:Pack.input) =
    match U.fixed_binary(input,4) with
    | {success=(input,salt)} -> {success=(input,salt)}
    | {~failure} -> {~failure}

/**
 * Empty parser for SCMCredential Authentication submessage
 */
  unpack_SCMCredential(input:Pack.input) =
    {success=(input,{})}

/**
 * Empty parser for GSS Authentication submessage
 */
  unpack_GSS(input:Pack.input) =
    {success=(input,{})}

/**
 * Empty parser for SSPI Authentication submessage
 */
  unpack_SSPI(input:Pack.input) =
    {success=(input,{})}

/**
 * Parser for GSSContinue Authentication submessage
 */
  unpack_GSSContinue(input:Pack.input) =
    match U.binary_no_prefix(input) with
    | {success=(input,data)} -> {success=(input,data)}
    | {~failure} -> {~failure}

/**
 * The main read loop from Postgres server.
 * The Postgres docs recommend having a single read point for all messages
 * from the server.  Here we handle all our supported messages and call the
 * requested continuations, update the connection object and return a suitable
 * status value.
 * 
 * @return Authentication ("R"): Authentication message (subclass, see Authentication)
 * @return BackendKeyData ("K"): Keys needed for cancellation facilities, stored in connection
 * @return BindComplete ("2"): Finished Bind operation, no action required (may be deferred)
 * @return CloseComplete ("3"): Finished Close operation, no action required (may be deferred)
 * @return CommandComplete ("C"): Command completed, stored in list of completed commands (may be deferred)
 * @return CopyDataB ("d"): Copy data message, unimplemented
 * @return CopyDoneB ("c"): Copy data complete, unimplemented
 * @return CopyOutResponse ("H"): Copy data out message, unimplemented
 * @return CopyBothResponse ("W"): Copy data in and out, unimplemented
 * @return DataRow ("D"): Data row, description should already have been received, call row continuation
 * @return EmptyQueryResponse ("I"): Query was empty, replaces description+rows
 * @return ErrorResponse ("E"): Postgres error message, call error continuation
 * @return FunctionCallResponse ("V"): Function call return, unimplemented
 * @return NoData ("n"): No data message, no action required
 * @return NoticeResponse ("N"): Postgres notice, call error continuaion
 * @return NotificationResponse ("A"): Notification, unimplemented
 * @return ParameterDescription ("t"): Description of results for execute command, stored in connection
 * @return ParameterStatus ("S"): Current value of the indicated parameter, stored in connection
 * @return ParseComplete ("1"): Finished Parse operation, no action required (may be deferred)
 * @return PortalSuspended ("s"): Execute command went into suspended state, set flag in connection
 * @return ReadyForQuery ("Z"): Terminates SQL command sequence, call final continuation
 * @return RowDescription ("T"): Description of requested (or implied by simple query) row
 */
  unpack_PostgresReply(input:Pack.input) =
    match U.char(input) with
    | {success=(input,"R")} -> 
      match unpack_Authentication(input) with
      | {success=(input,Authentication)} -> {success=(input,{~Authentication})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"K")} -> 
      match unpack_BackendKeyData(input) with
      | {success=(input,BackendKeyData)} -> {success=(input,{~BackendKeyData})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"2")} -> 
      match unpack_BindComplete(input) with
      | {success=(input,BindComplete)} -> {success=(input,{~BindComplete})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"3")} -> 
      match unpack_CloseComplete(input) with
      | {success=(input,CloseComplete)} -> {success=(input,{~CloseComplete})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"C")} -> 
      match unpack_CommandComplete(input) with
      | {success=(input,CommandComplete)} -> {success=(input,{~CommandComplete})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"d")} -> 
      match unpack_CopyDataB(input) with
      | {success=(input,CopyDataB)} -> {success=(input,{~CopyDataB})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"c")} -> 
      match unpack_CopyDoneB(input) with
      | {success=(input,CopyDoneB)} -> {success=(input,{~CopyDoneB})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"H")} -> 
      match unpack_CopyOutResponse(input) with
      | {success=(input,CopyOutResponse)} -> {success=(input,{~CopyOutResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"W")} -> 
      match unpack_CopyBothResponse(input) with
      | {success=(input,CopyBothResponse)} -> {success=(input,{~CopyBothResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"D")} -> 
      match unpack_DataRow(input) with
      | {success=(input,DataRow)} -> {success=(input,{~DataRow})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"I")} -> 
      match unpack_EmptyQueryResponse(input) with
      | {success=(input,EmptyQueryResponse)} -> {success=(input,{~EmptyQueryResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"E")} -> 
      match unpack_ErrorResponse(input) with
      | {success=(input,ErrorResponse)} -> {success=(input,{~ErrorResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"V")} -> 
      match unpack_FunctionCallResponse(input) with
      | {success=(input,FunctionCallResponse)} -> {success=(input,{~FunctionCallResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"n")} -> 
      match unpack_NoData(input) with
      | {success=(input,NoData)} -> {success=(input,{~NoData})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"N")} -> 
      match unpack_NoticeResponse(input) with
      | {success=(input,NoticeResponse)} -> {success=(input,{~NoticeResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"A")} -> 
      match unpack_NotificationResponse(input) with
      | {success=(input,NotificationResponse)} -> {success=(input,{~NotificationResponse})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"t")} -> 
      match unpack_ParameterDescription(input) with
      | {success=(input,ParameterDescription)} -> {success=(input,{~ParameterDescription})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"S")} -> 
      match unpack_ParameterStatus(input) with
      | {success=(input,ParameterStatus)} -> {success=(input,{~ParameterStatus})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"1")} -> 
      match unpack_ParseComplete(input) with
      | {success=(input,ParseComplete)} -> {success=(input,{~ParseComplete})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"s")} -> 
      match unpack_PortalSuspended(input) with
      | {success=(input,PortalSuspended)} -> {success=(input,{~PortalSuspended})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"Z")} -> 
      match unpack_ReadyForQuery(input) with
      | {success=(input,ReadyForQuery)} -> {success=(input,{~ReadyForQuery})}
      | {~failure} -> {~failure}
      end
    | {success=(input,"T")} -> 
      match unpack_RowDescription(input) with
      | {success=(input,RowDescription)} -> {success=(input,{~RowDescription})}
      | {~failure} -> {~failure}
      end
    | {success=(_,code)} -> {failure="Bad code {code} in unpack_PostgresReply"}
    | {~failure} -> {~failure}

/**
 * Second level parser for authentication messages which all have the same code "R".
 * There is a second (integer) code which comes after the message size so for
 * convenience we disambiguate on the length and the second code.
 * 
 * @return Ok ((8,0)): Ok returned when authentication succeeds
 * @return KerberosV5 ((8,2)): KerberosV5: Initiate Kerberos authentication
 * @return CleartextPassword ((8,3)): CleartextPassword: request clear text password
 * @return MD5Password ((12,5)): MD5Password: request MD5 encoded password
 * @return SCMCredential ((8,6)): SCMCredential: Initiate SCM authentication
 * @return GSS ((8,7)): GSS: Initiate GSS authentication
 * @return SSPI ((8,9)): SSPI: Initiate SSPI authentication
 * @return GSSContinue ((_,8)): GSSContinue: part of GSS authentication
 */
  unpack_Authentication(input:Pack.input) =
    match unpack_two_int32s(input) with
    | {success=(input,(8,0))} -> 
      match unpack_Ok(input) with
      | {success=(input,Ok)} -> {success=(input,{~Ok})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(8,2))} -> 
      match unpack_KerberosV5(input) with
      | {success=(input,KerberosV5)} -> {success=(input,{~KerberosV5})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(8,3))} -> 
      match unpack_CleartextPassword(input) with
      | {success=(input,CleartextPassword)} -> {success=(input,{~CleartextPassword})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(12,5))} -> 
      match unpack_MD5Password(input) with
      | {success=(input,MD5Password)} -> {success=(input,{~MD5Password})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(8,6))} -> 
      match unpack_SCMCredential(input) with
      | {success=(input,SCMCredential)} -> {success=(input,{~SCMCredential})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(8,7))} -> 
      match unpack_GSS(input) with
      | {success=(input,GSS)} -> {success=(input,{~GSS})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(8,9))} -> 
      match unpack_SSPI(input) with
      | {success=(input,SSPI)} -> {success=(input,{~SSPI})}
      | {~failure} -> {~failure}
      end
    | {success=(input,(_,8))} -> 
      match unpack_GSSContinue(input) with
      | {success=(input,GSSContinue)} -> {success=(input,{~GSSContinue})}
      | {~failure} -> {~failure}
      end
    | {success=(_,code)} -> {failure="Bad code {code} in unpack_Authentication"}
    | {~failure} -> {~failure}

  /** Default connection for this driver */
  default_host = ("localhost",5432)
  default_major_version = 3
  default_minor_version = 0

  /** Build the connection module */
  Conn = ApilibConnection(default_host)

  /** Open connection object (doesn't connect until read/write received) */
  connect(name:string) : Apigen.outcome(ApigenLib.connection) =
    conn = Conn.init("postgres",name)
    conn = Conn.custom_read_packet(conn, Conn.read_packet_prefixed({Conn.default_length with
      offset=1; 
      le=false; 
      signed=false; 
      size={L}
    }))
    Conn.connect(conn, default_host)

  /** Close connection (closes all open connections in pool) */
  close(c:Apigen.outcome(ApigenLib.connection)) : Apigen.outcome(ApigenLib.connection) =
    match c with
    | {success=c} -> {success=Conn.close(c)}
    | {~failure} -> {~failure}

  /** Send startup message */
  start(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_StartupMessage(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Return requested password (MD5-encoded, if requested) */
  password(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_PasswordMessage(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Send simple Query command */
  query(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_Query(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Send Parse query */
  parse(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_Parse(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Send Bind query to portal */
  bind(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_Bind(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Execute named portal */
  execute(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_Execute(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Get returned values for requested portal */
  describe(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_Describe(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Close portal or statement */
  closePS(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_Close(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Sync to given operations (processes messages until server ready) */
  @private packed_Sync =
    match Pack.Encode.pack(Pg.pack_Sync()) with
    | {success=binary} -> binary
    | {~failure} -> @fail("Failed to pre-pack message Sync {failure}")
  sync(conn:Apigen.outcome(ApigenLib.connection)) =
    Pg.Conn.snd(conn,packed_Sync)

  /** Flush current operations (processes messages until server ready) */
  @private packed_Flush =
    match Pack.Encode.pack(Pg.pack_Flush()) with
    | {success=binary} -> binary
    | {~failure} -> @fail("Failed to pre-pack message Flush {failure}")
  flush(conn:Apigen.outcome(ApigenLib.connection)) =
    Pg.Conn.snd(conn,packed_Flush)

  /** Send terminate message */
  @private packed_Terminate =
    match Pack.Encode.pack(Pg.pack_Terminate()) with
    | {success=binary} -> binary
    | {~failure} -> @fail("Failed to pre-pack message Terminate {failure}")
  terminate(conn:Apigen.outcome(ApigenLib.connection)) =
    Pg.Conn.snd(conn,packed_Terminate)

  /** Send cancellation message */
  cancel(conn:Apigen.outcome(ApigenLib.connection),params) =
    data = Pg.pack_CancelRequest(params)
    match Pack.Encode.pack(data) with
    | {success=binary} -> Pg.Conn.snd(conn,binary)
    | {~failure} -> {failure={pack=failure}}

  /** Read in coded reply from postgres server */
  reply(conn:Apigen.outcome(ApigenLib.connection)) =
    match Pg.Conn.rcv(conn) with
    | {success=binary} -> 
      match Pg.unpack_PostgresReply({~binary; pos=0}) with
      | {success=reply} -> {success=reply.f2}
      | {~failure} -> {failure={pack=failure}}
      end
    | {~failure} -> {~failure}

}}

// End of Pg

