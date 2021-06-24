Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8EA3B38CA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhFXVgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 17:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232677AbhFXVgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 17:36:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E362E613C3;
        Thu, 24 Jun 2021 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624570441;
        bh=Fu4/t9pMjXwvsBTR1oTGCXyaBjHyoagLyBJfrUrRITM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpFVCcAbGR4zcsWlck2egQvyCOOeASI/B8zSUTp69atLhimEY8pYZlvo1OT7I8gIk
         NgZjPhImZvva8OkleAEER4VUBTLqByhbxDdtzXoRD1UqjLkFdVnvq7mD+NWN599NPQ
         66xw/tQMcjfY7mdpzQbXrVE3AShG2Lki+cZwTzy88yFpVG/fjmIMR9YsHVeWmyHddU
         J1g/8ZAh9C5v5PkT48l2abmi94imL1L3LS6oE6b2kEgADgpzXl1FAE/xGVEsJfexpz
         NzZ9FNqsLYPjcDtPoyKTBy2rKm/tgdCdMdGLbmQbbhTg1rFy95TLJSRtixi6/wKsUC
         ynue32kge/i5w==
Received: by pali.im (Postfix)
        id A284B52D; Thu, 24 Jun 2021 23:34:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/3] PCI: aardvark: Fix checking for PIO status
Date:   Thu, 24 Jun 2021 23:33:44 +0200
Message-Id: <20210624213345.3617-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624213345.3617-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Evan Wang <xswang@marvell.com>

There is an issue that when PCIe switch is connected to an Armada 3700
board, there will be lots of warnings about PIO errors when reading the
config space. According to Aardvark PIO read and write sequence in HW
specification, the current way to check PIO status has the following
issues:

1) For PIO read operation, it reports the error message, which should be
   avoided according to HW specification.

2) For PIO read and write operations, it only checks PIO operation complete
   status, which is not enough, and error status should also be checked.

This patch aligns the code with Aardvark PIO read and write sequence in HW
specification on PIO status check and fix the warnings when reading config
space.

This patch also returns Completion Retry Status value when the read request
timeout, to give the caller a chance to send the request again instead of
failing.

Signed-off-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
Tested-by: Victor Gu <xigu@marvell.com>
[pali: Return CRS also after timeout]
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # b1bd5714472c ("PCI: aardvark: Indicate error in 'val' when config read fails")
---
 drivers/pci/controller/pci-aardvark.c | 93 +++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2f8380a1f84f..a37ba86f1b2d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -58,6 +58,7 @@
 #define   PIO_COMPLETION_STATUS_CRS		2
 #define   PIO_COMPLETION_STATUS_CA		4
 #define   PIO_NON_POSTED_REQ			BIT(10)
+#define   PIO_ERR_STATUS			BIT(11)
 #define PIO_ADDR_LS				(PIO_BASE_ADDR + 0x8)
 #define PIO_ADDR_MS				(PIO_BASE_ADDR + 0xc)
 #define PIO_WR_DATA				(PIO_BASE_ADDR + 0x10)
@@ -176,6 +177,9 @@
 
 #define MSI_IRQ_NUM			32
 
+#define CFG_RD_UR_VAL			0xffffffff
+#define CFG_RD_CRS_VAL			0xffff0001
+
 struct advk_pcie {
 	struct platform_device *pdev;
 	void __iomem *base;
@@ -461,7 +465,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
 }
 
-static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
+static int advk_pcie_check_pio_status(struct advk_pcie *pcie, u32 *val)
 {
 	struct device *dev = &pcie->pdev->dev;
 	u32 reg;
@@ -472,15 +476,50 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 	status = (reg & PIO_COMPLETION_STATUS_MASK) >>
 		PIO_COMPLETION_STATUS_SHIFT;
 
-	if (!status)
-		return;
-
+	/*
+	 * According to HW spec, the PIO status check sequence as below:
+	 * 1) even if COMPLETION_STATUS(bit9:7) indicates successful,
+	 *    it still needs to check Error Status(bit11), only when this bit
+	 *    indicates no error happen, the operation is successful.
+	 * 2) value Unsupported Request(1) of COMPLETION_STATUS(bit9:7) only
+	 *    means a PIO write error, and for PIO read it is successful with
+	 *    a read value of 0xFFFFFFFF.
+	 * 3) value Completion Retry Status(CRS) of COMPLETION_STATUS(bit9:7)
+	 *    only means a PIO write error, and for PIO read it is successful
+	 *    with a read value of 0xFFFF0001.
+	 * 4) value Completer Abort (CA) of COMPLETION_STATUS(bit9:7) means
+	 *    error for both PIO read and PIO write operation.
+	 * 5) other errors are indicated as 'unknown'.
+	 */
 	switch (status) {
+	case PIO_COMPLETION_STATUS_OK:
+		if (reg & PIO_ERR_STATUS) {
+			strcomp_status = "COMP_ERR";
+			break;
+		}
+		/* Get the read result */
+		if (val)
+			*val = advk_readl(pcie, PIO_RD_DATA);
+		/* No error */
+		strcomp_status = NULL;
+		break;
 	case PIO_COMPLETION_STATUS_UR:
-		strcomp_status = "UR";
+		if (val) {
+			/* For reading, UR is not an error status */
+			*val = CFG_RD_UR_VAL;
+			strcomp_status = NULL;
+		} else {
+			strcomp_status = "UR";
+		}
 		break;
 	case PIO_COMPLETION_STATUS_CRS:
-		strcomp_status = "CRS";
+		if (val) {
+			/* For reading, CRS is not an error status */
+			*val = CFG_RD_CRS_VAL;
+			strcomp_status = NULL;
+		} else {
+			strcomp_status = "CRS";
+		}
 		break;
 	case PIO_COMPLETION_STATUS_CA:
 		strcomp_status = "CA";
@@ -490,6 +529,9 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 		break;
 	}
 
+	if (!strcomp_status)
+		return 0;
+
 	if (reg & PIO_NON_POSTED_REQ)
 		str_posted = "Non-posted";
 	else
@@ -497,6 +539,8 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 
 	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
+
+	return -EFAULT;
 }
 
 static int advk_pcie_wait_pio(struct advk_pcie *pcie)
@@ -703,8 +747,17 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 						 size, val);
 
 	if (advk_pcie_pio_is_running(pcie)) {
-		*val = 0xffffffff;
-		return PCIBIOS_SET_FAILED;
+		/*
+		 * For PCI_VENDOR_ID register, return Completion Retry Status
+		 * so caller tries to issue the request again insted of failing
+		 */
+		if (where == PCI_VENDOR_ID) {
+			*val = CFG_RD_CRS_VAL;
+			return PCIBIOS_SUCCESSFUL;
+		} else {
+			*val = 0xffffffff;
+			return PCIBIOS_SET_FAILED;
+		}
 	}
 
 	/* Program the control register */
@@ -729,15 +782,27 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	advk_writel(pcie, 1, PIO_START);
 
 	ret = advk_pcie_wait_pio(pcie);
+	if (ret < 0) {
+		/*
+		 * For PCI_VENDOR_ID register, return Completion Retry Status
+		 * so caller tries to issue the request again instead of failing
+		 */
+		if (where == PCI_VENDOR_ID) {
+			*val = CFG_RD_CRS_VAL;
+			return PCIBIOS_SUCCESSFUL;
+		} else {
+			*val = 0xffffffff;
+			return PCIBIOS_SET_FAILED;
+		}
+	}
+
+	/* Check PIO status and get the read result */
+	ret = advk_pcie_check_pio_status(pcie, val);
 	if (ret < 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_SET_FAILED;
 	}
 
-	advk_pcie_check_pio_status(pcie);
-
-	/* Get the read result */
-	*val = advk_readl(pcie, PIO_RD_DATA);
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
 	else if (size == 2)
@@ -801,7 +866,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (ret < 0)
 		return PCIBIOS_SET_FAILED;
 
-	advk_pcie_check_pio_status(pcie);
+	ret = advk_pcie_check_pio_status(pcie, NULL);
+	if (ret < 0)
+		return PCIBIOS_SET_FAILED;
 
 	return PCIBIOS_SUCCESSFUL;
 }
-- 
2.20.1

