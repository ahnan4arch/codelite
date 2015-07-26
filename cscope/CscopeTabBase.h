//////////////////////////////////////////////////////////////////////
// This file was auto-generated by codelite's wxCrafter Plugin
// wxCrafter project file: CscopeTabBase.wxcp
// Do not modify this file by hand!
//////////////////////////////////////////////////////////////////////

#ifndef CODELITE_CSCOPE_CSCOPETABBASE_BASE_CLASSES_H
#define CODELITE_CSCOPE_CSCOPETABBASE_BASE_CLASSES_H

#include <wx/settings.h>
#include <wx/xrc/xmlres.h>
#include <wx/xrc/xh_bmp.h>
#include <wx/panel.h>
#include <wx/artprov.h>
#include <wx/sizer.h>
#include <wx/dataview.h>
#include "cscoptviewresultsmodel.h"
#include <wx/stattext.h>
#include <wx/choice.h>
#include <wx/arrstr.h>
#include <wx/checkbox.h>
#include <wx/button.h>
#include <wx/gauge.h>
#include <wx/dialog.h>
#include <wx/iconbndl.h>
#include <wx/filepicker.h>
#if wxVERSION_NUMBER >= 2900
#include <wx/persist.h>
#include <wx/persist/toplevel.h>
#include <wx/persist/bookctrl.h>
#include <wx/persist/treebook.h>
#endif

class CscopeTabBase : public wxPanel
{
protected:
    wxDataViewCtrl* m_dataview;
    wxObjectDataPtr<CScoptViewResultsModel> m_dataviewModel;

    wxStaticText* m_statusMessage;
    wxStaticText* m_staticText2;
    wxChoice* m_choiceSearchScope;
    wxCheckBox* m_checkBoxUpdateDb;
    wxCheckBox* m_checkBoxRevertedIndex;
    wxButton* m_buttonUpdateDbNow;
    wxButton* m_buttonClear;
    wxGauge* m_gauge;

protected:
    virtual void OnItemActivated(wxDataViewEvent& event) { event.Skip(); }
    virtual void OnItemSelected(wxDataViewEvent& event) { event.Skip(); }
    virtual void OnChangeSearchScope(wxCommandEvent& event) { event.Skip(); }
    virtual void OnWorkspaceOpenUI(wxUpdateUIEvent& event) { event.Skip(); }
    virtual void OnCreateDB(wxCommandEvent& event) { event.Skip(); }
    virtual void OnClearResults(wxCommandEvent& event) { event.Skip(); }
    virtual void OnClearResultsUI(wxUpdateUIEvent& event) { event.Skip(); }

public:
    wxDataViewCtrl* GetDataview() { return m_dataview; }
    wxStaticText* GetStatusMessage() { return m_statusMessage; }
    wxStaticText* GetStaticText2() { return m_staticText2; }
    wxChoice* GetChoiceSearchScope() { return m_choiceSearchScope; }
    wxCheckBox* GetCheckBoxUpdateDb() { return m_checkBoxUpdateDb; }
    wxCheckBox* GetCheckBoxRevertedIndex() { return m_checkBoxRevertedIndex; }
    wxButton* GetButtonUpdateDbNow() { return m_buttonUpdateDbNow; }
    wxButton* GetButtonClear() { return m_buttonClear; }
    wxGauge* GetGauge() { return m_gauge; }
    CscopeTabBase(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize(-1,-1), long style = wxTAB_TRAVERSAL);
    virtual ~CscopeTabBase();
};


class CScopeSettingsDlgBase : public wxDialog
{
protected:
    wxStaticText* m_staticText20;
    wxFilePickerCtrl* m_filePickerCScopeExe;
    wxStdDialogButtonSizer* m_stdBtnSizer12;
    wxButton* m_button14;
    wxButton* m_button16;

protected:

public:
    wxStaticText* GetStaticText20() { return m_staticText20; }
    wxFilePickerCtrl* GetFilePickerCScopeExe() { return m_filePickerCScopeExe; }
    CScopeSettingsDlgBase(wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& title = _("CScope Settings"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize(-1,-1), long style = wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER);
    virtual ~CScopeSettingsDlgBase();
};

#endif
