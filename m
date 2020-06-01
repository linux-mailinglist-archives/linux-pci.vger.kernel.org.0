Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B791EA5F3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFAOeI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAOeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 10:34:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A0C05BD43;
        Mon,  1 Jun 2020 07:34:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so5199143pjd.1;
        Mon, 01 Jun 2020 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhoKygBJPW8iiIoYuukeRCoyeOo+oUPTgHmqfyOxcvs=;
        b=SpGwooTQrY8w7OScm+BONuS5vtcYZUYsWC4mwMEc3yBEl3ExbsH165wtvd12acE8nX
         9ZtRbRK4xPdf957YMrQqdObrSqCqd9pIxLXkTy8jpgjaUF9i+bFysnK1PJZXwtuFmRks
         doR+oh8l0a9dBoq4VnvDdff59z0hsjQwyZwcWkfQEMYLOYzjPcx1NSm+iuasCEXRvexT
         tBVjwWyLldl7XB3ImGWpN6x/Fii6R6bJFZQgJ//FY6GULAVJoMfV1/Eh+tbeX1H30fy5
         OdckL3qNwURn5Oki7LsxY7LV+8KFPOqzXx1LfCgo6bB5lRIMqZP72TOD/GGgOv68Dgou
         fcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhoKygBJPW8iiIoYuukeRCoyeOo+oUPTgHmqfyOxcvs=;
        b=tb55351k6IlbKIVvV2evwYRSUP/I8sI63wXhr7CvBob0tPs8ZqGycZe1vFTAXdB+DV
         QUgGboW42PCD/m6fZfG4zs5ElaFu6bd9GcjXKApAR4m+EZQPtiZ3OQpXfIgsmP1GNgGK
         kRxZi+GwdG0rlrXSIod0s+7O0NMyZeicqB3ovw3gXL9dAsp+pzi2Ii0xx4nCxvin2q2O
         A7ctIokuXmnomrnsZGTkufjWKxvftl7pkvmiBLSEPLZ8tWKEwhyL66sknLspPTJgYXYN
         dyicqfhnbWQ9d69NRPORxdeFYinqSbaNyam6QIQHr92+kzDQaytPLIHCr0kqzwgxJivD
         SMsw==
X-Gm-Message-State: AOAM531yHlfTydRsXkaJEV1ZqI6EkvZAwfzxk+RFrcDyN7i2NXhYSItH
        NZSXOL6jnoOXFW0Iwn37iqY=
X-Google-Smtp-Source: ABdhPJzsVXxbq0rgv3G4+xD5SQR4d71vaU3b/C3b9HtFv18loQOdwREM5bD/IdEw8fDltSWgkc6SdQ==
X-Received: by 2002:a17:90b:315:: with SMTP id ay21mr21554693pjb.134.1591022046785;
        Mon, 01 Jun 2020 07:34:06 -0700 (PDT)
Received: from localhost ([162.211.223.96])
        by smtp.gmail.com with ESMTPSA id p16sm12992905pgj.53.2020.06.01.07.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 07:34:06 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        toan@os.amperecomputing.com, ley.foon.tan@intel.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] PCI: controller: convert to devm_platform_ioremap_resource_byname()
Date:   Mon,  1 Jun 2020 22:33:45 +0800
Message-Id: <20200601143345.24965-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use devm_platform_ioremap_resource_byname() to simplify codes.
it contains platform_get_resource_byname() and devm_ioremap_resource().

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 3 +--
 drivers/pci/controller/cadence/pcie-cadence-host.c | 3 +--
 drivers/pci/controller/pci-tegra.c                 | 8 +++-----
 drivers/pci/controller/pci-xgene.c                 | 3 +--
 drivers/pci/controller/pcie-altera-msi.c           | 3 +--
 drivers/pci/controller/pcie-altera.c               | 9 +++------
 drivers/pci/controller/pcie-mediatek.c             | 4 +---
 drivers/pci/controller/pcie-rockchip.c             | 5 ++---
 drivers/pci/controller/pcie-xilinx-nwl.c           | 7 +++----
 9 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c15c8352125..74ffa03fde5f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -408,8 +408,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 
 	pcie->is_rc = false;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
-	pcie->reg_base = devm_ioremap_resource(dev, res);
+	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
 	if (IS_ERR(pcie->reg_base)) {
 		dev_err(dev, "missing \"reg\"\n");
 		return PTR_ERR(pcie->reg_base);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8c2543f28ba0..dcc460a54875 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -225,8 +225,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	rc->device_id = 0xffff;
 	of_property_read_u32(np, "device-id", &rc->device_id);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
-	pcie->reg_base = devm_ioremap_resource(dev, res);
+	pcie->reg_base = devm_platform_ioremap_resource_byname(pdev, "reg");
 	if (IS_ERR(pcie->reg_base)) {
 		dev_err(dev, "missing \"reg\"\n");
 		return PTR_ERR(pcie->reg_base);
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index e3e917243e10..3e608383df66 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1462,7 +1462,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *pads, *afi, *res;
+	struct resource *res;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
@@ -1486,15 +1486,13 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 		}
 	}
 
-	pads = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pads");
-	pcie->pads = devm_ioremap_resource(dev, pads);
+	pcie->pads = devm_platform_ioremap_resource_byname(pdev, "pads");
 	if (IS_ERR(pcie->pads)) {
 		err = PTR_ERR(pcie->pads);
 		goto phys_put;
 	}
 
-	afi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "afi");
-	pcie->afi = devm_ioremap_resource(dev, afi);
+	pcie->afi = devm_platform_ioremap_resource_byname(pdev, "afi");
 	if (IS_ERR(pcie->afi)) {
 		err = PTR_ERR(pcie->afi);
 		goto phys_put;
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index d1efa8ffbae1..1431a18eb02c 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -355,8 +355,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	if (IS_ERR(port->csr_base))
 		return PTR_ERR(port->csr_base);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	port->cfg_base = devm_ioremap_resource(dev, res);
+	port->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
 	if (IS_ERR(port->cfg_base))
 		return PTR_ERR(port->cfg_base);
 	port->cfg_addr = res->start;
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 16d938920ca5..613e19af71bd 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -228,8 +228,7 @@ static int altera_msi_probe(struct platform_device *pdev)
 	mutex_init(&msi->lock);
 	msi->pdev = pdev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
+	msi->csr_base = devm_platform_ioremap_resource_byname(pdev, "csr");
 	if (IS_ERR(msi->csr_base)) {
 		dev_err(&pdev->dev, "failed to map csr memory\n");
 		return PTR_ERR(msi->csr_base);
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 24cb1c331058..7200e40ffa26 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -696,17 +696,14 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct platform_device *pdev = pcie->pdev;
-	struct resource *cra;
-	struct resource *hip;
 
-	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
-	pcie->cra_base = devm_ioremap_resource(dev, cra);
+	pcie->cra_base = devm_platform_ioremap_resource_byname(pdev, "Cra");
 	if (IS_ERR(pcie->cra_base))
 		return PTR_ERR(pcie->cra_base);
 
 	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
-		hip = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Hip");
-		pcie->hip_base = devm_ioremap_resource(&pdev->dev, hip);
+		pcie->hip_base =
+			devm_platform_ioremap_resource_byname(pdev, "Hip");
 		if (IS_ERR(pcie->hip_base))
 			return PTR_ERR(pcie->hip_base);
 	}
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ebfa7d5a4e2d..d8e38276dbe3 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -905,7 +905,6 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 			       int slot)
 {
 	struct mtk_pcie_port *port;
-	struct resource *regs;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	char name[10];
@@ -916,8 +915,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 		return -ENOMEM;
 
 	snprintf(name, sizeof(name), "port%d", slot);
-	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
-	port->base = devm_ioremap_resource(dev, regs);
+	port->base = devm_platform_ioremap_resource_byname(pdev, name);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map port%d base\n", slot);
 		return PTR_ERR(port->base);
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c53d1322a3d6..904dec0d3a88 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -45,9 +45,8 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 			return -EINVAL;
 	}
 
-	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					    "apb-base");
-	rockchip->apb_base = devm_ioremap_resource(dev, regs);
+	rockchip->apb_base =
+		devm_platform_ioremap_resource_byname(pdev, "apb-base");
 	if (IS_ERR(rockchip->apb_base))
 		return PTR_ERR(rockchip->apb_base);
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 9bd1427f2fd6..06d5ca33d008 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -777,14 +777,13 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	struct device *dev = pcie->dev;
 	struct resource *res;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
-	pcie->breg_base = devm_ioremap_resource(dev, res);
+	pcie->breg_base = devm_platform_ioremap_resource_byname(pdev, "breg");
 	if (IS_ERR(pcie->breg_base))
 		return PTR_ERR(pcie->breg_base);
 	pcie->phys_breg_base = res->start;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcireg");
-	pcie->pcireg_base = devm_ioremap_resource(dev, res);
+	pcie->pcireg_base =
+		devm_platform_ioremap_resource_byname(pdev, "pcireg");
 	if (IS_ERR(pcie->pcireg_base))
 		return PTR_ERR(pcie->pcireg_base);
 	pcie->phys_pcie_reg_base = res->start;
-- 
2.25.0

