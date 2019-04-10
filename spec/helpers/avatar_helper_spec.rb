require "spec_helper"

describe AvatarHelper, type: :helper do
  describe "#ui_avatar" do
    it "renders avatar with default options" do
      expected = [
        '<span class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy " role="img">',
          '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
        '</span>'
      ].join
      output = helper.ui_avatar src: "http://placeholder.it/32x32"
      expect(output).to eq expected
    end

    context "with no src" do
      it "renders nil" do
        expect(helper.ui_avatar).to be nil
      end
    end

    context "with optional fallback color" do
      it "renders with fallback color classname" do
        expected = [
          '<span class="ui-avatar ui-avatar--medium ui-avatar--fallback-orange " role="img">',
            '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
          '</span>'
        ].join
        output = helper.ui_avatar src: "http://placeholder.it/32x32", fallback_color: "orange"
        expect(output).to eq expected
      end
    end

    context "with optional fallback initials" do
      it "renders with fallback initials data attribute" do
        expected = [
          '<span data-fallback-initials="LE" class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy " role="img">',
            '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
          '</span>'
        ].join
        output = helper.ui_avatar src: "http://placeholder.it/32x32", fallback_initials: "LE"
        expect(output).to eq expected
      end
    end

    context "with optional is_grouped flag" do
      it "renders with grouped classname" do
        expected = [
          '<span class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy ui-avatar--grouped" role="img">',
            '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
          '</span>'
        ].join
        output = helper.ui_avatar src: "http://placeholder.it/32x32", is_grouped: true
        expect(output).to eq expected
      end
    end

    context "with optional size" do
      it "renders with fallback size classname" do
        expected = [
          '<span class="ui-avatar ui-avatar--large ui-avatar--fallback-navy " role="img">',
            '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
          '</span>'
        ].join
        output = helper.ui_avatar src: "http://placeholder.it/32x32", size: "large"
        expect(output).to eq expected
      end
    end

    context "with optional name" do
      it "renders with aria label attribute" do
        expected = [
          '<span aria-label="Test Avatar" class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy " role="img">',
            '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
          '</span>'
        ].join
        output = helper.ui_avatar src: "http://placeholder.it/32x32", name: "Test Avatar"
        expect(output).to eq expected
      end
    end

    context "with optional" do
      context "class" do
        it "renders with additional class" do
          expected = [
            '<span class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy  blah" role="img">',
              '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
            '</span>'
          ].join
          output = helper.ui_avatar src: "http://placeholder.it/32x32", class: "blah"
          expect(output).to eq expected
        end
      end

      context "multiple classes" do
        it "renders with additional classes" do
          expected = [
            '<span class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy  blah etc" role="img">',
              '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
            '</span>'
          ].join
          output = helper.ui_avatar src: "http://placeholder.it/32x32", class: "blah etc"
          expect(output).to eq expected
        end
      end

      context "array of classes" do
        it "renders with additional classes" do
          expected = [
            '<span class="ui-avatar ui-avatar--medium ui-avatar--fallback-navy  blah etc" role="img">',
              '<span class="ui-avatar__avatar" style="background-image: url(http://placeholder.it/32x32)"></span>',
            '</span>'
          ].join
          output = helper.ui_avatar src: "http://placeholder.it/32x32", class: ["blah", "etc"]
          expect(output).to eq expected
        end
      end
    end
  end

  describe "#ui_avatar_group" do
    let!(:avatar1) { helper.ui_avatar src: "http://placeholder.it/32x32" }
    let!(:avatar2) { helper.ui_avatar src: "http://placeholder.it/64x64" }

    context "with no avatars" do
      it "renders nil" do
        expect(helper.ui_avatar_group).to be nil
      end
    end

    it "renders each avatar within group" do
      expected = [
        '<div class="ui-avatar-group">',
          avatar1,
          avatar2,
        '</div>'
      ].join
      output = helper.ui_avatar_group do
        [avatar1, avatar2].join.html_safe
      end
      expect(output).to eq expected
    end

    context "with overflow option" do
      it "adds an overflow chip" do
        expected = [
          '<div class="ui-avatar-group">',
            avatar1,
            avatar2,
            '<span class="ui-avatar-group__chip ui-avatar--medium">2</span>',
          '</div>'
        ].join
        output = helper.ui_avatar_group(overflow: 2) do
          [avatar1, avatar2].join.html_safe
        end
        expect(output).to eq expected
      end

      context "with avatars with explicit size" do
        it "sets correct size class on overflow chip" do
          expected = [
            '<div class="ui-avatar-group">',
              avatar1,
              avatar2,
              '<span class="ui-avatar-group__chip ui-avatar--small">2</span>',
            '</div>'
          ].join
          output = helper.ui_avatar_group(overflow: 2, chip_size: "small") do
            [avatar1, avatar2].join.html_safe
          end
          expect(output).to eq expected
        end
      end
    end
  end
end
