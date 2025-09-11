Return-Path: <linux-pci+bounces-35867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F167CB52AC5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99FF5643C3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407B2C15BB;
	Thu, 11 Sep 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7OvQRjv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AE2C0F97;
	Thu, 11 Sep 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577405; cv=none; b=DkdMyjoRNVfO3hvDD9n/e1x4XTbaTPRyMZUasSCdhso8BjJsAuKCfaaHGerRDeVk6WUUkoIUHJa7RmS002HPl/4l/YqUMqZG6hBseRGH2r89gAh0TOGa3JRwMW0Q22I9U3WWfst0SrFmcXM5nYH0X3XPW/IqBFCmqfmvpIXyryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577405; c=relaxed/simple;
	bh=pBsfzo+76jLYoCUvLmqxOlwLg75OBZ+MgvSzYO1t/jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss6DZea4NlEIWItWNg4BOsaaE2M09tN5He6gmS1BMBM1L0SOaAKZmvvJOMIsRGS9Hy/UJgo8RlG8Dxv7euV6CTB0M/aloDcJHIAkU7VZSSHqFFvNu+W5EWJwT1vBsfE+gG2EQee4zf0SvLwqDemcssWH3FAFHdJScGwTBttuin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7OvQRjv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577403; x=1789113403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pBsfzo+76jLYoCUvLmqxOlwLg75OBZ+MgvSzYO1t/jk=;
  b=B7OvQRjvFeXMCoHxqZwIYWQcZHwU7xWi9nSExT8iJw3scB1OrlVVkQFE
   7v0GeqjruJf5uikXmZwck4jq8TFdUCi5DoGb8YS9mB8g01J7jufTvAnqt
   4dOo/22PXjjkLBHCAtm4l1xwII+h+eYc4ZTfDlcN09ec/AGOhBaVgshVr
   wLrvZ+sWGKmH4eWVknSj26ubqGn3Trk0/c6mce6FC2DeXKudMI+0Pf4Mb
   a2074nAS8EsKutwDKUfm2GN/hXltfMGv3FRXPL6lyWMC/nLizVxGB707m
   oau8zVNlb3TsFem5/gIkQC0qbmE2l9QtWvkEvJxkqeZsn7YOVjI/Emoa2
   Q==;
X-CSE-ConnectionGUID: SfDktIlGShuLBsKf2T188g==
X-CSE-MsgGUID: UcCjomu3RkCL+ssLgFMplQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70999106"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="70999106"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:56:34 -0700
X-CSE-ConnectionGUID: hPtAErc8QiiZR+eavhkRxw==
X-CSE-MsgGUID: 6d26r8G6RLeJknLwmOVvPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="210757590"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:56:26 -0700
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
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/11] PCI: Move Resizable BAR code into rebar.c
Date: Thu, 11 Sep 2025 10:55:55 +0300
Message-Id: <20250911075605.5277-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20250911075605.5277-1-ilpo.jarvinen@linux.intel.com>
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
index b0f4d98036cd..da3a48bf2799 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1874,32 +1874,6 @@ static void pci_restore_config_space(struct pci_dev *pdev)
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
@@ -3738,125 +3712,6 @@ void pci_acs_init(struct pci_dev *dev)
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
index 34f65d69662e..f1b30414b2f1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -926,6 +926,7 @@ static inline int acpi_get_rc_resources(struct device *dev, const char *hid,
 #endif
 
 void pci_rebar_init(struct pci_dev *pdev);
+void pci_restore_rebar_state(struct pci_dev *pdev);
 int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
 int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
 static inline u64 pci_rebar_size_to_bytes(int size)
diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
new file mode 100644
index 000000000000..b87cfa6fb3ef
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
+		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
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
index d2b3ed51e880..20b02b74e90b 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -423,84 +423,6 @@ void pci_release_resource(struct pci_dev *dev, int resno)
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
-		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
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


