Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DF24CC4B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHUD4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39267 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgHUD4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:30 -0400
Received: by mail-io1-f68.google.com with SMTP id z17so473493ioi.6;
        Thu, 20 Aug 2020 20:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBhQHSRC5b7EjXLe1wtIsk2mRWkusWFFlluCqZMlR3s=;
        b=n5DzGYJNeEG+RgU23YQHXIfx037E6/EkBEj85zJk0Z5sJtnPJspGgH6xfa3mLUybno
         UtXo1uWC/ZmLGcB3nuaVf/g+IDQ3vv6qFxKZDrSS48WXrYCzkB9BEvSsE61yky6ci+Gc
         +aILEfQrcesVCry5yikbDbCsk+3evfU6gowGDAkIiVeGjmka4FAfzkHZRgoEx4+bJtF8
         JaAqVWBOkGj7Zz72xte0+Nm8s+1hP2QhItRsPsdD2dm0E3D/aQerr3CSTZQPKUe9BOKG
         C2aGIJfQv7TYhBR1FGtuw+z42NW2vXxOrPiR4EKq7hy+4D3UETwCFezWBeqkL2/7FHx1
         xSWw==
X-Gm-Message-State: AOAM531qOY/DrYHQxcB5sbRZ+2XKMjUkPkXa36Kar+QvtISgbarkxnSQ
        4n4Rw/h0ty/Zs87J+p415g==
X-Google-Smtp-Source: ABdhPJyWAiaexmdeVEgzO5iZxSuqRD4JaSKu7ZG07XYDvC9mxMC+ZPTsXVXlnNGxxM2MFiKu9NmqRQ==
X-Received: by 2002:a6b:e517:: with SMTP id y23mr896790ioc.190.1597982188440;
        Thu, 20 Aug 2020 20:56:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:27 -0700 (PDT)
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
Subject: [PATCH v2 30/40] PCI: dwc: Remove hardcoded PCI_CAP_ID_EXP offset
Date:   Thu, 20 Aug 2020 21:54:10 -0600
Message-Id: <20200821035420.380495-31-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
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
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c     |  4 +---
 drivers/pci/controller/dwc/pci-keystone.c   | 11 +++++------
 drivers/pci/controller/dwc/pcie-spear13xx.c |  4 +---
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dc387724cf08..d42e0664f378 100644
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
index 0fe792f6c253..39a5a72de340 100644
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
index 62846562da0b..056c94541a22 100644
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

