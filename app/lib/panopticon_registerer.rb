class PanopticonRegisterer
  def initialize(dependencies)
    @api = dependencies.fetch(:api_client)
    @mappings = dependencies.fetch(:mappings)
    @artefact = dependencies.fetch(:artefact)
  end

  def call
    if mapping
      notify_of_update
    else
      register_new_artefact
    end
  end

  private

  attr_reader :api, :mappings, :artefact

  def register_new_artefact
    response = api.create_artefact!(artefact_attributes)

    save_new_mapping(response)
  end

  def notify_of_update
    api.put_artefact!(mapping.panopticon_id, artefact_attributes)
  end

  def save_new_mapping(response)
    mappings.create!(
      resource_id: artefact.resource_id,
      resource_type: artefact.kind,
      slug: artefact.slug,
      panopticon_id: response.fetch("id"),
    )
  end

  def artefact_attributes
    artefact.attributes.merge(
      owning_app: owning_app,
    )
  end

  def mapping
    @mapping ||= mappings.where(resource_id: artefact.resource_id).last
  end

  def owning_app
    "specialist-publisher"
  end
end
