# TypoRelatedPostsPlus
module TypoRelatedPostsPlus
  def related limit
    tag_ids_string = self.tags.map{|a| a=a.id}.join(",")
    if !tag_ids_string.empty?
      self.class.find_by_sql(["SELECT
          * , count(at.article_id) as hit_score
        FROM
          contents
        INNER JOIN articles_tags as at ON
          (
            at.tag_id in ("+tag_ids_string+")
            AND at.article_id=`contents`.id
          )
        WHERE contents.id!=? AND contents.`type`=?	GROUP BY at.article_id ORDER BY hit_score DESC LIMIT 0, ? ",self.id, self.type,limit])
    end
  end
end