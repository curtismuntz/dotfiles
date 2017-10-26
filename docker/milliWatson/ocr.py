#!/usr/env/python3

try:
    import Image
except ImportError:
    from PIL import Image
    import pytesseract
    pytesseract.pytesseract.tesseract_cmd = '<full_path_to_your_tesseract_executable>'
    # Include the above line, if you don't have tesseract executable in your PATH
    # Example tesseract_cmd: 'C:\\Program Files (x86)\\Tesseract-OCR\\tesseract'
    print(pytesseract.image_to_string(Image.open('test.png')))


class milliWatsonOCR:
    def __init__(self, image_name):
        self.image_name = image_name

    def loadImage(self):
        """Loads the image into memory
        """
        raise NotImplementedError

    def splitImage(self):
        """Parses the image into four chunks.
        1: Question section
        2: Answer A
        3: Answer B
        4: Answer C
        """
    def getQuestion(self):
        """Returns the detected text within the question section of the image
        """
        run_ocr_on_image_section(QUESTION_XMIN,QUESTION_XMAX,QUESTION_YMIN,QUESTION_YMAX)
        raise NotImplementedError

    def getAnswerA(self):
        """Returns the detected text within the first answer section of the image
        """
        run_ocr_on_image_section(ANSWER_A_XMIN,ANSWER_A_XMAX,ANSWER_A_YMIN,ANSWER_A_YMAX)
        raise NotImplementedError

    def getAnswerB(self):
        """Returns the detected text within the first answer section of the image
        """
        run_ocr_on_image_section(ANSWER_B_XMIN,ANSWER_B_XMAX,ANSWER_B_YMIN,ANSWER_B_YMAX)
        raise NotImplementedError

    def getAnswerC(self):
        """Returns the detected text within the first answer section of the image
        """
        run_ocr_on_image_section(ANSWER_C_XMIN,ANSWER_C_XMAX,ANSWER_C_YMIN,ANSWER_C_YMAX)
        raise NotImplementedError

    def run_ocr_on_image_section(self,xmin,xmax,ymin,ymax):
        """Runs OCR on a section of image and returns the string detected
        """
        raise NotImplementedError

