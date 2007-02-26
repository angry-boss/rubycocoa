/** -*-objc-*-
 *
 *   $Id$
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
 *
 **/

#ifndef _RBRUNTIME_H_
#define _RBRUNTIME_H_

#import <objc/objc.h>

/** [API] RBBundleInit
 *
 * initialize ruby and rubycocoa for a bundle.
 * return not 0 when something error.
 */
int RBBundleInit (const char* path_to_ruby_program, 
		  Class       objc_class, 
		  id          additional_param);


/** [API] RBApplicationInit
 *
 * initialize ruby and rubycocoa for a command/application
 * return 0 when complete, or return not 0 when error.
 */
int RBApplicationInit (const char* path_to_ruby_program,
		       int         argc,
		       const char* argv[],
		       id          additional_param);


/** [API] RBRubyCocoaInit (for compatibility)
 *
 * initialize rubycocoa for a ruby extention library
 */
void RBRubyCocoaInit();


/** [API] RBApplicationMain (for compatibility)
 *
 * launch rubycocoa application
 */
int
RBApplicationMain (const char* path_to_ruby_program, 
		   int         argc, 
		   const char* argv[]);

#endif  // _RBRUNTIME_H_
