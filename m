Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53854BF669
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiBVKrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiBVKrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4AA9A74;
        Tue, 22 Feb 2022 02:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF784615B0;
        Tue, 22 Feb 2022 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9696C340F1;
        Tue, 22 Feb 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526806;
        bh=2aT82nIT8kO4HHvh0X2ZN9nxoHzk3wWu8N2BXVWGDGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5qxbbyGd4qWX6gLgzrQZbtVZfKRWAbbRbyld+zQMF3p/rcQMqfnX9BAD8eEigmqE
         YofFQmfHOKC1L1fV5FNhXf3m9XgJIkVfmxe8UFkt2twc/+fSuQYlep31tsrtsGDNQd
         BMA1kbplSUrL9HmhiosIazv31jO6TaUEzNVV8TkV1QB+7PJzcMCwp2sB6+p34y/Izx
         BhmHdCp21oEFErn4bQcQUe5vkbTpXoCAvB1l0Zc7BGotZn67lT4mtR+ajAPCcvD8PB
         0NBfYcRzZo2GFhfRCEZ10D0gh0XtPVZJvhDYQBE/2UbDtrIFUsAAf5ubuVxD2gRmG8
         LDuuL/PaVHGXQ==
Received: by pali.im (Postfix)
        id 8707A2B5E; Tue, 22 Feb 2022 11:46:43 +0100 (CET)
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
Subject: [PATCH v3 01/12] PCI: pci-bridge-emul: Re-arrange register tests
Date:   Tue, 22 Feb 2022 11:46:14 +0100
Message-Id: <20220222104625.28461-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222104625.28461-1-pali@kernel.org>
References: <20220222104625.28461-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Re-arrange the tests for which sets of registers are being accessed so that
it is easier to add further regions later. No functional change.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[pali: Fix reading old value in pci_bridge_emul_conf_write]
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
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

