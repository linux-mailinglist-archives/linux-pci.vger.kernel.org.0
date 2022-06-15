Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921DB54D529
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiFOXQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350355AbiFOXQS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D83054F;
        Wed, 15 Jun 2022 16:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2AAF6190B;
        Wed, 15 Jun 2022 23:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F8C3411A;
        Wed, 15 Jun 2022 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334976;
        bh=cAJc7R7bE7xqXWor8RIIlSkD8G16T7DVc9c6nA3MW70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmOWlUMWLuGk93fTZdM2ZA5EUc664xLxgGIuWkZjzVD8k+UAoGCr9oqUMl1F7LLAg
         i3HapcV1AhKAkGci/Z6vAgi8VTP4f+dh5yNi54R7m/OwImR8UO/C7UrmzOHeEqb2xw
         DhIZ203TbCbvM4wb3q7187HU6gaAqur25XrZRjRqI8UOPrSO8SDe0kM9KHN0WBKZkI
         q6QQktpxs4xJp8PPor3mq7uocXF+Ocmjj4Q1l/Wuc0QNRAgIHCLvU+kQUenJJCBHtx
         w7X54W+JsYCDdgCb2KDU58M6EWLmb2RRY7+YbEhYdMYTX6+JhsV9/qcPpJUr4iGIIG
         8Tx63dmqF/FOw==
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
Subject: [PATCH v12 06/13] PCI: imx6: Collect clock enables in imx6_pcie_clk_enable()
Date:   Wed, 15 Jun 2022 18:15:44 -0500
Message-Id: <20220615231551.1054753-7-helgaas@kernel.org>
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

From: Richard Zhu <hongxing.zhu@nxp.com>

Encapsulate the i.MX PCIe clock enable operations into one standalone
function, imx6_pcie_clk_enable().  No functional change intended.

[bhelgaas: split pure code moves into separate patches]
Link: https://lore.kernel.org/r/1655189942-12678-2-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 98 ++++++++++++++++-----------
 1 file changed, 58 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f458461880dc..e36ca08a7c51 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -600,6 +600,58 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	}
 }
 
+static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
+{
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie_phy clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie_bus clock\n");
+		goto err_pcie_bus;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clock\n");
+		goto err_pcie;
+	}
+
+	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie ref clock\n");
+		goto err_ref_clk;
+	}
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		if (phy_power_on(imx6_pcie->phy))
+			dev_err(dev, "unable to power on PHY\n");
+		break;
+	default:
+		break;
+	}
+	/* allow the clocks to stabilize */
+	usleep_range(200, 500);
+	return 0;
+
+err_ref_clk:
+	clk_disable_unprepare(imx6_pcie->pcie);
+err_pcie:
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+err_pcie_bus:
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+
+	return ret;
+}
+
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
@@ -660,7 +712,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
+	int ret, err;
 
 	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
 		ret = regulator_enable(imx6_pcie->vpcie);
@@ -671,40 +723,12 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		}
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
+	err = imx6_pcie_clk_enable(imx6_pcie);
+	if (err) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", err);
+		goto err_clks;
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_bus clock\n");
-		goto err_pcie_bus;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clock\n");
-		goto err_pcie;
-	}
-
-	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
-	}
-
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		if (phy_power_on(imx6_pcie->phy))
-			dev_err(dev, "unable to power on PHY\n");
-		break;
-	default:
-		break;
-	}
-	/* allow the clocks to stabilize */
-	usleep_range(200, 500);
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
@@ -763,13 +787,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	return;
 
-err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
-err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
-err_pcie_phy:
+err_clks:
 	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
-- 
2.25.1

