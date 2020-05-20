from Bio.Blast import NCBIWWW
import os.path
import time


class BlastObject:
    """ creates an object for holding all the information for a BLAST """

    def __init__(self, acc, seq, score):
        """ the main of the class"""
        self.acc = acc
        self.seq = seq
        self.score = score

    def get_acc(self):
        """ returns identifier sequence"""
        return self.acc

    def get_seq(self):
        """ returns sequence"""
        return self.seq

    def get_score(self):
        """ returns sequence score"""
        return self.score


def read_tsv_file(file_name):
    """Reads the tsv-file and returns contents in objects
    input: tsv_name - str

    output: return obj_list - list - [obj1, obj2, obj3, ...]

    """
    print("Reading tsv-file...")
    obj_list = []
    with open(file_name) as inFile:
        for line in inFile:
            acc1, seq1, score1, acc2, seq2, score2 = line.strip().split("\t")
            obj = BlastObject(acc1, seq1, score1)
            obj_list.append(obj)
            obj = BlastObject(acc2, seq2, score2)
            obj_list.append(obj)
    print("Reading finished.\n")
    return obj_list


def automatic_blast(obj_list):
    """blasts sequences
    input: obj_list - list - [obj1, obj2, obj3, ...]

    output: xml-file
    """
    counter = 0  # Om te weten bij welke je bent
    for obj in obj_list:
        counter += 1
        print("Starting BlAST {} out of {}".format(counter, len(obj_list)))
        # de objecten zitten op volgorde in de lijst (de eerste sequentie in het excel bestand is ook de eerste
        # sequentie in de lijst). Met de counter kun je dus bijhouden bij welke sequentie je bent
        print("BLASTing... Currently BLASTing: ",  obj.get_acc())
        blast_seq = ">" + obj.get_acc() + "\n" + obj.get_seq()
        result_handle = NCBIWWW.qblast("blastx", "nr", blast_seq, expect=1, format_type="XML", hitlist_size=10,
                                       matrix_name="BLOSUM62")  # het aantal resultaten gelimiteerd tot 10. Je krijgt
        # alleen niet precies dezelfde volgorde aan resultaten dan wanneer je blast in de browser.
        print("BLASTing finished. Preparing XML-file from: ", obj.get_acc())

        xml_file_name = obj.get_acc().replace(":", ";")+".xml"  # je mag geen dubbele punten hebben in je bestandsnaam
        path_save_xml_files = r"C:\Users\nicks\Documents\Tutor\Blok 4\han-bi4a-1c-3-project\xml_files"  # geeft folder aan waar het allemaal mag
        # worden opgeslagen (moet dan nog aangepast worden)
        complete_path = os.path.join(path_save_xml_files, xml_file_name)

        with open(complete_path, "w") as out_handle:
            out_handle.write(result_handle.read())  # de resultaten worden ingelezen en geschreven naar een bestand
        result_handle.close()
        print("XML-file acquired from: ", obj.get_acc())
        print("Finished BlAST {} out of {})".format(counter, len(obj_list)))
        print("Starting next BLAST \n")
        time.sleep(5)
    print("Everything BLASTed")


def main():
    tsv_file = "dataset-10.tsv"
    obj_list = read_tsv_file(tsv_file)
    automatic_blast(obj_list)


main()
