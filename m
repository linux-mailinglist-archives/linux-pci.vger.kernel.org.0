Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637893F4E96
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhHWQlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 12:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhHWQlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 12:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 105C7613B1;
        Mon, 23 Aug 2021 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629736863;
        bh=cEI+qg5LiFT/MsVm3juyQ/F0QofSoSmzQNAz+sFwK+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VneIWHy9+of7BwhH4vDz9D8npklTIPXWHDLOwbRSoGn6oUWAVKXbkx722Td0Ntzkb
         PVqsnohDZKW5lr1e6IX2yPfsKkykdqbNxJIjW3nMAFXpGUgbvieFYi+IzKxGrM3gOr
         bhMv/J5eq99dAZWiQv24w/KI+k+bayyj7ouR8tfJ0rr3ckY6pv0+MGHO60AF8LXjDJ
         Q0f/VSq+Ow2Tv1Yp0CZLF8bJWF+4EjMgSPQh1GP0lOnnasal8sv7XPUvy3oIvNBdmp
         E/+47t12KriOP3MaSPNssRBXlV2EzeT6BYzWVgtNp0iMFbu108S8CFXF7Tv1bnTjPM
         s4EBnXRh6m/0w==
Received: by pali.im (Postfix)
        id 24CCA251E; Mon, 23 Aug 2021 18:41:01 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: aardvark: Fix reading MSI interrupt number
Date:   Mon, 23 Aug 2021 18:40:31 +0200
Message-Id: <20210823164033.27491-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210823164033.27491-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
 <20210823164033.27491-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Experiments showed that in register PCIE_MSI_PAYLOAD_REG is stored number
of the last received MSI interrupt and not number of MSI interrupt which
belongs to msi_idx bit. Therefore this implies that aardvark HW can cache
only bits [4:0] of received MSI interrupts with effectively means that it
supports only MSI interrupts with numbers 0-31.

Do not read PCIE_MSI_PAYLOAD_REG register for determining MSI interrupt
number. Instead ensure that pci-aardvark.c configures only MSI numbers in
range 0-31 and then msi_idx contains correct received MSI number.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 48fbfa7eb24c..81c4a9ff91a3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1232,7 +1232,6 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
-	u16 msi_data;
 	int virq;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
@@ -1243,17 +1242,13 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		/*
-		 * msi_idx contains bits [4:0] of the msi_data and msi_data
-		 * contains 16bit MSI interrupt number from MSI inner domain
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
2.20.1

