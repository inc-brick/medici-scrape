class KoyamaTomioGallarey
  # getter
  def gallery_name
    @gallery_name
  end

  def exhibition_name
    @exhibition_name
  end

  def artist_name
    @artist_name
  end

  def term
    @term
  end

  def address
    @address
  end

  def reception_date
    @reception_date
  end

  def content
    @content
  end

  def profile
    @profile
  end

  def img
    @img
  end

  # setter
  def gallery_name=(gallery_name)
    @gallery_name = gallery_name
  end

  def exhibition_name=(exhibition_name)
    @exhibition_name = exhibition_name
  end

  def artist_name=(artist_name)
    @artist_name = artist_name
  end

  def term=(term)
    @term = term
  end

  def address=(address)
    @address = address
  end

  def reception_date=(reception_date)
    @reception_date = reception_date
  end

  def content=(content)
    @content = content
  end

  def profile=(profile)
    @profile = profile
  end

  def img=(img)
    @img = img
  end

  def to_string
    printf(
        'gallery name: %s
exhibition_name: %s
artist_name: %s
term: %s
address: %s
reception_date: %s
content: %s
profile: %s
img: %s',
        @gallery_name,
        @exhibition_name,
        @artist_name,
        @term,
        @address,
        @reception_date,
        @content,
        @profile,
        @img)
  end
end