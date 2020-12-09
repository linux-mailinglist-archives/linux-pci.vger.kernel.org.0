Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265C42D37A6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgLIAZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:25:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:16959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731895AbgLIAZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:40 -0500
IronPort-SDR: xqstFyOh9XnrSMrWsaPSllib0xOOuG5GEg+Qgv2xJW1PZESqweqYgu9RUcTjbE4tjCzYG8lQLV
 S1LKQSQakfqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142079"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142079"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:25 -0800
IronPort-SDR: o9X7rNHop8rYuOfdHxs7jvL1rDq5M0TL0NxbGKoSTMUo5QZbMhIZkib7UKEC9EvXCHsrE6HPUE
 efixVCUY107g==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838487"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:24 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 06/14] cxl/mem: Find device capabilities
Date:   Tue,  8 Dec 2020 16:24:10 -0800
Message-Id: <20201209002418.1976362-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL devices contain an array of capabilities that describe the
interactions software can interact with the device, or firmware running
on the device. A CXL compliant device must implement the device status
and the mailbox capability. A CXL compliant memory device must implement
the memory device capability.

Each of the capabilities can [will] provide an offset within the MMIO
region for interacting with the CXL device.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h | 92 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/mem.c | 74 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d81d0ba4617c..91bb40f73ddc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -4,6 +4,38 @@
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
+/* Device */
+#define CXLDEV_CAP_ARRAY_REG 0x0
+#define CXLDEV_CAP_ARRAY_CAP_ID 0
+#define CXLDEV_CAP_ARRAY_ID(x) ((x) & (0xffff))
+#define CXLDEV_CAP_ARRAY_COUNT(x) (((x) >> 32) & 0xffff)
+
+#define CXL_CAP_CAP_ID_DEVICE_STATUS 0x1
+#define CXL_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
+#define CXL_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
+#define CXL_CAP_CAP_ID_MEMDEV 0x4000
+
+/* Mailbox (CXL 2.0 - 8.2.8.4) */
+#define CXLDEV_MB_CAPS_OFFSET 0x00
+#define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(5, 0)
+#define   CXLDEV_MB_CAP_PAYLOAD_SIZE_SHIFT 0
+#define CXLDEV_MB_CTRL_OFFSET 0x04
+#define CXLDEV_MB_CMD_OFFSET 0x08
+#define CXLDEV_MB_STATUS_OFFSET 0x10
+#define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
@@ -12,6 +44,64 @@
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
+static inline u32 __cxl_read_reg32(struct cxl_mem *cxlm, u32 reg)
+{
+	void __iomem *reg_addr = cxlm->regs;
+
+	return readl(reg_addr + reg);
+}
+
+static inline u64 __cxl_read_reg64(struct cxl_mem *cxlm, u32 reg)
+{
+	void __iomem *reg_addr = cxlm->regs;
+
+	return readq(reg_addr + reg);
+}
+#endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 06113d306cd2..8ea830ffdbba 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,75 @@
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
+ */
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+{
+	u64 cap_array;
+	int cap;
+
+	/*
+	 * Register accessors need the mappings set up by this function, so the
+	 * raw versions of the mmio accessors must be used instead.
+	 */
+	cap_array = __cxl_read_reg64(cxlm, CXLDEV_CAP_ARRAY_REG);
+	if (CXLDEV_CAP_ARRAY_ID(cap_array) != CXLDEV_CAP_ARRAY_CAP_ID)
+		return -ENODEV;
+
+	for (cap = 1; cap <= CXLDEV_CAP_ARRAY_COUNT(cap_array); cap++) {
+		void *__iomem register_block;
+		u32 offset;
+		u16 cap_id;
+
+		cap_id = __cxl_read_reg32(cxlm, cap * 0x10) & 0xffff;
+		offset = __cxl_read_reg32(cxlm, cap * 0x10 + 0x4);
+		register_block = cxlm->regs + offset;
+
+		switch (cap_id) {
+		case CXL_CAP_CAP_ID_DEVICE_STATUS:
+			dev_dbg(&cxlm->pdev->dev,
+				"found Status capability (0x%x)\n", offset);
+			cxlm->status.regs = register_block;
+			break;
+		case CXL_CAP_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(&cxlm->pdev->dev,
+				"found Mailbox capability (0x%x)\n", offset);
+			cxlm->mbox.regs = register_block;
+			cxlm->mbox.payload_size =
+				CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
+			break;
+		case CXL_CAP_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(&cxlm->pdev->dev,
+				"found Secondary Mailbox capability (0x%x)\n",
+				offset);
+			break;
+		case CXL_CAP_CAP_ID_MEMDEV:
+			dev_dbg(&cxlm->pdev->dev,
+				"found Memory Device capability (0x%x)\n",
+				offset);
+			cxlm->mem.regs = register_block;
+			break;
+		default:
+			dev_err(&cxlm->pdev->dev, "Unknown cap ID: %d (0x%x)\n",
+				cap_id, offset);
+			return -ENXIO;
+		}
+	}
+
+	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs)
+		return -ENXIO;
+
+	return 0;
+}
+
 /**
  * cxl_mem_create() - Create a new &struct cxl_mem.
  * @pdev: The pci device associated with the new &struct cxl_mem.
@@ -126,7 +195,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	}
 
-	return rc;
+	if (rc)
+		return rc;
+
+	return cxl_mem_setup_regs(cxlm);
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
-- 
2.29.2

