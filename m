Return-Path: <linux-pci+bounces-23868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573FAA632AE
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6AE1893BCA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F913197A7A;
	Sat, 15 Mar 2025 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQwsKKUP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC018B0F;
	Sat, 15 Mar 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742077894; cv=none; b=fa1+nrFSM3q+Vw0OVT3XA90QvKD4qI46UrPQ0slFLFS2ENjIGvYxOXH6OOfYCLCxFUr+QCp4SWRGNBtKOgmsRLDZPunlurYAz2zgHsr91SC8lR6q0EN28wmDYvcwm6pzMUPGBFRjW2uKS31ojNZXk19HR25n+w1RADX9BqRbCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742077894; c=relaxed/simple;
	bh=zNewV1rOkgFgsTpNdZlod87IIN04l7hTXMKh7JGDgFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dRz8duuNQoDAgkjazqfCzScVJXajjYw2VSToboCIwQl1h6mIgIxifvEVp4wpTMxv6NvBYp/nI281mnuRsURn8b0JkbyJM6tk10rIclIokud13mvdAQl/MJEvLgDNdmgbQTiO9TtNDn/YkftCY1aoXhkmhge/zmbyMTHAOxA8LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQwsKKUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E48C4CEE5;
	Sat, 15 Mar 2025 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742077893;
	bh=zNewV1rOkgFgsTpNdZlod87IIN04l7hTXMKh7JGDgFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CQwsKKUPITu/iaqKQBRRCczQ8NWd2IoWHOJmZYbolnXEcKFogY4gjkLx4xaKP83nb
	 7KCjGr3JEHSkcsnOv5wcJtVDqDxJfV5+CrKdhRBncGTGcdMMZFDth8hzFD9GAUGH9y
	 ff9OcuP+fudLADFjV5UbIK7GJTbgWi3Lk7PL/KXhStXaXzwk0HN5zY9Phw6fwfBqln
	 wadQE/u0MR6zCMf89CUwFAseDIvM5N9kw+FveQWf2l2aeE/JxR1kusU8QG6+PewDsm
	 D9Q7ZzQY+ZpwT5keKKsx8wZSJMHc4goALThzUEwWHiIUucn4ilbeNLcb3bggU26frd
	 R3vdj8JZzojWA==
Date: Sat, 15 Mar 2025 17:31:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 00/13] PCI: Use device bus range info to cleanup RC
 Host/EP pci_fixup_addr()
Message-ID: <20250315223131.GA866374@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:35PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a v12 based on Frank's v11 series.
> 
> v11 https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com
>     
> Changes from v11:
>   - Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init(), before
>     any devicetree-related code
>   - Call devm_pci_epc_create() early in dw_pcie_ep_init(), before any
>     devicetree-related code
>   - Consolidate devicetree-related code in dw_pcie_host_get_resources() and
>     dw_pcie_ep_get_resources()
>   - Integrate dw_pcie_cfg0_setup() into dw_pcie_host_get_resources()
>   - Convert dw_pcie_init_parent_bus_offset() to dw_pcie_parent_bus_offset()
>     which returns the offset rather than setting it internally
>   - Split the debug comparison of devicetree info with .cpu_addr_fixup() to
>     separate patch so we can easily revert it later
>   - Drop "cpu_addr_fixup() usage detected" warning since we always warn
>     about something in that case anyway

FWIW, here's the diff from v11 to v12:

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index e333855633a7..c1feaadb046a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -884,26 +884,15 @@ void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
 
-/**
- * dw_pcie_ep_init - Initialize the endpoint device
- * @ep: DWC EP device
- *
- * Initialize the endpoint device. Allocate resources and create the EPC
- * device with the endpoint framework.
- *
- * Return: 0 if success, errno otherwise.
- */
-int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+static int dw_pcie_ep_get_resources(struct dw_pcie_ep *ep)
 {
-	int ret;
-	struct resource *res;
-	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-
-	INIT_LIST_HEAD(&ep->func_list);
+	struct pci_epc *epc = ep->epc;
+	struct resource *res;
+	int ret;
 
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
@@ -917,15 +906,36 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->addr_size = resource_size(res);
 
 	/*
-	 * artpec6_pcie_cpu_addr_fixup() use ep->phys_base. so call
-	 * dw_pcie_init_parent_bus_offset after init ep->phys_base.
+	 * artpec6_pcie_cpu_addr_fixup() uses ep->phys_base, so call
+	 * dw_pcie_parent_bus_offset() after setting ep->phys_base.
 	 */
-	ret = dw_pcie_init_parent_bus_offset(pci, "addr_space", ep->phys_base);
-	if (ret)
-		return ret;
+	pci->parent_bus_offset = dw_pcie_parent_bus_offset(pci, "addr_space",
+							   ep->phys_base);
 
-	if (ep->ops->pre_init)
-		ep->ops->pre_init(ep);
+	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
+	if (ret < 0)
+		epc->max_functions = 1;
+
+	return 0;
+}
+
+/**
+ * dw_pcie_ep_init - Initialize the endpoint device
+ * @ep: DWC EP device
+ *
+ * Initialize the endpoint device. Allocate resources and create the EPC
+ * device with the endpoint framework.
+ *
+ * Return: 0 if success, errno otherwise.
+ */
+int dw_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	int ret;
+	struct pci_epc *epc;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
+
+	INIT_LIST_HEAD(&ep->func_list);
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
@@ -936,9 +946,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->epc = epc;
 	epc_set_drvdata(epc, ep);
 
-	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
-	if (ret < 0)
-		epc->max_functions = 1;
+	ret = dw_pcie_ep_get_resources(ep);
+	if (ret)
+		return ret;
+
+	if (ep->ops->pre_init)
+		ep->ops->pre_init(ep);
 
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e7df3d2ac26..d760abcbb785 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -392,29 +392,6 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static int dw_pcie_cfg0_setup(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (!res) {
-		dev_err(dev, "Missing \"config\" reg space\n");
-		return -ENODEV;
-	}
-
-	pp->cfg0_size = resource_size(res);
-	pp->cfg0_base = res->start;
-
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
-
-	return 0;
-}
-
 static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -441,33 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
-int dw_pcie_host_init(struct dw_pcie_rp *pp)
+static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
-	struct pci_host_bridge *bridge;
+	struct resource *res;
 	int ret;
 
-	raw_spin_lock_init(&pp->lock);
-
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return bridge;
-
-	pp->bridge = bridge;
-
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_cfg0_setup(pp);
-	if (ret)
-		return ret;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!res) {
+		dev_err(dev, "Missing \"config\" reg space\n");
+		return -ENODEV;
+	}
+
+	pp->cfg0_size = resource_size(res);
+	pp->cfg0_base = res->start;
+
+	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pp->va_cfg0_base))
+		return PTR_ERR(pp->va_cfg0_base);
 
 	/* Get the I/O range from DT */
-	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
+	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
 	if (win) {
 		pp->io_size = resource_size(win->res);
 		pp->io_bus_addr = win->res->start - win->offset;
@@ -475,11 +453,31 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	/*
-	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
-	 * so have to call dw_pcie_init_parent_bus_offset() after init
-	 * pp->io_base.
+	 * visconti_pcie_cpu_addr_fixup() uses pp->io_base, so we have to
+	 * call dw_pcie_parent_bus_offset() after setting pp->io_base.
 	 */
-	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
+	pci->parent_bus_offset = dw_pcie_parent_bus_offset(pci, "config",
+							   pp->cfg0_base);
+	return 0;
+}
+
+int dw_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	raw_spin_lock_init(&pp->lock);
+
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
+
+	pp->bridge = bridge;
+
+	ret = dw_pcie_host_get_resources(pp);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d4dc8bf06d4c..d9d2090f380c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1104,51 +1104,48 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
 
-int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
-				   resource_size_t cpu_phy_addr)
+resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
+					  const char *reg_name,
+					  resource_size_t cpu_phy_addr)
 {
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
-	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
-	u64 reg_addr, fixup_addr;
 	int index;
+	u64 reg_addr, fixup_addr;
+	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
 
 	/* Look up reg_name address on parent bus */
 	index = of_property_match_string(np, "reg-names", reg_name);
 
 	if (index < 0) {
-		dev_err(dev, "Missed reg-name: %s, Broken DTB file\n", reg_name);
-		return -EINVAL;
+		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
+		return 0;
 	}
 
 	of_property_read_reg(np, index, &reg_addr, NULL);
 
 	fixup = pci->ops->cpu_addr_fixup;
 	if (fixup) {
-		dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");
-
 		fixup_addr = fixup(pci, cpu_phy_addr);
 		if (reg_addr == fixup_addr) {
 			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
 				 cpu_phy_addr, reg_name, index,
 				 fixup_addr, fixup);
 		} else {
-			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; DT is broken\n",
+			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
 				 cpu_phy_addr, reg_name,
 				 index, fixup_addr);
 			reg_addr = fixup_addr;
 		}
 	} else if (!pci->use_parent_dt_ranges) {
 		if (reg_addr != cpu_phy_addr) {
-			dev_warn(dev, "Your DTB try to use fake translation, Please check parent's ranges property. cpu physical addr: %#010llx, parent bus addr: %#010llx",
+			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
 				 cpu_phy_addr, reg_addr);
 			return 0;
 		}
 	}
 
-	pci->parent_bus_offset = cpu_phy_addr - reg_addr;
 	dev_info(dev, "%s parent bus offset is %#010llx\n",
-		 reg_name, pci->parent_bus_offset);
-
-	return 0;
+		 reg_name, cpu_phy_addr - reg_addr);
+	return cpu_phy_addr - reg_addr;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index bfed9d45aba9..741c46926ce2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -466,13 +466,17 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+
 	/*
-	 * This flag indicates that the vendor driver uses devicetree 'ranges'
-	 * property to allow iATU to use the Intermediate Address (IA) for
-	 * outbound mapping.
+	 * If iATU input addresses are offset from CPU physical addresses,
+	 * we previously required .cpu_addr_fixup() to convert them.  We
+	 * now rely on the devicetree instead.  If .cpu_addr_fixup()
+	 * exists, we compare its results with devicetree.
 	 *
-	 * If use_parent_dt_ranges is false, warning will print if IA is not
-	 * equal to cpu physical address. Indicate dtb use a fake translation.
+	 * If .cpu_addr_fixup() does not exist, we assume the offset is
+	 * zero and warn if devicetree claims otherwise.  If we know all
+	 * devicetrees correctly describe the offset, set
+	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
 };
@@ -510,8 +514,9 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
-int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
-				   resource_size_t cpu_phy_addr);
+resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
+					  const char *reg_name,
+					  resource_size_t cpu_phy_addr);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {

