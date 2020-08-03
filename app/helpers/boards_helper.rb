module BoardsHelper

    def display_bm(board)
        if board.users.count == 0
            '徵求中啦！'
        else
            board.users.map { |user| user.account }.join("/")
        end

    end

end
