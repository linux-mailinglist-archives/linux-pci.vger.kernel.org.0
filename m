Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC154D510
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355385AbiFOXRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355290AbiFOXQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E626130F63;
        Wed, 15 Jun 2022 16:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D2CDB821F7;
        Wed, 15 Jun 2022 23:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE03C3411A;
        Wed, 15 Jun 2022 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334988;
        bh=8xHGKslATn5SqjbLCJ4pv8WkiU2h9ra44UFSzepa0O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LptAqZnuuxzXUum9OA3hLJVkODGls+p+ImCwu4SD+XKPZerUrxIvbCX29Deq36orQ
         JNPb7X3PI9WLkkHNq+ssl6laBiHAU6ed8rSVkMJkqaJ8/ZXEgd8SRKrZ0k5UEeVUz4
         TQ3l55j/bAx1TZ4kVsT6t/NAlzUJzWjy8anzwMTG09rjxq0njJzeRTHYUka06+z6/v
         FuF+grwf4xqPejHWzde3Nzl8E9jcwN5hNpgoA28faQfjLGdIrk8k4wcZqljge7JJq+
         Om6n12GLcwA+UA3FXDfzhcTafaGtuDYIgHg87lDMF+RX0aVLxjvuhYYlQdv463zLWw
         Ol2+YaGd7S9qg==
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
Subject: [PATCH v12 12/13] PCI: imx6: Do not hide phy driver callbacks and refine the error handling
Date:   Wed, 15 Jun 2022 18:15:50 -0500
Message-Id: <20220615231551.1054753-13-helgaas@kernel.org>
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

- Move the phy_power_on() to host_init and resume functions from
  imx6_pcie_clk_enable().
- Move the phy_init() to host_init and resume functions from
  imx6_pcie_deassert_core_reset().

Refine the error handling in imx6_pcie_host_init() and
imx6_pcie_resume_noirq() functions accordingly.

[bhelgaas: add "ret" back since it's used again]
Link: https://lore.kernel.org/r/1655189942-12678-9-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 70 +++++++++++++++++++++------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b6e5420d67b6..bd736aff94a3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -639,14 +639,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 		goto err_ref_clk;
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		if (phy_power_on(imx6_pcie->phy))
-			dev_err(dev, "unable to power on PHY\n");
-		break;
-	default:
-		break;
-	}
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 	return 0;
@@ -733,10 +725,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
-	case IMX8MM:
-		if (phy_init(imx6_pcie->phy))
-			dev_err(dev, "waiting for phy ready timeout!\n");
-		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -772,6 +760,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		usleep_range(200, 500);
 		break;
 	case IMX6Q:		/* Nothing to do */
+	case IMX8MM:
 		break;
 	}
 
@@ -923,15 +912,39 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
+	if (imx6_pcie->phy) {
+		ret = phy_power_on(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy power up failed.\n");
+			return ret;
+		}
+	}
+
 	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie host init failed: %d\n", ret);
-		return ret;
+		goto err_phy_off;
+	}
+	if (imx6_pcie->phy) {
+		ret = phy_init(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "waiting for phy ready timeout!\n");
+			goto err_phy_init;
+		}
 	}
 
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
+
+err_phy_init:
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+err_phy_off:
+	if (imx6_pcie->phy)
+		phy_power_off(imx6_pcie->phy);
+	return ret;
 }
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
@@ -1029,18 +1042,47 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 	struct pcie_port *pp = &imx6_pcie->pci->pp;
+	int ret;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
-	imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (imx6_pcie->phy) {
+		ret = phy_power_on(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy power up failed.\n");
+			return ret;
+		}
+	}
+
+	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (ret < 0) {
+		dev_err(dev, "pcie deassert core reset failed: %d.\n", ret);
+		goto err_phy_off;
+	} else if (imx6_pcie->phy) {
+		ret = phy_init(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy init failed.\n");
+			goto err_phy_init;
+		}
+	}
+
 	dw_pcie_setup_rc(pp);
 	if (imx6_pcie->link_is_up)
 		imx6_pcie_start_link(imx6_pcie->pci);
 
 	return 0;
+
+err_phy_init:
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+err_phy_off:
+	if (imx6_pcie->phy)
+		phy_power_off(imx6_pcie->phy);
+	return ret;
 }
 #endif
 
-- 
2.25.1

