Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6463577B6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhDGW2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 18:28:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:14322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhDGW1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:27:18 -0400
IronPort-SDR: lPaykhO6VkLQW/HdKprY7nxn9boQ/Jiaj0ue62D1GsaCNYo8nMg8IBYDejnnxminzpNJZ6oN02
 Es+gBZRZbNaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524935"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524935"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:40 -0700
IronPort-SDR: R9ujXl52iR8YMDKrsOUx8qsQTner51AqLlnqDBiirEAx2zaj3ODQ3vmT0nFZ44ZJXw0Yc8192x
 XVtG3rxIOSsg==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548559"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:40 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] cxl: Add HDM decoder capbilities
Date:   Wed,  7 Apr 2021 15:26:25 -0700
Message-Id: <20210407222625.320177-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407222625.320177-1-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An HDM decoder is defined in the CXL 2.0 specification as a mechanism
that allow devices and upstream ports to claim memory address ranges and
participate in interleave sets. HDM decoder registers are within the
component register block defined in CXL 2.0 8.2.3 CXL 2.0 Component
Registers as part of the CXL.cache and CXL.mem subregion.

The Component Register Block is found via the Register Locator DVSEC
in a similar fashion to how the CXL Device Register Block is found. The
primary difference is the capability id size of the Component Register
Block is a single DWORD instead of 4 DWORDS.

It's now possible to configure a CXL type 3 device's HDM decoder. Such
programming is expected for CXL devices with persistent memory, and hot
plugged CXL devices that participate in CXL.mem with volatile memory.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h  | 48 ++++++++++++++++++++++++++++++
 drivers/cxl/mem.c  | 37 ++++++++++++++++++++---
 drivers/cxl/pci.h  |  1 +
 4 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 65cd704581bc..db6a83eed0a2 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -479,6 +479,79 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_port);
 
+void cxl_setup_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_regs *regs)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*regs = (struct cxl_component_regs) { 0 };
+
+	/*
+	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
+	 * CXL 2.0 8.2.4 Table 141.
+	 *
+	 * TODO: Map other registers as needed.
+	 */
+	base += CXL_CM_OFFSET;
+
+	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
+
+	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
+		dev_err(dev,
+			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
+		return;
+	}
+
+	/* It's assumed that future versions will be backward compatible */
+#define CAPID_VERSION_CHECK(data, mask, expected, capability_msg)              \
+	do {                                                                   \
+		if (FIELD_GET(mask, data) < expected) {                        \
+			dev_err(dev,                                           \
+				capability_msg                                 \
+				" version %ld is below expected %d",           \
+				FIELD_GET(mask, data), expected);              \
+			return;                                                \
+		}                                                              \
+	} while (0)
+
+	CAPID_VERSION_CHECK(cap_array, CXL_CM_CAP_HDR_VERSION_MASK,
+			    CM_CAP_HDR_CAP_VERSION, "Capability array header");
+	CAPID_VERSION_CHECK(cap_array, CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK,
+			    CM_CAP_HDR_CACHE_MEM_VERSION,
+			    "Capability array header CXL.cache CXL.mem");
+
+	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 hdr;
+		u16 cap_id, offset;
+
+		hdr = readl(base + cap * 0x4);
+
+		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
+		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
+		register_block = base + offset;
+
+		switch (cap_id) {
+		case CXL_CM_CAP_CAP_ID_HDM:
+			CAPID_VERSION_CHECK(hdr, CXL_CM_CAP_HDR_VERSION_MASK,
+					    CXL_CM_CAP_CAP_HDM_VERSION,
+					    "HDM decoder capability");
+			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
+				offset);
+			regs->hdm_decoder = register_block;
+			break;
+		default:
+			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
+				offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_setup_component_regs);
+
 /*
  * cxl_setup_device_regs() - Detect CXL Device register blocks
  * @dev: Host device of the @base mapping
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0211f44c95a2..a4ad1176dc5a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,31 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 
+/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
+#define CXL_CM_OFFSET 0x1000
+#define CXL_CM_CAP_HDR_OFFSET 0x0
+#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
+#define     CM_CAP_HDR_CAP_ID 1
+#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
+#define     CM_CAP_HDR_CAP_VERSION 1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
+#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
+#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
+
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
+/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
+#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -35,11 +60,26 @@
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 /* See note for 'struct cxl_regs' for the rationale of this organization */
+#define CXL_COMPONENT_REGS() \
+	void __iomem *hdm_decoder
+
 #define CXL_DEVICE_REGS() \
 	void __iomem *status; \
 	void __iomem *mbox; \
 	void __iomem *memdev
 
+/**
+ * struct cxl_component_regs - Common container of CXL component register block
+ *			       base pointers.
+ *
+ * The only component registers that we care about are the CXL.cache and CXL.mem
+ * registers which are at offset 0x1000 from the component register base (CXL
+ * 2.0 8.2.4)
+ */
+struct cxl_component_regs {
+	CXL_COMPONENT_REGS();
+};
+
 /**
  * struct cxl_device_regs - Common container of CXL Device register
  * 			    block base pointers
@@ -59,6 +99,12 @@ struct cxl_device_regs {
  * The specificity reads naturally from left-to-right.
  */
 struct cxl_regs {
+	union {
+		struct {
+			CXL_COMPONENT_REGS();
+		};
+		struct cxl_component_regs component;
+	};
 	union {
 		struct {
 			CXL_DEVICE_REGS();
@@ -67,6 +113,8 @@ struct cxl_regs {
 	};
 };
 
+void cxl_setup_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_regs *regs);
 void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_regs *regs);
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index b7342aaf38c4..e915e3743b76 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -974,6 +974,21 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+static int __cxl_setup_component_regs(struct cxl_mem *cxlm, void __iomem *base)
+{
+	struct cxl_regs *regs = &cxlm->regs;
+	struct pci_dev *pdev = cxlm->pdev;
+	struct device *dev = &pdev->dev;
+
+	cxl_setup_component_regs(dev, base, &regs->component);
+	if (!regs->hdm_decoder) {
+		dev_err(dev, "HDM decoder registers not found\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int __cxl_setup_device_regs(struct cxl_mem *cxlm, void __iomem *base)
 {
 	struct cxl_regs *regs = &cxlm->regs;
@@ -1032,16 +1047,30 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
 		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+		if (reg_type == CXL_REGLOC_RBI_EMPTY ||
+		    reg_type > CXL_REGLOC_RBI_MAX)
+			continue;
+
+		base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
 
-		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
-			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
-			if (IS_ERR(base))
-				return PTR_ERR(base);
+		switch (reg_type) {
+		case CXL_REGLOC_RBI_COMPONENT:
+			rc = __cxl_setup_component_regs(cxlm, base);
+			if (rc)
+				return rc;
 
+			dev_dbg(dev, "Set up component registers\n");
+			break;
+		case CXL_REGLOC_RBI_MEMDEV:
 			rc = __cxl_setup_device_regs(cxlm, base);
 			if (rc)
 				return rc;
 
+			dev_dbg(dev, "Set up device registers\n");
+			break;
+		default:
 			break;
 		}
 	}
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index af3ec078cf6c..8b8c6afbe605 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -25,6 +25,7 @@
 #define CXL_REGLOC_RBI_COMPONENT 1
 #define CXL_REGLOC_RBI_VIRT 2
 #define CXL_REGLOC_RBI_MEMDEV 3
+#define CXL_REGLOC_RBI_MAX CXL_REGLOC_RBI_MEMDEV
 
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
-- 
2.31.1

