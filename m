Return-Path: <linux-pci+bounces-39015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288DBFC324
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 329C450405C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E6307ACE;
	Wed, 22 Oct 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYiOVAD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2D346E6D;
	Wed, 22 Oct 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140042; cv=none; b=oWucMRXrCladU1rYnuo8GFFmYKBz9pNSl0iqxZ0IvEE5ehoSUChVs2ru+e5a8jIj0/4hUJUedkXEtRunzLzGIP+VIkGj5kNk37rVqOdw75jbtjE4Ag9vAgLBIXtRjzulrekxYjQmKW4jTn2UYJiQjSUEcu99D1TcT4SO+fMjg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140042; c=relaxed/simple;
	bh=jU+vf5SQlVP4Swy33SeL2FgxRbN1I73BEiRw5Xyp7K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeSAW28rF3tzs+fmd57B128AuM4VXfwghU5QxXVF+5LkBbu/F2IkvO1yogy9fWgZURZtHgMzOnI1kVmwYhHrMCid/GV3G4Qjvnblv6ezF1ceJMKtoANoJhaE8WPtgZo5nPPq+DSIKAIQGCoDB/sEu76zSZf1GzVUourOpLqCaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYiOVAD5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761140040; x=1792676040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jU+vf5SQlVP4Swy33SeL2FgxRbN1I73BEiRw5Xyp7K0=;
  b=kYiOVAD5B09VT+W6PoLvxLuDJf05nUPZXvRKSvwFO2nSv4hrVbygE7Js
   Re2yjIsqs2PMPSbfvVHW7uQN8F6njDoK3V6B6wEh0poFJRjv9imE0ylEM
   BaM5s/ZCC+qmMqDpAmNZYmXwPC3XU37xT7y4h3unqmOp1lBbm78gsMy8p
   Crkli2tAnef9naN/Lxxxg9KHbZCUGuB757Yo98K9zni85a3pCjGsuBXMW
   /ckfM9C7SFLAjBKd+tZhQJ19BmgvvdoQ6RoQbbZJg2ciP3YlBhUj4xLWA
   9WLLd9U+89Tcbt6cmus2AFPsuvmXJYnX+lJFBWLk7R1JCZBB7Eg2xEpFk
   A==;
X-CSE-ConnectionGUID: q52bsIHOSjyZVcJfxOg9Wg==
X-CSE-MsgGUID: //jfwOUbQjaZi0vd66GFCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63435370"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63435370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:33:59 -0700
X-CSE-ConnectionGUID: BZUblLzJRGKkNt+NAKyQvw==
X-CSE-MsgGUID: SHmZXGgBSg6Qjmz6LZ/SJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183045441"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 06:33:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	"Michael J . Ruhl" <mjruhl@habana.ai>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 01/11] PCI: Move Resizable BAR code into rebar.c
Date: Wed, 22 Oct 2025 16:33:21 +0300
Message-Id: <20251022133331.4357-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
References: <20251022133331.4357-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the lack of better place to put it, Resizable BAR code has been
placed inside pci.c and setup-res.c that do not use it for anything.
Upcoming changes are going to add more Resizable BAR related API
functions to PCI core increasing the Resizable BAR code size from the
current.

As pci.c is huge file as is, extract the Resizable BAR related code out
of it into rebar.c and move the actual BAR resize code from setup-res.c
as well.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 Documentation/driver-api/pci/pci.rst |   3 +
 drivers/pci/Makefile                 |   2 +-
 drivers/pci/pci.c                    | 145 ----------------
 drivers/pci/pci.h                    |   1 +
 drivers/pci/rebar.c                  | 236 +++++++++++++++++++++++++++
 drivers/pci/setup-res.c              |  78 ---------
 6 files changed, 241 insertions(+), 224 deletions(-)
 create mode 100644 drivers/pci/rebar.c

diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/pci/pci.rst
index 59d86e827198..99a1bbaaec5d 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -37,6 +37,9 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/slot.c
    :export:
 
+.. kernel-doc:: drivers/pci/rebar.c
+   :export:
+
 .. kernel-doc:: drivers/pci/rom.c
    :export:
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..f3c81c892786 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
-				   rom.o setup-res.o irq.o vpd.o \
+				   rebar.o rom.o setup-res.o irq.o vpd.o \
 				   setup-bus.o vc.o mmap.o devres.o
 
 obj-$(CONFIG_PCI)		+= msi/
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..aedf6a9932ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1823,32 +1823,6 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	}
 }
 
-static void pci_restore_rebar_state(struct pci_dev *pdev)
-{
-	unsigned int pos, nbars, i;
-	u32 ctrl;
-
-	pos = pdev->rebar_cap;
-	if (!pos)
-		return;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
-
-	for (i = 0; i < nbars; i++, pos += 8) {
-		struct resource *res;
-		int bar_idx, size;
-
-		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
-		res = pci_resource_n(pdev, bar_idx);
-		size = pci_rebar_bytes_to_size(resource_size(res));
-		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
-		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
-	}
-}
-
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with
@@ -3687,125 +3661,6 @@ void pci_acs_init(struct pci_dev *dev)
 	pci_enable_acs(dev);
 }
 
-void pci_rebar_init(struct pci_dev *pdev)
-{
-	pdev->rebar_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
-}
-
-/**
- * pci_rebar_find_pos - find position of resize ctrl reg for BAR
- * @pdev: PCI device
- * @bar: BAR to find
- *
- * Helper to find the position of the ctrl register for a BAR.
- * Returns -ENOTSUPP if resizable BARs are not supported at all.
- * Returns -ENOENT if no ctrl register for the BAR could be found.
- */
-static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
-{
-	unsigned int pos, nbars, i;
-	u32 ctrl;
-
-	if (pci_resource_is_iov(bar)) {
-		pos = pci_iov_vf_rebar_cap(pdev);
-		bar = pci_resource_num_to_vf_bar(bar);
-	} else {
-		pos = pdev->rebar_cap;
-	}
-
-	if (!pos)
-		return -ENOTSUPP;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
-
-	for (i = 0; i < nbars; i++, pos += 8) {
-		int bar_idx;
-
-		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-		bar_idx = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, ctrl);
-		if (bar_idx == bar)
-			return pos;
-	}
-
-	return -ENOENT;
-}
-
-/**
- * pci_rebar_get_possible_sizes - get possible sizes for BAR
- * @pdev: PCI device
- * @bar: BAR to query
- *
- * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
- */
-u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
-{
-	int pos;
-	u32 cap;
-
-	pos = pci_rebar_find_pos(pdev, bar);
-	if (pos < 0)
-		return 0;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
-	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
-
-	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
-	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
-	    bar == 0 && cap == 0x700)
-		return 0x3f00;
-
-	return cap;
-}
-EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
-
-/**
- * pci_rebar_get_current_size - get the current size of a BAR
- * @pdev: PCI device
- * @bar: BAR to set size to
- *
- * Read the size of a BAR from the resizable BAR config.
- * Returns size if found or negative error code.
- */
-int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
-{
-	int pos;
-	u32 ctrl;
-
-	pos = pci_rebar_find_pos(pdev, bar);
-	if (pos < 0)
-		return pos;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	return FIELD_GET(PCI_REBAR_CTRL_BAR_SIZE, ctrl);
-}
-
-/**
- * pci_rebar_set_size - set a new size for a BAR
- * @pdev: PCI device
- * @bar: BAR to set size to
- * @size: new size as defined in the spec (0=1MB, 31=128TB)
- *
- * Set the new size of a BAR as defined in the spec.
- * Returns zero if resizing was successful, error code otherwise.
- */
-int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
-{
-	int pos;
-	u32 ctrl;
-
-	pos = pci_rebar_find_pos(pdev, bar);
-	if (pos < 0)
-		return pos;
-
-	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-	ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
-	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
-	return 0;
-}
-
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..fffd0a0cc803 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1020,6 +1020,7 @@ static inline int acpi_get_rc_resources(struct device *dev, const char *hid,
 #endif
 
 void pci_rebar_init(struct pci_dev *pdev);
+void pci_restore_rebar_state(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
 static inline u64 pci_rebar_size_to_bytes(int size)
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
new file mode 100644
index 000000000000..8deee5bb33fa
--- /dev/null
+++ b/drivers/pci/rebar.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Resizable BAR Extended Capability handling.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "pci.h"
+
+void pci_rebar_init(struct pci_dev *pdev)
+{
+	pdev->rebar_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+}
+
+/**
+ * pci_rebar_find_pos - find position of resize ctrl reg for BAR
+ * @pdev: PCI device
+ * @bar: BAR to find
+ *
+ * Helper to find the position of the ctrl register for a BAR.
+ * Returns -ENOTSUPP if resizable BARs are not supported at all.
+ * Returns -ENOENT if no ctrl register for the BAR could be found.
+ */
+static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	if (pci_resource_is_iov(bar)) {
+		pos = pci_iov_vf_rebar_cap(pdev);
+		bar = pci_resource_num_to_vf_bar(bar);
+	} else {
+		pos = pdev->rebar_cap;
+	}
+
+	if (!pos)
+		return -ENOTSUPP;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		int bar_idx;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, ctrl);
+		if (bar_idx == bar)
+			return pos;
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * pci_rebar_get_possible_sizes - get possible sizes for BAR
+ * @pdev: PCI device
+ * @bar: BAR to query
+ *
+ * Get the possible sizes of a resizable BAR as bitmask defined in the spec
+ * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
+ */
+u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
+{
+	int pos;
+	u32 cap;
+
+	pos = pci_rebar_find_pos(pdev, bar);
+	if (pos < 0)
+		return 0;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
+	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
+
+	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
+	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
+	    bar == 0 && cap == 0x700)
+		return 0x3f00;
+
+	return cap;
+}
+EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
+
+/**
+ * pci_rebar_get_current_size - get the current size of a BAR
+ * @pdev: PCI device
+ * @bar: BAR to set size to
+ *
+ * Read the size of a BAR from the resizable BAR config.
+ * Returns size if found or negative error code.
+ */
+int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
+{
+	int pos;
+	u32 ctrl;
+
+	pos = pci_rebar_find_pos(pdev, bar);
+	if (pos < 0)
+		return pos;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	return FIELD_GET(PCI_REBAR_CTRL_BAR_SIZE, ctrl);
+}
+
+/**
+ * pci_rebar_set_size - set a new size for a BAR
+ * @pdev: PCI device
+ * @bar: BAR to set size to
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ *
+ * Set the new size of a BAR as defined in the spec.
+ * Returns zero if resizing was successful, error code otherwise.
+ */
+int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
+{
+	int pos;
+	u32 ctrl;
+
+	pos = pci_rebar_find_pos(pdev, bar);
+	if (pos < 0)
+		return pos;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+	ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	return 0;
+}
+
+void pci_restore_rebar_state(struct pci_dev *pdev)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	pos = pdev->rebar_cap;
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		struct resource *res;
+		int bar_idx, size;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		res = pci_resource_n(pdev, bar_idx);
+		size = pci_rebar_bytes_to_size(resource_size(res));
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+}
+
+static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev,
+						  int resno)
+{
+	u16 cmd;
+
+	if (pci_resource_is_iov(resno))
+		return pci_iov_is_memory_decoding_enabled(dev);
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	return cmd & PCI_COMMAND_MEMORY;
+}
+
+static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
+					 int size)
+{
+	resource_size_t res_size = pci_rebar_size_to_bytes(size);
+	struct resource *res = pci_resource_n(dev, resno);
+
+	if (!pci_resource_is_iov(resno)) {
+		resource_set_size(res, res_size);
+	} else {
+		resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));
+		pci_iov_resource_set_size(dev, resno, res_size);
+	}
+}
+
+int pci_resize_resource(struct pci_dev *dev, int resno, int size)
+{
+	struct resource *res = pci_resource_n(dev, resno);
+	struct pci_host_bridge *host;
+	int old, ret;
+	u32 sizes;
+
+	/* Check if we must preserve the firmware's resource assignment */
+	host = pci_find_host_bridge(dev->bus);
+	if (host->preserve_config)
+		return -ENOTSUPP;
+
+	/* Make sure the resource isn't assigned before resizing it. */
+	if (!(res->flags & IORESOURCE_UNSET))
+		return -EBUSY;
+
+	if (pci_resize_is_memory_decoding_enabled(dev, resno))
+		return -EBUSY;
+
+	sizes = pci_rebar_get_possible_sizes(dev, resno);
+	if (!sizes)
+		return -ENOTSUPP;
+
+	if (!(sizes & BIT(size)))
+		return -EINVAL;
+
+	old = pci_rebar_get_current_size(dev, resno);
+	if (old < 0)
+		return old;
+
+	ret = pci_rebar_set_size(dev, resno, size);
+	if (ret)
+		return ret;
+
+	pci_resize_resource_set_size(dev, resno, size);
+
+	/* Check if the new config works by trying to assign everything. */
+	if (dev->bus->self) {
+		ret = pbus_reassign_bridge_resources(dev->bus, res);
+		if (ret)
+			goto error_resize;
+	}
+	return 0;
+
+error_resize:
+	pci_rebar_set_size(dev, resno, old);
+	pci_resize_resource_set_size(dev, resno, old);
+	return ret;
+}
+EXPORT_SYMBOL(pci_resize_resource);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c3ba4ccecd43..e5fcadfc58b0 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -431,84 +431,6 @@ int pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
-static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev,
-						  int resno)
-{
-	u16 cmd;
-
-	if (pci_resource_is_iov(resno))
-		return pci_iov_is_memory_decoding_enabled(dev);
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-
-	return cmd & PCI_COMMAND_MEMORY;
-}
-
-static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
-					 int size)
-{
-	resource_size_t res_size = pci_rebar_size_to_bytes(size);
-	struct resource *res = pci_resource_n(dev, resno);
-
-	if (!pci_resource_is_iov(resno)) {
-		resource_set_size(res, res_size);
-	} else {
-		resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));
-		pci_iov_resource_set_size(dev, resno, res_size);
-	}
-}
-
-int pci_resize_resource(struct pci_dev *dev, int resno, int size)
-{
-	struct resource *res = pci_resource_n(dev, resno);
-	struct pci_host_bridge *host;
-	int old, ret;
-	u32 sizes;
-
-	/* Check if we must preserve the firmware's resource assignment */
-	host = pci_find_host_bridge(dev->bus);
-	if (host->preserve_config)
-		return -ENOTSUPP;
-
-	/* Make sure the resource isn't assigned before resizing it. */
-	if (!(res->flags & IORESOURCE_UNSET))
-		return -EBUSY;
-
-	if (pci_resize_is_memory_decoding_enabled(dev, resno))
-		return -EBUSY;
-
-	sizes = pci_rebar_get_possible_sizes(dev, resno);
-	if (!sizes)
-		return -ENOTSUPP;
-
-	if (!(sizes & BIT(size)))
-		return -EINVAL;
-
-	old = pci_rebar_get_current_size(dev, resno);
-	if (old < 0)
-		return old;
-
-	ret = pci_rebar_set_size(dev, resno, size);
-	if (ret)
-		return ret;
-
-	pci_resize_resource_set_size(dev, resno, size);
-
-	/* Check if the new config works by trying to assign everything. */
-	if (dev->bus->self) {
-		ret = pbus_reassign_bridge_resources(dev->bus, res);
-		if (ret)
-			goto error_resize;
-	}
-	return 0;
-
-error_resize:
-	pci_rebar_set_size(dev, resno, old);
-	pci_resize_resource_set_size(dev, resno, old);
-	return ret;
-}
-EXPORT_SYMBOL(pci_resize_resource);
-
 int pci_enable_resources(struct pci_dev *dev, int mask)
 {
 	u16 cmd, old_cmd;
-- 
2.39.5


