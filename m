Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415EC44100E
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 19:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJaSPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 14:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhJaSPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 14:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6335B60E98;
        Sun, 31 Oct 2021 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635703963;
        bh=GcirBOdhWa2HZ1FienGtqUqNm9Cjo2uMfY7X9yTo63o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrAOAiWRVVkdMJZg+LAyV2BUqAZ0efGQNJgoC9eCGq4QlTqwYlSu36h4hQdU+fP2k
         q198QmPRUGKMMm+OA+KG9aV7sC+53FzHwf3basg5w0mGLPjVblmDPos74Jed8sLm5k
         IGrn2VABPLpWqv4pGz0x8bJ93yrkqGe/yAEOMQYMDeB2q75AlNL41U4UZ4xf8JVphQ
         Z+CNIGds92GyvNauY/x1R8Ifw+5i0v+buP+S3BJNcdBSWXHtXvmYTox0EyrqduUmRC
         qojhksoWOsS+/1ywEiguz+smNLMrIuxOY66ZQtCIQzGgHSlbGcREs/pVk5UCCKG0zE
         YZzRKtG0fEAyw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 5/7] PCI: aardvark: Disable bus mastering and mask all interrupts when unbinding driver
Date:   Sun, 31 Oct 2021 19:12:31 +0100
Message-Id: <20211031181233.9976-6-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211031181233.9976-1-kabel@kernel.org>
References: <20211031181233.9976-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Ensure that after driver unbinding PCIe cards are not be able to forward
memory and I/O requests in the upstream direction and that no interrupt can
be triggered.

Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 71ce9f02d596..08b34accfe2f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1695,13 +1695,42 @@ static int advk_pcie_remove(struct platform_device *pdev)
 {
 	struct advk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	u32 val;
 	int i;
 
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
2.32.0

