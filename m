Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EEC488E4A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiAJBvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59508 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiAJBu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B74160F4A
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CD0C36AF5;
        Mon, 10 Jan 2022 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779456;
        bh=dTXgpWiybwA/hCGFY5arTv+LKbZ+aZewd6YanDfyWEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bria5oNNYw5PUQKTKUWUEvjvkv3ubiXrESFz7qIK9VEDpA45nOT1Ch10pR+PEHuy/
         tTU2J8Kr9EEx4tTkUp7VDzC0Q96m9va8X3PJkOPnLtwB7JQAp5BLtFTPoCFwBF7fcC
         IadTwCro5Ll6RmV94Qr/sc6Mgtl7teyfqrmoq+pOW0Qtqsoi/9wbg73qmXufI/PqPy
         HSIHn2q7Z7fokq2I1VMZ36GxyA+RKJ+czveNtyGkishYdlRkdZ1Ex05BdQL6gwo55b
         DmcYWzNXb1SojJBIfEx7JzT/30mkAMRkGpM4c0CsOul6wthh1W8pqvu9k/gWwOXuUo
         cuRkCOxp05Q2A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 16/23] PCI: aardvark: Add support for PME interrupts
Date:   Mon, 10 Jan 2022 02:50:11 +0100
Message-Id: <20220110015018.26359-17-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Currently enabling PCI_EXP_RTSTA_PME bit in PCI_EXP_RTCTL register does
nothing. This is because PCIe PME driver expects to receive PCIe interrupt
defined in PCI_EXP_FLAGS_IRQ register, but aardvark hardware does not
trigger PCIe INTx/MSI interrupt for PME event, rather it triggers custom
aardvark interrupt which this driver is not processing yet.

Fix this issue by handling PME interrupt in advk_pcie_handle_int() and
chaining it to PCIe interrupt 0 with generic_handle_domain_irq() (since
aardvark sets PCI_EXP_FLAGS_IRQ to zero). With this change PCIe PME driver
finally starts receiving PME interrupt.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e7b9ca31c79c..3f2d570bfbb5 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1487,6 +1487,18 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 	isr1_mask = advk_readl(pcie, PCIE_ISR1_MASK_REG);
 	isr1_status = isr1_val & ((~isr1_mask) & PCIE_ISR1_ALL_MASK);
 
+	/* Process PME interrupt */
+	if (isr0_status & PCIE_MSG_PM_PME_MASK) {
+		/*
+		 * Do not clear PME interrupt bit in ISR0, it is cleared by IRQ
+		 * receiver by writing to the PCI_EXP_RTSTA register of emulated
+		 * root bridge. Aardvark HW returns zero for PCI_EXP_FLAGS_IRQ,
+		 * so use PCIe interrupt 0.
+		 */
+		if (generic_handle_domain_irq(pcie->irq_domain, 0) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unhandled PME IRQ\n");
+	}
+
 	/* Process ERR interrupt */
 	if (isr0_status & PCIE_ISR0_ERR_MASK) {
 		advk_writel(pcie, PCIE_ISR0_ERR_MASK, PCIE_ISR0_REG);
-- 
2.34.1

