Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36C346CD9B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhLHGWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhLHGWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE146C061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43108CE1EC8
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C9C341D4;
        Wed,  8 Dec 2021 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944342;
        bh=YIbG5l21IjIEu1q4I6c/AGG2UACPe9BUEBWv1B71YkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJZ+Lx8bEyg+hwZkeSUyJnZC/CdouJjIVUvo1piPwy44jlytX0Uwi892G4jRnHKqA
         NQMUEFjqNHalNcjtiQIM3JybD6RinEMjf9ilrSoShT/EQ7Vul02VVisx82YLBxOwDS
         GcqcCLzKjQcIX2hU1m07Nv/42MzETdGafEp/TLl9aIfjV9v9oof3JeBSjnAb1U4lZW
         spNwsdhmkbwukUMhrmbuZMjcuya+dAolNA8f59ZTp8uPnC/TYje8hg9FdQ92c6Lgtl
         W9wwsIfK67HTXdRpLSueFE32VeQKIRT+OqM2g30ClUNLfdybISf9mwgjqjmgeu3hGr
         777OuClzM85aA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 04/17] PCI: aardvark: Fix reading MSI interrupt number
Date:   Wed,  8 Dec 2021 07:18:38 +0100
Message-Id: <20211208061851.31867-5-kabel@kernel.org>
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
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 681d93a15be1..7ea18f0ab8ad 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1394,7 +1394,6 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
-	u16 msi_data;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
@@ -1404,15 +1403,10 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		/*
-		 * msi_idx contains bits [4:0] of the msi_data and msi_data
-		 * contains 16bit MSI interrupt number
-		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
 
-		if (generic_handle_domain_irq(pcie->msi_inner_domain, msi_data) == -EINVAL)
-			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
+		if (generic_handle_domain_irq(pcie->msi_inner_domain, msi_idx) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_idx);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.32.0

