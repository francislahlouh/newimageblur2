
class Image
    attr_reader :blurred_image
   
    def initialize(image_array)
        if image_array.empty?
            puts "Your image is empty"
        end
        @image_array = image_array
       
    end
   
    def output_image
        @image_array.each do |element|     
            element.each do |sub_element|
                print sub_element           
            end
            puts
        end
    end
   
   
    def blur_image
     
      #other method (so remove @ from vars where not needed) ***
      cells_with_ones = []                  # array to hold all index "coordinate" pairs of pre-blur occurrences of 1
      @blurred_image = @image_array         # copy of original image so we can compare original with blurred afterwards
     
      # record # of rows (elements/sub-arrays in @image_array) so we know when to stop looping
     
      image_length = @image_array.length           # number of rows in @image_array
      row_length = @image_array[0].length           # assume all rows in image are of equal length

      # for each row, save index for each occurrence of 1 within that row
     
      @image_array.each_with_index do |row, row_index|
#      row_index = 0                          # index of first row (an array) within @image_array
#      row_index = [0..@image_length-1]       # row index range within @image_array
        # row = @image_array[@row_index]     # actual row (an array) within @image_array
#        sub_element_indices = row.each_index.select{|i| row[i] == 1}  # find indices in @image_array rows (which are arrays)
                                                                               # of each occurrence of 1
                                                                               
        sub_element_indices = @image_array[row_index].each_index.select{|i| row[i] == 1}
     
        unless sub_element_indices.empty?          # if @sub_element_indices not empty, do rest of code
          sub_element_indices.each do |index|
#            @this_initial_one = [@row_index, index]   #create new array [@row_index, index]
 
            cells_with_ones << [row_index, index]     # index coordinate pairs for each occurrence of 1
          end
        end
      end
     
      cells_with_ones.each do |coords|     # assume @image_array rows are of constant length (no jagged images)
        case                            
       
        # we are at the upper left corner
        when coords[0] == 0 && coords[1] == 0
          @blurred_image[0][1] = 1      # right of occurrence of 1
          @blurred_image[1][0] = 1      # below occurrence of 1
       
        # we are at the upper right corner
        when coords[0] == 0 && coords[1] == row_length-1
          @blurred_image[0][row_length-2] = 1     # left of occurrence of 1
          @blurred_image[1][row_length-1] = 1     # below occurrence of 1
       
        # we are at the lower left corner
        when coords[0] == image_length-1 && coords[1] == 0
          @blurred_image[image_length-2][0] = 1     # above occurrence of 1
          @blurred_image[image_length-1][1] = 1     # right of occurrence of 1
       
        # we are at the lower right corner
        when coords[0] == image_length-1 && coords[1] == row_length-1
          @blurred_image[image_length-2][row_length-1] = 1      # above occurrence of 1
          @blurred_image[image_length-1][row_length-2] = 1      # left of occurrence of 1
       
        # we are at the top edge of the image and not in the upper left/right corners
        when coords[0] == 0  && coords[1]-1 >= 0 && coords[1]-1 < row_length-1
          @blurred_image[0][coords[1]-1] = 1      # left of occurrence of 1
          @blurred_image[0][coords[1]+1] = 1      # right of occurrence of 1
          @blurred_image[1][coords[1]] = 1        # below occurrence of 1
         

        when coords[1] == row_length-1 && coords[0] > 0 && coords[0] < image_length-1

          @blurred_image[coords[0]-1][coords[1]] = 1      # above occurrence of 1
          @blurred_image[coords[0]][coords[1]-1] = 1      # left of occurrence of 1
          @blurred_image[coords[0]+1][coords[1]] = 1      # below occurrence of 1
         
        # we are at the bottom edge of the image and not in the lower left/right corners
        when coords[0] == image_length-1 && coords[1] > 0 && coords[1] < image_length-1

          @blurred_image[coords[0]-1][coords[1]] = 1      # above occurrence of 1
          @blurred_image[coords[0]][coords[1]-1] = 1      # left of occurrence of 1
          @blurred_image[coords[0]][coords[1]+1] = 1      # right of occurrence of 1
           
        # we are at the left edge of the image and not in the upper/lower left corners
        when coords[1] == 0 && coords[0] > 0 && coords[0] < image_length-1

          @blurred_image[coords[0]-1][coords[1]] = 1      # above occurrence of 1
          @blurred_image[coords[0]][coords[1]+1] = 1      # right of occurrence of 1
          @blurred_image[coords[0]+1][coords[1]] = 1      # below occurrence of 1
         
        # general case for other than edges  
        else
          @blurred_image[coords[0]-1][coords[1]] = 1      # above occurrence of 1
          @blurred_image[coords[0]][coords[1]+1] = 1      # right of occurrence of 1
          @blurred_image[coords[0]+1][coords[1]] = 1      # below occurrence of 1
          @blurred_image[coords[0]][coords[1]-1] = 1      # left of occurrence of 1
       
        end
      end

    end

   
end

# image with 1 at each corner only
image = Image.new([
  [1, 0, 0, 1],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
  [1, 0, 0, 1]
])

# image with 1 at interior cells only (not at edges)
image3 = Image.new([
  [0, 0, 0, 0],
  [0, 1, 1, 0],
  [0, 1, 1, 0],
  [0, 0, 0, 0]
])

# image with 1 at non-corner edge cells only
image5 = Image.new([
  [0, 1, 1, 0],
  [1, 0, 0, 1],
  [1, 0, 0, 1],
  [0, 1, 1, 0]
])

# image with 1 at random cell
image7 = Image.new([
  [0, 0, 0, 0],
  [0, 1, 0, 0],
  [0, 0, 0, 0],
  [0, 0, 0, 0]
])

# image with 1 at random cells
image9 = Image.new([
  [0, 0, 1, 0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [1, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0]
])

puts "original image 1"
image.output_image
image.blur_image
puts
puts "blurred image 1"
image2 = Image.new(image.blurred_image)
image2.output_image
puts

puts "original image 2"
image3.output_image
image3.blur_image
puts
puts "blurred image 2"
image4 = Image.new(image3.blurred_image)
image4.output_image
puts

puts "original image 3"
image5.output_image
image5.blur_image
puts
puts "blurred image 3"
image6 = Image.new(image5.blurred_image)
image6.output_image
puts

puts "original image 4"
image7.output_image
image7.blur_image
puts
puts "blurred image 4"
image8 = Image.new(image7.blurred_image)
image8.output_image
puts

puts "original image 5"
image9.output_image
image9.blur_image
puts
puts "blurred image 5"
image10 = Image.new(image9.blurred_image)
image10.output_image
