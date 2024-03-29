Return-Path: <linux-pci+bounces-5429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2C8927E3
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 00:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F94CB22803
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5F53379;
	Fri, 29 Mar 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhiK0DU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD61D699;
	Fri, 29 Mar 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756132; cv=none; b=SF4m3CYNO1OZD12jmQXNicFoc7BeoROnLm7qAFNHpo35LKqi80WPG6FB00lpmPeP4fztY53O56q5oCScnhf9sYF08QWP6MWIPkceWSN5dtzms9KtBrwZWfTrh6kVU1cFHzpq9OVwDr+LcuJdUNaaajBHC/ZbeWsVgvj7B9xbStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756132; c=relaxed/simple;
	bh=rRbRBbINrELqiLSrluBakz7n766c7cLHG1AUcbdMyjQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wqn7MLGS9dFSujvURbjcqRWd4D5jsVc3OPUKvbCG9oXQldciHWEJJcuoQD2TLzDYwk5O8zcVdIIW1k9hhH82qlJrX6ZRPPlYQOHRSbfp91annZ7lWkbbEIwIHJXqumAWbBGV0AlWESIqaCtS9X0/0p0zXhV9e0QPhLeoEDS30ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhiK0DU8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711756130; x=1743292130;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRbRBbINrELqiLSrluBakz7n766c7cLHG1AUcbdMyjQ=;
  b=AhiK0DU8hEjeAQ3qQPDbI61KOdAEaYIklXLoxGog/s66YANpJ0yKatIa
   7JAQIveX8Ib0eF6PUQ/vosHplJ5lWLSQ9ge69gPhtJJ6yXKxRt21hq6ow
   gGYcgesEPAKC5G5jcSj65AE6zphuHciIpRZ2mSKOOiMSkpjvx2jH93YbX
   Crgp6mGzL15uIHd8/aqU9ZjdmO0bEfjCkG4KHZG1Nc5WmBAhiHa9L8fy0
   ELqrPPIsjdmCli2W5MrkAKibJK/K3sG4etyj84qTGKywalvYmuErPXGRd
   lfjY+5HzBuq2fPGJfjsgWhk1Sx30UpqxmA/B8WG6nO2YdL4S5OPIWYY7R
   Q==;
X-CSE-ConnectionGUID: Gv/oeJWdSha8r+tUKCXzHQ==
X-CSE-MsgGUID: dZmZO9beQreQyD1eRO1ctw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="9906945"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="9906945"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 16:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17000663"
Received: from mduggina-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.100.140])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 16:48:48 -0700
Subject: [PATCH v3] cleanup: Add usage and style documentation
From: Dan Williams <dan.j.williams@intel.com>
To: peterz@infradead.org, torvalds@linux-foundation.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Ilpo =?utf-8?b?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 29 Mar 2024 16:48:48 -0700
Message-ID: <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
References: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When proposing that PCI grow some new cleanup helpers for pci_dev_put()
and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
about expectations and best practices. Upon reviewing an updated
changelog with those details he recommended adding them to documentation
in the header file itself.

Add that documentation and link it into the rendering for
Documentation/core-api/.

Link: http://lore.kernel.org/r/20240104183218.GA1820872@bhelgaas [1]
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2:
* remove the unnecessary newlines around code examples further reducing
  the visual interruption of RST metadata (Jon)
* Fix a missing FILO=>LIFO conversion
* Fix a bug in the example
* Collect Jonathan's reviewed-by

Review has been quiet on this thread for a few days so I think is the
final rev. Let me know if anything else to fix up.

 Documentation/core-api/cleanup.rst |    8 ++
 Documentation/core-api/index.rst   |    1 
 include/linux/cleanup.h            |  136 ++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 Documentation/core-api/cleanup.rst

diff --git a/Documentation/core-api/cleanup.rst b/Documentation/core-api/cleanup.rst
new file mode 100644
index 000000000000..527eb2f8ec6e
--- /dev/null
+++ b/Documentation/core-api/cleanup.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Scope-based Cleanup Helpers
+===========================
+
+.. kernel-doc:: include/linux/cleanup.h
+   :doc: scope-based cleanup helpers
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a3a08d81f11..2d2b3719567e 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -35,6 +35,7 @@ Library functionality that is used throughout the kernel.
 
    kobject
    kref
+   cleanup
    assoc_array
    xarray
    maple_tree
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..5ffb2127e3ac 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -4,6 +4,142 @@
 
 #include <linux/compiler.h>
 
+/**
+ * DOC: scope-based cleanup helpers
+ *
+ * The "goto error" pattern is notorious for introducing subtle resource
+ * leaks. It is tedious and error prone to add new resource acquisition
+ * constraints into code paths that already have several unwind
+ * conditions. The "cleanup" helpers enable the compiler to help with
+ * this tedium and can aid in maintaining LIFO (last in first out)
+ * unwind ordering to avoid unintentional leaks.
+ *
+ * As drivers make up the majority of the kernel code base, here is an
+ * example of using these helpers to clean up PCI drivers. The target of
+ * the cleanups are occasions where a goto is used to unwind a device
+ * reference (pci_dev_put()), or unlock the device (pci_dev_unlock())
+ * before returning.
+ *
+ * The DEFINE_FREE() macro can arrange for PCI device references to be
+ * dropped when the associated variable goes out of scope::
+ *
+ *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
+ *	...
+ *	struct pci_dev *dev __free(pci_dev_put) =
+ *		pci_get_slot(parent, PCI_DEVFN(0, 0));
+ *
+ * The above will automatically call pci_dev_put() if @dev is non-NULL
+ * when @dev goes out of scope (automatic variable scope). If a function
+ * wants to invoke pci_dev_put() on error, but return @dev (i.e. without
+ * freeing it) on success, it can do::
+ *
+ *	return no_free_ptr(dev);
+ *
+ * ...or::
+ *
+ *	return_ptr(dev);
+ *
+ * The DEFINE_GUARD() macro can arrange for the PCI device lock to be
+ * dropped when the scope where guard() is invoked ends::
+ *
+ *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+ *	...
+ *	guard(pci_dev)(dev);
+ *
+ * The lifetime of the lock obtained by the guard() helper follows the
+ * scope of automatic variable declaration. Take the following example::
+ *
+ *	func(...)
+ *	{
+ *		if (...) {
+ *			...
+ *			guard(pci_dev)(dev); // pci_dev_lock() invoked here
+ *			...
+ *		} // <- implied pci_dev_unlock() triggered here
+ *	}
+ *
+ * Observe the lock is held for the remainder of the "if ()" block not
+ * the remainder of "func()".
+ *
+ * Now, when a function uses both __free() and guard(), or multiple
+ * instances of __free(), the LIFO order of variable definition order
+ * matters. GCC documentation says:
+ *
+ * "When multiple variables in the same scope have cleanup attributes,
+ * at exit from the scope their associated cleanup functions are run in
+ * reverse order of definition (last defined, first cleanup)."
+ *
+ * When the unwind order matters it requires that variables be defined
+ * mid-function scope rather than at the top of the file.  Take the
+ * following example and notice the bug highlighted by "!!"::
+ *
+ *	LIST_HEAD(list);
+ *	DEFINE_MUTEX(lock);
+ *
+ *	struct object {
+ *	        struct list_head node;
+ *	};
+ *
+ *	static struct object *alloc_add(void)
+ *	{
+ *	        struct object *obj;
+ *
+ *	        lockdep_assert_held(&lock);
+ *	        obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+ *	        if (obj) {
+ *	                LIST_HEAD_INIT(&obj->node);
+ *	                list_add(obj->node, &list):
+ *	        }
+ *	        return obj;
+ *	}
+ *
+ *	static void remove_free(struct object *obj)
+ *	{
+ *	        lockdep_assert_held(&lock);
+ *	        list_del(&obj->node);
+ *	        kfree(obj);
+ *	}
+ *
+ *	DEFINE_FREE(remove_free, struct object *, if (_T) remove_free(_T))
+ *	static int init(void)
+ *	{
+ *	        struct object *obj __free(remove_free) = NULL;
+ *	        int err;
+ *
+ *	        guard(mutex)(&lock);
+ *	        obj = alloc_add();
+ *
+ *	        if (!obj)
+ *	                return -ENOMEM;
+ *
+ *	        err = other_init(obj);
+ *	        if (err)
+ *	                return err; // remove_free() called without the lock!!
+ *
+ *	        no_free_ptr(obj);
+ *	        return 0;
+ *	}
+ *
+ * That bug is fixed by changing init() to call guard() and define +
+ * initialize @obj in this order::
+ *
+ *	guard(mutex)(&lock);
+ *	struct object *obj __free(remove_free) = alloc_add();
+ *
+ * Given that the "__free(...) = NULL" pattern for variables defined at
+ * the top of the function poses this potential interdependency problem
+ * the recommendation is to always define and assign variables in one
+ * statement and not group variable definitions at the top of the
+ * function when __free() is used.
+ *
+ * Lastly, given that the benefit of cleanup helpers is removal of
+ * "goto", and that the "goto" statement can jump between scopes, the
+ * expectation is that usage of "goto" and cleanup helpers is never
+ * mixed in the same function. I.e. for a given routine, convert all
+ * resources that need a "goto" cleanup to scope-based cleanup, or
+ * convert none of them.
+ */
+
 /*
  * DEFINE_FREE(name, type, free):
  *	simple helper macro that defines the required wrapper for a __free()


