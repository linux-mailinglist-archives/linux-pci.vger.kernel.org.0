Return-Path: <linux-pci+bounces-1438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A850881EF0A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 13:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6046E281BC9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D429844C71;
	Wed, 27 Dec 2023 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYp7PIIS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232A446C6;
	Wed, 27 Dec 2023 12:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A69FC433C7;
	Wed, 27 Dec 2023 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703681001;
	bh=fG3U9LgjzHMiSiELkBGqIA/RCiY7QC8U+5CJV01wDKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYp7PIISHXbUtOUBLx7LALbsOVeEHZIOhDh3/kcTf/6PDJQKihC8Oh2nG4pNyAe+S
	 PrT6EZpdAAwtlUS6tVg/hcx2ZQGVijt9bgAns8GbpV+n50CvvBxftlCSNyIkKX2Gna
	 A6wlYHu4Xp8GHvIXww3W/nOHnQJGABexWJGNMrvfdsSzHj1nQjKHNWx0dQMqntJ9EC
	 2mW/YZe8tunQtrNvu5AIMPgmr6Rgt/x1nJzGOv+Cw57VLrT885u/uD0tWMgTb7op2S
	 +blyurKWSClpvWSTcw81KgmR29lKw7xUyzvKWXC17iQu9vVQZf40nSByF//oNkUuK+
	 FuB6P/5YMzhdQ==
Date: Wed, 27 Dec 2023 13:43:13 +0100
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
	Kevin Xie <kevin.xie@starfivetech.com>, tglx@linutronix.de
Subject: Re: [PATCH v13 15/21] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Message-ID: <ZYwb4UQVoLDZw7kf@lpieralisi>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-16-minda.chen@starfivetech.com>
 <8c417157-8884-4e91-8912-0344e71f82c2@starfivetech.com>
 <ZYRaqYTcxWJGwWG8@lpieralisi>
 <025408dd-cc00-4744-8a41-cbd18209ed8b@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <025408dd-cc00-4744-8a41-cbd18209ed8b@starfivetech.com>

[+Thomas]

On Fri, Dec 22, 2023 at 07:18:48PM +0800, Minda Chen wrote:
> 
> 
> On 2023/12/21 23:32, Lorenzo Pieralisi wrote:
> > On Thu, Dec 21, 2023 at 06:56:22PM +0800, Minda Chen wrote:
> >> 
> >> 
> >> On 2023/12/14 15:28, Minda Chen wrote:
> >> > PolarFire PCIE event IRQs includes PLDA local interrupts and PolarFire
> >> > their own IRQs. PolarFire PCIe event irq_chip ops using an event_desc to
> >> > unify different IRQ register addresses. On PLDA sides, PLDA irqchip codes
> >> > only require to set PLDA local interrupt register. So the PLDA irqchip ops
> >> > codes can not be extracted from PolarFire codes.
> >> > 
> >> > To support PLDA its own event IRQ process, implements PLDA irqchip ops and
> >> > add event irqchip field to struct pcie_plda_rp.
> >> > 
> >> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> >> > ---
> >> >  .../pci/controller/plda/pcie-microchip-host.c | 65 ++++++++++++++++++-
> >> >  drivers/pci/controller/plda/pcie-plda.h       |  3 +
> >> >  2 files changed, 67 insertions(+), 1 deletion(-)
> >> > 
> >> Hi Conor
> >>    Could you take time to review this patch?  For I using event irq chip instead of event ops and the whole patch have been changed.  I think it's better 
> >>    And I added the implementation of PLDA event irqchip  and make it easier to claim the necessity of the modification.
> >>    If you approve this, I will add back the review tag. Thanks
> >> 
> >> Hi Lorenzo
> >>    Have you reviewed this patch？ Does the commit message and the codes are can be approved ？Thanks
> >> 
> > 
> > Please wrap the lines at 75 columns in length.
> > 
> OK
> > I have not reviewed but I am still struggling to understand the
> > commit log, I apologise, I can try to review the series and figure
> > out what the patch is doing but I would appreciate if commits logs
> > could be made easier to parse.
> > 
> > Thanks,
> > Lorenzo
> > 
> 
> The commit message it is not good.
> 
> I draw a graph about the PCIe global event interrupt domain
> (related to patch 10- 16).
> Actually all these interrupts patches are for extracting the common 
> PLDA codes to pcie-plda-host.c and do not change microchip's codes logic.

s/codes/code (please apply this to the the full series)

I will have a look at the code but I can't rewrite the commit log myself
(it does not scale I am afraid), as it stands I don't understand it and
that's a problem, I am sorry but that's important.

I added Thomas (you should CC him for irqchip [only] changes) if he
has time to review these irqchip changes to make sure they are proper.

Thanks,
Lorenzo

>             +----------------------------------------------------------+
>             |    microchip  Global event interrupt domain              |
>             +-----------------------------------+-----------+----------+
>             |                                   | microchip | PLDA     |
>             |                                   | event num |(StarFive)|
>             |                                   |           |event num |
>             +-----------------------------------+-----------+----------+
>             |                                   | 0         |          |
>             |                                   |           |          |
> (mc pcie    |microchip platform event interrupt |           |          |
> int line)   |                                   |           |          |
> ------------|                                   |           |          |
>             |                                   |10         |          |
>             +-----------------------------------+-----------+----------+
>             | PLDA host DMA interrupt           |11         |          |
>             | (int number is not fixed, defined |           |          |
>             |  by vendor)                       |14         |          |
>          +--+-----------------------------------+---------- +----------+-+
>          |  |  PLDA event interrupt             |15         |0         | |
>          |  |  (int number is fixed)            |           |          | |
> ---------|--|                                   |           |          | |
> (Starfive|  |                                   |           |          | |
> pcie int |  |   +------------------+            |           |          | |
> line)    |  |   |INTx event domain |            |           |          | |
>          |  |   +------------------+            |           |          | |
>          |  |                                   |           |          | |
>          |  |   +------------------+            |           |          | |
>          |  |   |MSI event domain  |            |           |          | |
>          |  |   +------------------+            |           |          | |
>          |  |                                   |27         |12        | |
>          |  +---------------------------------+-+-----------+----------+ |
>          | extract PLDA event part to common PLDA file.                  |
>          +---------------------------------------------------------------+
> 
> 
> >> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> >> > index fd0d92c3d03f..ff40c1622173 100644
> >> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> >> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> >> > @@ -771,6 +771,63 @@ static struct irq_chip mc_event_irq_chip = {
> >> >  	.irq_unmask = mc_unmask_event_irq,
> >> >  };
> >> > > +static u32 plda_hwirq_to_mask(int hwirq)
> >> > +{
> >> > +	u32 mask;
> >> > +
> >> > +	if (hwirq < EVENT_PM_MSI_INT_INTX)
> >> > +		mask = BIT(hwirq + A_ATR_EVT_POST_ERR_SHIFT);
> >> > +	else if (hwirq == EVENT_PM_MSI_INT_INTX)
> >> > +		mask = PM_MSI_INT_INTX_MASK;
> >> > +	else
> >> > +		mask = BIT(hwirq + PM_MSI_TO_MASK_OFFSET);
> >> > +
> >> > +	return mask;
> >> > +}
> >> > +
> >> > +static void plda_ack_event_irq(struct irq_data *data)
> >> > +{
> >> > +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
> >> > +
> >> > +	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
> >> > +		       port->bridge_addr + ISTATUS_LOCAL);
> >> > +}
> >> > +
> >> > +static void plda_mask_event_irq(struct irq_data *data)
> >> > +{
> >> > +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
> >> > +	u32 mask, val;
> >> > +
> >> > +	mask = plda_hwirq_to_mask(data->hwirq);
> >> > +
> >> > +	raw_spin_lock(&port->lock);
> >> > +	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
> >> > +	val &= ~mask;
> >> > +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
> >> > +	raw_spin_unlock(&port->lock);
> >> > +}
> >> > +
> >> > +static void plda_unmask_event_irq(struct irq_data *data)
> >> > +{
> >> > +	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
> >> > +	u32 mask, val;
> >> > +
> >> > +	mask = plda_hwirq_to_mask(data->hwirq);
> >> > +
> >> > +	raw_spin_lock(&port->lock);
> >> > +	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
> >> > +	val |= mask;
> >> > +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
> >> > +	raw_spin_unlock(&port->lock);
> >> > +}
> >> > +
> >> > +static struct irq_chip plda_event_irq_chip = {
> >> > +	.name = "PLDA PCIe EVENT",
> >> > +	.irq_ack = plda_ack_event_irq,
> >> > +	.irq_mask = plda_mask_event_irq,
> >> > +	.irq_unmask = plda_unmask_event_irq,
> >> > +};
> >> > +
> >> >  static const struct plda_event_ops plda_event_ops = {
> >> >  	.get_events = plda_get_events,
> >> >  };
> >> > @@ -778,7 +835,9 @@ static const struct plda_event_ops plda_event_ops = {
> >> >  static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
> >> >  			       irq_hw_number_t hwirq)
> >> >  {
> >> > -	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
> >> > +	struct plda_pcie_rp *port = (void *)domain->host_data;
> >> > +
> >> > +	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_irq);
> >> >  	irq_set_chip_data(irq, domain->host_data);
> >> >  
> >> >  	return 0;
> >> > @@ -963,6 +1022,9 @@ static int plda_init_interrupts(struct platform_device *pdev,
> >> >  	if (!port->event_ops)
> >> >  		port->event_ops = &plda_event_ops;
> >> >  
> >> > +	if (!port->event_irq_chip)
> >> > +		port->event_irq_chip = &plda_event_irq_chip;
> >> > +
> >> >  	ret = plda_pcie_init_irq_domains(port);
> >> >  	if (ret) {
> >> >  		dev_err(dev, "failed creating IRQ domains\n");
> >> > @@ -1040,6 +1102,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
> >> >  		return ret;
> >> >  
> >> >  	port->plda.event_ops = &mc_event_ops;
> >> > +	port->plda.event_irq_chip = &mc_event_irq_chip;
> >> >  
> >> >  	/* Address translation is up; safe to enable interrupts */
> >> >  	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
> >> > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> >> > index dd8bc2750bfc..24ac50c458dc 100644
> >> > --- a/drivers/pci/controller/plda/pcie-plda.h
> >> > +++ b/drivers/pci/controller/plda/pcie-plda.h
> >> > @@ -128,6 +128,8 @@
> >> >   * DMA end : reserved for vendor implement
> >> >   */
> >> >  
> >> > +#define PM_MSI_TO_MASK_OFFSET			19
> >> > +
> >> >  struct plda_pcie_rp;
> >> >  
> >> >  struct plda_event_ops {
> >> > @@ -150,6 +152,7 @@ struct plda_pcie_rp {
> >> >  	raw_spinlock_t lock;
> >> >  	struct plda_msi msi;
> >> >  	const struct plda_event_ops *event_ops;
> >> > +	const struct irq_chip *event_irq_chip;
> >> >  	void __iomem *bridge_addr;
> >> >  	int num_events;
> >> >  };

