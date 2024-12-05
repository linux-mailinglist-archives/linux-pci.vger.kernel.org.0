Return-Path: <linux-pci+bounces-17804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18F9E6075
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471012842E2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025801BBBF1;
	Thu,  5 Dec 2024 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwBqvmnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0A1BD51B
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437422; cv=none; b=uooLE9PfNUTrFkgAw6W5IyCJ1bR15+VHpI9IF2pyUk1q23wf1Ze/xqGOJlcguOV/RF/DS5OLUjnzMKyDT/lPRQSVyf9Q59iqFAEElBAgDtSa7/w66oIXx6zj3/pei5iBO7KZem/WkY5e2W4xNJdA+b4rUFWVGSxDWEutEUYH6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437422; c=relaxed/simple;
	bh=uUq0/GOA1EQbKpjajAth6SoWrhAyqr+GIV7hcxMGeGk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE4Vdu7v6GVCRCtkvLK9P9kIH/kMNDeYto6AK7R21iaWT3Dp1DtJ3Yi7rCVjeO1KEDUUlycb851RJzzc5Q1O/4Lqi4cRmK4be/Hc4mmzHfGOkFvw0280eUBIQxhESoZJ/uikhaZp8WDrzEDxf3AEGe5bcyp99EYeo5oTT1aHOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwBqvmnh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437420; x=1764973420;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uUq0/GOA1EQbKpjajAth6SoWrhAyqr+GIV7hcxMGeGk=;
  b=fwBqvmnhRK1lUk0odSgN9Q5DbR4HyarI8ahn6JmZlAAQ6mME79ZbqUir
   Mav+XqcsaYpX8CtbRJiamnw89Y80XLkrtiGLX4M+rA7jZa+9wOCmrBptU
   HGeJlNXFtI4VeOEmLsqdINvLEAtwkNWUvIN0C0D4q8JNTgJKSJThFiL1N
   e6hw7duZayGIzYv96NLyAxAkB0ZCERGIDtWrZ+PWsHWAwc2UNmfLohIMu
   3fgNDzGEPOHKj4qw5cKznmQ16vXL4qEzghSXaZy7WOISE9hyk/IKgIhaQ
   yF2BgDQz6YBx9QgSU/Fibiv7mjROJcrf2yl5orGstUP0FJSdpueAcIG0g
   w==;
X-CSE-ConnectionGUID: a1EG/HzjQEiqCaofJAgk4g==
X-CSE-MsgGUID: 1nfvf0i1Su6cGfG/gv/iqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33910422"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33910422"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:40 -0800
X-CSE-ConnectionGUID: cKhNha+FQYOOgF+9Azue7Q==
X-CSE-MsgGUID: XlG4EP+qTB6HU51wo31CWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99050093"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:23:40 -0800
Subject: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:23:39 -0800
Message-ID: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
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
Content-Transfer-Encoding: 7bit

Link encryption is a new PCIe capability defined by "PCIe 6.2 section
6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
and endpoint capability, it is also a building block for device security
defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
(TDISP)". That protocol coordinates device security setup between the
platform TSM (TEE Security Manager) and device DSM (Device Security
Manager). While the platform TSM can allocate resources like stream-ids
and manage keys, it still requires system software to manage the IDE
capability register block.

Add register definitions and basic enumeration for a "selective-stream"
IDE capability, a follow on change will select the new CONFIG_PCI_IDE
symbol. Note that while the IDE specifications defines both a
point-to-point "Link" stream and a root-port-to-endpoint "Selective"
stream, only "Selective" is considered for now for platform TSM
coordination.

Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig           |    3 +
 drivers/pci/Makefile          |    1 
 drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |    6 +++
 drivers/pci/probe.c           |    1 
 include/linux/pci.h           |    5 ++
 include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/ide.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379923fd..4e5236c456f5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_IDE
+	bool
+
 config PCI_DOE
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..6612256fd37d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
new file mode 100644
index 000000000000..a0c09d9e0b75
--- /dev/null
+++ b/drivers/pci/ide.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
+
+#define dev_fmt(fmt) "PCI/IDE: " fmt
+#include <linux/pci.h>
+#include "pci.h"
+
+static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
+{
+	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);
+}
+
+void pci_ide_init(struct pci_dev *pdev)
+{
+	u16 ide_cap, sel_ide_cap;
+	int nr_ide_mem = 0;
+	u32 val = 0;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
+	if (!ide_cap)
+		return;
+
+	/*
+	 * Check for selective stream capability from endpoint to root-port, and
+	 * require consistent number of address association blocks
+	 */
+	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
+	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
+		return;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
+		struct pci_dev *rp = pcie_find_root_port(pdev);
+
+		if (!rp->ide_cap)
+			return;
+	}
+
+	if (val & PCI_IDE_CAP_LINK)
+		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
+			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
+				      PCI_IDE_LINK_BLOCK_SIZE;
+	else
+		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
+
+	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
+		if (i == 0) {
+			pci_read_config_dword(pdev, sel_ide_cap, &val);
+			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
+		} else {
+			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
+
+			pci_read_config_dword(pdev, offset, &val);
+
+			/*
+			 * lets not entertain devices that do not have a
+			 * constant number of address association blocks
+			 */
+			if (PCI_IDE_SEL_CAP_ASSOC_NUM(val) != nr_ide_mem) {
+				pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
+				return;
+			}
+		}
+	}
+
+	pdev->ide_cap = ide_cap;
+	pdev->sel_ide_cap = sel_ide_cap;
+	pdev->nr_ide_mem = nr_ide_mem;
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..0305f497b28a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,6 +452,12 @@ static inline void pci_npem_create(struct pci_dev *dev) { }
 static inline void pci_npem_remove(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init(struct pci_dev *dev);
+#else
+static inline void pci_ide_init(struct pci_dev *dev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2e81ab0f5a25..e22f515a8da9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
+	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..50811b7655dd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -530,6 +530,11 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
+#endif
+#ifdef CONFIG_PCI_IDE
+	u16		ide_cap;	/* Link Integrity & Data Encryption */
+	u16		sel_ide_cap;	/* - Selective Stream register block */
+	int		nr_ide_mem;	/* - Address range limits for streams */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..9635b27d2485 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -748,7 +748,8 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
+#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1213,4 +1214,85 @@
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* Integrity and Data Encryption Extended Capability */
+#define PCI_IDE_CAP			0x4
+#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
+#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
+#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
+#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
+#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
+#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
+#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
+#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
+#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
+#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
+#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
+#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
+#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
+#define PCI_IDE_CTL			0x8
+#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
+#define PCI_IDE_LINK_STREAM		0xc
+#define PCI_IDE_LINK_BLOCK_SIZE		8
+/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
+/* Link IDE Stream Control Register */
+#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
+#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
+#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
+#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
+#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
+#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
+#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
+#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
+
+
+/* Link IDE Stream Status Register */
+#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
+#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
+/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
+#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))
+/* Selective IDE Stream Capability Register */
+#define  PCI_IDE_SEL_CAP		 0
+#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
+#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
+/* Selective IDE Stream Control Register */
+#define  PCI_IDE_SEL_CTL		 4
+#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
+#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
+#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
+#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
+#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
+#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
+#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
+#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
+#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
+#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
+#define   PCI_IDE_SEL_CTL_ID_MAX	 255
+/* Selective IDE Stream Status Register */
+#define  PCI_IDE_SEL_STS		 8
+#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
+#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
+/* IDE RID Association Register 1 */
+#define  PCI_IDE_SEL_RID_1		 12
+#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
+/* IDE RID Association Register 2 */
+#define  PCI_IDE_SEL_RID_2		 16
+#define   PCI_IDE_SEL_RID_2_VALID	 0x1
+#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
+#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
+/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
+#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
+#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
+#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
+#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
+/* IDE Address Association Register 2 is "Memory Limit Upper" */
+/* IDE Address Association Register 3 is "Memory Base Upper" */
+#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * 12)
+#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * 12)
+
 #endif /* LINUX_PCI_REGS_H */


