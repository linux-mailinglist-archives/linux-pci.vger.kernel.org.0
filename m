Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12824BF66A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiBVKrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiBVKrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86128580D3;
        Tue, 22 Feb 2022 02:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6F1B81983;
        Tue, 22 Feb 2022 10:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AD2C340F7;
        Tue, 22 Feb 2022 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526807;
        bh=ssTPPpyO85W3TgQhaVc2K7iRSIlo5BVWTFUDBr/Aw1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJCilu/chmljTjRAGHBgm96vhQTkOw8HmQIQsmStUaw+Gg1mWcdKmffajZ1EXrGlo
         JXFFUAxhrJ+dPifveNgzpA590v2wGPKuf4E/X94NKecQO9TLWfTZ4wfBOD0Zt+cBWA
         VfCsm3RTDuxgu+E76qsD3h55B6achk3dQ9FMmb0iRfPKjXVJrryht4dzKb4ud3rGgf
         tVL3MCuQPv1BavNHWFb4Z2qpgsvW7KxX0ZPhOAf7ncyC37mxJKoq7z3k4zGHA0eICW
         LwfDYSAhvan8FX2V7o4NmLRGkzu4LDJiMnnfWWRWMfguNUrU7M3ZcMGF/M07KjbwWT
         /B2VTHFCIjAKQ==
Received: by pali.im (Postfix)
        id A97683FAC; Tue, 22 Feb 2022 11:46:44 +0100 (CET)
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
Subject: [PATCH v3 02/12] PCI: pci-bridge-emul: Add support for PCIe extended capabilities
Date:   Tue, 22 Feb 2022 11:46:15 +0100
Message-Id: <20220222104625.28461-3-pali@kernel.org>
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

Add support for PCIe extended capabilities, which we just redirect to the
emulating driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[pali: Fix writing new value with W1C bits]
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
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

