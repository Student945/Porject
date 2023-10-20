FactoryBot.define do    
    factory :moderator, class: User do    
        email { "antonio.cardinali@hotmail.it"}
        password {"antonio"}
        role {2}
        full_name {"Giuseppe"}
    end
end
