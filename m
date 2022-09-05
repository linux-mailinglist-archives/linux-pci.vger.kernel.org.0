Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFC5AD997
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiIETZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiIETZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28001D31A;
        Mon,  5 Sep 2022 12:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AAC76130A;
        Mon,  5 Sep 2022 19:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D17AC433D6;
        Mon,  5 Sep 2022 19:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405917;
        bh=SXwJBeHNvftKq6M7GE7LYhPnEKUJ1AN/65rM+2MAXfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7wL2NabC/FAYEcXLM1B+pgI+y4/G87OSlPn1LeDkV/FJNjA7IWN4VkbmiZW6/IzO
         4LfaMfubGzhBe9FeB8lBQ2vrxN5+ZUbG0Bx09jlfXQRNjwRUfmzbVVA5MBeUvAiIxs
         q3pYe4QPdLD4HUK2eKf3dtLI4XL+sXTNcCwtf5hGTZHAm4yRNMcpLLwgyF+EbVQh9C
         rHR4qAlGe8dVa8cJmgIw0tp/g/hszQzkhy7bk5SHfo8OdF9VRqIemFCMQ8Lq1Gokol
         Z2GtP1mf3BbYaM27jUtlGubcgkeovErPHmEsvjRbbA3h+Vjb11hufAYcAg7ZS0spW/
         1YnoYXN0jQPtg==
Received: by pali.im (Postfix)
        id EA6917D7; Mon,  5 Sep 2022 21:25:16 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/7] PCI: mvebu: Add support for Orion PCIe controller
Date:   Mon,  5 Sep 2022 21:23:09 +0200
Message-Id: <20220905192310.22786-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Orion PCIe controller has same register sets, same APIs, same functionality
and also same bugs related to PCIe Root Ports as new PCIe controllers from
Marvell found on Kirkwood, Dove or Armada products. So pci-mvebu.c should
work fine with Orion PCIe controllers too.

But Orion PCIe controller has additional bug - broken Marvell CF8/CFC
registers which are used for config space access. This hardware bug is
documented in Marvell Orion Functional Errata, linked from kernel docs
https://www.kernel.org/doc/html/latest/arm/marvell.html. Document contains
also official workaround, but that workaround does not work when CPU or
other side of PCIe link is doing PCIe TLP operations. Because of race
conditions that official workaround is unusable for kernel, any other
multi-threaded systems and any PCIe card with bus mastering support.

Instead Linux kernel for a long time implements different undocumented
workaround (which does not have this issue) via platform code found in
arch/arm/mach-orion5x/pci.c and arch/arm/plat-orion/pcie.c files. It maps
PCIe config space directly into CPU physical address space via Marvell mbus
driver and then kernel access directly mapped physical address of config
space. The only disadvantage of this workaround is that it required
additional 16 MB of physical address space and only standard PCI config
space registers are accessible.

Testing proved that via mbus the physical size can be of this special
address range increased to 256 MB and then whole PCIe config space,
including PCIe registers, is accessible. So the only disadvantage is
requirement of free 256 MB in physical address space.

So for Orion support in pci-mvebu.c driver, this change reimplements
arch-specific mapping of config space with existing mbus driver and
kernel function pci_remap_cfgspace() which simplify physical space
mappings. Therefore pci-mvebu.c driver does not have to relay on static
virtual MMU mappings like old arch-specific code.

Like with any address ranges settings and configurations, this Orion code
reads physical config space address range from device tree files. There are
no fixed settings in the pci-mvebu.c driver as opposite of the old
arch-specific implementation. It is up to the board or platform dts file to
define how PCIe config space could be mapped into physical CPU address
space.

mbus specific target and attribute numbers, required for mbus mappings of
config space registers are also read from device tree files, in exactly
same format as are read for PCIe MEM and PCIe IO space mappings.

During probing of Orion PCIe controller, pci-mvebu.c driver ask kernel mbus
driver to map config space into CPU physical address range (based on DTS
offset and size). Config space stays mapped in physical address range while
PCIe controller is bind to driver.

Note that layout of PCIe config space is not standard PCIe ECAM. It is same
as layout accessed indirectly via CF8/CFC registers used in other Armada
PCIe controllers. Support for extended PCIe registers in this layout is
non-standard and hence it is Marvell specific layout.

The main issue with this layout is that config space of PCIe bus in not
coherent in address range. And neither address range of one PCIe device is
coherent. Therefore it is not possible to use PCI core .map_bus callback
for implementing access into config space. And because Orion is 32-bit
platform it is not a wise idea to map whole 256 MB PCIe config space into
CPU virtual address space permanently.

So because layout of config space via direct or indirect method is same,
functions mvebu_pcie_child_rd_conf() and mvebu_pcie_child_wd_conf() are
slightly modified to support also direct config space access method.
Functions calculates where in physical address range is requested config
space register and do virtual mapping at request time. After register
access it is unmapped from virtual address range.

Links: https://www.kernel.org/doc/html/latest/arm/marvell.html
Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* Completely rewritten
* Implement full support for accessing PCIe config space based on device
  tree details without any harcoded address in pci-mvebu.c driver
---
 drivers/pci/controller/Kconfig     |   4 +-
 drivers/pci/controller/pci-mvebu.c | 142 +++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8da2efdc5177..ae5a430387bc 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -5,7 +5,7 @@ menu "PCI controller drivers"
 
 config PCI_MVEBU
 	tristate "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
+	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_ORION5X || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
 	depends on OF
@@ -15,7 +15,7 @@ config PCI_MVEBU
 	select HOTPLUG_PCI_PCIE
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller
-	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
+	 is used on 32-bit Marvell ARM SoCs: Orion, Kirkwood, Dove, Armada 370,
 	 Armada XP, Armada 375, Armada 38x and Armada 39x.
 
 config PCI_AARDVARK
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 9986dd486680..2ef04a8241fc 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -96,6 +96,7 @@ struct mvebu_pcie {
 	struct resource io;
 	struct resource realio;
 	struct resource mem;
+	struct resource cfg;
 	int nports;
 };
 
@@ -127,6 +128,7 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
 	struct resource regs;
+	struct resource cfg;
 	u8 slot_power_limit_value;
 	u8 slot_power_limit_scale;
 	struct irq_domain *rp_irq_domain;
@@ -409,6 +411,7 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
 	void __iomem *conf_data;
+	u32 offset;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port)
@@ -417,10 +420,20 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	conf_data = port->base + PCIE_CONF_DATA_OFF;
+	if (resource_size(&port->cfg)) {
+		offset = PCIE_CONF_ADDR(bus->number, devfn, where) & ~PCIE_CONF_ADDR_EN;
+		if (offset >= resource_size(&port->cfg))
+			return PCIBIOS_DEVICE_NOT_FOUND;
 
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
+		conf_data = pci_remap_cfgspace(port->cfg.start + offset, size);
+		if (!conf_data)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	} else {
+		conf_data = port->base + PCIE_CONF_DATA_OFF;
+
+		mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+			     PCIE_CONF_ADDR_OFF);
+	}
 
 	switch (size) {
 	case 1:
@@ -433,9 +446,14 @@ static int mvebu_pcie_child_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		*val = readl_relaxed(conf_data);
 		break;
 	default:
+		if (resource_size(&port->cfg))
+			iounmap(conf_data);
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
+	if (resource_size(&port->cfg))
+		iounmap(conf_data);
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -445,6 +463,7 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
 	struct mvebu_pcie *pcie = bus->sysdata;
 	struct mvebu_pcie_port *port;
 	void __iomem *conf_data;
+	u32 offset;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
 	if (!port)
@@ -453,10 +472,20 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	conf_data = port->base + PCIE_CONF_DATA_OFF;
+	if (resource_size(&port->cfg)) {
+		offset = PCIE_CONF_ADDR(bus->number, devfn, where) & ~PCIE_CONF_ADDR_EN;
+		if (offset >= resource_size(&port->cfg))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		conf_data = pci_remap_cfgspace(port->cfg.start + offset, size);
+		if (!conf_data)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+	} else {
+		conf_data = port->base + PCIE_CONF_DATA_OFF;
 
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
+		mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+			     PCIE_CONF_ADDR_OFF);
+	}
 
 	switch (size) {
 	case 1:
@@ -469,9 +498,14 @@ static int mvebu_pcie_child_wr_conf(struct pci_bus *bus, u32 devfn,
 		writel(val, conf_data);
 		break;
 	default:
+		if (resource_size(&port->cfg))
+			iounmap(conf_data);
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
+	if (resource_size(&port->cfg))
+		iounmap(conf_data);
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -1472,6 +1506,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 
 static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 			      unsigned long type,
+			      unsigned long offset,
 			      unsigned int *tgt,
 			      unsigned int *attr)
 {
@@ -1493,6 +1528,7 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 	for (i = 0; i < nranges; i++, range += rangesz) {
 		u32 flags = of_read_number(range, 1);
 		u32 slot = of_read_number(range + 1, 1);
+		u32 dtaddr = of_read_number(range + 2, 1);
 		u64 cpuaddr = of_read_number(range + na, pna);
 		unsigned long rtype;
 
@@ -1503,6 +1539,9 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 		else
 			continue;
 
+		if (dtaddr != offset)
+			continue;
+
 		if (slot == PCI_SLOT(devfn) && type == rtype) {
 			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
 			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
@@ -1513,6 +1552,43 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 	return -ENOENT;
 }
 
+static int mvebu_get_cfg_tgt_attr(struct device_node *np, phys_addr_t start,
+				  struct resource *res,
+				  unsigned int *tgt, unsigned int *attr)
+{
+	const __be32 *addrp;
+	unsigned int flags;
+	u64 offset;
+	u64 size;
+	int ret;
+
+	/* get second cell from assigned-addresses property */
+	addrp = of_get_address(np, 1, &size, &flags);
+	if (!addrp)
+		return -EINVAL;
+
+	if (!(flags & IORESOURCE_MEM))
+		return -EINVAL;
+
+	if (be32_to_cpu(addrp[1]) != 0x0)
+		return -EINVAL;
+
+	flags |= IORESOURCE_MEM_NONPOSTED;
+	offset = be32_to_cpu(addrp[2]);
+
+	ret = mvebu_get_tgt_attr(of_get_parent(np), 0, IORESOURCE_MEM, offset, tgt, attr);
+	if (ret)
+		return ret;
+
+	memset(res, 0, sizeof(*res));
+	res->start = start;
+	res->end = start + size - 1;
+	res->flags = flags;
+	res->name = "PCI CFG";
+
+	return 0;
+}
+
 static int mvebu_pcie_suspend(struct device *dev)
 {
 	struct mvebu_pcie *pcie;
@@ -1592,7 +1668,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 		goto skip;
 	}
 
-	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM,
+	ret = mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_MEM, 0,
 				 &port->mem_target, &port->mem_attr);
 	if (ret < 0) {
 		dev_err(dev, "%s: cannot get tgt/attr for mem window\n",
@@ -1601,7 +1677,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	}
 
 	if (resource_size(&pcie->io) != 0) {
-		mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_IO,
+		mvebu_get_tgt_attr(dev->of_node, port->devfn, IORESOURCE_IO, 0,
 				   &port->io_target, &port->io_attr);
 	} else {
 		port->io_target = -1;
@@ -1794,6 +1870,20 @@ static int mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
 			return ret;
 	}
 
+	if (of_device_is_compatible(dev->of_node, "marvell,orion5x-pcie")) {
+		/* Get the PCIe configuration space aperture */
+		mvebu_mbus_get_pcie_cfg_aperture(&pcie->cfg);
+		if (resource_size(&pcie->cfg) == 0) {
+			dev_err(dev, "invalid config space aperature size\n");
+			return -EINVAL;
+		}
+
+		pcie->cfg.name = "PCI CFG";
+		ret = devm_request_resource(dev, &iomem_resource, &pcie->cfg);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -1804,6 +1894,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct device_node *np = dev->of_node;
 	struct device_node *child;
+	phys_addr_t pcie_cfg_offset;
 	int num, i, ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
@@ -1818,6 +1909,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pcie_cfg_offset = pcie->cfg.start;
+
 	num = of_get_available_child_count(np);
 
 	pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
@@ -1852,6 +1945,32 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			continue;
 
+		if (resource_size(&pcie->cfg) != 0) {
+			unsigned int cfg_target, cfg_attr;
+
+			ret = mvebu_get_cfg_tgt_attr(child, pcie_cfg_offset, &port->cfg, &cfg_target, &cfg_attr);
+			if (ret) {
+				dev_err(dev, "%s: missing address range for cfg space\n", port->name);
+				goto err_port_down;
+			}
+
+			if (port->cfg.end > pcie->cfg.end) {
+				dev_err(dev, "%s: requested cfg space of %u bytes is too large, available only %u bytes\n",
+					port->name, resource_size(&port->cfg), pcie->cfg.end - pcie_cfg_offset + 1);
+				port->cfg.start = port->cfg.end = 0;
+				goto err_port_down;
+			}
+
+			ret = mvebu_mbus_add_window_by_id(cfg_target, cfg_attr, port->cfg.start, resource_size(&port->cfg));
+			if (ret) {
+				dev_info(dev, "%s: cannot add mbus window for cfg space: %d\n", port->name, ret);
+				port->cfg.start = port->cfg.end = 0;
+				goto err_port_down;
+			}
+
+			pcie_cfg_offset += resource_size(&port->cfg);
+		}
+
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
 		if (IS_ERR(port->base)) {
 			dev_err(dev, "%s: cannot map registers\n", port->name);
@@ -2011,6 +2130,9 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		port->base = NULL;
 
 err_port_down:
+		if (port->cfg.end && resource_size(&port->cfg))
+			mvebu_mbus_del_window(port->cfg.start, resource_size(&port->cfg));
+
 		mvebu_pcie_powerdown(port);
 	}
 
@@ -2090,6 +2212,9 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		if (port->memwin.size)
 			mvebu_pcie_del_windows(port, port->memwin.base, port->memwin.size);
 
+		if (port->cfg.end && resource_size(&port->cfg))
+			mvebu_mbus_del_window(port->cfg.start, resource_size(&port->cfg));
+
 		/* Power down card and disable clocks. Must be the last step. */
 		mvebu_pcie_powerdown(port);
 	}
@@ -2102,6 +2227,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-370-pcie", },
 	{ .compatible = "marvell,dove-pcie", },
 	{ .compatible = "marvell,kirkwood-pcie", },
+	{ .compatible = "marvell,orion5x-pcie", },
 	{},
 };
 
-- 
2.20.1

