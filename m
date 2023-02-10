Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EA6923F1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjBJREz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjBJREr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:04:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2511E70715;
        Fri, 10 Feb 2023 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676048686; x=1707584686;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7zt+UtiRh4ehGAW6ociAQLf9mRyEgEGRu/VYdIgZBkU=;
  b=IpHiNMTj+fPpP9fg/egqZ248lAUdntSVT6veOs5yvsgeDXxMbYiI/L+1
   Pkn9QQOcZk0lV/i/cvg5OOvOOe0azgPKW9gvk6sEBK5kgnKExibMnrJpT
   eVRQmrM6RxuWU5lT/sxfRxfNpkX/GGLj2ateSRMxVH199hr+Akv9Cq03t
   ufuouLME4bo3KPg0Xs5VJYbXamaizzUMxc7QS2lSQ2SX5I6fAx9mVeYg6
   ylB2mtmdwicqnpcIizirRELveFo9uGIpBsYHBZC2FJo/yuYvxLo6ad6EG
   o4UPnntuxeaqZ50aUBQLYGiV5l+eo2LqojMG4NzCF5uleA51ksXytGujJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="416693494"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="416693494"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:04:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="617943038"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="617943038"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.190.133])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:04:05 -0800
Subject: [PATCH v6] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, bhelgaas@google.com,
        Jonathan.Cameron@Huawei.com
Date:   Fri, 10 Feb 2023 10:04:03 -0700
Message-ID: <167604864163.2392965.5102660329807283871.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By default the CXL RAS mask registers bits are defaulted to 1's and
suppress all error reporting. If the kernel has negotiated ownership
of error handling for CXL then unmask the mask registers by writing 0s.

PCI_EXP_AER_FLAGS moved to linux/pci.h header to expose to driver. It
allows exposure of system enabled PCI error flags for the driver to decide
which error bits to toggle. Bjorn suggested that the error enabling should
be controlled from the system policy rather than a driver level choice[1].

CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
unmasking.

[1]: https://lore.kernel.org/linux-cxl/20230210122952.00006999@Huawei.com/T/#me8c7f39d43029c64ccff5c950b78a2cee8e885af

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---

Based on patch posted by Ira [1] to export CXL native error reporting control.

[1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/

v6:
- Call cxl_pci_ras_unmask() based on return of pci_enable_pcie_error_reporting()
- Check PCI_EXP_DEVCTL for UE and CE bit before unmasking the respective error reporting.

v5:
- Add single debug out to show mask changing. (Dan)

v4:
- Fix masking of RAS register. (Jonathan)

v3:
- Remove flex bus port status check. (Jonathan)
- Only unmask known mask bits. (Jonathan)

v2:
- Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
- Return error for cxl_pci_ras_unmask(). (Dan)
- Add dev_dbg() for register bits to be cleared. (Dan)
- Check Flex Port DVSEC status. (Dan)
---
 drivers/cxl/cxl.h             |    1 +
 drivers/cxl/pci.c             |   66 +++++++++++++++++++++++++++++++++++++++--
 drivers/pci/pcie/aer.c        |    3 --
 include/linux/pci.h           |    2 +
 include/uapi/linux/pci_regs.h |    1 +
 5 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b3964149c77b..d640fe61b893 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
 #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
 #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
 #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
 #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
 #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4cf9a2191602..4bb41cf581df 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -642,6 +642,59 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u32 lnksta2;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
+}
+
+static int cxl_pci_ras_unmask(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	void __iomem *addr;
+	u32 orig_val, val, mask;
+
+	if (!cxlds->regs.ras)
+		return -ENODEV;
+
+	/* BIOS has CXL error control */
+	if (!host_bridge->native_cxl_error)
+		return -EOPNOTSUPP;
+
+	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_URRE) {
+		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+
+		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
+		if (!cxl_pci_flit_256(pdev))
+			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+		val = orig_val & ~mask;
+		writel(val, addr);
+		dev_dbg(&pdev->dev,
+			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_CERE) {
+		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
+		writel(val, addr);
+		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -734,10 +787,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	if (cxlds->regs.ras) {
-		pci_enable_pcie_error_reporting(pdev);
-		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
-		if (rc)
-			return rc;
+		rc = pci_enable_pcie_error_reporting(pdev);
+		if (!rc) {
+			cxl_pci_ras_unmask(pdev);
+			rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
+			if (rc)
+				return rc;
+		} else {
+			dev_warn(&pdev->dev, "Failed to enable PCIE AER.\n");
+		}
 	}
 	pci_save_state(pdev);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 625f7b2cafe4..21af538ee4a0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -214,9 +214,6 @@ void pcie_ecrc_get_policy(char *str)
 }
 #endif	/* CONFIG_PCIE_ECRC */
 
-#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
-
 int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22319ea71ab0..508eb3659762 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2545,4 +2545,6 @@ void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 	WARN_ONCE(condition, "%s %s: " fmt, \
 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
 
+#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
+				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 #endif /* LINUX_PCI_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 85ab1278811e..f19e5ccf5cc1 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -693,6 +693,7 @@
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
+#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
 #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
 #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */


