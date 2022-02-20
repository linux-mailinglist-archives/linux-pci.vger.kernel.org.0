Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CE4BD106
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbiBTTet (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiBTTeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B3522F2
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1265A60EED
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670B7C340E8;
        Sun, 20 Feb 2022 19:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385664;
        bh=/PnS26xChDA5R/YR7kt1XShfm9aDXqQ1PCUmLWPS9NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p23F61SS/A6CTlR3B8ruMMNQ/J+rEbBDadaEtLw8GomIwF88W90kcvdJoqhGeDORt
         1d6IOlKMSqCrZenHzWV3oBkJDTtwXmKfCyveoiBXj9miVTeVvNhHCBDDNTvhSCTixA
         o6PgEaSclLMoZl2ZLcymvKPKfZCxvzJSd81ch1wX1JGlzspDfcAGEQy0XclaaRSRNI
         bOdoX665CXsDU4YjqQtvxNbqBJ21w9U9xYQxvVzWiTcZAbGrTK7/2t44+sBV3Zkmwh
         ugZf2YqzHId3xeDM7FZjhIzvrZcAkmcG1GmnA+hcfrvmTqC2hmV6CqvF6cCW7rCPPe
         dM6xLFwScRSaw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 14/18] PCI: aardvark: Add clock support
Date:   Sun, 20 Feb 2022 20:33:42 +0100
Message-Id: <20220220193346.23789-15-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

The IP relies on a gated clock. When we will add S2RAM support, this
clock will need to be resumed before any PCIe registers are
accessed. Add support for this clock.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 41127a26c5bc..3b51f47abd72 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -8,6 +8,7 @@
  * Author: Hezi Shahmoon <hezi.shahmoon@marvell.com>
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -297,6 +298,7 @@ struct advk_pcie {
 	struct timer_list link_irq_timer;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
+	struct clk *clk;
 	struct phy *phy;
 };
 
@@ -1813,6 +1815,29 @@ static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		return of_irq_parse_and_map_pci(dev, slot, pin);
 }
 
+static int advk_pcie_setup_clk(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	int ret;
+
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk) && (PTR_ERR(pcie->clk) == -EPROBE_DEFER))
+		return PTR_ERR(pcie->clk);
+
+	/* Old bindings miss the clock handle */
+	if (IS_ERR(pcie->clk)) {
+		dev_warn(dev, "Clock unavailable (%ld)\n", PTR_ERR(pcie->clk));
+		pcie->clk = NULL;
+		return 0;
+	}
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		dev_err(dev, "Clock initialization failed (%d)\n", ret);
+
+	return ret;
+}
+
 static void advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
@@ -1998,6 +2023,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 			 slot_power_limit / 1000,
 			 (slot_power_limit / 100) % 10);
 
+	ret = advk_pcie_setup_clk(pcie);
+	if (ret)
+		return ret;
+
 	ret = advk_pcie_setup_phy(pcie);
 	if (ret)
 		return ret;
@@ -2126,6 +2155,9 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	/* Disable phy */
 	advk_pcie_disable_phy(pcie);
 
+	/* Disable clock */
+	clk_disable_unprepare(pcie->clk);
+
 	return 0;
 }
 
-- 
2.34.1

