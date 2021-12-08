Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC32A46CDA4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhLHGWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48890 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhLHGWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8774DCE200B
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD74C341CD;
        Wed,  8 Dec 2021 06:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944355;
        bh=x6mGO1A2iEumqCE+hexaTyDoxdauLG8AC4qMGkes0Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQO670b2k/F3b3KB91kWSqNy6AeUbKBkbsVIAkbT0qrEqItej/Bk310fWD2mGp0JC
         dwnmWmfAhJGafWYadgayIqeWtBoZFidAPKGooWtdUj3xehH2pnO6IdOLvDHqdKx6kv
         iiMtOob8AYTDR+Fz/QsHiOTEBAZu02ByraHSspPlcbn8NRFesnf0jnDUSYz7wM2fzf
         aN/aSO1NrRBvOZCBOeUwVVQGH859pnRXYJz/RUXc6m07YSBLhJAXwtG+3nOehWVMuG
         cJqysMPIsp9kAH29+0qQuPQyqhs880RHOy9P47/7IZ25kitURojmCLCryU6seWgVWU
         aGLF106MeyTyw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 12/17] PCI: aardvark: Add support for PME interrupts
Date:   Wed,  8 Dec 2021 07:18:46 +0100
Message-Id: <20211208061851.31867-13-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
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
index 1c7485489632..3cf454ddc005 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1495,6 +1495,18 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
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
2.32.0

