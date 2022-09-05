Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB485AD945
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiIESwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiIESwR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 14:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDF614C;
        Mon,  5 Sep 2022 11:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D2661467;
        Mon,  5 Sep 2022 18:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93853C433D6;
        Mon,  5 Sep 2022 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662403936;
        bh=uYXn4ODMewN8FNKLW3ITPu9bWfeJ/vLE7EUtvluPaPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCKVrG6+DJD8gwdNjZb3JANtK+l84hxHKutZTIzGJOh9M22VuPsJndi5vzXac3M6a
         NgIAGG3Rft51H7//DAyD+p0UQSvNze2kRV5D4fF/xQyqDt+3N2EjYVLCueTTlsPftk
         FOvW/Zoz1AABIkj2q8whQVpeDmTdDCcwzHnemlwv1+YakCw5WGK4JqJry2N+s8OJnh
         9AgfEkkKGB6JQ+2kv3j+BfgmUDJF+KVWey2xd6KaGv9uIgbP2c5YWdZ8vikRJa456N
         d0SFBWy2rdGTwrQmKAd4R5FocJ1DVgveEBE/LpmAk3KtnCZCUjbQhSJ+gZHhkhtnCC
         NgYbk4fduCP1Q==
Received: by pali.im (Postfix)
        id D863820B1; Mon,  5 Sep 2022 20:52:12 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI: mvebu: For consistency add _OFF suffix to all registers
Date:   Mon,  5 Sep 2022 20:51:50 +0200
Message-Id: <20220905185150.22220-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905185150.22220-1-pali@kernel.org>
References: <20220905185150.22220-1-pali@kernel.org>
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

Signed-off-by: Pali Rohár <pali@kernel.org>
---
This patch depends on now accepted patch:
"PCI: pci-bridge-emul: Set position of PCI capabilities to real HW value"
https://lore.kernel.org/linux-pci/20220824112124.21675-1-pali@kernel.org/
---
 drivers/pci/controller/pci-mvebu.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c222dc189567..6ef8c1ee4cbb 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -34,7 +34,7 @@
 #define PCIE_BAR_LO_OFF(n)	(0x0010 + ((n) << 3))
 #define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
 #define PCIE_SSDEV_ID_OFF	0x002c
-#define PCIE_CAP_PCIEXP		0x0060
+#define PCIE_CAP_PCIEXP_OFF	0x0060
 #define PCIE_CAP_PCIERR_OFF	0x0100
 #define PCIE_BAR_CTRL_OFF(n)	(0x1804 + (((n) - 1) * 4))
 #define PCIE_WIN04_CTRL_OFF(n)	(0x1820 + ((n) << 4))
@@ -83,8 +83,8 @@
 #define  PCIE_SSPL_SCALE_SHIFT		8
 #define  PCIE_SSPL_SCALE_MASK		GENMASK(9, 8)
 #define  PCIE_SSPL_ENABLE		BIT(16)
-#define PCIE_RC_RTSTA		0x1a14
-#define PCIE_DEBUG_CTRL         0x1a60
+#define PCIE_RC_RTSTA_OFF	0x1a14
+#define PCIE_DEBUG_CTRL_OFF	0x1a60
 #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
 
 struct mvebu_pcie_port;
@@ -296,10 +296,10 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
 	 * not set correctly then link with endpoint card is not established.
 	 */
-	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
+	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCAP);
 	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
 	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
-	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
+	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCAP);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
 	cmd = mvebu_readl(port, PCIE_CMD_OFF);
@@ -690,11 +690,11 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_EXP_DEVCAP:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCAP);
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCAP);
 		break;
 
 	case PCI_EXP_DEVCTL:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL);
 		break;
 
 	case PCI_EXP_LNKCAP:
@@ -704,13 +704,13 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		 * Additionally enable Data Link Layer Link Active Reporting
 		 * Capable bit as DL_Active indication is provided too.
 		 */
-		*value = (mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
+		*value = (mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCAP) &
 			  ~PCI_EXP_LNKCAP_CLKPM) | PCI_EXP_LNKCAP_DLLLARC;
 		break;
 
 	case PCI_EXP_LNKCTL:
 		/* DL_Active indication is provided via PCIE_STAT_OFF */
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) |
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL) |
 			 (mvebu_pcie_link_up(port) ?
 			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
 		break;
@@ -748,19 +748,19 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_EXP_RTSTA:
-		*value = mvebu_readl(port, PCIE_RC_RTSTA);
+		*value = mvebu_readl(port, PCIE_RC_RTSTA_OFF);
 		break;
 
 	case PCI_EXP_DEVCAP2:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCAP2);
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCAP2);
 		break;
 
 	case PCI_EXP_DEVCTL2:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL2);
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL2);
 		break;
 
 	case PCI_EXP_LNKCTL2:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL2);
 		break;
 
 	default:
@@ -902,7 +902,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_EXP_DEVCTL:
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
+		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL);
 		break;
 
 	case PCI_EXP_LNKCTL:
@@ -913,7 +913,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		 */
 		new &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
 
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
+		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL);
 		/*
 		 * When dropping to Detect via Hot Reset, Disable Link
 		 * or Loopback states, the Link Failure interrupt is not
@@ -953,7 +953,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_RTSTA:
 		/*
-		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
+		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA_OFF)
 		 * is read-only and can be cleared only by writing 0b to the
 		 * Interrupt Cause RW0C register (PCIE_INT_CAUSE_OFF). So
 		 * clear PME via Interrupt Cause and also set port->pme_pending
@@ -978,11 +978,11 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_EXP_DEVCTL2:
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL2);
+		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL2);
 		break;
 
 	case PCI_EXP_LNKCTL2:
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
+		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL2);
 		break;
 
 	default:
@@ -1042,7 +1042,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	u32 dev_id = mvebu_readl(port, PCIE_DEV_ID_OFF);
 	u32 dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
 	u32 ssdev_id = mvebu_readl(port, PCIE_SSDEV_ID_OFF);
-	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP);
+	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF);
 	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
 
 	bridge->conf.vendor = cpu_to_le16(dev_id & 0xffff);
@@ -1103,7 +1103,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
 	bridge->subsystem_id = ssdev_id >> 16;
 	bridge->has_pcie = true;
-	bridge->pcie_start = PCIE_CAP_PCIEXP;
+	bridge->pcie_start = PCIE_CAP_PCIEXP_OFF;
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
-- 
2.20.1

