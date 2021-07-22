Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461203D25F4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 16:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhGVOAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 10:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhGVOAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 10:00:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E2AE6135B;
        Thu, 22 Jul 2021 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626964847;
        bh=e3z/cs4Ve/WGfWG2UNadwndIAWLqSwkZCOlXnCd1+CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ry5wjePs9UZpdZkhZZUvwYGXDDqjM3XeEtSPQ7Z1V86JfkR8F2dIuql+XzUdD1JlQ
         qZu7NYjZd2XjcL41rlsU6x06+YfN4OiarChFBqGvs20PmcojuB/OTIXFZMYmDG6YW1
         O7Y0QFhDe4P8JRBfkio/JBjoiA/ZdRjvPHURLLP1oAiHR70v1/4VEbWzijJGezhDOp
         7T3bFrvDCVERVhkvTkkWBWd85de5eYWxhcRQV1+ONYuWWrpV0f9mMoaFEggDeQWt29
         AQoDWApO/CPM71jdM+KeEu79eSQ7/wWythcbfCMweTMfvcX/Sm5GNbYNzpCNSpSisl
         8/SJBwDtO6rrA==
Received: by pali.im (Postfix)
        id 8A4AD13E7; Thu, 22 Jul 2021 16:40:45 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: aardvark: Fix reporting CRS value
Date:   Thu, 22 Jul 2021 16:40:41 +0200
Message-Id: <20210722144041.12661-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722144041.12661-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
 <20210722144041.12661-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set CRSVIS flag in emulated root PCI bridge to indicate support for
Completion Retry Status.

Add check for CRSSVE flag from root PCI brige when issuing Configuration
Read Request via PIO to correctly returns fabricated CRS value as it is
required by PCIe spec.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Cc: stable@vger.kernel.org # e0d9d30b7354 ("PCI: pci-bridge-emul: Fix big-endian support")
---
 drivers/pci/controller/pci-aardvark.c | 67 +++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ebb48530024c..abc93225ba20 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -177,6 +177,8 @@
 
 #define MSI_IRQ_NUM			32
 
+#define CFG_RD_CRS_VAL			0xffff0001
+
 struct advk_pcie {
 	struct platform_device *pdev;
 	void __iomem *base;
@@ -462,7 +464,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
 }
 
-static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
+static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u32 *val)
 {
 	struct device *dev = &pcie->pdev->dev;
 	u32 reg;
@@ -504,9 +506,30 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
 		strcomp_status = "UR";
 		break;
 	case PIO_COMPLETION_STATUS_CRS:
+		if (allow_crs && val) {
+			/* PCIe r4.0, sec 2.3.2, says:
+			 * If CRS Software Visibility is enabled:
+			 * For a Configuration Read Request that includes both
+			 * bytes of the Vendor ID field of a device Function's
+			 * Configuration Space Header, the Root Complex must
+			 * complete the Request to the host by returning a
+			 * read-data value of 0001h for the Vendor ID field and
+			 * all '1's for any additional bytes included in the
+			 * request.
+			 *
+			 * So CRS in this case is not an error status.
+			 */
+			*val = CFG_RD_CRS_VAL;
+			strcomp_status = NULL;
+			break;
+		}
 		/* PCIe r4.0, sec 2.3.2, says:
 		 * If CRS Software Visibility is not enabled, the Root Complex
 		 * must re-issue the Configuration Request as a new Request.
+		 * If CRS Software Visibility is enabled: For a Configuration
+		 * Write Request or for any other Configuration Read Request,
+		 * the Root Complex must re-issue the Configuration Request as
+		 * a new Request.
 		 * A Root Complex implementation may choose to limit the number
 		 * of Configuration Request/CRS Completion Status loops before
 		 * determining that something is wrong with the target of the
@@ -575,6 +598,7 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_EXP_RTCTL: {
 		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
 		*value = (val & PCIE_MSG_PM_PME_MASK) ? 0 : PCI_EXP_RTCTL_PMEIE;
+		*value |= PCI_EXP_RTCAP_CRSVIS << 16;
 		return PCI_BRIDGE_EMUL_HANDLED;
 	}
 
@@ -656,6 +680,7 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
+	int ret;
 
 	bridge->conf.vendor =
 		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
@@ -679,7 +704,15 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	return pci_bridge_emul_init(bridge, 0);
+	/* PCIe config space can be initialized after pci_bridge_emul_init() */
+	ret = pci_bridge_emul_init(bridge, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Indicates supports for Completion Retry Status */
+	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
+
+	return 0;
 }
 
 static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
@@ -731,6 +764,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
 	struct advk_pcie *pcie = bus->sysdata;
+	bool allow_crs;
 	u32 reg;
 	int ret;
 
@@ -743,7 +777,24 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		return pci_bridge_emul_conf_read(&pcie->bridge, where,
 						 size, val);
 
+	/*
+	 * Completion Retry Status is possible to return only when reading all
+	 * 4 bytes from PCI_VENDOR_ID and PCI_DEVICE_ID registers at once and
+	 * CRSSVE flag on Root Bridge is enabled.
+	 */
+	allow_crs = (where == PCI_VENDOR_ID) && (size == 4) &&
+		    (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) &
+		     PCI_EXP_RTCTL_CRSSVE);
+
 	if (advk_pcie_pio_is_running(pcie)) {
+		/*
+		 * If it is possible return Completion Retry Status so caller
+		 * tries to issue the request again instead of failing.
+		 */
+		if (allow_crs) {
+			*val = CFG_RD_CRS_VAL;
+			return PCIBIOS_SUCCESSFUL;
+		}
 		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
@@ -771,12 +822,20 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 
 	ret = advk_pcie_wait_pio(pcie);
 	if (ret < 0) {
+		/*
+		 * If it is possible return Completion Retry Status so caller
+		 * tries to issue the request again instead of failing.
+		 */
+		if (allow_crs) {
+			*val = CFG_RD_CRS_VAL;
+			return PCIBIOS_SUCCESSFUL;
+		}
 		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
 
 	/* Check PIO status and get the read result */
-	ret = advk_pcie_check_pio_status(pcie, val);
+	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
 	if (ret < 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
@@ -845,7 +904,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
-	ret = advk_pcie_check_pio_status(pcie, NULL);
+	ret = advk_pcie_check_pio_status(pcie, false, NULL);
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
-- 
2.20.1

