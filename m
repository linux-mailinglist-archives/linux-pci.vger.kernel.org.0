Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01487BE248
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjJIOPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjJIOPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 10:15:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43649C;
        Mon,  9 Oct 2023 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696860947; x=1728396947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IhzK3duzX5Q6yCOph3/oGnySaf5b1o5e0X7ExSdftU=;
  b=oMDGIB0ZD5vLxGMMa63sHJ25lzkOZE3Kjlpg4FtqgAmY+FIVWM6Y45OM
   ulzruH+J+bvxxBGmPk5Zc9t/zv/Fe+BSGGiEyCQ83noSnLAL+wWwiSAVQ
   6XJN2SVfpyo8qF5dJW5r8MXBngZEJP2DyDktlQO7N1sxQ2QuuOCsEH1rq
   p+Fs75H8VLzP0twBFO0xDeulrw3quwaTBDWkux7NGZD7AtbtlD/sRENfQ
   2x2ph6rdFBNnG47XpT4IKHksLHKFfxIYy+mpUiAJXZs+ljqL7CKrhACnL
   P+/RIysq/1oYJPYNq/6SJWW9y/GTVLHfUcUgZDpa8oi317oKvGGxiHgKY
   w==;
X-CSE-ConnectionGUID: s0PWYqtQTGCWC+1qamY5Mg==
X-CSE-MsgGUID: 0cNllYBpQ8Sn+U0LxmQUNg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="asc'?scan'208";a="9742329"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 06:56:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 06:56:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 06:56:30 -0700
Date:   Mon, 9 Oct 2023 14:56:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v7 15/19] PCI: microchip: Move IRQ functions to
 pcie-plda-host.c
Message-ID: <20231009-professor-serving-4d4a004b1333@wendy>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
 <20230927100802.46620-16-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubv8tug+K2nCx7Kb"
Content-Disposition: inline
In-Reply-To: <20230927100802.46620-16-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--ubv8tug+K2nCx7Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 27, 2023 at 06:07:58PM +0800, Minda Chen wrote:
> Move IRQ functions to pcie-plda-host.c.
> Including MSI, INTx, event interrupts and IRQ
> init functions.

Same comments about missing motivation for the changes in the commit
message. This just gives a summary of what's being done, without
mentioning the why.

> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Otherwise:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 364 -----------------
>  drivers/pci/controller/plda/pcie-plda-host.c  | 365 ++++++++++++++++++
>  drivers/pci/controller/plda/pcie-plda.h       |   3 +
>  3 files changed, 368 insertions(+), 364 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index 49e09d24eb8f..016915d42f73 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -317,240 +317,6 @@ static void mc_pcie_enable_msi(struct mc_pcie *port=
, void __iomem *ecam)
>  		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
>  }
> =20
> -static void plda_handle_msi(struct irq_desc *desc)
> -{
> -	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> -	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> -	struct device *dev =3D port->dev;
> -	struct plda_msi *msi =3D &port->msi;
> -	void __iomem *bridge_base_addr =3D port->bridge_addr;
> -	unsigned long status;
> -	u32 bit;
> -	int ret;
> -
> -	chained_irq_enter(chip, desc);
> -
> -	status =3D readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> -	if (status & PM_MSI_INT_MSI_MASK) {
> -		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATU=
S_LOCAL);
> -		status =3D readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> -		for_each_set_bit(bit, &status, msi->num_vectors) {
> -			ret =3D generic_handle_domain_irq(msi->dev_domain, bit);
> -			if (ret)
> -				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
> -						    bit);
> -		}
> -	}
> -
> -	chained_irq_exit(chip, desc);
> -}
> -
> -static void plda_msi_bottom_irq_ack(struct irq_data *data)
> -{
> -	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D port->bridge_addr;
> -	u32 bitpos =3D data->hwirq;
> -
> -	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> -}
> -
> -static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
> -{
> -	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> -	phys_addr_t addr =3D port->msi.vector_phy;
> -
> -	msg->address_lo =3D lower_32_bits(addr);
> -	msg->address_hi =3D upper_32_bits(addr);
> -	msg->data =3D data->hwirq;
> -
> -	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
> -		(int)data->hwirq, msg->address_hi, msg->address_lo);
> -}
> -
> -static int plda_msi_set_affinity(struct irq_data *irq_data,
> -				 const struct cpumask *mask, bool force)
> -{
> -	return -EINVAL;
> -}
> -
> -static struct irq_chip plda_msi_bottom_irq_chip =3D {
> -	.name =3D "PLDA MSI",
> -	.irq_ack =3D plda_msi_bottom_irq_ack,
> -	.irq_compose_msi_msg =3D plda_compose_msi_msg,
> -	.irq_set_affinity =3D plda_msi_set_affinity,
> -};
> -
> -static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned=
 int virq,
> -				     unsigned int nr_irqs, void *args)
> -{
> -	struct plda_pcie_rp *port =3D domain->host_data;
> -	struct plda_msi *msi =3D &port->msi;
> -	unsigned long bit;
> -
> -	mutex_lock(&msi->lock);
> -	bit =3D find_first_zero_bit(msi->used, msi->num_vectors);
> -	if (bit >=3D msi->num_vectors) {
> -		mutex_unlock(&msi->lock);
> -		return -ENOSPC;
> -	}
> -
> -	set_bit(bit, msi->used);
> -
> -	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
> -			    domain->host_data, handle_edge_irq, NULL, NULL);
> -
> -	mutex_unlock(&msi->lock);
> -
> -	return 0;
> -}
> -
> -static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned=
 int virq,
> -				     unsigned int nr_irqs)
> -{
> -	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> -	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(d);
> -	struct plda_msi *msi =3D &port->msi;
> -
> -	mutex_lock(&msi->lock);
> -
> -	if (test_bit(d->hwirq, msi->used))
> -		__clear_bit(d->hwirq, msi->used);
> -	else
> -		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
> -
> -	mutex_unlock(&msi->lock);
> -}
> -
> -static const struct irq_domain_ops msi_domain_ops =3D {
> -	.alloc	=3D plda_irq_msi_domain_alloc,
> -	.free	=3D plda_irq_msi_domain_free,
> -};
> -
> -static struct irq_chip plda_msi_irq_chip =3D {
> -	.name =3D "PLDA PCIe MSI",
> -	.irq_ack =3D irq_chip_ack_parent,
> -	.irq_mask =3D pci_msi_mask_irq,
> -	.irq_unmask =3D pci_msi_unmask_irq,
> -};
> -
> -static struct msi_domain_info plda_msi_domain_info =3D {
> -	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		  MSI_FLAG_PCI_MSIX),
> -	.chip =3D &plda_msi_irq_chip,
> -};
> -
> -static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
> -{
> -	struct device *dev =3D port->dev;
> -	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
> -	struct plda_msi *msi =3D &port->msi;
> -
> -	mutex_init(&port->msi.lock);
> -
> -	msi->dev_domain =3D irq_domain_add_linear(NULL, msi->num_vectors,
> -						&msi_domain_ops, port);
> -	if (!msi->dev_domain) {
> -		dev_err(dev, "failed to create IRQ domain\n");
> -		return -ENOMEM;
> -	}
> -
> -	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode, &plda_msi_domain_=
info,
> -						    msi->dev_domain);
> -	if (!msi->msi_domain) {
> -		dev_err(dev, "failed to create MSI domain\n");
> -		irq_domain_remove(msi->dev_domain);
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
> -static void plda_handle_intx(struct irq_desc *desc)
> -{
> -	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> -	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> -	struct device *dev =3D port->dev;
> -	void __iomem *bridge_base_addr =3D port->bridge_addr;
> -	unsigned long status;
> -	u32 bit;
> -	int ret;
> -
> -	chained_irq_enter(chip, desc);
> -
> -	status =3D readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> -	if (status & PM_MSI_INT_INTX_MASK) {
> -		status &=3D PM_MSI_INT_INTX_MASK;
> -		status >>=3D PM_MSI_INT_INTX_SHIFT;
> -		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> -			ret =3D generic_handle_domain_irq(port->intx_domain, bit);
> -			if (ret)
> -				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
> -						    bit);
> -		}
> -	}
> -
> -	chained_irq_exit(chip, desc);
> -}
> -
> -static void plda_ack_intx_irq(struct irq_data *data)
> -{
> -	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D port->bridge_addr;
> -	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> -
> -	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
> -}
> -
> -static void plda_mask_intx_irq(struct irq_data *data)
> -{
> -	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D port->bridge_addr;
> -	unsigned long flags;
> -	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> -	u32 val;
> -
> -	raw_spin_lock_irqsave(&port->lock, flags);
> -	val =3D readl_relaxed(bridge_base_addr + IMASK_LOCAL);
> -	val &=3D ~mask;
> -	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
> -	raw_spin_unlock_irqrestore(&port->lock, flags);
> -}
> -
> -static void plda_unmask_intx_irq(struct irq_data *data)
> -{
> -	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> -	void __iomem *bridge_base_addr =3D port->bridge_addr;
> -	unsigned long flags;
> -	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> -	u32 val;
> -
> -	raw_spin_lock_irqsave(&port->lock, flags);
> -	val =3D readl_relaxed(bridge_base_addr + IMASK_LOCAL);
> -	val |=3D mask;
> -	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
> -	raw_spin_unlock_irqrestore(&port->lock, flags);
> -}
> -
> -static struct irq_chip plda_intx_irq_chip =3D {
> -	.name =3D "PLDA PCIe INTx",
> -	.irq_ack =3D plda_ack_intx_irq,
> -	.irq_mask =3D plda_mask_intx_irq,
> -	.irq_unmask =3D plda_unmask_intx_irq,
> -};
> -
> -static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int ir=
q,
> -			      irq_hw_number_t hwirq)
> -{
> -	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops intx_domain_ops =3D {
> -	.map =3D plda_pcie_intx_map,
> -};
> -
>  static inline u32 reg_to_event(u32 reg, struct event_map field)
>  {
>  	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
> @@ -637,23 +403,6 @@ static irqreturn_t mc_event_handler(int irq, void *d=
ev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> -static void plda_handle_event(struct irq_desc *desc)
> -{
> -	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> -	unsigned long events;
> -	u32 bit;
> -	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> -
> -	chained_irq_enter(chip, desc);
> -
> -	events =3D port->event_ops->get_events(port);
> -
> -	for_each_set_bit(bit, &events, port->num_events)
> -		generic_handle_domain_irq(port->event_domain, bit);
> -
> -	chained_irq_exit(chip, desc);
> -}
> -
>  static void mc_ack_event_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> @@ -817,47 +566,6 @@ static const struct plda_event mc_event =3D {
>  	.msi_event              =3D EVENT_LOCAL_PM_MSI_INT_MSI,
>  };
> =20
> -static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> -				      const struct irq_domain_ops *ops)
> -{
> -	struct device *dev =3D port->dev;
> -	struct device_node *node =3D dev->of_node;
> -	struct device_node *pcie_intc_node;
> -
> -	/* Setup INTx */
> -	pcie_intc_node =3D of_get_next_child(node, NULL);
> -	if (!pcie_intc_node) {
> -		dev_err(dev, "failed to find PCIe Intc node\n");
> -		return -EINVAL;
> -	}
> -
> -	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, port->num_=
events,
> -						   ops, port);
> -
> -	if (!port->event_domain) {
> -		dev_err(dev, "failed to get event domain\n");
> -		of_node_put(pcie_intc_node);
> -		return -ENOMEM;
> -	}
> -
> -	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
> -
> -	port->intx_domain =3D irq_domain_add_linear(pcie_intc_node, PCI_NUM_INT=
X,
> -						  &intx_domain_ops, port);
> -	if (!port->intx_domain) {
> -		dev_err(dev, "failed to get an INTx IRQ domain\n");
> -		of_node_put(pcie_intc_node);
> -		return -ENOMEM;
> -	}
> -
> -	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
> -
> -	of_node_put(pcie_intc_node);
> -	raw_spin_lock_init(&port->lock);
> -
> -	return plda_allocate_msi_domains(port);
> -}
> -
>  static inline void mc_clear_secs(struct mc_pcie *port)
>  {
>  	void __iomem *ctrl_base_addr =3D port->axi_base_addr + MC_PCIE_CTRL_ADD=
R;
> @@ -918,78 +626,6 @@ static void mc_disable_interrupts(struct mc_pcie *po=
rt)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
> =20
> -static int plda_init_interrupts(struct platform_device *pdev,
> -				struct plda_pcie_rp *port,
> -				const struct plda_event *event)
> -{
> -	struct device *dev =3D &pdev->dev;
> -	int irq;
> -	int i, intx_irq, msi_irq, event_irq;
> -	int ret;
> -	const struct irq_domain_ops *irq_dom_ops;
> -
> -	if (!event->event_ops || !event->event_ops->get_events) {
> -		dev_err(dev, "no get events ops\n");
> -		return -EINVAL;
> -	}
> -
> -	irq_dom_ops =3D event->domain_ops ? event->domain_ops : &mc_event_domai=
n_ops;
> -
> -	ret =3D plda_pcie_init_irq_domains(port, irq_dom_ops);
> -	if (ret) {
> -		dev_err(dev, "failed creating IRQ domains\n");
> -		return ret;
> -	}
> -
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return -ENODEV;
> -
> -	port->event_ops =3D event->event_ops;
> -
> -	for (i =3D 0; i < port->num_events; i++) {
> -		event_irq =3D irq_create_mapping(port->event_domain, i);
> -		if (!event_irq) {
> -			dev_err(dev, "failed to map hwirq %d\n", i);
> -			return -ENXIO;
> -		}
> -
> -		if (event->request_event_irq)
> -			ret =3D event->request_event_irq(port, event_irq, i);
> -		else
> -			ret =3D devm_request_irq(dev, event_irq, plda_event_handler,
> -					       0, NULL, port);
> -
> -		if (ret) {
> -			dev_err(dev, "failed to request IRQ %d\n", event_irq);
> -			return ret;
> -		}
> -	}
> -
> -	intx_irq =3D irq_create_mapping(port->event_domain,
> -				      event->intx_event);
> -	if (!intx_irq) {
> -		dev_err(dev, "failed to map INTx interrupt\n");
> -		return -ENXIO;
> -	}
> -
> -	/* Plug the INTx chained handler */
> -	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
> -
> -	msi_irq =3D irq_create_mapping(port->event_domain,
> -				     event->msi_event);
> -	if (!msi_irq)
> -		return -ENXIO;
> -
> -	/* Plug the MSI chained handler */
> -	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
> -
> -	/* Plug the main event chained handler */
> -	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
> -
> -	return 0;
> -}
> -
>  static int mc_platform_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev =3D cfg->parent;
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/c=
ontroller/plda/pcie-plda-host.c
> index 197eda731c71..c73953bcd1f8 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -20,6 +20,240 @@
> =20
>  #include "pcie-plda.h"
> =20
> +static void plda_handle_msi(struct irq_desc *desc)
> +{
> +	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	struct device *dev =3D port->dev;
> +	struct plda_msi *msi =3D &port->msi;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	unsigned long status;
> +	u32 bit;
> +	int ret;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	status =3D readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> +	if (status & PM_MSI_INT_MSI_MASK) {
> +		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATU=
S_LOCAL);
> +		status =3D readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> +		for_each_set_bit(bit, &status, msi->num_vectors) {
> +			ret =3D generic_handle_domain_irq(msi->dev_domain, bit);
> +			if (ret)
> +				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
> +						    bit);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void plda_msi_bottom_irq_ack(struct irq_data *data)
> +{
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	u32 bitpos =3D data->hwirq;
> +
> +	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> +}
> +
> +static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
> +{
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	phys_addr_t addr =3D port->msi.vector_phy;
> +
> +	msg->address_lo =3D lower_32_bits(addr);
> +	msg->address_hi =3D upper_32_bits(addr);
> +	msg->data =3D data->hwirq;
> +
> +	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
> +}
> +
> +static int plda_msi_set_affinity(struct irq_data *irq_data,
> +				 const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip plda_msi_bottom_irq_chip =3D {
> +	.name =3D "PLDA MSI",
> +	.irq_ack =3D plda_msi_bottom_irq_ack,
> +	.irq_compose_msi_msg =3D plda_compose_msi_msg,
> +	.irq_set_affinity =3D plda_msi_set_affinity,
> +};
> +
> +static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned=
 int virq,
> +				     unsigned int nr_irqs, void *args)
> +{
> +	struct plda_pcie_rp *port =3D domain->host_data;
> +	struct plda_msi *msi =3D &port->msi;
> +	unsigned long bit;
> +
> +	mutex_lock(&msi->lock);
> +	bit =3D find_first_zero_bit(msi->used, msi->num_vectors);
> +	if (bit >=3D msi->num_vectors) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +
> +	set_bit(bit, msi->used);
> +
> +	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
> +			    domain->host_data, handle_edge_irq, NULL, NULL);
> +
> +	mutex_unlock(&msi->lock);
> +
> +	return 0;
> +}
> +
> +static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned=
 int virq,
> +				     unsigned int nr_irqs)
> +{
> +	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(d);
> +	struct plda_msi *msi =3D &port->msi;
> +
> +	mutex_lock(&msi->lock);
> +
> +	if (test_bit(d->hwirq, msi->used))
> +		__clear_bit(d->hwirq, msi->used);
> +	else
> +		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
> +
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops =3D {
> +	.alloc	=3D plda_irq_msi_domain_alloc,
> +	.free	=3D plda_irq_msi_domain_free,
> +};
> +
> +static struct irq_chip plda_msi_irq_chip =3D {
> +	.name =3D "PLDA PCIe MSI",
> +	.irq_ack =3D irq_chip_ack_parent,
> +	.irq_mask =3D pci_msi_mask_irq,
> +	.irq_unmask =3D pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info plda_msi_domain_info =3D {
> +	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_PCI_MSIX),
> +	.chip =3D &plda_msi_irq_chip,
> +};
> +
> +static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
> +{
> +	struct device *dev =3D port->dev;
> +	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
> +	struct plda_msi *msi =3D &port->msi;
> +
> +	mutex_init(&port->msi.lock);
> +
> +	msi->dev_domain =3D irq_domain_add_linear(NULL, msi->num_vectors,
> +						&msi_domain_ops, port);
> +	if (!msi->dev_domain) {
> +		dev_err(dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode, &plda_msi_domain_=
info,
> +						    msi->dev_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->dev_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void plda_handle_intx(struct irq_desc *desc)
> +{
> +	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	struct device *dev =3D port->dev;
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	unsigned long status;
> +	u32 bit;
> +	int ret;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	status =3D readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> +	if (status & PM_MSI_INT_INTX_MASK) {
> +		status &=3D PM_MSI_INT_INTX_MASK;
> +		status >>=3D PM_MSI_INT_INTX_SHIFT;
> +		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +			ret =3D generic_handle_domain_irq(port->intx_domain, bit);
> +			if (ret)
> +				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
> +						    bit);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void plda_ack_intx_irq(struct irq_data *data)
> +{
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> +
> +	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
> +}
> +
> +static void plda_mask_intx_irq(struct irq_data *data)
> +{
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	unsigned long flags;
> +	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D readl_relaxed(bridge_base_addr + IMASK_LOCAL);
> +	val &=3D ~mask;
> +	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void plda_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	unsigned long flags;
> +	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D readl_relaxed(bridge_base_addr + IMASK_LOCAL);
> +	val |=3D mask;
> +	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip plda_intx_irq_chip =3D {
> +	.name =3D "PLDA PCIe INTx",
> +	.irq_ack =3D plda_ack_intx_irq,
> +	.irq_mask =3D plda_mask_intx_irq,
> +	.irq_unmask =3D plda_unmask_intx_irq,
> +};
> +
> +static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int ir=
q,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops =3D {
> +	.map =3D plda_pcie_intx_map,
> +};
> +
>  irqreturn_t plda_event_handler(int irq, void *dev_id)
>  {
>  	return IRQ_HANDLED;
> @@ -45,6 +279,23 @@ static u32 plda_get_events(struct plda_pcie_rp *port)
>  	return events;
>  }
> =20
> +static void plda_handle_event(struct irq_desc *desc)
> +{
> +	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	u32 bit;
> +	unsigned long events;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	events =3D port->event_ops->get_events(port);
> +
> +	for_each_set_bit(bit, &events, port->num_events)
> +		generic_handle_domain_irq(port->event_domain, bit);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
>  static u32 plda_hwirq_to_mask(int hwirq)
>  {
>  	u32 mask;
> @@ -119,6 +370,120 @@ struct plda_event_ops plda_event_ops =3D {
>  	.get_events =3D plda_get_events,
>  };
> =20
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> +				      const struct irq_domain_ops *ops)
> +{
> +	struct device *dev =3D port->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node =3D of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "failed to find PCIe Intc node\n");
> +		return -EINVAL;
> +	}
> +
> +	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, port->num_=
events,
> +						   ops, port);
> +
> +	if (!port->event_domain) {
> +		dev_err(dev, "failed to get event domain\n");
> +		of_node_put(pcie_intc_node);
> +		return -ENOMEM;
> +	}
> +
> +	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
> +
> +	port->intx_domain =3D irq_domain_add_linear(pcie_intc_node, PCI_NUM_INT=
X,
> +						  &intx_domain_ops, port);
> +	if (!port->intx_domain) {
> +		dev_err(dev, "failed to get an INTx IRQ domain\n");
> +		of_node_put(pcie_intc_node);
> +		return -ENOMEM;
> +	}
> +
> +	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
> +
> +	of_node_put(pcie_intc_node);
> +	raw_spin_lock_init(&port->lock);
> +
> +	return plda_allocate_msi_domains(port);
> +}
> +
> +int plda_init_interrupts(struct platform_device *pdev,
> +			 struct plda_pcie_rp *port,
> +			 const struct plda_event *event)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	int irq;
> +	int i, intx_irq, msi_irq, event_irq;
> +	int ret;
> +	const struct irq_domain_ops *irq_dom_ops;
> +
> +	if (!event->event_ops || !event->event_ops->get_events) {
> +		dev_err(dev, "no get events ops\n");
> +		return -EINVAL;
> +	}
> +
> +	irq_dom_ops =3D event->domain_ops ? event->domain_ops : &plda_evt_dom_o=
ps;
> +
> +	ret =3D plda_pcie_init_irq_domains(port, irq_dom_ops);
> +	if (ret) {
> +		dev_err(dev, "failed creating IRQ domains\n");
> +		return ret;
> +	}
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +
> +	port->event_ops =3D event->event_ops;
> +
> +	for (i =3D 0; i < port->num_events; i++) {
> +		event_irq =3D irq_create_mapping(port->event_domain, i);
> +		if (!event_irq) {
> +			dev_err(dev, "failed to map hwirq %d\n", i);
> +			return -ENXIO;
> +		}
> +
> +		if (event->request_event_irq)
> +			ret =3D event->request_event_irq(port, event_irq, i);
> +		else
> +			ret =3D devm_request_irq(dev, event_irq, plda_event_handler,
> +					       0, NULL, port);
> +
> +		if (ret) {
> +			dev_err(dev, "failed to request IRQ %d\n", event_irq);
> +			return ret;
> +		}
> +	}
> +
> +	intx_irq =3D irq_create_mapping(port->event_domain,
> +				      event->intx_event);
> +	if (!intx_irq) {
> +		dev_err(dev, "failed to map INTx interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
> +
> +	msi_irq =3D irq_create_mapping(port->event_domain,
> +				     event->msi_event);
> +	if (!msi_irq)
> +		return -ENXIO;
> +
> +	/* Plug the MSI chained handler */
> +	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
> +
> +	/* Plug the main event chained handler */
> +	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(plda_init_interrupts);
> +
>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>  			    size_t size)
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/contro=
ller/plda/pcie-plda.h
> index 122084a3318a..e59369f23329 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -164,6 +164,9 @@ struct plda_event {
>  };
> =20
>  irqreturn_t plda_event_handler(int irq, void *dev_id);
> +int plda_init_interrupts(struct platform_device *pdev,
> +			 struct plda_pcie_rp *port,
> +			 const struct plda_event *event);
>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>  			    size_t size);
> --=20
> 2.17.1
>=20

--ubv8tug+K2nCx7Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQGeQAKCRB4tDGHoIJi
0hsJAQDBe0s8l+u6kfKYR7jI18G06dWMAzSvc6HHEh3PMHja+QD+JD6WAcrZJMI4
WxYVfCgUSBLV1ZojItvdkD9W0aY9UQU=
=aKq7
-----END PGP SIGNATURE-----

--ubv8tug+K2nCx7Kb--
