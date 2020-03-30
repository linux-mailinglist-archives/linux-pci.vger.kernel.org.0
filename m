Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40B419813A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgC3Q3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 12:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgC3Q3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 12:29:51 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB4820578;
        Mon, 30 Mar 2020 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585585789;
        bh=zTvL89t6cRLY2IwX0b2s1y4hD8pcV1s4WQklqCIrcrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yLdXvmkx/PzecUWi5hqNgJquAURAJxAhojpSCWmzP3QjRs7pfHvwKdso9MD08Yx8T
         LEZ+MuFkEPbc2UG1sJy3N+IRAelS2JNl+eZfkJvucAIHTPfx9hD/LU/Ta1uxc+5c/B
         k7NpdwWDMF6jXslsSrtLlKJEommIhYCZMuAcQNEA=
Date:   Mon, 30 Mar 2020 11:29:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
Message-ID: <20200330162928.GA55054@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327095434.945-1-vigneshr@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, Thomas]

On Fri, Mar 27, 2020 at 03:24:34PM +0530, Vignesh Raghavendra wrote:
> Due an issue with PCIe wrapper around DWC PCIe IP on dra7xx, driver
> needs to ensure that there are no pending MSI IRQ vector set (i.e
> PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting IRQ handler.
> Else, the dra7xx PCIe wrapper will not register new MSI IRQs even though
> PCIE_MSI_INTR0_STATUS shows IRQs are pending.

I'm not an IRQ guy (real IRQ guys CC'd), but I'm wondering if this is
really a symptom of a problem in the generic DWC IRQ handling, not a
problem in dra7xx itself.

I thought it was sort of standard behavior that a device would not
send a new MSI unless there was a transition from "no status bits set"
to "at least one status bit set".  I'm looking at this text from the
PCIe r5.0 spec, sec 6.7.3.4:

  If the Port is enabled for edge-triggered interrupt signaling using
  MSI or MSI-X, an interrupt message must be sent every time the
  logical AND of the following conditions transitions from FALSE to
  TRUE:

    - The associated vector is unmasked (not applicable if MSI does
      not support PVM).

    - The Hot-Plug Interrupt Enable bit in the Slot Control register
      is set to 1b.

    - At least one hot-plug event status bit in the Slot Status
      register and its associated enable bit in the Slot Control
      register are both set to 1b.

and this related commit: https://git.kernel.org/linus/fad214b0aa72

> Therefore its no longer possible to use default IRQ handler provided by
> DWC library. So, add irqchip implementation inside pci-dra7xx.c and
> install new MSI IRQ handler to handle above errata.
> 
> This fixes a bug, where PCIe wifi cards with 4 DMA queues like Intel
> 8260 used to throw following error and stall during ping/iperf3 tests.
> 
> [   97.776310] iwlwifi 0000:01:00.0: Queue 9 stuck for 2500 ms.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> 
> v4:
> Simplify dra7xx_pcie_handle_msi_irq() by spliting inner loop into
> separte function as suggested by Lorenzo
> 
> v3:
> - Move loop to service all MSI IRQs into dra7xx_pcie_handle_msi_irq()
> - Add a warning msg when loop counter overflows
> 
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c | 231 ++++++++++++++++++++----
>  1 file changed, 195 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 9bf7fa99b103..3b0e58f2de58 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -215,10 +215,6 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
> -	.host_init = dra7xx_pcie_host_init,
> -};
> -
>  static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  				irq_hw_number_t hwirq)
>  {
> @@ -233,43 +229,77 @@ static const struct irq_domain_ops intx_domain_ops = {
>  	.xlate = pci_irqd_intx_xlate,
>  };
>  
> -static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> +static int dra7xx_pcie_handle_msi(struct pcie_port *pp, int index)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct device *dev = pci->dev;
> -	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
> -	struct device_node *node = dev->of_node;
> -	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
> +	unsigned long val;
> +	int pos, irq;
>  
> -	if (!pcie_intc_node) {
> -		dev_err(dev, "No PCIe Intc node found\n");
> -		return -ENODEV;
> -	}
> +	val = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> +				   (index * MSI_REG_CTRL_BLOCK_SIZE));
> +	if (!val)
> +		return 0;
>  
> -	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> -						   &intx_domain_ops, pp);
> -	of_node_put(pcie_intc_node);
> -	if (!dra7xx->irq_domain) {
> -		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return -ENODEV;
> +	pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, 0);
> +	while (pos != MAX_MSI_IRQS_PER_CTRL) {
> +		irq = irq_find_mapping(pp->irq_domain,
> +				       (index * MAX_MSI_IRQS_PER_CTRL) + pos);
> +		generic_handle_irq(irq);
> +		pos++;
> +		pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, pos);
>  	}
>  
> -	return 0;
> +	return 1;
>  }
>  
> -static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
> +static void dra7xx_pcie_handle_msi_irq(struct pcie_port *pp)
>  {
> -	struct dra7xx_pcie *dra7xx = arg;
> -	struct dw_pcie *pci = dra7xx->pci;
> -	struct pcie_port *pp = &pci->pp;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int ret, i, count, num_ctrls;
> +
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	/**
> +	 * Need to make sure all MSI status bits read 0 before exiting.
> +	 * Else, new MSI IRQs are not registered by the wrapper. Have an
> +	 * upperbound for the loop and exit the IRQ in case of IRQ flood
> +	 * to avoid locking up system in interrupt context.
> +	 */
> +	count = 0;
> +	do {
> +		ret = 0;
> +
> +		for (i = 0; i < num_ctrls; i++)
> +			ret |= dra7xx_pcie_handle_msi(pp, i);
> +		count++;
> +	} while (ret && count <= 1000);
> +
> +	if (count > 1000)
> +		dev_warn_ratelimited(pci->dev,
> +				     "Too many MSI IRQs to handle\n");
> +}
> +
> +static void dra7xx_pcie_msi_irq_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct dra7xx_pcie *dra7xx;
> +	struct dw_pcie *pci;
> +	struct pcie_port *pp;
>  	unsigned long reg;
>  	u32 virq, bit;
>  
> +	chained_irq_enter(chip, desc);
> +
> +	pp = irq_desc_get_handler_data(desc);
> +	pci = to_dw_pcie_from_pp(pp);
> +	dra7xx = to_dra7xx_pcie(pci);
> +
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>  
>  	switch (reg) {
>  	case MSI:
> -		dw_handle_msi_irq(pp);
> +		dra7xx_pcie_handle_msi_irq(pp);
>  		break;
>  	case INTA:
>  	case INTB:
> @@ -283,9 +313,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  		break;
>  	}
>  
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
> -
> -	return IRQ_HANDLED;
> +	chained_irq_exit(chip, desc);
>  }
>  
>  static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
> @@ -347,6 +375,145 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
> +
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -ENODEV;
> +	}
> +
> +	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler,
> +					 pp);
> +	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						   &intx_domain_ops, pp);
> +	of_node_put(pcie_intc_node);
> +	if (!dra7xx->irq_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dra7xx_pcie_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u64 msi_target;
> +
> +	msi_target = (u64)pp->msi_data;
> +
> +	msg->address_lo = lower_32_bits(msi_target);
> +	msg->address_hi = upper_32_bits(msi_target);
> +
> +	msg->data = d->hwirq;
> +
> +	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
> +		(int)d->hwirq, msg->address_hi, msg->address_lo);
> +}
> +
> +static int dra7xx_pcie_msi_set_affinity(struct irq_data *d,
> +					const struct cpumask *mask,
> +					bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static void dra7xx_pcie_bottom_mask(struct irq_data *d)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	unsigned int res, bit, ctrl;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +
> +	pp->irq_mask[ctrl] |= BIT(bit);
> +	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res,
> +			   pp->irq_mask[ctrl]);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +}
> +
> +static void dra7xx_pcie_bottom_unmask(struct irq_data *d)
> +{
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	unsigned int res, bit, ctrl;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +
> +	pp->irq_mask[ctrl] &= ~BIT(bit);
> +	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res,
> +			   pp->irq_mask[ctrl]);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +}
> +
> +static void dra7xx_pcie_bottom_ack(struct irq_data *d)
> +{
> +	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	unsigned int res, bit, ctrl;
> +
> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +
> +	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
> +}
> +
> +static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
> +	.name = "DRA7XX-PCI-MSI",
> +	.irq_ack = dra7xx_pcie_bottom_ack,
> +	.irq_compose_msi_msg = dra7xx_pcie_setup_msi_msg,
> +	.irq_set_affinity = dra7xx_pcie_msi_set_affinity,
> +	.irq_mask = dra7xx_pcie_bottom_mask,
> +	.irq_unmask = dra7xx_pcie_bottom_unmask,
> +};
> +
> +static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u32 ctrl, num_ctrls;
> +
> +	pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
> +
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +	/* Initialize IRQ Status array */
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +		pp->irq_mask[ctrl] = ~0;
> +		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
> +				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +				    pp->irq_mask[ctrl]);
> +		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
> +				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +				    ~0);
> +	}
> +
> +	return dw_pcie_allocate_domains(pp);
> +}
> +
> +static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
> +	.host_init = dra7xx_pcie_host_init,
> +	.msi_host_init = dra7xx_pcie_msi_host_init,
> +};
> +
>  static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -467,14 +634,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  		return pp->irq;
>  	}
>  
> -	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
> -			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       "dra7-pcie-msi",	dra7xx);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq\n");
> -		return ret;
> -	}
> -
>  	ret = dra7xx_pcie_init_irq_domain(pp);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.26.0
> 
