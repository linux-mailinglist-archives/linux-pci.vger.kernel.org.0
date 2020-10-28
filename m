Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3464729E120
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 02:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgJ2Bxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 21:53:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46068 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgJ1V5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:57:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id j7so1123642oie.12;
        Wed, 28 Oct 2020 14:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbZEc8Er93jk4a6ztZuKlxbcqfjO3bgt1UlkERsxFZs=;
        b=Vyhpxn9mv6taMyfqMwrUIsPOl05IwwNNzx0kd/FLPOBGsEf1fDiQmgaiezxaa+CTTU
         01Lo1PFnXHMyLkkZ6b1VCoDFBtnooqsTrEZKMD4v356y0MRGIFK9KBCRNJLGPrQnJvIh
         naLFHL59h/eT7dPmti371RS7ljiMZmh1+HYpg0vexvXEb+1WHdH+BlXJK9H7wHplS+qw
         5oop5FSfMzXd8CGltOqcWsi8MiqGLrebWCJBQ+TY7HZkEg8N+TL5c+2PifDaVHrJpHhV
         VTv4vM7a18hOzw9IhRpR+FO+cb1zID5v/Ivap5j9Q2Kfr7hx/H62RKbwaIG0j7NFDbNt
         aoUQ==
X-Gm-Message-State: AOAM530bRXh7BlllOpbde4i8nEbL+RgddHsa7T+2UhsAopk6JNNmg28Z
        8T3lE3AEyGBatBFqQCGDDv4i+pDhmQ==
X-Google-Smtp-Source: ABdhPJy6x7S+eSVx9q7Igzxyr2K1XEbKHIhryPB4QHiwBFsbh27DOpX4yS0+Rq73HgdN+mL57gNq8A==
X-Received: by 2002:aca:5e03:: with SMTP id s3mr613140oib.125.1603918032930;
        Wed, 28 Oct 2020 13:47:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:47:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 09/13] PCI: dwc: Rework MSI initialization
Date:   Wed, 28 Oct 2020 15:46:42 -0500
Message-Id: <20201028204646.356535-10-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are 3 possible MSI implementations for the DWC host. The first is
using the built-in DWC MSI controller. The 2nd is a custom MSI
controller as part of the PCI host (keystone only). The 3rd is an
external MSI controller (typically GICv3 ITS). Currently, the last 2
are distinguished with a .msi_host_init() hook with the 3rd option using
an empty function. However we can detect the 3rd case with the presence
of 'msi-parent' or 'msi-map' properties, so let's do that instead and
remove the empty functions.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c     |  9 -------
 drivers/pci/controller/dwc/pci-layerscape.c   | 25 -------------------
 .../pci/controller/dwc/pcie-designware-host.c | 20 +++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  9 -------
 5 files changed, 13 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 9cf14f13798b..784385ae6074 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -272,14 +272,6 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
 }
 
-/*
- * Dummy function so that DW core doesn't configure MSI
- */
-static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
-{
-	return 0;
-}
-
 static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -854,7 +846,6 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 
 static const struct dw_pcie_host_ops ks_pcie_am654_host_ops = {
 	.host_init = ks_pcie_host_init,
-	.msi_host_init = ks_pcie_am654_msi_host_init,
 };
 
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 53e56d54c482..0d84986c4c16 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -168,37 +168,12 @@ static int ls1021_pcie_host_init(struct pcie_port *pp)
 	return ls_pcie_host_init(pp);
 }
 
-static int ls_pcie_msi_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *msi_node;
-
-	/*
-	 * The MSI domain is set by the generic of_msi_configure().  This
-	 * .msi_host_init() function keeps us from doing the default MSI
-	 * domain setup in dw_pcie_host_init() and also enforces the
-	 * requirement that "msi-parent" exists.
-	 */
-	msi_node = of_parse_phandle(np, "msi-parent", 0);
-	if (!msi_node) {
-		dev_err(dev, "failed to find msi-parent\n");
-		return -EINVAL;
-	}
-
-	of_node_put(msi_node);
-	return 0;
-}
-
 static const struct dw_pcie_host_ops ls1021_pcie_host_ops = {
 	.host_init = ls1021_pcie_host_init,
-	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
-	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static const struct dw_pcie_ops dw_ls1021_pcie_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0f77e4d4b385..6cebdd9bbd2e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -365,6 +365,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
 	if (pci_msi_enabled()) {
+		pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
+				     of_property_read_bool(np, "msi-parent") ||
+				     of_property_read_bool(np, "msi-map"));
+
 		if (!pp->num_vectors) {
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
 		} else if (pp->num_vectors > MAX_MSI_IRQS) {
@@ -372,7 +376,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			return -EINVAL;
 		}
 
-		if (!pp->ops->msi_host_init) {
+		if (pp->ops->msi_host_init) {
+			ret = pp->ops->msi_host_init(pp);
+			if (ret < 0)
+				return ret;
+		} else if (pp->has_msi_ctrl) {
 			if (!pp->msi_irq) {
 				pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 				if (pp->msi_irq < 0) {
@@ -402,10 +410,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 				pp->msi_data = 0;
 				goto err_free_msi;
 			}
-		} else {
-			ret = pp->ops->msi_host_init(pp);
-			if (ret < 0)
-				return ret;
 		}
 	}
 
@@ -426,7 +430,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		return 0;
 
 err_free_msi:
-	if (pci_msi_enabled() && !pp->ops->msi_host_init)
+	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 	return ret;
 }
@@ -436,7 +440,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 {
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
-	if (pci_msi_enabled() && !pp->ops->msi_host_init)
+	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
@@ -544,7 +548,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	if (pci_msi_enabled() && !pp->ops->msi_host_init) {
+	if (pp->has_msi_ctrl) {
 		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 		/* Initialize IRQ Status array */
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 96382dcb2859..5d374bab10d1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -175,6 +175,7 @@ struct dw_pcie_host_ops {
 };
 
 struct pcie_port {
+	bool			has_msi_ctrl:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c562eb7454b1..292b9de86532 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -385,14 +385,6 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
 	return intel_pcie_host_setup(lpp);
 }
 
-/*
- * Dummy function so that DW core doesn't configure MSI
- */
-static int intel_pcie_msi_init(struct pcie_port *pp)
-{
-	return 0;
-}
-
 static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
 {
 	return cpu_addr + BUS_IATU_OFFSET;
@@ -404,7 +396,6 @@ static const struct dw_pcie_ops intel_pcie_ops = {
 
 static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
 	.host_init =		intel_pcie_rc_init,
-	.msi_host_init =	intel_pcie_msi_init,
 };
 
 static const struct intel_pcie_soc pcie_data = {
-- 
2.25.1

