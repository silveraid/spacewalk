--
-- Copyright (c) 2008 Red Hat, Inc.
--
-- This software is licensed to you under the GNU General Public License,
-- version 2 (GPLv2). There is NO WARRANTY for this software, express or
-- implied, including the implied warranties of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
-- along with this software; if not, see
-- http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
-- 
-- Red Hat trademarks are not licensed under GPLv2. No permission is
-- granted to use or replicate Red Hat trademarks that are incorporated
-- in this software or its documentation. 
--
--
--
--
CREATE OR REPLACE FUNCTION
LOOKUP_CVE(name_in IN VARCHAR)
RETURNS NUMERIC
AS $$
DECLARE
             ret_val         NUMERIC;
BEGIN

	select retcode into ret_val
	from dblink('dbname='||current_database(),
	'select lookup_cve_autonomous('||coalesce(name_in::varchar,'null')||')')
	as f(retcode numeric);
        
        RETURN ret_val;
END;
$$ language plpgsql;
