# frozen_string_literal: true

require 'view/game/actionable'

module View
  module Game
    class SellShares < Snabberb::Component
      include Actionable

      needs :player
      needs :selected_corporation, default: nil, store: true

      def render
        buttons = @game.round.sellable_bundles(@player, @selected_corporation).map do |bundle|
          sell = lambda do
            process_action(Engine::Action::SellShares.new(@player, bundle.shares, bundle.percent))
          end

          num_shares = bundle.num_shares

          text = "Sell #{num_shares} (#{@game.format_currency(bundle.price)})"

          h('button.button.margined_half', { on: { click: sell } }, text)
        end

        h(:div, { style: { 'margin-top': '1rem' } }, buttons.compact)
      end
    end
  end
end
