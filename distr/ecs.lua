require('ffi').cdef[[
typedef uint8_t ecs_flags8_t;
typedef uint16_t ecs_flags16_t;
typedef uint32_t ecs_flags32_t;
typedef uint64_t ecs_flags64_t;
typedef int32_t ecs_size_t;
typedef struct ecs_allocator_t ecs_allocator_t;
typedef uint64_t ecs_id_t;
typedef ecs_id_t ecs_entity_t;
typedef struct {
    ecs_id_t *array;    
    int32_t count;      
} ecs_type_t;
typedef struct ecs_world_t ecs_world_t;
typedef struct ecs_stage_t ecs_stage_t;
typedef struct ecs_table_t ecs_table_t;
typedef struct ecs_term_t ecs_term_t;
typedef struct ecs_query_t ecs_query_t;
typedef struct ecs_observer_t ecs_observer_t;
typedef struct ecs_observable_t ecs_observable_t;
typedef struct ecs_iter_t ecs_iter_t;
typedef struct ecs_ref_t ecs_ref_t;
typedef struct ecs_type_hooks_t ecs_type_hooks_t;
typedef struct ecs_type_info_t ecs_type_info_t;
typedef struct ecs_record_t ecs_record_t;
typedef struct ecs_component_record_t ecs_component_record_t;
typedef void ecs_poly_t;
typedef struct ecs_mixins_t ecs_mixins_t;
typedef struct ecs_header_t {
    int32_t type;               
    int32_t refcount;           
    ecs_mixins_t *mixins;       
} ecs_header_t;
typedef struct ecs_table_record_t ecs_table_record_t;
typedef struct ecs_vec_t {
    void *array;
    int32_t count;
    int32_t size;
} ecs_vec_t;
__declspec(dllimport)
void ecs_vec_init(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
void ecs_vec_init_w_dbg_info(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count,
    const char *type_name);
__declspec(dllimport)
void ecs_vec_init_if(
    ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
void ecs_vec_fini(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
ecs_vec_t* ecs_vec_reset(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
void ecs_vec_clear(
    ecs_vec_t *vec);
__declspec(dllimport)
void* ecs_vec_append(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
void ecs_vec_remove(
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem);
__declspec(dllimport)
void ecs_vec_remove_ordered(
    ecs_vec_t *v,
    ecs_size_t size,
    int32_t index);
__declspec(dllimport)
void ecs_vec_remove_last(
    ecs_vec_t *vec);
__declspec(dllimport)
ecs_vec_t ecs_vec_copy(
    struct ecs_allocator_t *allocator,
    const ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
ecs_vec_t ecs_vec_copy_shrink(
    struct ecs_allocator_t *allocator,
    const ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
void ecs_vec_reclaim(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size);
__declspec(dllimport)
void ecs_vec_set_size(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
void ecs_vec_set_min_size(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
void ecs_vec_set_min_size_w_type_info(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count,
    const ecs_type_info_t *ti);
__declspec(dllimport)
void ecs_vec_set_min_count(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
void ecs_vec_set_min_count_zeromem(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
void ecs_vec_set_count(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
void ecs_vec_set_count_w_type_info(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count,
    const ecs_type_info_t *ti);
__declspec(dllimport)
void ecs_vec_set_min_count_w_type_info(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count,
    const ecs_type_info_t *ti);
__declspec(dllimport)
void* ecs_vec_grow(
    struct ecs_allocator_t *allocator,
    ecs_vec_t *vec,
    ecs_size_t size,
    int32_t elem_count);
__declspec(dllimport)
int32_t ecs_vec_count(
    const ecs_vec_t *vec);
__declspec(dllimport)
int32_t ecs_vec_size(
    const ecs_vec_t *vec);
__declspec(dllimport)
void* ecs_vec_get(
    const ecs_vec_t *vec,
    ecs_size_t size,
    int32_t index);
__declspec(dllimport)
void* ecs_vec_first(
    const ecs_vec_t *vec);
__declspec(dllimport)
void* ecs_vec_last(
    const ecs_vec_t *vec,
    ecs_size_t size);
typedef struct ecs_sparse_t {
    ecs_vec_t dense;         
    ecs_vec_t pages;         
    ecs_size_t size;         
    int32_t count;           
    uint64_t max_id;         
    struct ecs_allocator_t *allocator;
    struct ecs_block_allocator_t *page_allocator;
} ecs_sparse_t;
__declspec(dllimport)
void flecs_sparse_init(
    ecs_sparse_t *result,
    struct ecs_allocator_t *allocator,
    struct ecs_block_allocator_t *page_allocator,
    ecs_size_t size);
__declspec(dllimport)
void flecs_sparse_fini(
    ecs_sparse_t *sparse);
__declspec(dllimport)
void flecs_sparse_clear(
    ecs_sparse_t *sparse);
__declspec(dllimport)
void* flecs_sparse_add(
    ecs_sparse_t *sparse,
    ecs_size_t elem_size);
__declspec(dllimport)
uint64_t flecs_sparse_last_id(
    const ecs_sparse_t *sparse);
__declspec(dllimport)
uint64_t flecs_sparse_new_id(
    ecs_sparse_t *sparse);
__declspec(dllimport)
bool flecs_sparse_remove(
    ecs_sparse_t *sparse,
    ecs_size_t size,
    uint64_t id);
bool flecs_sparse_remove_w_gen(
    ecs_sparse_t *sparse,
    ecs_size_t size,
    uint64_t id);
__declspec(dllimport)
bool flecs_sparse_is_alive(
    const ecs_sparse_t *sparse,
    uint64_t id);
__declspec(dllimport)
void* flecs_sparse_get_dense(
    const ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    int32_t index);
__declspec(dllimport)
int32_t flecs_sparse_count(
    const ecs_sparse_t *sparse);
bool flecs_sparse_has(
    const ecs_sparse_t *sparse,
    uint64_t id);
__declspec(dllimport)
void* flecs_sparse_get(
    const ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    uint64_t id);
__declspec(dllimport)
void* flecs_sparse_insert(
    ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    uint64_t id);
__declspec(dllimport)
void* flecs_sparse_ensure(
    ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    uint64_t id,
    bool *is_new);
__declspec(dllimport)
void* flecs_sparse_ensure_fast(
    ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    uint64_t id);
__declspec(dllimport)
const uint64_t* flecs_sparse_ids(
    const ecs_sparse_t *sparse);
__declspec(dllimport)
void flecs_sparse_shrink(
    ecs_sparse_t *sparse);
__declspec(dllimport)
void ecs_sparse_init(
    ecs_sparse_t *sparse,
    ecs_size_t elem_size);
__declspec(dllimport)
void* ecs_sparse_add(
    ecs_sparse_t *sparse,
    ecs_size_t elem_size);
__declspec(dllimport)
uint64_t ecs_sparse_last_id(
    const ecs_sparse_t *sparse);
__declspec(dllimport)
int32_t ecs_sparse_count(
    const ecs_sparse_t *sparse);
__declspec(dllimport)
void* ecs_sparse_get_dense(
    const ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    int32_t index);
__declspec(dllimport)
void* ecs_sparse_get(
    const ecs_sparse_t *sparse,
    ecs_size_t elem_size,
    uint64_t id);
typedef struct ecs_map_t ecs_map_t;
typedef struct ecs_block_allocator_block_t {
    void *memory;
    struct ecs_block_allocator_block_t *next;
} ecs_block_allocator_block_t;
typedef struct ecs_block_allocator_chunk_header_t {
    struct ecs_block_allocator_chunk_header_t *next;
} ecs_block_allocator_chunk_header_t;
typedef struct ecs_block_allocator_t {
    int32_t data_size;
    int32_t chunk_size;
    int32_t chunks_per_block;
    int32_t block_size;
    ecs_block_allocator_chunk_header_t *head;
    ecs_block_allocator_block_t *block_head;
} ecs_block_allocator_t;
__declspec(dllimport)
void flecs_ballocator_init(
    ecs_block_allocator_t *ba,
    ecs_size_t size);
__declspec(dllimport)
ecs_block_allocator_t* flecs_ballocator_new(
    ecs_size_t size);
__declspec(dllimport)
void flecs_ballocator_fini(
    ecs_block_allocator_t *ba);
__declspec(dllimport)
void flecs_ballocator_free(
    ecs_block_allocator_t *ba);
__declspec(dllimport)
void* flecs_balloc(
    ecs_block_allocator_t *allocator);
__declspec(dllimport)
void* flecs_balloc_w_dbg_info(
    ecs_block_allocator_t *allocator,
    const char *type_name);
__declspec(dllimport)
void* flecs_bcalloc(
    ecs_block_allocator_t *allocator);
__declspec(dllimport)
void* flecs_bcalloc_w_dbg_info(
    ecs_block_allocator_t *allocator,
    const char *type_name);
__declspec(dllimport)
void flecs_bfree(
    ecs_block_allocator_t *allocator, 
    void *memory);
__declspec(dllimport)
void flecs_bfree_w_dbg_info(
    ecs_block_allocator_t *allocator, 
    void *memory,
    const char *type_name);
__declspec(dllimport)
void* flecs_brealloc(
    ecs_block_allocator_t *dst, 
    ecs_block_allocator_t *src, 
    void *memory);
__declspec(dllimport)
void* flecs_brealloc_w_dbg_info(
    ecs_block_allocator_t *dst, 
    ecs_block_allocator_t *src, 
    void *memory,
    const char *type_name);
__declspec(dllimport)
void* flecs_bdup(
    ecs_block_allocator_t *ba, 
    void *memory);
typedef struct ecs_stack_page_t {
    void *data;
    struct ecs_stack_page_t *next;
    int16_t sp;
    uint32_t id;
} ecs_stack_page_t;
typedef struct ecs_stack_cursor_t {
    struct ecs_stack_cursor_t *prev;
    struct ecs_stack_page_t *page;
    int16_t sp;
    bool is_free;
    struct ecs_stack_t *owner;
} ecs_stack_cursor_t;
typedef struct ecs_stack_t {
    ecs_stack_page_t *first;
    ecs_stack_page_t *tail_page;
    ecs_stack_cursor_t *tail_cursor;
    int32_t cursor_count;
} ecs_stack_t;
__declspec(dllimport)
void flecs_stack_init(
    ecs_stack_t *stack);
__declspec(dllimport)
void flecs_stack_fini(
    ecs_stack_t *stack);
__declspec(dllimport)
void* flecs_stack_alloc(
    ecs_stack_t *stack, 
    ecs_size_t size,
    ecs_size_t align);
__declspec(dllimport)
void* flecs_stack_calloc(
    ecs_stack_t *stack, 
    ecs_size_t size,
    ecs_size_t align);
__declspec(dllimport)
void flecs_stack_free(
    void *ptr,
    ecs_size_t size);
void flecs_stack_reset(
    ecs_stack_t *stack);
__declspec(dllimport)
ecs_stack_cursor_t* flecs_stack_get_cursor(
    ecs_stack_t *stack);
__declspec(dllimport)
void flecs_stack_restore_cursor(
    ecs_stack_t *stack,
    ecs_stack_cursor_t *cursor);
typedef uint64_t ecs_map_data_t;
typedef ecs_map_data_t ecs_map_key_t;
typedef ecs_map_data_t ecs_map_val_t;
typedef struct ecs_bucket_entry_t {
    ecs_map_key_t key;
    ecs_map_val_t value;
    struct ecs_bucket_entry_t *next;
} ecs_bucket_entry_t;
typedef struct ecs_bucket_t {
    ecs_bucket_entry_t *first;
} ecs_bucket_t;
struct ecs_map_t {
    ecs_bucket_t *buckets;
    int32_t bucket_count;
    unsigned count : 26;
    unsigned bucket_shift : 6;
    struct ecs_allocator_t *allocator;
};
typedef struct ecs_map_iter_t {
    const ecs_map_t *map;
    ecs_bucket_t *bucket;
    ecs_bucket_entry_t *entry;
    ecs_map_data_t *res;
} ecs_map_iter_t;
typedef struct ecs_map_params_t {
    struct ecs_allocator_t *allocator;
    struct ecs_block_allocator_t entry_allocator;
} ecs_map_params_t;
__declspec(dllimport)
void ecs_map_params_init(
    ecs_map_params_t *params,
    struct ecs_allocator_t *allocator);
__declspec(dllimport)
void ecs_map_params_fini(
    ecs_map_params_t *params);
__declspec(dllimport)
void ecs_map_init(
    ecs_map_t *map,
    struct ecs_allocator_t *allocator);
__declspec(dllimport)
void ecs_map_init_w_params(
    ecs_map_t *map,
    ecs_map_params_t *params);
__declspec(dllimport)
void ecs_map_init_if(
    ecs_map_t *map,
    struct ecs_allocator_t *allocator);
__declspec(dllimport)
void ecs_map_init_w_params_if(
    ecs_map_t *result,
    ecs_map_params_t *params);
__declspec(dllimport)
void ecs_map_fini(
    ecs_map_t *map);
__declspec(dllimport)
ecs_map_val_t* ecs_map_get(
    const ecs_map_t *map,
    ecs_map_key_t key);
__declspec(dllimport)
void* ecs_map_get_deref_(
    const ecs_map_t *map,
    ecs_map_key_t key);
__declspec(dllimport)
ecs_map_val_t* ecs_map_ensure(
    ecs_map_t *map,
    ecs_map_key_t key);
__declspec(dllimport)
void* ecs_map_ensure_alloc(
    ecs_map_t *map,
    ecs_size_t elem_size,
    ecs_map_key_t key);
__declspec(dllimport)
void ecs_map_insert(
    ecs_map_t *map,
    ecs_map_key_t key,
    ecs_map_val_t value);
__declspec(dllimport)
void* ecs_map_insert_alloc(
    ecs_map_t *map,
    ecs_size_t elem_size,
    ecs_map_key_t key);
__declspec(dllimport)
ecs_map_val_t ecs_map_remove(
    ecs_map_t *map,
    ecs_map_key_t key);
__declspec(dllimport)
void ecs_map_remove_free(
    ecs_map_t *map,
    ecs_map_key_t key);
__declspec(dllimport)
void ecs_map_clear(
    ecs_map_t *map);
__declspec(dllimport)
ecs_map_iter_t ecs_map_iter(
    const ecs_map_t *map);
__declspec(dllimport)
bool ecs_map_next(
    ecs_map_iter_t *iter);
__declspec(dllimport)
void ecs_map_copy(
    ecs_map_t *dst,
    const ecs_map_t *src);
__declspec(dllimport) extern int64_t ecs_block_allocator_alloc_count;
__declspec(dllimport) extern int64_t ecs_block_allocator_free_count;
__declspec(dllimport) extern int64_t ecs_stack_allocator_alloc_count;
__declspec(dllimport) extern int64_t ecs_stack_allocator_free_count;
struct ecs_allocator_t {
    ecs_block_allocator_t chunks;
    struct ecs_sparse_t sizes; 
};
__declspec(dllimport)
void flecs_allocator_init(
    ecs_allocator_t *a);
__declspec(dllimport)
void flecs_allocator_fini(
    ecs_allocator_t *a);
__declspec(dllimport)
ecs_block_allocator_t* flecs_allocator_get(
    ecs_allocator_t *a, 
    ecs_size_t size);
__declspec(dllimport)
char* flecs_strdup(
    ecs_allocator_t *a, 
    const char* str);
__declspec(dllimport)
void flecs_strfree(
    ecs_allocator_t *a, 
    char* str);
__declspec(dllimport)
void* flecs_dup(
    ecs_allocator_t *a,
    ecs_size_t size,
    const void *src);
typedef struct ecs_strbuf_list_elem {
    int32_t count;
    const char *separator;
} ecs_strbuf_list_elem;
typedef struct ecs_strbuf_t {
    char *content;
    ecs_size_t length;
    ecs_size_t size;
    ecs_strbuf_list_elem list_stack[(32)];
    int32_t list_sp;
    char small_string[(512)];
} ecs_strbuf_t;
__declspec(dllimport)
void ecs_strbuf_append(
    ecs_strbuf_t *buffer,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_strbuf_vappend(
    ecs_strbuf_t *buffer,
    const char *fmt,
    va_list args);
__declspec(dllimport)
void ecs_strbuf_appendstr(
    ecs_strbuf_t *buffer,
    const char *str);
__declspec(dllimport)
void ecs_strbuf_appendch(
    ecs_strbuf_t *buffer,
    char ch);
__declspec(dllimport)
void ecs_strbuf_appendint(
    ecs_strbuf_t *buffer,
    int64_t v);
__declspec(dllimport)
void ecs_strbuf_appendflt(
    ecs_strbuf_t *buffer,
    double v,
    char nan_delim);
__declspec(dllimport)
void ecs_strbuf_appendbool(
    ecs_strbuf_t *buffer,
    bool v);
__declspec(dllimport)
void ecs_strbuf_mergebuff(
    ecs_strbuf_t *dst_buffer,
    ecs_strbuf_t *src_buffer);
__declspec(dllimport)
void ecs_strbuf_appendstrn(
    ecs_strbuf_t *buffer,
    const char *str,
    int32_t n);
__declspec(dllimport)
char* ecs_strbuf_get(
    ecs_strbuf_t *buffer);
__declspec(dllimport)
char* ecs_strbuf_get_small(
    ecs_strbuf_t *buffer);
__declspec(dllimport)
void ecs_strbuf_reset(
    ecs_strbuf_t *buffer);
__declspec(dllimport)
void ecs_strbuf_list_push(
    ecs_strbuf_t *buffer,
    const char *list_open,
    const char *separator);
__declspec(dllimport)
void ecs_strbuf_list_pop(
    ecs_strbuf_t *buffer,
    const char *list_close);
__declspec(dllimport)
void ecs_strbuf_list_next(
    ecs_strbuf_t *buffer);
__declspec(dllimport)
void ecs_strbuf_list_appendch(
    ecs_strbuf_t *buffer,
    char ch);
__declspec(dllimport)
void ecs_strbuf_list_append(
    ecs_strbuf_t *buffer,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_strbuf_list_appendstr(
    ecs_strbuf_t *buffer,
    const char *str);
__declspec(dllimport)
void ecs_strbuf_list_appendstrn(
    ecs_strbuf_t *buffer,
    const char *str,
    int32_t n);
__declspec(dllimport)
int32_t ecs_strbuf_written(
    const ecs_strbuf_t *buffer);
typedef struct ecs_time_t {
    uint32_t sec;                                 
    uint32_t nanosec;                             
} ecs_time_t;
extern int64_t ecs_os_api_malloc_count;            
extern int64_t ecs_os_api_realloc_count;           
extern int64_t ecs_os_api_calloc_count;            
extern int64_t ecs_os_api_free_count;              
typedef uintptr_t ecs_os_thread_t;                 
typedef uintptr_t ecs_os_cond_t;                   
typedef uintptr_t ecs_os_mutex_t;                  
typedef uintptr_t ecs_os_dl_t;                     
typedef uintptr_t ecs_os_sock_t;                   
typedef uint64_t ecs_os_thread_id_t;
typedef void (*ecs_os_proc_t)(void);
typedef
void (*ecs_os_api_init_t)(void);
typedef
void (*ecs_os_api_fini_t)(void);
typedef
void* (*ecs_os_api_malloc_t)(
    ecs_size_t size);
typedef
void (*ecs_os_api_free_t)(
    void *ptr);
typedef
void* (*ecs_os_api_realloc_t)(
    void *ptr,
    ecs_size_t size);
typedef
void* (*ecs_os_api_calloc_t)(
    ecs_size_t size);
typedef
char* (*ecs_os_api_strdup_t)(
    const char *str);
typedef
void* (*ecs_os_thread_callback_t)(
    void*);
typedef
ecs_os_thread_t (*ecs_os_api_thread_new_t)(
    ecs_os_thread_callback_t callback,
    void *param);
typedef
void* (*ecs_os_api_thread_join_t)(
    ecs_os_thread_t thread);
typedef
ecs_os_thread_id_t (*ecs_os_api_thread_self_t)(void);
typedef
ecs_os_thread_t (*ecs_os_api_task_new_t)(
    ecs_os_thread_callback_t callback,
    void *param);
typedef
void* (*ecs_os_api_task_join_t)(
    ecs_os_thread_t thread);
typedef
int32_t (*ecs_os_api_ainc_t)(
    int32_t *value);
typedef
int64_t (*ecs_os_api_lainc_t)(
    int64_t *value);
typedef
ecs_os_mutex_t (*ecs_os_api_mutex_new_t)(
    void);
typedef
void (*ecs_os_api_mutex_lock_t)(
    ecs_os_mutex_t mutex);
typedef
void (*ecs_os_api_mutex_unlock_t)(
    ecs_os_mutex_t mutex);
typedef
void (*ecs_os_api_mutex_free_t)(
    ecs_os_mutex_t mutex);
typedef
ecs_os_cond_t (*ecs_os_api_cond_new_t)(
    void);
typedef
void (*ecs_os_api_cond_free_t)(
    ecs_os_cond_t cond);
typedef
void (*ecs_os_api_cond_signal_t)(
    ecs_os_cond_t cond);
typedef
void (*ecs_os_api_cond_broadcast_t)(
    ecs_os_cond_t cond);
typedef
void (*ecs_os_api_cond_wait_t)(
    ecs_os_cond_t cond,
    ecs_os_mutex_t mutex);
typedef
void (*ecs_os_api_sleep_t)(
    int32_t sec,
    int32_t nanosec);
typedef
void (*ecs_os_api_enable_high_timer_resolution_t)(
    bool enable);
typedef
void (*ecs_os_api_get_time_t)(
    ecs_time_t *time_out);
typedef
uint64_t (*ecs_os_api_now_t)(void);
typedef
void (*ecs_os_api_log_t)(
    int32_t level,     
    const char *file,  
    int32_t line,      
    const char *msg);
typedef
void (*ecs_os_api_abort_t)(
    void);
typedef
ecs_os_dl_t (*ecs_os_api_dlopen_t)(
    const char *libname);
typedef
ecs_os_proc_t (*ecs_os_api_dlproc_t)(
    ecs_os_dl_t lib,
    const char *procname);
typedef
void (*ecs_os_api_dlclose_t)(
    ecs_os_dl_t lib);
typedef
char* (*ecs_os_api_module_to_path_t)(
    const char *module_id);
typedef void (*ecs_os_api_perf_trace_t)(
    const char *filename,
    size_t line,
    const char *name);
typedef struct ecs_os_api_t {
    ecs_os_api_init_t init_;                       
    ecs_os_api_fini_t fini_;                       
    ecs_os_api_malloc_t malloc_;                   
    ecs_os_api_realloc_t realloc_;                 
    ecs_os_api_calloc_t calloc_;                   
    ecs_os_api_free_t free_;                       
    ecs_os_api_strdup_t strdup_;                   
    ecs_os_api_thread_new_t thread_new_;           
    ecs_os_api_thread_join_t thread_join_;         
    ecs_os_api_thread_self_t thread_self_;         
    ecs_os_api_thread_new_t task_new_;             
    ecs_os_api_thread_join_t task_join_;           
    ecs_os_api_ainc_t ainc_;                       
    ecs_os_api_ainc_t adec_;                       
    ecs_os_api_lainc_t lainc_;                     
    ecs_os_api_lainc_t ladec_;                     
    ecs_os_api_mutex_new_t mutex_new_;             
    ecs_os_api_mutex_free_t mutex_free_;           
    ecs_os_api_mutex_lock_t mutex_lock_;           
    ecs_os_api_mutex_lock_t mutex_unlock_;         
    ecs_os_api_cond_new_t cond_new_;               
    ecs_os_api_cond_free_t cond_free_;             
    ecs_os_api_cond_signal_t cond_signal_;         
    ecs_os_api_cond_broadcast_t cond_broadcast_;   
    ecs_os_api_cond_wait_t cond_wait_;             
    ecs_os_api_sleep_t sleep_;                     
    ecs_os_api_now_t now_;                         
    ecs_os_api_get_time_t get_time_;               
    ecs_os_api_log_t log_; 
    ecs_os_api_abort_t abort_;                     
    ecs_os_api_dlopen_t dlopen_;                   
    ecs_os_api_dlproc_t dlproc_;                   
    ecs_os_api_dlclose_t dlclose_;                 
    ecs_os_api_module_to_path_t module_to_dl_;     
    ecs_os_api_module_to_path_t module_to_etc_;    
    ecs_os_api_perf_trace_t perf_trace_push_;
    ecs_os_api_perf_trace_t perf_trace_pop_;
    int32_t log_level_;                            
    int32_t log_indent_;                           
    int32_t log_last_error_;                       
    int64_t log_last_timestamp_;                   
    ecs_flags32_t flags_;                          
    void *log_out_;                                
} ecs_os_api_t;
__declspec(dllimport)
extern ecs_os_api_t ecs_os_api;
__declspec(dllimport)
void ecs_os_init(void);
__declspec(dllimport)
void ecs_os_fini(void);
__declspec(dllimport)
void ecs_os_set_api(
    ecs_os_api_t *os_api);
__declspec(dllimport)
ecs_os_api_t ecs_os_get_api(void);
__declspec(dllimport)
void ecs_os_set_api_defaults(void);
__declspec(dllimport)
void ecs_os_dbg(
    const char *file, 
    int32_t line, 
    const char *msg);
__declspec(dllimport)
void ecs_os_trace(
    const char *file, 
    int32_t line, 
    const char *msg);
__declspec(dllimport)
void ecs_os_warn(
    const char *file, 
    int32_t line, 
    const char *msg);
__declspec(dllimport)
void ecs_os_err(
    const char *file, 
    int32_t line, 
    const char *msg);
__declspec(dllimport)
void ecs_os_fatal(
    const char *file, 
    int32_t line, 
    const char *msg);
__declspec(dllimport)
const char* ecs_os_strerror(
    int err);
__declspec(dllimport)
void ecs_os_strset(
    char **str, 
    const char *value);
void ecs_os_perf_trace_push_(
    const char *file,
    size_t line,
    const char *name);
void ecs_os_perf_trace_pop_(
    const char *file,
    size_t line,
    const char *name);
__declspec(dllimport)
void ecs_sleepf(
    double t);
__declspec(dllimport)
double ecs_time_measure(
    ecs_time_t *start);
__declspec(dllimport)
ecs_time_t ecs_time_sub(
    ecs_time_t t1,
    ecs_time_t t2);
__declspec(dllimport)
double ecs_time_to_double(
    ecs_time_t t);
__declspec(dllimport)
void* ecs_os_memdup(
    const void *src,
    ecs_size_t size);
__declspec(dllimport)
bool ecs_os_has_heap(void);
__declspec(dllimport)
bool ecs_os_has_threading(void);
__declspec(dllimport)
bool ecs_os_has_task_support(void);
__declspec(dllimport)
bool ecs_os_has_time(void);
__declspec(dllimport)
bool ecs_os_has_logging(void);
__declspec(dllimport)
bool ecs_os_has_dl(void);
__declspec(dllimport)
bool ecs_os_has_modules(void);
typedef void (*ecs_run_action_t)(
    ecs_iter_t *it);
typedef void (*ecs_iter_action_t)(
    ecs_iter_t *it);
typedef bool (*ecs_iter_next_action_t)(
    ecs_iter_t *it);
typedef void (*ecs_iter_fini_action_t)(
    ecs_iter_t *it);
typedef int (*ecs_order_by_action_t)(
    ecs_entity_t e1,
    const void *ptr1,
    ecs_entity_t e2,
    const void *ptr2);
typedef void (*ecs_sort_table_action_t)(
    ecs_world_t* world,
    ecs_table_t* table,
    ecs_entity_t* entities,
    void* ptr,
    int32_t size,
    int32_t lo,
    int32_t hi,
    ecs_order_by_action_t order_by);
typedef uint64_t (*ecs_group_by_action_t)(
    ecs_world_t *world,
    ecs_table_t *table,
    ecs_id_t group_id,
    void *ctx);
typedef void* (*ecs_group_create_action_t)(
    ecs_world_t *world,
    uint64_t group_id,
    void *group_by_ctx); 
typedef void (*ecs_group_delete_action_t)(
    ecs_world_t *world,
    uint64_t group_id,
    void *group_ctx,     
    void *group_by_ctx); 
typedef void (*ecs_module_action_t)(
    ecs_world_t *world);
typedef void (*ecs_fini_action_t)(
    ecs_world_t *world,
    void *ctx);
typedef void (*ecs_ctx_free_t)(
    void *ctx);
typedef int (*ecs_compare_action_t)(
    const void *ptr1,
    const void *ptr2);
typedef uint64_t (*ecs_hash_value_action_t)(
    const void *ptr);
typedef void (*ecs_xtor_t)(
    void *ptr,
    int32_t count,
    const ecs_type_info_t *type_info);
typedef void (*ecs_copy_t)(
    void *dst_ptr,
    const void *src_ptr,
    int32_t count,
    const ecs_type_info_t *type_info);
typedef void (*ecs_move_t)(
    void *dst_ptr,
    void *src_ptr,
    int32_t count,
    const ecs_type_info_t *type_info);
typedef int (*ecs_cmp_t)(
    const void *a_ptr,
    const void *b_ptr,
    const ecs_type_info_t *type_info);
typedef bool (*ecs_equals_t)(
    const void *a_ptr,
    const void *b_ptr,
    const ecs_type_info_t *type_info);
typedef void (*flecs_poly_dtor_t)(
    ecs_poly_t *poly);
typedef enum ecs_inout_kind_t {
    EcsInOutDefault,  
    EcsInOutNone,     
    EcsInOutFilter,   
    EcsInOut,         
    EcsIn,            
    EcsOut,           
} ecs_inout_kind_t;
typedef enum ecs_oper_kind_t {
    EcsAnd,           
    EcsOr,            
    EcsNot,           
    EcsOptional,      
    EcsAndFrom,       
    EcsOrFrom,        
    EcsNotFrom,       
} ecs_oper_kind_t;
typedef enum ecs_query_cache_kind_t {
    EcsQueryCacheDefault,   
    EcsQueryCacheAuto,      
    EcsQueryCacheAll,       
    EcsQueryCacheNone,      
} ecs_query_cache_kind_t;
typedef struct ecs_term_ref_t {
    ecs_entity_t id;            
    const char *name;           
} ecs_term_ref_t;
struct ecs_term_t {
    ecs_id_t id;                
    ecs_term_ref_t src;          
    ecs_term_ref_t first;        
    ecs_term_ref_t second;       
    ecs_entity_t trav;          
    int16_t inout;              
    int16_t oper;               
    int8_t field_index;         
    ecs_flags16_t flags_;       
};
struct ecs_query_t {
    ecs_header_t hdr;           
    ecs_term_t *terms;          
    int32_t *sizes;             
    ecs_id_t *ids;              
    uint64_t bloom_filter;      
    ecs_flags32_t flags;        
    int8_t var_count;           
    int8_t term_count;          
    int8_t field_count;         
    ecs_flags32_t fixed_fields; 
    ecs_flags32_t var_fields;   
    ecs_flags32_t static_id_fields; 
    ecs_flags32_t data_fields;  
    ecs_flags32_t write_fields; 
    ecs_flags32_t read_fields;  
    ecs_flags32_t row_fields;   
    ecs_flags32_t shared_readonly_fields; 
    ecs_flags32_t set_fields;   
    ecs_query_cache_kind_t cache_kind;  
    char **vars;                
    void *ctx;                  
    void *binding_ctx;          
    ecs_entity_t entity;        
    ecs_world_t *real_world;    
    ecs_world_t *world;         
    int32_t eval_count;         
};
struct ecs_observer_t {
    ecs_header_t hdr;           
    ecs_query_t *query;         
    ecs_entity_t events[(8)];
    int32_t event_count;        
    ecs_iter_action_t callback; 
    ecs_run_action_t run;       
    void *ctx;                  
    void *callback_ctx;         
    void *run_ctx;              
    ecs_ctx_free_t ctx_free;    
    ecs_ctx_free_t callback_ctx_free; 
    ecs_ctx_free_t run_ctx_free; 
    ecs_observable_t *observable; 
    ecs_world_t *world;         
    ecs_entity_t entity;        
};
struct ecs_type_hooks_t {
    ecs_xtor_t ctor;            
    ecs_xtor_t dtor;            
    ecs_copy_t copy;            
    ecs_move_t move;            
    ecs_copy_t copy_ctor;
    ecs_move_t move_ctor;
    ecs_move_t ctor_move_dtor;
    ecs_move_t move_dtor;
    ecs_cmp_t cmp;
    ecs_equals_t equals;
    ecs_flags32_t flags;
    ecs_iter_action_t on_add;
    ecs_iter_action_t on_set;
    ecs_iter_action_t on_remove;
    ecs_iter_action_t on_replace;
    void *ctx;                         
    void *binding_ctx;                 
    void *lifecycle_ctx;               
    ecs_ctx_free_t ctx_free;           
    ecs_ctx_free_t binding_ctx_free;   
    ecs_ctx_free_t lifecycle_ctx_free; 
};
struct ecs_type_info_t {
    ecs_size_t size;         
    ecs_size_t alignment;    
    ecs_type_hooks_t hooks;  
    ecs_entity_t component;  
    const char *name;        
};
typedef struct ecs_data_t ecs_data_t;
typedef struct ecs_query_cache_match_t ecs_query_cache_match_t;
typedef struct ecs_query_cache_group_t ecs_query_cache_group_t;
typedef struct ecs_event_record_t {
    struct ecs_event_id_record_t *any;
    struct ecs_event_id_record_t *wildcard;
    struct ecs_event_id_record_t *wildcard_pair;
    ecs_map_t event_ids; 
    ecs_entity_t event;
} ecs_event_record_t;
struct ecs_observable_t {
    ecs_event_record_t on_add;
    ecs_event_record_t on_remove;
    ecs_event_record_t on_set;
    ecs_event_record_t on_wildcard;
    ecs_sparse_t events;  
    uint64_t last_observer_id;
};
typedef struct ecs_table_range_t {
    ecs_table_t *table;
    int32_t offset;       
    int32_t count;       
} ecs_table_range_t;
typedef struct ecs_var_t {
    ecs_table_range_t range; 
    ecs_entity_t entity;     
} ecs_var_t;
struct ecs_ref_t {
    ecs_entity_t entity;         
    ecs_entity_t id;             
    uint64_t table_id;           
    uint32_t table_version_fast; 
    uint16_t table_version;      
    ecs_record_t *record;        
    void *ptr;                   
};
typedef struct ecs_page_iter_t {
    int32_t offset;
    int32_t limit;
    int32_t remaining;
} ecs_page_iter_t;
typedef struct ecs_worker_iter_t {
    int32_t index;
    int32_t count;
} ecs_worker_iter_t;
typedef struct ecs_table_cache_iter_t {
    const struct ecs_table_cache_hdr_t *cur, *next;
    bool iter_fill;
    bool iter_empty;
} ecs_table_cache_iter_t;
typedef struct ecs_each_iter_t {
    ecs_table_cache_iter_t it;
    ecs_id_t ids;
    ecs_entity_t sources;
    ecs_size_t sizes;
    int32_t columns;
    const ecs_table_record_t* trs;
} ecs_each_iter_t;
typedef struct ecs_query_op_profile_t {
    int32_t count[2]; 
} ecs_query_op_profile_t;
typedef struct ecs_query_iter_t {
    struct ecs_var_t *vars;                   
    const struct ecs_query_var_t *query_vars; 
    const struct ecs_query_op_t *ops;         
    struct ecs_query_op_ctx_t *op_ctx;        
    uint64_t *written;
    ecs_query_cache_group_t *group;           
    ecs_vec_t *tables;                        
    ecs_vec_t *all_tables;                    
    ecs_query_cache_match_t *elem;            
    int32_t cur, all_cur;                     
    ecs_query_op_profile_t *profile;
    int16_t op;                               
    bool iter_single_group;
} ecs_query_iter_t;
typedef struct ecs_iter_private_t {
    union {
        ecs_query_iter_t query;
        ecs_page_iter_t page;
        ecs_worker_iter_t worker;
        ecs_each_iter_t each;
    } iter;                       
    void *entity_iter;            
    ecs_stack_cursor_t *stack_cursor; 
} ecs_iter_private_t;
typedef struct ecs_commands_t {
    ecs_vec_t queue;
    ecs_stack_t stack;          
    ecs_sparse_t entries;       
} ecs_commands_t;
__declspec(dllimport)
char* flecs_module_path_from_c(
    const char *c_name);
__declspec(dllimport)
void flecs_default_ctor(
    void *ptr, 
    int32_t count, 
    const ecs_type_info_t *type_info);
__declspec(dllimport)
char* flecs_vasprintf(
    const char *fmt,
    va_list args);
__declspec(dllimport)
char* flecs_asprintf(
    const char *fmt,
    ...);
__declspec(dllimport)
char* flecs_chresc(
    char *out,
    char in,
    char delimiter);
const char* flecs_chrparse(
    const char *in,
    char *out);
__declspec(dllimport)
ecs_size_t flecs_stresc(
    char *out,
    ecs_size_t size,
    char delimiter,
    const char *in);
__declspec(dllimport)
char* flecs_astresc(
    char delimiter,
    const char *in);
__declspec(dllimport)
const char* flecs_parse_ws_eol(
    const char *ptr);
__declspec(dllimport)
const char* flecs_parse_digit(
    const char *ptr,
    char *token);
__declspec(dllimport)
char* flecs_to_snake_case(
    const char *str);
typedef struct ecs_suspend_readonly_state_t {
    bool is_readonly;
    bool is_deferred;
    bool cmd_flushing;
    int32_t defer_count;
    ecs_entity_t scope;
    ecs_entity_t with;
    ecs_commands_t cmd_stack[2];
    ecs_commands_t *cmd;
    ecs_stage_t *stage;
} ecs_suspend_readonly_state_t;
__declspec(dllimport)
ecs_world_t* flecs_suspend_readonly(
    const ecs_world_t *world,
    ecs_suspend_readonly_state_t *state);
__declspec(dllimport)
void flecs_resume_readonly(
    ecs_world_t *world,
    ecs_suspend_readonly_state_t *state);
__declspec(dllimport)
int32_t flecs_table_observed_count(
    const ecs_table_t *table);
__declspec(dllimport)
void flecs_dump_backtrace(
    void *stream);
__declspec(dllimport)
int32_t flecs_poly_claim_(
    ecs_poly_t *poly);
__declspec(dllimport)
int32_t flecs_poly_release_(
    ecs_poly_t *poly);
__declspec(dllimport)
int32_t flecs_poly_refcount(
    ecs_poly_t *poly);
__declspec(dllimport)
int32_t flecs_component_ids_index_get(void);
__declspec(dllimport)
ecs_entity_t flecs_component_ids_get(
    const ecs_world_t *world, 
    int32_t index);
__declspec(dllimport)
ecs_entity_t flecs_component_ids_get_alive(
    const ecs_world_t *world, 
    int32_t index);
__declspec(dllimport)
void flecs_component_ids_set(
    ecs_world_t *world, 
    int32_t index,
    ecs_entity_t id);
__declspec(dllimport)
bool flecs_query_trivial_cached_next(
    ecs_iter_t *it);
__declspec(dllimport)
void flecs_check_exclusive_world_access_write(
    const ecs_world_t *world);
__declspec(dllimport)
void flecs_check_exclusive_world_access_read(
    const ecs_world_t *world);
typedef struct {
    ecs_vec_t keys;
    ecs_vec_t values;
} ecs_hm_bucket_t;
typedef struct {
    ecs_hash_value_action_t hash;
    ecs_compare_action_t compare;
    ecs_size_t key_size;
    ecs_size_t value_size;
    ecs_block_allocator_t *hashmap_allocator;
    ecs_block_allocator_t bucket_allocator;
    ecs_map_t impl;
} ecs_hashmap_t;
typedef struct {
    ecs_map_iter_t it;
    ecs_hm_bucket_t *bucket;
    int32_t index;
} flecs_hashmap_iter_t;
typedef struct {
    void *key;
    void *value;
    uint64_t hash;
} flecs_hashmap_result_t;
__declspec(dllimport)
void flecs_hashmap_init_(
    ecs_hashmap_t *hm,
    ecs_size_t key_size,
    ecs_size_t value_size,
    ecs_hash_value_action_t hash,
    ecs_compare_action_t compare,
    ecs_allocator_t *allocator);
__declspec(dllimport)
void flecs_hashmap_fini(
    ecs_hashmap_t *map);
__declspec(dllimport)
void* flecs_hashmap_get_(
    const ecs_hashmap_t *map,
    ecs_size_t key_size,
    const void *key,
    ecs_size_t value_size);
__declspec(dllimport)
flecs_hashmap_result_t flecs_hashmap_ensure_(
    ecs_hashmap_t *map,
    ecs_size_t key_size,
    const void *key,
    ecs_size_t value_size);
__declspec(dllimport)
void flecs_hashmap_set_(
    ecs_hashmap_t *map,
    ecs_size_t key_size,
    void *key,
    ecs_size_t value_size,
    const void *value);
__declspec(dllimport)
void flecs_hashmap_remove_(
    ecs_hashmap_t *map,
    ecs_size_t key_size,
    const void *key,
    ecs_size_t value_size);
__declspec(dllimport)
void flecs_hashmap_remove_w_hash_(
    ecs_hashmap_t *map,
    ecs_size_t key_size,
    const void *key,
    ecs_size_t value_size,
    uint64_t hash);
__declspec(dllimport)
ecs_hm_bucket_t* flecs_hashmap_get_bucket(
    const ecs_hashmap_t *map,
    uint64_t hash);
__declspec(dllimport)
void flecs_hm_bucket_remove(
    ecs_hashmap_t *map,
    ecs_hm_bucket_t *bucket,
    uint64_t hash,
    int32_t index);
__declspec(dllimport)
void flecs_hashmap_copy(
    ecs_hashmap_t *dst,
    const ecs_hashmap_t *src);
__declspec(dllimport)
flecs_hashmap_iter_t flecs_hashmap_iter(
    ecs_hashmap_t *map);
__declspec(dllimport)
void* flecs_hashmap_next_(
    flecs_hashmap_iter_t *it,
    ecs_size_t key_size,
    void *key_out,
    ecs_size_t value_size);
struct ecs_record_t {
    ecs_component_record_t *cr;               
    ecs_table_t *table;                        
    uint32_t row;                              
    int32_t dense;                                 
};
typedef struct ecs_table_cache_hdr_t {
    struct ecs_component_record_t *cr;         
    ecs_table_t *table;                        
    struct ecs_table_cache_hdr_t *prev, *next; 
} ecs_table_cache_hdr_t;
struct ecs_table_record_t {
    ecs_table_cache_hdr_t hdr;                 
    int16_t index;                             
    int16_t count;                             
    int16_t column;                            
};
typedef struct ecs_table_diff_t {
    ecs_type_t added;                
    ecs_type_t removed;              
    ecs_flags32_t added_flags;
    ecs_flags32_t removed_flags;
} ecs_table_diff_t;
__declspec(dllimport)
ecs_record_t* ecs_record_find(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
ecs_entity_t ecs_record_get_entity(
    const ecs_record_t *record);
__declspec(dllimport)
ecs_record_t* ecs_write_begin(
    ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_write_end(
    ecs_record_t *record);
__declspec(dllimport)
const ecs_record_t* ecs_read_begin(
    ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_read_end(
    const ecs_record_t *record);
__declspec(dllimport)
const void* ecs_record_get_id(
    const ecs_world_t *world,
    const ecs_record_t *record,
    ecs_id_t id);
__declspec(dllimport)
void* ecs_record_ensure_id(
    ecs_world_t *world,
    ecs_record_t *record,
    ecs_id_t id);
__declspec(dllimport)
bool ecs_record_has_id(
    ecs_world_t *world,
    const ecs_record_t *record,
    ecs_id_t id);
__declspec(dllimport)
void* ecs_record_get_by_column(
    const ecs_record_t *record,
    int32_t column,
    size_t size);
__declspec(dllimport)
 ecs_component_record_t* flecs_components_get(
    const ecs_world_t *world,
    ecs_id_t id);
__declspec(dllimport)
ecs_id_t flecs_component_get_id(
    const ecs_component_record_t *cr);
__declspec(dllimport)
 const ecs_table_record_t* flecs_component_get_table(
    const ecs_component_record_t *cr,
    const ecs_table_t *table);
__declspec(dllimport)
bool flecs_component_iter(
    const ecs_component_record_t *cr,
    ecs_table_cache_iter_t *iter_out);
__declspec(dllimport)
const ecs_table_record_t* flecs_component_next(
    ecs_table_cache_iter_t *iter);
typedef struct ecs_table_records_t {
    const ecs_table_record_t *array;
    int32_t count;
} ecs_table_records_t;
__declspec(dllimport)
ecs_table_records_t flecs_table_records(
    ecs_table_t* table);
__declspec(dllimport)
ecs_component_record_t* flecs_table_record_get_component(
    const ecs_table_record_t *tr);
__declspec(dllimport)
uint64_t flecs_table_id(
    ecs_table_t* table);
__declspec(dllimport)
 ecs_table_t *flecs_table_traverse_add(
    ecs_world_t *world,
    ecs_table_t *table,
    ecs_id_t *id_ptr,
    ecs_table_diff_t *diff);
typedef struct ecs_value_t {
    ecs_entity_t type;      
    void *ptr;              
} ecs_value_t;
typedef struct ecs_entity_desc_t {
    int32_t _canary;      
    ecs_entity_t id;      
    ecs_entity_t parent;  
    const char *name;     
    const char *sep;      
    const char *root_sep; 
    const char *symbol;   
    bool use_low_id;      
    const ecs_id_t *add;
    const ecs_value_t *set;
    const char *add_expr;
} ecs_entity_desc_t;
typedef struct ecs_bulk_desc_t {
    int32_t _canary;        
    ecs_entity_t *entities; 
    int32_t count;     
    ecs_id_t ids[(32)]; 
    void **data;       
    ecs_table_t *table; 
} ecs_bulk_desc_t;
typedef struct ecs_component_desc_t {
    int32_t _canary;        
    ecs_entity_t entity;
    ecs_type_info_t type;
} ecs_component_desc_t;
struct ecs_iter_t {
    ecs_world_t *world;           
    ecs_world_t *real_world;      
    int32_t offset;               
    int32_t count;                
    const ecs_entity_t *entities; 
    void **ptrs;                  
    const ecs_table_record_t **trs; 
    const ecs_size_t *sizes;      
    ecs_table_t *table;           
    ecs_table_t *other_table;     
    ecs_id_t *ids;                
    ecs_entity_t *sources;        
    ecs_flags64_t constrained_vars; 
    ecs_flags32_t set_fields;     
    ecs_flags32_t ref_fields;     
    ecs_flags32_t row_fields;     
    ecs_flags32_t up_fields;      
    ecs_entity_t system;          
    ecs_entity_t event;           
    ecs_id_t event_id;            
    int32_t event_cur;            
    int8_t field_count;           
    int8_t term_index;            
    const ecs_query_t *query;     
    void *param;                  
    void *ctx;                    
    void *binding_ctx;            
    void *callback_ctx;           
    void *run_ctx;                
    float delta_time;       
    float delta_system_time;
    int32_t frame_offset;         
    ecs_flags32_t flags;          
    ecs_entity_t interrupted_by;  
    ecs_iter_private_t priv_;     
    ecs_iter_next_action_t next;  
    ecs_iter_action_t callback;   
    ecs_iter_fini_action_t fini;  
    ecs_iter_t *chain_it;         
};
typedef struct ecs_query_desc_t {
    int32_t _canary;
    ecs_term_t terms[32];
    const char *expr;
    ecs_query_cache_kind_t cache_kind;
    ecs_flags32_t flags;
    ecs_order_by_action_t order_by_callback;
    ecs_sort_table_action_t order_by_table_callback;
    ecs_entity_t order_by;
    ecs_id_t group_by;
    ecs_group_by_action_t group_by_callback;
    ecs_group_create_action_t on_group_create;
    ecs_group_delete_action_t on_group_delete;
    void *group_by_ctx;
    ecs_ctx_free_t group_by_ctx_free;
    void *ctx;
    void *binding_ctx;
    ecs_ctx_free_t ctx_free;
    ecs_ctx_free_t binding_ctx_free;
    ecs_entity_t entity;
} ecs_query_desc_t;
typedef struct ecs_observer_desc_t {
    int32_t _canary;
    ecs_entity_t entity;
    ecs_query_desc_t query;
    ecs_entity_t events[(8)];
    bool yield_existing;
    ecs_iter_action_t callback;
    ecs_run_action_t run;
    void *ctx;
    ecs_ctx_free_t ctx_free;
    void *callback_ctx;
    ecs_ctx_free_t callback_ctx_free;
    void *run_ctx;
    ecs_ctx_free_t run_ctx_free;
    ecs_poly_t *observable;
    int32_t *last_event_id;
    int8_t term_index_;
    ecs_flags32_t flags_;
} ecs_observer_desc_t;
typedef struct ecs_event_desc_t {
    ecs_entity_t event;
    const ecs_type_t *ids;
    ecs_table_t *table;
    ecs_table_t *other_table;
    int32_t offset;
    int32_t count;
    ecs_entity_t entity;
    void *param;
    const void *const_param;
    ecs_poly_t *observable;
    ecs_flags32_t flags;
} ecs_event_desc_t;
typedef struct ecs_build_info_t {
    const char *compiler;           
    const char **addons;            
    const char *version;            
    int16_t version_major;          
    int16_t version_minor;          
    int16_t version_patch;          
    bool debug;                     
    bool sanitize;                  
    bool perf_trace;                
} ecs_build_info_t;
typedef struct ecs_world_info_t {
    ecs_entity_t last_component_id;   
    ecs_entity_t min_id;              
    ecs_entity_t max_id;              
    float delta_time_raw;       
    float delta_time;           
    float time_scale;           
    float target_fps;           
    float frame_time_total;     
    float system_time_total;    
    float emit_time_total;      
    float merge_time_total;     
    float rematch_time_total;   
    double world_time_total;          
    double world_time_total_raw;      
    int64_t frame_count_total;        
    int64_t merge_count_total;        
    int64_t eval_comp_monitors_total; 
    int64_t rematch_count_total;      
    int64_t id_create_total;          
    int64_t id_delete_total;          
    int64_t table_create_total;       
    int64_t table_delete_total;       
    int64_t pipeline_build_count_total; 
    int64_t systems_ran_frame;        
    int64_t observers_ran_frame;      
    int32_t tag_id_count;             
    int32_t component_id_count;       
    int32_t pair_id_count;            
    int32_t table_count;              
    struct {
        int64_t add_count;             
        int64_t remove_count;          
        int64_t delete_count;          
        int64_t clear_count;           
        int64_t set_count;             
        int64_t ensure_count;          
        int64_t modified_count;        
        int64_t discard_count;         
        int64_t event_count;           
        int64_t other_count;           
        int64_t batched_entity_count;  
        int64_t batched_command_count; 
    } cmd;                             
    const char *name_prefix;          
} ecs_world_info_t;
typedef struct ecs_query_group_info_t {
    uint64_t id;
    int32_t match_count;  
    int32_t table_count;  
    void *ctx;            
} ecs_query_group_info_t;
typedef struct EcsIdentifier {
    char *value;          
    ecs_size_t length;    
    uint64_t hash;        
    uint64_t index_hash;  
    ecs_hashmap_t *index; 
} EcsIdentifier;
typedef struct EcsComponent {
    ecs_size_t size;           
    ecs_size_t alignment;      
} EcsComponent;
typedef struct EcsPoly {
    ecs_poly_t *poly;          
} EcsPoly;
typedef struct EcsDefaultChildComponent {
    ecs_id_t component;  
} EcsDefaultChildComponent;
__declspec(dllimport) extern const ecs_id_t ECS_PAIR;
__declspec(dllimport) extern const ecs_id_t ECS_AUTO_OVERRIDE;
__declspec(dllimport) extern const ecs_id_t ECS_TOGGLE;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsComponentID_;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsIdentifierID_;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsPolyID_;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsDefaultChildComponentID_;
__declspec(dllimport) extern const ecs_entity_t EcsQuery;
__declspec(dllimport) extern const ecs_entity_t EcsObserver;
__declspec(dllimport) extern const ecs_entity_t EcsSystem;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsTickSourceID_;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsPipelineQueryID_;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsTimerID_;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsRateFilterID_;
__declspec(dllimport) extern const ecs_entity_t EcsFlecs;
__declspec(dllimport) extern const ecs_entity_t EcsFlecsCore;
__declspec(dllimport) extern const ecs_entity_t EcsWorld;
__declspec(dllimport) extern const ecs_entity_t EcsWildcard;
__declspec(dllimport) extern const ecs_entity_t EcsAny;
__declspec(dllimport) extern const ecs_entity_t EcsThis;
__declspec(dllimport) extern const ecs_entity_t EcsVariable;
__declspec(dllimport) extern const ecs_entity_t EcsTransitive;
__declspec(dllimport) extern const ecs_entity_t EcsReflexive;
__declspec(dllimport) extern const ecs_entity_t EcsFinal;
__declspec(dllimport) extern const ecs_entity_t EcsInheritable;
__declspec(dllimport) extern const ecs_entity_t EcsOnInstantiate;
__declspec(dllimport) extern const ecs_entity_t EcsOverride;
__declspec(dllimport) extern const ecs_entity_t EcsInherit;
__declspec(dllimport) extern const ecs_entity_t EcsDontInherit;
__declspec(dllimport) extern const ecs_entity_t EcsSymmetric;
__declspec(dllimport) extern const ecs_entity_t EcsExclusive;
__declspec(dllimport) extern const ecs_entity_t EcsAcyclic;
__declspec(dllimport) extern const ecs_entity_t EcsTraversable;
__declspec(dllimport) extern const ecs_entity_t EcsWith;
__declspec(dllimport) extern const ecs_entity_t EcsOneOf;
__declspec(dllimport) extern const ecs_entity_t EcsCanToggle;
__declspec(dllimport) extern const ecs_entity_t EcsTrait;
__declspec(dllimport) extern const ecs_entity_t EcsRelationship;
__declspec(dllimport) extern const ecs_entity_t EcsTarget;
__declspec(dllimport) extern const ecs_entity_t EcsPairIsTag;
__declspec(dllimport) extern const ecs_entity_t EcsName;
__declspec(dllimport) extern const ecs_entity_t EcsSymbol;
__declspec(dllimport) extern const ecs_entity_t EcsAlias;
__declspec(dllimport) extern const ecs_entity_t EcsChildOf;
__declspec(dllimport) extern const ecs_entity_t EcsIsA;
__declspec(dllimport) extern const ecs_entity_t EcsDependsOn;
__declspec(dllimport) extern const ecs_entity_t EcsSlotOf;
__declspec(dllimport) extern const ecs_entity_t EcsOrderedChildren;
__declspec(dllimport) extern const ecs_entity_t EcsModule;
__declspec(dllimport) extern const ecs_entity_t EcsPrivate;
__declspec(dllimport) extern const ecs_entity_t EcsPrefab;
__declspec(dllimport) extern const ecs_entity_t EcsDisabled;
__declspec(dllimport) extern const ecs_entity_t EcsNotQueryable;
__declspec(dllimport) extern const ecs_entity_t EcsOnAdd;
__declspec(dllimport) extern const ecs_entity_t EcsOnRemove;
__declspec(dllimport) extern const ecs_entity_t EcsOnSet;
__declspec(dllimport) extern const ecs_entity_t EcsMonitor;
__declspec(dllimport) extern const ecs_entity_t EcsOnTableCreate;
__declspec(dllimport) extern const ecs_entity_t EcsOnTableDelete;
__declspec(dllimport) extern const ecs_entity_t EcsOnDelete;
__declspec(dllimport) extern const ecs_entity_t EcsOnDeleteTarget;
__declspec(dllimport) extern const ecs_entity_t EcsRemove;
__declspec(dllimport) extern const ecs_entity_t EcsDelete;
__declspec(dllimport) extern const ecs_entity_t EcsPanic;
__declspec(dllimport) extern const ecs_entity_t EcsSingleton;
__declspec(dllimport) extern const ecs_entity_t EcsSparse;
__declspec(dllimport) extern const ecs_entity_t EcsDontFragment;
__declspec(dllimport) extern const ecs_entity_t EcsPredEq;
__declspec(dllimport) extern const ecs_entity_t EcsPredMatch;
__declspec(dllimport) extern const ecs_entity_t EcsPredLookup;
__declspec(dllimport) extern const ecs_entity_t EcsScopeOpen;
__declspec(dllimport) extern const ecs_entity_t EcsScopeClose;
__declspec(dllimport) extern const ecs_entity_t EcsEmpty;
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsPipelineID_; 
__declspec(dllimport) extern const ecs_entity_t EcsOnStart;     
__declspec(dllimport) extern const ecs_entity_t EcsPreFrame;    
__declspec(dllimport) extern const ecs_entity_t EcsOnLoad;      
__declspec(dllimport) extern const ecs_entity_t EcsPostLoad;    
__declspec(dllimport) extern const ecs_entity_t EcsPreUpdate;   
__declspec(dllimport) extern const ecs_entity_t EcsOnUpdate;    
__declspec(dllimport) extern const ecs_entity_t EcsOnValidate;  
__declspec(dllimport) extern const ecs_entity_t EcsPostUpdate;  
__declspec(dllimport) extern const ecs_entity_t EcsPreStore;    
__declspec(dllimport) extern const ecs_entity_t EcsOnStore;     
__declspec(dllimport) extern const ecs_entity_t EcsPostFrame;   
__declspec(dllimport) extern const ecs_entity_t EcsPhase;       
__declspec(dllimport) extern const ecs_entity_t EcsConstant;    
__declspec(dllimport)
ecs_world_t* ecs_init(void);
__declspec(dllimport)
ecs_world_t* ecs_mini(void);
__declspec(dllimport)
ecs_world_t* ecs_init_w_args(
    int argc,
    char *argv[]);
__declspec(dllimport)
int ecs_fini(
    ecs_world_t *world);
__declspec(dllimport)
bool ecs_is_fini(
    const ecs_world_t *world);
__declspec(dllimport)
void ecs_atfini(
    ecs_world_t *world,
    ecs_fini_action_t action,
    void *ctx);
typedef struct ecs_entities_t {
    const ecs_entity_t *ids; 
    int32_t count;           
    int32_t alive_count;     
} ecs_entities_t;
__declspec(dllimport)
ecs_entities_t ecs_get_entities(
    const ecs_world_t *world);
__declspec(dllimport)
ecs_flags32_t ecs_world_get_flags(
    const ecs_world_t *world);
__declspec(dllimport)
float ecs_frame_begin(
    ecs_world_t *world,
    float delta_time);
__declspec(dllimport)
void ecs_frame_end(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_run_post_frame(
    ecs_world_t *world,
    ecs_fini_action_t action,
    void *ctx);
__declspec(dllimport)
void ecs_quit(
    ecs_world_t *world);
__declspec(dllimport)
bool ecs_should_quit(
    const ecs_world_t *world);
__declspec(dllimport) void ecs_measure_frame_time(
    ecs_world_t *world,
    bool enable);
__declspec(dllimport) void ecs_measure_system_time(
    ecs_world_t *world,
    bool enable);
__declspec(dllimport)
void ecs_set_target_fps(
    ecs_world_t *world,
    float fps);
__declspec(dllimport)
void ecs_set_default_query_flags(
    ecs_world_t *world,
    ecs_flags32_t flags);
__declspec(dllimport)
bool ecs_readonly_begin(
    ecs_world_t *world,
    bool multi_threaded);
__declspec(dllimport)
void ecs_readonly_end(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_merge(
    ecs_world_t *world);
__declspec(dllimport)
bool ecs_defer_begin(
    ecs_world_t *world);
__declspec(dllimport)
bool ecs_is_deferred(
    const ecs_world_t *world);
__declspec(dllimport)
bool ecs_defer_end(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_defer_suspend(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_defer_resume(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_set_stage_count(
    ecs_world_t *world,
    int32_t stages);
__declspec(dllimport)
int32_t ecs_get_stage_count(
    const ecs_world_t *world);
__declspec(dllimport)
ecs_world_t* ecs_get_stage(
    const ecs_world_t *world,
    int32_t stage_id);
__declspec(dllimport)
bool ecs_stage_is_readonly(
    const ecs_world_t *world);
__declspec(dllimport)
ecs_world_t* ecs_stage_new(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_stage_free(
    ecs_world_t *stage);
__declspec(dllimport)
int32_t ecs_stage_get_id(
    const ecs_world_t *world);
__declspec(dllimport)
void ecs_set_ctx(
    ecs_world_t *world,
    void *ctx,
    ecs_ctx_free_t ctx_free);
__declspec(dllimport)
void ecs_set_binding_ctx(
    ecs_world_t *world,
    void *ctx,
    ecs_ctx_free_t ctx_free);
__declspec(dllimport)
void* ecs_get_ctx(
    const ecs_world_t *world);
__declspec(dllimport)
void* ecs_get_binding_ctx(
    const ecs_world_t *world);
__declspec(dllimport)
const ecs_build_info_t* ecs_get_build_info(void);
__declspec(dllimport)
const ecs_world_info_t* ecs_get_world_info(
    const ecs_world_t *world);
__declspec(dllimport)
void ecs_dim(
    ecs_world_t *world,
    int32_t entity_count);
__declspec(dllimport)
void ecs_shrink(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_set_entity_range(
    ecs_world_t *world,
    ecs_entity_t id_start,
    ecs_entity_t id_end);
__declspec(dllimport)
bool ecs_enable_range_check(
    ecs_world_t *world,
    bool enable);
__declspec(dllimport)
ecs_entity_t ecs_get_max_id(
    const ecs_world_t *world);
__declspec(dllimport)
void ecs_run_aperiodic(
    ecs_world_t *world,
    ecs_flags32_t flags);
typedef struct ecs_delete_empty_tables_desc_t {
    uint16_t clear_generation;
    uint16_t delete_generation;
    double time_budget_seconds;
} ecs_delete_empty_tables_desc_t;
__declspec(dllimport)
int32_t ecs_delete_empty_tables(
    ecs_world_t *world,
    const ecs_delete_empty_tables_desc_t *desc);
__declspec(dllimport)
const ecs_world_t* ecs_get_world(
    const ecs_poly_t *poly);
__declspec(dllimport)
ecs_entity_t ecs_get_entity(
    const ecs_poly_t *poly);
__declspec(dllimport)
bool flecs_poly_is_(
    const ecs_poly_t *object,
    int32_t type);
__declspec(dllimport)
ecs_id_t ecs_make_pair(
    ecs_entity_t first,
    ecs_entity_t second);
__declspec(dllimport)
void ecs_exclusive_access_begin(
    ecs_world_t *world,
    const char *thread_name);
__declspec(dllimport)
void ecs_exclusive_access_end(
    ecs_world_t *world,
    bool lock_world);
__declspec(dllimport)
ecs_entity_t ecs_new(
    ecs_world_t *world);
__declspec(dllimport)
ecs_entity_t ecs_new_low_id(
    ecs_world_t *world);
__declspec(dllimport)
ecs_entity_t ecs_new_w_id(
    ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
ecs_entity_t ecs_new_w_table(
    ecs_world_t *world,
    ecs_table_t *table);
__declspec(dllimport)
ecs_entity_t ecs_entity_init(
    ecs_world_t *world,
    const ecs_entity_desc_t *desc);
__declspec(dllimport)
const ecs_entity_t* ecs_bulk_init(
    ecs_world_t *world,
    const ecs_bulk_desc_t *desc);
__declspec(dllimport)
const ecs_entity_t* ecs_bulk_new_w_id(
    ecs_world_t *world,
    ecs_id_t component,
    int32_t count);
__declspec(dllimport)
ecs_entity_t ecs_clone(
    ecs_world_t *world,
    ecs_entity_t dst,
    ecs_entity_t src,
    bool copy_value);
__declspec(dllimport)
void ecs_delete(
    ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_delete_with(
    ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
void ecs_set_child_order(
    ecs_world_t *world,
    ecs_entity_t parent,
    const ecs_entity_t *children,
    int32_t child_count);
__declspec(dllimport)
ecs_entities_t ecs_get_ordered_children(
    const ecs_world_t *world,
    ecs_entity_t parent);
__declspec(dllimport)
void ecs_add_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
void ecs_remove_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
void ecs_auto_override_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
void ecs_clear(
    ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_remove_all(
    ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
ecs_entity_t ecs_set_with(
    ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
ecs_id_t ecs_get_with(
    const ecs_world_t *world);
__declspec(dllimport)
void ecs_enable(
    ecs_world_t *world,
    ecs_entity_t entity,
    bool enabled);
__declspec(dllimport)
void ecs_enable_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component,
    bool enable);
__declspec(dllimport)
bool ecs_is_enabled_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
 const void* ecs_get_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
 void* ecs_get_mut_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
void* ecs_ensure_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component,
    size_t size);
 __declspec(dllimport)
ecs_ref_t ecs_ref_init_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
 __declspec(dllimport)
void* ecs_ref_get_id(
    const ecs_world_t *world,
    ecs_ref_t *ref,
    ecs_id_t component);
 __declspec(dllimport)
void ecs_ref_update(
    const ecs_world_t *world,
    ecs_ref_t *ref);
__declspec(dllimport)
void* ecs_emplace_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component,
    size_t size,
    bool *is_new);
__declspec(dllimport)
void ecs_modified_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
void ecs_set_id(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component,
    size_t size,
    const void *ptr);
__declspec(dllimport)
bool ecs_is_valid(
    const ecs_world_t *world,
    ecs_entity_t e);
__declspec(dllimport)
bool ecs_is_alive(
    const ecs_world_t *world,
    ecs_entity_t e);
__declspec(dllimport)
ecs_id_t ecs_strip_generation(
    ecs_entity_t e);
__declspec(dllimport)
ecs_entity_t ecs_get_alive(
    const ecs_world_t *world,
    ecs_entity_t e);
__declspec(dllimport)
void ecs_make_alive(
    ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_make_alive_id(
    ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
bool ecs_exists(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_set_version(
    ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const ecs_type_t* ecs_get_type(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
ecs_table_t* ecs_get_table(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
char* ecs_type_str(
    const ecs_world_t *world,
    const ecs_type_t* type);
__declspec(dllimport)
char* ecs_table_str(
    const ecs_world_t *world,
    const ecs_table_t *table);
__declspec(dllimport)
char* ecs_entity_str(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
 bool ecs_has_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
 bool ecs_owns_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component);
__declspec(dllimport)
ecs_entity_t ecs_get_target(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_entity_t rel,
    int32_t index);
__declspec(dllimport)
ecs_entity_t ecs_get_parent(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
ecs_entity_t ecs_get_target_for_id(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_entity_t rel,
    ecs_id_t component);
__declspec(dllimport)
int32_t ecs_get_depth(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_entity_t rel);
__declspec(dllimport)
int32_t ecs_count_id(
    const ecs_world_t *world,
    ecs_id_t entity);
__declspec(dllimport)
const char* ecs_get_name(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const char* ecs_get_symbol(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
ecs_entity_t ecs_set_name(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *name);
__declspec(dllimport)
ecs_entity_t ecs_set_symbol(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *symbol);
__declspec(dllimport)
void ecs_set_alias(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *alias);
__declspec(dllimport)
ecs_entity_t ecs_lookup(
    const ecs_world_t *world,
    const char *path);
__declspec(dllimport)
ecs_entity_t ecs_lookup_child(
    const ecs_world_t *world,
    ecs_entity_t parent,
    const char *name);
__declspec(dllimport)
ecs_entity_t ecs_lookup_path_w_sep(
    const ecs_world_t *world,
    ecs_entity_t parent,
    const char *path,
    const char *sep,
    const char *prefix,
    bool recursive);
__declspec(dllimport)
ecs_entity_t ecs_lookup_symbol(
    const ecs_world_t *world,
    const char *symbol,
    bool lookup_as_path,
    bool recursive);
__declspec(dllimport)
char* ecs_get_path_w_sep(
    const ecs_world_t *world,
    ecs_entity_t parent,
    ecs_entity_t child,
    const char *sep,
    const char *prefix);
__declspec(dllimport)
void ecs_get_path_w_sep_buf(
    const ecs_world_t *world,
    ecs_entity_t parent,
    ecs_entity_t child,
    const char *sep,
    const char *prefix,
    ecs_strbuf_t *buf,
    bool escape);
__declspec(dllimport)
ecs_entity_t ecs_new_from_path_w_sep(
    ecs_world_t *world,
    ecs_entity_t parent,
    const char *path,
    const char *sep,
    const char *prefix);
__declspec(dllimport)
ecs_entity_t ecs_add_path_w_sep(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_entity_t parent,
    const char *path,
    const char *sep,
    const char *prefix);
__declspec(dllimport)
ecs_entity_t ecs_set_scope(
    ecs_world_t *world,
    ecs_entity_t scope);
__declspec(dllimport)
ecs_entity_t ecs_get_scope(
    const ecs_world_t *world);
__declspec(dllimport)
const char* ecs_set_name_prefix(
    ecs_world_t *world,
    const char *prefix);
__declspec(dllimport)
ecs_entity_t* ecs_set_lookup_path(
    ecs_world_t *world,
    const ecs_entity_t *lookup_path);
__declspec(dllimport)
ecs_entity_t* ecs_get_lookup_path(
    const ecs_world_t *world);
__declspec(dllimport)
ecs_entity_t ecs_component_init(
    ecs_world_t *world,
    const ecs_component_desc_t *desc);
__declspec(dllimport)
const ecs_type_info_t* ecs_get_type_info(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
void ecs_set_hooks_id(
    ecs_world_t *world,
    ecs_entity_t component,
    const ecs_type_hooks_t *hooks);
__declspec(dllimport)
const ecs_type_hooks_t* ecs_get_hooks_id(
    const ecs_world_t *world,
    ecs_entity_t component);
__declspec(dllimport)
bool ecs_id_is_tag(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
bool ecs_id_in_use(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
ecs_entity_t ecs_get_typeid(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
bool ecs_id_match(
    ecs_id_t component,
    ecs_id_t pattern);
__declspec(dllimport)
bool ecs_id_is_pair(
    ecs_id_t component);
__declspec(dllimport)
bool ecs_id_is_wildcard(
    ecs_id_t component);
bool ecs_id_is_any(
    ecs_id_t component);
__declspec(dllimport)
bool ecs_id_is_valid(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
ecs_flags32_t ecs_id_get_flags(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
const char* ecs_id_flag_str(
    ecs_id_t component_flags);
__declspec(dllimport)
char* ecs_id_str(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
void ecs_id_str_buf(
    const ecs_world_t *world,
    ecs_id_t component,
    ecs_strbuf_t *buf);
__declspec(dllimport)
ecs_id_t ecs_id_from_str(
    const ecs_world_t *world,
    const char *expr);
__declspec(dllimport) 
bool ecs_term_ref_is_set(
    const ecs_term_ref_t *ref);
__declspec(dllimport)
bool ecs_term_is_initialized(
    const ecs_term_t *term);
__declspec(dllimport)
bool ecs_term_match_this(
    const ecs_term_t *term);
__declspec(dllimport)
bool ecs_term_match_0(
    const ecs_term_t *term);
__declspec(dllimport)
char* ecs_term_str(
    const ecs_world_t *world,
    const ecs_term_t *term);
__declspec(dllimport) 
char* ecs_query_str(
    const ecs_query_t *query); 
__declspec(dllimport)
ecs_iter_t ecs_each_id(
    const ecs_world_t *world,
    ecs_id_t component);
__declspec(dllimport)
bool ecs_each_next(
    ecs_iter_t *it);
__declspec(dllimport)
ecs_iter_t ecs_children(
    const ecs_world_t *world,
    ecs_entity_t parent);
__declspec(dllimport)
bool ecs_children_next(
    ecs_iter_t *it);
__declspec(dllimport)
ecs_query_t* ecs_query_init(
    ecs_world_t *world,
    const ecs_query_desc_t *desc);
__declspec(dllimport)
void ecs_query_fini(
    ecs_query_t *query);
__declspec(dllimport)
int32_t ecs_query_find_var(
    const ecs_query_t *query,
    const char *name);    
__declspec(dllimport)
const char* ecs_query_var_name(
    const ecs_query_t *query,
    int32_t var_id);
__declspec(dllimport)
bool ecs_query_var_is_entity(
    const ecs_query_t *query,
    int32_t var_id);  
__declspec(dllimport)
ecs_iter_t ecs_query_iter(
    const ecs_world_t *world,
    const ecs_query_t *query);
__declspec(dllimport)
bool ecs_query_next(
    ecs_iter_t *it);
__declspec(dllimport)
bool ecs_query_has(
    ecs_query_t *query,
    ecs_entity_t entity,
    ecs_iter_t *it);
__declspec(dllimport)
bool ecs_query_has_table(
    ecs_query_t *query,
    ecs_table_t *table,
    ecs_iter_t *it);
__declspec(dllimport)
bool ecs_query_has_range(
    ecs_query_t *query,
    ecs_table_range_t *range,
    ecs_iter_t *it);
__declspec(dllimport)
int32_t ecs_query_match_count(
    const ecs_query_t *query);
__declspec(dllimport)
char* ecs_query_plan(
    const ecs_query_t *query);
__declspec(dllimport)
char* ecs_query_plan_w_profile(
    const ecs_query_t *query,
    const ecs_iter_t *it);
__declspec(dllimport)
const char* ecs_query_args_parse(
    ecs_query_t *query,
    ecs_iter_t *it,
    const char *expr);
__declspec(dllimport)
bool ecs_query_changed(
    ecs_query_t *query);
__declspec(dllimport)
const ecs_query_t* ecs_query_get(
    const ecs_world_t *world,
    ecs_entity_t query);
__declspec(dllimport)
void ecs_iter_skip(
    ecs_iter_t *it);
__declspec(dllimport)
void ecs_iter_set_group(
    ecs_iter_t *it,
    uint64_t group_id);
__declspec(dllimport)
void* ecs_query_get_group_ctx(
    const ecs_query_t *query,
    uint64_t group_id);
__declspec(dllimport)
const ecs_query_group_info_t* ecs_query_get_group_info(
    const ecs_query_t *query,
    uint64_t group_id);
typedef struct ecs_query_count_t {
    int32_t results;      
    int32_t entities;     
    int32_t tables;       
} ecs_query_count_t;
__declspec(dllimport)
ecs_query_count_t ecs_query_count(
    const ecs_query_t *query);
__declspec(dllimport)
bool ecs_query_is_true(
    const ecs_query_t *query);
__declspec(dllimport)
const ecs_query_t* ecs_query_get_cache_query(
    const ecs_query_t *query);
__declspec(dllimport)
void ecs_emit(
    ecs_world_t *world,
    ecs_event_desc_t *desc);
__declspec(dllimport)
void ecs_enqueue(
    ecs_world_t *world,
    ecs_event_desc_t *desc);
__declspec(dllimport)
ecs_entity_t ecs_observer_init(
    ecs_world_t *world,
    const ecs_observer_desc_t *desc);
__declspec(dllimport)
const ecs_observer_t* ecs_observer_get(
    const ecs_world_t *world,
    ecs_entity_t observer);
__declspec(dllimport)
bool ecs_iter_next(
    ecs_iter_t *it);
__declspec(dllimport)
void ecs_iter_fini(
    ecs_iter_t *it);
__declspec(dllimport)
int32_t ecs_iter_count(
    ecs_iter_t *it);
__declspec(dllimport)
bool ecs_iter_is_true(
    ecs_iter_t *it);
__declspec(dllimport)
ecs_entity_t ecs_iter_first(
    ecs_iter_t *it);
__declspec(dllimport)
void ecs_iter_set_var(
    ecs_iter_t *it,
    int32_t var_id,
    ecs_entity_t entity);
__declspec(dllimport)
void ecs_iter_set_var_as_table(
    ecs_iter_t *it,
    int32_t var_id,
    const ecs_table_t *table);
__declspec(dllimport)
void ecs_iter_set_var_as_range(
    ecs_iter_t *it,
    int32_t var_id,
    const ecs_table_range_t *range);
__declspec(dllimport)
ecs_entity_t ecs_iter_get_var(
    ecs_iter_t *it,
    int32_t var_id);
__declspec(dllimport)
const char* ecs_iter_get_var_name(
    const ecs_iter_t *it,
    int32_t var_id);
__declspec(dllimport)
int32_t ecs_iter_get_var_count(
    const ecs_iter_t *it);
__declspec(dllimport)
ecs_var_t* ecs_iter_get_vars(
    const ecs_iter_t *it);
__declspec(dllimport)
ecs_table_t* ecs_iter_get_var_as_table(
    ecs_iter_t *it,
    int32_t var_id);
__declspec(dllimport)
ecs_table_range_t ecs_iter_get_var_as_range(
    ecs_iter_t *it,
    int32_t var_id);
__declspec(dllimport)
bool ecs_iter_var_is_constrained(
    ecs_iter_t *it,
    int32_t var_id);
__declspec(dllimport)
uint64_t ecs_iter_get_group(
    const ecs_iter_t *it);
__declspec(dllimport)
bool ecs_iter_changed(
    ecs_iter_t *it);
__declspec(dllimport)
char* ecs_iter_str(
    const ecs_iter_t *it);
__declspec(dllimport)
ecs_iter_t ecs_page_iter(
    const ecs_iter_t *it,
    int32_t offset,
    int32_t limit);
__declspec(dllimport)
bool ecs_page_next(
    ecs_iter_t *it);
__declspec(dllimport)
ecs_iter_t ecs_worker_iter(
    const ecs_iter_t *it,
    int32_t index,
    int32_t count);
__declspec(dllimport)
bool ecs_worker_next(
    ecs_iter_t *it);
__declspec(dllimport)
void* ecs_field_w_size(
    const ecs_iter_t *it,
    size_t size,
    int8_t index);
__declspec(dllimport)
void* ecs_field_at_w_size(
    const ecs_iter_t *it,
    size_t size,
    int8_t index,
    int32_t row);
__declspec(dllimport)
bool ecs_field_is_readonly(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
bool ecs_field_is_writeonly(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
bool ecs_field_is_set(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
ecs_id_t ecs_field_id(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
int32_t ecs_field_column(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
ecs_entity_t ecs_field_src(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
size_t ecs_field_size(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
bool ecs_field_is_self(
    const ecs_iter_t *it,
    int8_t index);
__declspec(dllimport)
const ecs_type_t* ecs_table_get_type(
    const ecs_table_t *table);
__declspec(dllimport)
int32_t ecs_table_get_type_index(
    const ecs_world_t *world,
    const ecs_table_t *table,
    ecs_id_t component);
__declspec(dllimport)
int32_t ecs_table_get_column_index(
    const ecs_world_t *world,
    const ecs_table_t *table,
    ecs_id_t component);
__declspec(dllimport)
int32_t ecs_table_column_count(
    const ecs_table_t *table);
__declspec(dllimport)
int32_t ecs_table_type_to_column_index(
    const ecs_table_t *table,
    int32_t index);
__declspec(dllimport)
int32_t ecs_table_column_to_type_index(
    const ecs_table_t *table,
    int32_t index);
__declspec(dllimport)
void* ecs_table_get_column(
    const ecs_table_t *table,
    int32_t index,
    int32_t offset);
__declspec(dllimport)
void* ecs_table_get_id(
    const ecs_world_t *world,
    const ecs_table_t *table,
    ecs_id_t component,
    int32_t offset);
__declspec(dllimport)
size_t ecs_table_get_column_size(
    const ecs_table_t *table,
    int32_t index);
__declspec(dllimport)
int32_t ecs_table_count(
    const ecs_table_t *table);
__declspec(dllimport)
int32_t ecs_table_size(
    const ecs_table_t *table);
__declspec(dllimport)
const ecs_entity_t* ecs_table_entities(
    const ecs_table_t *table);
__declspec(dllimport)
bool ecs_table_has_id(
    const ecs_world_t *world,
    const ecs_table_t *table,
    ecs_id_t component);
__declspec(dllimport)
int32_t ecs_table_get_depth(
    const ecs_world_t *world,
    const ecs_table_t *table,
    ecs_entity_t rel);
__declspec(dllimport)
ecs_table_t* ecs_table_add_id(
    ecs_world_t *world,
    ecs_table_t *table,
    ecs_id_t component);
__declspec(dllimport)
ecs_table_t* ecs_table_find(
    ecs_world_t *world,
    const ecs_id_t *ids,
    int32_t id_count);
__declspec(dllimport)
ecs_table_t* ecs_table_remove_id(
    ecs_world_t *world,
    ecs_table_t *table,
    ecs_id_t component);
__declspec(dllimport)
void ecs_table_lock(
    ecs_world_t *world,
    ecs_table_t *table);
__declspec(dllimport)
void ecs_table_unlock(
    ecs_world_t *world,
    ecs_table_t *table);
__declspec(dllimport)
bool ecs_table_has_flags(
    ecs_table_t *table,
    ecs_flags32_t flags);
__declspec(dllimport)
bool ecs_table_has_traversable(
    const ecs_table_t *table);
__declspec(dllimport)
void ecs_table_swap_rows(
    ecs_world_t* world,
    ecs_table_t* table,
    int32_t row_1,
    int32_t row_2);
__declspec(dllimport)
bool ecs_commit(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_record_t *record,
    ecs_table_t *table,
    const ecs_type_t *added,
    const ecs_type_t *removed);
__declspec(dllimport)
int32_t ecs_search(
    const ecs_world_t *world,
    const ecs_table_t *table,
    ecs_id_t component,
    ecs_id_t *component_out);
__declspec(dllimport)
int32_t ecs_search_offset(
    const ecs_world_t *world,
    const ecs_table_t *table,
    int32_t offset,
    ecs_id_t component,
    ecs_id_t *component_out);
__declspec(dllimport)
int32_t ecs_search_relation(
    const ecs_world_t *world,
    const ecs_table_t *table,
    int32_t offset,
    ecs_id_t component,
    ecs_entity_t rel,
    ecs_flags64_t flags, 
    ecs_entity_t *subject_out,
    ecs_id_t *component_out,
    struct ecs_table_record_t **tr_out);
__declspec(dllimport)
void ecs_table_clear_entities(
    ecs_world_t* world,
    ecs_table_t* table);
__declspec(dllimport)
int ecs_value_init(
    const ecs_world_t *world,
    ecs_entity_t type,
    void *ptr);
__declspec(dllimport)
int ecs_value_init_w_type_info(
    const ecs_world_t *world,
    const ecs_type_info_t *ti,
    void *ptr);
__declspec(dllimport)
void* ecs_value_new(
    ecs_world_t *world,
    ecs_entity_t type);
void* ecs_value_new_w_type_info(
    ecs_world_t *world,
    const ecs_type_info_t *ti);
int ecs_value_fini_w_type_info(
    const ecs_world_t *world,
    const ecs_type_info_t *ti,
    void *ptr);
__declspec(dllimport)
int ecs_value_fini(
    const ecs_world_t *world,
    ecs_entity_t type,
    void* ptr);
__declspec(dllimport)
int ecs_value_free(
    ecs_world_t *world,
    ecs_entity_t type,
    void* ptr);
__declspec(dllimport)
int ecs_value_copy_w_type_info(
    const ecs_world_t *world,
    const ecs_type_info_t *ti,
    void* dst,
    const void *src);
__declspec(dllimport)
int ecs_value_copy(
    const ecs_world_t *world,
    ecs_entity_t type,
    void* dst,
    const void *src);
int ecs_value_move_w_type_info(
    const ecs_world_t *world,
    const ecs_type_info_t *ti,
    void* dst,
    void *src);
int ecs_value_move(
    const ecs_world_t *world,
    ecs_entity_t type,
    void* dst,
    void *src);
int ecs_value_move_ctor_w_type_info(
    const ecs_world_t *world,
    const ecs_type_info_t *ti,
    void* dst,
    void *src);
int ecs_value_move_ctor(
    const ecs_world_t *world,
    ecs_entity_t type,
    void* dst,
    void *src);
__declspec(dllimport)
void ecs_deprecated_(
    const char *file,
    int32_t line,
    const char *msg);
__declspec(dllimport)
void ecs_log_push_(int32_t level);
__declspec(dllimport)
void ecs_log_pop_(int32_t level);
__declspec(dllimport)
bool ecs_should_log(int32_t level);
__declspec(dllimport)
const char* ecs_strerror(
    int32_t error_code);
__declspec(dllimport)
void ecs_print_(
    int32_t level,
    const char *file,
    int32_t line,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_printv_(
    int level,
    const char *file,
    int32_t line,
    const char *fmt,
    va_list args);
__declspec(dllimport)
void ecs_log_(
    int32_t level,
    const char *file,
    int32_t line,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_logv_(
    int level,
    const char *file,
    int32_t line,
    const char *fmt,
    va_list args);
__declspec(dllimport)
void ecs_abort_(
    int32_t error_code,
    const char *file,
    int32_t line,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_assert_log_(
    int32_t error_code,
    const char *condition_str,
    const char *file,
    int32_t line,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_parser_error_(
    const char *name,
    const char *expr,
    int64_t column,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_parser_errorv_(
    const char *name,
    const char *expr,
    int64_t column,
    const char *fmt,
    va_list args);
__declspec(dllimport)
void ecs_parser_warning_(
    const char *name,
    const char *expr,
    int64_t column,
    const char *fmt,
    ...);
__declspec(dllimport)
void ecs_parser_warningv_(
    const char *name,
    const char *expr,
    int64_t column,
    const char *fmt,
    va_list args);
__declspec(dllimport)
int ecs_log_set_level(
    int level);
__declspec(dllimport)
int ecs_log_get_level(void);
__declspec(dllimport)
bool ecs_log_enable_colors(
    bool enabled);
__declspec(dllimport)
bool ecs_log_enable_timestamp(
    bool enabled);
__declspec(dllimport)
bool ecs_log_enable_timedelta(
    bool enabled);
__declspec(dllimport)
int ecs_log_last_error(void);
__declspec(dllimport)
void ecs_log_start_capture(bool capture_try);
__declspec(dllimport)
char* ecs_log_stop_capture(void);
typedef int(*ecs_app_init_action_t)(
    ecs_world_t *world);
typedef struct ecs_app_desc_t {
    float target_fps;   
    float delta_time;   
    int32_t threads;          
    int32_t frames;           
    bool enable_rest;         
    bool enable_stats;      
    uint16_t port;            
    ecs_app_init_action_t init; 
    void *ctx;                
} ecs_app_desc_t;
typedef int(*ecs_app_run_action_t)(
    ecs_world_t *world,
    ecs_app_desc_t *desc);
typedef int(*ecs_app_frame_action_t)(
    ecs_world_t *world,
    const ecs_app_desc_t *desc);
__declspec(dllimport)
int ecs_app_run(
    ecs_world_t *world,
    ecs_app_desc_t *desc);
__declspec(dllimport)
int ecs_app_run_frame(
    ecs_world_t *world,
    const ecs_app_desc_t *desc);
__declspec(dllimport)
int ecs_app_set_run_action(
    ecs_app_run_action_t callback);
__declspec(dllimport)
int ecs_app_set_frame_action(
    ecs_app_frame_action_t callback);
typedef struct ecs_http_server_t ecs_http_server_t;
typedef struct {
    uint64_t id;
    ecs_http_server_t *server;
    char host[128];
    char port[16];
} ecs_http_connection_t;
typedef struct {
    const char *key;
    const char *value;
} ecs_http_key_value_t;
typedef enum {
    EcsHttpGet,
    EcsHttpPost,
    EcsHttpPut,
    EcsHttpDelete,
    EcsHttpOptions,
    EcsHttpMethodUnsupported
} ecs_http_method_t;
typedef struct {
    uint64_t id;
    ecs_http_method_t method;
    char *path;
    char *body;
    ecs_http_key_value_t headers[(32)];
    ecs_http_key_value_t params[(32)];
    int32_t header_count;
    int32_t param_count;
    ecs_http_connection_t *conn;
} ecs_http_request_t;
typedef struct {
    int code;                   
    ecs_strbuf_t body;          
    const char* status;         
    const char* content_type;   
    ecs_strbuf_t headers;       
} ecs_http_reply_t;
extern int64_t ecs_http_request_received_count;       
extern int64_t ecs_http_request_invalid_count;        
extern int64_t ecs_http_request_handled_ok_count;     
extern int64_t ecs_http_request_handled_error_count;  
extern int64_t ecs_http_request_not_handled_count;    
extern int64_t ecs_http_request_preflight_count;      
extern int64_t ecs_http_send_ok_count;                
extern int64_t ecs_http_send_error_count;             
extern int64_t ecs_http_busy_count;                   
typedef bool (*ecs_http_reply_action_t)(
    const ecs_http_request_t* request,
    ecs_http_reply_t *reply,
    void *ctx);
typedef struct {
    ecs_http_reply_action_t callback; 
    void *ctx;                        
    uint16_t port;                    
    const char *ipaddr;               
    int32_t send_queue_wait_ms;       
    double cache_timeout;             
    double cache_purge_timeout;       
} ecs_http_server_desc_t;
__declspec(dllimport)
ecs_http_server_t* ecs_http_server_init(
    const ecs_http_server_desc_t *desc);
__declspec(dllimport)
void ecs_http_server_fini(
    ecs_http_server_t* server);
__declspec(dllimport)
int ecs_http_server_start(
    ecs_http_server_t* server);
__declspec(dllimport)
void ecs_http_server_dequeue(
    ecs_http_server_t* server,
    float delta_time);
__declspec(dllimport)
void ecs_http_server_stop(
    ecs_http_server_t* server);
__declspec(dllimport)
int ecs_http_server_http_request(
    ecs_http_server_t* srv,
    const char *req,
    ecs_size_t len,
    ecs_http_reply_t *reply_out);
__declspec(dllimport)
int ecs_http_server_request(
    ecs_http_server_t* srv,
    const char *method,
    const char *req,
    const char *body,
    ecs_http_reply_t *reply_out);
__declspec(dllimport)
void* ecs_http_server_ctx(
    ecs_http_server_t* srv);
__declspec(dllimport)
const char* ecs_http_get_header(
    const ecs_http_request_t* req,
    const char* name);
__declspec(dllimport)
const char* ecs_http_get_param(
    const ecs_http_request_t* req,
    const char* name);
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsRestID_;
typedef struct {
    uint16_t port;      
    char *ipaddr;       
    void *impl;
} EcsRest;
__declspec(dllimport)
ecs_http_server_t* ecs_rest_server_init(
    ecs_world_t *world,
    const ecs_http_server_desc_t *desc);
__declspec(dllimport)
void ecs_rest_server_fini(
    ecs_http_server_t *srv);
__declspec(dllimport)
void FlecsRestImport(
    ecs_world_t *world);
typedef struct EcsTimer {
    float timeout;         
    float time;            
    float overshoot;       
    int32_t fired_count;         
    bool active;                 
    bool single_shot;            
} EcsTimer;
typedef struct EcsRateFilter {
    ecs_entity_t src;            
    int32_t rate;                
    int32_t tick_count;          
    float time_elapsed;    
} EcsRateFilter;
__declspec(dllimport)
ecs_entity_t ecs_set_timeout(
    ecs_world_t *world,
    ecs_entity_t tick_source,
    float timeout);
__declspec(dllimport)
float ecs_get_timeout(
    const ecs_world_t *world,
    ecs_entity_t tick_source);
__declspec(dllimport)
ecs_entity_t ecs_set_interval(
    ecs_world_t *world,
    ecs_entity_t tick_source,
    float interval);
__declspec(dllimport)
float ecs_get_interval(
    const ecs_world_t *world,
    ecs_entity_t tick_source);
__declspec(dllimport)
void ecs_start_timer(
    ecs_world_t *world,
    ecs_entity_t tick_source);
__declspec(dllimport)
void ecs_stop_timer(
    ecs_world_t *world,
    ecs_entity_t tick_source);
__declspec(dllimport)
void ecs_reset_timer(
    ecs_world_t *world,
    ecs_entity_t tick_source);
__declspec(dllimport)
void ecs_randomize_timers(
    ecs_world_t *world);
__declspec(dllimport)
ecs_entity_t ecs_set_rate(
    ecs_world_t *world,
    ecs_entity_t tick_source,
    int32_t rate,
    ecs_entity_t source);
__declspec(dllimport)
void ecs_set_tick_source(
    ecs_world_t *world,
    ecs_entity_t system,
    ecs_entity_t tick_source);
__declspec(dllimport)
void FlecsTimerImport(
    ecs_world_t *world);
typedef struct ecs_pipeline_desc_t {
    ecs_entity_t entity;
    ecs_query_desc_t query;
} ecs_pipeline_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_pipeline_init(
    ecs_world_t *world,
    const ecs_pipeline_desc_t *desc);
__declspec(dllimport)
void ecs_set_pipeline(
    ecs_world_t *world,
    ecs_entity_t pipeline);
__declspec(dllimport)
ecs_entity_t ecs_get_pipeline(
    const ecs_world_t *world);
__declspec(dllimport)
bool ecs_progress(
    ecs_world_t *world,
    float delta_time);
__declspec(dllimport)
void ecs_set_time_scale(
    ecs_world_t *world,
    float scale);
__declspec(dllimport)
void ecs_reset_clock(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_run_pipeline(
    ecs_world_t *world,
    ecs_entity_t pipeline,
    float delta_time);
__declspec(dllimport)
void ecs_set_threads(
    ecs_world_t *world,
    int32_t threads);
__declspec(dllimport)
void ecs_set_task_threads(
    ecs_world_t *world,
    int32_t task_threads);
__declspec(dllimport)
bool ecs_using_task_threads(
    ecs_world_t *world);
__declspec(dllimport)
void FlecsPipelineImport(
    ecs_world_t *world);
typedef struct EcsTickSource {
    bool tick;                 
    float time_elapsed;  
} EcsTickSource;
typedef struct ecs_system_desc_t {
    int32_t _canary;
    ecs_entity_t entity;
    ecs_query_desc_t query;
    ecs_iter_action_t callback;
    ecs_run_action_t run;
    void *ctx;
    ecs_ctx_free_t ctx_free;
    void *callback_ctx;
    ecs_ctx_free_t callback_ctx_free;
    void *run_ctx;
    ecs_ctx_free_t run_ctx_free;
    float interval;
    int32_t rate;
    ecs_entity_t tick_source;
    bool multi_threaded;
    bool immediate;
} ecs_system_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_system_init(
    ecs_world_t *world,
    const ecs_system_desc_t *desc);
typedef struct ecs_system_t {
    ecs_header_t hdr;
    ecs_run_action_t run;
    ecs_iter_action_t action;
    ecs_query_t *query;
    ecs_entity_t tick_source;
    bool multi_threaded;
    bool immediate;
    const char *name;
    void *ctx;
    void *callback_ctx;
    void *run_ctx;
    ecs_ctx_free_t ctx_free;
    ecs_ctx_free_t callback_ctx_free;
    ecs_ctx_free_t run_ctx_free;
    float time_spent;
    float time_passed;
    int64_t last_frame;
    flecs_poly_dtor_t dtor;      
} ecs_system_t;
__declspec(dllimport)
const ecs_system_t* ecs_system_get(
    const ecs_world_t *world,
    ecs_entity_t system);
__declspec(dllimport)
ecs_entity_t ecs_run(
    ecs_world_t *world,
    ecs_entity_t system,
    float delta_time,
    void *param);
__declspec(dllimport)
ecs_entity_t ecs_run_worker(
    ecs_world_t *world,
    ecs_entity_t system,
    int32_t stage_current,
    int32_t stage_count,
    float delta_time,
    void *param);
__declspec(dllimport)
void FlecsSystemImport(
    ecs_world_t *world);
typedef struct ecs_gauge_t {
    float avg[(60)];
    float min[(60)];
    float max[(60)];
} ecs_gauge_t;
typedef struct ecs_counter_t {
    ecs_gauge_t rate;                     
    double value[(60)];
} ecs_counter_t;
typedef union ecs_metric_t {
    ecs_gauge_t gauge;
    ecs_counter_t counter;
} ecs_metric_t;
typedef struct ecs_world_stats_t {
    int64_t first_;
    struct {
        ecs_metric_t count;               
        ecs_metric_t not_alive_count;     
    } entities;
    struct {
        ecs_metric_t tag_count;           
        ecs_metric_t component_count;     
        ecs_metric_t pair_count;          
        ecs_metric_t type_count;          
        ecs_metric_t create_count;        
        ecs_metric_t delete_count;        
    } components;
    struct {
        ecs_metric_t count;                
        ecs_metric_t empty_count;          
        ecs_metric_t create_count;         
        ecs_metric_t delete_count;         
    } tables;
    struct {
        ecs_metric_t query_count;          
        ecs_metric_t observer_count;       
        ecs_metric_t system_count;         
    } queries;
    struct {
        ecs_metric_t add_count;
        ecs_metric_t remove_count;
        ecs_metric_t delete_count;
        ecs_metric_t clear_count;
        ecs_metric_t set_count;
        ecs_metric_t ensure_count;
        ecs_metric_t modified_count;
        ecs_metric_t other_count;
        ecs_metric_t discard_count;
        ecs_metric_t batched_entity_count;
        ecs_metric_t batched_count;
    } commands;
    struct {
        ecs_metric_t frame_count;          
        ecs_metric_t merge_count;          
        ecs_metric_t rematch_count;        
        ecs_metric_t pipeline_build_count; 
        ecs_metric_t systems_ran;          
        ecs_metric_t observers_ran;        
        ecs_metric_t event_emit_count;     
    } frame;
    struct {
        ecs_metric_t world_time_raw;       
        ecs_metric_t world_time;           
        ecs_metric_t frame_time;           
        ecs_metric_t system_time;          
        ecs_metric_t emit_time;            
        ecs_metric_t merge_time;           
        ecs_metric_t rematch_time;         
        ecs_metric_t fps;                  
        ecs_metric_t delta_time;           
    } performance;
    struct {
        ecs_metric_t alloc_count;          
        ecs_metric_t realloc_count;        
        ecs_metric_t free_count;           
        ecs_metric_t outstanding_alloc_count; 
        ecs_metric_t block_alloc_count;    
        ecs_metric_t block_free_count;     
        ecs_metric_t block_outstanding_alloc_count; 
        ecs_metric_t stack_alloc_count;    
        ecs_metric_t stack_free_count;     
        ecs_metric_t stack_outstanding_alloc_count; 
    } memory;
    struct {
        ecs_metric_t request_received_count;
        ecs_metric_t request_invalid_count;
        ecs_metric_t request_handled_ok_count;
        ecs_metric_t request_handled_error_count;
        ecs_metric_t request_not_handled_count;
        ecs_metric_t request_preflight_count;
        ecs_metric_t send_ok_count;
        ecs_metric_t send_error_count;
        ecs_metric_t busy_count;
    } http;
    int64_t last_;
    int32_t t;
} ecs_world_stats_t;
typedef struct ecs_query_stats_t {
    int64_t first_;
    ecs_metric_t result_count;              
    ecs_metric_t matched_table_count;       
    ecs_metric_t matched_entity_count;      
    int64_t last_;
    int32_t t; 
} ecs_query_stats_t;
typedef struct ecs_system_stats_t {
    int64_t first_;
    ecs_metric_t time_spent;       
    int64_t last_;
    bool task;                     
    ecs_query_stats_t query;
} ecs_system_stats_t;
typedef struct ecs_sync_stats_t {
    int64_t first_;
    ecs_metric_t time_spent;
    ecs_metric_t commands_enqueued;
    int64_t last_;
    int32_t system_count;
    bool multi_threaded;
    bool immediate;
} ecs_sync_stats_t;
typedef struct ecs_pipeline_stats_t {
    int8_t canary_;
    ecs_vec_t systems;
    ecs_vec_t sync_points;
    int32_t t;
    int32_t system_count;        
    int32_t active_system_count; 
    int32_t rebuild_count;       
} ecs_pipeline_stats_t;
__declspec(dllimport)
void ecs_world_stats_get(
    const ecs_world_t *world,
    ecs_world_stats_t *stats);
__declspec(dllimport)
void ecs_world_stats_reduce(
    ecs_world_stats_t *dst,
    const ecs_world_stats_t *src);
__declspec(dllimport)
void ecs_world_stats_reduce_last(
    ecs_world_stats_t *stats,
    const ecs_world_stats_t *old,
    int32_t count);
__declspec(dllimport)
void ecs_world_stats_repeat_last(
    ecs_world_stats_t *stats);
__declspec(dllimport)
void ecs_world_stats_copy_last(
    ecs_world_stats_t *dst,
    const ecs_world_stats_t *src);
__declspec(dllimport)
void ecs_world_stats_log(
    const ecs_world_t *world,
    const ecs_world_stats_t *stats);
__declspec(dllimport)
void ecs_query_stats_get(
    const ecs_world_t *world,
    const ecs_query_t *query,
    ecs_query_stats_t *stats);
__declspec(dllimport) 
void ecs_query_cache_stats_reduce(
    ecs_query_stats_t *dst,
    const ecs_query_stats_t *src);
__declspec(dllimport)
void ecs_query_cache_stats_reduce_last(
    ecs_query_stats_t *stats,
    const ecs_query_stats_t *old,
    int32_t count);
__declspec(dllimport)
void ecs_query_cache_stats_repeat_last(
    ecs_query_stats_t *stats);
__declspec(dllimport)
void ecs_query_cache_stats_copy_last(
    ecs_query_stats_t *dst,
    const ecs_query_stats_t *src);
__declspec(dllimport)
bool ecs_system_stats_get(
    const ecs_world_t *world,
    ecs_entity_t system,
    ecs_system_stats_t *stats);
__declspec(dllimport)
void ecs_system_stats_reduce(
    ecs_system_stats_t *dst,
    const ecs_system_stats_t *src);
__declspec(dllimport)
void ecs_system_stats_reduce_last(
    ecs_system_stats_t *stats,
    const ecs_system_stats_t *old,
    int32_t count);
__declspec(dllimport)
void ecs_system_stats_repeat_last(
    ecs_system_stats_t *stats);
__declspec(dllimport)
void ecs_system_stats_copy_last(
    ecs_system_stats_t *dst,
    const ecs_system_stats_t *src);
__declspec(dllimport)
bool ecs_pipeline_stats_get(
    ecs_world_t *world,
    ecs_entity_t pipeline,
    ecs_pipeline_stats_t *stats);
__declspec(dllimport)
void ecs_pipeline_stats_fini(
    ecs_pipeline_stats_t *stats);
__declspec(dllimport)
void ecs_pipeline_stats_reduce(
    ecs_pipeline_stats_t *dst,
    const ecs_pipeline_stats_t *src);
__declspec(dllimport)
void ecs_pipeline_stats_reduce_last(
    ecs_pipeline_stats_t *stats,
    const ecs_pipeline_stats_t *old,
    int32_t count);
__declspec(dllimport)
void ecs_pipeline_stats_repeat_last(
    ecs_pipeline_stats_t *stats);
__declspec(dllimport)
void ecs_pipeline_stats_copy_last(
    ecs_pipeline_stats_t *dst,
    const ecs_pipeline_stats_t *src);
__declspec(dllimport)
void ecs_metric_reduce(
    ecs_metric_t *dst,
    const ecs_metric_t *src,
    int32_t t_dst,
    int32_t t_src);
__declspec(dllimport)
void ecs_metric_reduce_last(
    ecs_metric_t *m,
    int32_t t,
    int32_t count);
__declspec(dllimport)
void ecs_metric_copy(
    ecs_metric_t *m,
    int32_t dst,
    int32_t src);
__declspec(dllimport) extern ecs_entity_t FLECS_IDFlecsStatsID_;        
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsWorldStatsID_;     
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsWorldSummaryID_;   
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsSystemStatsID_;    
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsPipelineStatsID_;  
__declspec(dllimport) extern ecs_entity_t EcsPeriod1s;                 
__declspec(dllimport) extern ecs_entity_t EcsPeriod1m;                 
__declspec(dllimport) extern ecs_entity_t EcsPeriod1h;                 
__declspec(dllimport) extern ecs_entity_t EcsPeriod1d;                 
__declspec(dllimport) extern ecs_entity_t EcsPeriod1w;                 
typedef struct {
    float elapsed;
    int32_t reduce_count;
} EcsStatsHeader;
typedef struct {
    EcsStatsHeader hdr;
    ecs_world_stats_t stats;
} EcsWorldStats;
typedef struct {
    EcsStatsHeader hdr;
    ecs_map_t stats;
} EcsSystemStats;
typedef struct {
    EcsStatsHeader hdr;
    ecs_map_t stats;
} EcsPipelineStats;
typedef struct {
    double target_fps;          
    double time_scale;          
    double frame_time_total;    
    double system_time_total;   
    double merge_time_total;    
    double frame_time_last;     
    double system_time_last;    
    double merge_time_last;     
    int64_t frame_count;        
    int64_t command_count;      
    ecs_build_info_t build_info; 
} EcsWorldSummary;
__declspec(dllimport)
void FlecsStatsImport(
    ecs_world_t *world);
__declspec(dllimport) extern ecs_entity_t FLECS_IDFlecsMetricsID_;
__declspec(dllimport) extern ecs_entity_t EcsMetric, FLECS_IDEcsMetricID_;
__declspec(dllimport) extern ecs_entity_t EcsCounter, FLECS_IDEcsCounterID_;
__declspec(dllimport) extern ecs_entity_t EcsCounterIncrement, FLECS_IDEcsCounterIncrementID_;
__declspec(dllimport) extern ecs_entity_t EcsCounterId, FLECS_IDEcsCounterIdID_;
__declspec(dllimport) extern ecs_entity_t EcsGauge, FLECS_IDEcsGaugeID_;
__declspec(dllimport) extern ecs_entity_t EcsMetricInstance, FLECS_IDEcsMetricInstanceID_;
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsMetricValueID_;
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsMetricSourceID_;
typedef struct EcsMetricValue {
    double value;
} EcsMetricValue;
typedef struct EcsMetricSource {
    ecs_entity_t entity;
} EcsMetricSource;
typedef struct ecs_metric_desc_t {
    int32_t _canary;
    ecs_entity_t entity;
    ecs_entity_t member;
    const char *dotmember;
    ecs_id_t id;
    bool targets;
    ecs_entity_t kind;
    const char *brief;
} ecs_metric_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_metric_init(
    ecs_world_t *world,
    const ecs_metric_desc_t *desc);
__declspec(dllimport)
void FlecsMetricsImport(
    ecs_world_t *world);
__declspec(dllimport) extern ecs_entity_t FLECS_IDFlecsAlertsID_;
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsAlertID_;          
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsAlertInstanceID_;  
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsAlertsActiveID_;   
__declspec(dllimport) extern ecs_entity_t FLECS_IDEcsAlertTimeoutID_;   
__declspec(dllimport) extern ecs_entity_t EcsAlertInfo, FLECS_IDEcsAlertInfoID_;            
__declspec(dllimport) extern ecs_entity_t EcsAlertWarning, FLECS_IDEcsAlertWarningID_;         
__declspec(dllimport) extern ecs_entity_t EcsAlertError, FLECS_IDEcsAlertErrorID_;           
__declspec(dllimport) extern ecs_entity_t EcsAlertCritical, FLECS_IDEcsAlertCriticalID_;        
typedef struct EcsAlertInstance {
    char *message; 
} EcsAlertInstance;
typedef struct EcsAlertsActive {
    int32_t info_count;    
    int32_t warning_count; 
    int32_t error_count;   
    ecs_map_t alerts;
} EcsAlertsActive;
typedef struct ecs_alert_severity_filter_t {
    ecs_entity_t severity; 
    ecs_id_t with;         
    const char *var;       
    int32_t _var_index;    
} ecs_alert_severity_filter_t;
typedef struct ecs_alert_desc_t {
    int32_t _canary;
    ecs_entity_t entity;
    ecs_query_desc_t query;
    const char *message;
    const char *doc_name;
    const char *brief;
    ecs_entity_t severity;
    ecs_alert_severity_filter_t severity_filters[(4)];
    float retain_period;
    ecs_entity_t member;
    ecs_id_t id;
    const char *var;
} ecs_alert_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_alert_init(
    ecs_world_t *world,
    const ecs_alert_desc_t *desc);
__declspec(dllimport)
int32_t ecs_get_alert_count(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_entity_t alert);
__declspec(dllimport)
ecs_entity_t ecs_get_alert(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_entity_t alert);
__declspec(dllimport)
void FlecsAlertsImport(
    ecs_world_t *world);
typedef struct ecs_from_json_desc_t {
    const char *name; 
    const char *expr; 
    ecs_entity_t (*lookup_action)(
        ecs_world_t*,
        const char *value,
        void *ctx);
    void *lookup_ctx;
    bool strict;
} ecs_from_json_desc_t;
__declspec(dllimport)
const char* ecs_ptr_from_json(
    const ecs_world_t *world,
    ecs_entity_t type,
    void *ptr,
    const char *json,
    const ecs_from_json_desc_t *desc);
__declspec(dllimport)
const char* ecs_entity_from_json(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *json,
    const ecs_from_json_desc_t *desc);
__declspec(dllimport)
const char* ecs_world_from_json(
    ecs_world_t *world,
    const char *json,
    const ecs_from_json_desc_t *desc);
__declspec(dllimport)
const char* ecs_world_from_json_file(
    ecs_world_t *world,
    const char *filename,
    const ecs_from_json_desc_t *desc);
__declspec(dllimport)
char* ecs_array_to_json(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data,
    int32_t count);
__declspec(dllimport)
int ecs_array_to_json_buf(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data,
    int32_t count,
    ecs_strbuf_t *buf_out);
__declspec(dllimport)
char* ecs_ptr_to_json(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data);
__declspec(dllimport)
int ecs_ptr_to_json_buf(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data,
    ecs_strbuf_t *buf_out);
__declspec(dllimport)
char* ecs_type_info_to_json(
    const ecs_world_t *world,
    ecs_entity_t type);
__declspec(dllimport)
int ecs_type_info_to_json_buf(
    const ecs_world_t *world,
    ecs_entity_t type,
    ecs_strbuf_t *buf_out);
typedef struct ecs_entity_to_json_desc_t {
    bool serialize_entity_id;  
    bool serialize_doc;        
    bool serialize_full_paths; 
    bool serialize_inherited;  
    bool serialize_values;     
    bool serialize_builtin;    
    bool serialize_type_info;  
    bool serialize_alerts;     
    ecs_entity_t serialize_refs; 
    bool serialize_matches;    
} ecs_entity_to_json_desc_t;
__declspec(dllimport)
char* ecs_entity_to_json(
    const ecs_world_t *world,
    ecs_entity_t entity,
    const ecs_entity_to_json_desc_t *desc);
__declspec(dllimport)
int ecs_entity_to_json_buf(
    const ecs_world_t *world,
    ecs_entity_t entity,
    ecs_strbuf_t *buf_out,
    const ecs_entity_to_json_desc_t *desc);
typedef struct ecs_iter_to_json_desc_t {
    bool serialize_entity_ids;      
    bool serialize_values;          
    bool serialize_builtin;         
    bool serialize_doc;             
    bool serialize_full_paths;      
    bool serialize_fields;          
    bool serialize_inherited;       
    bool serialize_table;           
    bool serialize_type_info;       
    bool serialize_field_info;      
    bool serialize_query_info;      
    bool serialize_query_plan;      
    bool serialize_query_profile;   
    bool dont_serialize_results;    
    bool serialize_alerts;          
    ecs_entity_t serialize_refs;    
    bool serialize_matches;         
    ecs_poly_t *query;            
} ecs_iter_to_json_desc_t;
__declspec(dllimport)
char* ecs_iter_to_json(
    ecs_iter_t *iter,
    const ecs_iter_to_json_desc_t *desc);
__declspec(dllimport)
int ecs_iter_to_json_buf(
    ecs_iter_t *iter,
    ecs_strbuf_t *buf_out,
    const ecs_iter_to_json_desc_t *desc);
typedef struct ecs_world_to_json_desc_t {
    bool serialize_builtin;    
    bool serialize_modules;    
} ecs_world_to_json_desc_t;
__declspec(dllimport)
char* ecs_world_to_json(
    ecs_world_t *world,
    const ecs_world_to_json_desc_t *desc);
__declspec(dllimport)
int ecs_world_to_json_buf(
    ecs_world_t *world,
    ecs_strbuf_t *buf_out,
    const ecs_world_to_json_desc_t *desc);
__declspec(dllimport) extern ecs_entity_t EcsUnitPrefixes; 
__declspec(dllimport) extern ecs_entity_t EcsYocto;  
__declspec(dllimport) extern ecs_entity_t EcsZepto;  
__declspec(dllimport) extern ecs_entity_t EcsAtto;   
__declspec(dllimport) extern ecs_entity_t EcsFemto;  
__declspec(dllimport) extern ecs_entity_t EcsPico;   
__declspec(dllimport) extern ecs_entity_t EcsNano;   
__declspec(dllimport) extern ecs_entity_t EcsMicro;  
__declspec(dllimport) extern ecs_entity_t EcsMilli;  
__declspec(dllimport) extern ecs_entity_t EcsCenti;  
__declspec(dllimport) extern ecs_entity_t EcsDeci;   
__declspec(dllimport) extern ecs_entity_t EcsDeca;   
__declspec(dllimport) extern ecs_entity_t EcsHecto;  
__declspec(dllimport) extern ecs_entity_t EcsKilo;   
__declspec(dllimport) extern ecs_entity_t EcsMega;   
__declspec(dllimport) extern ecs_entity_t EcsGiga;   
__declspec(dllimport) extern ecs_entity_t EcsTera;   
__declspec(dllimport) extern ecs_entity_t EcsPeta;   
__declspec(dllimport) extern ecs_entity_t EcsExa;    
__declspec(dllimport) extern ecs_entity_t EcsZetta;  
__declspec(dllimport) extern ecs_entity_t EcsYotta;  
__declspec(dllimport) extern ecs_entity_t EcsKibi;   
__declspec(dllimport) extern ecs_entity_t EcsMebi;   
__declspec(dllimport) extern ecs_entity_t EcsGibi;   
__declspec(dllimport) extern ecs_entity_t EcsTebi;   
__declspec(dllimport) extern ecs_entity_t EcsPebi;   
__declspec(dllimport) extern ecs_entity_t EcsExbi;   
__declspec(dllimport) extern ecs_entity_t EcsZebi;   
__declspec(dllimport) extern ecs_entity_t EcsYobi;   
__declspec(dllimport) extern ecs_entity_t EcsDuration;         
__declspec(dllimport) extern     ecs_entity_t EcsPicoSeconds;  
__declspec(dllimport) extern     ecs_entity_t EcsNanoSeconds;  
__declspec(dllimport) extern     ecs_entity_t EcsMicroSeconds; 
__declspec(dllimport) extern     ecs_entity_t EcsMilliSeconds; 
__declspec(dllimport) extern     ecs_entity_t EcsSeconds;      
__declspec(dllimport) extern     ecs_entity_t EcsMinutes;      
__declspec(dllimport) extern     ecs_entity_t EcsHours;        
__declspec(dllimport) extern     ecs_entity_t EcsDays;         
__declspec(dllimport) extern ecs_entity_t EcsTime;             
__declspec(dllimport) extern     ecs_entity_t EcsDate;         
__declspec(dllimport) extern ecs_entity_t EcsMass;             
__declspec(dllimport) extern     ecs_entity_t EcsGrams;        
__declspec(dllimport) extern     ecs_entity_t EcsKiloGrams;    
__declspec(dllimport) extern ecs_entity_t EcsElectricCurrent;  
__declspec(dllimport) extern     ecs_entity_t EcsAmpere;       
__declspec(dllimport) extern ecs_entity_t EcsAmount;           
__declspec(dllimport) extern     ecs_entity_t EcsMole;         
__declspec(dllimport) extern ecs_entity_t EcsLuminousIntensity; 
__declspec(dllimport) extern     ecs_entity_t EcsCandela;       
__declspec(dllimport) extern ecs_entity_t EcsForce;            
__declspec(dllimport) extern     ecs_entity_t EcsNewton;       
__declspec(dllimport) extern ecs_entity_t EcsLength;              
__declspec(dllimport) extern     ecs_entity_t EcsMeters;          
__declspec(dllimport) extern         ecs_entity_t EcsPicoMeters;  
__declspec(dllimport) extern         ecs_entity_t EcsNanoMeters;  
__declspec(dllimport) extern         ecs_entity_t EcsMicroMeters; 
__declspec(dllimport) extern         ecs_entity_t EcsMilliMeters; 
__declspec(dllimport) extern         ecs_entity_t EcsCentiMeters; 
__declspec(dllimport) extern         ecs_entity_t EcsKiloMeters;  
__declspec(dllimport) extern     ecs_entity_t EcsMiles;           
__declspec(dllimport) extern     ecs_entity_t EcsPixels;          
__declspec(dllimport) extern ecs_entity_t EcsPressure;          
__declspec(dllimport) extern     ecs_entity_t EcsPascal;        
__declspec(dllimport) extern     ecs_entity_t EcsBar;           
__declspec(dllimport) extern ecs_entity_t EcsSpeed;                   
__declspec(dllimport) extern     ecs_entity_t EcsMetersPerSecond;     
__declspec(dllimport) extern     ecs_entity_t EcsKiloMetersPerSecond; 
__declspec(dllimport) extern     ecs_entity_t EcsKiloMetersPerHour;   
__declspec(dllimport) extern     ecs_entity_t EcsMilesPerHour;        
__declspec(dllimport) extern ecs_entity_t EcsTemperature;       
__declspec(dllimport) extern     ecs_entity_t EcsKelvin;        
__declspec(dllimport) extern     ecs_entity_t EcsCelsius;       
__declspec(dllimport) extern     ecs_entity_t EcsFahrenheit;    
__declspec(dllimport) extern ecs_entity_t EcsData;               
__declspec(dllimport) extern     ecs_entity_t EcsBits;           
__declspec(dllimport) extern         ecs_entity_t EcsKiloBits;   
__declspec(dllimport) extern         ecs_entity_t EcsMegaBits;   
__declspec(dllimport) extern         ecs_entity_t EcsGigaBits;   
__declspec(dllimport) extern     ecs_entity_t EcsBytes;          
__declspec(dllimport) extern         ecs_entity_t EcsKiloBytes;  
__declspec(dllimport) extern         ecs_entity_t EcsMegaBytes;  
__declspec(dllimport) extern         ecs_entity_t EcsGigaBytes;  
__declspec(dllimport) extern         ecs_entity_t EcsKibiBytes;  
__declspec(dllimport) extern         ecs_entity_t EcsMebiBytes;  
__declspec(dllimport) extern         ecs_entity_t EcsGibiBytes;  
__declspec(dllimport) extern ecs_entity_t EcsDataRate;               
__declspec(dllimport) extern     ecs_entity_t EcsBitsPerSecond;      
__declspec(dllimport) extern     ecs_entity_t EcsKiloBitsPerSecond;  
__declspec(dllimport) extern     ecs_entity_t EcsMegaBitsPerSecond;  
__declspec(dllimport) extern     ecs_entity_t EcsGigaBitsPerSecond;  
__declspec(dllimport) extern     ecs_entity_t EcsBytesPerSecond;     
__declspec(dllimport) extern     ecs_entity_t EcsKiloBytesPerSecond; 
__declspec(dllimport) extern     ecs_entity_t EcsMegaBytesPerSecond; 
__declspec(dllimport) extern     ecs_entity_t EcsGigaBytesPerSecond; 
__declspec(dllimport) extern ecs_entity_t EcsAngle;            
__declspec(dllimport) extern     ecs_entity_t EcsRadians;      
__declspec(dllimport) extern     ecs_entity_t EcsDegrees;      
__declspec(dllimport) extern ecs_entity_t EcsFrequency;        
__declspec(dllimport) extern     ecs_entity_t EcsHertz;        
__declspec(dllimport) extern     ecs_entity_t EcsKiloHertz;    
__declspec(dllimport) extern     ecs_entity_t EcsMegaHertz;    
__declspec(dllimport) extern     ecs_entity_t EcsGigaHertz;    
__declspec(dllimport) extern ecs_entity_t EcsUri;              
__declspec(dllimport) extern     ecs_entity_t EcsUriHyperlink; 
__declspec(dllimport) extern     ecs_entity_t EcsUriImage;     
__declspec(dllimport) extern     ecs_entity_t EcsUriFile;      
__declspec(dllimport) extern ecs_entity_t EcsColor;            
__declspec(dllimport) extern     ecs_entity_t EcsColorRgb;     
__declspec(dllimport) extern     ecs_entity_t EcsColorHsl;     
__declspec(dllimport) extern     ecs_entity_t EcsColorCss;     
__declspec(dllimport) extern ecs_entity_t EcsAcceleration;     
__declspec(dllimport) extern ecs_entity_t EcsPercentage;       
__declspec(dllimport) extern ecs_entity_t EcsBel;              
__declspec(dllimport) extern ecs_entity_t EcsDeciBel;          
__declspec(dllimport)
void FlecsUnitsImport(
    ecs_world_t *world);
__declspec(dllimport)
extern ecs_entity_t FLECS_IDEcsScriptID_;
__declspec(dllimport)
extern ecs_entity_t EcsScriptTemplate, FLECS_IDEcsScriptTemplateID_;
__declspec(dllimport)
extern ecs_entity_t FLECS_IDEcsScriptConstVarID_;
__declspec(dllimport)
extern ecs_entity_t FLECS_IDEcsScriptFunctionID_;
__declspec(dllimport)
extern ecs_entity_t FLECS_IDEcsScriptMethodID_;
typedef struct ecs_script_template_t ecs_script_template_t;
typedef struct ecs_script_var_t {
    const char *name;
    ecs_value_t value;
    const ecs_type_info_t *type_info;
    int32_t sp;
    bool is_const;
} ecs_script_var_t;
typedef struct ecs_script_vars_t {
    struct ecs_script_vars_t *parent;
    int32_t sp;
    ecs_hashmap_t var_index;
    ecs_vec_t vars;
    const ecs_world_t *world;
    struct ecs_stack_t *stack;
    ecs_stack_cursor_t *cursor;
    ecs_allocator_t *allocator;
} ecs_script_vars_t;
typedef struct ecs_script_t {
    ecs_world_t *world;
    const char *name;
    const char *code;
} ecs_script_t;
typedef struct ecs_script_runtime_t ecs_script_runtime_t;
typedef struct EcsScript {
    char *filename;
    char *code;
    char *error; 
    ecs_script_t *script;
    ecs_script_template_t *template_; 
} EcsScript;
typedef struct ecs_function_ctx_t {
    ecs_world_t *world;
    ecs_entity_t function;
    void *ctx;
} ecs_function_ctx_t;
typedef void(*ecs_function_callback_t)(
    const ecs_function_ctx_t *ctx,
    int32_t argc,
    const ecs_value_t *argv,
    ecs_value_t *result);
typedef struct ecs_script_parameter_t {
    const char *name;
    ecs_entity_t type;
} ecs_script_parameter_t;
typedef struct EcsScriptConstVar {
    ecs_value_t value;
    const ecs_type_info_t *type_info;
} EcsScriptConstVar;
typedef struct EcsScriptFunction {
    ecs_entity_t return_type;
    ecs_vec_t params; 
    ecs_function_callback_t callback;
    void *ctx;
} EcsScriptFunction;
typedef struct EcsScriptMethod {
    ecs_entity_t return_type;
    ecs_vec_t params; 
    ecs_function_callback_t callback;
    void *ctx;
} EcsScriptMethod;
typedef struct ecs_script_eval_desc_t {
    ecs_script_vars_t *vars;       
    ecs_script_runtime_t *runtime; 
} ecs_script_eval_desc_t;
typedef struct ecs_script_eval_result_t {
    char *error;
} ecs_script_eval_result_t;
__declspec(dllimport)
ecs_script_t* ecs_script_parse(
    ecs_world_t *world,
    const char *name,
    const char *code,
    const ecs_script_eval_desc_t *desc,
    ecs_script_eval_result_t *result);
__declspec(dllimport)
int ecs_script_eval(
    const ecs_script_t *script,
    const ecs_script_eval_desc_t *desc,
    ecs_script_eval_result_t *result);
__declspec(dllimport)
void ecs_script_free(
    ecs_script_t *script);
__declspec(dllimport)
int ecs_script_run(
    ecs_world_t *world,
    const char *name,
    const char *code,
    ecs_script_eval_result_t *result);
__declspec(dllimport)
int ecs_script_run_file(
    ecs_world_t *world,
    const char *filename);
__declspec(dllimport)
ecs_script_runtime_t* ecs_script_runtime_new(void);
__declspec(dllimport)
void ecs_script_runtime_free(
    ecs_script_runtime_t *runtime);
__declspec(dllimport)
int ecs_script_ast_to_buf(
    ecs_script_t *script,
    ecs_strbuf_t *buf,
    bool colors);
__declspec(dllimport)
char* ecs_script_ast_to_str(
    ecs_script_t *script,
    bool colors);
typedef struct ecs_script_desc_t {
    ecs_entity_t entity;   
    const char *filename;  
    const char *code;      
} ecs_script_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_script_init(
    ecs_world_t *world,
    const ecs_script_desc_t *desc);
__declspec(dllimport)
int ecs_script_update(
    ecs_world_t *world,
    ecs_entity_t script,
    ecs_entity_t instance,
    const char *code);
__declspec(dllimport)
void ecs_script_clear(
    ecs_world_t *world,
    ecs_entity_t script,
    ecs_entity_t instance);
__declspec(dllimport)
ecs_script_vars_t* ecs_script_vars_init(
    ecs_world_t *world);
__declspec(dllimport)
void ecs_script_vars_fini(
    ecs_script_vars_t *vars);
__declspec(dllimport)
ecs_script_vars_t* ecs_script_vars_push(
    ecs_script_vars_t *parent);
__declspec(dllimport)
ecs_script_vars_t* ecs_script_vars_pop(
    ecs_script_vars_t *vars);
__declspec(dllimport)
ecs_script_var_t* ecs_script_vars_declare(
    ecs_script_vars_t *vars,
    const char *name);
__declspec(dllimport)
ecs_script_var_t* ecs_script_vars_define_id(
    ecs_script_vars_t *vars,
    const char *name,
    ecs_entity_t type);
__declspec(dllimport)
ecs_script_var_t* ecs_script_vars_lookup(
    const ecs_script_vars_t *vars,
    const char *name);
__declspec(dllimport)
ecs_script_var_t* ecs_script_vars_from_sp(
    const ecs_script_vars_t *vars,
    int32_t sp);
__declspec(dllimport)
void ecs_script_vars_print(
    const ecs_script_vars_t *vars);
__declspec(dllimport)
void ecs_script_vars_set_size(
    ecs_script_vars_t *vars,
    int32_t count);
__declspec(dllimport)
void ecs_script_vars_from_iter(
    const ecs_iter_t *it,
    ecs_script_vars_t *vars,
    int offset);
typedef struct ecs_expr_eval_desc_t {
    const char *name;                
    const char *expr;                
    const ecs_script_vars_t *vars;   
    ecs_entity_t type;               
    ecs_entity_t (*lookup_action)(   
        const ecs_world_t*,
        const char *value,
        void *ctx);
    void *lookup_ctx;                
    bool disable_folding;
    bool disable_dynamic_variable_binding;
    bool allow_unresolved_identifiers;
    ecs_script_runtime_t *runtime;   
    void *script_visitor;            
} ecs_expr_eval_desc_t;
__declspec(dllimport)
const char* ecs_expr_run(
    ecs_world_t *world,
    const char *ptr,
    ecs_value_t *value,
    const ecs_expr_eval_desc_t *desc);
__declspec(dllimport)
ecs_script_t* ecs_expr_parse(
    ecs_world_t *world,
    const char *expr,
    const ecs_expr_eval_desc_t *desc);
__declspec(dllimport)
int ecs_expr_eval(
    const ecs_script_t *script,
    ecs_value_t *value,
    const ecs_expr_eval_desc_t *desc);
__declspec(dllimport)
char* ecs_script_string_interpolate(
    ecs_world_t *world,
    const char *str,
    const ecs_script_vars_t *vars);
typedef struct ecs_const_var_desc_t {
    const char *name;
    ecs_entity_t parent;
    ecs_entity_t type;
    void *value;
} ecs_const_var_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_const_var_init(
    ecs_world_t *world,
    ecs_const_var_desc_t *desc);
__declspec(dllimport)
ecs_value_t ecs_const_var_get(
    const ecs_world_t *world,
    ecs_entity_t var);
typedef struct ecs_function_desc_t {
    const char *name;
    ecs_entity_t parent;
    ecs_script_parameter_t params[(16)];
    ecs_entity_t return_type;
    ecs_function_callback_t callback;
    void *ctx;
} ecs_function_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_function_init(
    ecs_world_t *world,
    const ecs_function_desc_t *desc);
__declspec(dllimport)
ecs_entity_t ecs_method_init(
    ecs_world_t *world,
    const ecs_function_desc_t *desc);
__declspec(dllimport)
char* ecs_ptr_to_expr(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data);
__declspec(dllimport)
int ecs_ptr_to_expr_buf(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data,
    ecs_strbuf_t *buf);
__declspec(dllimport)
char* ecs_ptr_to_str(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data);
__declspec(dllimport)
int ecs_ptr_to_str_buf(
    const ecs_world_t *world,
    ecs_entity_t type,
    const void *data,
    ecs_strbuf_t *buf);
typedef struct ecs_expr_node_t ecs_expr_node_t; 
__declspec(dllimport)
void FlecsScriptImport(
    ecs_world_t *world);
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsDocDescriptionID_; 
__declspec(dllimport) extern const ecs_entity_t EcsDocUuid;
__declspec(dllimport) extern const ecs_entity_t EcsDocBrief;
__declspec(dllimport) extern const ecs_entity_t EcsDocDetail;
__declspec(dllimport) extern const ecs_entity_t EcsDocLink;
__declspec(dllimport) extern const ecs_entity_t EcsDocColor;
typedef struct EcsDocDescription {
    char *value;
} EcsDocDescription;
__declspec(dllimport)
void ecs_doc_set_uuid(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *uuid);
__declspec(dllimport)
void ecs_doc_set_name(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *name);
__declspec(dllimport)
void ecs_doc_set_brief(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *description);
__declspec(dllimport)
void ecs_doc_set_detail(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *description);
__declspec(dllimport)
void ecs_doc_set_link(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *link);
__declspec(dllimport)
void ecs_doc_set_color(
    ecs_world_t *world,
    ecs_entity_t entity,
    const char *color);
__declspec(dllimport)
const char* ecs_doc_get_uuid(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const char* ecs_doc_get_name(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const char* ecs_doc_get_brief(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const char* ecs_doc_get_detail(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const char* ecs_doc_get_link(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
const char* ecs_doc_get_color(
    const ecs_world_t *world,
    ecs_entity_t entity);
__declspec(dllimport)
void FlecsDocImport(
    ecs_world_t *world);
typedef bool ecs_bool_t;                                        
typedef char ecs_char_t;                                        
typedef unsigned char ecs_byte_t;                               
typedef uint8_t ecs_u8_t;                                       
typedef uint16_t ecs_u16_t;                                     
typedef uint32_t ecs_u32_t;                                     
typedef uint64_t ecs_u64_t;                                     
typedef uintptr_t ecs_uptr_t;                                   
typedef int8_t ecs_i8_t;                                        
typedef int16_t ecs_i16_t;                                      
typedef int32_t ecs_i32_t;                                      
typedef int64_t ecs_i64_t;                                      
typedef intptr_t ecs_iptr_t;                                    
typedef float ecs_f32_t;                                        
typedef double ecs_f64_t;                                       
typedef char* ecs_string_t;                                     
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsTypeID_;            
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsTypeSerializerID_;  
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsPrimitiveID_;       
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsEnumID_;            
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsBitmaskID_;         
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsConstantsID_;       
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsMemberID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsMemberRangesID_;    
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsStructID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsArrayID_;           
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsVectorID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsOpaqueID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsUnitID_;            
__declspec(dllimport) extern const ecs_entity_t FLECS_IDEcsUnitPrefixID_;      
__declspec(dllimport) extern const ecs_entity_t EcsQuantity;                
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_bool_tID_;         
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_char_tID_;         
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_byte_tID_;         
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_u8_tID_;           
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_u16_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_u32_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_u64_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_uptr_tID_;         
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_i8_tID_;           
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_i16_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_i32_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_i64_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_iptr_tID_;         
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_f32_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_f64_tID_;          
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_string_tID_;       
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_entity_tID_;       
__declspec(dllimport) extern const ecs_entity_t FLECS_IDecs_id_tID_;           
typedef enum ecs_type_kind_t {
    EcsPrimitiveType,
    EcsBitmaskType,
    EcsEnumType,
    EcsStructType,
    EcsArrayType,
    EcsVectorType,
    EcsOpaqueType,
    EcsTypeKindLast = EcsOpaqueType
} ecs_type_kind_t;
typedef struct EcsType {
    ecs_type_kind_t kind;  
    bool existing;         
    bool partial;          
} EcsType;
typedef enum ecs_primitive_kind_t {
    EcsBool = 1,
    EcsChar,
    EcsByte,
    EcsU8,
    EcsU16,
    EcsU32,
    EcsU64,
    EcsI8,
    EcsI16,
    EcsI32,
    EcsI64,
    EcsF32,
    EcsF64,
    EcsUPtr,
    EcsIPtr,
    EcsString,
    EcsEntity,
    EcsId,
    EcsPrimitiveKindLast = EcsId
} ecs_primitive_kind_t;
typedef struct EcsPrimitive {
    ecs_primitive_kind_t kind;                     
} EcsPrimitive;
typedef struct EcsMember {
    ecs_entity_t type;                             
    int32_t count;                                 
    ecs_entity_t unit;                             
    int32_t offset;                                
    bool use_offset;                               
} EcsMember;
typedef struct ecs_member_value_range_t {
    double min;                                    
    double max;                                    
} ecs_member_value_range_t;
typedef struct EcsMemberRanges {
    ecs_member_value_range_t value;                
    ecs_member_value_range_t warning;              
    ecs_member_value_range_t error;                
} EcsMemberRanges;
typedef struct ecs_member_t {
    const char *name;
    ecs_entity_t type;
    int32_t count;
    int32_t offset;
    ecs_entity_t unit;
    bool use_offset;
    ecs_member_value_range_t range;
    ecs_member_value_range_t error_range;
    ecs_member_value_range_t warning_range;
    ecs_size_t size;
    ecs_entity_t member;
} ecs_member_t;
typedef struct EcsStruct {
    ecs_vec_t members; 
} EcsStruct;
typedef struct ecs_enum_constant_t {
    const char *name;
    int64_t value;
    uint64_t value_unsigned;
    ecs_entity_t constant;
} ecs_enum_constant_t;
typedef struct EcsEnum {
    ecs_entity_t underlying_type;
} EcsEnum;
typedef struct ecs_bitmask_constant_t {
    const char *name;
    ecs_flags64_t value;
    int64_t _unused;
    ecs_entity_t constant;
} ecs_bitmask_constant_t;
typedef struct EcsBitmask {
    int32_t dummy_;
} EcsBitmask;
typedef struct EcsConstants {
    ecs_map_t *constants; 
    ecs_vec_t ordered_constants; 
} EcsConstants;
typedef struct EcsArray {
    ecs_entity_t type; 
    int32_t count;     
} EcsArray;
typedef struct EcsVector {
    ecs_entity_t type; 
} EcsVector;
typedef struct ecs_serializer_t {
    int (*value)(
        const struct ecs_serializer_t *ser, 
        ecs_entity_t type,                  
        const void *value);                 
    int (*member)(
        const struct ecs_serializer_t *ser, 
        const char *member);                
    const ecs_world_t *world;               
    void *ctx;                              
} ecs_serializer_t;
typedef int (*ecs_meta_serialize_t)(
    const ecs_serializer_t *ser,
    const void *src);                  
typedef int (*ecs_meta_serialize_member_t)(
    const ecs_serializer_t *ser,
    const void *src,                   
    const char* name);                 
typedef int (*ecs_meta_serialize_element_t)(
    const ecs_serializer_t *ser,
    const void *src,                   
    size_t elem);                      
typedef struct EcsOpaque {
    ecs_entity_t as_type;              
    ecs_meta_serialize_t serialize;    
    ecs_meta_serialize_member_t serialize_member; 
    ecs_meta_serialize_element_t serialize_element; 
    void (*assign_bool)(
        void *dst,
        bool value);
    void (*assign_char)(
        void *dst,
        char value);
    void (*assign_int)(
        void *dst,
        int64_t value);
    void (*assign_uint)(
        void *dst,
        uint64_t value);
    void (*assign_float)(
        void *dst,
        double value);
    void (*assign_string)(
        void *dst,
        const char *value);
    void (*assign_entity)(
        void *dst,
        ecs_world_t *world,
        ecs_entity_t entity);
    void (*assign_id)(
        void *dst,
        ecs_world_t *world,
        ecs_id_t id);
    void (*assign_null)(
        void *dst);
    void (*clear)(
        void *dst);
    void* (*ensure_element)(
        void *dst,
        size_t elem);
    void* (*ensure_member)(
        void *dst,
        const char *member);
    size_t (*count)(
        const void *dst);
    void (*resize)(
        void *dst,
        size_t count);
} EcsOpaque;
typedef struct ecs_unit_translation_t {
    int32_t factor; 
    int32_t power;  
} ecs_unit_translation_t;
typedef struct EcsUnit {
    char *symbol;                                  
    ecs_entity_t prefix;                           
    ecs_entity_t base;                             
    ecs_entity_t over;                             
    ecs_unit_translation_t translation;            
} EcsUnit;
typedef struct EcsUnitPrefix {
    char *symbol;                                 
    ecs_unit_translation_t translation;           
} EcsUnitPrefix;
typedef enum ecs_meta_op_kind_t {
    EcsOpPushStruct,   
    EcsOpPushArray,    
    EcsOpPushVector,   
    EcsOpPop,          
    EcsOpOpaqueStruct, 
    EcsOpOpaqueArray,  
    EcsOpOpaqueVector, 
    EcsOpForward,      
    EcsOpScope,        
    EcsOpOpaqueValue,  
    EcsOpEnum,
    EcsOpBitmask,
    EcsOpPrimitive,    
    EcsOpBool,
    EcsOpChar,
    EcsOpByte,
    EcsOpU8,
    EcsOpU16,
    EcsOpU32,
    EcsOpU64,
    EcsOpI8,
    EcsOpI16,
    EcsOpI32,
    EcsOpI64,
    EcsOpF32,
    EcsOpF64,
    EcsOpUPtr,
    EcsOpIPtr,
    EcsOpString,
    EcsOpEntity,
    EcsOpId,
    EcsMetaTypeOpKindLast = EcsOpId
} ecs_meta_op_kind_t;
typedef struct ecs_meta_op_t {
    ecs_meta_op_kind_t kind;                       
    ecs_meta_op_kind_t underlying_kind;            
    ecs_size_t offset;                             
    const char *name;                              
    ecs_size_t elem_size;                          
    int16_t op_count;                              
    int16_t member_index;                          
    ecs_entity_t type;                             
    const ecs_type_info_t *type_info;              
    union {
        ecs_hashmap_t *members;                    
        ecs_map_t *constants;                      
        ecs_meta_serialize_t opaque;               
    } is;
} ecs_meta_op_t;
typedef struct EcsTypeSerializer {
    ecs_type_kind_t kind;         
    ecs_vec_t ops;                
} EcsTypeSerializer;
typedef struct ecs_meta_scope_t {
    ecs_entity_t type;                             
    ecs_meta_op_t *ops;                       
    int16_t ops_count;                             
    int16_t ops_cur;                               
    int16_t prev_depth;                            
    void *ptr;                                     
    const EcsOpaque *opaque;                       
    ecs_hashmap_t *members;                        
    bool is_collection;                            
    bool is_empty_scope;                           
    bool is_moved_scope;                           
    int32_t elem, elem_count;                      
} ecs_meta_scope_t;
typedef struct ecs_meta_cursor_t {
    const ecs_world_t *world;                      
    ecs_meta_scope_t scope[(32)]; 
    int16_t depth;                                 
    bool valid;                                    
    bool is_primitive_scope;                       
    ecs_entity_t (*lookup_action)(ecs_world_t*, const char*, void*);
    void *lookup_ctx;                              
} ecs_meta_cursor_t;
__declspec(dllimport)
char* ecs_meta_serializer_to_str(
    ecs_world_t *world,
    ecs_entity_t type);
__declspec(dllimport)
ecs_meta_cursor_t ecs_meta_cursor(
    const ecs_world_t *world,
    ecs_entity_t type,
    void *ptr);
__declspec(dllimport)
void* ecs_meta_get_ptr(
    ecs_meta_cursor_t *cursor);
__declspec(dllimport)
int ecs_meta_next(
    ecs_meta_cursor_t *cursor);
__declspec(dllimport)
int ecs_meta_elem(
    ecs_meta_cursor_t *cursor,
    int32_t elem);
__declspec(dllimport)
int ecs_meta_member(
    ecs_meta_cursor_t *cursor,
    const char *name);
__declspec(dllimport)
int ecs_meta_try_member(
    ecs_meta_cursor_t *cursor,
    const char *name);
__declspec(dllimport)
int ecs_meta_dotmember(
    ecs_meta_cursor_t *cursor,
    const char *name);
__declspec(dllimport)
int ecs_meta_try_dotmember(
    ecs_meta_cursor_t *cursor,
    const char *name);
__declspec(dllimport)
int ecs_meta_push(
    ecs_meta_cursor_t *cursor);
__declspec(dllimport)
int ecs_meta_pop(
    ecs_meta_cursor_t *cursor);
__declspec(dllimport)
bool ecs_meta_is_collection(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
ecs_entity_t ecs_meta_get_type(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
ecs_entity_t ecs_meta_get_unit(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
const char* ecs_meta_get_member(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
ecs_entity_t ecs_meta_get_member_id(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
int ecs_meta_set_bool(
    ecs_meta_cursor_t *cursor,
    bool value);
__declspec(dllimport)
int ecs_meta_set_char(
    ecs_meta_cursor_t *cursor,
    char value);
__declspec(dllimport)
int ecs_meta_set_int(
    ecs_meta_cursor_t *cursor,
    int64_t value);
__declspec(dllimport)
int ecs_meta_set_uint(
    ecs_meta_cursor_t *cursor,
    uint64_t value);
__declspec(dllimport)
int ecs_meta_set_float(
    ecs_meta_cursor_t *cursor,
    double value);
__declspec(dllimport)
int ecs_meta_set_string(
    ecs_meta_cursor_t *cursor,
    const char *value);
__declspec(dllimport)
int ecs_meta_set_string_literal(
    ecs_meta_cursor_t *cursor,
    const char *value);
__declspec(dllimport)
int ecs_meta_set_entity(
    ecs_meta_cursor_t *cursor,
    ecs_entity_t value);
__declspec(dllimport)
int ecs_meta_set_id(
    ecs_meta_cursor_t *cursor,
    ecs_id_t value);
__declspec(dllimport)
int ecs_meta_set_null(
    ecs_meta_cursor_t *cursor);
__declspec(dllimport)
int ecs_meta_set_value(
    ecs_meta_cursor_t *cursor,
    const ecs_value_t *value);
__declspec(dllimport)
bool ecs_meta_get_bool(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
char ecs_meta_get_char(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
int64_t ecs_meta_get_int(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
uint64_t ecs_meta_get_uint(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
double ecs_meta_get_float(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
const char* ecs_meta_get_string(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
ecs_entity_t ecs_meta_get_entity(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
ecs_id_t ecs_meta_get_id(
    const ecs_meta_cursor_t *cursor);
__declspec(dllimport)
double ecs_meta_ptr_to_float(
    ecs_primitive_kind_t type_kind,
    const void *ptr);
__declspec(dllimport)
ecs_size_t ecs_meta_op_get_elem_count(
    const ecs_meta_op_t *op,
    const void *ptr);
typedef struct ecs_primitive_desc_t {
    ecs_entity_t entity;       
    ecs_primitive_kind_t kind; 
} ecs_primitive_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_primitive_init(
    ecs_world_t *world,
    const ecs_primitive_desc_t *desc);
typedef struct ecs_enum_desc_t {
    ecs_entity_t entity;       
    ecs_enum_constant_t constants[(32)]; 
    ecs_entity_t underlying_type;
} ecs_enum_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_enum_init(
    ecs_world_t *world,
    const ecs_enum_desc_t *desc);
typedef struct ecs_bitmask_desc_t {
    ecs_entity_t entity;       
    ecs_bitmask_constant_t constants[(32)]; 
} ecs_bitmask_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_bitmask_init(
    ecs_world_t *world,
    const ecs_bitmask_desc_t *desc);
typedef struct ecs_array_desc_t {
    ecs_entity_t entity;  
    ecs_entity_t type;    
    int32_t count;        
} ecs_array_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_array_init(
    ecs_world_t *world,
    const ecs_array_desc_t *desc);
typedef struct ecs_vector_desc_t {
    ecs_entity_t entity;  
    ecs_entity_t type;    
} ecs_vector_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_vector_init(
    ecs_world_t *world,
    const ecs_vector_desc_t *desc);
typedef struct ecs_struct_desc_t {
    ecs_entity_t entity; 
    ecs_member_t members[(32)]; 
} ecs_struct_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_struct_init(
    ecs_world_t *world,
    const ecs_struct_desc_t *desc);
typedef struct ecs_opaque_desc_t {
    ecs_entity_t entity;  
    EcsOpaque type;       
} ecs_opaque_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_opaque_init(
    ecs_world_t *world,
    const ecs_opaque_desc_t *desc);
typedef struct ecs_unit_desc_t {
    ecs_entity_t entity;
    const char *symbol;
    ecs_entity_t quantity;
    ecs_entity_t base;
    ecs_entity_t over;
    ecs_unit_translation_t translation;
    ecs_entity_t prefix;
} ecs_unit_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_unit_init(
    ecs_world_t *world,
    const ecs_unit_desc_t *desc);
typedef struct ecs_unit_prefix_desc_t {
    ecs_entity_t entity;
    const char *symbol;
    ecs_unit_translation_t translation;
} ecs_unit_prefix_desc_t;
__declspec(dllimport)
ecs_entity_t ecs_unit_prefix_init(
    ecs_world_t *world,
    const ecs_unit_prefix_desc_t *desc);
__declspec(dllimport)
ecs_entity_t ecs_quantity_init(
    ecs_world_t *world,
    const ecs_entity_desc_t *desc);
__declspec(dllimport)
void FlecsMetaImport(
    ecs_world_t *world);
__declspec(dllimport)
int ecs_meta_from_desc(
    ecs_world_t *world,
    ecs_entity_t component,
    ecs_type_kind_t kind,
    const char *desc);
__declspec(dllimport)
void ecs_set_os_api_impl(void);
__declspec(dllimport)
ecs_entity_t ecs_import(
    ecs_world_t *world,
    ecs_module_action_t module,
    const char *module_name);
__declspec(dllimport)
ecs_entity_t ecs_import_c(
    ecs_world_t *world,
    ecs_module_action_t module,
    const char *module_name_c);
__declspec(dllimport)
ecs_entity_t ecs_import_from_library(
    ecs_world_t *world,
    const char *library_name,
    const char *module_name);
__declspec(dllimport)
ecs_entity_t ecs_module_init(
    ecs_world_t *world,
    const char *c_name,
    const ecs_component_desc_t *desc);
__declspec(dllimport)
char* ecs_cpp_get_type_name(
    char *type_name, 
    const char *func_name,
    size_t len,
    size_t front_len);
__declspec(dllimport)
char* ecs_cpp_get_symbol_name(
    char *symbol_name,
    const char *type_name,
    size_t len);
__declspec(dllimport)
char* ecs_cpp_get_constant_name(
    char *constant_name,
    const char *func_name,
    size_t len,
    size_t back_len);
__declspec(dllimport)
const char* ecs_cpp_trim_module(
    ecs_world_t *world,
    const char *type_name);
__declspec(dllimport)
ecs_entity_t ecs_cpp_component_register(
    ecs_world_t *world,
    ecs_entity_t id,
    int32_t ids_index,
    const char *name,
    const char *cpp_name,
    const char *cpp_symbol,
    size_t size,
    size_t alignment,
    bool is_component,
    bool explicit_registration,
    bool *registered_out,
    bool *existing_out);
__declspec(dllimport)
void ecs_cpp_enum_init(
    ecs_world_t *world,
    ecs_entity_t id,
    ecs_entity_t underlying_type);
__declspec(dllimport)
ecs_entity_t ecs_cpp_enum_constant_register(
    ecs_world_t *world,
    ecs_entity_t parent,
    ecs_entity_t id,
    const char *name,
    void *value,
    ecs_entity_t value_type,
    size_t value_size);
typedef struct ecs_cpp_get_mut_t {
    void *ptr;
    bool call_modified;
} ecs_cpp_get_mut_t;
__declspec(dllimport)
 ecs_cpp_get_mut_t ecs_cpp_set(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component,
    const void *new_ptr,
    size_t size);
__declspec(dllimport)
 ecs_cpp_get_mut_t ecs_cpp_assign(
    ecs_world_t *world,
    ecs_entity_t entity,
    ecs_id_t component,
    const void *new_ptr,
    size_t size);
__declspec(dllimport)
const ecs_member_t* ecs_cpp_last_member(
    const ecs_world_t *world, 
    ecs_entity_t type);
]]

require('jit').off()
local bit = require 'bit'
local ffi = require 'ffi'
local buffer = require 'string.buffer'
local table = table

-- TODO: Add a way to prevent requiring the library twice and passing worlds created in one instante to another.
-- This will wreak havoc!

ffi.cdef[[
__declspec(dllexport) void dbreak(void);

// Define some opaque types we can (hopefully) safely expose to the public.
// I say safely because fortunately, LuaJIT doesn't allow pointer arithmetic on those
// nor implicit casts between incompatible types.
typedef struct public_ecs_query_t public_ecs_query_t;
typedef struct public_ecs_iter_t  public_ecs_iter_t;

// Define some helper types.
typedef struct world_binding_context_t {
  // Maps component IDs to the names the FFI understands.
  ecs_map_t component_c_types;
  // Maps that works as sets. The keys are pointers to query_wrapper_t and iter_wrapper_t
  // that need to be finished upon world destruction. Values are unused.
  ecs_map_t alive_iterators, alive_queries;
} world_binding_context_t;

typedef struct query_wrapper_t {
  ecs_query_t* query;
} query_wrapper_t;

// Define some helper custom types we need internally.
typedef struct iter_wrapper_t {
  ecs_iter_t iter;
  int32_t i;
  bool invalid;
} iter_wrapper_t;
]]

local c = ffi.C

-- Flecs types

local ecs_world_info_t            = ffi.typeof 'ecs_world_info_t'
local ecs_world_stats_t           = ffi.typeof 'ecs_world_stats_t'
local ecs_metric_t                = ffi.typeof 'ecs_metric_t'
local EcsType                     = ffi.typeof 'EcsType'

-- Standard C types

local uint32_t                    = ffi.typeof 'uint32_t'
local uint64_t                    = ffi.typeof 'uint64_t'
local uint64_t_vla                = ffi.typeof 'uint64_t[?]'

-- Convenience types

local void_ptr                    = ffi.typeof 'void*'
local void_func                   = ffi.typeof 'void (*)(void)'
local char_ptr                    = ffi.typeof 'char*'
local char_ptr_ptr                = ffi.typeof 'char**'

local world_binding_context_t     = ffi.typeof 'world_binding_context_t'
local world_binding_context_t_ptr = ffi.typeof 'world_binding_context_t*'

local ecs_entity_desc_t           = ffi.typeof 'ecs_entity_desc_t'

local ecs_array_desc_t            = ffi.typeof 'ecs_array_desc_t'

local ecs_query_desc_t            = ffi.typeof 'ecs_query_desc_t'

local ecs_map_t                   = ffi.typeof 'ecs_map_t'
local ecs_map_t_ptr               = ffi.typeof 'ecs_map_t*'
local ecs_map_iter_t_vla          = ffi.typeof 'ecs_map_iter_t[?]'

local ecs_query_t_ptr             = ffi.typeof 'ecs_query_t*'
local public_ecs_query_t          = ffi.typeof 'public_ecs_query_t'
local public_ecs_query_t_ptr      = ffi.typeof 'public_ecs_query_t*'
local query_wrapper_t             = ffi.typeof 'query_wrapper_t'
local query_wrapper_t_ptr         = ffi.typeof 'query_wrapper_t*'

local ecs_iter_t_ptr              = ffi.typeof 'ecs_iter_t*'
-- local ecs_iter_t_vla             = ffi.typeof 'ecs_iter_t[?]'
local public_ecs_iter_t           = ffi.typeof 'public_ecs_iter_t'
local public_ecs_iter_t_ptr       = ffi.typeof 'public_ecs_iter_t*'
local iter_wrapper_t              = ffi.typeof 'iter_wrapper_t'
local iter_wrapper_t_ptr          = ffi.typeof 'iter_wrapper_t*'

local function is_entity(entity)
  return type(entity) == 'cdata' and ffi.typeof(entity) == uint64_t
end

local function ecs_entity_t_lo(value)
  return ffi.cast(uint32_t, value)
end

local function ecs_entity_t_hi(value)
  return ffi.rshift(ffi.cast(uint32_t, value), 32)
end

local function ecs_entity_t_comb(lo, hi)
  return bit.lshift(ffi.cast(uint64_t, hi), 32) + ffi.cast(uint32_t, lo)
end

local function ecs_pair(pred, obj)
  return bit.bor(c.ECS_PAIR, ecs_entity_t_comb(obj, pred))
end

local function ecs_add_pair(world, subject, first, second)
  c.ecs_add_id(world, subject, ecs_pair(first, second))
end

local function ecs_get_path(world, entity)
  return c.ecs_get_path_w_sep(world, 0, entity, '.', nil)
end

local function ecs_has_pair(world, entity, first, second)
  return c.ecs_has_id(world, entity, ecs_pair(first, second))
end

local function ecs_remove_pair(world, subject, first, second)
  c.ecs_remove_id(world, subject, ecs_pair(first, second))
end

local ECS_ID_FLAGS_MASK = bit.lshift(0xFFull, 60)
local ECS_ENTITY_MASK = 0xFFFFFFFFull
local ECS_GENERATION_MASK = bit.lshift(0xFFFFull, 32)

local function ECS_GENERATION(e)
  return bit.rshift(bit.band(e, ECS_GENERATION_MASK), 32)
end

local function ECS_GENERATION_INC(e)
  return bit.bor(bit.band(e, bit.bnot(ECS_GENERATION_MASK)), bit.lshift(bit.band(0xffff, ECS_GENERATION(e) + 1), 32))
end

local ECS_COMPONENT_MASK = bit.bnot(ECS_ID_FLAGS_MASK)

local function ECS_HAS_ID_FLAG(e, flag)
  return bit.band(e, flag) ~= 0
end

local function ECS_IS_PAIR(id)
  return bit.band(id, ECS_ID_FLAGS_MASK) == c.ECS_PAIR
end

local function ECS_PAIR_FIRST(e)
  return ecs_entity_t_hi(bit.band(e, ECS_COMPONENT_MASK))
end

local function ECS_PAIR_SECOND(e)
  return ecs_entity_t_lo(e)
end

local function ecs_pair_first(world, pair)
  return c.ecs_get_alive(world, ECS_PAIR_FIRST(pair))
end

local function ecs_pair_second(world, pair)
  return c.ecs_get_alive(world, ECS_PAIR_SECOND(pair))
end

local ecs_pair_relation = ecs_pair_first
local ecs_pair_target = ecs_pair_second

local function ECS_HAS_RELATION(e, rel)
  return ECS_HAS_ID_FLAG(e, c.ECS_PAIR) and ECS_PAIR_FIRST() ~= 0
end

local function init_scope(world, id)
  local scope = c.ecs_get_scope(world)
  if scope ~= 0 then
    ecs_add_pair(world, id, c.EcsChildOf, scope)
  end
end

local forbidden_struct_patterns = {
  { pattern = '%*',                    error_message = 'No pointers allowed.'       },
  { pattern = '[%[%]]',                error_message = 'No arrays allowed.'         },
  { pattern = '%f[%w_]uptr%f[^%w_]',   error_message = 'No pointers allowed.'       },
  { pattern = '%f[%w_]iptr%f[^%w_]',   error_message = 'No pointers allowed.'       },
  { pattern = '%f[%w_]string%f[^%w_]', error_message = 'No strings allowed (yet?).' },
}

local c_type_map = {
  byte = 'unsigned char',
  u8   = 'uint8_t',
  u16  = 'uint16_t',
  u32  = 'uint32_t',
  u64  = 'uint64_t',
  i8   = 'int8_t',
  i16  = 'int16_t',
  i32  = 'int32_t',
  i64  = 'int64_t',
  f32  = 'float',
  f64  = 'double',
}

local flecs_type_map = {
  uint8_t  = 'u8',
  uint16_t = 'u16',
  uint32_t = 'u32',
  uint64_t = 'u64',
  int8_t   = 'i8',
  int16_t  = 'i16',
  int32_t  = 'i32',
  int64_t  = 'i64',
  float    = 'f32',
  double   = 'f64',
  int      = 'i32',
}

local function check_c_identifier(identifier)
  if not identifier:match '^%a[%a_%d]*$' then
    error('Not a valid C identifier: "' .. identifier .. '"', 3)
  end
end

local function filter_unsafe_constructs(s)
  for i = 1, #forbidden_struct_patterns do
    local pattern = forbidden_struct_patterns[i]
    if s:match(pattern.pattern) then
      error(pattern.error_message, 4)
    end
  end
end

local function substitute_types(input, type_map)
  -- Replace types only when they are full words (surrounded by non-word boundaries).
  return input:gsub("(%f[%w_])(%a[%w_]*)(%f[^%w_])", function (prefix, word, suffix)
    local replacement = type_map[word] or word
    return prefix .. replacement .. suffix
  end)
end

local function generate_definitions(description)
  filter_unsafe_constructs(description)

  local flecs_definition = substitute_types(description, flecs_type_map)
  local c_definition = substitute_types(description, c_type_map)

  return flecs_definition, c_definition
end

local c_identifier_sequence = 0

-- local function address_of_cdata(cdata)
--   -- With a Lua number we can represent all integers up to 2^53,
--   -- and as of today LuaJIT uses only the lower 47 bits of a pointer.
--   -- So, this is a neat trick that enables us to avoid boxed pointers
--   -- or converting addresses to strings.
--   return tonumber(ffi.cast('uintptr_t', cdata))
-- end

local function finish_query_wrapper(wrapper)
  wrapper = ffi.cast(query_wrapper_t_ptr, wrapper)
  if wrapper.query ~= nil then
    c.ecs_query_fini(wrapper.query)
    local binding_context = ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(wrapper.query.world))
    c.ecs_map_remove(binding_context.alive_queries, ffi.cast(uint64_t, wrapper))
  end
  c.ecs_os_api.free_(wrapper)
end

local function invalidate_query_wrapper(wrapper)
  ffi.cast(query_wrapper_t_ptr, wrapper).query = nil
end

ffi.metatype('ecs_world_t', {
  __index = {
    is_fini = function (self)
      return c.ecs_is_fini(self)
    end,
    info = function (self)
      return c.ecs_get_world_info(self)
    end,
    stats = function (self)
      local stats = ecs_world_stats_t()
      c.ecs_world_stats_get(self, stats)
      return stats
    end,
    dim = function (self, entity_count)
      c.ecs_dim(self, entity_count)
    end,
    quit = function (self)
      c.ecs_quit(self)
    end,
    should_quit = function (self)
      return c.ecs_should_quit(self)
    end,
    get_entities = function (self)
      local entities = c.ecs_get_entities(self)
      local alive = {}
      local dead = {}

      for i = 0, entities.alive_count - 1 do
        table.insert(alive, entities.ids[i])
      end

      for i = entities.alive_count, entities.count - 1 do
        table.insert(dead, entities.ids[i])
      end

      return { alive = alive, dead = dead }
    end,
    get_flags = function (self)
      return c.ecs_world_get_flags(self)
    end,
    measure_frame_time = function (self, enable)
      c.ecs_measure_frame_time(self, enable)
    end,
    measure_system_time = function (self, enable)
      c.ecs_measure_system_time(self, enable)
    end,
    set_target_fps = function (self, fps)
      c.ecs_set_target_fps(self, fps)
    end,
    set_default_query_flags = function (self, flags)
      c.ecs_set_default_query_flags(self, flags)
    end,
    new = function (self, arg1, arg2, arg3)
      local entity
      local name
      local components

      if not arg1 and not arg2 then
        --  entity | name(string)
        entity = c.ecs_new(self)
      elseif arg2 and not arg3 then
        if is_entity(arg1) then
          -- entity, name (string)
          entity = arg1
          if type(arg2) == 'string' then
            name = arg2
          else
            error('Expected a name after the entity.', 2)
          end
        else
          -- name (string|nil), components
          name = arg1
          components = arg2
        end
      elseif arg1 and arg3 then
        -- entity, name (string|nil), components
        entity = arg1
        name = arg2
        components = arg3
      end

      if entity and name and c.ecs_is_alive(self, entity) then
        local existing = c.ecs_get_name(self, entity)
        if existing ~= nil then
          if ffi.string(existing) == name then
            return entity
          end

          error('Entity redefined with a different name.', 2)
        end
      end

      if (not entity or entity == 0) and name then
        entity = c.ecs_lookup(self, name)
        if entity and entity ~= 0 then
          return entity
        end
      end

      -- Create an entity, the following functions will take the same ID.
      if (not entity or entity == 0) and (arg1 or arg2) then
        entity = c.ecs_new(self)
      end

      if (entity and entity ~= 0) and not c.ecs_is_alive(self, entity) then
        c.ecs_make_alive(self, entity)
      end

      local scope = c.ecs_get_scope(self)
      if scope ~= 0 then
        ecs_add_pair(self, entity, c.EcsChildOf, scope)
      end

      if components then
        -- TODO: Check whether this creates under the current scope, if any.
        entity = c.ecs_entity_init(self, ecs_entity_desc_t({ id = entity, add_expr = components }))
      end

      if name then
        c.ecs_set_name(self, entity, name)
      end

      return entity ~= 0 and entity or nil
    end,
    delete = function (self, entity)
      if is_entity(entity) then
        c.ecs_delete(self, entity)
      else
        for i = 1, #entity do
          c.ecs_delete(self, entity[i])
        end
      end
    end,
    new_tag = function (self, name)
      local entity = c.ecs_lookup(self, name)
      if entity == 0 then
        entity = c.ecs_set_name(self, entity, name)
      end

      return entity ~= 0 and entity or nil
    end,
    name = function (self, entity, numeric_name)
      local name = c.ecs_get_name(self, entity)
      if name ~= nil then
        return ffi.string(name)
      elseif numeric_name and self:is_alive(entity) then
        return '#' .. tostring(entity)
      end
    end,
    set_name = function (self, entity, name)
      c.ecs_set_name(self, entity, name)
    end,
    symbol = function (self, entity)
      local symbol = c.ecs_get_symbol(self, entity)
      if symbol ~= nil then
        return ffi.string(symbol)
      end
    end,
    path = function (self, entity)
      local path = ecs_get_path(self, entity)
      local ret = ffi.string(path)
      c.ecs_os_api.free_(path)
      return ret
    end,
    lookup = function (self, path)
      local ret = c.ecs_lookup(self, path)
      return ret ~= 0 and ret or nil
    end,
    lookup_child = function (self, parent, name)
      local ret = c.ecs_lookup_child(self, parent, name)
      return ret ~= 0 and ret or nil
    end,
    lookup_path = function (self, parent, path, sep, prefix)
      local ret = c.ecs_lookup_path_w_sep(self, parent, path, sep, prefix, false)
      return ret ~= 0 and ret or nil
    end,
    lookup_symbol = function (self, symbol)
      local ret = c.ecs_lookup_symbol(self, symbol, true, false)
      return ret ~= 0 and ret or nil
    end,
    set_alias = function (self, entity, name)
      c.ecs_set_alias(self, entity, name)
    end,
    has = function (self, entity, arg1, arg2)
      if entity and arg1 and arg2 then
        return ecs_has_pair(self, entity, arg1, arg2)
      else
        return c.ecs_has_id(self, entity, arg1)
      end
    end,
    owns = function (self, entity, id)
      return c.ecs_owns_id(self, entity, id)
    end,
    is_alive = function (self, entity)
      return c.ecs_is_alive(self, entity)
    end,
    is_valid = function (self, entity)
      return c.ecs_is_valid(self, entity)
    end,
    alive = function (self, entity)
      local ret = c.ecs_get_alive(self, entity)
      return ret
    end,
    make_alive = function (self, entity)
      c.ecs_make_alive(self, entity)
    end,
    exists = function (self, entity)
      return c.ecs_exists(self, entity)
    end,
    add = function (self, entity, arg1, arg2)
      if entity and arg1 and arg2 then
        ecs_add_pair(self, entity, arg1, arg2)
      else
        c.ecs_add_id(self, entity, arg1)
      end
    end,
    remove = function (self, entity, arg1, arg2)
      if arg1 and arg2 then
        ecs_remove_pair(self, entity, arg1, arg2)
      else
        c.ecs_remove_id(self, entity, arg1)
      end
    end,
    clear = function (self, entity)
      c.ecs_clear(self, entity)
    end,
    enable = function (self, entity, component)
      if component then
        c.ecs_enable_id(self, entity, component, true)
      else
        c.ecs_enable(self, entity, true)
      end
    end,
    disable = function (self, entity, component)
      if component then
        c.ecs_enable_id(self, entity, component, false)
      else
        c.ecs_enable(self, entity, false)
      end
    end,
    count = function (self, entity)
      return c.ecs_count_id(self, entity)
    end,
    delete_children = function (self, parent)
      c.ecs_delete_with(self, ecs_pair(c.EcsChildOf, parent))
    end,
    parent = function (self, entity)
      local ret = c.ecs_get_target(self, entity, c.EcsChildOf, 0)
      return ret
    end,
    is_component_enabled = function (self, entity, component)
      return c.ecs_is_enabled_id(self, entity, component)
    end,
    pair = function (predicate, object)
      return ecs_pair(predicate, object)
    end,
    is_pair = function (id)
      return ECS_IS_PAIR(id)
    end,
    pair_target = function (self, pair)
      return ecs_pair_target(self, pair)
    end,
    add_is_a = function (self, entity, base)
      ecs_add_pair(self, entity, c.EcsIsA, base)
    end,
    remove_is_a = function (self, entity, base)
      ecs_remove_pair(self, entity, c.EcsIsA, base)
    end,
    add_child_of = function (self, entity, parent)
      ecs_add_pair(self, entity, c.EcsChildOf, parent)
    end,
    remove_child_of = function (self, entity, parent)
      ecs_remove_pair(self, entity, c.EcsChildOf, parent)
    end,
    auto_override = function (self, entity, component)
      c.ecs_add_id(self, entity, bit.bor(c.ECS_AUTO_OVERRIDE, component))
    end,
    new_enum = function (self, name, description)
      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)
      if c.ecs_meta_from_desc(self, component, c.EcsEnumType, description) ~= 0 then
        error('Invalid descriptor.', 2)
      end

      init_scope(self, component)
      return component
    end,
    new_bitmask = function (self, name, description)
      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)
      if c.ecs_meta_from_desc(self, component, c.EcsBitmaskType, description) ~= 0 then
        error('Invalid descriptor.', 2)
      end

      init_scope(self, component)
      return component
    end,
    new_array = function (self, name, element, count)
      if count < 0 or count > 0x7fffffff then
        error(string.format('Element count out of range (%f)', count), 2)
      end

      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local component = c.ecs_array_init(self, ecs_array_desc_t({ type = element, count = count }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)

      init_scope(self, component)
      return component
    end,
    new_struct = function (self, name, description)
      check_c_identifier(name)

      if c.ecs_lookup(self, name) ~= 0 then
        error('Component already exists.', 2)
      end

      local flecs_definition, c_definition = generate_definitions(description)

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, name)
      if c.ecs_meta_from_desc(self, component, c.EcsStructType, flecs_definition) ~= 0 then
        error('Invalid descriptor.', 2)
      end

      c.ecs_set_id(self, component, c.FLECS_IDEcsTypeID_, ffi.sizeof(EcsType), EcsType({ kind = c.EcsStructType }))

      local path = c.ecs_get_path_w_sep(self, 0, component, '_', nil)
      local c_identifier = ffi.string(path) .. '_' .. c_identifier_sequence
      c_identifier_sequence = c_identifier_sequence + 1
      c.ecs_os_api.free_(path)

      local success, error_message = pcall(function ()
        ffi.cdef('typedef struct ' .. c_identifier .. c_definition .. c_identifier)
      end)
      if not success then
        c.ecs_delete(self, component)
        error(error_message, 2)
      end
      local component_c_types = ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).component_c_types
      -- local component_ctypes = worlds[address_of_cdata(self)].component_ctypes
      -- In LuaJIT, uint64_t is boxed in a cdata object. And every time you make a new uint64_t by any means,
      -- you get a different cdata object, which counts as a different table index!
      -- Therefore, the quick, easy and correct workaround is to convert the component ID to string
      -- and use that instead.
      -- https://luajit.org/ext_ffi_semantics.html#cdata_key
      -- component_ctypes[tostring(component)] = {
      --   struct = ffi.typeof(c_identifier),
      --   ptr = ffi.typeof(c_identifier .. '*'),
      --   const_ptr = ffi.typeof('const ' .. c_identifier .. '*'),
      --   size = ffi.sizeof(c_identifier),
      -- }
      c.ecs_map_insert(component_c_types, component, ffi.cast(uint64_t, c.ecs_os_api.strdup_(c_identifier)))

      ffi.metatype(c_identifier, {
        __tostring = function (this)
          local ptr = c.ecs_ptr_to_expr(self, component, this)
          local result = ffi.string(ptr)
          c.ecs_os_api.free_(ptr)
          return result
        end,
        __metatable = nil,
      })

      init_scope(self, component)
      return component
    end,
    new_alias = function (self, name, alias)
      local type_entity = c.ecs_lookup(self, name)
      if type_entity == 0 then
        error('Component does not exist.', 2)
      end

      if not c.ecs_has_id(self, type_entity, c.FLECS_IDEcsComponentID_) then
        error('Not a component,', 2)
      end

      if c.ecs_get_id(self, type_entity, c.FLECS_IDEcsTypeID_) == nil then
        error('Missing descriptor.', 2)
      end

      if c.ecs_lookup(self, alias) ~= 0 then
        error('Alias already exists.', 2)
      end

      local component = c.ecs_entity_init(self, ecs_entity_desc_t({ use_low_id = true }))
      if component == 0 then
        return
      end
      c.ecs_set_name(self, component, alias)
      -- TODO: Should we copy components?

      init_scope(self, component)
      return component
    end,
    new_prefab = function (self, id, expression)
      local entity
      if not id then
        entity = c.ecs_new(self)
        local scope = c.ecs_get_scope(self)
        if scope ~= 0 then
          ecs_add_pair(self, entity, c.EcsChildOf, scope)
        end
        c.ecs_add_id(self, entity, c.EcsPrefab)
      else
        entity = c.ecs_entity_init(self, ecs_entity_desc_t({
          name = id,
          add_expr = expression,
          add = uint64_t_vla(2, { c.EcsPrefab, 0 }),
        }))
      end

      return entity ~= 0 and entity or nil
    end,
    -- For safety, this function always returns a new struct initialized with the component's value.
    -- Client code should have no access to pointers, references, or arrays.
    -- And, since we're returning a copy here, there's no need for a get_mut function.
    get = function (self, entity, component)
      local data = c.ecs_get_id(self, entity, component)
      if data == nil then
        return
      end

      local ctype = c.ecs_map_get(
        ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).component_c_types,
        component)
      if ctype == nil then
        error('Component ' .. self:name(component, true) .. " does not exist or it's missing serialization data.", 2)
      end
      ctype = ffi.string(ffi.cast(char_ptr_ptr, ctype)[0])

      return ffi.new(ctype, (ffi.cast(ctype .. '*', data)[0]))
    end,
    -- TODO: Get ref.
    set = function (self, entity, component, value)
      if not value then
        error('Value must not be nil', 2)
      end

      local ctype = c.ecs_map_get(
        ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).component_c_types,
        component)
      if ctype == nil then
        error('Component ' .. self:name(component, true) .. " does not exist or it's missing serialization data.", 2)
      end
      ctype = ffi.string(ffi.cast(char_ptr_ptr, ctype)[0])

      c.ecs_set_id(self, entity, component, ffi.sizeof(ctype), type(value) == 'table' and ffi.new(ctype, value) or value)
    end,
    singleton_add = function (self, component)
      self:add(component, component)
    end,
    singleton_remove = function (self, component)
      self:remove(component, component)
    end,
    singleton_get = function (self, component)
      return self:get(component, component)
    end,
    singleton_set = function (self, component, value)
      if not value then
        error('Value must not be nil', 2)
      end
      self:set(component, component, value)
    end,
    query = function (self, query_or_description)
      local description
      local wrapper = query_wrapper_t_ptr(c.ecs_os_api.malloc_(ffi.sizeof(query_wrapper_t)))

      if type(query_or_description) == 'string' then
        description = ecs_query_desc_t({
          expr = query_or_description,
          binding_ctx = wrapper,
        })
        -- Queries without an associated entity don't have their binding_ctx_free function called
        -- upon world destruction. Do it ourselves with this mechanism.
        c.ecs_map_insert(
          ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).alive_queries,
          ffi.cast(uint64_t, wrapper),
          0)
      else
        -- Clear dangerous, unreviewed or unimplemented fields.
        query_or_description._canary = 0;
        query_or_description.flags = 0;
        query_or_description.order_by_callback = nil;
        query_or_description.order_by_table_callback = nil;
        query_or_description.order_by = nil;
        query_or_description.group_by = nil;
        query_or_description.group_by_callback = nil;
        query_or_description.on_group_create = nil;
        query_or_description.on_group_delete = nil;
        query_or_description.group_by_ctx = nil;
        query_or_description.group_by_ctx_free = nil;
        query_or_description.ctx = nil;
        query_or_description.ctx_free = nil;

        -- Setup our binding context.
        query_or_description.binding_ctx = wrapper
        if not query_or_description.entity or query_or_description.entity == 0 then
          c.ecs_map_insert(
            ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(self)).alive_queries,
            ffi.cast(uint64_t, wrapper),
            0)
        else
          query_or_description.binding_ctx_free = invalidate_query_wrapper
        end

        description = ecs_query_desc_t(query_or_description)

        -- Clear dangerous stuff once again before handing it back to the user.
        query_or_description.binding_ctx = nil
        query_or_description.binding_ctx_free = nil
      end

      wrapper.query = c.ecs_query_init(self, description)

      return ffi.gc(ffi.cast(public_ecs_query_t_ptr, wrapper), finish_query_wrapper)
    end,
  },
  __tostring = function (self)
    return string.format('Flecs world 0x%x', ffi.cast(uint64_t, self))
  end,
  __metatable = nil,
})

ffi.metatype(ecs_world_info_t, {
  __tostring = function (self)
    local buf = buffer.new()

    buf:put 'Last component id: '
    buf:put(self.last_component_id)
    buf:put '\nMin id: '
    buf:put(self.min_id)
    buf:put '\nMax id: '
    buf:put(self.max_id)
    buf:put '\nDelta time raw: '
    buf:put(self.delta_time_raw)
    buf:put '\nDelta time: '
    buf:put(self.delta_time)
    buf:put '\nTime scale: '
    buf:put(self.time_scale)
    buf:put '\nTarget fps: '
    buf:put(self.target_fps)
    buf:put '\nFrame time total: '
    buf:put(self.frame_time_total)
    buf:put '\nSystem time total: '
    buf:put(self.system_time_total)
    buf:put '\nEmit time total: '
    buf:put(self.emit_time_total)
    buf:put '\nMerge time total: '
    buf:put(self.merge_time_total)
    buf:put '\nRematch time total: '
    buf:put(self.rematch_time_total)
    buf:put '\nWorld time total: '
    buf:put(self.world_time_total)
    buf:put '\nWorld time total raw: '
    buf:put(self.world_time_total_raw)
    buf:put '\nFrame count total: '
    buf:put(self.frame_count_total)
    buf:put '\nMerge count total: '
    buf:put(self.merge_count_total)
    buf:put '\nEval comp monitors total: '
    buf:put(self.eval_comp_monitors_total)
    buf:put '\nRematch count total: '
    buf:put(self.rematch_count_total)
    buf:put '\nId create total: '
    buf:put(self.id_create_total)
    buf:put '\nId delete total: '
    buf:put(self.id_delete_total)
    buf:put '\nTable create total: '
    buf:put(self.table_create_total)
    buf:put '\nTable delete total: '
    buf:put(self.table_delete_total)
    buf:put '\nPipeline build count total: '
    buf:put(self.pipeline_build_count_total)
    buf:put '\nSystems ran frame: '
    buf:put(self.systems_ran_frame)
    buf:put '\nObservers ran frame: '
    buf:put(self.observers_ran_frame)
    buf:put '\nTag id count: '
    buf:put(self.tag_id_count)
    buf:put '\nComponent id count: '
    buf:put(self.component_id_count)
    buf:put '\nPair id count: '
    buf:put(self.pair_id_count)
    buf:put '\nTable count: '
    buf:put(self.table_count)
    buf:put '\nCommand add count: '
    buf:put(self.cmd.add_count)
    buf:put '\nCommand remove count: '
    buf:put(self.cmd.remove_count)
    buf:put '\nCommand delete count: '
    buf:put(self.cmd.delete_count)
    buf:put '\nCommand clear count: '
    buf:put(self.cmd.clear_count)
    buf:put '\nCommand set count: '
    buf:put(self.cmd.set_count)
    buf:put '\nCommand ensure count: '
    buf:put(self.cmd.ensure_count)
    buf:put '\nCommand modified count: '
    buf:put(self.cmd.modified_count)
    buf:put '\nCommand discard count: '
    buf:put(self.cmd.discard_count)
    buf:put '\nCommand event count: '
    buf:put(self.cmd.event_count)
    buf:put '\nCommand other count: '
    buf:put(self.cmd.other_count)
    buf:put '\nCommand batched entity count: '
    buf:put(self.cmd.batched_entity_count)
    buf:put '\nCommand batched command count: '
    buf:put(self.cmd.batched_command_count)
    buf:put '\nName prefix: '
    if self.name_prefix == nil then
      buf:put '(null)'
    else
      buf:put(ffi.string(self.name_prefix))
    end

    return buf:get()
  end,
  __metatable = nil,
})

ffi.metatype(ecs_world_stats_t, {
  __tostring = function (self)
    local buf = buffer.new()

    buf:put 'Entities count:'
    buf:put(self.entities.count.counter.value[self.t])
    buf:put '\nEntities not alive count:'
    buf:put(self.entities.not_alive_count.counter.value[self.t])
    buf:put '\nComponents tag count:'
    buf:put(self.components.tag_count.counter.value[self.t])
    buf:put '\nComponents component count:'
    buf:put(self.components.component_count.counter.value[self.t])
    buf:put '\nComponents pair count:'
    buf:put(self.components.pair_count.counter.value[self.t])
    buf:put '\nComponents type count:'
    buf:put(self.components.type_count.counter.value[self.t])
    buf:put '\nComponents create count:'
    buf:put(self.components.create_count.counter.value[self.t])
    buf:put '\nComponents delete count:'
    buf:put(self.components.delete_count.counter.value[self.t])
    buf:put '\nTables count:'
    buf:put(self.tables.count.counter.value[self.t])
    buf:put '\nTables empty count:'
    buf:put(self.tables.empty_count.counter.value[self.t])
    buf:put '\nTables create count:'
    buf:put(self.tables.create_count.counter.value[self.t])
    buf:put '\nTables delete count:'
    buf:put(self.tables.delete_count.counter.value[self.t])
    buf:put '\nQueries query count:'
    buf:put(self.queries.query_count.counter.value[self.t])
    buf:put '\nQueries observer count:'
    buf:put(self.queries.observer_count.counter.value[self.t])
    buf:put '\nQueries system count:'
    buf:put(self.queries.system_count.counter.value[self.t])
    buf:put '\nCommands add count:'
    buf:put(self.commands.add_count.counter.value[self.t])
    buf:put '\nCommands remove count:'
    buf:put(self.commands.remove_count.counter.value[self.t])
    buf:put '\nCommands delete count:'
    buf:put(self.commands.delete_count.counter.value[self.t])
    buf:put '\nCommands clear count:'
    buf:put(self.commands.clear_count.counter.value[self.t])
    buf:put '\nCommands set count:'
    buf:put(self.commands.set_count.counter.value[self.t])
    buf:put '\nCommands ensure count:'
    buf:put(self.commands.ensure_count.counter.value[self.t])
    buf:put '\nCommands modified count:'
    buf:put(self.commands.modified_count.counter.value[self.t])
    buf:put '\nCommands other count:'
    buf:put(self.commands.other_count.counter.value[self.t])
    buf:put '\nCommands discard count:'
    buf:put(self.commands.discard_count.counter.value[self.t])
    buf:put '\nCommands batched entity count:'
    buf:put(self.commands.batched_entity_count.counter.value[self.t])
    buf:put '\nCommands batched count:'
    buf:put(self.commands.batched_count.counter.value[self.t])
    buf:put '\nFrame frame count:'
    buf:put(self.frame.frame_count.counter.value[self.t])
    buf:put '\nFrame merge count:'
    buf:put(self.frame.merge_count.counter.value[self.t])
    buf:put '\nFrame rematch count:'
    buf:put(self.frame.rematch_count.counter.value[self.t])
    buf:put '\nFrame pipeline build count:'
    buf:put(self.frame.pipeline_build_count.counter.value[self.t])
    buf:put '\nFrame systems ran:'
    buf:put(self.frame.systems_ran.counter.value[self.t])
    buf:put '\nFrame observers ran:'
    buf:put(self.frame.observers_ran.counter.value[self.t])
    buf:put '\nFrame event emit count:'
    buf:put(self.frame.event_emit_count.counter.value[self.t])
    buf:put '\nPerformance world time raw:'
    buf:put(self.performance.world_time_raw.counter.value[self.t])
    buf:put '\nPerformance world time:'
    buf:put(self.performance.world_time.counter.value[self.t])
    buf:put '\nPerformance frame time:'
    buf:put(self.performance.frame_time.counter.value[self.t])
    buf:put '\nPerformance system time:'
    buf:put(self.performance.system_time.counter.value[self.t])
    buf:put '\nPerformance emit time:'
    buf:put(self.performance.emit_time.counter.value[self.t])
    buf:put '\nPerformance merge time:'
    buf:put(self.performance.merge_time.counter.value[self.t])
    buf:put '\nPerformance rematch time:'
    buf:put(self.performance.rematch_time.counter.value[self.t])
    buf:put '\nPerformance fps:'
    buf:put(self.performance.fps.counter.value[self.t])
    buf:put '\nPerformance delta time:'
    buf:put(self.performance.delta_time.counter.value[self.t])
    buf:put '\nMemory alloc count:'
    buf:put(self.memory.alloc_count.counter.value[self.t])
    buf:put '\nMemory realloc count:'
    buf:put(self.memory.realloc_count.counter.value[self.t])
    buf:put '\nMemory free count:'
    buf:put(self.memory.free_count.counter.value[self.t])
    buf:put '\nMemory outstanding alloc count:'
    buf:put(self.memory.outstanding_alloc_count.counter.value[self.t])
    buf:put '\nMemory block alloc count:'
    buf:put(self.memory.block_alloc_count.counter.value[self.t])
    buf:put '\nMemory block free count:'
    buf:put(self.memory.block_free_count.counter.value[self.t])
    buf:put '\nMemory block outstanding alloc count:'
    buf:put(self.memory.block_outstanding_alloc_count.counter.value[self.t])
    buf:put '\nMemory stack alloc count:'
    buf:put(self.memory.stack_alloc_count.counter.value[self.t])
    buf:put '\nMemory stack free count:'
    buf:put(self.memory.stack_free_count.counter.value[self.t])
    buf:put '\nMemory stack outstanding alloc count:'
    buf:put(self.memory.stack_outstanding_alloc_count.counter.value[self.t])
    buf:put '\nHTTP request received count:'
    buf:put(self.http.request_received_count.counter.value[self.t])
    buf:put '\nHTTP request invalid count:'
    buf:put(self.http.request_invalid_count.counter.value[self.t])
    buf:put '\nHTTP request handled ok count:'
    buf:put(self.http.request_handled_ok_count.counter.value[self.t])
    buf:put '\nHTTP request handled error count:'
    buf:put(self.http.request_handled_error_count.counter.value[self.t])
    buf:put '\nHTTP request not handled count:'
    buf:put(self.http.request_not_handled_count.counter.value[self.t])
    buf:put '\nHTTP request preflight count:'
    buf:put(self.http.request_preflight_count.counter.value[self.t])
    buf:put '\nHTTP send ok count:'
    buf:put(self.http.send_ok_count.counter.value[self.t])
    buf:put '\nHTTP send error count:'
    buf:put(self.http.send_error_count.counter.value[self.t])
    buf:put '\nHTTP busy count:'
    buf:put(self.http.busy_count.counter.value[self.t])

    return buf:get()
  end,
  __metatable = nil,
})

ffi.metatype(ecs_metric_t, {
  __metatable = nil,
})

local function finish_iter_wrapper(wrapper)
  wrapper = ffi.cast(iter_wrapper_t_ptr, wrapper)
  if not wrapper.invalid then
    c.ecs_map_remove(
      ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(wrapper.iter.world)).alive_iterators,
      ffi.cast(uint64_t, wrapper))
    c.ecs_iter_fini(wrapper.iter)
  end
  c.ecs_os_api.free_(wrapper)
end

local function invalidate_iter_wrapper(wrapper)
  print('invalidate_iter_wrapper()', debug.traceback())
  ffi.cast(iter_wrapper_t_ptr, ffi.cast(ecs_iter_t_ptr, wrapper).binding_ctx).invalid = true
end

ffi.metatype(public_ecs_query_t, {
  __index = {
    iter = function (self)
      local query_wrapper = ffi.cast(query_wrapper_t_ptr, self)
      if query_wrapper.query == nil then
        error('The query has been finished.', 2)
      end

      local world = query_wrapper.query.world

      -- local result = ffi.gc(ecs_iter_t_vla(1, { c.ecs_query_iter(query.world, query) }), finish_iter)
      local wrapper = ffi.cast(
        iter_wrapper_t_ptr,
        c.ecs_os_api.malloc_(ffi.sizeof(iter_wrapper_t)))
      wrapper.iter = c.ecs_query_iter(world, query_wrapper.query)
      wrapper.iter.binding_ctx = wrapper
      wrapper.iter.fini = invalidate_iter_wrapper
      wrapper.i = 0
      wrapper.invalid = false

      c.ecs_map_insert(
        ffi.cast(world_binding_context_t_ptr, c.ecs_get_binding_ctx(world)).alive_iterators,
        ffi.cast(uint64_t, wrapper),
        0)

      return ffi.gc(ffi.cast(public_ecs_iter_t_ptr, wrapper), finish_iter_wrapper)
    end,
  },
  is_valid = function ()
    local query_wrapper = ffi.cast(query_wrapper_t_ptr, self)
    return query_wrapper.query ~= nil
  end,
  __tostring = function (self)
    local query_wrapper = ffi.cast(query_wrapper_t_ptr, self)
    if query_wrapper.query == nil then
      return 'Finished query.'
    end

    local ptr = c.ecs_query_str(query_wrapper.query)
    local result = ffi.string(ptr)
    c.ecs_os_api.free_(ptr)
    return result
  end,
  __metatable = nil,
})

ffi.metatype(public_ecs_iter_t, {
  __tostring = function (self)
    local wrapper = ffi.cast(iter_wrapper_t_ptr, self)
    if wrapper.invalid then
      return 'Invalid iterator.'
    end
    return 'Iterator for query: ' .. tostring(ffi.cast(public_ecs_query_t_ptr, wrapper.iter.query.binding_ctx))
  end,
  is_valid = function (self)
    local iter_wrapper = ffi.cast(iter_wrapper_t_ptr, self)
    return not iter_wrapper.invalid
  end,
  __metatable = nil,
})

local function finish_world_binding_context(binding_context)
  binding_context = ffi.cast(world_binding_context_t_ptr, binding_context)

  -- Free all contained strings.
  local iter = ecs_map_iter_t_vla(1)
  iter[0] = c.ecs_map_iter(binding_context.component_c_types)
  while c.ecs_map_next(iter) do
    c.ecs_os_api.free_(ffi.cast(void_ptr, iter[0].res[1]))
  end

  -- Finish all alive queries.
  iter[0] = c.ecs_map_iter(binding_context.alive_queries)
  while c.ecs_map_next(iter) do
    local wrapper = ffi.cast(query_wrapper_t_ptr, iter[0].res[0])
    c.ecs_query_fini(wrapper.query)
    wrapper.query = nil
  end

  -- Finish all alive iterators.
  iter[0] = c.ecs_map_iter(binding_context.alive_iterators)
  while c.ecs_map_next(iter) do
    local wrapper = ffi.cast(iter_wrapper_t_ptr, iter[0].res[0])
    c.ecs_iter_fini(wrapper.iter)
    print('finish_world_binding_context()', debug.traceback())
    wrapper.invalid = true
  end

  c.ecs_map_fini(binding_context.component_c_types)
  c.ecs_map_fini(binding_context.alive_queries)
  c.ecs_map_fini(binding_context.alive_iterators)
  c.ecs_os_api.free_(binding_context)
end

local function init_world(world)
  local binding_context = ffi.cast(
    world_binding_context_t_ptr,
    c.ecs_os_api.malloc_(ffi.sizeof(world_binding_context_t)))
  c.ecs_map_init(binding_context.component_c_types, nil)
  c.ecs_map_init(binding_context.alive_iterators, nil)
  c.ecs_map_init(binding_context.alive_queries, nil)
  c.ecs_set_binding_ctx(world, binding_context, finish_world_binding_context)
  return world
end

local function finish_world(world)
  c.ecs_fini(world)
end

local ret = {}

function ret.init()
  return ffi.gc(init_world(c.ecs_init()), finish_world)
end

function ret.mini()
  return ffi.gc(init_world(c.ecs_mini()), finish_world)
end

ret.inout = {
  default = c.EcsInOutDefault,
  none = c.EcsInOutNone,
  filter = c.EcsInOutFilter,
  inout = c.EcsInOut,
  in_ = c.EcsIn,
  out = c.EcsOut,
}

ret.cache = {
  default = c.EcsQueryCacheDefault,
  auto = c.EcsQueryCacheAuto,
  all = c.EcsQueryCacheAll,
  none = c.EcsQueryCacheNone,
}

-- TODO: For ecs_query_desc_t: flags, and check all the callbacks and void pointers.

return ret
