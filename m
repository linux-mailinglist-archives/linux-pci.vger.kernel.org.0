Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61562F23AD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404072AbhALAZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:11211 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390804AbhAKWwk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:52:40 -0500
IronPort-SDR: 6dBqPs9zPdn4eRVCo7vq0vJf2L5GQn43ZfIss8X2QIsEW0VHmuK68plP/yru5Zd9X68k5lKQwH
 Gqs6RFKXtF7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726536"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726536"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:34 -0800
IronPort-SDR: nxN9PiqNZhBYr+TAkbrH8jBsAS6wSvfIF//l+WLJV472SHjJR2/XfqZ3nvoXR5XIeHwO3Dh8vN
 lmM8FaWOBqzQ==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352777989"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:33 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: [RFC PATCH v3 06/16] cxl/mem: Find device capabilities
Date:   Mon, 11 Jan 2021 14:51:10 -0800
Message-Id: <20210111225121.820014-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
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

For more details see 8.2.8 of the CXL 2.0 specification.

Link: Link: https://www.computeexpresslink.org/download-the-specification
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h | 82 ++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/mem.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d81d0ba4617c..a77286d04ce4 100644
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
+/* Device  (CXL 2.0 - 8.2.8.3) */
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
+#define   CXLDEV_MB_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MB_CAP_PAYLOAD_SIZE_SHIFT 0
+#define CXLDEV_MB_CTRL_OFFSET 0x04
+#define CXLDEV_MB_CMD_OFFSET 0x08
+#define CXLDEV_MB_STATUS_OFFSET 0x10
+#define CXLDEV_MB_BG_CMD_STATUS_OFFSET 0x18
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
@@ -12,6 +44,54 @@
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
+#define cxl_payload_regs(cxlm)                                                 \
+	((void __iomem *)(cxlm)->mbox.regs + CXLDEV_MB_PAYLOAD_OFFSET)
+
+#endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8301db34d2ff..8da9f4a861ea 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,91 @@
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
+	u64 cap_array;
+	int cap;
+
+	/*
+	 */
+	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_REG);
+	if (CXLDEV_CAP_ARRAY_ID(cap_array) != CXLDEV_CAP_ARRAY_CAP_ID)
+		return -ENODEV;
+
+	for (cap = 1; cap <= CXLDEV_CAP_ARRAY_COUNT(cap_array); cap++) {
+		void __iomem *register_block;
+		u32 offset;
+		u16 cap_id;
+
+		cap_id = readl(cxlm->regs + cap * 0x10) & 0xffff;
+		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
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
+			dev_warn(&cxlm->pdev->dev,
+				 "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
+			break;
+		}
+	}
+
+	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs)
+		return -ENXIO;
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
+	if (cxlm->mbox.payload_size < 256)
+		return -ENXIO;
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
@@ -129,8 +214,20 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_mem_setup_regs(cxlm);
+	if (rc)
+		goto err;
+
+	rc = cxl_mem_setup_mailbox(cxlm);
+	if (rc)
+		goto err;
+
 	pci_set_drvdata(pdev, cxlm);
 	return 0;
+
+err:
+	kfree(cxlm);
+	return rc;
 }
 
 static void cxl_mem_remove(struct pci_dev *pdev)
-- 
2.30.0

