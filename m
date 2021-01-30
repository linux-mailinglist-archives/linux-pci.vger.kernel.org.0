Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D030946F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jan 2021 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhA3KXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 05:23:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:38338 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhA3AZz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 19:25:55 -0500
IronPort-SDR: x215d5KLD0t1r1pgXyxJndlETrsaT+I4ut5dVCQw1FhzN0EUnPHyFSPQDzQv3EX9xhIKs8sMwX
 1W/4iz+Ey+QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199350683"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="199350683"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:46 -0800
IronPort-SDR: rwtIFrLbgdRfbKZdTrY4Ko2/Lhi+tupqhi7a6rJ5rf6+mSF3KNTStj/fB1X+1QPKASZzNMzYSw
 mlcWpz0sXtMQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="370591655"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:46 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: [PATCH 03/14] cxl/mem: Find device capabilities
Date:   Fri, 29 Jan 2021 16:24:27 -0800
Message-Id: <20210130002438.1872527-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130002438.1872527-1-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL devices contain an array of capabilities that describe the
interactions software can have with the device or firmware running on
the device. A CXL compliant device must implement the device status and
the mailbox capability. A CXL compliant memory device must implement the
memory device capability.

Each of the capabilities can [will] provide an offset within the MMIO
region for interacting with the CXL device.

For more details see 8.2.8 of the CXL 2.0 specification (see Link).

Link: https://www.computeexpresslink.org/download-the-specification
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h |  78 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/mem.c | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d81d0ba4617c..a3da7f8050c4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -4,6 +4,37 @@
 #ifndef __CXL_H__
 #define __CXL_H__
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+
+#define CXL_SET_FIELD(value, field)                                            \
+	({                                                                     \
+		WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
+		FIELD_PREP(field##_MASK, value);                               \
+	})
+
+#define CXL_GET_FIELD(word, field) FIELD_GET(field##_MASK, word)
+
+/* Device Capabilities (CXL 2.0 - 8.2.8.1) */
+#define CXLDEV_CAP_ARRAY_OFFSET 0x0
+#define   CXLDEV_CAP_ARRAY_CAP_ID 0
+#define   CXLDEV_CAP_ARRAY_ID_MASK GENMASK(15, 0)
+#define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK(47, 32)
+/* (CXL 2.0 - 8.2.8.2.1) */
+#define CXLDEV_CAP_CAP_ID_DEVICE_STATUS 0x1
+#define CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
+#define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
+#define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
+
+/* CXL Device Mailbox (CXL 2.0 - 8.2.8.4) */
+#define CXLDEV_MB_CAPS_OFFSET 0x00
+#define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define CXLDEV_MB_CTRL_OFFSET 0x04
+#define CXLDEV_MB_CMD_OFFSET 0x08
+#define CXLDEV_MB_STATUS_OFFSET 0x10
+#define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
@@ -12,6 +43,51 @@
 struct cxl_mem {
 	struct pci_dev *pdev;
 	void __iomem *regs;
+
+	/* Cap 0001h - CXL_CAP_CAP_ID_DEVICE_STATUS */
+	struct {
+		void __iomem *regs;
+	} status;
+
+	/* Cap 0002h - CXL_CAP_CAP_ID_PRIMARY_MAILBOX */
+	struct {
+		void __iomem *regs;
+		size_t payload_size;
+	} mbox;
+
+	/* Cap 4000h - CXL_CAP_CAP_ID_MEMDEV */
+	struct {
+		void __iomem *regs;
+	} mem;
 };
 
-#endif
+#define cxl_reg(type)                                                          \
+	static inline void cxl_write_##type##_reg32(struct cxl_mem *cxlm,      \
+						    u32 reg, u32 value)        \
+	{                                                                      \
+		void __iomem *reg_addr = cxlm->type.regs;                      \
+		writel(value, reg_addr + reg);                                 \
+	}                                                                      \
+	static inline void cxl_write_##type##_reg64(struct cxl_mem *cxlm,      \
+						    u32 reg, u64 value)        \
+	{                                                                      \
+		void __iomem *reg_addr = cxlm->type.regs;                      \
+		writeq(value, reg_addr + reg);                                 \
+	}                                                                      \
+	static inline u32 cxl_read_##type##_reg32(struct cxl_mem *cxlm,        \
+						  u32 reg)                     \
+	{                                                                      \
+		void __iomem *reg_addr = cxlm->type.regs;                      \
+		return readl(reg_addr + reg);                                  \
+	}                                                                      \
+	static inline u64 cxl_read_##type##_reg64(struct cxl_mem *cxlm,        \
+						  u32 reg)                     \
+	{                                                                      \
+		void __iomem *reg_addr = cxlm->type.regs;                      \
+		return readq(reg_addr + reg);                                  \
+	}
+
+cxl_reg(status);
+cxl_reg(mbox);
+
+#endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a869c8dc24cc..fa14d51243ee 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -6,6 +6,99 @@
 #include "pci.h"
 #include "cxl.h"
 
+/**
+ * cxl_mem_setup_regs() - Setup necessary MMIO.
+ * @cxlm: The CXL memory device to communicate with.
+ *
+ * Return: 0 if all necessary registers mapped.
+ *
+ * A memory device is required by spec to implement a certain set of MMIO
+ * regions. The purpose of this function is to enumerate and map those
+ * registers.
+ *
+ * XXX: Register accessors need the mappings set up by this function, so
+ * any reads or writes must be read(b|w|l|q) or write(b|w|l|q)
+ */
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+{
+	struct device *dev = &cxlm->pdev->dev;
+	int cap, cap_count;
+	u64 cap_array;
+
+	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
+	if (CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_ID) != CXLDEV_CAP_ARRAY_CAP_ID)
+		return -ENODEV;
+
+	cap_count = CXL_GET_FIELD(cap_array, CXLDEV_CAP_ARRAY_COUNT);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 offset;
+		u16 cap_id;
+
+		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
+		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
+		register_block = cxlm->regs + offset;
+
+		switch (cap_id) {
+		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
+			dev_dbg(dev, "found Status capability (0x%x)\n",
+				offset);
+			cxlm->status.regs = register_block;
+			break;
+		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(dev, "found Mailbox capability (0x%x)\n",
+				offset);
+			cxlm->mbox.regs = register_block;
+			break;
+		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(dev,
+				"found Secondary Mailbox capability (0x%x)\n",
+				offset);
+			break;
+		case CXLDEV_CAP_CAP_ID_MEMDEV:
+			dev_dbg(dev, "found Memory Device capability (0x%x)\n",
+				offset);
+			cxlm->mem.regs = register_block;
+			break;
+		default:
+			dev_warn(dev, "Unknown cap ID: %d (0x%x)\n", cap_id,
+				 offset);
+			break;
+		}
+	}
+
+	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs) {
+		dev_err(dev, "registers not found: %s%s%s\n",
+			!cxlm->status.regs ? "status " : "",
+			!cxlm->mbox.regs ? "mbox " : "",
+			!cxlm->mem.regs ? "mem" : "");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
+{
+	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
+
+	cxlm->mbox.payload_size =
+		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
+
+	/* 8.2.8.4.3 */
+	if (cxlm->mbox.payload_size < 256) {
+		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
+			cxlm->mbox.payload_size);
+		return -ENXIO;
+	}
+
+	dev_dbg(&cxlm->pdev->dev, "Mailbox payload sized %zu",
+		cxlm->mbox.payload_size);
+
+	return 0;
+}
+
 /**
  * cxl_mem_create() - Create a new &struct cxl_mem.
  * @pdev: The pci device associated with the new &struct cxl_mem.
@@ -119,7 +212,14 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	}
 
-	return rc;
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_setup_regs(cxlm);
+	if (rc)
+		return rc;
+
+	return cxl_mem_setup_mailbox(cxlm);
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
-- 
2.30.0

