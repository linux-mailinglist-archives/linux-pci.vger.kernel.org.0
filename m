Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7F4B07C8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 09:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiBJIKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 03:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiBJIKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 03:10:04 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA27D1A6;
        Thu, 10 Feb 2022 00:10:05 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Feb 2022 17:10:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5FAC3205D901;
        Thu, 10 Feb 2022 17:10:05 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 10 Feb 2022 17:10:05 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E9B9EC1E22;
        Thu, 10 Feb 2022 17:10:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 3/3] PCI: uniphier-ep: Add NX1 support
Date:   Thu, 10 Feb 2022 17:09:56 +0900
Message-Id: <1644480596-20037-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add basic support for UniPhier NX1 SoC as non-legacy SoC. This includes
a compatible string, SoC-dependent data containing init() and wait()
functions for the controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 81 +++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 6c035fc45aaa..4d0a587c0ba5 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -31,6 +32,17 @@
 #define PCL_RSTCTRL2			0x0024
 #define PCL_RSTCTRL_PHY_RESET		BIT(0)
 
+#define PCL_PINCTRL0			0x002c
+#define PCL_PERST_PLDN_REGEN		BIT(12)
+#define PCL_PERST_NOE_REGEN		BIT(11)
+#define PCL_PERST_OUT_REGEN		BIT(8)
+#define PCL_PERST_PLDN_REGVAL		BIT(4)
+#define PCL_PERST_NOE_REGVAL		BIT(3)
+#define PCL_PERST_OUT_REGVAL		BIT(0)
+
+#define PCL_PIPEMON			0x0044
+#define PCL_PCLK_ALIVE			BIT(15)
+
 #define PCL_MODE			0x8000
 #define PCL_MODE_REGEN			BIT(8)
 #define PCL_MODE_REGVAL			BIT(0)
@@ -51,6 +63,9 @@
 #define PCL_APP_INTX			0x8074
 #define PCL_APP_INTX_SYS_INT		BIT(0)
 
+#define PCL_APP_PM0			0x8078
+#define PCL_SYS_AUX_PWR_DET		BIT(8)
+
 /* assertion time of INTx in usec */
 #define PCL_INTX_WIDTH_USEC		30
 
@@ -123,6 +138,55 @@ static void uniphier_pcie_pro5_init_ep(struct uniphier_pcie_ep_priv *priv)
 	msleep(100);
 }
 
+static void uniphier_pcie_nx1_init_ep(struct uniphier_pcie_ep_priv *priv)
+{
+	u32 val;
+
+	/* set EP mode */
+	val = readl(priv->base + PCL_MODE);
+	val |= PCL_MODE_REGEN | PCL_MODE_REGVAL;
+	writel(val, priv->base + PCL_MODE);
+
+	/* use auxiliary power detection */
+	val = readl(priv->base + PCL_APP_PM0);
+	val |= PCL_SYS_AUX_PWR_DET;
+	writel(val, priv->base + PCL_APP_PM0);
+
+	/* assert PERST# */
+	val = readl(priv->base + PCL_PINCTRL0);
+	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
+		 | PCL_PERST_PLDN_REGVAL);
+	val |= PCL_PERST_NOE_REGEN | PCL_PERST_OUT_REGEN
+		| PCL_PERST_PLDN_REGEN;
+	writel(val, priv->base + PCL_PINCTRL0);
+
+	uniphier_pcie_ltssm_enable(priv, false);
+
+	usleep_range(100000, 200000);
+
+	/* deassert PERST# */
+	val = readl(priv->base + PCL_PINCTRL0);
+	val |= PCL_PERST_OUT_REGVAL | PCL_PERST_OUT_REGEN;
+	writel(val, priv->base + PCL_PINCTRL0);
+}
+
+static int uniphier_pcie_nx1_wait_ep(struct uniphier_pcie_ep_priv *priv)
+{
+	u32 status;
+	int ret;
+
+	/* wait PIPE clock */
+	ret = readl_poll_timeout(priv->base + PCL_PIPEMON, status,
+				 status & PCL_PCLK_ALIVE, 100000, 1000000);
+	if (ret) {
+		dev_err(priv->pci.dev,
+			"Failed to initialize controller in EP mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int uniphier_pcie_start_link(struct dw_pcie *pci)
 {
 	struct uniphier_pcie_ep_priv *priv = to_uniphier_pcie(pci);
@@ -353,11 +417,28 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 	},
 };
 
+static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
+	.has_gio = false,
+	.init = uniphier_pcie_nx1_init_ep,
+	.wait = uniphier_pcie_nx1_wait_ep,
+	.features = {
+		.linkup_notifier = false,
+		.msi_capable = true,
+		.msix_capable = false,
+		.align = 1 << 12,
+		.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
+	},
+};
+
 static const struct of_device_id uniphier_pcie_ep_match[] = {
 	{
 		.compatible = "socionext,uniphier-pro5-pcie-ep",
 		.data = &uniphier_pro5_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-pcie-ep",
+		.data = &uniphier_nx1_data,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.7.4

