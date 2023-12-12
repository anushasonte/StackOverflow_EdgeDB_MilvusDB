CREATE MIGRATION m1hcwv3vamknljnegzf7izjfra6w4y4i6p53qszndknqheu7d6ogbq
    ONTO initial
{
  CREATE TYPE default::Answer {
      CREATE PROPERTY account_id: std::str;
      CREATE PROPERTY answer_id: std::str;
      CREATE PROPERTY body: std::str;
      CREATE PROPERTY creation_date: std::str;
      CREATE PROPERTY post_id: std::int64;
      CREATE PROPERTY question_id: std::str;
      CREATE PROPERTY reputation: std::str;
      CREATE PROPERTY score: std::int32;
      CREATE REQUIRED PROPERTY user_id: std::int32;
  };
  CREATE TYPE default::Comments {
      CREATE PROPERTY comment_id: std::int64;
      CREATE PROPERTY creation_date: std::str;
      CREATE PROPERTY edited: std::str;
      CREATE PROPERTY post_id: std::int64;
      CREATE PROPERTY score: std::int32;
      CREATE PROPERTY user_id: std::int32;
      CREATE PROPERTY user_type: std::str;
  };
  CREATE TYPE default::User {
      CREATE PROPERTY account_id: std::int32;
      CREATE PROPERTY creation_date: std::str;
      CREATE PROPERTY display_name: std::str;
      CREATE PROPERTY is_employee: std::bool;
      CREATE PROPERTY last_access_date: std::str;
      CREATE PROPERTY last_modified_date: std::str;
      CREATE PROPERTY location: std::str;
      CREATE PROPERTY reputation: std::int32;
      CREATE PROPERTY reputation_change_day: std::int32;
      CREATE PROPERTY reputation_change_month: std::int32;
      CREATE PROPERTY reputation_change_quarter: std::int32;
      CREATE PROPERTY reputation_change_week: std::int32;
      CREATE PROPERTY reputation_change_year: std::int32;
      CREATE REQUIRED PROPERTY user_id: std::int32;
      CREATE PROPERTY user_type: std::str;
      CREATE PROPERTY website_url: std::str;
  };
  ALTER TYPE default::Answer {
      CREATE LINK by_user: default::User;
  };
  CREATE TYPE default::TagSynonyms {
      CREATE PROPERTY applied_count: std::int32;
      CREATE PROPERTY creation_date: std::str;
      CREATE PROPERTY from_tag: std::str;
      CREATE PROPERTY last_applied_date: std::str;
      CREATE PROPERTY to_tag: std::str;
  };
  CREATE TYPE default::UserRelatedTagInfo {
      CREATE MULTI LINK related_users: default::User;
      CREATE PROPERTY tagName: std::str;
      CREATE REQUIRED PROPERTY user_id: std::int32;
  };
  CREATE TYPE default::Tags {
      CREATE MULTI LINK has_synonyms: default::TagSynonyms;
      CREATE MULTI LINK used_by: default::UserRelatedTagInfo;
      CREATE PROPERTY count: std::int64;
      CREATE PROPERTY is_moderator_only: std::str;
      CREATE PROPERTY is_require: std::str;
      CREATE PROPERTY name: std::str;
  };
  CREATE TYPE default::QuestionsRelatedTagsInfo {
      CREATE LINK tagInformation: default::Tags;
      CREATE REQUIRED PROPERTY question_id: std::str;
      CREATE PROPERTY tag: std::str;
  };
  CREATE TYPE default::Question {
      CREATE MULTI LINK has_Tags: default::QuestionsRelatedTagsInfo;
      CREATE LINK question_by_user: default::User;
      CREATE PROPERTY body: std::str;
      CREATE PROPERTY creation_date: std::str;
      CREATE PROPERTY is_answered: std::str;
      CREATE PROPERTY post_id: std::int64;
      CREATE PROPERTY question_id: std::str;
      CREATE PROPERTY score: std::int32;
      CREATE PROPERTY title: std::str;
      CREATE REQUIRED PROPERTY user_id: std::int32;
  };
  ALTER TYPE default::Answer {
      CREATE LINK to_Question: default::Question;
  };
  ALTER TYPE default::Question {
      CREATE MULTI LINK has_answer := (.<to_Question[IS default::Answer]);
  };
  CREATE TYPE default::Post {
      CREATE LINK to_Answer: default::Answer;
      CREATE MULTI LINK has_comments: default::Comments;
      CREATE LINK post_by_user: default::User;
      CREATE LINK to_Question: default::Question;
      CREATE PROPERTY creation_date: std::int64;
      CREATE PROPERTY last_activity_date: std::int64;
      CREATE PROPERTY post_id: std::str;
      CREATE PROPERTY post_type: std::str;
      CREATE PROPERTY score: std::int32;
      CREATE REQUIRED PROPERTY user_id: std::int32;
  };
  CREATE TYPE default::Badge {
      CREATE LINK to_user: default::User;
      CREATE PROPERTY award_count: std::int32;
      CREATE PROPERTY badge_id: std::int32;
      CREATE PROPERTY badge_type: std::str;
      CREATE PROPERTY name: std::str;
      CREATE PROPERTY rank: std::str;
      CREATE REQUIRED PROPERTY user_id: std::int32;
  };
  ALTER TYPE default::User {
      CREATE MULTI LINK has_badge := (.<to_user[IS default::Badge]);
      CREATE MULTI LINK has_posts := (.<post_by_user[IS default::Post]);
      CREATE MULTI LINK has_Tags := (.<related_users[IS default::UserRelatedTagInfo]);
  };
};
