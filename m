Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB245FF02
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbhK0OKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355185AbhK0OIO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:08:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA609C061757
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:04:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p18so10444936wmq.5
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55xNdDsbhGQwGCxpHuik1LGW0HwSl/QeIVoHFKNxGfA=;
        b=DDUNDBSAwB4ZuY0jksQFgCR9Rr2moAUzn4LcydlAIHs5ZZzKUQC/FpiCP8psYDfONj
         pwThE/nN4d3OioGM8E9GXY0L9WobLdgfdBMUf+IN+ZUV/SByLqxz6st1G2ikzMnuGlnV
         1+0psaV1d5VJjjIC0sEQVrf2+ZtoRIOqa17S68WvHxNFAmskydHjHynd5D8RjzyUMN8f
         EcrsWjXT/ICwB1fTnuv6vastHm/oYMsD36eiIZ78lrUsYTAblTwKLN3wiYqxAwzmUx5y
         IC1jJrkErCoH2F43mUitWYL85ZWf6aPnpbENiAN3zzNnnq8qR2j3ijNLI5NNVnIgrZPm
         2vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55xNdDsbhGQwGCxpHuik1LGW0HwSl/QeIVoHFKNxGfA=;
        b=R8iuIqzaMLTv6yPGhAvyEBc4nJiUcwH2GW7eBEVwv8ANkUdsY1qOdWISqAv9mvOyw8
         Vn54/p/YgibxQs5RQgRANqNzA/z2+CQ3+Yc31mtujfVWeAWXyxZf+Tb/ytDXaA/9QzMb
         GpSJ0vqsT0KqbHD4hYBay9R4WsKpTT9Eh/CU8k9BVvDW9qmT2QoBDMlzacG7MwErrc8w
         WcQtObJdm2A+KXRXn892p81DC1st0lWU+Ppub4rqxZfXDy66wFcGX7lG/x4YFvrraPIf
         9DjKSB9hKfzhoYoo+JOw1fxMLaPFDljbQhYR8PZinmZreTb0SIgwAIRwv2DmjcEHwX75
         ca5g==
X-Gm-Message-State: AOAM533MEhiUSfz8i68BNd79+cQFDL9GHpbMu0KwzUKNX48VO+hAqIeE
        Q5qkhKHJ3//m/GphiWva/K0=
X-Google-Smtp-Source: ABdhPJxGAZ1VQDz+dYCZWP161/6WCGyYjkfmGHy39WvQ4oCYZ+FYyaWDEttiTC9/PKGm54CFv4YOkg==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr23149338wmj.13.1638021898432;
        Sat, 27 Nov 2021 06:04:58 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id w7sm8447071wru.51.2021.11.27.06.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:04:58 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/6] PCI: xgene: Rename struct xgene_pcie_port to xgene_pcie
Date:   Sat, 27 Nov 2021 15:04:38 +0100
Message-Id: <55ab30f8640e3e7894dfd6b8a89241e0ac191ad0.1638021831.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638021831.git.ffclaire1224@gmail.com>
References: <cover.1638021831.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename struct xgene_pcie_port to xgene_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 46 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 56d0d50338c8..ba11f369a1c9 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -60,7 +60,7 @@
 #define XGENE_PCIE_IP_VER_2		2
 
 #if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
-struct xgene_pcie_port {
+struct xgene_pcie {
 	struct device_node	*node;
 	struct device		*dev;
 	struct clk		*clk;
@@ -71,12 +71,12 @@ struct xgene_pcie_port {
 	u32			version;
 };
 
-static u32 xgene_pcie_readl(struct xgene_pcie_port *port, u32 reg)
+static u32 xgene_pcie_readl(struct xgene_pcie *port, u32 reg)
 {
 	return readl(port->csr_base + reg);
 }
 
-static void xgene_pcie_writel(struct xgene_pcie_port *port, u32 reg, u32 val)
+static void xgene_pcie_writel(struct xgene_pcie *port, u32 reg, u32 val)
 {
 	writel(val, port->csr_base + reg);
 }
@@ -86,15 +86,15 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
 	return (addr & PCI_BASE_ADDRESS_MEM_MASK) | flags;
 }
 
-static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
+static inline struct xgene_pcie *pcie_bus_to_port(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
 
 	if (acpi_disabled)
-		return (struct xgene_pcie_port *)(bus->sysdata);
+		return (struct xgene_pcie *)(bus->sysdata);
 
 	cfg = bus->sysdata;
-	return (struct xgene_pcie_port *)(cfg->priv);
+	return (struct xgene_pcie *)(cfg->priv);
 }
 
 /*
@@ -103,7 +103,7 @@ static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
  */
 static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 
 	if (bus->number >= (bus->primary + 1))
 		return port->cfg_base + AXI_EP_CFG_ACCESS;
@@ -117,7 +117,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
  */
 static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 	unsigned int b, d, f;
 	u32 rtdid_val = 0;
 
@@ -164,7 +164,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
-	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
+	struct xgene_pcie *port = pcie_bus_to_port(bus);
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
 	    PCIBIOS_SUCCESSFUL)
@@ -227,7 +227,7 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 {
 	struct device *dev = cfg->parent;
 	struct acpi_device *adev = to_acpi_device(dev);
-	struct xgene_pcie_port *port;
+	struct xgene_pcie *port;
 	struct resource csr;
 	int ret;
 
@@ -281,7 +281,7 @@ const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
 #endif
 
 #if defined(CONFIG_PCI_XGENE)
-static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
+static u64 xgene_pcie_set_ib_mask(struct xgene_pcie *port, u32 addr,
 				  u32 flags, u64 size)
 {
 	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
@@ -307,7 +307,7 @@ static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
 	return mask;
 }
 
-static void xgene_pcie_linkup(struct xgene_pcie_port *port,
+static void xgene_pcie_linkup(struct xgene_pcie *port,
 			      u32 *lanes, u32 *speed)
 {
 	u32 val32;
@@ -322,7 +322,7 @@ static void xgene_pcie_linkup(struct xgene_pcie_port *port,
 	}
 }
 
-static int xgene_pcie_init_port(struct xgene_pcie_port *port)
+static int xgene_pcie_init_port(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
 	int rc;
@@ -342,7 +342,7 @@ static int xgene_pcie_init_port(struct xgene_pcie_port *port)
 	return 0;
 }
 
-static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
+static int xgene_pcie_map_reg(struct xgene_pcie *port,
 			      struct platform_device *pdev)
 {
 	struct device *dev = port->dev;
@@ -362,7 +362,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ob_reg(struct xgene_pcie *port,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
@@ -394,7 +394,7 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
 	xgene_pcie_writel(port, offset + 0x14, upper_32_bits(pci_addr));
 }
 
-static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
+static void xgene_pcie_setup_cfg_reg(struct xgene_pcie *port)
 {
 	u64 addr = port->cfg_addr;
 
@@ -403,7 +403,7 @@ static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
 	xgene_pcie_writel(port, CFGCTL, EN_REG);
 }
 
-static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_map_ranges(struct xgene_pcie *port)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *window;
@@ -444,7 +444,7 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port)
 	return 0;
 }
 
-static void xgene_pcie_setup_pims(struct xgene_pcie_port *port, u32 pim_reg,
+static void xgene_pcie_setup_pims(struct xgene_pcie *port, u32 pim_reg,
 				  u64 pim, u64 size)
 {
 	xgene_pcie_writel(port, pim_reg, lower_32_bits(pim));
@@ -478,7 +478,7 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 	return -EINVAL;
 }
 
-static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
+static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
 				    struct resource_entry *entry,
 				    u8 *ib_reg_mask)
 {
@@ -529,7 +529,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
 }
 
-static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
+static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
 	struct resource_entry *entry;
@@ -542,7 +542,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 }
 
 /* clear BAR configuration which was done by firmware */
-static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
+static void xgene_pcie_clear_config(struct xgene_pcie *port)
 {
 	int i;
 
@@ -550,7 +550,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
 		xgene_pcie_writel(port, i, 0);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie_port *port)
+static int xgene_pcie_setup(struct xgene_pcie *port)
 {
 	struct device *dev = port->dev;
 	u32 val, lanes = 0, speed = 0;
@@ -588,7 +588,7 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
-	struct xgene_pcie_port *port;
+	struct xgene_pcie *port;
 	struct pci_host_bridge *bridge;
 	int ret;
 
-- 
2.25.1

