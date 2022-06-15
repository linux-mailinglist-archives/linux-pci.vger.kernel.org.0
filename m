Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7454D520
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355999AbiFOXQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352759AbiFOXQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20DB3135B;
        Wed, 15 Jun 2022 16:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3096199D;
        Wed, 15 Jun 2022 23:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B32C3411A;
        Wed, 15 Jun 2022 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334981;
        bh=mrxLuwW6VYNrbcjHq58c7unp1aMAICbpn9ly/gV4ASg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FM5K2aJkpFeURvD/3/dy2vhcGN/VarB0IaQE3Vq93OGfrK8xPLEVBfA4UtVIoh82+
         51oyRBKJnkdrhaxaJq6hzcfHqOzUdWhPR6LVAVFY281iLTIFTMOJsrqxgQmoamFPZK
         DkD3PC75Vr4iuidfAUxT924WHbpVp03ZvgWvXAtZwE/697yR8UAb49/ybR8YxefThh
         aRxaN4ulx6mJiv19xe1KxdDkSldawgOqWgpRskRvY+W3FVfe0yJqYY3uL/74MkYAYe
         fhORMhTEU4nQtYzvnOCmteoi94ODJLKoiInYTbKAJ6EJa/+bhhptM/p88LmoMPduXc
         Mh7X1va7mk+Gg==
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
Subject: [PATCH v12 09/13] PCI: imx6: Turn off regulator when system is in suspend mode
Date:   Wed, 15 Jun 2022 18:15:47 -0500
Message-Id: <20220615231551.1054753-10-helgaas@kernel.org>
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

The driver should undo any enables it did itself. The regulator disable
shouldn't be basing decisions on regulator_is_enabled().

Move the regulator_disable to the suspend function, turn off regulator when
the system is in suspend mode.

To keep the balance of the regulator usage counter, disable the regulator
in shutdown.

Link: https://lore.kernel.org/r/1655189942-12678-6-git-send-email-hongxing.z
hu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6eddd0b5f628..537b8a2e0e3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -670,8 +670,6 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
-
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
@@ -702,14 +700,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
-		int ret = regulator_disable(imx6_pcie->vpcie);
-
-		if (ret)
-			dev_err(dev, "failed to disable vpcie regulator: %d\n",
-				ret);
-	}
-
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio))
 		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
@@ -722,7 +712,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret, err;
 
-	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
+	if (imx6_pcie->vpcie) {
 		ret = regulator_enable(imx6_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
@@ -796,7 +786,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_clks:
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
+	if (imx6_pcie->vpcie) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
 			dev_err(dev, "failed to disable vpcie regulator: %d\n",
@@ -1023,6 +1013,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 		break;
 	}
 
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+
 	return 0;
 }
 
@@ -1269,6 +1262,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx6_pcie_assert_core_reset(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
 }
 
 static const struct imx6_pcie_drvdata drvdata[] = {
-- 
2.25.1

