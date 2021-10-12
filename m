Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1251D42A9C1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJLQn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231671AbhJLQn6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95BB961076;
        Tue, 12 Oct 2021 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056916;
        bh=hea+1UVi3ohfhJZI4mMcaUDQQxTJgXwy3BlfutwNhOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEqkI6uaVskBxuedI3jhG7Sql1g5tni1UIO3alo9nIb0VjA8gdTxC2KPlmoC20QMl
         L4HJ3LpnlmdJ4TRJLZwDWC6V+fMHOzTwBN2VWHWVdVKJ8w7wd9EwzJEoKuBc26+U1S
         6bpATiZYSFqMWS/hKzmynEDYXxi0lV5Q2KFaeLw/Vcz3p51ZNGMQcUuSysrGMq6dCp
         cw9XM1/oF23ONtmCMyu/SlAEUy65UZHBVylRMEZKRDNZGlDjbnYpaOMlVaT8OktB6X
         Id2q9+EfDRidOgGtQ9joV2qW4h8n7df4cOsNI2InsbUEqaJIVZ19F1y3Fk+32tgtVO
         XdfbvEgXE3XiQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 06/14] PCI: aardvark: Clear all MSIs at setup
Date:   Tue, 12 Oct 2021 18:41:37 +0200
Message-Id: <20211012164145.14126-7-kabel@kernel.org>
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

We already clear all the other interrupts (ISR0, ISR1, HOST_CTRL_INT).

Define a new macro PCIE_MSI_ALL_MASK and do the same clearing for MSIs,
to ensure that we don't start receiving spurious interrupts.

Use this new mask in advk_pcie_handle_msi();

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 735fd70e8dc3..a5fbe24b9612 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -118,6 +118,7 @@
 #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
+#define     PCIE_MSI_ALL_MASK			GENMASK(31, 0)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
 #define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
 
@@ -548,6 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Clear all interrupts */
+	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
 	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
 	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
@@ -560,7 +562,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
 
 	/* Unmask all MSIs */
-	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
+	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
 
 	/* Enable summary interrupt for GIC SPI source */
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
@@ -1310,7 +1312,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
 	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
-	msi_status = msi_val & ~msi_mask;
+	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
 
 	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
 		if (!(BIT(msi_idx) & msi_status))
-- 
2.32.0

