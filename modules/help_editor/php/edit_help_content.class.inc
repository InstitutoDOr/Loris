<?php
/**
 * This file contains code for editing context help section
 *
 * PHP Version 7
 *
 * @category Main
 * @package  Loris
 * @author   Rathi Sekaran <sekaranrathi@gmail.com>
 * @license  Loris license
 * @link     https://github.com/aces/Loris
 */
namespace LORIS\help_editor;

/**
 * A class for holding a set of functions to add/update content
 * for all modules
 *
 * @category Main
 * @package  Loris
 * @author   Rathi Sekaran <sekaranrathi@gmail.com>
 * @license  Loris license
 * @link     https://github.com/aces/Loris
 */

class Edit_Help_Content extends \NDB_Form
{
    var $indent = "&nbsp;&nbsp;&nbsp;&nbsp;";
     /**
     * Determine if user has permission to access this page
     *
     * @return boolean true if access is permitted
     */
    function _hasAccess()
    {
        // create user object
        $user = \User::singleton();

            // check user permissions
        return $user->hasPermission('context_help');
    }
     /**
      * Returns default help content of the page
      *
      * @return default array
      */
    function _getDefaults()
    {
        $DB = \Database::singleton();
        //Get the default values

        // Sanitize user input
        $safeHelpID     = htmlspecialchars($_REQUEST['helpID']);
        $safeSection    = $_REQUEST['section'] ?
            htmlspecialchars($_REQUEST['section']) : '';
        $safeSubsection = $_REQUEST['subsection'] ?
            htmlspecialchars($_REQUEST['subsection']) : '';

        if (isset($_REQUEST['helpID'])) {
            $helpID = $safeHelpID;
        }
        if (!empty($_REQUEST['section'])) {
            $helpID = HelpFile::hashToID(md5($_REQUEST['section']));
        }
        if (!empty($_REQUEST['section'])
            && $_REQUEST['subsection'] != 'undefined'
        ) {
            $helpID = HelpFile::hashToID(md5($_REQUEST['subsection']));
        }
        $this->tpl_data['section']    = $safeSection;
        $this->tpl_data['subsection'] = $safeSubsection;

        if (!empty($helpID)) {
            $help_file = HelpFile::factory($helpID);
            $data      = $help_file->toArray();
            $defaults['title']   = $data['topic'];
            $defaults['content'] = utf8_encode(trim($data['content']));
            if (isset($_REQUEST['helpID'])) {
                $this->tpl_data['module_name'] = "Help Editor";
            } else {
                $this->tpl_data['module_name'] = $defaults['title'];
            }

        }
        // case where no help content exists
        if (empty($defaults['title'])) {
            if (!empty($_REQUEST['section'])) {
                $defaults['title'] = str_replace("_", " ", $safeSection);
            }
            // if not module and not instrument, should be a subtest
            if ($_REQUEST['subsection'] != 'undefined') {
                $defaults['title'] = str_replace("_", " ", $safeSubsection);
            }
            $this->tpl_data['module_name'] = $defaults['title'];
        }
        if (empty($defaults['content'])) {
            $defaults['content'] = 'Under Construction';
        }

        if (isset($_COOKIE["LastUrl"]) ) {
            $this->tpl_data['url'] = $_COOKIE["LastUrl"];
        }
        return $defaults;
    }
     /**
      * Process function
      *
      * @param string $values the value
      *
      * @return void
      */
    function _process($values)
    {
        $DB = \Database::singleton();
        //Get the default values

        // Sanitize user input
        $safeHelpID     = htmlspecialchars($_REQUEST['helpID']);
        $safeParentID   = htmlspecialchars($_REQUEST['parentID']);
        $safeSection    = htmlspecialchars($_REQUEST['section']);
        $safeSubsection = htmlspecialchars($_REQUEST['subsection']);
        if (isset($_REQUEST['helpID'])) {
            $helpID = $safeHelpID;
        }
        if (isset($_REQUEST['parentID'])) {
            $parentID = $safeParentID;
        }

        if (!empty($_REQUEST['section'])) {
            $helpID = HelpFile::hashToID(md5($_REQUEST['section']));
        }
        if (!empty($_REQUEST['section'])
            && $_REQUEST['subsection'] != 'undefined'
        ) {
            $helpID   = HelpFile::hashToID(md5($_REQUEST['subsection']));
            $parentID = HelpFile::hashToID(md5($_REQUEST['section']));
        }
        if (!empty($helpID)
            && isset($values['title'])
            && isset($values['content'])
        ) {
            $help_file = HelpFile::factory($helpID);
            // update the help file
            $success = $help_file->update(
                array(
                 'topic'   => $values['title'],
                 'content' => $values['content'],
                 'updated' => date(
                     'Y-m-d h:i:s',
                     time()
                 ),
                )
            );
        } else {
            //content does not exist insert the help file
            if (!empty($_REQUEST['section'])
                && $_REQUEST['subsection'] != 'undefined'
                && empty($parentID)
            ) {
                //create parent help section first
                $parentID = HelpFile::insert(
                    array(
                     'hash'    => md5($_REQUEST['section']),
                     'topic'   => "",
                     'content' => "Under construction",
                     'created' => date(
                         'Y-m-d h:i:s',
                         time()
                     ),
                    )
                );
                 // check errors

            }
            if (!empty($_REQUEST['section'])
                && $_REQUEST['subsection'] != 'undefined'
                && !empty($parentID)
            ) {

                // insert the help file
                $helpID = HelpFile::insert(
                    array(
                     'parentID' => $parentID,
                     'hash'     => md5($_REQUEST['subsection']),
                     'topic'    => $values['title'],
                     'content'  => $values['content'],
                     'created'  => date(
                         'Y-m-d h:i:s',
                         time()
                     ),
                    )
                );

            } else if (!empty($_REQUEST['section'])
                && $_REQUEST['subsection'] == 'undefined'
            ) {
                //default case
                $helpID = HelpFile::insert(
                    array(
                     'hash'    => md5($_REQUEST['section']),
                     'topic'   => $values['title'],
                     'content' => $values['content'],
                     'created' => date(
                         'Y-m-d h:i:s',
                         time()
                     ),
                    )
                );

            }

        }
        $this->tpl_data['success'] =  true;

    }

    /**
     * Does the setup required for this page. By default, sets up elements
     * that are common to every type of page. May be overridden by a specific
     * page or specific page type.
     *
     * @return none
     */
    function setup()
    {
        parent::setup();

        $this->addBasicText('title', 'Title');
        $this->addBasicTextArea(
            'content',
            'Content',
            array(
             'cols' => 140,
             'rows' => 30,
            )
        );

    }

    /**
     * Include the column formatter required to display the feedback link colours
     * in the candidate_list menu
     *
     * @return array of javascript to be inserted
     */
    function getJSDependencies()
    {
        $factory = \NDB_Factory::singleton();
        $baseURL = $factory->settings()->getBaseURL();
        $deps    = parent::getJSDependencies();
        return array_merge(
            $deps,
            array(
             $baseURL . "/help_editor/js/help_editor_helper.js",
            )
        );
    }
}

?>
