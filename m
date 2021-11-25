Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60345DE44
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhKYQHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 11:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356226AbhKYQFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 11:05:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B744610F8;
        Thu, 25 Nov 2021 16:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637856119;
        bh=hS3NA/ZnxaapyiZBcm0lRHNeeMwlMMHhL1Em7n8wGIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+J/2+Oz7C4IIWT+5mkI01HWOKAPOdqF5FoLL62oaLOHi2BmrYum2t4LAbS1yj1Es
         B7WQDTglgMrD00vjVSt+rRRxeDu1UPxP4H57+dCoChh2suV/NyZ8M354qBshw7xn3C
         qR0ndXFcC6NozLgxKJi5DoiPHHFkcZ1mikV8egRlu59keELN6p7Tw1gX0AA+R8dd/f
         pYvXBQcIXoIQ/ANMYvYdVnpnvgSGJhnZLdaVxuP2nGGy6/KdLRkAYoZ+zy5XywwSP6
         RAkaAKpwbfETF2ZkWJaaj5HrMGrE0vASA8xdslqbxVyOkB3+4mVGcKl3kzGL6oR3zk
         2eoB/R3uSKheA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH pci-fixes 2/2] Revert "PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge"
Date:   Thu, 25 Nov 2021 17:01:48 +0100
Message-Id: <20211125160148.26029-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125160148.26029-1-kabel@kernel.org>
References: <20211125160148.26029-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 239edf686c14a9ff926dec2f350289ed7adfefe2.

PCI Bridge which represents aardvark's PCIe Root Port has Expansion ROM
Base Address register at offset 0x30, but its meaning is different than
PCI's Expansion ROM BAR register, although the layout is the same.
(This is why we thought it does the same thing.)

First: there is no ROM (or part of BootROM) in the A3720 SOC dedicated
for PCIe Root Port (or controller in RC mode) containing executable code
that would initialize the Root Port, suitable for execution in
bootloader (this is how Expansion ROM BAR is used on x86).

Second: in A3720 spec the register (address D0070030) is not documented
at all for Root Complex mode, but similar to other BAR registers, it has
an "entangled partner" in register D0075920, which does address
translation for the BAR in D0070030:
- the BAR register sets the address from the view of PCIe bus
- the translation register sets the address from the view of the CPU

The other BAR registers also have this entangled partner, and they
can be used to:
- in RC mode: address-checking on the receive side of the RC (they
  can define address ranges for memory accesses from remote Endpoints
  to the RC)
- in Endpoint mode: allow the remote CPU to access memory on A3720

The Expansion ROM BAR has only the Endpoint part documented, but from
the similarities we think that it can also be used in RC mode in that
way.

So either Expansion ROM BAR has different meaning (if the hypothesis
above is true), or we don't know it's meaning (since it is not
documented for RC mode).

Remove the register from the emulated bridge accessing functions.

Fixes: 239edf686c14 ("PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index baa62cdcaab4..e3001b3b3293 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -32,7 +32,6 @@
 #define PCIE_CORE_DEV_ID_REG					0x0
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define PCIE_CORE_DEV_REV_REG					0x8
-#define PCIE_CORE_EXP_ROM_BAR_REG				0x30
 #define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
@@ -774,10 +773,6 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 		return PCI_BRIDGE_EMUL_HANDLED;
 
-	case PCI_ROM_ADDRESS1:
-		*value = advk_readl(pcie, PCIE_CORE_EXP_ROM_BAR_REG);
-		return PCI_BRIDGE_EMUL_HANDLED;
-
 	case PCI_INTERRUPT_LINE: {
 		/*
 		 * From the whole 32bit register we support reading from HW only
@@ -810,10 +805,6 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
 		break;
 
-	case PCI_ROM_ADDRESS1:
-		advk_writel(pcie, new, PCIE_CORE_EXP_ROM_BAR_REG);
-		break;
-
 	case PCI_INTERRUPT_LINE:
 		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
 			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
-- 
2.32.0

