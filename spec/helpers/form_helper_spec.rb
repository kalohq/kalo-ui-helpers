require "spec_helper"

describe FormHelper, type: :helper do
  describe ActionView::Helpers::FormBuilder do
    describe "ui_field_wrapper" do
      let(:resource) { FactoryBot.build :user }
      let(:helper) { ActionView::Helpers::FormBuilder.new :user, resource, self, {} }
      let(:field) { helper.text_field :first_name }
      let(:output) { helper.ui_field_wrapper :first_name, field }

      it "renders given field and label" do
        expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_first_name\">First name</label><input type=\"text\" value=\"#{resource.first_name}\" name=\"user[first_name]\" id=\"user_first_name\" /></div>"
      end

      context "with hint text" do
        let(:output) {
          helper.ui_field_wrapper :first_name,
                                  field, hint: "I am hint text"
        }

        it "renders inline help text" do
          expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_first_name\">First name</label><input type=\"text\" value=\"#{resource.first_name}\" name=\"user[first_name]\" id=\"user_first_name\" /><div class=\"ui-field-hint\">I am hint text</div></div>"
        end
      end

      context "with single error" do
        let(:output) {
          helper.ui_field_wrapper :first_name,
                                  field, hint: "I am hint text"
        }

        it "renders inline validation message" do
          resource.first_name = ""
          resource.save
          expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_first_name\">First name</label><input type=\"text\" value=\"\" name=\"user[first_name]\" id=\"user_first_name\" /><div class=\"ui-field-validation\">First name can&#39;t be blank</div></div>"
        end
      end

      context "with multiple errors" do
        let(:field) {
          helper.text_field :email
        }

        let(:output) {
          helper.ui_field_wrapper :email,
                                  field, hint: "I am hint text"
        }

        it "renders a list of inline validation messages" do
          resource.email = ""
          resource.first_name = ""
          resource.save
          expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_email\">Email</label><input type=\"text\" value=\"\" name=\"user[email]\" id=\"user_email\" /><div class=\"ui-field-validations\"><div class=\"ui-field-validation\">Email can&#39;t be blank</div><div class=\"ui-field-validation\">Email must be a valid email address</div></div></div>"
        end
      end
    end

    describe "ui_text_field" do
      let(:resource) {
        FactoryBot.build :user
      }

      let(:helper) {
        ActionView::Helpers::FormBuilder.new :user,
                                             resource,
                                             self,
                                             {}
      }

      let(:output) {
        helper.ui_text_field :first_name
      }

      it "renders text field and label" do
        expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_first_name\">First name</label><input class=\"ui-input ui-input--medium\" type=\"text\" value=\"#{resource.first_name}\" name=\"user[first_name]\" id=\"user_first_name\" /></div>"
      end

      context "with errors" do
        let(:output) {
          helper.ui_text_field :first_name,
                               hint: "I am hint text"
        }

        it "renders error class on input" do
          resource.first_name = ""
          resource.save
          expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_first_name\">First name</label><input class=\"ui-input ui-input--medium ui-input--invalid\" type=\"text\" value=\"\" name=\"user[first_name]\" id=\"user_first_name\" /><div class=\"ui-field-validation\">First name can&#39;t be blank</div></div>"
        end
      end
    end

    describe "ui_email_field" do
      let(:resource) {
        FactoryBot.build :user
      }

      let(:helper) {
        ActionView::Helpers::FormBuilder.new :user,
                                             resource,
                                             self,
                                             {}
      }

      let(:output) {
        helper.ui_email_field :email
      }

      it "renders email field and label" do
        expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_email\">Email</label><input class=\"ui-input ui-input--medium\" type=\"email\" value=\"#{resource.email}\" name=\"user[email]\" id=\"user_email\" /></div>"
      end
    end

    describe "ui_telephone_field" do
      let(:resource) {
        FactoryBot.build :user,
                         phone_number: "01234567890"
      }

      let(:helper) {
        ActionView::Helpers::FormBuilder.new :user,
                                             resource,
                                             self,
                                             {}
      }

      let(:output) {
        helper.ui_telephone_field :phone_number
      }

      it "renders phone_number field and label" do
        expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_phone_number\">Phone number</label><input class=\"ui-input ui-input--medium\" type=\"tel\" value=\"#{resource.phone_number}\" name=\"user[phone_number]\" id=\"user_phone_number\" /></div>"
      end
    end

    describe "ui_date_field" do
      let(:resource) {
        FactoryBot.build :user,
                         date_of_birth: "01/01/1970"
      }

      let(:helper) {
        ActionView::Helpers::FormBuilder.new :user,
                                             resource,
                                             self,
                                             {}
      }

      let(:output) {
        helper.ui_date_field :date_of_birth
      }

      it "renders date field and label" do
        expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_date_of_birth\">Date of birth</label><input class=\"ui-input ui-input--medium\" type=\"date\" name=\"user[date_of_birth]\" id=\"user_date_of_birth\" /></div>"
      end
    end

    describe "ui_select_field" do
      let(:resource) {
        FactoryBot.build :user
      }

      let(:helper) {
        ActionView::Helpers::FormBuilder.new :user,
                                             resource,
                                             self,
                                             {}
      }

      let(:options) {
        '<option value="1">Option 1</option><option value="2">Option 2</option>'.html_safe
      }

      let(:output) {
        helper.ui_select_field :country_code,
                               options
      }

      it "renders select field and label" do
        expect(output).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_country_code\">Country code</label><select class=\"ui-select ui-input--medium\" name=\"user[country_code]\" id=\"user_country_code\"><option value=\"1\">Option 1</option><option value=\"2\">Option 2</option></select></div>"
      end

      context "with select options" do
        let(:output) {
          helper.ui_select_field :country_code,
                                 options,
                                 prompt: "Pick one"
        }

        it "renders select with given options" do
          resource.country_code = ""
          resource.save
          expect(output.gsub(/\n+/, "")).to include "<div class=\"ui-field\"><label class=\"ui-field-label\" for=\"user_country_code\">Country code</label><select class=\"ui-select ui-input--medium ui-input--invalid\" name=\"user[country_code]\" id=\"user_country_code\"><option value=\"\">Pick one</option><option value=\"1\">Option 1</option><option value=\"2\">Option 2</option></select><div class=\"ui-field-validation\">Country code can&#39;t be blank</div></div>"
        end
      end
    end
  end
end
