Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BA2AE850
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 06:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKKFoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 00:44:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:54155 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgKKFoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 00:44:07 -0500
IronPort-SDR: 06Ob2bvSOfd2Eekdi/gms4ndEJ6GW0GKuUFOTP5L1sm4fXsVuoBqRIO5EDxB/NwQoZd2AsWCA3
 nSrn6S+RSKxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149372968"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="149372968"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:06 -0800
IronPort-SDR: O84T/28VvH2cbRWrhPM9NlhGvj0OjUSPMy557wfyjDLYJXmUSsdNTMvl41KJFJ1ysMj0svhyFm
 IirDsHIs8cmA==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360414759"
Received: from hccoutan-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.131.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:05 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 5/9] cxl/mem: Find device capabilities
Date:   Tue, 10 Nov 2020 21:43:52 -0800
Message-Id: <20201111054356.793390-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
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
 drivers/cxl/cxl.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.c | 58 +++++++++++++++++++++++++++---
 2 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cxl/cxl.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
new file mode 100644
index 000000000000..02858ae63d6d
--- /dev/null
+++ b/drivers/cxl/cxl.h
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2020 Intel Corporation. All rights reserved.
+
+#ifndef __CXL_H__
+#define __CXL_H__
+
+/* Device */
+#define CXLDEV_CAP_ARRAY_REG 0x0
+#define CXLDEV_CAP_ARRAY_CAP_ID 0
+#define CXLDEV_CAP_ARRAY_ID(x) ((x) & 0xffff)
+#define CXLDEV_CAP_ARRAY_COUNT(x) (((x) >> 32) & 0xffff)
+
+#define CXL_CAPABILITIES_CAP_ID_DEVICE_STATUS 1
+#define CXL_CAPABILITIES_CAP_ID_PRIMARY_MAILBOX 2
+#define CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX 3
+#define CXL_CAPABILITIES_CAP_ID_MEMDEV 0x4000
+
+/* Mailbox */
+#define CXLDEV_MB_CAPS 0x00
+#define   CXLDEV_MB_CAP_PAYLOAD_SIZE(cap) ((cap) & 0x1F)
+#define CXLDEV_MB_CTRL 0x04
+#define CXLDEV_MB_CMD 0x08
+#define CXLDEV_MB_STATUS 0x10
+#define CXLDEV_MB_BG_CMD_STATUS 0x18
+
+struct cxl_mem {
+	struct pci_dev *pdev;
+	void __iomem *regs;
+
+	/* Cap 0000h */
+	struct {
+		void __iomem *regs;
+	} status;
+
+	/* Cap 0002h */
+	struct {
+		void __iomem *regs;
+		size_t payload_size;
+	} mbox;
+
+	/* Cap 0040h */
+	struct {
+		void __iomem *regs;
+	} mem;
+};
+
+#define cxl_reg(type)                                                          \
+	static inline void cxl_write_##type##_reg32(struct cxl_mem *cxlm,      \
+						    u32 reg, u32 value)        \
+	{                                                                      \
+		void __iomem *reg_addr = READ_ONCE(cxlm->type.regs);           \
+		writel(value, reg_addr + reg);                                 \
+	}                                                                      \
+	static inline void cxl_write_##type##_reg64(struct cxl_mem *cxlm,      \
+						    u32 reg, u64 value)        \
+	{                                                                      \
+		void __iomem *reg_addr = READ_ONCE(cxlm->type.regs);           \
+		writeq(value, reg_addr + reg);                                 \
+	}                                                                      \
+	static inline u32 cxl_read_##type##_reg32(struct cxl_mem *cxlm,        \
+						  u32 reg)                     \
+	{                                                                      \
+		void __iomem *reg_addr = READ_ONCE(cxlm->type.regs);           \
+		return readl(reg_addr + reg);                                  \
+	}                                                                      \
+	static inline u64 cxl_read_##type##_reg64(struct cxl_mem *cxlm,        \
+						  u32 reg)                     \
+	{                                                                      \
+		void __iomem *reg_addr = READ_ONCE(cxlm->type.regs);           \
+		return readq(reg_addr + reg);                                  \
+	}
+
+cxl_reg(status)
+cxl_reg(mbox)
+
+static inline u32 __cxl_raw_read_reg32(struct cxl_mem *cxlm, u32 reg)
+{
+	void __iomem *reg_addr = READ_ONCE(cxlm->regs);
+
+	return readl(reg_addr + reg);
+}
+
+static inline u64 __cxl_raw_read_reg64(struct cxl_mem *cxlm, u32 reg)
+{
+	void __iomem *reg_addr = READ_ONCE(cxlm->regs);
+
+	return readq(reg_addr + reg);
+}
+#endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8d9b9ab6c5ea..4109ef7c3ecb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -5,11 +5,57 @@
 #include <linux/io.h>
 #include "acpi.h"
 #include "pci.h"
+#include "cxl.h"
 
-struct cxl_mem {
-	struct pci_dev *pdev;
-	void __iomem *regs;
-};
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+{
+	u64 cap_array;
+	int cap;
+
+	cap_array = __cxl_raw_read_reg64(cxlm, CXLDEV_CAP_ARRAY_REG);
+	if (CXLDEV_CAP_ARRAY_ID(cap_array) != CXLDEV_CAP_ARRAY_CAP_ID)
+		return -ENODEV;
+
+	for (cap = 1; cap <= CXLDEV_CAP_ARRAY_COUNT(cap_array); cap++) {
+		void *__iomem register_block;
+		u32 offset;
+		u16 cap_id;
+
+		cap_id = __cxl_raw_read_reg32(cxlm, cap * 0x10) & 0xffff;
+		offset = __cxl_raw_read_reg32(cxlm, cap * 0x10 + 0x4);
+		register_block = cxlm->regs + offset;
+
+		switch (cap_id) {
+		case CXL_CAPABILITIES_CAP_ID_DEVICE_STATUS:
+			dev_dbg(&cxlm->pdev->dev, "found Status capability\n");
+			cxlm->status.regs = register_block;
+			break;
+		case CXL_CAPABILITIES_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(&cxlm->pdev->dev,
+				 "found Mailbox capability\n");
+			cxlm->mbox.regs = register_block;
+			cxlm->mbox.payload_size = CXLDEV_MB_CAP_PAYLOAD_SIZE(cap_id);
+			break;
+		case CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(&cxlm->pdev->dev,
+				   "found UNSUPPORTED Secondary Mailbox capability\n");
+			break;
+		case CXL_CAPABILITIES_CAP_ID_MEMDEV:
+			dev_dbg(&cxlm->pdev->dev,
+				 "found Memory Device capability\n");
+			cxlm->mem.regs = register_block;
+			break;
+		default:
+			dev_err(&cxlm->pdev->dev, "Unknown cap ID: %d\n", cap_id);
+			return -ENXIO;
+		}
+	}
+
+	if (!cxlm->status.regs || !cxlm->mbox.regs || !cxlm->mem.regs)
+		return -ENXIO;
+
+	return 0;
+}
 
 static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi)
 {
@@ -110,6 +156,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlm))
 		return -ENXIO;
 
+	rc = cxl_mem_setup_regs(cxlm);
+	if (rc)
+		return rc;
+
 	pci_set_drvdata(pdev, cxlm);
 
 	return 0;
-- 
2.29.2

