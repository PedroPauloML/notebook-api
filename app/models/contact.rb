class Contact < ApplicationRecord
  belongs_to :kind

  has_one :address, dependent: :destroy

  has_many :phones, dependent: :destroy

  accepts_nested_attributes_for :address, update_only: true
  accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: :all_blank

  # def author
  #   "Pedro Paulo"
  # end

  # def kind_description
  #   self.kind.description
  # end

  def as_json(options={})
    super(
      # root: true,
      # methods: [:author, :kind_description]
      methods: [:kind, :address, :phones]
    )
  end
end
