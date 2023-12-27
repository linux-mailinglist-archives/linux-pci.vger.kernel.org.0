Return-Path: <linux-pci+bounces-1444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A181EFE7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 16:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4346DB214AE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8445976;
	Wed, 27 Dec 2023 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krFHbGEK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9D45957;
	Wed, 27 Dec 2023 15:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2153C433C8;
	Wed, 27 Dec 2023 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703692364;
	bh=HUUYT38ijS88V+WbIgD3c5c1zlkbxXthc/FJwbEx62M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=krFHbGEKwa3sp5P7T8YbE9CQnxN5frHCiFM3wj92vajrUHDcyZ78nGYpZWyLf+Yhh
	 qq0VZmTTCd7u2Ua16kno8di8DO7egsUO248gk2QFof3Mhi9W2z5BezfkfD3RQr0Wcy
	 1nn2D8l216wF8IXnmVpcMlMH/ocRjuLW4zKBOJAPpjgVkjKF7tyE6r3lP2UNWXF9Ab
	 WkRvNIrqNMvDAnAuWVdSCVdAYweL1wPTVfGmXd1pQoJzCwFo4ebqsdQvHeR+mfY6dA
	 X7elROsAS7w4MX4sfpU1kUTdZIOrJDYIv3v0blYcgZ5gEiKMzhkviQtnhMghcAm1Gn
	 /Ka8mXWoLaneg==
Date: Wed, 27 Dec 2023 16:52:35 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v13 10/21] PCI: microchip: Rename interrupt related
 functions
Message-ID: <ZYxIQ9ruBbxWKfIg@lpieralisi>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-11-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214072839.2367-11-minda.chen@starfivetech.com>

On Thu, Dec 14, 2023 at 03:28:28PM +0800, Minda Chen wrote:
> Rename mc_* to plda_* for IRQ functions and related IRQ domain ops data
> instances.
> 
> MSI, INTx interrupt codes and IRQ init codes are all can be re-used.

s/codes/code

> 
> - function rename list:
>   mc_allocate_msi_domains()  --> plda_allocate_msi_domains()
>   mc_init_interrupts()       --> plda_init_interrupts()
>   mc_pcie_init_irq_domain()  --> plda_pcie_init_irq_domains()
>   mc_handle_event()          --> plda_handle_event()
>   get_events()               --> mc_get_events()
> 
>   MSI interrupts related functions and IRQ domain
>   (primary function is mc_handle_msi()):
>     mc_handle_msi()          --> plda_handle_msi()
>   INTx interrupts related functions and IRQ domain
>   (primary function is mc_handle_intx()):
>     mc_handle_intx()         --> plda_handle_intx()

We can read the code you are changing, there is no need to
add it to the commit log, especially because it is a trivial
rename here.

> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 112 +++++++++---------
>  1 file changed, 59 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 2e79bcc7c0a5..506e6eeadc76 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -318,7 +318,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
>  		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
>  }
>  
> -static void mc_handle_msi(struct irq_desc *desc)
> +static void plda_handle_msi(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -333,7 +333,8 @@ static void mc_handle_msi(struct irq_desc *desc)
>  
>  	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
>  	if (status & PM_MSI_INT_MSI_MASK) {
> -		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
> +		writel_relaxed(status & PM_MSI_INT_MSI_MASK,
> +			       bridge_base_addr + ISTATUS_LOCAL);

Unrelated change (I suspect checkpatch nudged you to make it; it
is tempting but it does not belong in this patch).

Lorenzo

>  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>  		for_each_set_bit(bit, &status, msi->num_vectors) {
>  			ret = generic_handle_domain_irq(msi->dev_domain, bit);
> @@ -346,7 +347,7 @@ static void mc_handle_msi(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static void mc_msi_bottom_irq_ack(struct irq_data *data)
> +static void plda_msi_bottom_irq_ack(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
> @@ -355,7 +356,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
>  	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
>  }
>  
> -static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	phys_addr_t addr = port->msi.vector_phy;
> @@ -368,21 +369,23 @@ static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		(int)data->hwirq, msg->address_hi, msg->address_lo);
>  }
>  
> -static int mc_msi_set_affinity(struct irq_data *irq_data,
> -			       const struct cpumask *mask, bool force)
> +static int plda_msi_set_affinity(struct irq_data *irq_data,
> +				 const struct cpumask *mask, bool force)
>  {
>  	return -EINVAL;
>  }
>  
> -static struct irq_chip mc_msi_bottom_irq_chip = {
> -	.name = "Microchip MSI",
> -	.irq_ack = mc_msi_bottom_irq_ack,
> -	.irq_compose_msi_msg = mc_compose_msi_msg,
> -	.irq_set_affinity = mc_msi_set_affinity,
> +static struct irq_chip plda_msi_bottom_irq_chip = {
> +	.name = "PLDA MSI",
> +	.irq_ack = plda_msi_bottom_irq_ack,
> +	.irq_compose_msi_msg = plda_compose_msi_msg,
> +	.irq_set_affinity = plda_msi_set_affinity,
>  };
>  
> -static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> -				   unsigned int nr_irqs, void *args)
> +static int plda_irq_msi_domain_alloc(struct irq_domain *domain,
> +				     unsigned int virq,
> +				     unsigned int nr_irqs,
> +				     void *args)
>  {
>  	struct plda_pcie_rp *port = domain->host_data;
>  	struct plda_msi *msi = &port->msi;
> @@ -397,7 +400,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	set_bit(bit, msi->used);
>  
> -	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
> +	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
>  			    domain->host_data, handle_edge_irq, NULL, NULL);
>  
>  	mutex_unlock(&msi->lock);
> @@ -405,8 +408,9 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	return 0;
>  }
>  
> -static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> -				   unsigned int nr_irqs)
> +static void plda_irq_msi_domain_free(struct irq_domain *domain,
> +				     unsigned int virq,
> +				     unsigned int nr_irqs)
>  {
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>  	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
> @@ -423,24 +427,24 @@ static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned int virq,
>  }
>  
>  static const struct irq_domain_ops msi_domain_ops = {
> -	.alloc	= mc_irq_msi_domain_alloc,
> -	.free	= mc_irq_msi_domain_free,
> +	.alloc	= plda_irq_msi_domain_alloc,
> +	.free	= plda_irq_msi_domain_free,
>  };
>  
> -static struct irq_chip mc_msi_irq_chip = {
> -	.name = "Microchip PCIe MSI",
> +static struct irq_chip plda_msi_irq_chip = {
> +	.name = "PLDA PCIe MSI",
>  	.irq_ack = irq_chip_ack_parent,
>  	.irq_mask = pci_msi_mask_irq,
>  	.irq_unmask = pci_msi_unmask_irq,
>  };
>  
> -static struct msi_domain_info mc_msi_domain_info = {
> +static struct msi_domain_info plda_msi_domain_info = {
>  	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>  		  MSI_FLAG_PCI_MSIX),
> -	.chip = &mc_msi_irq_chip,
> +	.chip = &plda_msi_irq_chip,
>  };
>  
> -static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
> +static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
>  	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> @@ -455,7 +459,8 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
>  		return -ENOMEM;
>  	}
>  
> -	msi->msi_domain = pci_msi_create_irq_domain(fwnode, &mc_msi_domain_info,
> +	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> +						    &plda_msi_domain_info,
>  						    msi->dev_domain);
>  	if (!msi->msi_domain) {
>  		dev_err(dev, "failed to create MSI domain\n");
> @@ -466,7 +471,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
>  	return 0;
>  }
>  
> -static void mc_handle_intx(struct irq_desc *desc)
> +static void plda_handle_intx(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -493,7 +498,7 @@ static void mc_handle_intx(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static void mc_ack_intx_irq(struct irq_data *data)
> +static void plda_ack_intx_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
> @@ -502,7 +507,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
>  	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
>  }
>  
> -static void mc_mask_intx_irq(struct irq_data *data)
> +static void plda_mask_intx_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
> @@ -517,7 +522,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> -static void mc_unmask_intx_irq(struct irq_data *data)
> +static void plda_unmask_intx_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr = port->bridge_addr;
> @@ -532,24 +537,24 @@ static void mc_unmask_intx_irq(struct irq_data *data)
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> -static struct irq_chip mc_intx_irq_chip = {
> -	.name = "Microchip PCIe INTx",
> -	.irq_ack = mc_ack_intx_irq,
> -	.irq_mask = mc_mask_intx_irq,
> -	.irq_unmask = mc_unmask_intx_irq,
> +static struct irq_chip plda_intx_irq_chip = {
> +	.name = "PLDA PCIe INTx",
> +	.irq_ack = plda_ack_intx_irq,
> +	.irq_mask = plda_mask_intx_irq,
> +	.irq_unmask = plda_unmask_intx_irq,
>  };
>  
> -static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> -			    irq_hw_number_t hwirq)
> +static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +			      irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_level_irq);
> +	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
>  
>  	return 0;
>  }
>  
>  static const struct irq_domain_ops intx_domain_ops = {
> -	.map = mc_pcie_intx_map,
> +	.map = plda_pcie_intx_map,
>  };
>  
>  static inline u32 reg_to_event(u32 reg, struct event_map field)
> @@ -609,7 +614,7 @@ static u32 local_events(struct mc_pcie *port)
>  	return val;
>  }
>  
> -static u32 get_events(struct plda_pcie_rp *port)
> +static u32 mc_get_events(struct plda_pcie_rp *port)
>  {
>  	struct mc_pcie *mc_port = container_of(port, struct mc_pcie, plda);
>  	u32 events = 0;
> @@ -638,7 +643,7 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void mc_handle_event(struct irq_desc *desc)
> +static void plda_handle_event(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
>  	unsigned long events;
> @@ -647,7 +652,7 @@ static void mc_handle_event(struct irq_desc *desc)
>  
>  	chained_irq_enter(chip, desc);
>  
> -	events = get_events(port);
> +	events = mc_get_events(port);
>  
>  	for_each_set_bit(bit, &events, NUM_EVENTS)
>  		generic_handle_domain_irq(port->event_domain, bit);
> @@ -741,8 +746,8 @@ static struct irq_chip mc_event_irq_chip = {
>  	.irq_unmask = mc_unmask_event_irq,
>  };
>  
> -static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
> -			     irq_hw_number_t hwirq)
> +static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
> +			       irq_hw_number_t hwirq)
>  {
>  	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> @@ -750,8 +755,8 @@ static int mc_pcie_event_map(struct irq_domain *domain, unsigned int irq,
>  	return 0;
>  }
>  
> -static const struct irq_domain_ops event_domain_ops = {
> -	.map = mc_pcie_event_map,
> +static const struct irq_domain_ops plda_event_domain_ops = {
> +	.map = plda_pcie_event_map,
>  };
>  
>  static inline void mc_pcie_deinit_clk(void *data)
> @@ -799,7 +804,7 @@ static int mc_pcie_init_clks(struct device *dev)
>  	return 0;
>  }
>  
> -static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
> @@ -813,7 +818,8 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  	}
>  
>  	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
> -						   &event_domain_ops, port);
> +						   &plda_event_domain_ops,
> +						   port);
>  	if (!port->event_domain) {
>  		dev_err(dev, "failed to get event domain\n");
>  		of_node_put(pcie_intc_node);
> @@ -835,7 +841,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  	of_node_put(pcie_intc_node);
>  	raw_spin_lock_init(&port->lock);
>  
> -	return mc_allocate_msi_domains(port);
> +	return plda_allocate_msi_domains(port);
>  }
>  
>  static inline void mc_clear_secs(struct mc_pcie *port)
> @@ -898,14 +904,14 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
>  
> -static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
> +static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
>  {
>  	struct device *dev = &pdev->dev;
>  	int irq;
>  	int i, intx_irq, msi_irq, event_irq;
>  	int ret;
>  
> -	ret = mc_pcie_init_irq_domains(port);
> +	ret = plda_pcie_init_irq_domains(port);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> @@ -938,7 +944,7 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>  	}
>  
>  	/* Plug the INTx chained handler */
> -	irq_set_chained_handler_and_data(intx_irq, mc_handle_intx, port);
> +	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
>  
>  	msi_irq = irq_create_mapping(port->event_domain,
>  				     EVENT_LOCAL_PM_MSI_INT_MSI);
> @@ -946,10 +952,10 @@ static int mc_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp
>  		return -ENXIO;
>  
>  	/* Plug the MSI chained handler */
> -	irq_set_chained_handler_and_data(msi_irq, mc_handle_msi, port);
> +	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
>  
>  	/* Plug the main event chained handler */
> -	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
> +	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
>  
>  	return 0;
>  }
> @@ -977,7 +983,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  		return ret;
>  
>  	/* Address translation is up; safe to enable interrupts */
> -	ret = mc_init_interrupts(pdev, &port->plda);
> +	ret = plda_init_interrupts(pdev, &port->plda);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.17.1
> 

