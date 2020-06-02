Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDF1EC0CC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBRQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 13:16:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC726C05BD1E;
        Tue,  2 Jun 2020 10:16:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m1so5371020pgk.1;
        Tue, 02 Jun 2020 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECV7MViJhNn0RuU05iBSnmEkE8SIp1DMaGZTHaxcfhs=;
        b=H6akTEGthQUBZkxTA30TH1mgMVAVssTUsIXHwzsxW6qKXv15WI3V+FsesjHjzSEuXm
         kBt8z7Rc+6yQacyrwBzUFtuVQwThAm7cbin0OGc+CWA0AnogUcD5McDP2IJhSHQeYO7J
         ++NKJIr5hK+r8zq4eVl9Oc6hMYEdU9zWo3o7nDebGmLujsdTSWijCdAvCG+AGLfWNeCj
         KGlvSA29WNCmrTJF09fAu+oicpfTAXw5TzrGTsJAruTRe0C/rF1KZFoUOgdgv87GfkAs
         1493EsxTeE6SAcYTN5mdfiHoOyP/irjxEjExpS9rGP+l9OXyeY6sCOI8Lwq+r3ceaGSm
         IgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECV7MViJhNn0RuU05iBSnmEkE8SIp1DMaGZTHaxcfhs=;
        b=OYeejursMN8bmGUn44VvErG/shRnCCKpuHGNkly/ZSKPGF5Nyj5dUGt1ZlahmdiOeL
         iju+ZhcOyDI0p8Tw5vQWjkTMPqqVk65DzmdgUyPVz7uwqqzH1mX5QKWoTmPt9HiGeBbG
         zUssKGE3P+rqOWVGJPCkzvQQlQZmp+PyMgg4PP1AaEJaQM2TLz/3sIJulzLMq4qUIJoW
         pKdYuyyhcmUgr5KivKLYTJK8D+MOKj6K0DdeUWQwdlJ+fkB0Au0tY8+nugTK6/JnL1ER
         7n+tC4HSW3Mmn7fCZq+bYylutf6VHenDLXmoxBuYG4QN63otKL8xqZGgmuh9hjuMRQ2p
         n07w==
X-Gm-Message-State: AOAM530hR3AXBj4iVrX4WYhxTHDqlQQmqZb0Mg5c+jZKUymRDK5h3gOa
        jVGYR6B026xjmEMajbArEx8=
X-Google-Smtp-Source: ABdhPJyz5H4CSDJqPBN56joAUkb39gMu1+xqLMlY6U73yl4NplLy3v4TiJqoecRPU8wq28Dp6cOAEg==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr15120749pfc.189.1591118170331;
        Tue, 02 Jun 2020 10:16:10 -0700 (PDT)
Received: from localhost ([162.211.223.96])
        by smtp.gmail.com with ESMTPSA id y9sm2926598pjy.56.2020.06.02.10.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 10:16:09 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        toan@os.amperecomputing.com, ley.foon.tan@intel.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2] PCI: controller: convert to devm_platform_ioremap_resource_byname()
Date:   Wed,  3 Jun 2020 01:16:01 +0800
Message-Id: <20200602171601.17630-1-zhengdejin5@gmail.com>
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
v1 -> v2:
	- Discard changes to the file drivers/pci/controller/pcie-xilinx-nwl.c
	  Due to my mistakes, my patch will modify pcie-xilinx-nwl.c,
	  but it still need to use the res variable, but
	  devm_platform_ioremap_resource_byname() funtion can't assign a
	  value to the variable res. kbuild test robot report it. Thanks
	  very much for kbuild test robot <lkp@intel.com>.

 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 3 +--
 drivers/pci/controller/cadence/pcie-cadence-host.c | 3 +--
 drivers/pci/controller/pci-tegra.c                 | 8 +++-----
 drivers/pci/controller/pci-xgene.c                 | 3 +--
 drivers/pci/controller/pcie-altera-msi.c           | 3 +--
 drivers/pci/controller/pcie-altera.c               | 9 +++------
 drivers/pci/controller/pcie-mediatek.c             | 4 +---
 drivers/pci/controller/pcie-rockchip.c             | 5 ++---
 8 files changed, 13 insertions(+), 25 deletions(-)

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
 
-- 
2.25.0

