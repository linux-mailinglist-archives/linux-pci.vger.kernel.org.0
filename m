Return-Path: <linux-pci+bounces-41149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19EC59617
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEC625020BC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44D2EFD9F;
	Thu, 13 Nov 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIkh1geG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440329BD95;
	Thu, 13 Nov 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056885; cv=none; b=B4tftptj1b013z2ycHIWvvnKqUhBloaKFGX9Sy25Wby8Dqbwri3SAn4RhZo1BsG5MIDMv6OueEPQ3EufynFQe4a28pvYvuD5NGA9TIhwc1PbxQctPmkZsxMoOdjjmOOkhuKS9qJmpiSASelU7/5tB0JZsSnOQN/5/mnRbEkUykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056885; c=relaxed/simple;
	bh=w/eqwcH4YBVoPX7qAYr81YCS6pKpZMntJReWM+XRRZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVf3sSsM5vvvMhT9sCSAWv7c+ShdnA+4G5BkC/yJelMqq/xVGZYvSNiPWHYhsDi/HtKoAZ7yXBJT38NTkqpyTWOyEeecGRdDkRusO/WekmciE4IS9cv6WiFEfzOJfZzNY/xZo9QfnTsIhawyt0GmXJ2vNmywXjkIdmlkjwG2lNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIkh1geG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763056883; x=1794592883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/eqwcH4YBVoPX7qAYr81YCS6pKpZMntJReWM+XRRZ0=;
  b=DIkh1geGoGTQ0qbymYv9IDl4exKrEwQtoZ8JHuPQKodJ8FKtTVpVR+y5
   P7cMprzYf3HC/+s7NjwqicHoOxkFdayhKr9BeYyv5W89KzMrLS3OYMF1+
   5oQpMb5hzLquU4mGfCXudE55n9auqbpeAOC25/M4KeHBisa+aQLa7qCLt
   X8yEuDYyoIyyczDjGEiopOZRczarXx3DQtcSRwhkQFNGDB3AYhpzhgrQW
   d2KD/PZ2kQs1ASxPrAGCJqurA190eyEjY/AmTFjrhLxKjkemBWLYE/AUs
   7fS/dzPMmeq+k+PBgk32kj6C4sQbYgrabI4ojRN0y4qNgRTP30CFGVpcj
   w==;
X-CSE-ConnectionGUID: NAPFc6VcQUeiG5uAoZwANg==
X-CSE-MsgGUID: P/DtolZHQFebybMitcOIgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75826879"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75826879"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:22 -0800
X-CSE-ConnectionGUID: l+/eRDiXSuCEh657R344Lg==
X-CSE-MsgGUID: KqE05w0XTvGQpxKcXpB2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194713595"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:01:14 -0800
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
Subject: [PATCH v4 01/11] PCI: Move Resizable BAR code to rebar.c
Date: Thu, 13 Nov 2025 20:00:43 +0200
Message-Id: <20251113180053.27944-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
References: <20251113180053.27944-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For lack of a better place to put it, Resizable BAR code has been placed
inside pci.c and setup-res.c that do not use it for anything.  Upcoming
changes are going to add more Resizable BAR related functions, increasing
the code size.

As pci.c is huge as is, move the Resizable BAR related code and the BAR
resize code from setup-res.c to rebar.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 Documentation/driver-api/pci/pci.rst |   3 +
 drivers/pci/Makefile                 |   2 +-
 drivers/pci/pci.c                    | 149 ----------------
 drivers/pci/pci.h                    |   1 +
 drivers/pci/rebar.c                  | 247 +++++++++++++++++++++++++++
 drivers/pci/setup-res.c              |  85 ---------
 6 files changed, 252 insertions(+), 235 deletions(-)
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
index 7dfc58b0e55e..aedf6a9932ce 100644
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
@@ -3687,129 +3661,6 @@ void pci_acs_init(struct pci_dev *dev)
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
-
-	if (pci_resource_is_iov(bar))
-		pci_iov_resource_set_size(pdev, bar, size);
-
-	return 0;
-}
-
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9893ea12d1f2..41df35920632 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1021,6 +1021,7 @@ static inline int acpi_get_rc_resources(struct device *dev, const char *hid,
 #endif
 
 void pci_rebar_init(struct pci_dev *pdev);
+void pci_restore_rebar_state(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
 static inline u64 pci_rebar_size_to_bytes(int size)
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
new file mode 100644
index 000000000000..f6ed7e4893a7
--- /dev/null
+++ b/drivers/pci/rebar.c
@@ -0,0 +1,247 @@
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
+
+	if (pci_resource_is_iov(bar))
+		pci_iov_resource_set_size(pdev, bar, size);
+
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
+void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size)
+{
+	resource_size_t res_size = pci_rebar_size_to_bytes(size);
+	struct resource *res = pci_resource_n(dev, resno);
+
+	if (pci_resource_is_iov(resno))
+		res_size *= pci_sriov_get_totalvfs(dev);
+
+	resource_set_size(res, res_size);
+}
+
+/**
+ * pci_resize_resource - reconfigure a Resizable BAR and resources
+ * @dev: the PCI device
+ * @resno: index of the BAR to be resized
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ * @exclude_bars: a mask of BARs that should not be released
+ *
+ * Reconfigure @resno to @size and re-run resource assignment algorithm
+ * with the new size.
+ *
+ * Prior to resize, release @dev resources that share a bridge window with
+ * @resno.  This unpins the bridge window resource to allow changing it.
+ *
+ * The caller may prevent releasing a particular BAR by providing
+ * @exclude_bars mask, but this may result in the resize operation failing
+ * due to insufficient space.
+ *
+ * Return: 0 on success, or negative on error. In case of an error, the
+ *         resources are restored to their original places.
+ */
+int pci_resize_resource(struct pci_dev *dev, int resno, int size,
+			int exclude_bars)
+{
+	struct pci_host_bridge *host;
+	int old, ret;
+	u32 sizes;
+
+	/* Check if we must preserve the firmware's resource assignment */
+	host = pci_find_host_bridge(dev->bus);
+	if (host->preserve_config)
+		return -ENOTSUPP;
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
+	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
+	if (ret)
+		goto error_resize;
+	return 0;
+
+error_resize:
+	pci_rebar_set_size(dev, resno, old);
+	return ret;
+}
+EXPORT_SYMBOL(pci_resize_resource);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index caec9fec5d03..e5fcadfc58b0 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -431,91 +431,6 @@ int pci_release_resource(struct pci_dev *dev, int resno)
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
-void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size)
-{
-	resource_size_t res_size = pci_rebar_size_to_bytes(size);
-	struct resource *res = pci_resource_n(dev, resno);
-
-	if (pci_resource_is_iov(resno))
-		res_size *= pci_sriov_get_totalvfs(dev);
-
-	resource_set_size(res, res_size);
-}
-
-/**
- * pci_resize_resource - reconfigure a Resizable BAR and resources
- * @dev: the PCI device
- * @resno: index of the BAR to be resized
- * @size: new size as defined in the spec (0=1MB, 31=128TB)
- * @exclude_bars: a mask of BARs that should not be released
- *
- * Reconfigure @resno to @size and re-run resource assignment algorithm
- * with the new size.
- *
- * Prior to resize, release @dev resources that share a bridge window with
- * @resno.  This unpins the bridge window resource to allow changing it.
- *
- * The caller may prevent releasing a particular BAR by providing
- * @exclude_bars mask, but this may result in the resize operation failing
- * due to insufficient space.
- *
- * Return: 0 on success, or negative on error. In case of an error, the
- *         resources are restored to their original places.
- */
-int pci_resize_resource(struct pci_dev *dev, int resno, int size,
-			int exclude_bars)
-{
-	struct pci_host_bridge *host;
-	int old, ret;
-	u32 sizes;
-
-	/* Check if we must preserve the firmware's resource assignment */
-	host = pci_find_host_bridge(dev->bus);
-	if (host->preserve_config)
-		return -ENOTSUPP;
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
-	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
-	if (ret)
-		goto error_resize;
-	return 0;
-
-error_resize:
-	pci_rebar_set_size(dev, resno, old);
-	return ret;
-}
-EXPORT_SYMBOL(pci_resize_resource);
-
 int pci_enable_resources(struct pci_dev *dev, int mask)
 {
 	u16 cmd, old_cmd;
-- 
2.39.5


