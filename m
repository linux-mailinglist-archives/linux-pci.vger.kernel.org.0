Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E9305C7D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 14:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbhA0NHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 08:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238066AbhA0NGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 08:06:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A304C2079A;
        Wed, 27 Jan 2021 13:05:24 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l4kVe-00ANT7-Kt; Wed, 27 Jan 2021 13:05:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Jan 2021 13:05:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v7,5/7] PCI: mediatek-gen3: Add MSI support
In-Reply-To: <1611750706.14672.54.camel@mhfsdcap03>
References: <20210113114001.5804-1-jianjun.wang@mediatek.com>
 <20210113114001.5804-6-jianjun.wang@mediatek.com>
 <661df220100e0d4e69f5cde90c083f4a@kernel.org>
 <1611750706.14672.54.camel@mhfsdcap03>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <210ce8009aedbea1660e1c5e1f8ebce9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jianjun.wang@mediatek.com, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, ryder.lee@mediatek.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sj.huang@mediatek.com, youlin.pei@mediatek.com, chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com, sin_jieyang@mediatek.com, drinkcat@chromium.org, Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-27 12:31, Jianjun Wang wrote:
> On Tue, 2021-01-26 at 13:57 +0000, Marc Zyngier wrote:
>> On 2021-01-13 11:39, Jianjun Wang wrote:
>> > Add MSI support for MediaTek Gen3 PCIe controller.
>> >
>> > This PCIe controller supports up to 256 MSI vectors, the MSI hardware
>> > block diagram is as follows:
>> >
>> >                   +-----+
>> >                   | GIC |
>> >                   +-----+
>> >                      ^
>> >                      |
>> >                  port->irq
>> >                      |
>> >              +-+-+-+-+-+-+-+-+
>> >              |0|1|2|3|4|5|6|7| (PCIe intc)
>> >              +-+-+-+-+-+-+-+-+
>> >               ^ ^           ^
>> >               | |    ...    |
>> >       +-------+ +------+    +-----------+
>> >       |                |                |
>> > +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
>> > |0|1|...|30|31|  |0|1|...|30|31|  |0|1|...|30|31| (MSI sets)
>> > +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
>> >  ^ ^      ^  ^    ^ ^      ^  ^    ^ ^      ^  ^
>> >  | |      |  |    | |      |  |    | |      |  |  (MSI vectors)
>> >  | |      |  |    | |      |  |    | |      |  |
>> >
>> >   (MSI SET0)       (MSI SET1)  ...   (MSI SET7)
>> >
>> > With 256 MSI vectors supported, the MSI vectors are composed of 8 sets,
>> > each set has its own address for MSI message, and supports 32 MSI
>> > vectors
>> > to generate interrupt.
>> >
>> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
>> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
>> > ---
>> >  drivers/pci/controller/pcie-mediatek-gen3.c | 261 ++++++++++++++++++++
>> >  1 file changed, 261 insertions(+)
>> >
>> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
>> > b/drivers/pci/controller/pcie-mediatek-gen3.c
>> > index 7979a2856c35..471d97cd1ef9 100644
>> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> > @@ -14,6 +14,7 @@
>> >  #include <linux/irqdomain.h>
>> >  #include <linux/kernel.h>
>> >  #include <linux/module.h>
>> > +#include <linux/msi.h>
>> >  #include <linux/of_address.h>
>> >  #include <linux/of_clk.h>
>> >  #include <linux/of_pci.h>
>> > @@ -52,11 +53,28 @@
>> >  #define PCIE_LINK_STATUS_REG		0x154
>> >  #define PCIE_PORT_LINKUP		BIT(8)
>> >
>> > +#define PCIE_MSI_SET_NUM		8
>> > +#define PCIE_MSI_IRQS_PER_SET		32
>> > +#define PCIE_MSI_IRQS_NUM \
>> > +	(PCIE_MSI_IRQS_PER_SET * (PCIE_MSI_SET_NUM))
>> 
>> Spurious inner bracketing.
>> 
>> > +
>> >  #define PCIE_INT_ENABLE_REG		0x180
>> > +#define PCIE_MSI_ENABLE			GENMASK(PCIE_MSI_SET_NUM + 8 - 1, 8)
>> > +#define PCIE_MSI_SHIFT			8
>> >  #define PCIE_INTX_SHIFT			24
>> >  #define PCIE_INTX_MASK			GENMASK(27, 24)
>> >
>> >  #define PCIE_INT_STATUS_REG		0x184
>> > +#define PCIE_MSI_SET_ENABLE_REG		0x190
>> > +#define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
>> > +
>> > +#define PCIE_MSI_SET_BASE_REG		0xc00
>> > +#define PCIE_MSI_SET_OFFSET		0x10
>> > +#define PCIE_MSI_SET_STATUS_OFFSET	0x04
>> > +#define PCIE_MSI_SET_ENABLE_OFFSET	0x08
>> > +
>> > +#define PCIE_MSI_SET_ADDR_HI_BASE	0xc80
>> > +#define PCIE_MSI_SET_ADDR_HI_OFFSET	0x04
>> >
>> >  #define PCIE_TRANS_TABLE_BASE_REG	0x800
>> >  #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
>> > @@ -76,6 +94,18 @@
>> >  #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
>> >  #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
>> >
>> > +/**
>> > + * struct mtk_pcie_msi - MSI information for each set
>> > + * @dev: pointer to PCIe device
>> > + * @base: IO mapped register base
>> > + * @msg_addr: MSI message address
>> > + */
>> > +struct mtk_msi_set {
>> > +	struct device *dev;
>> > +	void __iomem *base;
>> > +	phys_addr_t msg_addr;
>> > +};
>> > +
>> >  /**
>> >   * struct mtk_pcie_port - PCIe port information
>> >   * @dev: pointer to PCIe device
>> > @@ -88,6 +118,11 @@
>> >   * @num_clks: PCIe clocks count for this port
>> >   * @irq: PCIe controller interrupt number
>> >   * @intx_domain: legacy INTx IRQ domain
>> > + * @msi_domain: MSI IRQ domain
>> > + * @msi_bottom_domain: MSI IRQ bottom domain
>> > + * @msi_sets: MSI sets information
>> > + * @lock: lock protecting IRQ bit map
>> > + * @msi_irq_in_use: bit map for assigned MSI IRQ
>> >   */
>> >  struct mtk_pcie_port {
>> >  	struct device *dev;
>> > @@ -101,6 +136,11 @@ struct mtk_pcie_port {
>> >
>> >  	int irq;
>> >  	struct irq_domain *intx_domain;
>> > +	struct irq_domain *msi_domain;
>> > +	struct irq_domain *msi_bottom_domain;
>> > +	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
>> > +	struct mutex lock;
>> > +	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
>> >  };
>> >
>> >  /**
>> > @@ -243,6 +283,15 @@ static int mtk_pcie_startup_port(struct
>> > mtk_pcie_port *port)
>> >  		return err;
>> >  	}
>> >
>> > +	/* Enable MSI */
>> > +	val = readl_relaxed(port->base + PCIE_MSI_SET_ENABLE_REG);
>> > +	val |= PCIE_MSI_SET_ENABLE;
>> > +	writel_relaxed(val, port->base + PCIE_MSI_SET_ENABLE_REG);
>> > +
>> > +	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
>> > +	val |= PCIE_MSI_ENABLE;
>> > +	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
>> > +
>> >  	/* Set PCIe translation windows */
>> >  	resource_list_for_each_entry(entry, &host->windows) {
>> >  		struct resource *res = entry->res;
>> > @@ -286,6 +335,129 @@ static int mtk_pcie_set_affinity(struct irq_data
>> > *data,
>> >  	return -EINVAL;
>> >  }
>> >
>> > +static struct irq_chip mtk_msi_irq_chip = {
>> > +	.name = "MSI",
>> > +	.irq_ack = irq_chip_ack_parent,
>> > +};
>> > +
>> > +static struct msi_domain_info mtk_msi_domain_info = {
>> > +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_PCI_MSIX |
>> > +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI),
>> > +	.chip		= &mtk_msi_irq_chip,
>> > +};
>> > +
>> > +static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg
>> > *msg)
>> > +{
>> > +	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
>> > +	unsigned long hwirq;
>> > +
>> > +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
>> > +
>> > +	msg->address_hi = upper_32_bits(msi_set->msg_addr);
>> > +	msg->address_lo = lower_32_bits(msi_set->msg_addr);
>> > +	msg->data = hwirq;
>> > +	dev_dbg(msi_set->dev, "msi#%#lx address_hi %#x address_lo %#x data
>> > %d\n",
>> > +		hwirq, msg->address_hi, msg->address_lo, msg->data);
>> > +}
>> > +
>> > +static void mtk_msi_bottom_irq_ack(struct irq_data *data)
>> > +{
>> > +	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
>> > +	unsigned long hwirq;
>> > +
>> > +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
>> > +
>> > +	writel_relaxed(BIT(hwirq), msi_set->base +
>> > PCIE_MSI_SET_STATUS_OFFSET);
>> > +}
>> > +
>> > +static struct irq_chip mtk_msi_bottom_irq_chip = {
>> > +	.irq_ack		= mtk_msi_bottom_irq_ack,
>> > +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
>> > +	.irq_set_affinity	= mtk_pcie_set_affinity,
>> > +	.name			= "PCIe",
>> 
>> nit: "MSI", rather than "PCIe".
>> 
>> > +};
>> > +
>> > +static int mtk_msi_bottom_domain_alloc(struct irq_domain *domain,
>> > +				       unsigned int virq, unsigned int nr_irqs,
>> > +				       void *arg)
>> > +{
>> > +	struct mtk_pcie_port *port = domain->host_data;
>> > +	struct mtk_msi_set *msi_set;
>> > +	int i, hwirq, set_idx;
>> > +
>> > +	mutex_lock(&port->lock);
>> > +
>> > +	hwirq = bitmap_find_free_region(port->msi_irq_in_use,
>> > PCIE_MSI_IRQS_NUM,
>> > +					order_base_2(nr_irqs));
>> > +
>> > +	mutex_unlock(&port->lock);
>> > +
>> > +	if (hwirq < 0)
>> > +		return -ENOSPC;
>> > +
>> > +	set_idx = hwirq / PCIE_MSI_IRQS_PER_SET;
>> > +	msi_set = &port->msi_sets[set_idx];
>> > +
>> > +	for (i = 0; i < nr_irqs; i++)
>> > +		irq_domain_set_info(domain, virq + i, hwirq + i,
>> > +				    &mtk_msi_bottom_irq_chip, msi_set,
>> > +				    handle_edge_irq, NULL, NULL);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static void mtk_msi_bottom_domain_free(struct irq_domain *domain,
>> > +				       unsigned int virq, unsigned int nr_irqs)
>> > +{
>> > +	struct mtk_pcie_port *port = domain->host_data;
>> > +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
>> > +
>> > +	mutex_lock(&port->lock);
>> > +
>> > +	bitmap_clear(port->msi_irq_in_use, data->hwirq, nr_irqs);
>> > +
>> > +	mutex_unlock(&port->lock);
>> > +
>> > +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>> > +}
>> > +
>> > +static int mtk_msi_bottom_domain_activate(struct irq_domain *domain,
>> > +					  struct irq_data *data, bool reserve)
>> > +{
>> > +	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
>> > +	unsigned long hwirq;
>> > +	u32 val;
>> > +
>> > +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
>> > +
>> > +	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
>> > +	val |= BIT(hwirq);
>> > +	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
>> 
>> This isn't an activate. This is an unmask, which suffers from the same
>> issue as its INTx sibling.
>> 
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static void mtk_msi_bottom_domain_deactivate(struct irq_domain
>> > *domain,
>> > +					     struct irq_data *data)
>> > +{
>> > +	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
>> > +	unsigned long hwirq;
>> > +	u32 val;
>> > +
>> > +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
>> > +
>> > +	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
>> > +	val &= ~BIT(hwirq);
>> > +	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
>> > +}
>> 
>> Same thing, this is a mask. I don't think this block requires any
>> activate/deactivate callbacks for its lower irqdomain.
>> 
>> As it stands, you can't mask a MSI at the low-level, which is
>> pretty bad (you need to mask them at the PCI source, which can
>> end-up disabling all vectors in the case of Multi-MSI).
> 
> Hi Marc,
> 
> Thanks for your review.
> 
> This mtk_msi_bottom_domain is the parent domain of pci_msi_domain, but
> the mask/unmask callback of pci_msi_domain does not call the callback 
> of
> its parent. Therefore if these functions are put in the mask/unmask
> callbacks, they will not have a chance to be called.

It is for you to wire the callbacks in the mtk_msi_irq_chip irqchip
so that the request can be forwarded to the parent, without relying
on the default callbacks:

static void mtk_mask_msi_irq(struct irq_data *d)
{
	pci_msi_mask_irq(d);
	irq_chip_mask_parent(d);
}

static void mtk_unmask_msi_irq(struct irq_data *d)
{
	pci_msi_unmask_irq(d);
	irq_chip_unmask_parent(d);
}

static struct irq_chip mtk_msi_irq_chip = {
        .name = "MSI",
        .irq_mask = mtk_mask_msi_irq,
        .irq_unmask = mtk_unmask_msi_irq,
        .irq_ack = irq_chip_ack_parent,
};

and turn your activate/deactivate into unmask/mask.

>> 
>> > +
>> > +static const struct irq_domain_ops mtk_msi_bottom_domain_ops = {
>> > +	.alloc = mtk_msi_bottom_domain_alloc,
>> > +	.free = mtk_msi_bottom_domain_free,
>> > +	.activate = mtk_msi_bottom_domain_activate,
>> > +	.deactivate = mtk_msi_bottom_domain_deactivate,
>> > +};
>> > +
>> >  static void mtk_intx_mask(struct irq_data *data)
>> >  {
>> >  	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
>> > @@ -350,6 +522,9 @@ static int mtk_pcie_init_irq_domains(struct
>> > mtk_pcie_port *port,
>> >  {
>> >  	struct device *dev = port->dev;
>> >  	struct device_node *intc_node;
>> > +	struct fwnode_handle *fwnode = of_node_to_fwnode(node);
>> > +	struct msi_domain_info *info;
>> > +	int i, ret;
>> >
>> >  	/* Setup INTx */
>> >  	intc_node = of_get_child_by_name(node, "interrupt-controller");
>> > @@ -365,7 +540,57 @@ static int mtk_pcie_init_irq_domains(struct
>> > mtk_pcie_port *port,
>> >  		return -ENODEV;
>> >  	}
>> >
>> > +	/* Setup MSI */
>> > +	mutex_init(&port->lock);
>> > +
>> > +	port->msi_bottom_domain = irq_domain_add_linear(node,
>> > PCIE_MSI_IRQS_NUM,
>> > +				  &mtk_msi_bottom_domain_ops, port);
>> > +	if (!port->msi_bottom_domain) {
>> > +		dev_info(dev, "failed to create MSI bottom domain\n");
>> > +		ret = -ENODEV;
>> > +		goto err_msi_bottom_domain;
>> > +	}
>> > +
>> > +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> > +	if (!info) {
>> > +		ret = -ENOMEM;
>> > +		goto err_msi_bottom_domain;
>> > +	}
>> > +
>> > +	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
>> 
>> Why the memcpy()? There is nothing in mtk_msi_domain_info that is
>> per-domain, and you should be able to use this structure for all
>> ports, shouldn't you?
> 
> Yes, it used to update the info->chip_data for each port, but since the
> msi_set has been used for msi_bottom_domain ,it has no effect anymore, 
> I
> will drop it in the next version, thanks.
>> 
>> > +	info->chip_data = port;
>> > +
>> > +	port->msi_domain = pci_msi_create_irq_domain(fwnode, info,
>> > +						     port->msi_bottom_domain);
>> > +	if (!port->msi_domain) {
>> > +		dev_info(dev, "failed to create MSI domain\n");
>> > +		ret = -ENODEV;
>> > +		goto err_msi_domain;
>> > +	}
>> > +
>> > +	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
>> > +		struct mtk_msi_set *msi_set = &port->msi_sets[i];
>> > +
>> > +		msi_set->dev = port->dev;
>> 
>> Given that this is only used in a debug message, and that the 
>> addresses
>> are already non-ambiguous, you can probably remove this field.
> 
> OK, I will remove it in the next version.
> 
>> 
>> > +		msi_set->base = port->base + PCIE_MSI_SET_BASE_REG +
>> > +				i * PCIE_MSI_SET_OFFSET;
>> > +		msi_set->msg_addr = port->reg_base + PCIE_MSI_SET_BASE_REG +
>> > +				    i * PCIE_MSI_SET_OFFSET;
>> > +
>> > +		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
>> > +		writel_relaxed(upper_32_bits(msi_set->msg_addr),
>> > +			       port->base + PCIE_MSI_SET_ADDR_HI_BASE +
>> > +			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);
>> 
>> Please a comment on what this is doing...
> 
> This codes are used to configure the capture address of each MSI set,
> the lower 32 bits of MSI address should be written to msi_set->base, 
> but
> the strange thing is that the address where need to write the higher 32
> bits are not near each set, they are start from
> PCIE_MSI_SET_ADDR_HI_BASE, and have PCIE_MSI_SET_ADDR_HI_OFFSET apart.
> 
> That's why it looks so weired...

OK. Just add a comment saying that this programs the MSI capture 
address.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
