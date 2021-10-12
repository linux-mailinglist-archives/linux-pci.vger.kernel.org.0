Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8149542A9C6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJLQoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhJLQoF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:44:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8175F61074;
        Tue, 12 Oct 2021 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056923;
        bh=MJeu2fzW5NBLKHSNKakfjSQWhTKiXXkyxY+t9ZoKJv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GptlwadZqxMY48TDvPt4xW5/MbLhpvcBHPw2KXmAfVDICpKlj7h2Mll1JoPBtcebD
         XizntGVvJ2FcI8pwdKL5gtnEaEYtLpQX14chlK6UdmdQOryMUqyZTWF0Yfqh6L0N7F
         eXzs9R3Ar2lom15gPUWua8p+dudzhNrcqtI3fFDtDQhEo+W7WaUl1Hk4sodEf/rUes
         m7YMrzj4j/lrWS6nBrT0PBPcjgTlbg/r111pYDFtMK0+0KxLvj/C9HGTrPgs97p+xw
         dVqkreHXUBO8ox6eGEWs8gQgFAjx9WMMdDzQLdg10I56X63F6teMJ9hK7ncFY5EyQt
         y1kPXUDXdHS/A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 11/14] PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on emulated bridge
Date:   Tue, 12 Oct 2021 18:41:42 +0200
Message-Id: <20211012164145.14126-12-kabel@kernel.org>
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

From very vague, ambiguous and incomplete information from Marvell we
deduced that the 32-bit Aardvark register at address 0x4
(PCIE_CORE_CMD_STATUS_REG), which is not documented for Root Complex mode
in the Functional Specification (only for Endpoint mode), controls two
16-bit PCIe registers: Command Register and Status Registers of PCIe Root
Port.

This means that bit 2 controls bus mastering and forwarding of memory and
I/O requests in the upstream direction. According to PCI specifications
bits [0:2] of Command Register, this should be by default disabled on
reset. So explicitly disable these bits at early setup of the Aardvark
driver.

Remove code which unconditionally enables all 3 bits and let kernel code
(via pci_set_master() function) to handle bus mastering of Root PCIe
Bridge via emulated PCI_COMMAND on emulated bridge.

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # b2a56469d550 ("PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access")
---
 drivers/pci/controller/pci-aardvark.c | 54 +++++++++++++++++++--------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 337b61508799..289cd45ed1ec 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -31,9 +31,6 @@
 /* PCIe core registers */
 #define PCIE_CORE_DEV_ID_REG					0x0
 #define PCIE_CORE_CMD_STATUS_REG				0x4
-#define     PCIE_CORE_CMD_IO_ACCESS_EN				BIT(0)
-#define     PCIE_CORE_CMD_MEM_ACCESS_EN				BIT(1)
-#define     PCIE_CORE_CMD_MEM_IO_REQ_EN				BIT(2)
 #define PCIE_CORE_DEV_REV_REG					0x8
 #define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
@@ -516,6 +513,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = (PCI_VENDOR_ID_MARVELL << 16) | PCI_VENDOR_ID_MARVELL;
 	advk_writel(pcie, reg, VENDOR_ID_REG);
 
+	/* Disable Root Bridge I/O space, memory space and bus mastering */
+	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
+	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
+
 	/* Set Advanced Error Capabilities and Control PF0 register */
 	reg = PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX |
 		PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN |
@@ -620,19 +622,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		advk_pcie_disable_ob_win(pcie, i);
 
 	advk_pcie_train_link(pcie);
-
-	/*
-	 * FIXME: The following register update is suspicious. This register is
-	 * applicable only when the PCI controller is configured for Endpoint
-	 * mode, not as a Root Complex. But apparently when this code is
-	 * removed, some cards stop working. This should be investigated and
-	 * a comment explaining this should be put here.
-	 */
-	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
-	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
-		PCIE_CORE_CMD_IO_ACCESS_EN |
-		PCIE_CORE_CMD_MEM_IO_REQ_EN;
-	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
 }
 
 static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u32 *val)
@@ -761,6 +750,37 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static pci_bridge_emul_read_status_t
+advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
+				    int reg, u32 *value)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case PCI_COMMAND:
+		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+}
+
+static void
+advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
+				     int reg, u32 old, u32 new, u32 mask)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case PCI_COMMAND:
+		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
+		break;
+
+	default:
+		break;
+	}
+}
 
 static pci_bridge_emul_read_status_t
 advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
@@ -862,6 +882,8 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 }
 
 static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
+	.read_base = advk_pci_bridge_emul_base_conf_read,
+	.write_base = advk_pci_bridge_emul_base_conf_write,
 	.read_pcie = advk_pci_bridge_emul_pcie_conf_read,
 	.write_pcie = advk_pci_bridge_emul_pcie_conf_write,
 };
-- 
2.32.0

