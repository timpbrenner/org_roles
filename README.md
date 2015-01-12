# Organization Roles
I have a GemFile so you can juat bundle in case you don't have RSpec
installed.

Here are my thoughts on how I solved the problem.

I thought of it as two different tasks. 1.) Enforce the organizational
hierarchy and 2.) returning accurate roles.

I solved the first problem by having a base organization object that can
have one parent and multiple children. The sub-classes enforce the
individual business logic.

There is a method called add_child_organization that will
help build the organizational structure.  It is overriden in the
RootOrganization, Organization, and ChildOrganization class to enforce
the rules of organizational hierarchy.

The second problem reloved around the role object roles are associated with
a user and an organization.  The lowest applicable organization will be
asked for the role and the organization will keep asking parents until it finds a role.

I have a base organization class that will handle the role addition and
retrivial. This is also how I would have done it with ActiveRecord
classes. This would mean that all the organization could live in one
table. The accessors, child_organizations, parent_organizations and
roles would be ActiveRecord associations.
