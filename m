Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69B13B031
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 18:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgANRCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 12:02:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35562 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRCq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 12:02:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so5479711plt.2;
        Tue, 14 Jan 2020 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+lga2oB8K5Ss2Uu6yNflYDGPUmZeE6SY/JusL2fAR8=;
        b=X0z4Ei56FLn458HWuargVdl+kd8CHVATzwkQ7yugIsxLYSRyj7Ysp6xewUSmHBocpW
         8XIX/B8KRRqdOsLk4Rjk6cFn3C+Rf0k6romlEZaCJsSvMYsIs4cgdpgWooTSlWm1+Mzc
         sNvzQIUL0uBzRRFVV5y4XeanmNpoP25Rs+Rf3I0dwmSmTC/lyN2qRxFEM/8pnqRY/Oqd
         bUec9PsIO2d36BCVfDpACU+ioRlgGUNhgw2vlvwOugDPJZqHPC6peiCNjqS+KupYpuov
         UmbDYTPyavTOye4In6KFO3a9YLfJnHLyeVP1fn9ogNmN+hLjpBl7wkAgIKHJI8lAIG0h
         Hneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+lga2oB8K5Ss2Uu6yNflYDGPUmZeE6SY/JusL2fAR8=;
        b=B7e/iFa3+FKfdZSOsRG4jQDIAd2oVbolQCZJ5+N7rCW8dkoaHN7oUGlIERu43KfYVY
         NGy2liLO1Ih81kjgog2HugT7kXl3jfO2ipRXV2I8jBQIBIl2GXaCdVr6CDoSLHasJsK2
         GhIRgn5NaQajm/DarT02eL1abYGixsxkHstqFvOlQgpIiRAIK/Mx70QMAMkOe4sE8Fqc
         GAgDG1Eod1yeZPsQ0kVX5x4Iki+3Gi+crz3D63ltfvhrKswTWTxL/ykTJ/BPmR065gN1
         UCSY0JBW6+puJuVECvObCXrFEimwTKFs0M5X45TEtSRiinpMHbjV9MOZiIr5LeSLkjtq
         UfxQ==
X-Gm-Message-State: APjAAAVEtGahuF/C4mTr5/0JR995Y2caPXXetgSGSJ8+3IVM0hMsT07K
        06vLjNRda7j9Ua/oyHvThszQ8nvD
X-Google-Smtp-Source: APXvYqxFUIKh/fr1rGtVIHfPs5AXKPCZiAnvlSg0dzBq1NcpbElJqq90X2OA7RaV9kWCUHUgwmwxKw==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr26704047plt.306.1579021364635;
        Tue, 14 Jan 2020 09:02:44 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id 3sm18686345pfi.13.2020.01.14.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:02:43 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: Add L1SS support for i.MX8MQ
Date:   Tue, 14 Jan 2020 09:02:31 -0800
Message-Id: <20200114170231.16421-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add code to configure PCI IP block to utilize supported ASPM features.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 72 ++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index acfbd34032a8..3cc94ab7d22b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -40,6 +40,9 @@
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000

+#define IMX8MQ_PCIE_LINK_CAP_L1EL_64US		(0x6 << 15)
+#define IMX8MQ_PCIE_CTRL_APPS_CLK_REQ		BIT(4)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)

 enum imx6_pcie_variants {
@@ -64,12 +67,14 @@ struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
 	bool			gpio_active_high;
+	bool			supports_clkreq;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct clk		*pcie_aux;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*src;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
@@ -421,11 +426,17 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }

+static unsigned int
+imx6_pcie_pciphy_rcr_offset(const struct imx6_pcie *imx6_pcie)
+{
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
+	return imx6_pcie->controller_id == 1 ? 0x48 : 0x2C;
+}
+
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
-	unsigned int offset;
 	int ret = 0;

 	switch (imx6_pcie->drvdata->variant) {
@@ -463,17 +474,19 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 			break;
 		}

-		offset = imx6_pcie_grp_offset(imx6_pcie);
-		/*
-		 * Set the over ride low and enabled
-		 * make sure that REF_CLK is turned on.
-		 */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
-				   0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
-				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+		if (!imx6_pcie->supports_clkreq) {
+			unsigned int offset = imx6_pcie_grp_offset(imx6_pcie);
+			/*
+			 * Set the over ride low and enabled
+			 * make sure that REF_CLK is turned on.
+			 */
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+					   0);
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+					 IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+					 IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
+		}
 		break;
 	}

@@ -547,6 +560,27 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
+		if (imx6_pcie->supports_clkreq) {
+			u32 lcr;
+
+			regmap_update_bits(imx6_pcie->src,
+				imx6_pcie_pciphy_rcr_offset(imx6_pcie),
+				IMX8MQ_PCIE_CTRL_APPS_CLK_REQ,
+				IMX8MQ_PCIE_CTRL_APPS_CLK_REQ);
+			/*
+			 * Configure the L1 latency of rc to less than
+			 * 64us Otherwise, the L1/L1SUB wouldn't be
+			 * enable by ASPM.
+			 */
+			dw_pcie_dbi_ro_wr_en(pci);
+
+			lcr  = dw_pcie_readl_dbi2(pci, PCIE_RC_LCR);
+			lcr &= ~PCI_EXP_LNKCAP_L1EL;
+			lcr |= IMX8MQ_PCIE_LINK_CAP_L1EL_64US;
+			dw_pcie_writel_dbi2(pci, PCIE_RC_LCR, lcr);
+
+			dw_pcie_dbi_ro_wr_dis(pci);
+		}
 		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
@@ -1054,6 +1088,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
+	/*
+	 * Configure dbi_base2 to access DBI space with CS2
+	 * asserted
+	 */
+	pci->dbi_base2 = pci->dbi_base + SZ_1M;

 	/* Fetch GPIOs */
 	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
@@ -1107,6 +1146,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "pcie_aux clock source missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_aux);
 		}
+		imx6_pcie->src =
+			syscon_regmap_lookup_by_compatible("fsl,imx8mq-src");
+		if (IS_ERR(imx6_pcie->src)) {
+			dev_err(dev, "SRC regmap is missing or invalid\n");
+			return PTR_ERR(imx6_pcie->src);
+		}
+
 		/* fall through */
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1179,6 +1225,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}

+	imx6_pcie->supports_clkreq = of_property_read_bool(node,
+							   "supports-clkreq");
 	platform_set_drvdata(pdev, imx6_pcie);

 	ret = imx6_pcie_attach_pd(dev);
--
2.21.0
