Return-Path: <linux-pci+bounces-39217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A7C04135
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C256F4F1C97
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C53225A38;
	Fri, 24 Oct 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMR461ud"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3972010EE
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271462; cv=none; b=RIobt67PqXwahln/5z5OUDCNwCqudfspaAji19n5VCD0b5ExiK4XkLZgbM/RVWik4eWcUeV8V9DgjM1mUssKdbJvs0nKvsfp6faW5ePRAAapWxotA1Flucv6Z1vWOAioMo/KLzyO7hXPOhxLP2swi5gzhiC4asJy06e2VUrGZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271462; c=relaxed/simple;
	bh=+fFZaPOxKKFP1Y8B3sc4//72UBC6J+SAsBM42404vGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTmVX3BcSCStnASwS26laYswBR+xPbWanQVHDjWaDPmxhUnrj2JmrgGDpQc+F/UmWN3id9Y+IvhZ/UhitA4pf7wu9EpRGK8zplgF3raykEjJvz+kLmivVAG1E2QpcVyiZAuiyIjX6eKH/EuPg2OkXJCkzqtJsqG0UZbk8ROtRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMR461ud; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271461; x=1792807461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+fFZaPOxKKFP1Y8B3sc4//72UBC6J+SAsBM42404vGM=;
  b=lMR461ud7eGTA3G5WBkyz42+SeGO6Qbli5WHLUuYbqND1xWT38W9OY+n
   ri+PGzlo66G1v4Jk4LIHquVna0enHnrzJU2hD1KQ28+Nan5M3GYZudtV6
   P1aPrRnSjb4eXgT42XCIZuKm3NKUbkPhZKsfqqEK2uZj7PjCYWjt/Ov/z
   XpE5EI7dulK66Oj/8T9wt88SqO+JlVmVzM2M4tYuOSjZhUEYPaTUY2qU3
   aG3t5rKqhf3ooy7EibtqqIc/t8ptynUwbwkUNl/lrvIdsNyI+dcnCHcHc
   GpzhNXzq+QraQEnmWHzeyf2W60wrKzFyritZw/ExAmn2RAkN19LOifUu5
   g==;
X-CSE-ConnectionGUID: /5FZKRfpRgih92cdu85PXQ==
X-CSE-MsgGUID: bCVphwyOTkGT8806Eis2Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67319378"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67319378"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:04:18 -0700
X-CSE-ConnectionGUID: l4E7l39pQ+OPJNS9VizM0Q==
X-CSE-MsgGUID: Tv/XuO3RTJWeBvhT2G35ow==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2025 19:04:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com,
	yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v7 5/9] PCI: Add PCIe Device 3 Extended Capability enumeration
Date: Thu, 23 Oct 2025 19:04:14 -0700
Message-ID: <20251024020418.1366664-6-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024020418.1366664-1-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe r7.0 Section 7.7.9 Device 3 Extended Capability Structure, defines the
canonical location for determining the Flit Mode of a device. This status
is a dependency for PCIe IDE enabling. Add a new fm_enabled flag to 'struct
pci_dev'.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  7 +++++++
 drivers/pci/probe.c           | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2f9c0cb6a50a..ea94799c81b0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -450,6 +450,7 @@ struct pci_dev {
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
+	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f2759c1097bc..3add74ae2594 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -755,6 +755,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
@@ -1246,6 +1247,12 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_CAP		0x04	/* Device 3 Capabilities Register */
+#define PCI_DEV3_CTL		0x08	/* Device 3 Control Register */
+#define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
+#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d1467348c169..3b54f1720be5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2283,6 +2283,17 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	return 0;
 }
 
+static void pci_dev3_init(struct pci_dev *pdev)
+{
+	u16 cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
+	u32 val = 0;
+
+	if (!cap)
+		return;
+	pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
+	pdev->fm_enabled = !!(val & PCI_DEV3_STA_SEGMENT);
+}
+
 /**
  * pcie_relaxed_ordering_enabled - Probe for PCIe relaxed ordering enable
  * @dev: PCI device to query
@@ -2667,6 +2678,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
-- 
2.51.0


