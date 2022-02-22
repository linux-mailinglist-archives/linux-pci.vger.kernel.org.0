Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92574BF673
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 11:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiBVKrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 05:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiBVKrY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 05:47:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97768B1095;
        Tue, 22 Feb 2022 02:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3824EB8198E;
        Tue, 22 Feb 2022 10:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84EFC340F0;
        Tue, 22 Feb 2022 10:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645526814;
        bh=T0OQ1LwOMBCaJvSz5mAten5eaCv3anJ8MD7pa93uSwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUdkFXv94Zc1QeW94oUipzL5oBoJG5NzssEFKTrMFoyw8P424Ku3eOcdoXz+R09Xz
         d0TFmL892rIh06+0GozmMNpqTTSnV9+XeUMgakAsHJBzbb8yoxvcjtVVZKmlF/NTu6
         IlI+W80hEiZzhRpW7fTjzeBjjnl/tMVJHNAJ58AhUaoOJ0SKrib2CnexqPO4O2UfE9
         0wip2Yp1Dq/Bf8pWQIn2hZ3uJv3HcJF8P9Voe3hue0uLW5rc5+5fwOcWz1croxcu5V
         RaA6aRxN+WFsUHwKwKM6HBncQO+Ku3CyjcDnKhQL7e77qt/sAR7HiKSfo0TSwbLkZU
         4Qy8qOfn6ipDw==
Received: by pali.im (Postfix)
        id 908E8FDB; Tue, 22 Feb 2022 11:46:53 +0100 (CET)
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
Subject: [PATCH v3 10/12] PCI: mvebu: Fix macro names and comments about legacy interrupts
Date:   Tue, 22 Feb 2022 11:46:23 +0100
Message-Id: <20220222104625.28461-11-pali@kernel.org>
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

Register 0x1910 unmasks interrupts and legacy INTx interrupts are unmasked
because driver does not support individual masking yet.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1e90ab888075..5f8b8b4ddbea 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -54,9 +54,10 @@
 	 PCIE_CONF_ADDR_EN)
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
+#define PCIE_INT_UNMASK_OFF	0x1910
+#define  PCIE_INT_INTX(i)		BIT(24+i)
 #define  PCIE_INT_PM_PME		BIT(28)
-#define PCIE_MASK_OFF		0x1910
-#define  PCIE_MASK_ENABLE_INTS          0x0f000000
+#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define  PCIE_CTRL_RC_MODE		BIT(1)
@@ -235,7 +236,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, lnkcap, cmd, dev_rev, mask;
+	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -288,10 +289,19 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
-	/* Enable interrupt lines A-D. */
-	mask = mvebu_readl(port, PCIE_MASK_OFF);
-	mask |= PCIE_MASK_ENABLE_INTS;
-	mvebu_writel(port, mask, PCIE_MASK_OFF);
+	/*
+	 * Unmask all legacy INTx interrupts as driver does not provide a way
+	 * for masking and unmasking of individual legacy INTx interrupts.
+	 * Legacy INTx are reported via one shared GIC source and therefore
+	 * kernel cannot distinguish which individual legacy INTx was triggered.
+	 * These interrupts are shared, so it should not cause any issue. Just
+	 * performance penalty as every PCIe interrupt handler needs to be
+	 * called when some interrupt is triggered.
+	 */
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
+		  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
+	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
 }
 
 static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
@@ -1458,7 +1468,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		mvebu_writel(port, cmd, PCIE_CMD_OFF);
 
 		/* Mask all interrupt sources. */
-		mvebu_writel(port, 0, PCIE_MASK_OFF);
+		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.20.1

