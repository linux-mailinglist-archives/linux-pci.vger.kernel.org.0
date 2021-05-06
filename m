Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6D37576F
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhEFPfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235765AbhEFPeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0585F6192B;
        Thu,  6 May 2021 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315176;
        bh=REF2cZ76zLLt5itdjPFPEdxTt802EyaUEpYkfKBXnp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bymXLmxPOCNDiGCwPxOj9Ki5Mh1U6YrCM+T34IowpaRXqHyKJzzFPG7dpzU2x029r
         2t4BZmAzPudvus95KmfRSke7U0/JAgR+LnWhsGFKZFMX7AMomrx6hf+Y/1JKgGAYdI
         pNhJWPlEIHhriq/ATU/Cah1LOf/e9EACgvlN0KzoQMgH8vKVEZ2WgAtSL/QoKsYw7e
         PKHlSdx7IAswcp6n1dpK/QsrO4W8NfyhpatlE/+iosj+WqTGHlfDclBD4xzyYc0FS0
         N1EHXcqOdpLUxDFnXpPeH2G4Bl5wII6kTXNZFv6PuYw8Qw4Ca6/G2+ZfPHlE0QH7rY
         xx1oUB2YGeHaw==
Received: by pali.im (Postfix)
        id A8AD1732; Thu,  6 May 2021 17:32:55 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 40/42] PCI: pci-bridge-emul: re-arrange register tests
Date:   Thu,  6 May 2021 17:31:51 +0200
Message-Id: <20210506153153.30454-41-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Re-arrange the tests for which sets of registers are being accessed so that
it is easier to add further regions later. No functional change.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[pali: Fix reading old value in pci_bridge_emul_conf_write]
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 61 ++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 5f8398f8d039..63959e4b188a 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -370,25 +370,25 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	__le32 *cfgspace;
 	const struct pci_bridge_reg_behavior *behavior;
 
-	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END) {
-		*value = 0;
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	if (!bridge->has_pcie && reg >= PCI_BRIDGE_CONF_END) {
+	if (reg < PCI_BRIDGE_CONF_END) {
+		/* Emulated PCI space */
+		read_op = bridge->ops->read_base;
+		cfgspace = (__le32 *) &bridge->conf;
+		behavior = bridge->pci_regs_behavior;
+	} else if (!bridge->has_pcie) {
+		/* PCIe space is not implemented, and no PCI capabilities */
 		*value = 0;
 		return PCIBIOS_SUCCESSFUL;
-	}
-
-	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
+	} else if (reg < PCI_CAP_PCIE_END) {
+		/* Our emulated PCIe capability */
 		reg -= PCI_CAP_PCIE_START;
 		read_op = bridge->ops->read_pcie;
 		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
 	} else {
-		read_op = bridge->ops->read_base;
-		cfgspace = (__le32 *) &bridge->conf;
-		behavior = bridge->pci_regs_behavior;
+		/* Beyond our PCIe space */
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
 	}
 
 	if (read_op)
@@ -432,11 +432,27 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	__le32 *cfgspace;
 	const struct pci_bridge_reg_behavior *behavior;
 
-	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END)
-		return PCIBIOS_SUCCESSFUL;
+	ret = pci_bridge_emul_conf_read(bridge, reg, 4, &old);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
 
-	if (!bridge->has_pcie && reg >= PCI_BRIDGE_CONF_END)
+	if (reg < PCI_BRIDGE_CONF_END) {
+		/* Emulated PCI space */
+		write_op = bridge->ops->write_base;
+		cfgspace = (__le32 *) &bridge->conf;
+		behavior = bridge->pci_regs_behavior;
+	} else if (!bridge->has_pcie) {
+		/* PCIe space is not implemented, and no PCI capabilities */
 		return PCIBIOS_SUCCESSFUL;
+	} else if (reg < PCI_CAP_PCIE_END) {
+		/* Our emulated PCIe capability */
+		reg -= PCI_CAP_PCIE_START;
+		write_op = bridge->ops->write_pcie;
+		cfgspace = (__le32 *) &bridge->pcie_conf;
+		behavior = bridge->pcie_cap_regs_behavior;
+	} else {
+		return PCIBIOS_SUCCESSFUL;
+	}
 
 	shift = (where & 0x3) * 8;
 
@@ -449,21 +465,6 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	ret = pci_bridge_emul_conf_read(bridge, reg, 4, &old);
-	if (ret != PCIBIOS_SUCCESSFUL)
-		return ret;
-
-	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
-		reg -= PCI_CAP_PCIE_START;
-		write_op = bridge->ops->write_pcie;
-		cfgspace = (__le32 *) &bridge->pcie_conf;
-		behavior = bridge->pcie_cap_regs_behavior;
-	} else {
-		write_op = bridge->ops->write_base;
-		cfgspace = (__le32 *) &bridge->conf;
-		behavior = bridge->pci_regs_behavior;
-	}
-
 	/* Keep all bits, except the RW bits */
 	new = old & (~mask | ~behavior[reg / 4].rw);
 
-- 
2.20.1

