## Brief overview
- Project-specific rules to verify Apex class names in this SFDX project follow common Salesforce best practices and the current codebase conventions.
- Focus on naming patterns, suffix usage, test class naming, file alignment, and avoiding anti-patterns to keep metadata consistent and readable.

## Naming conventions
- Use PascalCase for all Apex class names (e.g., OrdersSelector, OrderTriggerHandler, UpdateAccountsBatch).
- Class names must start with an uppercase letter and contain only letters and numbers; no spaces, underscores, or hyphens.
- Names should be descriptive and business-oriented; avoid ambiguous names like Util, Helper, or Misc without context.
- Keep names concise; prefer OrdersController over OrdersUIBusinessControllerImpl.

## Suffix patterns by responsibility
- Controller: Classes exposing methods to Aura/LWC or UI controllers should end with Controller (e.g., OrdersController).
- Selector: Data access classes encapsulating SOQL/SOSL should end with Selector (e.g., OrdersSelector).
- Trigger Handler: Trigger orchestration classes should end with TriggerHandler (e.g., OrderTriggerHandler).
- Batch Apex: Batch jobs should end with Batch (e.g., UpdateAccountsBatch). Optional additions for clarity are not required unless value-added (e.g., UpdateAccountsBatchDaily).
- Future/Queueable/Schedulable: Consider adding Future, Queueable, or Schedulable suffixes when the pattern is the class’s primary role (e.g., RecalculateScoresQueueable).
- Domain/Service: If using Domain/Service layers, end with Domain or Service (e.g., OrderDomain, PaymentService).
- Avoid redundant suffix stacking (e.g., OrdersControllerClass, OrdersSelectorHelper).

## Test class naming
- Test classes must mirror the production class name with a Test suffix (e.g., OrdersControllerTest, OrdersSelectorTest, OrderTriggerTest, UpdateAccountsBatchTest).
- One primary test class per production class is preferred; create additional focused test classes only if they serve a clear separation of concerns (e.g., OrdersControllerBulkTest).

## File alignment and metadata
- Each Apex class .cls file must have a matching .cls-meta.xml with the same base name (e.g., OrdersController.cls and OrdersController.cls-meta.xml).
- Names must be unique within the project and must not collide after namespace packaging.
- When renaming classes, update references in tests, Factory/DI, and metadata (package.xml if present) to keep consistency.

## Disallowed and anti-patterns
- No snake_case, kebab-case, or trailing numbers that do not convey meaning (e.g., Helper2).
- Avoid generic buckets like Manager, Processor, Handler without domain context (prefer OrderTriggerHandler to GenericHandler).
- Do not prefix with object API names unless it adds clarity (Order vs ORD); avoid cryptic abbreviations.
- Do not include environment or org-specific tokens in names (e.g., Dev, UAT, Prod) unless it is a distinct deployable artifact required by design.

## Cross-checks to perform
- Project scan path: force-app/main/default/classes.
- Validate each class name against:
  - PascalCase regex: ^[A-Z][A-Za-z0-9]*$.
  - Recommended suffixes based on class role (Controller, Selector, TriggerHandler, Batch, Queueable, Schedulable, Service, Domain).
  - Presence of corresponding Test class with the same base name + Test.
  - Matching .cls and .cls-meta.xml file pairs.
- Flag recommendations, not hard failures, when a class does not use a conventional suffix but has a clear purpose; suggest the closest matching suffix.

## Alignment with current project
- Existing examples that align with these rules:
  - OrdersController, OrdersSelector, OrderTriggerHandler, UpdateAccountsBatch, and their corresponding Tests.
- Continue to follow these patterns for new classes to retain consistency across the codebase.

## Exceptions and flexibility
- Framework or library classes may intentionally diverge (e.g., Factory) if the name is widely recognized and self-explanatory.
- When a class legitimately spans multiple roles, choose the most dominant responsibility for the suffix; document any exceptions in code comments.

## Change management
- When a naming change is proposed:
  - Refactor class name, update imports/references, update related test classes, and confirm deployment coverage.
  - Include a short description in the PR explaining the rationale for the renaming and the mapping from old to new names.
