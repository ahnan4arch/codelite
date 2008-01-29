#include "configurationtoolbase.h"
#include "xmlutils.h"
#include "serialized_object.h"
#include "wx/filename.h"
#include "wx/ffile.h"

ConfigurationToolBase::ConfigurationToolBase()
: m_fileName(wxEmptyString)
{ 
}

ConfigurationToolBase::~ConfigurationToolBase()
{
} 

bool ConfigurationToolBase::Load(const wxString &fileName)
{
	wxFileName fn(fileName);
	fn.MakeAbsolute();
	m_fileName = fn.GetFullPath();
	
	if(fn.FileExists() == false){
		//no such file, create an empty file
		wxString content;
		content << wxT("<") << GetRootName() << wxT("/>");
		wxFFile file;
		file.Open(fn.GetFullPath(), wxT("w+b"));
		if(file.IsOpened()){
			file.Write(content);
			file.Close();
		}
	}
	return m_doc.Load(m_fileName);
}

bool ConfigurationToolBase::WriteObject(const wxString &name, SerializedObject *obj)
{
	if(m_doc.IsOk() == false){
		return false;
	}
	Archive arch;
	wxXmlNode *child = XmlUtils::FindNodeByName(m_doc.GetRoot(), wxT("ArchiveObject"), name);
	if (child) {
		wxXmlNode *n = m_doc.GetRoot();
		n->RemoveChild(child);
		delete child;
	}

	//create new xml node for this object
	child = new wxXmlNode(NULL, wxXML_ELEMENT_NODE, wxT("ArchiveObject"));
	m_doc.GetRoot()->AddChild(child);
	child->AddProperty(wxT("Name"), name);

	arch.SetXmlNode(child);
	//serialize the object into the archive
	obj->Serialize(arch);
	//save the archive
	return m_doc.Save(m_fileName);
}


bool ConfigurationToolBase::ReadObject(const wxString &name, SerializedObject *obj)
{
	if(m_doc.IsOk() == false){
		return false;
	}

	//find the object node in the xml file
	wxXmlNode *node = XmlUtils::FindNodeByName(m_doc.GetRoot(), wxT("ArchiveObject"), name);
	if (node) {
		Archive arch;
		arch.SetXmlNode(node);
		obj->DeSerialize(arch);
		return true;
	}
	return false;
}
