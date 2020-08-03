Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA023AF59
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgHCVCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:34 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42462 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgHCVCe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:34 -0400
Received: by mail-il1-f195.google.com with SMTP id i138so26418165ild.9;
        Mon, 03 Aug 2020 14:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L06mAH8VA/IGeAefhzubwBSDxwj6YYC6qe74xf8W5J0=;
        b=uFuql2o52z3hJdVklnXHk/cwlxvZEfKGarlcVuO8vom/H5UTx8+JwICK+MHz26rnhy
         nAiEp7cZkZ8Bbfwob/MWu41yPuCygaSEXJ390hspWsW3rKiDFECBXfNwCIg6VBJDP2FB
         1ROYjlRCrZpd9fW0O4ZFTN5cmC3BmU79isUMPKQpQ1Df5wJwxsAmjfFMlkMmM7w3yKhM
         +2M8wmpqfDXkS5CIqY4Q2IJ69XWtbXMnU7WffBKZS2qADMEhRnGTGb+7X+TFzwFFDyk5
         2P7xVrpHjXGim2VkXkFK45z+PbxQ2se0OFI8JOj4m7rmydsETPpCp7X0669oUb50iiY9
         UVsQ==
X-Gm-Message-State: AOAM533mjdRWNecBwgPI7fYrEluQ2kb83Z0Dsfp0WLdWYgBMVw9aI88w
        Z6L34MjuPtt8MG4QL/onqg==
X-Google-Smtp-Source: ABdhPJyaj3PFM+CFdCy6mV1i58kFekEGMqO1UowSfypEY5AIM4vaGx5gSsEY/QdqAhmg5ntfqWZ6EQ==
X-Received: by 2002:a05:6e02:ea2:: with SMTP id u2mr1371612ilj.140.1596488552257;
        Mon, 03 Aug 2020 14:02:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 26/27] PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset
Date:   Mon,  3 Aug 2020 15:01:15 -0600
Message-Id: <20200803210116.3132633-27-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the Designware controller appears to hard code the PCI_CAP_ID_EXP
capability register at 0x70, there's no need to hard code this in the
driver as it is discoverable.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c     |  4 +---
 drivers/pci/controller/dwc/pci-keystone.c   | 11 +++++------
 drivers/pci/controller/dwc/pcie-spear13xx.c |  4 +---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 6184ebc9392d..b4508c3ffe96 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -73,8 +73,6 @@
 #define	LINK_UP						BIT(16)
 #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
-#define EXP_CAP_ID_OFFSET				0x70
-
 #define	PCIECTRL_TI_CONF_INTX_ASSERT			0x0124
 #define	PCIECTRL_TI_CONF_INTX_DEASSERT			0x0128
 
@@ -142,7 +140,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	struct device *dev = pci->dev;
 	u32 reg;
-	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
+	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
 	if (dw_pcie_link_up(pci)) {
 		dev_err(dev, "link is already up\n");
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 205754a6bc3c..d2eca3afebdb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -96,8 +96,6 @@
 #define LEG_EP				0x1
 #define RC				0x2
 
-#define EXP_CAP_ID_OFFSET		0x70
-
 #define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
 
 #define AM654_PCIE_DEV_TYPE_MASK	0x3
@@ -1125,22 +1123,23 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 static void ks_pcie_set_link_speed(struct dw_pcie *pci, int link_speed)
 {
 	u32 val;
+	u32 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	val = dw_pcie_readl_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCAP);
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
 		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 		val |= link_speed;
-		dw_pcie_writel_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCAP,
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP,
 				   val);
 	}
 
-	val = dw_pcie_readl_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCTL2);
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
 	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
 		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 		val |= link_speed;
-		dw_pcie_writel_dbi(pci, EXP_CAP_ID_OFFSET + PCI_EXP_LNKCTL2,
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2,
 				   val);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 7d0cdfd8138b..a4303148e8b1 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -65,8 +65,6 @@ struct pcie_app_reg {
 /* CR6 */
 #define MSI_CTRL_INT				(1 << 26)
 
-#define EXP_CAP_ID_OFFSET			0x70
-
 #define to_spear13xx_pcie(x)	dev_get_drvdata((x)->dev)
 
 static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
@@ -75,7 +73,7 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 	struct pcie_port *pp = &pci->pp;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 	u32 val;
-	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
+	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
 	if (dw_pcie_link_up(pci)) {
 		dev_err(pci->dev, "link already up\n");
-- 
2.25.1

