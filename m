Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99657375759
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhEFPeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235538AbhEFPdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E81613C8;
        Thu,  6 May 2021 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315172;
        bh=/zvV+LVq+BiEj5EQTG+PoYjWSGUTXma5kYGSqhsmE2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SO4Lkojzvq1tCkR9lzFTQufbRmYayxaQGTdisCbUsxZ0Z3kWr1XkuhWm+fPrHfxHG
         DX2++QMrlApeHy3cGTI3+Gsmr+CKws/TMblvtyr1bqQSpLFLdMjj9zFSADPqgdZIx0
         DA5eQMjWt4tSv73F4F03zuw2HhYHACD1AbZ37q4od1/d+8aTKC9emiwng6Qxbeghda
         aHACbdDsFgesmZzRt1FxvperRklvPAtnyS5ZSzddI9XYFEZNtYCdiBrxFv/292PLgK
         MaljOZpHcz2yyQ7rb31uZsxQbgvVBnJCE2tX2Yovxpb/NK2e+er7ylKnkrrAzzAgTN
         YV5e48uXIdK0Q==
Received: by pali.im (Postfix)
        id 2E51B89A; Thu,  6 May 2021 17:32:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/42] PCI: aardvark: Disable bus mastering and mask all interrupts when unbinding driver
Date:   Thu,  6 May 2021 17:31:38 +0200
Message-Id: <20210506153153.30454-28-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ensure that after unbinding aardvark driver, PCIe cards are not be able to
forward memory and I/O requests in the upstream direction and also that no
interrupt can be triggered.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
---
 drivers/pci/controller/pci-aardvark.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 92f93ec48d6b..28ddffce1bec 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1453,12 +1453,41 @@ static int advk_pcie_remove(struct platform_device *pdev)
 {
 	struct advk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	u32 val;
 
+	/* Remove PCI bus with all devices */
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
 
+	/* Disable Root Bridge I/O space, memory space and bus mastering */
+	val = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
+	val &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+	advk_writel(pcie, val, PCIE_CORE_CMD_STATUS_REG);
+
+	/* Disable MSI */
+	val = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
+	val &= ~PCIE_CORE_CTRL2_MSI_ENABLE;
+	advk_writel(pcie, val, PCIE_CORE_CTRL2_REG);
+
+	/* Clear MSI address */
+	advk_writel(pcie, 0, PCIE_MSI_ADDR_LOW_REG);
+	advk_writel(pcie, 0, PCIE_MSI_ADDR_HIGH_REG);
+
+	/* Mask all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
+	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
+	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
+	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_MASK_REG);
+
+	/* Clear all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
+	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
+	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
+	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
+
+	/* Remove IRQ domains */
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
-- 
2.20.1

