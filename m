Return-Path: <linux-pci+bounces-15815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C0E9B98FE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3225B21CFF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976451D1E74;
	Fri,  1 Nov 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNdSfh4C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7A1CACF2;
	Fri,  1 Nov 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490691; cv=none; b=PFi/vSWIUEKpML3aR5LQBxTeRVAXS56IH4oBO4sdr4DCygsrHt/WAByu5RhU2R7KTNNeMZmVnC080UxeTGbxPggJik1v3rnY4TdKLKLLjdE1G/NAtUSy98JFFv0AablELRK8Y+wG5R/SUytbKZVn42AJEBubiqrbU4LChrnUuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490691; c=relaxed/simple;
	bh=OT/t9K2xq7Es9qQAio9bNa7j/kTDs0LY2tM4nZClC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QJRn+5UvpHpNVJpF7djqXUb4EIc6BT2aJbR9jg0T+4+ld7mTBAzUAbVbzjRHz/Dz+HdqxxNT6LZlc9knEiSFmdNmlxlG0plvPJDD1QUzhZm5SEnq7/i7ap9NWD7qzGXwbqV8i/NQu54qBL4WV/uhgUtfJ/lAyO+UZm4xnWCmyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNdSfh4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7949C4CECD;
	Fri,  1 Nov 2024 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490691;
	bh=OT/t9K2xq7Es9qQAio9bNa7j/kTDs0LY2tM4nZClC5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BNdSfh4CjGIlBqyhVYDawbxl7pDUsTPDDc43sq8h1E0UkHJOoDviqK1A0iL34M6oX
	 ReGj655bTTyxE2UEMBcCE1YSs0VJJpzlz3RvANfaSZHWLxueSdKFCN6FZ4+24fvPHd
	 Fp+Te5+0RIgoZsDRa1JSyfqDBSKdkQxRwloZaaofhJtQLhqdRZH77MHYB+fxSpkGwL
	 HeVfNQ+drbSgbZJ1hoydfpvrxXTHU+S8IjEbWBPqFnXcDGuoSmVmktbFP9oRdvTYEx
	 3ge2LELG4KpWyfUhXgcXMrX7cfEI0Ci4qbWFEv/m8AjbmK4P28oMtmJxac+7Xc7OWJ
	 ExlFM7F6OaS6w==
Date: Fri, 1 Nov 2024 14:51:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/2] PCI: microchip: rework reg region handing to
 support using either instance 1 or 2
Message-ID: <20241101195129.GA1318063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-outmost-untainted-cedd4adcd551@spud>

On Wed, Aug 14, 2024 at 09:08:42AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The PCI host controller on PolarFire SoC has multiple "instances", each
> with their own bridge and ctrl address spaces. The original binding has
> an "apb" register region, and it is expected to be set to the base
> address of the host controllers register space. Defines in the driver
> were used to compute the addresses of the bridge and ctrl address ranges
> corresponding to instance1. Some customers want to use instance0 however
> and that requires changing the defines in the driver, which is clearly
> not a portable solution.

The subject mentions "instance 1 or 2".

This paragraph implies adding support for "instance0" ("customers want
to use instance0").

The DT patch suggests that we're adding support for "instance2"
("customers want to use instance2").

Both patches suggest that the existing support is for "instance 1".

Maybe what's being added is "instance 2", and this commit log should
s/instance0/instance 2/ ?  And probably s/instance1/instance 1/ so the
style is consistent?

Is this a "pick one or the other but not both" situation, or does this
device support two independent PCIe controllers?

I first thought this driver supported a single PCIe controller, and
you were adding support for a second independent controller.

But the fact that you say "the [singular] host controller on
PolarFire", and you're not changing mc_host_probe() to call
pci_host_common_probe() more than once makes me think there is only a
single PCIe controller, and for some reason you can choose to operate
it using either register set 1 or register set 2.

> The binding has been changed from a single register region to a pair,
> corresponding to the bridge and ctrl regions respectively, so modify the
> driver to read these regions directly from the devicetree rather than
> compute them from the base address of the abp region.
> 
> To maintain backwards compatibility with the existing binding, the
> driver retains code to handle the "abp" reg and computes the base
> address of the bridge and ctrl regions using the defines if it is
> present. reg-names has always been a required property, so this is
> safe to do.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Dropped Daire's Ack due to substantial rebasing.
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 116 +++++++++---------
>  1 file changed, 61 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 48f60a04b740..57f35290c83b 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -25,9 +25,6 @@
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
>  #define MC_PCIE1_CTRL_ADDR			0x0000a000u
>  
> -#define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
> -#define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
> -
>  /* PCIe Controller Phy Regs */
>  #define SEC_ERROR_EVENT_CNT			0x20
>  #define DED_ERROR_EVENT_CNT			0x24
> @@ -128,7 +125,6 @@
>  	[EVENT_LOCAL_ ## x] = { __stringify(x), s }
>  
>  #define PCIE_EVENT(x) \
> -	.base = MC_PCIE_CTRL_ADDR, \
>  	.offset = PCIE_EVENT_INT, \
>  	.mask_offset = PCIE_EVENT_INT, \
>  	.mask_high = 1, \
> @@ -136,7 +132,6 @@
>  	.enb_mask = PCIE_EVENT_INT_ENB_MASK
>  
>  #define SEC_EVENT(x) \
> -	.base = MC_PCIE_CTRL_ADDR, \
>  	.offset = SEC_ERROR_INT, \
>  	.mask_offset = SEC_ERROR_INT_MASK, \
>  	.mask = SEC_ERROR_INT_ ## x ## _INT, \
> @@ -144,7 +139,6 @@
>  	.enb_mask = 0
>  
>  #define DED_EVENT(x) \
> -	.base = MC_PCIE_CTRL_ADDR, \
>  	.offset = DED_ERROR_INT, \
>  	.mask_offset = DED_ERROR_INT_MASK, \
>  	.mask_high = 1, \
> @@ -152,7 +146,6 @@
>  	.enb_mask = 0
>  
>  #define LOCAL_EVENT(x) \
> -	.base = MC_PCIE_BRIDGE_ADDR, \
>  	.offset = ISTATUS_LOCAL, \
>  	.mask_offset = IMASK_LOCAL, \
>  	.mask_high = 0, \
> @@ -179,7 +172,8 @@ struct event_map {
>  
>  struct mc_pcie {
>  	struct plda_pcie_rp plda;
> -	void __iomem *axi_base_addr;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
>  };
>  
>  struct cause {
> @@ -253,7 +247,6 @@ static struct event_map local_status_to_event[] = {
>  };
>  
>  static struct {
> -	u32 base;
>  	u32 offset;
>  	u32 mask;
>  	u32 shift;
> @@ -325,8 +318,7 @@ static inline u32 reg_to_event(u32 reg, struct event_map field)
>  
>  static u32 pcie_events(struct mc_pcie *port)
>  {
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> -	u32 reg = readl_relaxed(ctrl_base_addr + PCIE_EVENT_INT);
> +	u32 reg = readl_relaxed(port->ctrl_base_addr + PCIE_EVENT_INT);
>  	u32 val = 0;
>  	int i;
>  
> @@ -338,8 +330,7 @@ static u32 pcie_events(struct mc_pcie *port)
>  
>  static u32 sec_errors(struct mc_pcie *port)
>  {
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> -	u32 reg = readl_relaxed(ctrl_base_addr + SEC_ERROR_INT);
> +	u32 reg = readl_relaxed(port->ctrl_base_addr + SEC_ERROR_INT);
>  	u32 val = 0;
>  	int i;
>  
> @@ -351,8 +342,7 @@ static u32 sec_errors(struct mc_pcie *port)
>  
>  static u32 ded_errors(struct mc_pcie *port)
>  {
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> -	u32 reg = readl_relaxed(ctrl_base_addr + DED_ERROR_INT);
> +	u32 reg = readl_relaxed(port->ctrl_base_addr + DED_ERROR_INT);
>  	u32 val = 0;
>  	int i;
>  
> @@ -364,8 +354,7 @@ static u32 ded_errors(struct mc_pcie *port)
>  
>  static u32 local_events(struct mc_pcie *port)
>  {
> -	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> -	u32 reg = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> +	u32 reg = readl_relaxed(port->bridge_base_addr + ISTATUS_LOCAL);
>  	u32 val = 0;
>  	int i;
>  
> @@ -412,8 +401,12 @@ static void mc_ack_event_irq(struct irq_data *data)
>  	void __iomem *addr;
>  	u32 mask;
>  
> -	addr = mc_port->axi_base_addr + event_descs[event].base +
> -		event_descs[event].offset;
> +	if (event_descs[event].offset == ISTATUS_LOCAL)
> +		addr = mc_port->bridge_base_addr;
> +	else
> +		addr = mc_port->ctrl_base_addr;
> +
> +	addr += event_descs[event].offset;
>  	mask = event_descs[event].mask;
>  	mask |= event_descs[event].enb_mask;
>  
> @@ -429,8 +422,12 @@ static void mc_mask_event_irq(struct irq_data *data)
>  	u32 mask;
>  	u32 val;
>  
> -	addr = mc_port->axi_base_addr + event_descs[event].base +
> -		event_descs[event].mask_offset;
> +	if (event_descs[event].offset == ISTATUS_LOCAL)
> +		addr = mc_port->bridge_base_addr;
> +	else
> +		addr = mc_port->ctrl_base_addr;
> +
> +	addr += event_descs[event].mask_offset;
>  	mask = event_descs[event].mask;
>  	if (event_descs[event].enb_mask) {
>  		mask <<= PCIE_EVENT_INT_ENB_SHIFT;
> @@ -460,8 +457,12 @@ static void mc_unmask_event_irq(struct irq_data *data)
>  	u32 mask;
>  	u32 val;
>  
> -	addr = mc_port->axi_base_addr + event_descs[event].base +
> -		event_descs[event].mask_offset;
> +	if (event_descs[event].offset == ISTATUS_LOCAL)
> +		addr = mc_port->bridge_base_addr;
> +	else
> +		addr = mc_port->ctrl_base_addr;
> +
> +	addr += event_descs[event].mask_offset;
>  	mask = event_descs[event].mask;
>  
>  	if (event_descs[event].enb_mask)
> @@ -554,26 +555,20 @@ static const struct plda_event mc_event = {
>  
>  static inline void mc_clear_secs(struct mc_pcie *port)
>  {
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> -
> -	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, ctrl_base_addr +
> +	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, port->ctrl_base_addr +
>  		       SEC_ERROR_INT);
> -	writel_relaxed(0, ctrl_base_addr + SEC_ERROR_EVENT_CNT);
> +	writel_relaxed(0, port->ctrl_base_addr + SEC_ERROR_EVENT_CNT);
>  }
>  
>  static inline void mc_clear_deds(struct mc_pcie *port)
>  {
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
> -
> -	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, ctrl_base_addr +
> +	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, port->ctrl_base_addr +
>  		       DED_ERROR_INT);
> -	writel_relaxed(0, ctrl_base_addr + DED_ERROR_EVENT_CNT);
> +	writel_relaxed(0, port->ctrl_base_addr + DED_ERROR_EVENT_CNT);
>  }
>  
>  static void mc_disable_interrupts(struct mc_pcie *port)
>  {
> -	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> -	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
>  	u32 val;
>  
>  	/* Ensure ECC bypass is enabled */
> @@ -581,22 +576,22 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>  	      ECC_CONTROL_RX_RAM_ECC_BYPASS |
>  	      ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS |
>  	      ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS;
> -	writel_relaxed(val, ctrl_base_addr + ECC_CONTROL);
> +	writel_relaxed(val, port->ctrl_base_addr + ECC_CONTROL);
>  
>  	/* Disable SEC errors and clear any outstanding */
> -	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, ctrl_base_addr +
> +	writel_relaxed(SEC_ERROR_INT_ALL_RAM_SEC_ERR_INT, port->ctrl_base_addr +
>  		       SEC_ERROR_INT_MASK);
>  	mc_clear_secs(port);
>  
>  	/* Disable DED errors and clear any outstanding */
> -	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, ctrl_base_addr +
> +	writel_relaxed(DED_ERROR_INT_ALL_RAM_DED_ERR_INT, port->ctrl_base_addr +
>  		       DED_ERROR_INT_MASK);
>  	mc_clear_deds(port);
>  
>  	/* Disable local interrupts and clear any outstanding */
> -	writel_relaxed(0, bridge_base_addr + IMASK_LOCAL);
> -	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_LOCAL);
> -	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_MSI);
> +	writel_relaxed(0, port->bridge_base_addr + IMASK_LOCAL);
> +	writel_relaxed(GENMASK(31, 0), port->bridge_base_addr + ISTATUS_LOCAL);
> +	writel_relaxed(GENMASK(31, 0), port->bridge_base_addr + ISTATUS_MSI);
>  
>  	/* Disable PCIe events and clear any outstanding */
>  	val = PCIE_EVENT_INT_L2_EXIT_INT |
> @@ -605,11 +600,11 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>  	      PCIE_EVENT_INT_L2_EXIT_INT_MASK |
>  	      PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK |
>  	      PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> -	writel_relaxed(val, ctrl_base_addr + PCIE_EVENT_INT);
> +	writel_relaxed(val, port->ctrl_base_addr + PCIE_EVENT_INT);
>  
>  	/* Disable host interrupts and clear any outstanding */
> -	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
> -	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
> +	writel_relaxed(0, port->bridge_base_addr + IMASK_HOST);
> +	writel_relaxed(GENMASK(31, 0), port->bridge_base_addr + ISTATUS_HOST);
>  }
>  
>  static int mc_platform_init(struct pci_config_window *cfg)
> @@ -617,12 +612,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	struct device *dev = cfg->parent;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
> -	void __iomem *bridge_base_addr =
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	int ret;
>  
>  	/* Configure address translation table 0 for PCIe config space */
> -	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> +	plda_pcie_setup_window(port->bridge_base_addr, 0, cfg->res.start,
>  			       cfg->res.start,
>  			       resource_size(&cfg->res));
>  
> @@ -649,7 +642,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  static int mc_host_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	void __iomem *bridge_base_addr;
> +	void __iomem *apb_base_addr;
>  	struct plda_pcie_rp *plda;
>  	int ret;
>  	u32 val;
> @@ -661,30 +654,43 @@ static int mc_host_probe(struct platform_device *pdev)
>  	plda = &port->plda;
>  	plda->dev = dev;
>  
> -	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(port->axi_base_addr))
> -		return PTR_ERR(port->axi_base_addr);
> +	port->bridge_base_addr = devm_platform_ioremap_resource_byname(pdev, "bridge");
> +	port->ctrl_base_addr = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	if (!IS_ERR(port->bridge_base_addr) && !IS_ERR(port->ctrl_base_addr))
> +		goto addrs_set;
>  
> +	/*
> +	 * The original, incorrect, binding that lumped the control and
> +	 * bridge addresses together still needs to be handled by the driver.
> +	 */
> +	apb_base_addr = devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(apb_base_addr))
> +		return dev_err_probe(dev, PTR_ERR(apb_base_addr),
> +				     "both legacy apb register and ctrl/bridge regions missing");
> +
> +	port->bridge_base_addr = apb_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	port->ctrl_base_addr = apb_base_addr + MC_PCIE1_CTRL_ADDR;
> +
> +addrs_set:
>  	mc_disable_interrupts(port);
>  
> -	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> -	plda->bridge_addr = bridge_base_addr;
> +	plda->bridge_addr = port->bridge_base_addr;
>  	plda->num_events = NUM_EVENTS;
>  
>  	/* Allow enabling MSI by disabling MSI-X */
> -	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	val = readl(port->bridge_base_addr + PCIE_PCI_IRQ_DW0);
>  	val &= ~MSIX_CAP_MASK;
> -	writel(val, bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	writel(val, port->bridge_base_addr + PCIE_PCI_IRQ_DW0);
>  
>  	/* Pick num vectors from bitfile programmed onto FPGA fabric */
> -	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	val = readl(port->bridge_base_addr + PCIE_PCI_IRQ_DW0);
>  	val &= NUM_MSI_MSGS_MASK;
>  	val >>= NUM_MSI_MSGS_SHIFT;
>  
>  	plda->msi.num_vectors = 1 << val;
>  
>  	/* Pick vector address from design */
> -	plda->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
> +	plda->msi.vector_phy = readl_relaxed(port->bridge_base_addr + IMSI_ADDR);
>  
>  	ret = mc_pcie_init_clks(dev);
>  	if (ret) {
> -- 
> 2.43.0
> 

