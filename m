Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E601488E3B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiAJBue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiAJBua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87EC061748
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E18BB8107B
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA6AC36AF5;
        Mon, 10 Jan 2022 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779428;
        bh=WlK2jvGZlR70DhVFOHRErXdLS0BK+jecbB6nUy5X55c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGKocFOl14XgdbYufSDEkwyQ047cvZVnTNLXO5lVtBhkGqtetN8wWRwatTv+/rZV8
         bwyPbhdU3s6Mw7YOSlK3Z2/DGO1MwPSU7niyKFGoxqQAhssGhFtrsKylsHssphDoJ7
         zFONXEDqZ6BDnlhrlubfZq5X3mQ66llqAkZVFLMvim7Xz7A7sd04Bsa7PuabczYAMQ
         gzMXHp7ybtztkNY/d8VNxkyHo4zbuOCfG88VDR4ucj9iB5hZfFOFDnhqlieRKijFCy
         wSTbwidMyFcfLBpNZht+ml+JKkHXsGkTuFKQxt/C+ljL+qePO6yUqmJMyOnzuLiVNQ
         CiQCbQr1kAJJA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 02/23] PCI: aardvark: Fix reading MSI interrupt number
Date:   Mon, 10 Jan 2022 02:49:57 +0100
Message-Id: <20220110015018.26359-3-kabel@kernel.org>
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
 drivers/pci/controller/pci-aardvark.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 62baddd2ca95..fd95ad64c887 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1393,7 +1393,6 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
-	u16 msi_data;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
@@ -1403,13 +1402,9 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		/*
-		 * msi_idx contains bits [4:0] of the msi_data and msi_data
-		 * contains 16bit MSI interrupt number
-		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
-		generic_handle_irq(msi_data);
+		if (generic_handle_domain_irq(pcie->msi_inner_domain, msi_idx) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%02x\n", msi_idx);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.34.1

