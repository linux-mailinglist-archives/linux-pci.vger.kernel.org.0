Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35699BD47E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394267AbfIXVql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43426 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388524AbfIXVql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so3042302oih.10;
        Tue, 24 Sep 2019 14:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NoeAS779Z7n+6bw4b58c1x/JgogGZV7oOEiXSfojCsM=;
        b=T7ovEIXdVY09AkE2NOvyoystac8CwLrB/zPJodIhOPqTDHWmge7p7GTxqfL8/+NrPP
         Bz+56rLEdq6OIoiDDnyE7uyJr5AdADpNyMqWIgwqhlxlRCeeG8qyZquxbyO0DzkqnGrm
         uHw00UEeIvajisDd5SxPmK/htnACjoyqAg0uzq0DXorJTNUTiQqQ+DUXtzAAr4dCZjPo
         EL85TAeesRO4d45qqmwSdJm1bxMJ1S2rZRMufjFzQp/TnHd1q+ArzCvIhh56pr4+g+o+
         4sX0djL8NFseydwyDVJI2rNpb0SWi6bakgv0Javwg8JjLMuzz1jZNp3CMDl57nnjaTvL
         2hjA==
X-Gm-Message-State: APjAAAV/AKWOKnqB7hl4Cd2SAQe0bQCTLV2B4j6iUV21RpHMxuhvlYPY
        D8x7eYNtzvUxE208flt2LhpW0+A=
X-Google-Smtp-Source: APXvYqxdAPeGtkEzrkp60jWMj/G0sVTCH/6vT1EK9Awn+6rp6xQIJmnnnBtehNhsOnyt3SkFcaTbLg==
X-Received: by 2002:aca:1a16:: with SMTP id a22mr2013528oia.49.1569361599819;
        Tue, 24 Sep 2019 14:46:39 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <lftan@altera.com>,
        Tom Joseph <tjoseph@cadence.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        rfi@lists.rocketboards.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 06/11] PCI: of: Add inbound resource parsing to helpers
Date:   Tue, 24 Sep 2019 16:46:25 -0500
Message-Id: <20190924214630.12817-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
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
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c |  3 +-
 drivers/pci/controller/pci-aardvark.c         |  2 +-
 drivers/pci/controller/pci-ftpci100.c         |  3 +-
 drivers/pci/controller/pci-host-common.c      |  2 +-
 drivers/pci/controller/pci-v3-semi.c          |  2 +-
 drivers/pci/controller/pci-versatile.c        |  2 +-
 drivers/pci/controller/pci-xgene.c            |  1 +
 drivers/pci/controller/pcie-altera.c          |  2 +-
 drivers/pci/controller/pcie-cadence-host.c    |  2 +-
 drivers/pci/controller/pcie-iproc-platform.c  |  1 +
 drivers/pci/controller/pcie-mediatek.c        |  2 +-
 drivers/pci/controller/pcie-mobiveil.c        |  4 +-
 drivers/pci/controller/pcie-rcar.c            |  3 +-
 drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
 drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
 drivers/pci/controller/pcie-xilinx.c          |  2 +-
 drivers/pci/of.c                              | 44 ++++++++++++++++++-
 drivers/pci/pci.h                             |  8 +++-
 include/linux/pci.h                           |  2 +
 19 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f93252d0da5b..0743ae64bb0f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -342,7 +342,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		return -ENOMEM;
 
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-					&bridge->windows, &pp->io_base);
+					&bridge->windows, &bridge->dma_ranges,
+					&pp->io_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ff3af3d34028..c00b391529f3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -940,7 +940,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	}
 
 	ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
-					      &bus);
+					      &bridge->dma_ranges, &bus);
 	if (ret) {
 		dev_err(dev, "Failed to parse resources\n");
 		return ret;
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index bf5ece5d9291..3e07a8203736 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -481,7 +481,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 		return PTR_ERR(p->base);
 
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &res, &io_base);
+						    &res, &host->dma_ranges,
+						    &io_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c742881b5061..183381c19ee8 100644
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
index d219404bad92..090df766faf9 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -794,7 +794,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 		return PTR_ERR(v3->config_base);
 
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
-						    &io_base);
+						    &host->dma_ranges, &io_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 237b1abb26f2..211159f54b4a 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -93,7 +93,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(versatile_cfg_base[1]))
 		return PTR_ERR(versatile_cfg_base[1]);
 
-	ret = pci_parse_request_of_pci_ranges(dev, &pci_res, NULL);
+	ret = pci_parse_request_of_pci_ranges(dev, &pci_res, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index ffda3e8b4742..11f27c42c06a 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -635,6 +635,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
+						    &bridge->dma_ranges,
 						    &iobase);
 	if (ret)
 		return ret;
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2ed00babff5a..fde6a3b16fb9 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -801,7 +801,7 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	}
 
 	ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
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
index 5a3550b6bb29..62eee2d17f43 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -101,6 +101,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
+						    &bridge->dma_ranges,
 						    &iobase);
 	if (ret) {
 		dev_err(dev, "unable to get PCI host bridge resources\n");
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cea4112b5309..f3996eed152d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1032,7 +1032,7 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	int err;
 
 	err = pci_parse_request_of_pci_ranges(dev, windows,
-					      &bus);
+					      &host->dma_ranges, &bus);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 672e633601c7..93064faaa656 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -875,7 +875,9 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 
 	/* parse the host bridge base addresses from the device tree file */
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
+						    &pcie->resources,
+						    &bridge->dma_ranges,
+						    &iobase);
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
index 8d20f1793a61..093b816b9dc9 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -996,7 +996,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_deinit_port;
 
 	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &res, &io_base);
+						    &res, &bridge->dma_ranges,
+						    &io_base);
 	if (err)
 		goto err_remove_irq_domain;
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 45c0f344ccd1..5c9132a02d15 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -846,7 +846,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	}
 
 	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
-						    &iobase);
+						    &bridge->dma_ranges, &iobase);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 5bf3af3b28e6..a95faca30291 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -648,7 +648,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	}
 
 	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
-						    &iobase);
+						    &bridge->dma_ranges, &iobase);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index bc7b27a28795..8d31e078461f 100644
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
@@ -489,8 +528,9 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	struct resource_entry *win, *tmp;
 
 	INIT_LIST_HEAD(resources);
+	INIT_LIST_HEAD(ib_resources);
 	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
-						    &iobase);
+						    ib_resources, &iobase);
 	if (err)
 		return err;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d22d1b807701..790458953c54 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -582,11 +582,15 @@ of_pci_get_max_link_speed(struct device_node *node)
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
+			resource_size_t *io_base);
 {
 	return -EINVAL;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82e4cd1b7ac3..d57389b86f92 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2312,6 +2312,7 @@ void pci_release_bus_of_node(struct pci_bus *bus);
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
 int pci_parse_request_of_pci_ranges(struct device *dev,
 				    struct list_head *resources,
+				    struct list_head *ib_resources,
 				    struct resource **bus_range);
 
 /* Arch may override this (weak) */
@@ -2326,6 +2327,7 @@ static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline int pci_parse_request_of_pci_ranges(struct device *dev,
 						  struct list_head *resources,
+						  struct list_head *ib_resources,
 						  struct resource **bus_range)
 {
 	return -EINVAL;
-- 
2.20.1

