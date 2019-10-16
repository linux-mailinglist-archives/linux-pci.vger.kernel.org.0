Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE40D9AFC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfJPUH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39773 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733045AbfJPUH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so21287040otr.6;
        Wed, 16 Oct 2019 13:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qMqLBNtHNld2muil9Efe/rTJzgTbPeVP5bYdXvxyJfw=;
        b=RPstxivu3xFbX8ykkdqnaQ64RIZ+SF6Yf6J4abkkGXtQA+OKMBiXXo6jin6eDhQuar
         PkpyN9o3lFgGk1gDE/Z0hd831CgNH+YCeTnvnAE9hfBKyrieQHoqHLLyyM6yIu0WVl2n
         VRdWVid89z5UzHmB4y6EWTj/GC6g9eMGMCK1dTiaNAcS7WsY3Fo3qgSWDynmUWc4A8wF
         3QfOFF5FEJmoHirr0La/EYXp45jfWbe5Ej4KLJqDgz+moscmmvbMRER4MdQcFQzdothf
         spemC6AZrpo8C+fIe5Qmv03EKHzUepFlAU/pS4e1+kHs96cfrze2wq/vdooYUyYJtyUo
         Qodw==
X-Gm-Message-State: APjAAAUecPsdAHzOG64lRdTvEDNuEB02XICS9SImJW4xDZxlzKs9tz5P
        aOraBFaETCqlRzE+fbTG0A==
X-Google-Smtp-Source: APXvYqznjq7+ZSe5aEtZJGHSVG0X9szfbBdsRbu4NjF4nRqtNmJwKwSZ46We+m6ah454h24rld6/EA==
X-Received: by 2002:a9d:12f1:: with SMTP id g104mr56956otg.24.1571256445876;
        Wed, 16 Oct 2019 13:07:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 19/25] PCI: of: Add inbound resource parsing to helpers
Date:   Wed, 16 Oct 2019 15:06:41 -0500
Message-Id: <20191016200647.32050-20-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Extend devm_of_pci_get_host_bridge_resources() and
pci_parse_request_of_pci_ranges() helpers to also parse the inbound
addresses from DT 'dma-ranges' and populate a resource list with the
translated addresses. This will help ensure 'dma-ranges' is always
parsed in a consistent way.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Will Deacon <will@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Toan Le <toan@os.amperecomputing.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Tom Joseph <tjoseph@cadence.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: rfi@lists.rocketboards.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com> # for AArdvark
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix crash in INIT_LIST_HEAD when ib_resources is NULL
---
 .../pci/controller/dwc/pcie-designware-host.c |  3 +-
 drivers/pci/controller/pci-aardvark.c         |  2 +-
 drivers/pci/controller/pci-ftpci100.c         |  3 +-
 drivers/pci/controller/pci-host-common.c      |  2 +-
 drivers/pci/controller/pci-v3-semi.c          |  3 +-
 drivers/pci/controller/pci-versatile.c        |  2 +-
 drivers/pci/controller/pci-xgene.c            |  3 +-
 drivers/pci/controller/pcie-altera.c          |  2 +-
 drivers/pci/controller/pcie-cadence-host.c    |  2 +-
 drivers/pci/controller/pcie-iproc-platform.c  |  3 +-
 drivers/pci/controller/pcie-mediatek.c        |  2 +-
 drivers/pci/controller/pcie-mobiveil.c        |  3 +-
 drivers/pci/controller/pcie-rcar.c            |  3 +-
 drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
 drivers/pci/controller/pcie-xilinx-nwl.c      |  3 +-
 drivers/pci/controller/pcie-xilinx.c          |  3 +-
 drivers/pci/of.c                              | 45 ++++++++++++++++++-
 drivers/pci/pci.h                             |  8 +++-
 include/linux/pci.h                           |  2 +
 19 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index aeec8b65eb97..f7b1d80c4a0a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -342,7 +342,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 9cbeba507f0c..b34eaa2cd762 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -939,7 +939,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	}
 
 	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      &bus);
+					      &bridge->dma_ranges, &bus);
 	if (ret) {
 		dev_err(dev, "Failed to parse resources\n");
 		return ret;
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 12bc7daef5b5..5824913e311b 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -477,7 +477,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &host->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &host->windows,
+					      &host->dma_ranges, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c8cb9c5188a4..250a3fc80ec6 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -27,7 +27,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	struct pci_config_window *cfg;
 
 	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
+	err = pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_range);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 96677520f6c1..2209c7671115 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -776,7 +776,8 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &host->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &host->windows,
+					      &host->dma_ranges, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index eae1b859990b..8f81d2c9296a 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -92,7 +92,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(versatile_cfg_base[1]))
 		return PTR_ERR(versatile_cfg_base[1]);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 7d0f0395a479..9408269d943d 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -627,7 +627,8 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index ba025efeae28..b447c3e4abad 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -800,7 +800,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	}
 
 	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
-					      NULL);
+					      &bridge->dma_ranges, NULL);
 	if (ret) {
 		dev_err(dev, "Failed add resources\n");
 		return ret;
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 97e251090b4f..a8f7a6284c3e 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -211,7 +211,7 @@ static int cdns_pcie_host_init(struct device *dev,
 	int err;
 
 	/* Parse our PCI ranges and request their resources */
-	err = pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
+	err = pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_range);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 375d815f7301..ff0a81a632a1 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -95,7 +95,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy))
 		return PTR_ERR(pcie->phy);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
 	if (ret) {
 		dev_err(dev, "unable to get PCI host bridge resources\n");
 		return ret;
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index df19beb2b2f1..d334925f19fd 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1034,7 +1034,7 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	int err;
 
 	err = pci_parse_request_of_pci_ranges(dev, windows,
-					      &bus);
+					      &host->dma_ranges, &bus);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 4eab8624ce4d..257ba49c177c 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -875,7 +875,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* parse the host bridge base addresses from the device tree file */
-	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return ret;
diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index f6a669a9af41..b8d6e86a5539 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1138,7 +1138,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie->dev = dev;
 	platform_set_drvdata(pdev, pcie);
 
-	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
+	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
+					      &bridge->dma_ranges, NULL);
 	if (err)
 		goto err_free_bridge;
 
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 2255ff53e2fb..b538b9ad8917 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -1004,7 +1004,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_deinit_port;
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, &bus_res);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, &bus_res);
 	if (err)
 		goto err_remove_irq_domain;
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index e135a4b60489..9bd1427f2fd6 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -843,7 +843,8 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 257702288787..98e55297815b 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -645,7 +645,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bridge->dma_ranges, NULL);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index f3da49a31db4..0b1e4623dfcf 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -257,7 +257,9 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  */
 int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base)
+			struct list_head *resources,
+			struct list_head *ib_resources,
+			resource_size_t *io_base)
 {
 	struct device_node *dev_node = dev->of_node;
 	struct resource *res, tmp_res;
@@ -340,6 +342,42 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
 	}
 
+	/* Check for dma-ranges property */
+	if (!ib_resources)
+		return 0;
+	err = of_pci_dma_range_parser_init(&parser, dev_node);
+	if (err)
+		return 0;
+
+	dev_dbg(dev, "Parsing dma-ranges property...\n");
+	for_each_of_pci_range(&parser, &range) {
+		/*
+		 * If we failed translation or got a zero-sized region
+		 * then skip this range
+		 */
+		if (((range.flags & IORESOURCE_TYPE_BITS) != IORESOURCE_MEM) ||
+		    range.cpu_addr == OF_BAD_ADDR || range.size == 0)
+			continue;
+
+		dev_info(dev, "IB MEM %#010llx..%#010llx -> %#010llx\n",
+			 range.cpu_addr,
+			 range.cpu_addr + range.size - 1, range.pci_addr);
+
+
+		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
+		if (err)
+			continue;
+
+		res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
+		if (!res) {
+			err = -ENOMEM;
+			goto failed;
+		}
+
+		pci_add_resource_offset(ib_resources, res,
+					res->start - range.pci_addr);
+	}
+
 	return 0;
 
 failed:
@@ -482,6 +520,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
 
 int pci_parse_request_of_pci_ranges(struct device *dev,
 				    struct list_head *resources,
+				    struct list_head *ib_resources,
 				    struct resource **bus_range)
 {
 	int err, res_valid = 0;
@@ -489,8 +528,10 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	struct resource_entry *win, *tmp;
 
 	INIT_LIST_HEAD(resources);
+	if (ib_resources)
+		INIT_LIST_HEAD(ib_resources);
 	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
-						    &iobase);
+						    ib_resources, &iobase);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6947ee3324..6692c4fe4290 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -633,11 +633,15 @@ static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 #if defined(CONFIG_OF_ADDRESS)
 int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base);
+			struct list_head *resources,
+			struct list_head *ib_resources,
+			resource_size_t *io_base);
 #else
 static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources, resource_size_t *io_base)
+			struct list_head *resources,
+			struct list_head *ib_resources,
+			resource_size_t *io_base)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..df6bafc54080 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2278,6 +2278,7 @@ struct irq_domain;
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
 int pci_parse_request_of_pci_ranges(struct device *dev,
 				    struct list_head *resources,
+				    struct list_head *ib_resources,
 				    struct resource **bus_range);
 
 /* Arch may override this (weak) */
@@ -2288,6 +2289,7 @@ static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline int pci_parse_request_of_pci_ranges(struct device *dev,
 						  struct list_head *resources,
+						  struct list_head *ib_resources,
 						  struct resource **bus_range)
 {
 	return -EINVAL;
-- 
2.20.1

