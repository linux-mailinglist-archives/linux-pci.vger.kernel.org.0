Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730B0463561
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhK3N27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 08:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhK3N27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 08:28:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2856C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 05:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4AF73CE198C
        for <linux-pci@vger.kernel.org>; Tue, 30 Nov 2021 13:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6955DC53FD1;
        Tue, 30 Nov 2021 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638278736;
        bh=fAeNKFXV7WUm8K8pBxkbvov2vC1OOlzEhU9AbCAwaN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qj5rKAfmEdHxtUch1dGbepcfIWYxr2EDq2f3Jz8Ldy12zQ++2KDT+Yp2YMAGFGPw4
         sSepQwt5dk4PSSDTA6ik7+sj3zgS6mOsPyxjefe+2XEHNaRCKhc1xdHeJ95fM0AoKt
         gD3/53F0r45r5xNNWzmhzOMgssXQtHPa/8ZKywP9x6UiRUuACDu87cv0+s515e3DtG
         M8kxRxaP4OMYnEo2LaRpuwOJbJG/F4Qp54ninaBvAaECLmcCPhyAdvbOKtI35Sg7qC
         912scYnSne2e7QIoxkcdQpf+zPLHNBlJAh+bvvpl+TMKp0nTI8ZUxdi1e7zFeitNyp
         RnCJR+8d2l6Tw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 04/11] PCI: aardvark: Clear all MSIs at setup
Date:   Tue, 30 Nov 2021 14:25:16 +0100
Message-Id: <20211130132523.28126-5-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130132523.28126-1-kabel@kernel.org>
References: <20211130132523.28126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

We already clear all the other interrupts (ISR0, ISR1, HOST_CTRL_INT).

Define a new macro PCIE_MSI_ALL_MASK and do the same clearing for MSIs,
to ensure that we don't start receiving spurious interrupts.

Use this new mask in advk_pcie_handle_msi();

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 25af189a1052..71ce9f02d596 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -116,6 +116,7 @@
 #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
+#define     PCIE_MSI_ALL_MASK			GENMASK(31, 0)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
 #define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
 
@@ -571,6 +572,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Clear all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
 	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
@@ -583,7 +585,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
 
 	/* Unmask all MSIs */
-	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
+	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
 
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
@@ -1399,7 +1401,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
-	msi_status = msi_val & ~msi_mask;
+	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
 
 	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
 		if (!(BIT(msi_idx) & msi_status))
-- 
2.32.0

