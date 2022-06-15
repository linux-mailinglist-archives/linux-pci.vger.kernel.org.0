Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46F54D507
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiFOXQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiFOXQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5122E9D2;
        Wed, 15 Jun 2022 16:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB567B81FE1;
        Wed, 15 Jun 2022 23:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5244CC3411A;
        Wed, 15 Jun 2022 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334965;
        bh=8Nk1lM8ejhDBpfSrhxbf7ohET2bkSRBFmOkP/OAeT3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYScISFZqXBv4Gx8Zaxkg6Stj9YYzNwF1LAsGhDYzm/uUV9ECE9U9DMelj+b5ArVp
         /AEB/eKnBBHFpG0sCejGKyRaLcDEQfyqtRfJPp7O7XMNZNI7Wi9gTP6mi7DKOppuyK
         Jybza/eV8rmhocAqIQqyru1zwUYiOGGexyVHEoTuuNCz6uCkaGcJd5F4aSRTEW135t
         SKfaBvtIEKAd2cFpyqRCz7/c+oerq8ctyQm2dSI+mLLTBszkal5+tHgFIPmjDOQzht
         V5o9YkzSWiEFSX118VIftxDCqBsshuFpwQTcEhILL4OCBp0GVNdXjK+fG37E/e9YYj
         RpEc6D5nxkYGg==
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
Subject: [PATCH v12 01/13] PCI: imx6: Move imx6_pcie_grp_offset(), imx6_pcie_configure_type() earlier
Date:   Wed, 15 Jun 2022 18:15:39 -0500
Message-Id: <20220615231551.1054753-2-helgaas@kernel.org>
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

Move imx6_pcie_grp_offset() and imx6_pcie_configure_type() earlier in the
file since they depend on nothing and are used by several other functions
that will be moved earlier.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 50 +++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7a285fb0f619..8653ca8cbfb9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -146,6 +146,31 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
+{
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MM);
+	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
+}
+
+static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
+{
+	unsigned int mask, val;
+
+	if (imx6_pcie->drvdata->variant == IMX8MQ &&
+	    imx6_pcie->controller_id == 1) {
+		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
+		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+				  PCI_EXP_TYPE_ROOT_PORT);
+	} else {
+		mask = IMX6Q_GPR12_DEVICE_TYPE;
+		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
+				  PCI_EXP_TYPE_ROOT_PORT);
+	}
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+}
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -415,13 +440,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 					imx6_pcie->gpio_active_high);
 }
 
-static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
-{
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
-		imx6_pcie->drvdata->variant != IMX8MM);
-	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
-}
-
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -617,24 +635,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 }
 
-static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
-{
-	unsigned int mask, val;
-
-	if (imx6_pcie->drvdata->variant == IMX8MQ &&
-	    imx6_pcie->controller_id == 1) {
-		mask   = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-		val    = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-				    PCI_EXP_TYPE_ROOT_PORT);
-	} else {
-		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
-				  PCI_EXP_TYPE_ROOT_PORT);
-	}
-
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
-}
-
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
-- 
2.25.1

