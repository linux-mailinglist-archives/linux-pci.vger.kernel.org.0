Return-Path: <linux-pci+bounces-4966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A02881956
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 23:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6144E1C2102A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 22:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC285C46;
	Wed, 20 Mar 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RusWDa4P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4092CA6;
	Wed, 20 Mar 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972289; cv=none; b=S0u+j9uzfdymzL/5ANgiZX4ffsDeG74L0HIKfgn9NtnwR11wvdfrgv4YzJsKcpWnd7h/rN5G4zGLjWaNGg4oeegCoGpC631/doAcR5Na8kE2/PYF3wcpSe7+CWEmwvINLQclV3RRqPfzw9Auv7ZGC7zI0bIOxLyqmPbRSpvFFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972289; c=relaxed/simple;
	bh=rQSedZF7x5w5CBcWQj3ApLjCKzMLnQMFwdN5vVIHFxg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Od6DV6y8yx7GFq+8Gv94MInIWxiyA0Y5jn5qxpuqevS5s/Z9cpllTkYNMeKJt9qK6HLjESfXeIlJ9BfzTHZDWdkbQFbdBPAtiEqHUQDvlTMTptvwGGaECglrY+KBoKDExj4jLAmk2WDw19PXJTTXHx8bsaIejrm9G6hShUHGf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RusWDa4P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710972282; x=1742508282;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rQSedZF7x5w5CBcWQj3ApLjCKzMLnQMFwdN5vVIHFxg=;
  b=RusWDa4PBBNDzpD6mNTwgATAuC0HHCEv4y4+OHw80Sz1/M1olG0qqFJe
   Wlf9xhLlAEaiSfx8lEur58EDWXEwUsSMVBMNS7mKZXktBSyPF+wjsptyO
   WtDgUI9i6tQJDuRQo3t6EdUp6CDKYH8Gcld93ACPVMkRdHPtY078Qf0TD
   k0I3cx7gNgoWuRoBn+MwaynJ6rX4bC5hYrGvKyBUDkxDg8vXmzHFJM/hd
   HVUsD+nxrJfKmA+808+JEYx2mY28SF/gFHLlTYiNRMiKqWcKRSskEXfyd
   VWn84Z1dU6ZRYBmmulDvxgMcFgqKFgXk6bBNydnvmBoca0BGUrO648i8o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5799992"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5799992"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 15:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14686157"
Received: from sunkaras-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.79.95])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 15:04:41 -0700
Subject: [PATCH] cleanup: Add usage and style documentation
From: Dan Williams <dan.j.williams@intel.com>
To: peterz@infradead.org, torvalds@linux-foundation.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Ilpo =?utf-8?b?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas.wunner@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-doc@vger.kernel.org
Date: Wed, 20 Mar 2024 15:04:41 -0700
Message-ID: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
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
Cc: Lukas Wunner <lukas.wunner@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Peter, Linus,

I am starting to see more usage of the cleanup helpers and some
style confusion or misunderstanding on best practices on how to use
them. As I mention above, Bjorn found the writeup I did for justifying
__free(pci_dev_put) and guard(pci_dev) useful, so here is an attempt to
uplevel and centralize those notes.

Linus, I include you directly since you have expressed some opinions on
how these helpers are used and want to capture that in a central
location.

This patch stops short of updating coding-style or checkpatch, but I
expect that it can later be used as a reference for that work.

 Documentation/core-api/cleanup.rst |    8 +++
 Documentation/core-api/index.rst   |    1 
 include/linux/cleanup.h            |  112 ++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
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
index 7a3a08d81f11..845fbd54948f 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -36,6 +36,7 @@ Library functionality that is used throughout the kernel.
    kobject
    kref
    assoc_array
+   cleanup
    xarray
    maple_tree
    idr
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..4620a475faee 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -4,6 +4,118 @@
 
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
+ * As drivers make up the majority of the kernel code base lets describe
+ * the Theory of Operation, Coding Style implications, and motivation
+ * for using these helpers through the example of cleaning up PCI
+ * drivers with DEFINE_FREE() and DEFINE_GUARD(), e.g.:
+ *
+ * .. code-block:: c
+ *
+ *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
+ *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+ *
+ * The DEFINE_FREE(pci_dev_put, ...) definition allows for declaring
+ * variables like this:
+ *
+ * .. code-block:: c
+ *
+ *	struct pci_dev *dev __free(pci_dev_put) =
+ *		pci_get_slot(parent, PCI_DEVFN(0, 0));
+ *
+ * The above will automatically call pci_dev_put() if @pdev is non-NULL
+ * when @pdev goes out of scope (automatic variable scope). If a
+ * function wants to invoke pci_dev_put() on error, but return @pdev
+ * (i.e. without freeing it) on success, it can do:
+ *
+ * .. code-block:: c
+ *
+ *	return no_free_ptr(pdev);
+ *
+ * ...or:
+ *
+ * .. code-block:: c
+ *
+ *	return_ptr(pdev);
+ *
+ * Note that unwind order is dictated by declaration order. That
+ * contraindicates a pattern like the following:
+ *
+ * .. code-block:: c
+ *
+ *	int num, ret = 0;
+ *	struct pci_dev *bridge = ctrl->pcie->port;
+ *	struct pci_bus *parent = bridge->subordinate;
+ *	struct pci_dev *dev __free(pci_dev_put) = NULL;
+ *
+ *	pci_lock_rescan_remove();
+ *
+ *	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
+ *
+ * In this case @dev is declared in x-mas tree style in a preamble
+ * declaration block. That is problematic because it destroys the
+ * compiler's ability to infer proper unwind order. If other cleanup
+ * helpers appeared in such a function that depended on @dev being live
+ * to complete their unwind then using the "struct obj_type *obj
+ * __free(...) = NULL" style is an anti-pattern that potentially causes
+ * a use-after-free bug. Instead, the expectation is this conversion:
+ *
+ * .. code-block:: c
+ *
+ *	int num, ret = 0;
+ *	struct pci_dev *bridge = ctrl->pcie->port;
+ *	struct pci_bus *parent = bridge->subordinate;
+ *
+ *	pci_lock_rescan_remove();
+ *
+ *	struct pci_dev *dev __free(pci_dev_put) =
+ *		pci_get_slot(parent, PCI_DEVFN(0, 0));
+ *
+ * ...which implies that declaring variables in mid-function scope is
+ * not only allowed, but expected.
+ *
+ * The motivation for deploying DEFINE_FREE(pci_dev_put, ...) is that at
+ * the time of writing of this documentation there are ~590 instances of
+ * pci_dev_put(), ~70 of them with 10 lines of a goto implying that a
+ * significant number of gotos might be cleaned up for incremental
+ * maintenance burden relief.
+ *
+ * The guard() helper holds the associated lock for the remainder of the
+ * current scope in which it was invoked. So, for example:
+ *
+ * .. code-block:: c
+ *
+ *	func(...)
+ *	{
+ *		if (...) {
+ *			...
+ *			guard(pci_dev); // pci_dev_lock() invoked here
+ *			...
+ *		} // <- implied pci_dev_unlock() triggered here
+ *	}
+ *
+ * ...in other words, the lock is held for the remainder of the current
+ * scope not the remainder of "func()".
+ *
+ * At the time of writing there are 15 invocations of pci_dev_unlock() in
+ * the kernel with 5 within 10 lines of a goto.
+ *
+ * Conversions of existing code to use cleanup helpers should convert
+ * all resources so that no "goto" unwind statements remain. If not all
+ * resources are amenable to cleanup then additional refactoring is
+ * needed to build helper functions, or the function is simply not a
+ * good candidate for conversion.
+ */
+
 /*
  * DEFINE_FREE(name, type, free):
  *	simple helper macro that defines the required wrapper for a __free()


