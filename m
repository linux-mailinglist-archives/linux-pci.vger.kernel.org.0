Return-Path: <linux-pci+bounces-17807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330F09E6079
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D69916A79B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FF1BBBF1;
	Thu,  5 Dec 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJNdnujj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA521CCEF8
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437439; cv=none; b=gD6Id4czZAnsW32aLk1ZWObNqy2NLXTzpDcHk4fPOlK9mCR1/Zv2uIXw2UfHU7OQP3218p+bDUKoGP4dpyY+oAxHSaNTft4Nb0S3m3MlyT9XjIJlh/5cdoWSpyYyiN5vZhVjqoPulZL8e4ISlGXwLUdOaby9BIWi06JK4qDqI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437439; c=relaxed/simple;
	bh=xFHmZBWJPr9bAxkc/LrrW+59qUpbdh11WV1EQ2Bc3Fk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJsh4W6JtV3a9yGxBpOl+6csbJHrRyS1zDp/uhUKs+zMhG+dN48nvR5iYzwa7jZDZL5rU4XFniwIdN/xpsWS64S7dVW56ygl46w1hqNP7z5YUPBRM5SjmWPVAnap52CXHleJHHA+GmtfVDRAUESLKdEkwV5Xnen5dPzWzJcWSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJNdnujj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437438; x=1764973438;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFHmZBWJPr9bAxkc/LrrW+59qUpbdh11WV1EQ2Bc3Fk=;
  b=WJNdnujjYEh+spP03oxEtyS1wUv2t2y/vIkNVSjvVyGCHRb22y+MG6Ec
   Yc3VbN+hj+zKKVhq28O7EfFh73RqkqgNzwlyQtmvVi0aDAwuTGid9BZ0W
   8I1C4N00Hyu2/s2NApRavl0Q7vx0fa5KKFAY+/EZOHkJMNiB/b5wAZ0Et
   8Kg/eV2WZxXdxJAHJ8KpR2sLEDYDtU+Youv3QXxeSYsfujK87VgBNBsLj
   cNPlDv1hOB4K84rUI3tWeN86Y1dSKycd+iMDw5nuBuikIgfLopcriBjUj
   lOirwON7KGmVzL65Keg+BFkhnYtTbl2nmUGyvS+pFQB88gvlKSLzCFMPk
   g==;
X-CSE-ConnectionGUID: YFcR/JYDRWeEfsSf6WFZIg==
X-CSE-MsgGUID: 1/NHhkspS2er5+z/UFOCww==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33910450"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33910450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:58 -0800
X-CSE-ConnectionGUID: r08nk+EVT3qcv7ocWN7RHg==
X-CSE-MsgGUID: Qgq3q9+KTAWmP7bPEXacyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99050142"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:57 -0800
Subject: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability enumeration
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Lukas Wunner <lukas@wunner.de>,
 Ilpo =?utf-8?b?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:56 -0800
Message-ID: <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
enumerates new link capabilities and status added for Gen 6 devices. One
of the link details enumerated in that register block is the "Segment
Captured" status in the Device Status 3 register. That status is
relevant for enabling IDE (Integrity & Data Encryption) whereby
Selective IDE streams can be limited to a given requester id range
within a given segment.

If a device has captured its Segment value then it knows that PCIe Flit
Mode is enabled via all links in the path that a configuration write
traversed. IDE establishment requires that "Segment Base" in
IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
programmed if the RID association mechanism is in effect.

When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
setup the segment base when using the RID association facility, but no
known deployments today depend on this.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/pci.h             |   11 +++++++++++
 drivers/pci/probe.c           |    1 +
 include/linux/pci.h           |    1 +
 include/uapi/linux/pci_regs.h |    7 +++++++
 4 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0537fc72d5be..6565eb72ded2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -444,6 +444,17 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+static inline void pci_dev3_init(struct pci_dev *pdev)
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
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cddde3cb0ed..6c1fe6354d26 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
+	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 	pci_tsm_init(dev);		/* TEE Security Manager connection */
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a0900e7d2012..10d035395a43 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -443,6 +443,7 @@ struct pci_dev {
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
+	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 19bba65a262c..c61231861b51 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -749,6 +749,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
 
@@ -1210,6 +1211,12 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
+#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
+#define PCI_DEV3_STA		0xc	/* Device 3 Status Register */
+#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c


