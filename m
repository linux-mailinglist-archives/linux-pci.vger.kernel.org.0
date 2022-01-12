Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D62D48C6FB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiALPSt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbiALPSi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:18:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA92C061756;
        Wed, 12 Jan 2022 07:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 266DCB81F67;
        Wed, 12 Jan 2022 15:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7E6C36AEA;
        Wed, 12 Jan 2022 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000716;
        bh=YzSw0jzAbp3IOps2JabCEF2fRcUsifDh7TuQoPY2nDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdLceE6/HmquP+9HVKmrBDgoPvGPncj7SewfyVMlpL78YedkvGF9tJQ7nXdlqrEr9
         AN29VF4YlhWTLCnMkGCL8gKAjYGoU1RKcRnnUQwJDnZ5TrkUCOTmiHcpRy3GNqYjCi
         wU/7ABf0lmnaVBAZMMR0JK2TgmlhFlZUKwGR0R/Z8SYbwnJgSAhxXLGBjH7sqi8QSv
         DmXUBrASqYV5pAoGtvTHJSSeR/5+dZSqbDxoTGpMjTRLDR6QTo1ulcntPEeC+LoVQq
         rJph0a8/tSGCcUBcU7np7VibW0dEnhj1uD6xXMLN5BDKig0NaxjaLOZjOEvOi06GTI
         PbWPwGTGGadnQ==
Received: by pali.im (Postfix)
        id 6527422CA; Wed, 12 Jan 2022 16:18:33 +0100 (CET)
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
Subject: [PATCH v2 02/11] PCI: pci-bridge-emul: Add support for PCIe extended capabilities
Date:   Wed, 12 Jan 2022 16:18:05 +0100
Message-Id: <20220112151814.24361-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112151814.24361-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Add support for PCIe extended capabilities, which we just redirect to the
emulating driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[pali: Fix writing new value with W1C bits]
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 77 +++++++++++++++++++++++------------
 drivers/pci/pci-bridge-emul.h | 15 +++++++
 2 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 56b2cb741498..9f4f173f0650 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -433,10 +433,16 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 		read_op = bridge->ops->read_pcie;
 		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
-	} else {
-		/* Beyond our PCIe space */
+	} else if (reg < PCI_CFG_SPACE_SIZE) {
+		/* Rest of PCI space not implemented */
 		*value = 0;
 		return PCIBIOS_SUCCESSFUL;
+	} else {
+		/* PCIe extended capability space */
+		reg -= PCI_CFG_SPACE_SIZE;
+		read_op = bridge->ops->read_ext;
+		cfgspace = NULL;
+		behavior = NULL;
 	}
 
 	if (read_op)
@@ -444,15 +450,20 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	else
 		ret = PCI_BRIDGE_EMUL_NOT_HANDLED;
 
-	if (ret == PCI_BRIDGE_EMUL_NOT_HANDLED)
-		*value = le32_to_cpu(cfgspace[reg / 4]);
+	if (ret == PCI_BRIDGE_EMUL_NOT_HANDLED) {
+		if (cfgspace)
+			*value = le32_to_cpu(cfgspace[reg / 4]);
+		else
+			*value = 0;
+	}
 
 	/*
 	 * Make sure we never return any reserved bit with a value
 	 * different from 0.
 	 */
-	*value &= behavior[reg / 4].ro | behavior[reg / 4].rw |
-		  behavior[reg / 4].w1c;
+	if (behavior)
+		*value &= behavior[reg / 4].ro | behavior[reg / 4].rw |
+			  behavior[reg / 4].w1c;
 
 	if (size == 1)
 		*value = (*value >> (8 * (where & 3))) & 0xff;
@@ -498,8 +509,15 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 		write_op = bridge->ops->write_pcie;
 		cfgspace = (__le32 *) &bridge->pcie_conf;
 		behavior = bridge->pcie_cap_regs_behavior;
-	} else {
+	} else if (reg < PCI_CFG_SPACE_SIZE) {
+		/* Rest of PCI space not implemented */
 		return PCIBIOS_SUCCESSFUL;
+	} else {
+		/* PCIe extended capability space */
+		reg -= PCI_CFG_SPACE_SIZE;
+		write_op = bridge->ops->write_ext;
+		cfgspace = NULL;
+		behavior = NULL;
 	}
 
 	shift = (where & 0x3) * 8;
@@ -513,29 +531,38 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	/* Keep all bits, except the RW bits */
-	new = old & (~mask | ~behavior[reg / 4].rw);
+	if (behavior) {
+		/* Keep all bits, except the RW bits */
+		new = old & (~mask | ~behavior[reg / 4].rw);
 
-	/* Update the value of the RW bits */
-	new |= (value << shift) & (behavior[reg / 4].rw & mask);
+		/* Update the value of the RW bits */
+		new |= (value << shift) & (behavior[reg / 4].rw & mask);
 
-	/* Clear the W1C bits */
-	new &= ~((value << shift) & (behavior[reg / 4].w1c & mask));
+		/* Clear the W1C bits */
+		new &= ~((value << shift) & (behavior[reg / 4].w1c & mask));
+	} else {
+		new = old & ~mask;
+		new |= (value << shift) & mask;
+	}
 
-	/* Save the new value with the cleared W1C bits into the cfgspace */
-	cfgspace[reg / 4] = cpu_to_le32(new);
+	if (cfgspace) {
+		/* Save the new value with the cleared W1C bits into the cfgspace */
+		cfgspace[reg / 4] = cpu_to_le32(new);
+	}
 
-	/*
-	 * Clear the W1C bits not specified by the write mask, so that the
-	 * write_op() does not clear them.
-	 */
-	new &= ~(behavior[reg / 4].w1c & ~mask);
+	if (behavior) {
+		/*
+		 * Clear the W1C bits not specified by the write mask, so that the
+		 * write_op() does not clear them.
+		 */
+		new &= ~(behavior[reg / 4].w1c & ~mask);
 
-	/*
-	 * Set the W1C bits specified by the write mask, so that write_op()
-	 * knows about that they are to be cleared.
-	 */
-	new |= (value << shift) & (behavior[reg / 4].w1c & mask);
+		/*
+		 * Set the W1C bits specified by the write mask, so that write_op()
+		 * knows about that they are to be cleared.
+		 */
+		new |= (value << shift) & (behavior[reg / 4].w1c & mask);
+	}
 
 	if (write_op)
 		write_op(bridge, reg, old, new, mask);
diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index 4953274cac18..6b5f75b2ad02 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -90,6 +90,14 @@ struct pci_bridge_emul_ops {
 	 */
 	pci_bridge_emul_read_status_t (*read_pcie)(struct pci_bridge_emul *bridge,
 						   int reg, u32 *value);
+
+	/*
+	 * Same as ->read_base(), except it is for reading from the
+	 * PCIe extended capability configuration space.
+	 */
+	pci_bridge_emul_read_status_t (*read_ext)(struct pci_bridge_emul *bridge,
+						  int reg, u32 *value);
+
 	/*
 	 * Called when writing to the regular PCI bridge configuration
 	 * space. old is the current value, new is the new value being
@@ -105,6 +113,13 @@ struct pci_bridge_emul_ops {
 	 */
 	void (*write_pcie)(struct pci_bridge_emul *bridge, int reg,
 			   u32 old, u32 new, u32 mask);
+
+	/*
+	 * Same as ->write_base(), except it is for writing from the
+	 * PCIe extended capability configuration space.
+	 */
+	void (*write_ext)(struct pci_bridge_emul *bridge, int reg,
+			  u32 old, u32 new, u32 mask);
 };
 
 struct pci_bridge_reg_behavior;
-- 
2.20.1

