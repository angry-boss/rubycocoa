/** -*-objc-*-
 *
 *   $Id$
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import <LibRuby/cocoa_ruby.h>
#import "osx_ocobject.h"
#import <Foundation/Foundation.h>
#import <RubyCocoa/RBRuntime.h>	// RubyCocoa.framework
#import <RubyCocoa/RBObject.h>	// RubyCocoa.framework

#define OSX_MODULE_NAME "OSX"

static VALUE init_module_OSX()
{
  VALUE module;
  RB_ID id_osx = rb_intern(OSX_MODULE_NAME);

  if (rb_const_defined(rb_cObject, id_osx))
    module = rb_const_get(rb_cObject, id_osx);
  else
    module = rb_define_module(OSX_MODULE_NAME);
  return module;
}

// def OSX.objc_proxy_class_new (class_name)
// ex1.  OSX.objc_proxy_class_new (:AppController)
static VALUE
osx_mf_objc_proxy_class_new(VALUE mdl, VALUE class_name)
{
  class_name = rb_obj_as_string(class_name);
  RBOCClassNew(STR2CSTR(class_name), [RBObject class]);
  return Qnil;
}

// def OSX.objc_derived_class_new (class_name, super_name)
// ex1.  OSX.objc_derived_class_new (:CustomView, :NSView)
static VALUE
osx_mf_objc_derived_class_new(VALUE mdl, VALUE class_name, VALUE super_name)
{
  Class super_class;
  id pool = [[NSAutoreleasePool alloc] init];

  class_name = rb_obj_as_string(class_name);
  super_name = rb_obj_as_string(super_name);
  super_class = NSClassFromString([NSString 
				    stringWithCString: STR2CSTR(super_name)]);
  if (super_class)
    RBOCDerivedClassNew(STR2CSTR(class_name), super_class);
  [pool release];
  return Qnil;
}

// def OSX.objc_derived_class_method_add (class_name, method_name)
// ex1.  OSX.objc_derived_class_method_add (:CustomView, "drawRect:")
static VALUE
osx_mf_objc_derived_class_method_add(VALUE mdl, VALUE class_name, VALUE method_name)
{
  Class a_class;
  SEL a_sel;
  id pool = [[NSAutoreleasePool alloc] init];

  class_name = rb_obj_as_string(class_name);
  method_name = rb_obj_as_string(method_name);
  a_class = 
    NSClassFromString([NSString stringWithCString: STR2CSTR(class_name)]);
  a_sel =
    NSSelectorFromString([NSString stringWithCString: STR2CSTR(method_name)]);
  if (a_class && a_sel) {
    [a_class addRubyMethod: a_sel];
  }
  [pool release];
  return Qnil;
}


void Init_osxobjc()
{
  VALUE mOSX, cOCObject;
  extern void init_cocoa(VALUE);

  mOSX = init_module_OSX();
  init_class_OCObject(mOSX);

  rb_define_module_function(mOSX, "objc_proxy_class_new", 
			    osx_mf_objc_proxy_class_new, 1);
  rb_define_module_function(mOSX, "objc_derived_class_new", 
			    osx_mf_objc_derived_class_new, 2);
  rb_define_module_function(mOSX, "objc_derived_class_method_add",
			    osx_mf_objc_derived_class_method_add, 2);

  init_cocoa(mOSX);
}
