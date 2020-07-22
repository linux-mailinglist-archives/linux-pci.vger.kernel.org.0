Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB0228E29
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgGVC0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:26:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36484 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgGVC0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:26:19 -0400
Received: by mail-io1-f67.google.com with SMTP id t131so881186iod.3;
        Tue, 21 Jul 2020 19:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nA+rsQKPRqCqRLcwD1sS32YGd+tZlaV9KVJ00B242z0=;
        b=YybYqRQd0QpWC4+ByyRAhQRVtoCKkzbzqq9iqidx02zCS78Cfy/+saBURW8Es+vP+Q
         OvsiFHowMkxP4koJLW8uM6tk1gRddINcGrNa3Zcrpt43Iwutl7/yD15DdGvRlPs9o2El
         TBBV+fNK5VYZ+GOBN+ZVYLhq86+Ez3zKMVhKlznm9oSjmYe11ZmN4vakaFMIa0cZuypE
         /tKoyaY7I9FscoEPNHKwZmYX6wMIhVH2qZOq9dUpWGzDrtDrISEXfxFh4uKx92r6NUto
         JJTuKS9IBkFTJSOOaB1xVz9EGvX6yMce47xy/ohawFfM5nVczcRRxMvT4Azeht1vnJ8r
         6edQ==
X-Gm-Message-State: AOAM531CwU+QqQXKMDErsBTuBPzYgreo2ifnq+ozVOot2h9LXr9JlIJI
        xCdqAmRO09TUSEw7NqaXqQ==
X-Google-Smtp-Source: ABdhPJxSNucNP4OWBpa9UcK7As8QwrrkPn4QAty5DF1RSC4aIpj+DE8hJm33Ytw1h98hgyWUYp5/ow==
X-Received: by 2002:a5d:8d12:: with SMTP id p18mr30809085ioj.148.1595384777729;
        Tue, 21 Jul 2020 19:26:17 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:26:17 -0700 (PDT)
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
Subject: [PATCH 17/19] PCI: rcar-gen2: Convert to use modern host bridge probe functions
Date:   Tue, 21 Jul 2020 20:25:12 -0600
Message-Id: <20200722022514.1283916-18-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The rcar-gen2 host driver still uses the old Arm PCI setup function
pci_common_init_dev(). Let's update it to use the modern
devm_pci_alloc_host_bridge(), pci_parse_request_of_pci_ranges() and
pci_host_probe() functions.

Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-rcar-gen2.c | 168 +++++++------------------
 1 file changed, 46 insertions(+), 122 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 326171cb1a97..5b9888d4c34a 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -98,22 +98,17 @@ struct rcar_pci_priv {
 	void __iomem *reg;
 	struct resource mem_res;
 	struct resource *cfg_res;
-	unsigned busnr;
 	int irq;
-	unsigned long window_size;
-	unsigned long window_addr;
-	unsigned long window_pci;
 };
 
 /* PCI configuration space operations */
 static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 				       int where)
 {
-	struct pci_sys_data *sys = bus->sysdata;
-	struct rcar_pci_priv *priv = sys->private_data;
+	struct rcar_pci_priv *priv = bus->sysdata;
 	int slot, val;
 
-	if (sys->busnr != bus->number || PCI_FUNC(devfn))
+	if (!pci_is_root_bus(bus) || PCI_FUNC(devfn))
 		return NULL;
 
 	/* Only one EHCI/OHCI device built-in */
@@ -132,20 +127,6 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 	return priv->reg + (slot >> 1) * 0x100 + where;
 }
 
-/* PCI interrupt mapping */
-static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pci_sys_data *sys = dev->bus->sysdata;
-	struct rcar_pci_priv *priv = sys->private_data;
-	int irq;
-
-	irq = of_irq_parse_and_map_pci(dev, slot, pin);
-	if (!irq)
-		irq = priv->irq;
-
-	return irq;
-}
-
 #ifdef CONFIG_PCI_DEBUG
 /* if debug enabled, then attach an error handler irq to the bridge */
 
@@ -189,19 +170,33 @@ static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
 #endif
 
 /* PCI host controller setup */
-static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
+static void rcar_pci_setup(struct rcar_pci_priv *priv)
 {
-	struct rcar_pci_priv *priv = sys->private_data;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(priv);
 	struct device *dev = priv->dev;
 	void __iomem *reg = priv->reg;
+	struct resource_entry *entry;
+	unsigned long window_size;
+	unsigned long window_addr;
+	unsigned long window_pci;
 	u32 val;
-	int ret;
+
+	entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
+	if (!entry) {
+		window_addr = 0x40000000;
+		window_pci = 0x40000000;
+		window_size = SZ_1G;
+	} else {
+		window_addr = entry->res->start;
+		window_pci = entry->res->start - entry->offset;
+		window_size = resource_size(entry->res);
+	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
 	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
-	dev_info(dev, "PCI: bus%u revision %x\n", sys->busnr, val);
+	dev_info(dev, "PCI: revision %x\n", val);
 
 	/* Disable Direct Power Down State and assert reset */
 	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
@@ -214,7 +209,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		 RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST);
 
 	/* Setup PCIAHB window1 size */
-	switch (priv->window_size) {
+	switch (window_size) {
 	case SZ_2G:
 		val |= RCAR_USBCTR_PCIAHB_WIN1_2G;
 		break;
@@ -226,8 +221,8 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		break;
 	default:
 		pr_warn("unknown window size %ld - defaulting to 256M\n",
-			priv->window_size);
-		priv->window_size = SZ_256M;
+			window_size);
+		window_size = SZ_256M;
 		/* fall-through */
 	case SZ_256M:
 		val |= RCAR_USBCTR_PCIAHB_WIN1_256M;
@@ -245,7 +240,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	iowrite32(val, reg + RCAR_PCI_ARBITER_CTR_REG);
 
 	/* PCI-AHB mapping */
-	iowrite32(priv->window_addr | RCAR_PCIAHB_PREFETCH16,
+	iowrite32(window_addr | RCAR_PCIAHB_PREFETCH16,
 		  reg + RCAR_PCIAHB_WIN1_CTR_REG);
 
 	/* AHB-PCI mapping: OHCI/EHCI registers */
@@ -256,7 +251,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	iowrite32(RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG,
 		  reg + RCAR_AHBPCI_WIN1_CTR_REG);
 	/* Set PCI-AHB Window1 address */
-	iowrite32(priv->window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH,
+	iowrite32(window_pci | PCI_BASE_ADDRESS_MEM_PREFETCH,
 		  reg + PCI_BASE_ADDRESS_1);
 	/* Set AHB-PCI bridge PCI communication area address */
 	val = priv->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
@@ -271,18 +266,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
 		  reg + RCAR_PCI_INT_ENABLE_REG);
 
-	if (priv->irq > 0)
-		rcar_pci_setup_errirq(priv);
-
-	/* Add PCI resources */
-	pci_add_resource(&sys->resources, &priv->mem_res);
-	ret = devm_request_pci_bus_resources(dev, &sys->resources);
-	if (ret < 0)
-		return ret;
-
-	/* Setup bus number based on platform device id / of bus-range */
-	sys->busnr = priv->busnr;
-	return 1;
+	rcar_pci_setup_errirq(priv);
 }
 
 static struct pci_ops rcar_pci_ops = {
@@ -291,55 +275,21 @@ static struct pci_ops rcar_pci_ops = {
 	.write	= pci_generic_config_write,
 };
 
-static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
-					 struct device_node *np)
-{
-	struct device *dev = pci->dev;
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-	int index = 0;
-
-	/* Failure to parse is ok as we fall back to defaults */
-	if (of_pci_dma_range_parser_init(&parser, np))
-		return 0;
-
-	/* Get the dma-ranges from DT */
-	for_each_of_pci_range(&parser, &range) {
-		/* Hardware only allows one inbound 32-bit range */
-		if (index)
-			return -EINVAL;
-
-		pci->window_addr = (unsigned long)range.cpu_addr;
-		pci->window_pci = (unsigned long)range.pci_addr;
-		pci->window_size = (unsigned long)range.size;
-
-		/* Catch HW limitations */
-		if (!(range.flags & IORESOURCE_PREFETCH)) {
-			dev_err(dev, "window must be prefetchable\n");
-			return -EINVAL;
-		}
-		if (pci->window_addr) {
-			u32 lowaddr = 1 << (ffs(pci->window_addr) - 1);
-
-			if (lowaddr < pci->window_size) {
-				dev_err(dev, "invalid window size/addr\n");
-				return -EINVAL;
-			}
-		}
-		index++;
-	}
-
-	return 0;
-}
-
 static int rcar_pci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *cfg_res, *mem_res;
 	struct rcar_pci_priv *priv;
+	struct pci_host_bridge *bridge;
 	void __iomem *reg;
-	struct hw_pci hw;
-	void *hw_private[1];
+	int ret;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
+	if (!bridge)
+		return -ENOMEM;
+
+	priv = pci_host_bridge_priv(bridge);
+	bridge->sysdata = priv;
 
 	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, cfg_res);
@@ -369,44 +319,18 @@ static int rcar_pci_probe(struct platform_device *pdev)
 		return priv->irq;
 	}
 
-	/* default window addr and size if not specified in DT */
-	priv->window_addr = 0x40000000;
-	priv->window_pci = 0x40000000;
-	priv->window_size = SZ_1G;
-
-	if (dev->of_node) {
-		struct resource busnr;
-		int ret;
-
-		ret = of_pci_parse_bus_range(dev->of_node, &busnr);
-		if (ret < 0) {
-			dev_err(dev, "failed to parse bus-range\n");
-			return ret;
-		}
-
-		priv->busnr = busnr.start;
-		if (busnr.end != busnr.start)
-			dev_warn(dev, "only one bus number supported\n");
-
-		ret = rcar_pci_parse_map_dma_ranges(priv, dev->of_node);
-		if (ret < 0) {
-			dev_err(dev, "failed to parse dma-range\n");
-			return ret;
-		}
-	} else {
-		priv->busnr = pdev->id;
-	}
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
+	if (ret)
+		return ret;
+
+	bridge->ops = &rcar_pci_ops;
+
+	pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
+	rcar_pci_setup(priv);
 
-	hw_private[0] = priv;
-	memset(&hw, 0, sizeof(hw));
-	hw.nr_controllers = ARRAY_SIZE(hw_private);
-	hw.io_optional = 1;
-	hw.private_data = hw_private;
-	hw.map_irq = rcar_pci_map_irq;
-	hw.ops = &rcar_pci_ops;
-	hw.setup = rcar_pci_setup;
-	pci_common_init_dev(dev, &hw);
-	return 0;
+	return pci_host_probe(bridge);
 }
 
 static const struct of_device_id rcar_pci_of_match[] = {
-- 
2.25.1

