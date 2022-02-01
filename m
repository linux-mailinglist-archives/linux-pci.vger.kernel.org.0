Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD764A68C2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 00:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiBAXs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 18:48:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:15188 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbiBAXs5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 18:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643759337; x=1675295337;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52q2zTYRWzOA+xqqfcsssRP6HVYMj56pzgBjtNndfYc=;
  b=Zf91Nub3lWGlBq7CwiByt48POGz8M/xJAwRNYa+OsTPRjyQtWD713pNa
   nQz0uigRSCifb89QQwVXtHxOrk3D+dPhfQmRf4NJHt+gDJkGAxLdm8Wvh
   T84nrhJYYOON3grRzbyK8iqgAvAiidkgpNrCI4BQFhTBq+Nn06Ybylt3y
   XudwzzCuqAGOnLqxN3xN48cfbmwhWbgogPa2Xpf7KDKbfTTE7TpEWBXgX
   OJoZrlDi9EfBpUAO9r1Ro7i7r0MdbAHF1Dg8LqZy3k1D9dUeUPt9UvtJs
   sE/69KfU0GDRbt//hQR+5V1+JK2MURYmMRMH2vmLb1CtUvIgo7bBDSYRn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="248040929"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="248040929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:48:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538035571"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:48:56 -0800
Subject: [PATCH v4 28/40] cxl/pci: Retrieve CXL DVSEC memory info
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 01 Feb 2022 15:48:56 -0800
Message-ID: <164375911821.559935.7375160041663453400.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298426829.3018233.15215948891228582221.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298426829.3018233.15215948891228582221.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Before CXL 2.0 HDM Decoder Capability mechanisms can be utilized in a
device the driver must determine that the device is ready for CXL.mem
operation and that platform firmware, or some other agent, has
established an active decode via the legacy CXL 1.1 decoder mechanism.

This legacy mechanism is defined in the CXL DVSEC as a set of range
registers and status bits that take time to settle after a reset.

Validate the CXL memory decode setup via the DVSEC and cache it for
later consideration by the cxl_mem driver (to be added). Failure to
validate is not fatal to the cxl_pci driver since that is only providing
CXL command support over PCI.mmio, and might be needed to rectify CXL
DVSEC validation problems.

Any potential ranges that the device is already claiming via DVSEC need
to be reconciled with the dynamic provisioning ranges provided by
platform firmware (like ACPI CEDT.CFMWS). Leave that reconciliation to
the cxl_mem driver.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: clarify changelog]
[djbw: shorten defines]
[djbw: change precise spin wait to generous msleep]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- Move cxl_dvsec rename to previous patch (Jonathan)
- Change dev_err() on cxl_dvsec_range() failure to dev_warn()
- Fixup cxl_dvsec_range() to check for missing ->cxl_dvsec == 0
- Clarify legacy HDM decoder count expectations (Jonathan)
- Cleanup error exit s/break/return rc;/ (Jonathan)
- Cleanup whitespace (Jonathan)

 drivers/cxl/cxlmem.h |   14 ++++++
 drivers/cxl/cxlpci.h |   13 +++++
 drivers/cxl/pci.c    |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5cf5329e13a9..00f55f4066b9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -89,6 +89,18 @@ struct cxl_mbox_cmd {
  */
 #define CXL_CAPACITY_MULTIPLIER SZ_256M
 
+/**
+ * struct cxl_endpoint_dvsec_info - Cached DVSEC info
+ * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+ * @ranges: Number of active HDM ranges this device uses.
+ * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
+ */
+struct cxl_endpoint_dvsec_info {
+	bool mem_enabled;
+	int ranges;
+	struct range dvsec_range[2];
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -118,6 +130,7 @@ struct cxl_mbox_cmd {
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @component_reg_phys: register base of component registers
+ * @info: Cached DVSEC information about the device.
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -149,6 +162,7 @@ struct cxl_dev_state {
 	u64 next_persistent_bytes;
 
 	resource_size_t component_reg_phys;
+	struct cxl_endpoint_dvsec_info info;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 766de340c4ce..329e7ea3f36a 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -17,6 +17,19 @@
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
 
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c94002166084..6b3270246545 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -386,6 +386,120 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static int wait_for_valid(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec, rc;
+	u32 val;
+
+	/*
+	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
+	 * and Size Low registers are valid. Must be set within 1 second of
+	 * deassertion of reset to CXL device. Likely it is already set by the
+	 * time this runs, but otherwise give a 1.5 second timeout in case of
+	 * clock skew.
+	 */
+	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
+	if (rc)
+		return rc;
+
+	if (val & CXL_DVSEC_MEM_INFO_VALID)
+		return 0;
+
+	msleep(1500);
+
+	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
+	if (rc)
+		return rc;
+
+	if (val & CXL_DVSEC_MEM_INFO_VALID)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
+{
+	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	int hdm_count, rc, i;
+	u16 cap, ctrl;
+
+	if (!d)
+		return -ENXIO;
+
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_MEM_CAPABLE))
+		return -ENXIO;
+
+	/*
+	 * It is not allowed by spec for MEM.capable to be set and have 0 legacy
+	 * HDM decoders (values > 2 are also undefined as of CXL 2.0). As this
+	 * driver is for a spec defined class code which must be CXL.mem
+	 * capable, there is no point in continuing to enable CXL.mem.
+	 */
+	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	if (!hdm_count || hdm_count > 2)
+		return -EINVAL;
+
+	rc = wait_for_valid(cxlds);
+	if (rc)
+		return rc;
+
+	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+
+	for (i = 0; i < hdm_count; i++) {
+		u64 base, size;
+		u32 temp;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
+		if (rc)
+			return rc;
+
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
+		if (rc)
+			return rc;
+
+		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
+		if (rc)
+			return rc;
+
+		base = (u64)temp << 32;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
+		if (rc)
+			return rc;
+
+		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
+
+		info->dvsec_range[i] = (struct range) {
+			.start = base,
+			.end = base + size - 1
+		};
+
+		if (size)
+			info->ranges++;
+	}
+
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -449,6 +563,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_dvsec_ranges(cxlds);
+	if (rc)
+		dev_warn(&pdev->dev,
+			 "Failed to get DVSEC range information (%d)\n", rc);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);

