Return-Path: <linux-pci+bounces-4233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72B86C63F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB50B20DA7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E15663130;
	Thu, 29 Feb 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq0nbs3u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283063129;
	Thu, 29 Feb 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200909; cv=none; b=Tq/ujJSAYcz+Ao/AEM2NWRaCkgcDxt84IePXgTsOM2f0hI+Im0NTSRP0pT/wU8VWPAbSLrAsEK8DBAanABHx09ovFvNgzc+mex4Gc5edgFsv/iL2KA4SEyzpDjsYYAt2Z4SJxlaNb7C+EWJ1gnw0YaP1rhQQBd56h7Pgr9BCeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200909; c=relaxed/simple;
	bh=0EvAP/k3RYWfB4nfZLvIefXSHFryrqEoAdsNstyND9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibDHByl8C5o8NsFKciYAduKCL6wIoyK+9mIZ3RedI3lXAKY9w08MdeDSO6yJxBauD4gpwJPkMekIhvkc70cylGP8GynJJAkPqaBxm3exYJkQ+MHrMX0Hj2Q/FZHjQKSo802S3YeuFwDGYiiRSM2V9APGFb2dBImQfQ+z/tfms7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq0nbs3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301D5C433C7;
	Thu, 29 Feb 2024 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200908;
	bh=0EvAP/k3RYWfB4nfZLvIefXSHFryrqEoAdsNstyND9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tq0nbs3uLnKCLIVkPa0855Ew6lEJ8NSJ53kKT41FCB6zoxM9uJyJcPc6EEeYk/Ii3
	 N9O3nBW48txXwUZeUqA9bWvmUMQrfaaZ+BAhl8KDvj/FSTPBXS8tcro3ta2ilCfRAC
	 7zoTTaJOjWhsH9Ul+77Jag+or2uPZWgXgyBaGCqQhIif4R2luSePgjzbLyJpDeEsEm
	 LRnc3CM/IroJNzXfriPkqCt3VJk/WcTuBphH9rlCmwsooJ3SHSIb540u2AB8b3t1Gf
	 IghH6xFkLzA69TnyKjFIiTmHoPQ2dOTjy/33h7zjW1KF98muLHDxQmQJT7/DPj9URP
	 YUU9fS8+EPC6w==
Date: Thu, 29 Feb 2024 11:01:41 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 05/23] PCI: microchip: Rename two PCIe data
 structures
Message-ID: <ZeBWBfMlS4nxMZJ2@lpieralisi>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
 <20240227103522.80915-6-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227103522.80915-6-minda.chen@starfivetech.com>

On Tue, Feb 27, 2024 at 06:35:04PM +0800, Minda Chen wrote:
> Add PLDA PCIe related data structures by rename data structure name from
> mc_* to plda_*.
> 
> axi_base_addr is stayed in struct mc_pcie for it's microchip its own data.

Here in "for it's microchip" you mean "since it's microchip" own data.

Please fix this "for" usage in all commit logs, I noticed it is
a recurrent mistake you make I can do it but it is tedious.

Don't resend another version yet, I am trying to see what I can
take from this one.

> The event interrupt codes is still using struct mc_pcie because the event

"code", please not "codes". Please fix it everywhere in your patch
series, same as above.

Lorenzo

> interrupt codes can not be re-used.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 96 ++++++++++---------
>  1 file changed, 53 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index c55ede80a6d0..df0736f688ce 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -22,7 +22,7 @@
>  #include "pcie-plda.h"
>  
>  /* Number of MSI IRQs */
> -#define MC_MAX_NUM_MSI_IRQS			32
> +#define PLDA_MAX_NUM_MSI_IRQS			32
>  
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> @@ -179,25 +179,29 @@ struct event_map {
>  	u32 event_bit;
>  };
>  
> -struct mc_msi {
> +struct plda_msi {
>  	struct mutex lock;		/* Protect used bitmap */
>  	struct irq_domain *msi_domain;
>  	struct irq_domain *dev_domain;
>  	u32 num_vectors;
>  	u64 vector_phy;
> -	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
> +	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
>  };
>  
> -struct mc_pcie {
> -	void __iomem *axi_base_addr;
> +struct plda_pcie_rp {
>  	struct device *dev;
>  	struct irq_domain *intx_domain;
>  	struct irq_domain *event_domain;
>  	raw_spinlock_t lock;
> -	struct mc_msi msi;
> +	struct plda_msi msi;
>  	void __iomem *bridge_addr;
>  };
>  
> +struct mc_pcie {
> +	struct plda_pcie_rp plda;
> +	void __iomem *axi_base_addr;
> +};
> +
>  struct cause {
>  	const char *sym;
>  	const char *str;
> @@ -313,7 +317,7 @@ static struct mc_pcie *port;
>  
>  static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
>  {
> -	struct mc_msi *msi = &port->msi;
> +	struct plda_msi *msi = &port->plda.msi;
>  	u16 reg;
>  	u8 queue_size;
>  
> @@ -336,10 +340,10 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
>  
>  static void mc_handle_msi(struct irq_desc *desc)
>  {
> -	struct mc_pcie *port = irq_desc_get_handler_data(desc);
> +	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct device *dev = port->dev;
> -	struct mc_msi *msi = &port->msi;
> +	struct plda_msi *msi = &port->msi;
>  	void __iomem *bridge_base_addr = port->bridge_addr;
>  	unsigned long status;
>  	u32 bit;
> @@ -364,7 +368,7 @@ static void mc_handle_msi(struct irq_desc *desc)
>  
>  static void mc_msi_bottom_irq_ack(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
>  	u32 bitpos = data->hwirq;
>  
> @@ -373,7 +377,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
>  
>  static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	phys_addr_t addr = port->msi.vector_phy;
>  
>  	msg->address_lo = lower_32_bits(addr);
> @@ -400,8 +404,8 @@ static struct irq_chip mc_msi_bottom_irq_chip = {
>  static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  				   unsigned int nr_irqs, void *args)
>  {
> -	struct mc_pcie *port = domain->host_data;
> -	struct mc_msi *msi = &port->msi;
> +	struct plda_pcie_rp *port = domain->host_data;
> +	struct plda_msi *msi = &port->msi;
>  	unsigned long bit;
>  
>  	mutex_lock(&msi->lock);
> @@ -425,8 +429,8 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
>  				   unsigned int nr_irqs)
>  {
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(d);
> -	struct mc_msi *msi = &port->msi;
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
> +	struct plda_msi *msi = &port->msi;
>  
>  	mutex_lock(&msi->lock);
>  
> @@ -456,11 +460,11 @@ static struct msi_domain_info mc_msi_domain_info = {
>  	.chip = &mc_msi_irq_chip,
>  };
>  
> -static int mc_allocate_msi_domains(struct mc_pcie *port)
> +static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
>  	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> -	struct mc_msi *msi = &port->msi;
> +	struct plda_msi *msi = &port->msi;
>  
>  	mutex_init(&port->msi.lock);
>  
> @@ -484,7 +488,7 @@ static int mc_allocate_msi_domains(struct mc_pcie *port)
>  
>  static void mc_handle_intx(struct irq_desc *desc)
>  {
> -	struct mc_pcie *port = irq_desc_get_handler_data(desc);
> +	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct device *dev = port->dev;
>  	void __iomem *bridge_base_addr = port->bridge_addr;
> @@ -511,7 +515,7 @@ static void mc_handle_intx(struct irq_desc *desc)
>  
>  static void mc_ack_intx_irq(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
>  	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
>  
> @@ -520,7 +524,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
>  
>  static void mc_mask_intx_irq(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
>  	unsigned long flags;
>  	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> @@ -535,7 +539,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
>  
>  static void mc_unmask_intx_irq(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
>  	unsigned long flags;
>  	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> @@ -625,21 +629,22 @@ static u32 local_events(struct mc_pcie *port)
>  	return val;
>  }
>  
> -static u32 get_events(struct mc_pcie *port)
> +static u32 get_events(struct plda_pcie_rp *port)
>  {
> +	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
>  	u32 events = 0;
>  
> -	events |= pcie_events(port);
> -	events |= sec_errors(port);
> -	events |= ded_errors(port);
> -	events |= local_events(port);
> +	events |= pcie_events(mc_port);
> +	events |= sec_errors(mc_port);
> +	events |= ded_errors(mc_port);
> +	events |= local_events(mc_port);
>  
>  	return events;
>  }
>  
>  static irqreturn_t mc_event_handler(int irq, void *dev_id)
>  {
> -	struct mc_pcie *port = dev_id;
> +	struct plda_pcie_rp *port = dev_id;
>  	struct device *dev = port->dev;
>  	struct irq_data *data;
>  
> @@ -655,7 +660,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
>  
>  static void mc_handle_event(struct irq_desc *desc)
>  {
> -	struct mc_pcie *port = irq_desc_get_handler_data(desc);
> +	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>  	unsigned long events;
>  	u32 bit;
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -672,12 +677,13 @@ static void mc_handle_event(struct irq_desc *desc)
>  
>  static void mc_ack_event_irq(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
> +	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
>  	u32 event = data->hwirq;
>  	void __iomem *addr;
>  	u32 mask;
>  
> -	addr = port->axi_base_addr + event_descs[event].base +
> +	addr = mc_port->axi_base_addr + event_descs[event].base +
>  		event_descs[event].offset;
>  	mask = event_descs[event].mask;
>  	mask |= event_descs[event].enb_mask;
> @@ -687,13 +693,14 @@ static void mc_ack_event_irq(struct irq_data *data)
>  
>  static void mc_mask_event_irq(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
> +	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
>  	u32 event = data->hwirq;
>  	void __iomem *addr;
>  	u32 mask;
>  	u32 val;
>  
> -	addr = port->axi_base_addr + event_descs[event].base +
> +	addr = mc_port->axi_base_addr + event_descs[event].base +
>  		event_descs[event].mask_offset;
>  	mask = event_descs[event].mask;
>  	if (event_descs[event].enb_mask) {
> @@ -717,13 +724,14 @@ static void mc_mask_event_irq(struct irq_data *data)
>  
>  static void mc_unmask_event_irq(struct irq_data *data)
>  {
> -	struct mc_pcie *port = irq_data_get_irq_chip_data(data);
> +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
> +	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
>  	u32 event = data->hwirq;
>  	void __iomem *addr;
>  	u32 mask;
>  	u32 val;
>  
> -	addr = port->axi_base_addr + event_descs[event].base +
> +	addr = mc_port->axi_base_addr + event_descs[event].base +
>  		event_descs[event].mask_offset;
>  	mask = event_descs[event].mask;
>  
> @@ -811,7 +819,7 @@ static int mc_pcie_init_clks(struct device *dev)
>  	return 0;
>  }
>  
> -static int mc_pcie_init_irq_domains(struct mc_pcie *port)
> +static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
> @@ -889,7 +897,7 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  }
>  
>  static int mc_pcie_setup_windows(struct platform_device *pdev,
> -				 struct mc_pcie *port)
> +				 struct plda_pcie_rp *port)
>  {
>  	void __iomem *bridge_base_addr = port->bridge_addr;
>  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
> @@ -970,7 +978,7 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
>  
> -static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port)
> +static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
>  {
>  	struct device *dev = &pdev->dev;
>  	int irq;
> @@ -1043,12 +1051,12 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	mc_pcie_enable_msi(port, cfg->win);
>  
>  	/* Configure non-config space outbound ranges */
> -	ret = mc_pcie_setup_windows(pdev, port);
> +	ret = mc_pcie_setup_windows(pdev, &port->plda);
>  	if (ret)
>  		return ret;
>  
>  	/* Address translation is up; safe to enable interrupts */
> -	ret = mc_init_interrupts(pdev, port);
> +	ret = mc_init_interrupts(pdev, &port->plda);
>  	if (ret)
>  		return ret;
>  
> @@ -1059,6 +1067,7 @@ static int mc_host_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	void __iomem *bridge_base_addr;
> +	struct plda_pcie_rp *plda;
>  	int ret;
>  	u32 val;
>  
> @@ -1066,7 +1075,8 @@ static int mc_host_probe(struct platform_device *pdev)
>  	if (!port)
>  		return -ENOMEM;
>  
> -	port->dev = dev;
> +	plda = &port->plda;
> +	plda->dev = dev;
>  
>  	port->axi_base_addr = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(port->axi_base_addr))
> @@ -1075,7 +1085,7 @@ static int mc_host_probe(struct platform_device *pdev)
>  	mc_disable_interrupts(port);
>  
>  	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> -	port->bridge_addr = bridge_base_addr;
> +	plda->bridge_addr = bridge_base_addr;
>  
>  	/* Allow enabling MSI by disabling MSI-X */
>  	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> @@ -1087,10 +1097,10 @@ static int mc_host_probe(struct platform_device *pdev)
>  	val &= NUM_MSI_MSGS_MASK;
>  	val >>= NUM_MSI_MSGS_SHIFT;
>  
> -	port->msi.num_vectors = 1 << val;
> +	plda->msi.num_vectors = 1 << val;
>  
>  	/* Pick vector address from design */
> -	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
> +	plda->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
>  
>  	ret = mc_pcie_init_clks(dev);
>  	if (ret) {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

