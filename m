Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C633A1D5866
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 19:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEORzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 13:55:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:26829 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgEORzf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 13:55:35 -0400
IronPort-SDR: stbtdaglhcGp/EGrUkZFsPJI/hmqw3bb/XdyRDzyS4xViGGe9B4RxRjUFW4KvPYJ/+o8PbuZLc
 yqj7S0/y/+xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:55:35 -0700
IronPort-SDR: TBKh+ihMjMtoxPYH+OtfEHSMh9mvSuJosODBNQBSufQTKe072TnEDrjnulbwFEepL7H3HK4iCq
 8a0UTnYXbaSA==
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="464804660"
Received: from msethi-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.178.149])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 10:55:34 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [RFC PATCH 2/2] PCI: Add basic Compute eXpress Link DVSEC decode
Date:   Fri, 15 May 2020 10:55:28 -0700
Message-Id: <20200515175528.980103-3-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515175528.980103-1-sean.v.kelley@linux.intel.com>
References: <20200515175528.980103-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Compute eXpress Link is a new CPU interconnect created with
workload accelerators in mind. The interconnect relies on PCIe Electrical
and Physical interconnect for communication. CXL devices enumerate to the
OS as an ACPI-described PCIe Root Complex Integrated Endpoint.

This patch introduces the bare minimum support by simply looking for and
caching the DVSEC CXL Extended Capability. Currently, only CXL.io (which
is mandatory to be configured by BIOS) is enabled. In future, we will
also add support for CXL.cache and CXL.mem.

DocLink: https://www.computeexpresslink.org/

Originally-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
---
 drivers/pci/Kconfig  |  9 +++++
 drivers/pci/Makefile |  1 +
 drivers/pci/cxl.c    | 89 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |  7 ++++
 drivers/pci/probe.c  |  1 +
 include/linux/pci.h  |  1 +
 6 files changed, 108 insertions(+)
 create mode 100644 drivers/pci/cxl.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2bae9f..eafb200b320b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -115,6 +115,15 @@ config XEN_PCIDEV_FRONTEND
 	  The PCI device frontend driver allows the kernel to import arbitrary
 	  PCI devices from a PCI backend to support PCI driver domains.
 
+config PCI_CXL
+	bool "Enable PCI Compute eXpress Link"
+	depends on PCI
+	help
+	  Say Y here if you want the PCI core to detect CXL devices, decode, and
+	  cache the DVSEC CXL Extended Capability as configured by BIOS.
+
+	  When in doubt, say N.
+
 config PCI_ATS
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 522d2b974e91..465eee31e999 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
+obj-$(CONFIG_PCI_CXL)		+= cxl.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
new file mode 100644
index 000000000000..f02bdd7b77f2
--- /dev/null
+++ b/drivers/pci/cxl.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Compute eXpress Link Support
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1e98
+#define PCI_DVSEC_ID_CXL_DEV		0x0
+
+#define PCI_CXL_CAP			0x0a
+#define PCI_CXL_CTRL			0x0c
+#define PCI_CXL_STS			0x0e
+#define PCI_CXL_CTRL2			0x10
+#define PCI_CXL_STS2			0x12
+#define PCI_CXL_LOCK			0x14
+
+#define PCI_CXL_CACHE			BIT(0)
+#define PCI_CXL_IO			BIT(1)
+#define PCI_CXL_MEM			BIT(2)
+#define PCI_CXL_HDM_COUNT(reg)		(((reg) & (3 << 4)) >> 4)
+#define PCI_CXL_VIRAL			BIT(14)
+
+/*
+ * pci_find_cxl_capability - Identify and return offset to Vendor-Specific
+ * capabilities.
+ *
+ * CXL makes use of Designated Vendor-Specific Extended Capability (DVSEC)
+ * to uniquely identify both DVSEC Vendor ID and DVSEC ID aligning with
+ * PCIe r5.0, sec 7.9.6.2
+ */
+static int pci_find_cxl_capability(struct pci_dev *dev)
+{
+	u16 vendor, id;
+	int pos = 0;
+
+	while ((pos = pci_find_next_ext_capability(dev, pos,
+						   PCI_EXT_CAP_ID_DVSEC))) {
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1,
+				     &vendor);
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
+		if (vendor == PCI_DVSEC_VENDOR_ID_CXL &&
+		    id == PCI_DVSEC_ID_CXL_DEV)
+			return pos;
+	}
+
+	return 0;
+}
+
+void pci_cxl_init(struct pci_dev *dev)
+{
+	u16 cap, ctrl, status, ctrl2, status2, lock;
+	int pos;
+
+	/* Only for PCIe */
+	if (!pci_is_pcie(dev))
+		return;
+
+	/* Only for Device 0 Function 0, Root Complex Integrated Endpoints */
+	if (dev->devfn != 0 || (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END))
+		return;
+
+	pos = pci_find_cxl_capability(dev);
+	if (!pos)
+		return;
+
+	dev->cxl_cap = pos;
+
+	pci_read_config_word(dev, pos + PCI_CXL_CAP, &cap);
+	pci_read_config_word(dev, pos + PCI_CXL_CTRL, &ctrl);
+	pci_read_config_word(dev, pos + PCI_CXL_STS, &status);
+	pci_read_config_word(dev, pos + PCI_CXL_CTRL2, &ctrl2);
+	pci_read_config_word(dev, pos + PCI_CXL_STS2, &status2);
+	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
+
+	dev_info(&dev->dev, "CXL: Cache%c IO%c Mem%c Viral%c HDMCount %d\n",
+		 (cap & PCI_CXL_CACHE) ? '+' : '-',
+		 (cap & PCI_CXL_IO) ? '+' : '-',
+		 (cap & PCI_CXL_MEM) ? '+' : '-',
+		 (cap & PCI_CXL_VIRAL) ? '+' : '-',
+		 PCI_CXL_HDM_COUNT(cap));
+
+	dev_info(&dev->dev, "CXL: cap ctrl status ctrl2 status2 lock\n");
+	dev_info(&dev->dev, "CXL: %04x %04x %04x %04x %04x %04x\n",
+		 cap, ctrl, status, ctrl2, status2, lock);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..d9905e2dee95 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -469,6 +469,13 @@ static inline void pci_ats_init(struct pci_dev *d) { }
 static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 #endif /* CONFIG_PCI_ATS */
 
+#ifdef CONFIG_PCI_CXL
+/* Compute eXpress Link */
+void pci_cxl_init(struct pci_dev *dev);
+#else
+static inline void pci_cxl_init(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *dev);
 void pci_restore_pri_state(struct pci_dev *pdev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77b8a145c39b..c55df0ae8f06 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2371,6 +2371,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
+	pci_cxl_init(dev);		/* Compute eXpress Link */
 
 	pcie_report_downtraining(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..0c9145f48456 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -315,6 +315,7 @@ struct pci_dev {
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
 #endif
+	u16		cxl_cap;	/* CXL capability offset */
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
-- 
2.26.2

