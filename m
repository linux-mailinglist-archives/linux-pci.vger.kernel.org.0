Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71854D521
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346333AbiFOXQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348831AbiFOXQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D649B3153D;
        Wed, 15 Jun 2022 16:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736786190B;
        Wed, 15 Jun 2022 23:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37C5C3411A;
        Wed, 15 Jun 2022 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334973;
        bh=6n0tIEHZZvt8rxIbib1rB35al+cRkpgFY2U5/42NqDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLicyyvw9fcDSit3P0wBpq8LeyLA15p1xaJp8YkJsbYlLTeED/wsSPUqx2JNRDw3A
         z5ywyl9o5NxMys+hUrZ5EdUfArCtnB3AKoXTR+3Y19T5SjZ4BtQH0quUk5azKOz849
         aWpGyo3qfq5q8iTfjV3wlc92lHmGjmCsd+4grA7ucrJF0HnsfQ7oQoi9jnUFawmWAk
         vGY6jpaukbk6wM/FUtmsEcQtara02WQU8LXOl7S7rb7Pob+FxmAVe5SuRWQ77Ko1G9
         ga9ihGL6YiNEhnCiK1O2/yNiq1FKycaXynhSlpppjj8i7TZgKEbqC8ylBKDN4IRzr7
         atZKOZhqW2rTQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 05/13] PCI: imx6: Factor out ref clock disable to match enable
Date:   Wed, 15 Jun 2022 18:15:43 -0500
Message-Id: <20220615231551.1054753-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615231551.1054753-1-helgaas@kernel.org>
References: <20220615231551.1054753-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The PCIe ref clocks are specific to different variants.  The enables are
already split out into imx6_pcie_enable_ref_clk(), but the disables were
combined with the more generic bus/phy/pcie clock disables in
imx6_pcie_clk_disable().

Split out the variant-specific disables into imx6_pcie_disable_ref_clk() to
match imx6_pcie_enable_ref_clk().

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 38f208eea2d7..f458461880dc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -580,12 +580,8 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
+static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
@@ -595,8 +591,8 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
-	case IMX8MQ:
 	case IMX8MM:
+	case IMX8MQ:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -604,6 +600,14 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 	}
 }
 
+static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
+{
+	clk_disable_unprepare(imx6_pcie->pcie);
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+	imx6_pcie_disable_ref_clk(imx6_pcie);
+}
+
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
-- 
2.25.1

