Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0145FF19
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhK0OTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhK0ORs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:48 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF7C0613E1
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q3so2334587wru.5
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEVHP1Z7SXziMrmDguErfOjl2Wgj4B31N+1BfgHsn/U=;
        b=pXpCZegAvrkl+3je5xwGq4D3det+7TlmeoHF7AjL0WKB0MlQ67TjbOo9ClwNo7zh3l
         JQu66pwZsoovlBH5Uqj+g49y3FrQAJnXGu/bk2ZILDNQovhcJmB9UPNHBFjMWSWnFOEY
         nIE5iHd8uFKqrDzzH2P4RgJHFBLcmNogKAVzRZi7hZNX8QuADZpYs1np3TbVNN59kilv
         +6tXiFC9EXG3IXZzCbK3Lg+Ubxr5wChUCcyWohu1NLs5oAiJDqqFqPS0lbhm/PA5PYGb
         qDIibNMLOowNrHzroFQ07izdB2PIPOYN4U0iQq3Mb76lwyOQmyEd7dutwMvk8idzrGX8
         oa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEVHP1Z7SXziMrmDguErfOjl2Wgj4B31N+1BfgHsn/U=;
        b=sIZlG9V5lwCb2L29OdLcSC5x6lLqr/1RQmyzVCKHne48l9gwece2HqgEqgq2V5eKX1
         e7rm8tgMP/Dzk7uwchkGqr1yVO0hcpeab65+qS3bWtFhWmDsDWACs+uGU1i8DBb6F+zY
         oEOPGZCfgL/akncM83qiG0NqU8mimrOyiSikUs20KHH4KrSCYbO6qNs6K8Co25qvWhSr
         92idZNc69BdN6rrAFvEpyaVkZACrXlj82gzIorSruce3ttuV+89GIsjd9n84I5Uzwz3I
         SJI46ipckHhUHmtLJpEHLvIE/blnf3CdELQSnsMFOTdbbEXcOXyZqUSsHlW6rhVz1/xQ
         WUUQ==
X-Gm-Message-State: AOAM532p8oM0roLD7sWU/gRVGKzrOrKaxUTT/ceMylwMAwMKEcOQtRkS
        j6zWavZlUXEzmnzc2K56u2w=
X-Google-Smtp-Source: ABdhPJxNvYM+onzR5frLegIltIq3rRh0Qnli2Jj6QLVjbYniqGXXF+uKJn4C4+YQGBNZbjMnrPc1Dw==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr20179386wrt.327.1638022292438;
        Sat, 27 Nov 2021 06:11:32 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:32 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 04/13] PCI: xegene: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:12 +0100
Message-Id: <273bcf128fa16901a51f4143ff291e52905d0703.1638022049.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller struct contain "device *", while others contain
"platform_device *". Unify "device *dev" to "platform_device *pdev" in
struct xgene_pcie, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 222 ++++++++++++++---------------
 1 file changed, 111 insertions(+), 111 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index ba11f369a1c9..f66abd60058b 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -61,8 +61,8 @@
 
 #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 struct xgene_pcie {
+	struct platform_device		*pdev;
 	struct device_node	*node;
-	struct device		*dev;
 	struct clk		*clk;
 	void __iomem		*csr_base;
 	void __iomem		*cfg_base;
@@ -71,14 +71,14 @@ struct xgene_pcie {
 	u32			version;
 };
 
-static u32 xgene_pcie_readl(struct xgene_pcie *port, u32 reg)
+static u32 xgene_pcie_readl(struct xgene_pcie *pcie, u32 reg)
 {
-	return readl(port->csr_base + reg);
+	return readl(pcie->csr_base + reg);
 }
 
-static void xgene_pcie_writel(struct xgene_pcie *port, u32 reg, u32 val)
+static void xgene_pcie_writel(struct xgene_pcie *pcie, u32 reg, u32 val)
 {
-	writel(val, port->csr_base + reg);
+	writel(val, pcie->csr_base + reg);
 }
 
 static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
@@ -103,12 +103,12 @@ static inline struct xgene_pcie *pcie_bus_to_port(struct pci_bus *bus)
  */
 static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
 {
-	struct xgene_pcie *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *pcie = pcie_bus_to_port(bus);
 
 	if (bus->number >= (bus->primary + 1))
-		return port->cfg_base + AXI_EP_CFG_ACCESS;
+		return pcie->cfg_base + AXI_EP_CFG_ACCESS;
 
-	return port->cfg_base;
+	return pcie->cfg_base;
 }
 
 /*
@@ -117,7 +117,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
  */
 static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 {
-	struct xgene_pcie *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *pcie = pcie_bus_to_port(bus);
 	unsigned int b, d, f;
 	u32 rtdid_val = 0;
 
@@ -128,9 +128,9 @@ static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 	if (!pci_is_root_bus(bus))
 		rtdid_val = (b << 8) | (d << 3) | f;
 
-	xgene_pcie_writel(port, RTDID, rtdid_val);
+	xgene_pcie_writel(pcie, RTDID, rtdid_val);
 	/* read the register back to ensure flush */
-	xgene_pcie_readl(port, RTDID);
+	xgene_pcie_readl(pcie, RTDID);
 }
 
 /*
@@ -164,7 +164,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
-	struct xgene_pcie *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *pcie = pcie_bus_to_port(bus);
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
 	    PCIBIOS_SUCCESSFUL)
@@ -180,7 +180,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	 * the read until it times out.  Avoid this by not claiming to
 	 * support CRS SV.
 	 */
-	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
+	if (pci_is_root_bus(bus) && (pcie->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
 		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
 
@@ -227,12 +227,12 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 {
 	struct device *dev = cfg->parent;
 	struct acpi_device *adev = to_acpi_device(dev);
-	struct xgene_pcie *port;
+	struct xgene_pcie *pcie;
 	struct resource csr;
 	int ret;
 
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
 		return -ENOMEM;
 
 	ret = xgene_get_csr_resource(adev, &csr);
@@ -240,14 +240,14 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 		dev_err(dev, "can't get CSR resource\n");
 		return ret;
 	}
-	port->csr_base = devm_pci_remap_cfg_resource(dev, &csr);
-	if (IS_ERR(port->csr_base))
-		return PTR_ERR(port->csr_base);
+	pcie->csr_base = devm_pci_remap_cfg_resource(dev, &csr);
+	if (IS_ERR(pcie->csr_base))
+		return PTR_ERR(pcie->csr_base);
 
-	port->cfg_base = cfg->win;
-	port->version = ipversion;
+	pcie->cfg_base = cfg->win;
+	pcie->version = ipversion;
 
-	cfg->priv = port;
+	cfg->priv = pcie;
 	return 0;
 }
 
@@ -281,59 +281,59 @@ const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
 #endif
 
 #if defined(CONFIG_PCI_XGENE)
-static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *port, u32 addr,
+static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *pcie, u32 addr,
 				  u32 flags, u64 size)
 {
 	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
 	u32 val32 = 0;
 	u32 val;
 
-	val32 = xgene_pcie_readl(port, addr);
+	val32 = xgene_pcie_readl(pcie, addr);
 	val = (val32 & 0x0000ffff) | (lower_32_bits(mask) << 16);
-	xgene_pcie_writel(port, addr, val);
+	xgene_pcie_writel(pcie, addr, val);
 
-	val32 = xgene_pcie_readl(port, addr + 0x04);
+	val32 = xgene_pcie_readl(pcie, addr + 0x04);
 	val = (val32 & 0xffff0000) | (lower_32_bits(mask) >> 16);
-	xgene_pcie_writel(port, addr + 0x04, val);
+	xgene_pcie_writel(pcie, addr + 0x04, val);
 
-	val32 = xgene_pcie_readl(port, addr + 0x04);
+	val32 = xgene_pcie_readl(pcie, addr + 0x04);
 	val = (val32 & 0x0000ffff) | (upper_32_bits(mask) << 16);
-	xgene_pcie_writel(port, addr + 0x04, val);
+	xgene_pcie_writel(pcie, addr + 0x04, val);
 
-	val32 = xgene_pcie_readl(port, addr + 0x08);
+	val32 = xgene_pcie_readl(pcie, addr + 0x08);
 	val = (val32 & 0xffff0000) | (upper_32_bits(mask) >> 16);
-	xgene_pcie_writel(port, addr + 0x08, val);
+	xgene_pcie_writel(pcie, addr + 0x08, val);
 
 	return mask;
 }
 
-static void xgene_pcie_linkup(struct xgene_pcie *port,
+static void xgene_pcie_linkup(struct xgene_pcie *pcie,
 			      u32 *lanes, u32 *speed)
 {
 	u32 val32;
 
-	port->link_up = false;
-	val32 = xgene_pcie_readl(port, PCIECORE_CTLANDSTATUS);
+	pcie->link_up = false;
+	val32 = xgene_pcie_readl(pcie, PCIECORE_CTLANDSTATUS);
 	if (val32 & LINK_UP_MASK) {
-		port->link_up = true;
+		pcie->link_up = true;
 		*speed = PIPE_PHY_RATE_RD(val32);
-		val32 = xgene_pcie_readl(port, BRIDGE_STATUS_0);
+		val32 = xgene_pcie_readl(pcie, BRIDGE_STATUS_0);
 		*lanes = val32 >> 26;
 	}
 }
 
-static int xgene_pcie_init_port(struct xgene_pcie *port)
+static int xgene_pcie_init_port(struct xgene_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = &pcie->pdev->dev;
 	int rc;
 
-	port->clk = clk_get(dev, NULL);
-	if (IS_ERR(port->clk)) {
+	pcie->clk = clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk)) {
 		dev_err(dev, "clock not available\n");
 		return -ENODEV;
 	}
 
-	rc = clk_prepare_enable(port->clk);
+	rc = clk_prepare_enable(pcie->clk);
 	if (rc) {
 		dev_err(dev, "clock enable failed\n");
 		return rc;
@@ -342,31 +342,31 @@ static int xgene_pcie_init_port(struct xgene_pcie *port)
 	return 0;
 }
 
-static int xgene_pcie_map_reg(struct xgene_pcie *port,
+static int xgene_pcie_map_reg(struct xgene_pcie *pcie,
 			      struct platform_device *pdev)
 {
-	struct device *dev = port->dev;
+	struct device *dev = &pdev->dev;
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	port->csr_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(port->csr_base))
-		return PTR_ERR(port->csr_base);
+	pcie->csr_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->csr_base))
+		return PTR_ERR(pcie->csr_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	port->cfg_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(port->cfg_base))
-		return PTR_ERR(port->cfg_base);
-	port->cfg_addr = res->start;
+	pcie->cfg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pcie->cfg_base))
+		return PTR_ERR(pcie->cfg_base);
+	pcie->cfg_addr = res->start;
 
 	return 0;
 }
 
-static void xgene_pcie_setup_ob_reg(struct xgene_pcie *port,
+static void xgene_pcie_setup_ob_reg(struct xgene_pcie *pcie,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
-	struct device *dev = port->dev;
+	struct device *dev = &pcie->pdev->dev;
 	resource_size_t size = resource_size(res);
 	u64 restype = resource_type(res);
 	u64 mask = 0;
@@ -386,28 +386,28 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie *port,
 		dev_warn(dev, "res size 0x%llx less than minimum 0x%x\n",
 			 (u64)size, min_size);
 
-	xgene_pcie_writel(port, offset, lower_32_bits(cpu_addr));
-	xgene_pcie_writel(port, offset + 0x04, upper_32_bits(cpu_addr));
-	xgene_pcie_writel(port, offset + 0x08, lower_32_bits(mask));
-	xgene_pcie_writel(port, offset + 0x0c, upper_32_bits(mask));
-	xgene_pcie_writel(port, offset + 0x10, lower_32_bits(pci_addr));
-	xgene_pcie_writel(port, offset + 0x14, upper_32_bits(pci_addr));
+	xgene_pcie_writel(pcie, offset, lower_32_bits(cpu_addr));
+	xgene_pcie_writel(pcie, offset + 0x04, upper_32_bits(cpu_addr));
+	xgene_pcie_writel(pcie, offset + 0x08, lower_32_bits(mask));
+	xgene_pcie_writel(pcie, offset + 0x0c, upper_32_bits(mask));
+	xgene_pcie_writel(pcie, offset + 0x10, lower_32_bits(pci_addr));
+	xgene_pcie_writel(pcie, offset + 0x14, upper_32_bits(pci_addr));
 }
 
-static void xgene_pcie_setup_cfg_reg(struct xgene_pcie *port)
+static void xgene_pcie_setup_cfg_reg(struct xgene_pcie *pcie)
 {
-	u64 addr = port->cfg_addr;
+	u64 addr = pcie->cfg_addr;
 
-	xgene_pcie_writel(port, CFGBARL, lower_32_bits(addr));
-	xgene_pcie_writel(port, CFGBARH, upper_32_bits(addr));
-	xgene_pcie_writel(port, CFGCTL, EN_REG);
+	xgene_pcie_writel(pcie, CFGBARL, lower_32_bits(addr));
+	xgene_pcie_writel(pcie, CFGBARH, upper_32_bits(addr));
+	xgene_pcie_writel(pcie, CFGCTL, EN_REG);
 }
 
-static int xgene_pcie_map_ranges(struct xgene_pcie *port)
+static int xgene_pcie_map_ranges(struct xgene_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct resource_entry *window;
-	struct device *dev = port->dev;
+	struct device *dev = &pcie->pdev->dev;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		struct resource *res = window->res;
@@ -417,18 +417,18 @@ static int xgene_pcie_map_ranges(struct xgene_pcie *port)
 
 		switch (restype) {
 		case IORESOURCE_IO:
-			xgene_pcie_setup_ob_reg(port, res, OMR3BARL,
+			xgene_pcie_setup_ob_reg(pcie, res, OMR3BARL,
 						pci_pio_to_address(res->start),
 						res->start - window->offset);
 			break;
 		case IORESOURCE_MEM:
 			if (res->flags & IORESOURCE_PREFETCH)
-				xgene_pcie_setup_ob_reg(port, res, OMR2BARL,
+				xgene_pcie_setup_ob_reg(pcie, res, OMR2BARL,
 							res->start,
 							res->start -
 							window->offset);
 			else
-				xgene_pcie_setup_ob_reg(port, res, OMR1BARL,
+				xgene_pcie_setup_ob_reg(pcie, res, OMR1BARL,
 							res->start,
 							res->start -
 							window->offset);
@@ -440,18 +440,18 @@ static int xgene_pcie_map_ranges(struct xgene_pcie *port)
 			return -EINVAL;
 		}
 	}
-	xgene_pcie_setup_cfg_reg(port);
+	xgene_pcie_setup_cfg_reg(pcie);
 	return 0;
 }
 
-static void xgene_pcie_setup_pims(struct xgene_pcie *port, u32 pim_reg,
+static void xgene_pcie_setup_pims(struct xgene_pcie *pcie, u32 pim_reg,
 				  u64 pim, u64 size)
 {
-	xgene_pcie_writel(port, pim_reg, lower_32_bits(pim));
-	xgene_pcie_writel(port, pim_reg + 0x04,
+	xgene_pcie_writel(pcie, pim_reg, lower_32_bits(pim));
+	xgene_pcie_writel(pcie, pim_reg + 0x04,
 			  upper_32_bits(pim) | EN_COHERENCY);
-	xgene_pcie_writel(port, pim_reg + 0x10, lower_32_bits(size));
-	xgene_pcie_writel(port, pim_reg + 0x14, upper_32_bits(size));
+	xgene_pcie_writel(pcie, pim_reg + 0x10, lower_32_bits(size));
+	xgene_pcie_writel(pcie, pim_reg + 0x14, upper_32_bits(size));
 }
 
 /*
@@ -478,12 +478,12 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 	return -EINVAL;
 }
 
-static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
+static void xgene_pcie_setup_ib_reg(struct xgene_pcie *pcie,
 				    struct resource_entry *entry,
 				    u8 *ib_reg_mask)
 {
-	void __iomem *cfg_base = port->cfg_base;
-	struct device *dev = port->dev;
+	void __iomem *cfg_base = pcie->cfg_base;
+	struct device *dev = &pcie->pdev->dev;
 	void __iomem *bar_addr;
 	u32 pim_reg;
 	u64 cpu_addr = entry->res->start;
@@ -506,72 +506,72 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
 	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
 	switch (region) {
 	case 0:
-		xgene_pcie_set_ib_mask(port, BRIDGE_CFG_4, flags, size);
+		xgene_pcie_set_ib_mask(pcie, BRIDGE_CFG_4, flags, size);
 		bar_addr = cfg_base + PCI_BASE_ADDRESS_0;
 		writel(bar_low, bar_addr);
 		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
 		pim_reg = PIM1_1L;
 		break;
 	case 1:
-		xgene_pcie_writel(port, IBAR2, bar_low);
-		xgene_pcie_writel(port, IR2MSK, lower_32_bits(mask));
+		xgene_pcie_writel(pcie, IBAR2, bar_low);
+		xgene_pcie_writel(pcie, IR2MSK, lower_32_bits(mask));
 		pim_reg = PIM2_1L;
 		break;
 	case 2:
-		xgene_pcie_writel(port, IBAR3L, bar_low);
-		xgene_pcie_writel(port, IBAR3L + 0x4, upper_32_bits(cpu_addr));
-		xgene_pcie_writel(port, IR3MSKL, lower_32_bits(mask));
-		xgene_pcie_writel(port, IR3MSKL + 0x4, upper_32_bits(mask));
+		xgene_pcie_writel(pcie, IBAR3L, bar_low);
+		xgene_pcie_writel(pcie, IBAR3L + 0x4, upper_32_bits(cpu_addr));
+		xgene_pcie_writel(pcie, IR3MSKL, lower_32_bits(mask));
+		xgene_pcie_writel(pcie, IR3MSKL + 0x4, upper_32_bits(mask));
 		pim_reg = PIM3_1L;
 		break;
 	}
 
-	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
+	xgene_pcie_setup_pims(pcie, pim_reg, pci_addr, ~(size - 1));
 }
 
-static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
+static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct resource_entry *entry;
 	u8 ib_reg_mask = 0;
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges)
-		xgene_pcie_setup_ib_reg(port, entry, &ib_reg_mask);
+		xgene_pcie_setup_ib_reg(pcie, entry, &ib_reg_mask);
 
 	return 0;
 }
 
 /* clear BAR configuration which was done by firmware */
-static void xgene_pcie_clear_config(struct xgene_pcie *port)
+static void xgene_pcie_clear_config(struct xgene_pcie *pcie)
 {
 	int i;
 
 	for (i = PIM1_1L; i <= CFGCTL; i += 4)
-		xgene_pcie_writel(port, i, 0);
+		xgene_pcie_writel(pcie, i, 0);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie *port)
+static int xgene_pcie_setup(struct xgene_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = &pcie->pdev->dev;
 	u32 val, lanes = 0, speed = 0;
 	int ret;
 
-	xgene_pcie_clear_config(port);
+	xgene_pcie_clear_config(pcie);
 
 	/* setup the vendor and device IDs correctly */
 	val = (XGENE_PCIE_DEVICEID << 16) | PCI_VENDOR_ID_AMCC;
-	xgene_pcie_writel(port, BRIDGE_CFG_0, val);
+	xgene_pcie_writel(pcie, BRIDGE_CFG_0, val);
 
-	ret = xgene_pcie_map_ranges(port);
+	ret = xgene_pcie_map_ranges(pcie);
 	if (ret)
 		return ret;
 
-	ret = xgene_pcie_parse_map_dma_ranges(port);
+	ret = xgene_pcie_parse_map_dma_ranges(pcie);
 	if (ret)
 		return ret;
 
-	xgene_pcie_linkup(port, &lanes, &speed);
-	if (!port->link_up)
+	xgene_pcie_linkup(pcie, &lanes, &speed);
+	if (!pcie->link_up)
 		dev_info(dev, "(rc) link down\n");
 	else
 		dev_info(dev, "(rc) x%d gen-%d link up\n", lanes, speed + 1);
@@ -588,36 +588,36 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
-	struct xgene_pcie *port;
+	struct xgene_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	int ret;
 
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
 
-	port = pci_host_bridge_priv(bridge);
+	pcie = pci_host_bridge_priv(bridge);
 
-	port->node = of_node_get(dn);
-	port->dev = dev;
+	pcie->node = of_node_get(dn);
+	pcie->pdev = pdev;
 
-	port->version = XGENE_PCIE_IP_VER_UNKN;
-	if (of_device_is_compatible(port->node, "apm,xgene-pcie"))
-		port->version = XGENE_PCIE_IP_VER_1;
+	pcie->version = XGENE_PCIE_IP_VER_UNKN;
+	if (of_device_is_compatible(pcie->node, "apm,xgene-pcie"))
+		pcie->version = XGENE_PCIE_IP_VER_1;
 
-	ret = xgene_pcie_map_reg(port, pdev);
+	ret = xgene_pcie_map_reg(pcie, pdev);
 	if (ret)
 		return ret;
 
-	ret = xgene_pcie_init_port(port);
+	ret = xgene_pcie_init_port(pcie);
 	if (ret)
 		return ret;
 
-	ret = xgene_pcie_setup(port);
+	ret = xgene_pcie_setup(pcie);
 	if (ret)
 		return ret;
 
-	bridge->sysdata = port;
+	bridge->sysdata = pcie;
 	bridge->ops = &xgene_pcie_ops;
 
 	return pci_host_probe(bridge);
-- 
2.25.1

