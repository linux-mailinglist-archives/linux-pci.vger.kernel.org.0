Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB36485541
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiAEPCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:02:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46394 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiAEPCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:02:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4D061791;
        Wed,  5 Jan 2022 15:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6EBC36AEF;
        Wed,  5 Jan 2022 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641394972;
        bh=dOKwtHaPNlkgW3INrUS/DqG3hJgd3fUV+vVGrwrZHco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iavGmojLJJpxaq47kvgt+0bqh6y20VySlglkoPkPcEv32fFMRphi4Z2epNisJDRHo
         EdJKzkZz4aoIKjLlxAoiAZnj3EO9HZa1a1G5Jy80VT1bpPiO41MlYQyR3oMC3/lHYB
         gNbBNw7Fh3to6h8soKg0rM/KL63QYMV6v93NRtjOleoVvokRWZ7IqdmW1UGcDKQSZf
         bDwFfl7sEOurPSYhgQYJVB0pac17oVeMpLwKQS8jCAiSY5+kTrJAXm5syNMytWSKlq
         WMJBEy5GtpqvONNXaZwB5p1juI6shyni5RXxcx8ZGT6wdJ9yUZKcmYfwNCk0J09iqy
         awj+zIuId0SbQ==
Received: by pali.im (Postfix)
        id 32F5B848; Wed,  5 Jan 2022 16:02:50 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/11] PCI: pci-bridge-emul: Re-arrange register tests
Date:   Wed,  5 Jan 2022 16:02:29 +0100
Message-Id: <20220105150239.9628-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105150239.9628-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
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
index 033bbeb99176..56b2cb741498 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -418,25 +418,25 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
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
@@ -480,11 +480,27 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
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
 
@@ -497,21 +513,6 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
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

