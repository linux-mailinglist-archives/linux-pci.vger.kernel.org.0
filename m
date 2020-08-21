Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4C24CC41
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHUD4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37033 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgHUD4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:24 -0400
Received: by mail-il1-f195.google.com with SMTP id v2so342181ilq.4;
        Thu, 20 Aug 2020 20:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UY2fPz0NO05RXL9vePRt/cRMQCQrnZKBpfHarfvkz5Q=;
        b=ffLPa/zb74yU/wce7oDtxFnWD/CEYE8bJfUSYv5ukm1Bfy8wCDfBJZDxaxsVVu9HOV
         MpG5V51FZaLt1goLvHoUDd2dqnpk+etYtkYb1TUdOiK8otiIrVkzjIIfdyaBbTEIwwHW
         hAFfEvYIKvjPS3l6FYSH1IQjkA1AEPTvJ1tqhoT09Jc35QK5HwKr2HoEviTYgWleNg6a
         sbOF7M6HbC7cF2G1mLOu3Knd96pu7T1jzzFUrXCbrK0TCTRQKCEe+MpZSGDf9W1EoDdC
         UbYRIa7D4FK3GMj7R+8uDO2k+p7hZQUAudoROlp6lfNL2dm5vjmtGRnptP10BOoXJ8yr
         qjCQ==
X-Gm-Message-State: AOAM531oSludN1WTJ7NynZHvQkkubWQMV+UekErOJtFz4HTIoXzULx+6
        54OtdQ1qww+dGGBK7y4u+XOK397q1Q==
X-Google-Smtp-Source: ABdhPJz5gb7SbCmow1gnu4VRVRjNASATy8ZJ3fF6Oeyl4ezMABhw3IGS66vddsKWQh3VagZpXEQ3Aw==
X-Received: by 2002:a92:914a:: with SMTP id t71mr963369ild.298.1597982183177;
        Thu, 20 Aug 2020 20:56:23 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 28/40] PCI: dwc/imx6: Use common PCI register definitions
Date:   Thu, 20 Aug 2020 21:54:08 -0600
Message-Id: <20200821035420.380495-29-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX6 driver has its own defines for common PCI config space
registers. It also hard codes the capability register offsets which are
discoverable. Convert it to use the standard register definitions.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++-----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2b075a468104..9f6018d3d338 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -94,15 +94,6 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
 #define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
 
-/* PCIe Root Complex registers (memory-mapped) */
-#define PCIE_RC_IMX6_MSI_CAP			0x50
-#define PCIE_RC_LCR				0x7c
-#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
-#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
-#define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
-
-#define PCIE_RC_LCSR				0x80
-
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
 
@@ -759,6 +750,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 tmp;
 	int ret;
 
@@ -767,10 +759,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
-	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
-	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
-	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
+	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+	tmp &= ~PCI_EXP_LNKCAP_SLS;
+	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
 
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
@@ -781,10 +773,10 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 	if (imx6_pcie->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-		tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
-		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
-		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
+		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		tmp &= ~PCI_EXP_LNKCAP_SLS;
+		tmp |= PCI_EXP_LNKCAP_SLS_5_0GB;
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
 
 		/*
 		 * Start Directed Speed Change so the best possible
@@ -822,8 +814,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
-	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
+	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
@@ -1184,11 +1176,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	if (pci_msi_enabled()) {
-		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
-					PCI_MSI_FLAGS);
+		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
 		val |= PCI_MSI_FLAGS_ENABLE;
-		dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP + PCI_MSI_FLAGS,
-				   val);
+		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 	}
 
 	return 0;
-- 
2.25.1

