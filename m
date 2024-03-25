Return-Path: <linux-pci+bounces-5132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511E88B495
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 23:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C007D1F3DCE5
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 22:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87987FBDB;
	Mon, 25 Mar 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzpgxMWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DFB6E2AB;
	Mon, 25 Mar 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407467; cv=none; b=h5eiP/rThgO25nmrA3h7Wl47dIuxI/s1wgZDWf1h8zqwPRCw4kHpOacmEmFGquRzfRxNaHMefAo3lUhTP3SNyzSaZiAIeMG8q3wlGdlJ+ooTTcNXCp83zF8X204mYd3Pxqv6HFzUhVBnQNEBWXC+TNvRazK1Ph1qGcz7QeA6ybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407467; c=relaxed/simple;
	bh=XI2t2jo9o+wsz6b5gBsR5OP8VWlf5kU9qzxkADoRJws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDoKoSgWkYPO3Lg8L27pA6mPKeMqmbH1QOxxPUKhsdg1su3THBkMYKLKQsAqI9B5wlqO0Njh8esKkNsboPFU9s5uLsUQYuncm2c6eKQHGGqB5j8nPUHi7X0whOoJRWuSUPbItIOHm2n4Ryl6x2Iyj8EF75b6TnqpgWUQWw4gcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzpgxMWW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711407465; x=1742943465;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XI2t2jo9o+wsz6b5gBsR5OP8VWlf5kU9qzxkADoRJws=;
  b=BzpgxMWWU+0KxEyCWXF6/++BSd9fsiL4KyE2VKVU5v4HJiZK77n6rG4H
   zzS7hHbKGqIhHntOMYw4Tsod81dJZ3Z/ewF1DF7ut3AjpyX6/Sq6/rUjM
   PMc5M37rbF1abS3zdIbhGOEZ+15eO0FD2G/LAKGMXqKN6a/hC7ntFAA3c
   JpMWtdk0ULGKtEuu5ZknDYYDoRgZDBAd2gQgHLuFA51wQUOsEYILxcY+r
   uwq53do5p+Y5HYM3Dj11raqlxQbFPb6qDV0LQhd8ZWc2F5HniVO8rOq86
   YuYYdUZpd4iLhh0UgYX0zhUfDDphI1bM8gjqPO3CoV1J2OlGa9xF27LiT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="16980397"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="16980397"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 15:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15853427"
Received: from sbista-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.58.57])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 15:57:43 -0700
Subject: [PATCH v2] cleanup: Add usage and style documentation
From: Dan Williams <dan.j.williams@intel.com>
To: peterz@infradead.org, torvalds@linux-foundation.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Ilpo =?utf-8?b?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-doc@vger.kernel.org
Date: Mon, 25 Mar 2024 15:57:42 -0700
Message-ID: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
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
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1:
* drop RST markup for C-syntax highlighting in examples, use the simpler
  "::" annotation (Peter, Lukas, Jon)
* fixup ordering of core-api sections (Matthew)
* describe ordering as LIFO (Bjorn)
* wait to talk about DEFINE_GUARD() until after DEFINE_FREE() section
  (Bjorn)
* clarify the "definition order matters" concern (Bjorn)
* drop statistics for goto patterns in source, "TMI" (Bjorn)
* include example of order dependent cleanups helpers (Kevin, Bjorn)

 Documentation/core-api/cleanup.rst |    8 ++
 Documentation/core-api/index.rst   |    1 
 include/linux/cleanup.h            |  151 ++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
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
index c2d09bc4f976..8ef2d91c2cbf 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -4,6 +4,157 @@
 
 #include <linux/compiler.h>
 
+/**
+ * DOC: scope-based cleanup helpers
+ *
+ * The "goto error" pattern is notorious for introducing subtle resource
+ * leaks. It is tedious and error prone to add new resource acquisition
+ * constraints into code paths that already have several unwind
+ * conditions. The "cleanup" helpers enable the compiler to help with
+ * this tedium and can aid in maintaining FILO (first in last out)
+ * unwind ordering to avoid unintentional leaks.
+ *
+ * As drivers make up the majority of the kernel code base, here is an
+ * example of using these helpers to clean up PCI drivers. The target of
+ * the cleanups are occasions where a goto is used to unwind a device
+ * reference (pci_dev_put()), or unlock the device (pci_dev_unlock())
+ * before returning.
+ *
+ * The DEFINE_FREE() macro can arrange for PCI device references to be
+ * dropped when the associated variable goes out of scope:
+ *
+ * ::
+ *
+ *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
+ *	...
+ *	struct pci_dev *dev __free(pci_dev_put) =
+ *		pci_get_slot(parent, PCI_DEVFN(0, 0));
+ *
+ * The above will automatically call pci_dev_put() if @dev is non-NULL
+ * when @dev goes out of scope (automatic variable scope). If a function
+ * wants to invoke pci_dev_put() on error, but return @dev (i.e. without
+ * freeing it) on success, it can do:
+ *
+ * ::
+ *
+ *	return no_free_ptr(dev);
+ *
+ * ...or:
+ *
+ * ::
+ *
+ *	return_ptr(dev);
+ *
+ * The DEFINE_GUARD() macro can arrange for the PCI device lock to be
+ * dropped when the scope where guard() is invoked ends:
+ *
+ * ::
+ *
+ *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+ *	...
+ *	guard(pci_dev)(dev);
+ *
+ *
+ * The lifetime of the lock obtained by the guard() helper follows the
+ * scope of automatic variable declaration. Take the following example:
+ *
+ * ::
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
+ * following example and notice the bug highlighted by "!!":
+ *
+ * ::
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
+ *	        obj = kfree(sizeof(*obj), GFP_KERNEL);
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
+ * initialize @obj in this order:
+ *
+ * ::
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


