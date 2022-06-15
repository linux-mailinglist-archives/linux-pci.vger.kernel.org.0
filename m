Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4454D514
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiFOXQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347762AbiFOXQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5F31233;
        Wed, 15 Jun 2022 16:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E3226199C;
        Wed, 15 Jun 2022 23:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D7C3411A;
        Wed, 15 Jun 2022 23:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334969;
        bh=QSnSKTKUmF2B69IgvFcJoWsIu/H9OSZZxzlv5+9t/Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFvW9oy5uGDTNxc8Mxa69AjgF2aWqTk4HwGP0VCaXl2y4M5c0GrRC9JNn4AwckaV5
         +gu5JHmto/XruJWv7Xw+H2dN7Civ3L4yNEbx7gVqg9DohhBDdJuu9xTRE8ZFzwE69T
         lSNKgZtqOjs/L5Le1xPr9t3vxgJ/3DfJwWZSpKXRw2hrYylXSvpcmZSJCb3ykaj6AK
         nvVBGhSUjhvfK9Y+KvkRYcLN2RoJB8U1fNY38ESLVOPCmf6ANwY59eOOQ41YKV3N3P
         2S7Bc5co+nXLRzCL8H4B/1Zv2yqmc9jdLDmBdQxOw6FOfenDL9mkjFNWVctIdvTMJ4
         OAk2OOV7wei2A==
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
Subject: [PATCH v12 03/13] PCI: imx6: Move imx6_pcie_enable_ref_clk() earlier
Date:   Wed, 15 Jun 2022 18:15:41 -0500
Message-Id: <20220615231551.1054753-4-helgaas@kernel.org>
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

Move imx6_pcie_enable_ref_clk() earlier so it's not in the middle between
imx6_pcie_assert_core_reset() and imx6_pcie_deassert_core_reset().  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 96 +++++++++++++--------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e63eb6380020..a6d2b907d42b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -520,54 +520,6 @@ static int imx6_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
-{
-	struct device *dev = imx6_pcie->pci->dev;
-
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-	case IMX8MQ:
-		reset_control_assert(imx6_pcie->pciephy_reset);
-		fallthrough;
-	case IMX8MM:
-		reset_control_assert(imx6_pcie->apps_reset);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-		/* Force PCIe PHY reset */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
-				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
-		break;
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_SW_RST,
-				   IMX6Q_GPR1_PCIE_SW_RST);
-		break;
-	case IMX6Q:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
-		break;
-	}
-
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
-		int ret = regulator_disable(imx6_pcie->vpcie);
-
-		if (ret)
-			dev_err(dev, "failed to disable vpcie regulator: %d\n",
-				ret);
-	}
-
-	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio))
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					imx6_pcie->gpio_active_high);
-}
-
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -628,6 +580,54 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
+static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
+{
+	struct device *dev = imx6_pcie->pci->dev;
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX7D:
+	case IMX8MQ:
+		reset_control_assert(imx6_pcie->pciephy_reset);
+		fallthrough;
+	case IMX8MM:
+		reset_control_assert(imx6_pcie->apps_reset);
+		break;
+	case IMX6SX:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
+		break;
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_SW_RST,
+				   IMX6Q_GPR1_PCIE_SW_RST);
+		break;
+	case IMX6Q:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+		break;
+	}
+
+	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
+		int ret = regulator_disable(imx6_pcie->vpcie);
+
+		if (ret)
+			dev_err(dev, "failed to disable vpcie regulator: %d\n",
+				ret);
+	}
+
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio))
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					imx6_pcie->gpio_active_high);
+}
+
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-- 
2.25.1

