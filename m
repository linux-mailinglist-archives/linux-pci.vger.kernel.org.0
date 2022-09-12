Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C475B572C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiILJ1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 05:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILJ1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 05:27:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA625E96;
        Mon, 12 Sep 2022 02:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0140B80C97;
        Mon, 12 Sep 2022 09:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DA0C433C1;
        Mon, 12 Sep 2022 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662974850;
        bh=IhTlDk9RJ8PMcIGhvN5LuOxHP2l88O5c9wNiwk0x0rY=;
        h=From:To:Subject:Date:From;
        b=mIAzGXRKrEiQHfh+QoL+6tZ3nmHVve/QNXC0N84jDwkGG06udOvcfIAs2FPR5sxfG
         QiLPaYhgEnNMIw6WmE7J5RET9xniLsO6RzUFohO0rKz5uXm4mZqT71zDyZFRbXhwKf
         +h0MTSG1y1uBZzFEvRLXA9NDHBEquopnjeLB8R23mi7SbnKxrMDB27xoE7bbgCmF2D
         SqCEb3coEggNYqTWfDo6tMkq/3QyXi5bUsWeK0xRzPOiXONj5cRj8w+V3cl3cblEJ+
         N5hZLQgyF76M4Soa9Jw0kMLLQa8op9NXauzo0OMWmcwjhLoKLPvpL+P15CjTxIHgkb
         H0WD8E/sfOaSw==
Received: by pali.im (Postfix)
        id 8A4B711D3; Mon, 12 Sep 2022 11:27:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Cleanup macro names
Date:   Mon, 12 Sep 2022 11:27:22 +0200
Message-Id: <20220912092722.24545-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Use "MVPCIE_" prefix instead of generic "PCIE_" prefix for pci-mvebu.c
specific macros. Define offset macros for Root Port registers and use
standard register macros from pci_regs.h when accessing Root Port
registers, like PCI_VENDOR_ID, PCI_COMMAND, PCI_CLASS_REVISION,
PCI_REVISION_ID, PCI_SUBSYSTEM_VENDOR_ID.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
This is my last patch for pci-mvebu.c. It is the cleanup of registers
macros and can be applied on top of all other pending patches on the
list.
---
 drivers/pci/controller/pci-mvebu.c | 403 ++++++++++++++---------------
 1 file changed, 200 insertions(+), 203 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 2ef04a8241fc..2a8314442600 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -28,64 +28,61 @@
 /*
  * PCIe unit register offsets.
  */
-#define PCIE_DEV_ID_OFF		0x0000
-#define PCIE_CMD_OFF		0x0004
-#define PCIE_DEV_REV_OFF	0x0008
-#define PCIE_BAR_LO_OFF(n)	(0x0010 + ((n) << 3))
-#define PCIE_BAR_HI_OFF(n)	(0x0014 + ((n) << 3))
-#define PCIE_SSDEV_ID_OFF	0x002c
-#define PCIE_CAP_PCIEXP_OFF	0x0060
-#define PCIE_CAP_PCIERR_OFF	0x0100
-#define PCIE_BAR_CTRL_OFF(n)	(0x1804 + (((n) - 1) * 4))
-#define PCIE_WIN04_CTRL_OFF(n)	(0x1820 + ((n) << 4))
-#define PCIE_WIN04_BASE_OFF(n)	(0x1824 + ((n) << 4))
-#define PCIE_WIN04_REMAP_OFF(n)	(0x182c + ((n) << 4))
-#define PCIE_WIN5_CTRL_OFF	0x1880
-#define PCIE_WIN5_BASE_OFF	0x1884
-#define PCIE_WIN5_REMAP_OFF	0x188c
-#define PCIE_CONF_ADDR_OFF	0x18f8
-#define  PCIE_CONF_ADDR_EN		BIT(31)
-#define  PCIE_CONF_REG(r)		((((r) & 0xf00) << 16) | ((r) & 0xfc))
-#define  PCIE_CONF_BUS(b)		(((b) & 0xff) << 16)
-#define  PCIE_CONF_DEV(d)		(((d) & 0x1f) << 11)
-#define  PCIE_CONF_FUNC(f)		(((f) & 0x7) << 8)
-#define  PCIE_CONF_ADDR(bus, devfn, where) \
-	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))    | \
-	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where) | \
-	 PCIE_CONF_ADDR_EN)
-#define PCIE_CONF_DATA_OFF	0x18fc
-#define PCIE_INT_CAUSE_OFF	0x1900
-#define PCIE_INT_UNMASK_OFF	0x1910
-#define  PCIE_INT_TXREQ_NOLINK		BIT(0)
-#define  PCIE_INT_DET_COR		BIT(8)
-#define  PCIE_INT_DET_NONFATAL		BIT(9)
-#define  PCIE_INT_DET_FATAL		BIT(10)
-#define  PCIE_INT_ERR_FATAL		BIT(16)
-#define  PCIE_INT_ERR_NONFATAL		BIT(17)
-#define  PCIE_INT_ERR_COR		BIT(18)
-#define  PCIE_INT_LINK_FAIL		BIT(23)
-#define  PCIE_INT_INTX(i)		BIT(24+i)
-#define  PCIE_INT_PM_PME		BIT(28)
-#define  PCIE_INT_DET_MASK		(PCIE_INT_DET_COR | PCIE_INT_DET_NONFATAL | PCIE_INT_DET_FATAL)
-#define  PCIE_INT_ERR_MASK		(PCIE_INT_ERR_FATAL | PCIE_INT_ERR_NONFATAL | PCIE_INT_ERR_COR)
-#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
-#define PCIE_CTRL_OFF		0x1a00
-#define  PCIE_CTRL_X1_MODE		BIT(0)
-#define  PCIE_CTRL_RC_MODE		BIT(1)
-#define  PCIE_CTRL_MASTER_HOT_RESET	BIT(24)
-#define PCIE_STAT_OFF		0x1a04
-#define  PCIE_STAT_LINK_DOWN		BIT(0)
-#define  PCIE_STAT_BUS			GENMASK(15, 8)
-#define  PCIE_STAT_DEV			GENMASK(20, 16)
-#define PCIE_SSPL_OFF		0x1a0c
-#define  PCIE_SSPL_VALUE_SHIFT		0
-#define  PCIE_SSPL_VALUE_MASK		GENMASK(7, 0)
-#define  PCIE_SSPL_SCALE_SHIFT		8
-#define  PCIE_SSPL_SCALE_MASK		GENMASK(9, 8)
-#define  PCIE_SSPL_ENABLE		BIT(16)
-#define PCIE_RC_RTSTA_OFF	0x1a14
-#define PCIE_DEBUG_CTRL_OFF	0x1a60
-#define  PCIE_DEBUG_SOFT_RESET		BIT(20)
+#define MVPCIE_ROOT_PORT_PCI_CFG_OFF	0x0000
+#define MVPCIE_ROOT_PORT_PCI_EXP_OFF	0x0060
+#define MVPCIE_ROOT_PORT_PCI_ERR_OFF	0x0100
+#define MVPCIE_BAR_LO_OFF(n)		(0x0010 + ((n) << 3))
+#define MVPCIE_BAR_HI_OFF(n)		(0x0014 + ((n) << 3))
+#define MVPCIE_BAR_CTRL_OFF(n)		(0x1804 + (((n) - 1) * 4))
+#define MVPCIE_WIN04_CTRL_OFF(n)	(0x1820 + ((n) << 4))
+#define MVPCIE_WIN04_BASE_OFF(n)	(0x1824 + ((n) << 4))
+#define MVPCIE_WIN04_REMAP_OFF(n)	(0x182c + ((n) << 4))
+#define MVPCIE_WIN5_CTRL_OFF		0x1880
+#define MVPCIE_WIN5_BASE_OFF		0x1884
+#define MVPCIE_WIN5_REMAP_OFF		0x188c
+#define MVPCIE_CONF_ADDR_OFF		0x18f8
+#define  MVPCIE_CONF_ADDR_EN			BIT(31)
+#define  MVPCIE_CONF_REG(r)			((((r) & 0xf00) << 16) | ((r) & 0xfc))
+#define  MVPCIE_CONF_BUS(b)			(((b) & 0xff) << 16)
+#define  MVPCIE_CONF_DEV(d)			(((d) & 0x1f) << 11)
+#define  MVPCIE_CONF_FUNC(f)			(((f) & 0x7) << 8)
+#define  MVPCIE_CONF_ADDR(bus, devfn, where) \
+	(MVPCIE_CONF_BUS(bus) | MVPCIE_CONF_DEV(PCI_SLOT(devfn))    | \
+	 MVPCIE_CONF_FUNC(PCI_FUNC(devfn)) | MVPCIE_CONF_REG(where) | \
+	 MVPCIE_CONF_ADDR_EN)
+#define MVPCIE_CONF_DATA_OFF		0x18fc
+#define MVPCIE_INT_CAUSE_OFF		0x1900
+#define MVPCIE_INT_UNMASK_OFF		0x1910
+#define  MVPCIE_INT_TXREQ_NOLINK		BIT(0)
+#define  MVPCIE_INT_DET_COR			BIT(8)
+#define  MVPCIE_INT_DET_NONFATAL		BIT(9)
+#define  MVPCIE_INT_DET_FATAL			BIT(10)
+#define  MVPCIE_INT_ERR_FATAL			BIT(16)
+#define  MVPCIE_INT_ERR_NONFATAL		BIT(17)
+#define  MVPCIE_INT_ERR_COR			BIT(18)
+#define  MVPCIE_INT_LINK_FAIL			BIT(23)
+#define  MVPCIE_INT_INTX(i)			BIT(24+i)
+#define  MVPCIE_INT_PM_PME			BIT(28)
+#define  MVPCIE_INT_DET_MASK			(MVPCIE_INT_DET_COR | MVPCIE_INT_DET_NONFATAL | MVPCIE_INT_DET_FATAL)
+#define  MVPCIE_INT_ERR_MASK			(MVPCIE_INT_ERR_FATAL | MVPCIE_INT_ERR_NONFATAL | MVPCIE_INT_ERR_COR)
+#define  MVPCIE_INT_ALL_MASK			GENMASK(31, 0)
+#define MVPCIE_CTRL_OFF			0x1a00
+#define  MVPCIE_CTRL_X1_MODE			BIT(0)
+#define  MVPCIE_CTRL_RC_MODE			BIT(1)
+#define  MVPCIE_CTRL_MASTER_HOT_RESET		BIT(24)
+#define MVPCIE_STAT_OFF			0x1a04
+#define  MVPCIE_STAT_LINK_DOWN			BIT(0)
+#define  MVPCIE_STAT_BUS			GENMASK(15, 8)
+#define  MVPCIE_STAT_DEV			GENMASK(20, 16)
+#define MVPCIE_SSPL_OFF			0x1a0c
+#define  MVPCIE_SSPL_VALUE_SHIFT		0
+#define  MVPCIE_SSPL_VALUE_MASK			GENMASK(7, 0)
+#define  MVPCIE_SSPL_SCALE_SHIFT		8
+#define  MVPCIE_SSPL_SCALE_MASK			GENMASK(9, 8)
+#define  MVPCIE_SSPL_ENABLE			BIT(16)
+#define MVPCIE_RC_RTSTA_OFF		0x1a14
+#define MVPCIE_DEBUG_CTRL_OFF		0x1a60
+#define  MVPCIE_DEBUG_SOFT_RESET		BIT(20)
 
 struct mvebu_pcie_port;
 
@@ -161,7 +158,7 @@ static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
 	bool link_is_up;
 	u16 slotsta;
 
-	link_is_up = !(mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
+	link_is_up = !(mvebu_readl(port, MVPCIE_STAT_OFF) & MVPCIE_STAT_LINK_DOWN);
 
 	if (link_is_up != port->link_was_up) {
 		port->link_was_up = link_is_up;
@@ -182,51 +179,51 @@ static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
 
 static u8 mvebu_pcie_get_local_bus_nr(struct mvebu_pcie_port *port)
 {
-	return (mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_BUS) >> 8;
+	return (mvebu_readl(port, MVPCIE_STAT_OFF) & MVPCIE_STAT_BUS) >> 8;
 }
 
 static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
 
-	stat = mvebu_readl(port, PCIE_STAT_OFF);
-	stat &= ~PCIE_STAT_BUS;
+	stat = mvebu_readl(port, MVPCIE_STAT_OFF);
+	stat &= ~MVPCIE_STAT_BUS;
 	stat |= nr << 8;
-	mvebu_writel(port, stat, PCIE_STAT_OFF);
+	mvebu_writel(port, stat, MVPCIE_STAT_OFF);
 }
 
 static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
 
-	stat = mvebu_readl(port, PCIE_STAT_OFF);
-	stat &= ~PCIE_STAT_DEV;
+	stat = mvebu_readl(port, MVPCIE_STAT_OFF);
+	stat &= ~MVPCIE_STAT_DEV;
 	stat |= nr << 16;
-	mvebu_writel(port, stat, PCIE_STAT_OFF);
+	mvebu_writel(port, stat, MVPCIE_STAT_OFF);
 }
 
 static void mvebu_pcie_disable_wins(struct mvebu_pcie_port *port)
 {
 	int i;
 
-	mvebu_writel(port, 0, PCIE_BAR_LO_OFF(0));
-	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(0));
+	mvebu_writel(port, 0, MVPCIE_BAR_LO_OFF(0));
+	mvebu_writel(port, 0, MVPCIE_BAR_HI_OFF(0));
 
 	for (i = 1; i < 3; i++) {
-		mvebu_writel(port, 0, PCIE_BAR_CTRL_OFF(i));
-		mvebu_writel(port, 0, PCIE_BAR_LO_OFF(i));
-		mvebu_writel(port, 0, PCIE_BAR_HI_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_BAR_CTRL_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_BAR_LO_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_BAR_HI_OFF(i));
 	}
 
 	for (i = 0; i < 5; i++) {
-		mvebu_writel(port, 0, PCIE_WIN04_CTRL_OFF(i));
-		mvebu_writel(port, 0, PCIE_WIN04_BASE_OFF(i));
-		mvebu_writel(port, 0, PCIE_WIN04_REMAP_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_WIN04_CTRL_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_WIN04_BASE_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_WIN04_REMAP_OFF(i));
 	}
 
-	mvebu_writel(port, 0, PCIE_WIN5_CTRL_OFF);
-	mvebu_writel(port, 0, PCIE_WIN5_BASE_OFF);
-	mvebu_writel(port, 0, PCIE_WIN5_REMAP_OFF);
+	mvebu_writel(port, 0, MVPCIE_WIN5_CTRL_OFF);
+	mvebu_writel(port, 0, MVPCIE_WIN5_BASE_OFF);
+	mvebu_writel(port, 0, MVPCIE_WIN5_REMAP_OFF);
 }
 
 /*
@@ -253,13 +250,13 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 		const struct mbus_dram_window *cs = dram->cs + i;
 
 		mvebu_writel(port, cs->base & 0xffff0000,
-			     PCIE_WIN04_BASE_OFF(i));
-		mvebu_writel(port, 0, PCIE_WIN04_REMAP_OFF(i));
+			     MVPCIE_WIN04_BASE_OFF(i));
+		mvebu_writel(port, 0, MVPCIE_WIN04_REMAP_OFF(i));
 		mvebu_writel(port,
 			     ((cs->size - 1) & 0xffff0000) |
 			     (cs->mbus_attr << 8) |
 			     (dram->mbus_dram_target_id << 4) | 1,
-			     PCIE_WIN04_CTRL_OFF(i));
+			     MVPCIE_WIN04_CTRL_OFF(i));
 
 		size += cs->size;
 	}
@@ -269,16 +266,16 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 		size = 1 << fls(size);
 
 	/* Setup BAR[1] to all DRAM banks. */
-	mvebu_writel(port, dram->cs[0].base, PCIE_BAR_LO_OFF(1));
-	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
+	mvebu_writel(port, dram->cs[0].base, MVPCIE_BAR_LO_OFF(1));
+	mvebu_writel(port, 0, MVPCIE_BAR_HI_OFF(1));
 	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
-		     PCIE_BAR_CTRL_OFF(1));
+		     MVPCIE_BAR_CTRL_OFF(1));
 
 	/*
 	 * Point BAR[0] to the device's internal registers.
 	 */
-	mvebu_writel(port, round_down(port->regs.start, SZ_1M), PCIE_BAR_LO_OFF(0));
-	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(0));
+	mvebu_writel(port, round_down(port->regs.start, SZ_1M), MVPCIE_BAR_LO_OFF(0));
+	mvebu_writel(port, 0, MVPCIE_BAR_HI_OFF(0));
 }
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
@@ -286,9 +283,9 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
 
 	/* Setup PCIe controller to Root Complex mode. */
-	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
-	ctrl |= PCIE_CTRL_RC_MODE;
-	mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
+	ctrl = mvebu_readl(port, MVPCIE_CTRL_OFF);
+	ctrl |= MVPCIE_CTRL_RC_MODE;
+	mvebu_writel(port, ctrl, MVPCIE_CTRL_OFF);
 
 	/*
 	 * Set Maximum Link Width to X1 or X4 in Root Port's PCIe Link
@@ -297,15 +294,15 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * be set to number of SerDes PCIe lanes (1 or 4). If this register is
 	 * not set correctly then link with endpoint card is not established.
 	 */
-	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCAP);
+	lnkcap = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCAP);
 	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
 	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
-	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCAP);
+	mvebu_writel(port, lnkcap, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCAP);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
-	cmd = mvebu_readl(port, PCIE_CMD_OFF);
+	cmd = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_COMMAND);
 	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-	mvebu_writel(port, cmd, PCIE_CMD_OFF);
+	mvebu_writel(port, cmd, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_COMMAND);
 
 	/*
 	 * Change Class Code of PCI Bridge device to PCI Bridge (0x6004)
@@ -319,7 +316,7 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * have the same format in Marvell's specification as in PCIe
 	 * specification, but their meaning is totally different and they do
 	 * different things: they are aliased into internal mvebu registers
-	 * (e.g. PCIE_BAR_LO_OFF) and these should not be changed or
+	 * (e.g. MVPCIE_BAR_LO_OFF) and these should not be changed or
 	 * reconfigured by pci device drivers.
 	 *
 	 * Therefore driver uses emulation of PCI Bridge which emulates
@@ -328,10 +325,10 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * directly for simplification, but these registers can be accessed
 	 * also via standard mvebu way for accessing PCI config space.
 	 */
-	dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
+	dev_rev = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_CLASS_REVISION);
 	dev_rev &= ~0xffffff00;
 	dev_rev |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
-	mvebu_writel(port, dev_rev, PCIE_DEV_REV_OFF);
+	mvebu_writel(port, dev_rev, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_CLASS_REVISION);
 
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
@@ -341,20 +338,20 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * PCIe Message when changing status from Dl_Down to Dl_Up and valid
 	 * slot power limit was specified.
 	 */
-	sspl = mvebu_readl(port, PCIE_SSPL_OFF);
-	sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
+	sspl = mvebu_readl(port, MVPCIE_SSPL_OFF);
+	sspl &= ~(MVPCIE_SSPL_VALUE_MASK | MVPCIE_SSPL_SCALE_MASK | MVPCIE_SSPL_ENABLE);
 	if (port->slot_power_limit_value) {
-		sspl |= port->slot_power_limit_value << PCIE_SSPL_VALUE_SHIFT;
-		sspl |= port->slot_power_limit_scale << PCIE_SSPL_SCALE_SHIFT;
-		sspl |= PCIE_SSPL_ENABLE;
+		sspl |= port->slot_power_limit_value << MVPCIE_SSPL_VALUE_SHIFT;
+		sspl |= port->slot_power_limit_scale << MVPCIE_SSPL_SCALE_SHIFT;
+		sspl |= MVPCIE_SSPL_ENABLE;
 	}
-	mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+	mvebu_writel(port, sspl, MVPCIE_SSPL_OFF);
 
 	/* Mask all interrupt sources. */
-	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+	mvebu_writel(port, ~MVPCIE_INT_ALL_MASK, MVPCIE_INT_UNMASK_OFF);
 
 	/* Clear all interrupt causes. */
-	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+	mvebu_writel(port, ~MVPCIE_INT_ALL_MASK, MVPCIE_INT_CAUSE_OFF);
 
 	/*
 	 * Unmask all error interrupts which are internally generated.
@@ -365,9 +362,9 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * interrupt which requires "error" interrupt to be specified in DT.
 	 */
 	if (port->error_irq > 0) {
-		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
-		unmask |= PCIE_INT_DET_MASK;
-		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+		unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
+		unmask |= MVPCIE_INT_DET_MASK;
+		mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 	}
 
 	/*
@@ -378,9 +375,9 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * So enable these interrupts under same conditions.
 	 */
 	if (port->error_irq > 0) {
-		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
-		unmask |= PCIE_INT_TXREQ_NOLINK | PCIE_INT_LINK_FAIL;
-		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+		unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
+		unmask |= MVPCIE_INT_TXREQ_NOLINK | MVPCIE_INT_LINK_FAIL;
+		mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 	}
 
 	/*
@@ -394,10 +391,10 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 * called when some interrupt is triggered.
 	 */
 	if (port->intx_irq <= 0) {
-		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
-		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
-			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
-		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+		unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
+		unmask |= MVPCIE_INT_INTX(0) | MVPCIE_INT_INTX(1) |
+			  MVPCIE_INT_INTX(2) | MVPCIE_INT_INTX(3);
+		mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 	}
 }
 
@@ -421,7 +418,7 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (resource_size(&port->cfg)) {
-		offset = PCIE_CONF_ADDR(bus->number, devfn, where) & ~PCIE_CONF_ADDR_EN;
+		offset = MVPCIE_CONF_ADDR(bus->number, devfn, where) & ~MVPCIE_CONF_ADDR_EN;
 		if (offset >= resource_size(&port->cfg))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -429,10 +426,10 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		if (!conf_data)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	} else {
-		conf_data = port->base + PCIE_CONF_DATA_OFF;
+		conf_data = port->base + MVPCIE_CONF_DATA_OFF;
 
-		mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-			     PCIE_CONF_ADDR_OFF);
+		mvebu_writel(port, MVPCIE_CONF_ADDR(bus->number, devfn, where),
+			     MVPCIE_CONF_ADDR_OFF);
 	}
 
 	switch (size) {
@@ -473,7 +470,7 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (resource_size(&port->cfg)) {
-		offset = PCIE_CONF_ADDR(bus->number, devfn, where) & ~PCIE_CONF_ADDR_EN;
+		offset = MVPCIE_CONF_ADDR(bus->number, devfn, where) & ~MVPCIE_CONF_ADDR_EN;
 		if (offset >= resource_size(&port->cfg))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -481,10 +478,10 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
 		if (!conf_data)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	} else {
-		conf_data = port->base + PCIE_CONF_DATA_OFF;
+		conf_data = port->base + MVPCIE_CONF_DATA_OFF;
 
-		mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-			     PCIE_CONF_ADDR_OFF);
+		mvebu_writel(port, MVPCIE_CONF_ADDR(bus->number, devfn, where),
+			     MVPCIE_CONF_ADDR_OFF);
 	}
 
 	switch (size) {
@@ -670,7 +667,7 @@ mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_COMMAND:
-		*value = mvebu_readl(port, PCIE_CMD_OFF);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_COMMAND);
 		break;
 
 	case PCI_PRIMARY_BUS: {
@@ -695,12 +692,12 @@ mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		 */
 		__le32 *cfgspace = (__le32 *)&bridge->conf;
 		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
-		if ((mvebu_readl(port, PCIE_INT_UNMASK_OFF) &
-		      PCIE_INT_ERR_MASK) == PCIE_INT_ERR_MASK)
+		if ((mvebu_readl(port, MVPCIE_INT_UNMASK_OFF) &
+		      MVPCIE_INT_ERR_MASK) == MVPCIE_INT_ERR_MASK)
 			val |= PCI_BRIDGE_CTL_SERR << 16;
 		else
 			val &= ~(PCI_BRIDGE_CTL_SERR << 16);
-		if (mvebu_readl(port, PCIE_CTRL_OFF) & PCIE_CTRL_MASTER_HOT_RESET)
+		if (mvebu_readl(port, MVPCIE_CTRL_OFF) & MVPCIE_CTRL_MASTER_HOT_RESET)
 			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
 		else
 			val &= ~(PCI_BRIDGE_CTL_BUS_RESET << 16);
@@ -723,11 +720,11 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_EXP_DEVCAP:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCAP);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_DEVCAP);
 		break;
 
 	case PCI_EXP_DEVCTL:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_DEVCTL);
 		break;
 
 	case PCI_EXP_LNKCAP:
@@ -737,13 +734,13 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		 * Additionally enable Data Link Layer Link Active Reporting
 		 * Capable bit as DL_Active indication is provided too.
 		 */
-		*value = (mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCAP) &
+		*value = (mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCAP) &
 			  ~PCI_EXP_LNKCAP_CLKPM) | PCI_EXP_LNKCAP_DLLLARC;
 		break;
 
 	case PCI_EXP_LNKCTL:
-		/* DL_Active indication is provided via PCIE_STAT_OFF */
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL) |
+		/* DL_Active indication is provided via MVPCIE_STAT_OFF */
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCTL) |
 			 (mvebu_pcie_link_up(port) ?
 			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
 		break;
@@ -755,11 +752,11 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		/*
 		 * When slot power limit was not specified in DT then
 		 * ASPL_DISABLE bit is stored only in emulated config space.
-		 * Otherwise reflect status of PCIE_SSPL_ENABLE bit in HW.
+		 * Otherwise reflect status of MVPCIE_SSPL_ENABLE bit in HW.
 		 */
 		if (!port->slot_power_limit_value)
 			val |= slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE;
-		else if (!(mvebu_readl(port, PCIE_SSPL_OFF) & PCIE_SSPL_ENABLE))
+		else if (!(mvebu_readl(port, MVPCIE_SSPL_OFF) & MVPCIE_SSPL_ENABLE))
 			val |= PCI_EXP_SLTCTL_ASPL_DISABLE;
 		/*
 		 * HPIE and DLLSCE bits are stored only in emulated config
@@ -776,24 +773,24 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 	}
 
 	case PCI_EXP_RTCTL:
-		*value = (mvebu_readl(port, PCIE_INT_UNMASK_OFF) &
-			  PCIE_INT_PM_PME) ? PCI_EXP_RTCTL_PMEIE : 0;
+		*value = (mvebu_readl(port, MVPCIE_INT_UNMASK_OFF) &
+			  MVPCIE_INT_PM_PME) ? PCI_EXP_RTCTL_PMEIE : 0;
 		break;
 
 	case PCI_EXP_RTSTA:
-		*value = mvebu_readl(port, PCIE_RC_RTSTA_OFF);
+		*value = mvebu_readl(port, MVPCIE_RC_RTSTA_OFF);
 		break;
 
 	case PCI_EXP_DEVCAP2:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCAP2);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_DEVCAP2);
 		break;
 
 	case PCI_EXP_DEVCTL2:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL2);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_DEVCTL2);
 		break;
 
 	case PCI_EXP_LNKCTL2:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL2);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCTL2);
 		break;
 
 	default:
@@ -824,7 +821,7 @@ mvebu_pci_bridge_emul_ext_conf_read(struct pci_bridge_emul *bridge,
 	case PCI_ERR_ROOT_COMMAND:
 	case PCI_ERR_ROOT_STATUS:
 	case PCI_ERR_ROOT_ERR_SRC:
-		*value = mvebu_readl(port, PCIE_CAP_PCIERR_OFF + reg);
+		*value = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_ERR_OFF + reg);
 		break;
 
 	default:
@@ -843,7 +840,7 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_COMMAND:
-		mvebu_writel(port, new, PCIE_CMD_OFF);
+		mvebu_writel(port, new, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_COMMAND);
 		break;
 
 	case PCI_IO_BASE:
@@ -886,27 +883,27 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_INTERRUPT_LINE:
 		if ((mask & (PCI_BRIDGE_CTL_SERR << 16)) && port->error_irq > 0) {
-			u32 unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+			u32 unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
 			if (new & (PCI_BRIDGE_CTL_SERR << 16))
-				unmask |= PCIE_INT_ERR_MASK;
+				unmask |= MVPCIE_INT_ERR_MASK;
 			else
-				unmask &= ~PCIE_INT_ERR_MASK;
-			mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+				unmask &= ~MVPCIE_INT_ERR_MASK;
+			mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 		}
 		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
-			u32 ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
+			u32 ctrl = mvebu_readl(port, MVPCIE_CTRL_OFF);
 			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
-				ctrl |= PCIE_CTRL_MASTER_HOT_RESET;
+				ctrl |= MVPCIE_CTRL_MASTER_HOT_RESET;
 			else
-				ctrl &= ~PCIE_CTRL_MASTER_HOT_RESET;
-			mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
+				ctrl &= ~MVPCIE_CTRL_MASTER_HOT_RESET;
+			mvebu_writel(port, ctrl, MVPCIE_CTRL_OFF);
 			/*
 			 * When dropping to Detect via Hot Reset, Disable Link
 			 * or Loopback states, the Link Failure interrupt is not
 			 * asserted. So when setting Secondary Bus Reset / Hot
 			 * Reset bit, call link IRQ timer/handler manually.
 			 */
-			if ((ctrl & PCIE_CTRL_MASTER_HOT_RESET) && port->link_was_up) {
+			if ((ctrl & MVPCIE_CTRL_MASTER_HOT_RESET) && port->link_was_up) {
 				port->link_was_up = false;
 				/*
 				 * Link IRQ timer/handler is available only when
@@ -935,7 +932,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_EXP_DEVCTL:
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL);
+		mvebu_writel(port, new, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_DEVCTL);
 		break;
 
 	case PCI_EXP_LNKCTL:
@@ -946,7 +943,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		 */
 		new &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
 
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL);
+		mvebu_writel(port, new, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCTL);
 		/*
 		 * When dropping to Detect via Hot Reset, Disable Link
 		 * or Loopback states, the Link Failure interrupt is not
@@ -970,52 +967,52 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_SLTCTL:
 		/*
-		 * Allow to change PCIE_SSPL_ENABLE bit only when slot power
+		 * Allow to change MVPCIE_SSPL_ENABLE bit only when slot power
 		 * limit was specified in DT and configured into HW.
 		 */
 		if ((mask & PCI_EXP_SLTCTL_ASPL_DISABLE) &&
 		    port->slot_power_limit_value) {
-			u32 sspl = mvebu_readl(port, PCIE_SSPL_OFF);
+			u32 sspl = mvebu_readl(port, MVPCIE_SSPL_OFF);
 			if (new & PCI_EXP_SLTCTL_ASPL_DISABLE)
-				sspl &= ~PCIE_SSPL_ENABLE;
+				sspl &= ~MVPCIE_SSPL_ENABLE;
 			else
-				sspl |= PCIE_SSPL_ENABLE;
-			mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+				sspl |= MVPCIE_SSPL_ENABLE;
+			mvebu_writel(port, sspl, MVPCIE_SSPL_OFF);
 		}
 		break;
 
 	case PCI_EXP_RTSTA:
 		/*
-		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA_OFF)
+		 * PME Status bit in Root Status Register (MVPCIE_RC_RTSTA_OFF)
 		 * is read-only and can be cleared only by writing 0b to the
-		 * Interrupt Cause RW0C register (PCIE_INT_CAUSE_OFF). So
+		 * Interrupt Cause RW0C register (MVPCIE_INT_CAUSE_OFF). So
 		 * clear PME via Interrupt Cause and also set port->pme_pending
 		 * variable to false value to start processing PME interrupts
 		 * in interrupt handler again.
 		 */
 		if (new & PCI_EXP_RTSTA_PME) {
-			mvebu_writel(port, ~PCIE_INT_PM_PME, PCIE_INT_CAUSE_OFF);
+			mvebu_writel(port, ~MVPCIE_INT_PM_PME, MVPCIE_INT_CAUSE_OFF);
 			port->pme_pending = false;
 		}
 		break;
 
 	case PCI_EXP_RTCTL:
 		if ((mask & PCI_EXP_RTCTL_PMEIE) && port->error_irq > 0) {
-			u32 unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+			u32 unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
 			if (new & PCI_EXP_RTCTL_PMEIE)
-				unmask |= PCIE_INT_PM_PME;
+				unmask |= MVPCIE_INT_PM_PME;
 			else
-				unmask &= ~PCIE_INT_PM_PME;
-			mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+				unmask &= ~MVPCIE_INT_PM_PME;
+			mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 		}
 		break;
 
 	case PCI_EXP_DEVCTL2:
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_DEVCTL2);
+		mvebu_writel(port, new, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_DEVCTL2);
 		break;
 
 	case PCI_EXP_LNKCTL2:
-		mvebu_writel(port, new, PCIE_CAP_PCIEXP_OFF + PCI_EXP_LNKCTL2);
+		mvebu_writel(port, new, MVPCIE_ROOT_PORT_PCI_EXP_OFF + PCI_EXP_LNKCTL2);
 		break;
 
 	default:
@@ -1047,7 +1044,7 @@ mvebu_pci_bridge_emul_ext_conf_write(struct pci_bridge_emul *bridge,
 	case PCI_ERR_HEADER_LOG+12:
 	case PCI_ERR_ROOT_COMMAND:
 	case PCI_ERR_ROOT_ERR_SRC:
-		mvebu_writel(port, new, PCIE_CAP_PCIERR_OFF + reg);
+		mvebu_writel(port, new, MVPCIE_ROOT_PORT_PCI_ERR_OFF + reg);
 		break;
 
 	default:
@@ -1072,10 +1069,10 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 {
 	unsigned int bridge_flags = PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD;
 	struct pci_bridge_emul *bridge = &port->bridge;
-	u32 dev_id = mvebu_readl(port, PCIE_DEV_ID_OFF);
-	u32 dev_rev = mvebu_readl(port, PCIE_DEV_REV_OFF);
-	u32 ssdev_id = mvebu_readl(port, PCIE_SSDEV_ID_OFF);
-	u32 pcie_cap = mvebu_readl(port, PCIE_CAP_PCIEXP_OFF);
+	u32 dev_id = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_VENDOR_ID);
+	u32 dev_rev = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_REVISION_ID);
+	u32 ssdev_id = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_SUBSYSTEM_VENDOR_ID);
+	u32 pcie_cap = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_EXP_OFF);
 	u8 pcie_cap_ver = ((pcie_cap >> 16) & PCI_EXP_FLAGS_VERS);
 
 	bridge->conf.vendor = cpu_to_le16(dev_id & 0xffff);
@@ -1136,7 +1133,7 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
 	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
 	bridge->subsystem_id = ssdev_id >> 16;
 	bridge->has_pcie = true;
-	bridge->pcie_start = PCIE_CAP_PCIEXP_OFF;
+	bridge->pcie_start = MVPCIE_ROOT_PORT_PCI_EXP_OFF;
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
@@ -1212,9 +1209,9 @@ static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
 	u32 unmask;
 
 	raw_spin_lock_irqsave(&port->irq_lock, flags);
-	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
-	unmask &= ~PCIE_INT_INTX(hwirq);
-	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
+	unmask &= ~MVPCIE_INT_INTX(hwirq);
+	mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
 }
 
@@ -1226,9 +1223,9 @@ static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
 	u32 unmask;
 
 	raw_spin_lock_irqsave(&port->irq_lock, flags);
-	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
-	unmask |= PCIE_INT_INTX(hwirq);
-	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
+	unmask |= MVPCIE_INT_INTX(hwirq);
+	mvebu_writel(port, unmask, MVPCIE_INT_UNMASK_OFF);
 	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
 }
 
@@ -1341,16 +1338,16 @@ static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
 	u32 cause, unmask, status;
 	u16 slotsta;
 
-	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
-	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	cause = mvebu_readl(port, MVPCIE_INT_CAUSE_OFF);
+	unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
 	status = cause & unmask;
 
 	/* "error" interrupt handler does not process INTX interrupts */
-	status &= ~(PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
-		    PCIE_INT_INTX(2) | PCIE_INT_INTX(3));
+	status &= ~(MVPCIE_INT_INTX(0) | MVPCIE_INT_INTX(1) |
+		    MVPCIE_INT_INTX(2) | MVPCIE_INT_INTX(3));
 
 	/* Process PME interrupt */
-	if ((status & PCIE_INT_PM_PME) && !port->pme_pending) {
+	if ((status & MVPCIE_INT_PM_PME) && !port->pme_pending) {
 		/*
 		 * Do not clear PME interrupt bit in Cause Register as it
 		 * invalidates also content of Root Status Register. Instead
@@ -1364,24 +1361,24 @@ static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
 	}
 
 	/* Process ERR interrupt */
-	if (status & PCIE_INT_ERR_MASK) {
-		mvebu_writel(port, ~PCIE_INT_ERR_MASK, PCIE_INT_CAUSE_OFF);
+	if (status & MVPCIE_INT_ERR_MASK) {
+		mvebu_writel(port, ~MVPCIE_INT_ERR_MASK, MVPCIE_INT_CAUSE_OFF);
 		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
 			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
 	}
 
 	/* Process local ERR interrupt */
-	if (status & PCIE_INT_DET_MASK) {
-		mvebu_writel(port, ~PCIE_INT_DET_MASK, PCIE_INT_CAUSE_OFF);
+	if (status & MVPCIE_INT_DET_MASK) {
+		mvebu_writel(port, ~MVPCIE_INT_DET_MASK, MVPCIE_INT_CAUSE_OFF);
 		if (generic_handle_domain_irq(port->rp_irq_domain, 0) == -EINVAL)
 			dev_err_ratelimited(dev, "unhandled ERR IRQ\n");
 	}
 
 	/* Process No Link and Link Failure interrupts as HP IRQ */
-	if (status & (PCIE_INT_TXREQ_NOLINK | PCIE_INT_LINK_FAIL)) {
+	if (status & (MVPCIE_INT_TXREQ_NOLINK | MVPCIE_INT_LINK_FAIL)) {
 		mvebu_writel(port,
-			     ~(PCIE_INT_TXREQ_NOLINK | PCIE_INT_LINK_FAIL),
-			     PCIE_INT_CAUSE_OFF);
+			     ~(MVPCIE_INT_TXREQ_NOLINK | MVPCIE_INT_LINK_FAIL),
+			     MVPCIE_INT_CAUSE_OFF);
 		if (port->link_was_up) {
 			port->link_was_up = false;
 			slotsta = le16_to_cpu(port->bridge.pcie_conf.slotsta);
@@ -1406,17 +1403,17 @@ static irqreturn_t mvebu_pcie_intx_irq_handler(int irq, void *arg)
 	u32 cause, unmask, status;
 	int i;
 
-	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
-	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	cause = mvebu_readl(port, MVPCIE_INT_CAUSE_OFF);
+	unmask = mvebu_readl(port, MVPCIE_INT_UNMASK_OFF);
 	status = cause & unmask;
 
 	/* "intx" interrupt handler process only INTX interrupts */
-	status &= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
-		  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
+	status &= MVPCIE_INT_INTX(0) | MVPCIE_INT_INTX(1) |
+		  MVPCIE_INT_INTX(2) | MVPCIE_INT_INTX(3);
 
 	/* Process legacy INTx interrupts */
 	for (i = 0; i < PCI_NUM_INTX; i++) {
-		if (!(status & PCIE_INT_INTX(i)))
+		if (!(status & MVPCIE_INT_INTX(i)))
 			continue;
 
 		if (generic_handle_domain_irq(port->intx_irq_domain, i) == -EINVAL)
@@ -1599,7 +1596,7 @@ static int mvebu_pcie_suspend(struct device *dev)
 		struct mvebu_pcie_port *port = pcie->ports + i;
 		if (!port->base)
 			continue;
-		port->saved_pcie_stat = mvebu_readl(port, PCIE_STAT_OFF);
+		port->saved_pcie_stat = mvebu_readl(port, MVPCIE_STAT_OFF);
 	}
 
 	return 0;
@@ -1615,7 +1612,7 @@ static int mvebu_pcie_resume(struct device *dev)
 		struct mvebu_pcie_port *port = pcie->ports + i;
 		if (!port->base)
 			continue;
-		mvebu_writel(port, port->saved_pcie_stat, PCIE_STAT_OFF);
+		mvebu_writel(port, port->saved_pcie_stat, MVPCIE_STAT_OFF);
 		mvebu_pcie_setup_hw(port);
 	}
 
@@ -2165,15 +2162,15 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 			continue;
 
 		/* Disable Root Bridge I/O space, memory space and bus mastering. */
-		cmd = mvebu_readl(port, PCIE_CMD_OFF);
+		cmd = mvebu_readl(port, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_COMMAND);
 		cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-		mvebu_writel(port, cmd, PCIE_CMD_OFF);
+		mvebu_writel(port, cmd, MVPCIE_ROOT_PORT_PCI_CFG_OFF + PCI_COMMAND);
 
 		/* Mask all interrupt sources. */
-		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+		mvebu_writel(port, ~MVPCIE_INT_ALL_MASK, MVPCIE_INT_UNMASK_OFF);
 
 		/* Clear all interrupt causes. */
-		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+		mvebu_writel(port, ~MVPCIE_INT_ALL_MASK, MVPCIE_INT_CAUSE_OFF);
 
 		/* Remove IRQ domains. */
 		if (port->intx_irq_domain) {
@@ -2199,9 +2196,9 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		pci_bridge_emul_cleanup(&port->bridge);
 
 		/* Disable sending Set_Slot_Power_Limit PCIe Message. */
-		sspl = mvebu_readl(port, PCIE_SSPL_OFF);
-		sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
-		mvebu_writel(port, sspl, PCIE_SSPL_OFF);
+		sspl = mvebu_readl(port, MVPCIE_SSPL_OFF);
+		sspl &= ~(MVPCIE_SSPL_VALUE_MASK | MVPCIE_SSPL_SCALE_MASK | MVPCIE_SSPL_ENABLE);
+		mvebu_writel(port, sspl, MVPCIE_SSPL_OFF);
 
 		/* Disable and clear BARs and windows. */
 		mvebu_pcie_disable_wins(port);
-- 
2.20.1

