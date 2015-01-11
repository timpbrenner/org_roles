# Organization Roles
Here are my thoughts on how I solved the problem.

I have a base organization class that will handle the role addition and
retrivial. This is also how I would have done it with ActiveRecord
classes. This would mean that all the organization could live in one
table. The accessors, child_organizations, parent_organizations and
roles would be ActiveRecord associations if this was in a database.

There is a method called add_child_organization that will
help build the organizational structure.  It is overriden in the
RootOrganization, Organization, and ChildOrganization class to enforce
the rules of organizational hierarchy.
