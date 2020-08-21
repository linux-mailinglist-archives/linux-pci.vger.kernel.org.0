Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1086E24CC66
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgHUD4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:45 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37054 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgHUD4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:41 -0400
Received: by mail-il1-f196.google.com with SMTP id v2so342508ilq.4;
        Thu, 20 Aug 2020 20:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u016rzpt7YriLAuZFV7kubTg3FHvTAniK1PmR8gdKk=;
        b=krB1Bzt8azbDaXFq+2IW91pZ6nSx54dBq/0UFImvrPVGz6xr9vu1qUkPAqYe48Uqpc
         u16OsXP4KvLUd2f6sIds25wRdXtSRbgwl+fA8d976JT28kn6HGI3NGuyHpkx9VlktgjM
         stT/SM/VcYWxrE8JZPrnyAsT799WeQ6Fl6ACRCV8xwMAMp+0tGzXf+IUOcMxmEcY7ppU
         phH5xw12h0PZrTsLhZFZB0ExKTW+UgBx7GPzTlzcBPC7YxiQGYcVsGFFfmHQwGvNMrBD
         91BdnPR0l3L7zcuz9MqqvMWNGYKeF5tGu+c3dKbNxqzQr/xGpiyRWedFL6KTTAmCsPTe
         idgw==
X-Gm-Message-State: AOAM531/n75zJcUWu13MAWywvNgtre5jWrdpUhAnbveWiKNqhuYyP6mD
        P027ZmsHkGLk4BFAXdWzmw==
X-Google-Smtp-Source: ABdhPJyI7C3FaIbP1Yw4loRbbnfe9eS9CovdNd1g4j7RbFfdxm4RFx0bIf4GS4dH9/lLrncySzP8cw==
X-Received: by 2002:a92:a302:: with SMTP id a2mr1025900ili.116.1597982198643;
        Thu, 20 Aug 2020 20:56:38 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:38 -0700 (PDT)
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
Subject: [PATCH v2 34/40] PCI: dwc: Centralize link gen setting
Date:   Thu, 20 Aug 2020 21:54:14 -0600
Message-Id: <20200821035420.380495-35-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

keystone would force gen2 if no DT property. Now it relies on the
PCI_EXP_LNKCAP value.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       | 25 --------------
 drivers/pci/controller/dwc/pci-imx6.c         |  9 ++---
 drivers/pci/controller/dwc/pci-keystone.c     | 33 -------------------
 .../pci/controller/dwc/pcie-designware-ep.c   | 11 +++++--
 .../pci/controller/dwc/pcie-designware-host.c |  3 ++
 drivers/pci/controller/dwc/pcie-designware.c  | 32 ++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    | 13 +++-----
 drivers/pci/controller/dwc/pcie-qcom.c        | 11 -------
 drivers/pci/controller/dwc/pcie-spear13xx.c   | 27 +--------------
 drivers/pci/controller/dwc/pcie-tegra194.c    | 23 -------------
 11 files changed, 40 insertions(+), 149 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d42e0664f378..69cd43f74260 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -89,7 +89,6 @@ struct dra7xx_pcie {
 	void __iomem		*base;		/* DT ti_conf */
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
-	int			link_gen;
 	struct irq_domain	*irq_domain;
 	enum dw_pcie_device_mode mode;
 };
@@ -147,26 +146,6 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 		return 0;
 	}
 
-	if (dra7xx->link_gen == 1) {
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-			     4, &reg);
-		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
-			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
-			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCAP, 4, reg);
-		}
-
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-			     2, &reg);
-		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
-			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
-			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCTL2, 2, reg);
-		}
-	}
-
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
@@ -935,10 +914,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	reg &= ~LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	dra7xx->link_gen = of_pci_get_max_link_speed(np);
-	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
-		dra7xx->link_gen = 2;
-
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9f6018d3d338..337c74cbdfdb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -79,7 +79,6 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
-	int			link_gen;
 	struct regulator	*vpcie;
 	void __iomem		*phy_base;
 
@@ -771,7 +770,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	if (ret)
 		goto err_reset_phy;
 
-	if (imx6_pcie->link_gen == 2) {
+	if (pci->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 		tmp &= ~PCI_EXP_LNKCAP_SLS;
@@ -1153,10 +1152,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->tx_swing_low = 127;
 
 	/* Limit link speed */
-	ret = of_property_read_u32(node, "fsl,max-link-speed",
-				   &imx6_pcie->link_gen);
-	if (ret)
-		imx6_pcie->link_gen = 1;
+	pci->link_gen = 1;
+	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
 
 	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx6_pcie->vpcie)) {
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5fe36da0b7c6..b554812dace7 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1107,32 +1107,6 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 	return 0;
 }
 
-static void ks_pcie_set_link_speed(struct dw_pcie *pci, int link_speed)
-{
-	u32 val;
-	u32 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-
-	dw_pcie_dbi_ro_wr_en(pci);
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
-		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
-		val |= link_speed;
-		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP,
-				   val);
-	}
-
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
-	if ((val & PCI_EXP_LNKCAP_SLS) != link_speed) {
-		val &= ~((u32)PCI_EXP_LNKCAP_SLS);
-		val |= link_speed;
-		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2,
-				   val);
-	}
-
-	dw_pcie_dbi_ro_wr_dis(pci);
-}
-
 static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 	.host_ops = &ks_pcie_host_ops,
 	.version = 0x365A,
@@ -1185,7 +1159,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	unsigned int version;
 	void __iomem *base;
 	struct phy **phy;
-	int link_speed;
 	u32 num_lanes;
 	char name[10];
 	int ret;
@@ -1320,12 +1293,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 	}
 
-	link_speed = of_pci_get_max_link_speed(np);
-	if (link_speed < 0)
-		link_speed = 2;
-
-	ks_pcie_set_link_speed(pci, link_speed);
-
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 305bfec2424d..1a0f0ef4e97f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -12,6 +12,8 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+#include "../../pci.h"
+
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -518,18 +520,20 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
 
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	if (offset) {
 		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
 		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
 			PCI_REBAR_CTRL_NBAR_SHIFT;
 
-		dw_pcie_dbi_ro_wr_en(pci);
 		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
 			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
-		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 
 	dw_pcie_setup(pci);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -590,6 +594,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
+	if (pci->link_gen < 1)
+		pci->link_gen = of_pci_get_max_link_speed(np);
+
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1c750659aef8..4c1c1896ccab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -361,6 +361,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
+	if (pci->link_gen < 1)
+		pci->link_gen = of_pci_get_max_link_speed(np);
+
 	if (pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b0a030661860..448f62f2e6ea 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -473,37 +473,40 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 
-void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
+static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 {
-	u32 reg, val;
+	u32 cap, ctrl2, link_speed;
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
-	reg = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
-	reg &= ~PCI_EXP_LNKCTL2_TLS;
+	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
+	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
 
 	switch (pcie_link_speed[link_gen]) {
 	case PCIE_SPEED_2_5GT:
-		reg |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
 		break;
 	case PCIE_SPEED_5_0GT:
-		reg |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
 		break;
 	case PCIE_SPEED_8_0GT:
-		reg |= PCI_EXP_LNKCTL2_TLS_8_0GT;
+		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
 		break;
 	case PCIE_SPEED_16_0GT:
-		reg |= PCI_EXP_LNKCTL2_TLS_16_0GT;
+		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
 		break;
 	default:
 		/* Use hardware capability */
-		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
-		reg &= ~PCI_EXP_LNKCTL2_HASD;
-		reg |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, val);
+		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
+		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
 		break;
 	}
 
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, reg);
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
+
+	cap &= ~((u32)PCI_EXP_LNKCAP_SLS);
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
+
 }
 EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
 
@@ -545,6 +548,9 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
 
+	if (pci->link_gen > 0)
+		dw_pcie_link_set_max_speed(pci, pci->link_gen);
+
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_FAST_LINK_MODE;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f4b871e3d73f..0b48298362cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -252,6 +252,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	unsigned int		version;
 	int			num_lanes;
+	int			link_gen;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -270,7 +271,6 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
-void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen);
 void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c3b3a1d162b5..2c0d32ffb828 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -67,8 +67,6 @@ struct intel_pcie_port {
 	void __iomem		*app_base;
 	struct gpio_desc	*reset_gpio;
 	u32			rst_intrvl;
-	u32			max_speed;
-	u32			link_gen;
 	u32			max_width;
 	u32			n_fts;
 	struct clk		*core_clk;
@@ -137,7 +135,6 @@ static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
 	u8 offset = lpp->pcie_cap_ofst;
 
 	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCAP);
-	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
 	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
 
 	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCTL);
@@ -149,8 +146,9 @@ static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
 static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
 {
 	u32 val, mask;
+	struct dw_pcie *pci = &lpp->pci;
 
-	switch (pcie_link_speed[lpp->max_speed]) {
+	switch (pcie_link_speed[pci->link_gen]) {
 	case PCIE_SPEED_8_0GT:
 		lpp->n_fts = PORT_AFR_N_FTS_GEN3;
 		break;
@@ -179,7 +177,6 @@ static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
 	dw_pcie_setup_rc(&lpp->pci.pp);
 	dw_pcie_upconfig_setup(&lpp->pci);
 	intel_pcie_port_logic_setup(lpp);
-	dw_pcie_link_set_max_speed(&lpp->pci, lpp->link_gen);
 	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
 }
 
@@ -286,9 +283,6 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (ret)
 		lpp->rst_intrvl = RESET_INTERVAL_MS;
 
-	ret = of_pci_get_max_link_speed(dev->of_node);
-	lpp->link_gen = ret < 0 ? 0 : ret;
-
 	lpp->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
 	if (IS_ERR(lpp->app_base))
 		return PTR_ERR(lpp->app_base);
@@ -313,8 +307,9 @@ static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
 {
 	u32 value;
 	int ret;
+	struct dw_pcie *pci = &lpp->pci;
 
-	if (pcie_link_speed[lpp->max_speed] < PCIE_SPEED_8_0GT)
+	if (pci->link_gen < 3)
 		return 0;
 
 	/* Send PME_TURN_OFF message */
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8d1fb7e0b8f..5eb28251dbee 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -189,7 +189,6 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
-	int gen;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -390,12 +389,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	/* wait for clock acquisition */
 	usleep_range(1000, 1500);
 
-	if (pcie->gen == 1) {
-		val = readl(pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
-		val |= PCI_EXP_LNKSTA_CLS_2_5GB;
-		writel(val, pci->dbi_base + PCIE20_LNK_CONTROL2_LINK_STATUS2);
-	}
-
 	/* Set the Max TLP size to 2K, instead of using default of 4K */
 	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
 	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL0);
@@ -1395,10 +1388,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
-	if (pcie->gen < 0)
-		pcie->gen = 2;
-
 	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
 	if (IS_ERR(pcie->parf)) {
 		ret = PTR_ERR(pcie->parf);
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 056c94541a22..0d8d0fe87f27 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -26,7 +26,6 @@ struct spear13xx_pcie {
 	void __iomem		*app_base;
 	struct phy		*phy;
 	struct clk		*clk;
-	bool			is_gen1;
 };
 
 struct pcie_app_reg {
@@ -94,30 +93,6 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 	dw_pcie_write(pci->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
 	dw_pcie_write(pci->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
 
-	/*
-	 * if is_gen1 is set then handle it, so that some buggy card
-	 * also works
-	 */
-	if (spear13xx_pcie->is_gen1) {
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-			     4, &val);
-		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
-			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
-			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCAP, 4, val);
-		}
-
-		dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-			     2, &val);
-		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
-			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
-			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_write(pci->dbi_base + exp_cap_off +
-				      PCI_EXP_LNKCTL2, 2, val);
-		}
-	}
-
 	/* enable ltssm */
 	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
 			| (1 << APP_LTSSM_ENABLE_ID)
@@ -276,7 +251,7 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
 
 	if (of_property_read_bool(np, "st,pcie-is-gen1"))
-		spear13xx_pcie->is_gen1 = true;
+		pci->link_gen = 1;
 
 	platform_set_drvdata(pdev, spear13xx_pcie);
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f121ac25d418..91ef4b3e860d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -284,7 +284,6 @@ struct tegra_pcie_dw {
 	u8 init_link_width;
 	u32 msi_ctrl_int;
 	u32 num_lanes;
-	u32 max_speed;
 	u32 cid;
 	u32 cfg_link_cap_l1sub;
 	u32 pcie_cap_base;
@@ -900,16 +899,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 		AMBA_ERROR_RESPONSE_CRS_SHIFT);
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
-	/* Configure Max Speed from DT */
-	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
-		val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
-					PCI_EXP_LNKCAP);
-		val &= ~PCI_EXP_LNKCAP_SLS;
-		val |= pcie->max_speed;
-		dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP,
-				   val);
-	}
-
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
@@ -1119,8 +1108,6 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return ret;
 	}
 
-	pcie->max_speed = of_pci_get_max_link_speed(np);
-
 	ret = of_property_read_u32_index(np, "nvidia,bpmp", 1, &pcie->cid);
 	if (ret) {
 		dev_err(pcie->dev, "Failed to read Controller-ID: %d\n", ret);
@@ -1818,16 +1805,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= FTS_VAL;
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
-	/* Configure Max Speed from DT */
-	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
-		val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
-					PCI_EXP_LNKCAP);
-		val &= ~PCI_EXP_LNKCAP_SLS;
-		val |= pcie->max_speed;
-		dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP,
-				   val);
-	}
-
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
-- 
2.25.1

