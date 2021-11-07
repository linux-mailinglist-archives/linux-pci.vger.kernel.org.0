Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4544726C
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKGKHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 05:07:34 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:65327 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhKGKHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 05:07:34 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jf2ami9tyTdRTjf2bm7YIn; Sun, 07 Nov 2021 11:04:50 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Nov 2021 11:04:50 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: xilinx-nwl: Simplify code and fix a memory leak
Date:   Sun,  7 Nov 2021 11:04:43 +0100
Message-Id: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocate space for 'bitmap' in 'struct nwl_msi' at build time instead of
dynamically allocating the memory at runtime.

This simplifies code (especially error handling paths) and avoid some
open-coded arithmetic in allocator arguments

This also fixes a potential memory leak. The bitmap was never freed. It is
now part of a managed resource.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 30 ++++++------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index a72b4f9a2b00..40d070e54ad2 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -146,7 +146,7 @@
 
 struct nwl_msi {			/* MSI information */
 	struct irq_domain *msi_domain;
-	unsigned long *bitmap;
+	DECLARE_BITMAP(bitmap, INT_PCI_MSI_NR);
 	struct irq_domain *dev_domain;
 	struct mutex lock;		/* protect bitmap variable */
 	int irq_msi0;
@@ -335,12 +335,10 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 
 static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
 {
-	struct nwl_msi *msi;
+	struct nwl_msi *msi = &pcie->msi;
 	unsigned long status;
 	u32 bit;
 
-	msi = &pcie->msi;
-
 	while ((status = nwl_bridge_readl(pcie, status_reg)) != 0) {
 		for_each_set_bit(bit, &status, 32) {
 			nwl_bridge_writel(pcie, 1 << bit, status_reg);
@@ -560,30 +558,21 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	struct nwl_msi *msi = &pcie->msi;
 	unsigned long base;
 	int ret;
-	int size = BITS_TO_LONGS(INT_PCI_MSI_NR) * sizeof(long);
 
 	mutex_init(&msi->lock);
 
-	msi->bitmap = kzalloc(size, GFP_KERNEL);
-	if (!msi->bitmap)
-		return -ENOMEM;
-
 	/* Get msi_1 IRQ number */
 	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
-	if (msi->irq_msi1 < 0) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (msi->irq_msi1 < 0)
+		return -EINVAL;
 
 	irq_set_chained_handler_and_data(msi->irq_msi1,
 					 nwl_pcie_msi_handler_high, pcie);
 
 	/* Get msi_0 IRQ number */
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
-	if (msi->irq_msi0 < 0) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (msi->irq_msi0 < 0)
+		return -EINVAL;
 
 	irq_set_chained_handler_and_data(msi->irq_msi0,
 					 nwl_pcie_msi_handler_low, pcie);
@@ -592,8 +581,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
 	if (!ret) {
 		dev_err(dev, "MSI not present\n");
-		ret = -EIO;
-		goto err;
+		return -EIO;
 	}
 
 	/* Enable MSII */
@@ -632,10 +620,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
 
 	return 0;
-err:
-	kfree(msi->bitmap);
-	msi->bitmap = NULL;
-	return ret;
 }
 
 static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
-- 
2.30.2

