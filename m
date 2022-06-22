Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E05540B0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 04:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356237AbiFVC5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVC5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 22:57:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783C33A3F;
        Tue, 21 Jun 2022 19:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0DCCB81C06;
        Wed, 22 Jun 2022 02:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E23C3411C;
        Wed, 22 Jun 2022 02:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655866664;
        bh=+DAkEjyZDVXSjDhctgTH4pNXCRo3pfjqjM5DE9U5ZB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbNPaVHyGxLsLBgmfD9jcxHRpY72GtT1KHjKARb1/MBr3IofApDLPHXkGOSNJiRCC
         RkStxXoFJAytlTDOdtwj5plOHM1Rfz/Co1ki58ESI+1TS2vFw8hoj0LSn2KwyvqIqf
         4HsY7yXljLSnwu66k47I0BP7C/hekkQ+1NMGwjz8r4+PDr4Pjwgy6zdkbdIGCTQGGv
         DZRlsyQz0GmrvZPUhQBuoAmgmMgSq90cY8yPkvaC4vC/OCkWnH0tX1d1Kpi46PLX0P
         0+ggvT9uNIxGM16IrwawSp3kfv+VmLmVGU5spqcgfRURrirjTd401kX2iPM8QU9XKY
         kEbLEKuhSnp/Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Liang He <windhl@126.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] PCI: rcar: Add dev struct for of_device_get_match_data()
Date:   Tue, 21 Jun 2022 21:57:31 -0500
Message-Id: <20220622025732.1359389-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622025732.1359389-1-helgaas@kernel.org>
References: <20220622025732.1359389-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add a struct rcar_variant to hold details about differences between the
different R-Car variants we support.  No functional change intended.

The benefit is that we can find all this information with the existing
single of_device_get_match_data() call.  A subsequent commit will remove
an of_find_matching_node() call by extending this structure.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liang He <windhl@126.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 53 +++++++++++++++----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 997c4df6a1e7..ccf13aafa1e5 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -56,13 +56,19 @@ static void __iomem *pcie_base;
 static struct device *pcie_dev;
 #endif
 
+struct rcar_pcie_host;
+
+struct rcar_variant {
+	int	(*phy_init_fn)(struct rcar_pcie_host *host);
+};
+
 /* Structure representing the PCIe interface */
 struct rcar_pcie_host {
-	struct rcar_pcie	pcie;
-	struct phy		*phy;
-	struct clk		*bus_clk;
-	struct			rcar_msi msi;
-	int			(*phy_init_fn)(struct rcar_pcie_host *host);
+	struct rcar_pcie	  pcie;
+	struct phy		  *phy;
+	struct clk		  *bus_clk;
+	struct rcar_msi		  msi;
+	const struct rcar_variant *variant;
 };
 
 static DEFINE_SPINLOCK(pmsr_lock);
@@ -958,19 +964,26 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie_host *host)
 	return err;
 }
 
+static const struct rcar_variant rcar_h1_data = {
+	.phy_init_fn = rcar_pcie_phy_init_h1,
+};
+
+static const struct rcar_variant rcar_gen2_data = {
+	.phy_init_fn = rcar_pcie_phy_init_gen2,
+};
+
+static const struct rcar_variant rcar_gen3_data = {
+	.phy_init_fn = rcar_pcie_phy_init_gen3,
+};
+
 static const struct of_device_id rcar_pcie_of_match[] = {
-	{ .compatible = "renesas,pcie-r8a7779",
-	  .data = rcar_pcie_phy_init_h1 },
-	{ .compatible = "renesas,pcie-r8a7790",
-	  .data = rcar_pcie_phy_init_gen2 },
-	{ .compatible = "renesas,pcie-r8a7791",
-	  .data = rcar_pcie_phy_init_gen2 },
-	{ .compatible = "renesas,pcie-rcar-gen2",
-	  .data = rcar_pcie_phy_init_gen2 },
-	{ .compatible = "renesas,pcie-r8a7795",
-	  .data = rcar_pcie_phy_init_gen3 },
-	{ .compatible = "renesas,pcie-rcar-gen3",
-	  .data = rcar_pcie_phy_init_gen3 },
+	{ .compatible = "renesas,pcie-r8a7779",   .data = &rcar_h1_data },
+	{ .compatible = "renesas,pcie-r8a7790",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,pcie-r8a7791",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,pcie-rcar-gen2", .data = &rcar_gen2_data },
+
+	{ .compatible = "renesas,pcie-r8a7795",   .data = &rcar_gen3_data },
+	{ .compatible = "renesas,pcie-rcar-gen3", .data = &rcar_gen3_data },
 	{},
 };
 
@@ -1015,8 +1028,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_disable;
 
-	host->phy_init_fn = of_device_get_match_data(dev);
-	err = host->phy_init_fn(host);
+	host->variant = of_device_get_match_data(dev);
+	err = host->variant->phy_init_fn(host);
 	if (err) {
 		dev_err(dev, "failed to init PCIe PHY\n");
 		goto err_clk_disable;
@@ -1084,7 +1097,7 @@ static int __maybe_unused rcar_pcie_resume(struct device *dev)
 		return 0;
 
 	/* Failure to get a link might just be that no cards are inserted */
-	err = host->phy_init_fn(host);
+	err = host->variant->phy_init_fn(host);
 	if (err) {
 		dev_info(dev, "PCIe link down\n");
 		return 0;
-- 
2.25.1

