Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E29228E2C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgGVC0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:26:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41060 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgGVC0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:26:23 -0400
Received: by mail-io1-f67.google.com with SMTP id p205so860871iod.8;
        Tue, 21 Jul 2020 19:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLVAj3kGdSJ6T4CwdBz0jXIGSnRB5tOz+gDpzEQlBf4=;
        b=RUpV0oqeogU8Xgl+x0VsOdOKaHvwi+QYOcQqHSa4Y7lmXrvEfaJnsCXQj4Zx2xOaO/
         GwurjY5IewCnChN6lw82/DHAvEkRtytGFwi9v8e14QJWoKccTNIoQ1Dfl7+WRgWY6Hs+
         l0mPZm1iDllrdK+Mrh8H1CETv2z+Lp+qvWBpeMyJP6WOjdOeJqujiXcxn+aR8y+VEeEf
         ZP3fQrJt2Ztr8FF+Dpk0h3z57H4xHEMVWIYfkqqenkmAfQ7BWhrPSMtW66RuUpkPhQ+O
         OCDa+GsFjx2Jrm2TdJr4ozybUkGD/m8j47N2wdrAp8DDZiob+ugmI+OHAq5SErI9MHI/
         BvwQ==
X-Gm-Message-State: AOAM530OM3Md4quKLhjEoxQutD9WJ2DZZKEyGQX/PzThT/dBgb9JSoUf
        1ceABhLP/a2mn782auisRg==
X-Google-Smtp-Source: ABdhPJz57BUiBEUTV0l8f60CJbuIMMLc1hzjlFm+pRyqJngXTg0qHSlLsiYSw6ON9hm2I7epR6kQGw==
X-Received: by 2002:a02:cd91:: with SMTP id l17mr32895030jap.88.1595384780368;
        Tue, 21 Jul 2020 19:26:20 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:26:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 18/19] PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
Date:   Tue, 21 Jul 2020 20:25:13 -0600
Message-Id: <20200722022514.1283916-19-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that pci_parse_request_of_pci_ranges() callers just setup
pci_host_bridge.windows and dma_ranges directly and don't need the bus
range returned, we can just initialize them when allocating the
pci_host_bridge struct.

With this, pci_parse_request_of_pci_ranges() becomes a static function.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../controller/cadence/pcie-cadence-host.c    |  6 ---
 .../pci/controller/dwc/pcie-designware-host.c |  5 ---
 .../controller/mobiveil/pcie-mobiveil-host.c  |  8 ----
 drivers/pci/controller/pci-aardvark.c         |  7 ----
 drivers/pci/controller/pci-ftpci100.c         |  5 ---
 drivers/pci/controller/pci-host-common.c      | 13 +++----
 drivers/pci/controller/pci-loongson.c         |  7 ----
 drivers/pci/controller/pci-rcar-gen2.c        |  6 ---
 drivers/pci/controller/pci-tegra.c            |  6 ---
 drivers/pci/controller/pci-v3-semi.c          |  5 ---
 drivers/pci/controller/pci-versatile.c        |  7 +---
 drivers/pci/controller/pci-xgene.c            |  5 ---
 drivers/pci/controller/pcie-altera.c          |  7 ----
 drivers/pci/controller/pcie-brcmstb.c         |  5 ---
 drivers/pci/controller/pcie-iproc-platform.c  |  7 ----
 drivers/pci/controller/pcie-mediatek.c        |  7 ----
 drivers/pci/controller/pcie-rcar-host.c       |  5 ---
 drivers/pci/controller/pcie-rockchip-host.c   |  5 ---
 drivers/pci/controller/pcie-xilinx-nwl.c      |  7 ----
 drivers/pci/controller/pcie-xilinx.c          |  7 ----
 drivers/pci/of.c                              | 37 +++++++++----------
 drivers/pci/pci.h                             |  8 ++++
 drivers/pci/probe.c                           |  4 ++
 include/linux/pci.h                           | 12 ------
 24 files changed, 36 insertions(+), 155 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 6b5d20f026de..4fe39b6b4749 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -171,14 +171,8 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 static int cdns_pcie_host_init(struct device *dev,
 			       struct cdns_pcie_rc *rc)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
 	int err;
 
-	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL, NULL);
-	if (err)
-		return err;
-
 	err = cdns_pcie_host_init_root_port(rc);
 	if (err)
 		return err;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fa922cb876a3..d3d4c1e42868 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -346,11 +346,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret)
-		return ret;
-
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &bridge->windows) {
 		switch (resource_type(win->res)) {
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 7250b84a7efe..2954d6ad8333 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -577,14 +577,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	if (!mobiveil_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-	/* parse the host bridge base addresses from the device tree file */
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret) {
-		dev_err(dev, "Getting bridge resources failed\n");
-		return ret;
-	}
-
 	/*
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 61c59a6935c9..a4a799f52cdb 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1132,13 +1132,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret) {
-		dev_err(dev, "Failed to parse resources\n");
-		return ret;
-	}
-
 	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
 						       "reset-gpios", 0,
 						       GPIOD_OUT_LOW,
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 84b6b5a21a89..b1521f4f4096 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -467,11 +467,6 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &host->windows,
-					      &host->dma_ranges, NULL);
-	if (ret)
-		return ret;
-
 	win = resource_list_first_type(&host->windows, IORESOURCE_IO);
 	if (win) {
 		io = win->res;
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index e662910fe032..509624175260 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -25,21 +25,20 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 {
 	int err;
 	struct resource cfgres;
-	struct resource *bus_range = NULL;
+	struct resource_entry *bus;
 	struct pci_config_window *cfg;
 
-	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL, &bus_range);
-	if (err)
-		return ERR_PTR(err);
-
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
 		return ERR_PTR(err);
 	}
 
-	cfg = pci_ecam_create(dev, &cfgres, bus_range, ops);
+	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return ERR_PTR(-ENODEV);
+
+	cfg = pci_ecam_create(dev, &cfgres, bus->res, ops);
 	if (IS_ERR(cfg))
 		return cfg;
 
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 0198c15ed97c..a7a7fbe2b7a5 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -218,13 +218,6 @@ static int loongson_pci_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-						&bridge->dma_ranges, NULL);
-	if (err) {
-		dev_err(dev, "failed to get bridge resources\n");
-		return err;
-	}
-
 	bridge->sysdata = priv;
 	bridge->ops = &loongson_pci_ops;
 	bridge->map_irq = loongson_map_irq;
diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 5b9888d4c34a..046965d284a6 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -282,7 +282,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	struct rcar_pci_priv *priv;
 	struct pci_host_bridge *bridge;
 	void __iomem *reg;
-	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
 	if (!bridge)
@@ -319,11 +318,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
 		return priv->irq;
 	}
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret)
-		return ret;
-
 	bridge->ops = &rcar_pci_ops;
 
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9c91df9cd2ba..fc4e38fec928 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2684,12 +2684,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&pcie->ports);
 	pcie->dev = dev;
 
-	err = pci_parse_request_of_pci_ranges(dev, &host->windows, NULL, NULL);
-	if (err) {
-		dev_err(dev, "Getting bridge resources failed\n");
-		return err;
-	}
-
 	err = tegra_pcie_parse_dt(pcie);
 	if (err < 0)
 		return err;
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index d2619f583bfb..1a2cbc56b34b 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -764,11 +764,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &host->windows,
-					      &host->dma_ranges, NULL);
-	if (ret)
-		return ret;
-
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 80f594beea81..54a7a43d036a 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -67,7 +67,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct resource_entry *entry;
-	int ret, i, myslot = -1, mem = 1;
+	int i, myslot = -1, mem = 1;
 	u32 val;
 	void __iomem *local_pci_cfg_base;
 	struct pci_host_bridge *bridge;
@@ -91,11 +91,6 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(versatile_cfg_base[1]))
 		return PTR_ERR(versatile_cfg_base[1]);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      NULL, NULL);
-	if (ret)
-		return ret;
-
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			writel(entry->res->start >> 28, PCI_IMAP(mem));
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 1d3286823c16..7f5a6595af0a 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -615,11 +615,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret)
-		return ret;
-
 	ret = xgene_pcie_setup(port);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 83ee09baf95f..4b515329ad35 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -797,13 +797,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret) {
-		dev_err(dev, "Failed add resources\n");
-		return ret;
-	}
-
 	ret = altera_pcie_init_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index a92b337af20f..b24651fad199 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -972,11 +972,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
 
-	ret = pci_parse_request_of_pci_ranges(pcie->dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "could not enable clock\n");
diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index ff0a81a632a1..7c10c1cb6f65 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -95,13 +95,6 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy))
 		return PTR_ERR(pcie->phy);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (ret) {
-		dev_err(dev, "unable to get PCI host bridge resources\n");
-		return ret;
-	}
-
 	/* PAXC doesn't support legacy IRQs, skip mapping */
 	switch (pcie->type) {
 	case IPROC_PCIE_PAXC:
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index acbb656a8092..ca12b2d6892b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1029,15 +1029,8 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node, *child;
 	struct mtk_pcie_port *port, *tmp;
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct list_head *windows = &host->windows;
 	int err;
 
-	err = pci_parse_request_of_pci_ranges(dev, windows,
-					      &host->dma_ranges, NULL);
-	if (err)
-		return err;
-
 	for_each_available_child_of_node(node, child) {
 		int slot;
 
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index fa7b89378904..67f2a9d3bc29 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -913,11 +913,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 	platform_set_drvdata(pdev, host);
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (err)
-		return err;
-
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 9a30d08976d8..fed4f6cd1b7b 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -989,11 +989,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_deinit_port;
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (err)
-		goto err_remove_irq_domain;
-
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
 		goto err_remove_irq_domain;
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 566165c18fad..7e7c23c555c7 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -838,13 +838,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (err) {
-		dev_err(dev, "Getting bridge resources failed\n");
-		return err;
-	}
-
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 7bf80f68efa9..f8b8ccea5cbc 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -641,13 +641,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bridge->dma_ranges, NULL);
-	if (err) {
-		dev_err(dev, "Getting bridge resources failed\n");
-		return err;
-	}
-
 	bridge->sysdata = port;
 	bridge->ops = &xilinx_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cfb940c8b399..5e06aae1b4cd 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -521,28 +521,26 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
 #endif	/* CONFIG_OF_IRQ */
 
-int pci_parse_request_of_pci_ranges(struct device *dev,
-				    struct list_head *resources,
-				    struct list_head *ib_resources,
-				    struct resource **bus_range)
+static int pci_parse_request_of_pci_ranges(struct device *dev,
+					   struct pci_host_bridge *bridge)
 {
 	int err, res_valid = 0;
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
 
-	INIT_LIST_HEAD(resources);
-	if (ib_resources)
-		INIT_LIST_HEAD(ib_resources);
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
-						    ib_resources, &iobase);
+	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
+
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &bridge->windows,
+						    &bridge->dma_ranges, &iobase);
 	if (err)
 		return err;
 
-	err = devm_request_pci_bus_resources(dev, resources);
+	err = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (err)
-		goto out_release_res;
+		return err;
 
-	resource_list_for_each_entry_safe(win, tmp, resources) {
+	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
 		struct resource *res = win->res;
 
 		switch (resource_type(res)) {
@@ -557,10 +555,6 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 			break;
-		case IORESOURCE_BUS:
-			if (bus_range)
-				*bus_range = res;
-			break;
 		}
 	}
 
@@ -568,12 +562,15 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 		dev_warn(dev, "non-prefetchable memory resource required\n");
 
 	return 0;
+}
 
- out_release_res:
-	pci_free_resource_list(resources);
-	return err;
+int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
+{
+	if (!dev->of_node)
+		return 0;
+
+	return pci_parse_request_of_pci_ranges(dev, bridge);
 }
-EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
 
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..56d67071e116 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -627,6 +627,8 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
+
 #else
 static inline int
 of_pci_parse_bus_range(struct device_node *node, struct resource *res)
@@ -650,6 +652,12 @@ static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
+
+static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
+{
+	return 0;
+}
+
 #endif /* CONFIG_OF */
 
 #ifdef CONFIG_PCIEAER
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f850782efc35..998f615cdb6d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -635,6 +635,10 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 	if (ret)
 		return NULL;
 
+	ret = devm_of_pci_bridge_init(dev, bridge);
+	if (ret)
+		return NULL;
+
 	return bridge;
 }
 EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e52..2830799208fd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2303,10 +2303,6 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 struct device_node;
 struct irq_domain;
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
-int pci_parse_request_of_pci_ranges(struct device *dev,
-				    struct list_head *resources,
-				    struct list_head *ib_resources,
-				    struct resource **bus_range);
 
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -2314,14 +2310,6 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
 #else	/* CONFIG_OF */
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
-static inline int
-pci_parse_request_of_pci_ranges(struct device *dev,
-				struct list_head *resources,
-				struct list_head *ib_resources,
-				struct resource **bus_range)
-{
-	return -EINVAL;
-}
 #endif  /* CONFIG_OF */
 
 static inline struct device_node *
-- 
2.25.1

