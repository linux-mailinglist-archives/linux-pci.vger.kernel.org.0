Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C824579EA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhKTAGR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhKTAGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542414"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088395"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:59 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 17/23] cxl: Cache and pass DVSEC ranges
Date:   Fri, 19 Nov 2021 16:02:44 -0800
Message-Id: <20211120000250.1663391-18-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL 1.1 specification provided a mechanism for mapping an address space
of a CXL device. That functionality is known as a "range" and can be
programmed through PCIe DVSEC. In addition to this, the specification
defines an active bit which a device will expose through the same DVSEC
to notify system software that memory is initialized and ready.

While CXL 2.0 introduces a more powerful mechanism called HDM decoders
that are controlled by MMIO behind a PCIe BAR, the spec does allow the
1.1 style mapping to still be present. In such a case, when the CXL
driver takes over, if it were to enable HDM decoding and there was an
actively used range, things would likely blow up, in particular if it
wasn't an identical mapping.

This patch caches the relevant information which the cxl_mem driver will
need to make the proper decision and passes it along.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxlmem.h |  19 +++++++
 drivers/cxl/pci.c    | 126 +++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.h    |  13 +++++
 3 files changed, 158 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ef3c652599e..eac5528ccaae 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -89,6 +89,22 @@ struct cxl_mbox_cmd {
  */
 #define CXL_CAPACITY_MULTIPLIER SZ_256M
 
+/**
+ * struct cxl_endpoint_dvsec_info - Cached DVSEC info
+ * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+ * @ranges: Number of HDM ranges this device contains.
+ * @range.base: cached value of the range base in the DVSEC, PCIE_DEVICE
+ * @range.size: cached value of the range size in the DVSEC, PCIE_DEVICE
+ */
+struct cxl_endpoint_dvsec_info {
+	bool mem_enabled;
+	int ranges;
+	struct {
+		u64 base;
+		u64 size;
+	} range[2];
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -117,6 +133,7 @@ struct cxl_mbox_cmd {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
+ * @info: Cached DVSEC information about the device.
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -147,6 +164,8 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	struct cxl_endpoint_dvsec_info *info;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f3872cbee7f8..b3f46045bf3e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -452,8 +452,126 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+#define CDPD(cxlds, which)                                                     \
+	cxlds->device_dvsec + CXL_DVSEC_PCIE_DEVICE_##which##_OFFSET
+
+#define CDPDR(cxlds, which, sorb, lohi)                                        \
+	cxlds->device_dvsec +                                                  \
+		CXL_DVSEC_PCIE_DEVICE_RANGE_##sorb##_##lohi##_OFFSET(which)
+
+static int wait_for_valid(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	const unsigned long timeout = jiffies + HZ;
+	bool valid;
+
+	do {
+		u64 size;
+		u32 temp;
+		int rc;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, HIGH),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, LOW),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
+
+		/*
+		 * Memory_Info_Valid: When set, indicates that the CXL Range 1
+		 * Size high and Size Low registers are valid. Must be set
+		 * within 1 second of deassertion of reset to CXL device.
+		 */
+		valid = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_INFO_VALID, temp);
+		if (valid)
+			break;
+		cpu_relax();
+	} while (!time_after(jiffies, timeout));
+
+	return valid ? 0 : -ETIMEDOUT;
+}
+
+static struct cxl_endpoint_dvsec_info *dvsec_ranges(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_endpoint_dvsec_info *info;
+	int hdm_count, rc, i;
+	u16 cap, ctrl;
+
+	rc = pci_read_config_word(pdev, CDPD(cxlds, CAP), &cap);
+	if (rc)
+		return ERR_PTR(-ENXIO);
+	rc = pci_read_config_word(pdev, CDPD(cxlds, CTRL), &ctrl);
+	if (rc)
+		return ERR_PTR(-ENXIO);
+
+	if (!(cap & CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE))
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * It is not allowed by spec for MEM.capable to be set and have 0 HDM
+	 * decoders. Therefore, the device is not considered CXL.mem capable.
+	 */
+	hdm_count = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK, cap);
+	if (!hdm_count || hdm_count > 2)
+		return ERR_PTR(-EINVAL);
+
+	rc = wait_for_valid(cxlds);
+	if (rc)
+		return ERR_PTR(rc);
+
+	info = devm_kzalloc(cxlds->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->mem_enabled = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_ENABLE, ctrl);
+
+	for (i = 0; i < hdm_count; i++) {
+		u64 base, size;
+		u32 temp;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, SIZE, HIGH),
+					   &temp);
+		if (rc)
+			continue;
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, SIZE, LOW),
+					   &temp);
+		if (rc)
+			continue;
+		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, BASE, HIGH),
+					   &temp);
+		if (rc)
+			continue;
+		base = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, i, BASE, LOW),
+					   &temp);
+		if (rc)
+			continue;
+		base |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_BASE_LOW_MASK;
+
+		info->range[i].base = base;
+		info->range[i].size = size;
+		info->ranges++;
+	}
+
+	return info;
+}
+
+#undef CDPDR
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_endpoint_dvsec_info *info;
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
@@ -505,6 +623,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	info = dvsec_ranges(cxlds);
+	if (IS_ERR(info))
+		dev_err(&pdev->dev,
+			"Failed to get DVSEC range information (%ld)\n",
+			PTR_ERR(info));
+	else
+		cxlds->info = info;
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index a4b506bb37d1..2a48cd65bf59 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -15,6 +15,19 @@
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_PCIE_DEVICE_CAP_OFFSET			0xA
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE			BIT(2)
+#define     CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK		GENMASK(5, 4)
+#define   CXL_DVSEC_PCIE_DEVICE_CTRL_OFFSET			0xC
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_ENABLE			BIT(2)
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_HIGH_OFFSET(i)	0x18 + (i * 0x10)
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_LOW_OFFSET(i)	0x1C + (i * 0x10)
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_INFO_VALID		BIT(0)
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_ACTIVE			BIT(1)
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK		GENMASK(31, 28)
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_BASE_HIGH_OFFSET(i)	0x20 + (i * 0x10)
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_BASE_LOW_OFFSET(i)	0x24 + (i * 0x10)
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_BASE_LOW_MASK		GENMASK(31, 28)
 
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
-- 
2.34.0

