Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42B842A9C0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhJLQn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhJLQn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38307610C9;
        Tue, 12 Oct 2021 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056915;
        bh=POaxQMsFYmmfSe6N1OHY94F+jXEsjfJZ3iztSXITKYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHaBCv4tx1YBy6ElPhZpG6j4p1VYXN2LqBm6cejtkk0DBZ+s05Ra+wJ0HTK+bjnfm
         FJpoeZxMLnxz5oxHdi+69O55gw8OzY3kKustHDCRtA0Su3JIcU5FU/2sf5LJ/naRJ6
         pgssM1cN45DL/wCmynOT7UihUTqIrvZot0Enj1pnwFij83g1+oDsNsWiT4Qa1p8EcH
         w/4OOFojS2WLfto3fvJKDWCCY7wcOsnXi+a01KP/qtzqsLQGKhocKT1wrx0CJEX6ka
         /zPd37Zfh+WsfJ7wlIKhaYkiFYcxDUxREjnHGOTzLq12pk8D2fWi2RhaK4MvB1K3cu
         3Io1M+Fodn1GQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 05/14] PCI: aardvark: Fix reading MSI interrupt number
Date:   Tue, 12 Oct 2021 18:41:36 +0200
Message-Id: <20211012164145.14126-6-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

In advk_pcie_handle_msi() the authors expect that when bit i in the W1C
register PCIE_MSI_STATUS_REG is cleared, the PCIE_MSI_PAYLOAD_REG is
updated to contain the MSI number corresponding to index i.

Experiments show that this is not so, and instead PCIE_MSI_PAYLOAD_REG
always contains the number of the last received MSI, overall.

Do not read PCIE_MSI_PAYLOAD_REG register for determining MSI interrupt
number. Since Aardvark already forbids more than 32 interrupts and uses
own allocated hwirq numbers, the msi_idx already corresponds to the
received MSI number.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
Previous patches also touch PCIE_MSI_PAYLOAD_REG (adding comments, fixing
reading of the register) and now we are removing it's usage completely.
This is because we wanted the patches to be atomic and for the kernel to
contain the explanation and comments in it's history.
---
 drivers/pci/controller/pci-aardvark.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 4f232ee1f115..735fd70e8dc3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1306,7 +1306,6 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
-	u16 msi_data;
 	int virq;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
@@ -1317,17 +1316,13 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		/*
-		 * msi_idx contains bits [4:0] of the msi_data and msi_data
-		 * contains 16bit MSI interrupt number
-		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
-		virq = irq_find_mapping(pcie->msi_inner_domain, msi_data);
+
+		virq = irq_find_mapping(pcie->msi_inner_domain, msi_idx);
 		if (virq)
 			generic_handle_irq(virq);
 		else
-			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%02x\n", msi_idx);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.32.0

