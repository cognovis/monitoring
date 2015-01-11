SELECT acs_log__debug('/packages/monitoring/sql/postgresql/upgrade/upgrade-4.2.1-4.2.2.sql','');

create or replace function inline_1 ()
returns integer as '
declare
        v_menu                  integer;
        v_parent_menu    	integer;
        v_admins                integer;
begin

    select group_id into v_admins from groups where group_name = ''P/O Admins'';

    select menu_id into v_parent_menu from im_menus where label=''admin'';

    v_menu := im_menu__new (
        null,                   -- p_menu_id
        ''im_menu'',		-- object_type
        now(),                  -- creation_date
        null,                   -- creation_user
        null,                   -- creation_ip
        null,                   -- context_id
        ''monitoring'', -- package_name
        ''monitoring'',  -- label
        ''Monitoring'',  -- name
        ''/monitoring'', -- url
        2500,                    -- sort_order
        v_parent_menu,           -- parent_menu_id
        ''''                   -- p_visible_tcl
    );

    PERFORM acs_permission__grant_permission(v_menu, v_admins, ''read'');

    return 0;
end;' language 'plpgsql';
select inline_1 ();
drop function inline_1();

