Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C937BE059
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbjJINjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbjJINja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 09:39:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD9599;
        Mon,  9 Oct 2023 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696858767; x=1728394767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/AVCYo2GUuz1JzWrBlt41ai0mN9U2P/tWlgezZd4X0=;
  b=0RftUBV7tv10qU4BnG3rImCnEUumH8z2xhbHejgaZzAg/w1i4XZG0mv9
   OPkmxOrSc2eUOhulqjKOetwyywxhzW3mRkyucYj4QhhpVtKBPNnTXYh+b
   ha6lAePj+kb5TOoanBEJlsxsAk7TGBzTSKN4MHE3xIEOajnpjT9wTBrDC
   DY20Ju9KKhdQD1Qk9m/4642d4VNiIO9ggn8C4ydT9MSGo6XzhSrf24asw
   R0XnzRcmZIniKogY5kltGOR1SDPsFPU/Pg6YAtZE5bFVE5lfNH+iRUBJU
   O3hOWHcnPb1reJXQU9FXJYaasn3KQxhSCd8plYV1/SIxw8DL5losrNqzV
   g==;
X-CSE-ConnectionGUID: 3jofbIbTRbWiWUmzaP6uag==
X-CSE-MsgGUID: v8rheKmATRem+6rfkBvo6w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="asc'?scan'208";a="240014108"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 06:39:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 06:39:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 06:39:21 -0700
Date:   Mon, 9 Oct 2023 14:39:00 +0100
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
Subject: Re: [PATCH v7 09/19] PCI: microchip: Rename interrupt related
 functions
Message-ID: <20231009-quickstep-jacket-e3f086fb96cf@wendy>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
 <20230927100802.46620-10-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F31FkVq73C2/I0uC"
Content-Disposition: inline
In-Reply-To: <20230927100802.46620-10-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--F31FkVq73C2/I0uC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 06:07:52PM +0800, Minda Chen wrote:
> Rename mc_* to plda_* for IRQ functions and related
> IRQ domain ops data instances.
>=20
> MSI, INTx interrupt codes and IRQ init codes are all
> can be re-used.
>=20
> - function rename list:
>   mc_allocate_msi_domains()  --> plda_allocate_msi_domains()
>   mc_init_interrupts()       --> plda_init_interrupts()
>   mc_pcie_init_irq_domain()  --> plda_pcie_init_irq_domains()
>   mc_handle_event()          --> plda_handle_event()
>   get_events()               --> mc_get_events()
>   MSI interrupts related functions and IRQ domain
>   (primary function is mc_handle_msi()):
>     mc_handle_msi()          --> plda_handle_msi()
>   INTx interrupts related functions and IRQ domain
>   (primary function is mc_handle_intx()):
>     mc_handle_intx()         --> plda_handle_intx()
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 98 +++++++++----------
>  1 file changed, 49 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index ac7126b0bacf..81aac2d72a2f 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -317,7 +317,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, =
void __iomem *ecam)
>  		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
>  }
> =20
> -static void mc_handle_msi(struct irq_desc *desc)
> +static void plda_handle_msi(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> @@ -345,7 +345,7 @@ static void mc_handle_msi(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
> =20
> -static void mc_msi_bottom_irq_ack(struct irq_data *data)
> +static void plda_msi_bottom_irq_ack(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> @@ -354,7 +354,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data *da=
ta)
>  	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
>  }
> =20
> -static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *ms=
g)
> +static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *=
msg)
>  {
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>  	phys_addr_t addr =3D port->msi.vector_phy;
> @@ -367,21 +367,21 @@ static void mc_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
>  		(int)data->hwirq, msg->address_hi, msg->address_lo);
>  }
> =20
> -static int mc_msi_set_affinity(struct irq_data *irq_data,
> -			       const struct cpumask *mask, bool force)
> +static int plda_msi_set_affinity(struct irq_data *irq_data,
> +				 const struct cpumask *mask, bool force)
>  {
>  	return -EINVAL;
>  }
> =20
> -static struct irq_chip mc_msi_bottom_irq_chip =3D {
> -	.name =3D "Microchip MSI",
> -	.irq_ack =3D mc_msi_bottom_irq_ack,
> -	.irq_compose_msi_msg =3D mc_compose_msi_msg,
> -	.irq_set_affinity =3D mc_msi_set_affinity,
> +static struct irq_chip plda_msi_bottom_irq_chip =3D {
> +	.name =3D "PLDA MSI",
> +	.irq_ack =3D plda_msi_bottom_irq_ack,
> +	.irq_compose_msi_msg =3D plda_compose_msi_msg,
> +	.irq_set_affinity =3D plda_msi_set_affinity,
>  };
> =20
> -static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned i=
nt virq,
> -				   unsigned int nr_irqs, void *args)
> +static int plda_irq_msi_domain_alloc(struct irq_domain *domain, unsigned=
 int virq,
> +				     unsigned int nr_irqs, void *args)
>  {
>  	struct plda_pcie_rp *port =3D domain->host_data;
>  	struct plda_msi *msi =3D &port->msi;
> @@ -396,7 +396,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain =
*domain, unsigned int virq,
> =20
>  	set_bit(bit, msi->used);
> =20
> -	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
> +	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
>  			    domain->host_data, handle_edge_irq, NULL, NULL);
> =20
>  	mutex_unlock(&msi->lock);
> @@ -404,8 +404,8 @@ static int mc_irq_msi_domain_alloc(struct irq_domain =
*domain, unsigned int virq,
>  	return 0;
>  }
> =20
> -static void mc_irq_msi_domain_free(struct irq_domain *domain, unsigned i=
nt virq,
> -				   unsigned int nr_irqs)
> +static void plda_irq_msi_domain_free(struct irq_domain *domain, unsigned=
 int virq,
> +				     unsigned int nr_irqs)
>  {
>  	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(d);
> @@ -422,24 +422,24 @@ static void mc_irq_msi_domain_free(struct irq_domai=
n *domain, unsigned int virq,
>  }
> =20
>  static const struct irq_domain_ops msi_domain_ops =3D {
> -	.alloc	=3D mc_irq_msi_domain_alloc,
> -	.free	=3D mc_irq_msi_domain_free,
> +	.alloc	=3D plda_irq_msi_domain_alloc,
> +	.free	=3D plda_irq_msi_domain_free,
>  };
> =20
> -static struct irq_chip mc_msi_irq_chip =3D {
> -	.name =3D "Microchip PCIe MSI",
> +static struct irq_chip plda_msi_irq_chip =3D {
> +	.name =3D "PLDA PCIe MSI",
>  	.irq_ack =3D irq_chip_ack_parent,
>  	.irq_mask =3D pci_msi_mask_irq,
>  	.irq_unmask =3D pci_msi_unmask_irq,
>  };
> =20
> -static struct msi_domain_info mc_msi_domain_info =3D {
> +static struct msi_domain_info plda_msi_domain_info =3D {
>  	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>  		  MSI_FLAG_PCI_MSIX),
> -	.chip =3D &mc_msi_irq_chip,
> +	.chip =3D &plda_msi_irq_chip,
>  };
> =20
> -static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
> +static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev =3D port->dev;
>  	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
> @@ -454,7 +454,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_r=
p *port)
>  		return -ENOMEM;
>  	}
> =20
> -	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode, &mc_msi_domain_in=
fo,
> +	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode, &plda_msi_domain_=
info,
>  						    msi->dev_domain);
>  	if (!msi->msi_domain) {
>  		dev_err(dev, "failed to create MSI domain\n");
> @@ -465,7 +465,7 @@ static int mc_allocate_msi_domains(struct plda_pcie_r=
p *port)
>  	return 0;
>  }
> =20
> -static void mc_handle_intx(struct irq_desc *desc)
> +static void plda_handle_intx(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> @@ -492,7 +492,7 @@ static void mc_handle_intx(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
> =20
> -static void mc_ack_intx_irq(struct irq_data *data)
> +static void plda_ack_intx_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> @@ -501,7 +501,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
>  	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
>  }
> =20
> -static void mc_mask_intx_irq(struct irq_data *data)
> +static void plda_mask_intx_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> @@ -516,7 +516,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
> =20
> -static void mc_unmask_intx_irq(struct irq_data *data)
> +static void plda_unmask_intx_irq(struct irq_data *data)
>  {
>  	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
>  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> @@ -531,24 +531,24 @@ static void mc_unmask_intx_irq(struct irq_data *dat=
a)
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
> =20
> -static struct irq_chip mc_intx_irq_chip =3D {
> -	.name =3D "Microchip PCIe INTx",
> -	.irq_ack =3D mc_ack_intx_irq,
> -	.irq_mask =3D mc_mask_intx_irq,
> -	.irq_unmask =3D mc_unmask_intx_irq,
> +static struct irq_chip plda_intx_irq_chip =3D {
> +	.name =3D "PLDA PCIe INTx",
> +	.irq_ack =3D plda_ack_intx_irq,
> +	.irq_mask =3D plda_mask_intx_irq,
> +	.irq_unmask =3D plda_unmask_intx_irq,
>  };
> =20
> -static int mc_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> -			    irq_hw_number_t hwirq)
> +static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int ir=
q,
> +			      irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &mc_intx_irq_chip, handle_level_irq);
> +	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> =20
>  	return 0;
>  }
> =20
>  static const struct irq_domain_ops intx_domain_ops =3D {
> -	.map =3D mc_pcie_intx_map,
> +	.map =3D plda_pcie_intx_map,
>  };
> =20
>  static inline u32 reg_to_event(u32 reg, struct event_map field)
> @@ -608,7 +608,7 @@ static u32 local_events(struct mc_pcie *port)
>  	return val;
>  }
> =20
> -static u32 get_events(struct plda_pcie_rp *port)
> +static u32 mc_get_events(struct plda_pcie_rp *port)
>  {
>  	struct mc_pcie *mc_port =3D container_of(port, struct mc_pcie, plda);
>  	u32 events =3D 0;
> @@ -637,7 +637,7 @@ static irqreturn_t mc_event_handler(int irq, void *de=
v_id)
>  	return IRQ_HANDLED;
>  }
> =20
> -static void mc_handle_event(struct irq_desc *desc)
> +static void plda_handle_event(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
>  	unsigned long events;
> @@ -646,7 +646,7 @@ static void mc_handle_event(struct irq_desc *desc)
> =20
>  	chained_irq_enter(chip, desc);
> =20
> -	events =3D get_events(port);
> +	events =3D mc_get_events(port);
> =20
>  	for_each_set_bit(bit, &events, NUM_EVENTS)
>  		generic_handle_domain_irq(port->event_domain, bit);
> @@ -749,7 +749,7 @@ static int mc_pcie_event_map(struct irq_domain *domai=
n, unsigned int irq,
>  	return 0;
>  }
> =20
> -static const struct irq_domain_ops event_domain_ops =3D {
> +static const struct irq_domain_ops mc_event_domain_ops =3D {
>  	.map =3D mc_pcie_event_map,
>  };
> =20
> @@ -798,7 +798,7 @@ static int mc_pcie_init_clks(struct device *dev)
>  	return 0;
>  }
> =20
> -static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev =3D port->dev;
>  	struct device_node *node =3D dev->of_node;
> @@ -812,7 +812,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_=
rp *port)
>  	}
> =20
>  	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
> -						   &event_domain_ops, port);
> +						   &mc_event_domain_ops, port);
>  	if (!port->event_domain) {
>  		dev_err(dev, "failed to get event domain\n");
>  		of_node_put(pcie_intc_node);
> @@ -834,7 +834,7 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_=
rp *port)
>  	of_node_put(pcie_intc_node);
>  	raw_spin_lock_init(&port->lock);
> =20
> -	return mc_allocate_msi_domains(port);
> +	return plda_allocate_msi_domains(port);
>  }
> =20
>  static inline void mc_clear_secs(struct mc_pcie *port)
> @@ -897,14 +897,14 @@ static void mc_disable_interrupts(struct mc_pcie *p=
ort)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
> =20
> -static int mc_init_interrupts(struct platform_device *pdev, struct plda_=
pcie_rp *port)
> +static int plda_init_interrupts(struct platform_device *pdev, struct pld=
a_pcie_rp *port)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	int irq;
>  	int i, intx_irq, msi_irq, event_irq;
>  	int ret;
> =20
> -	ret =3D mc_pcie_init_irq_domains(port);
> +	ret =3D plda_pcie_init_irq_domains(port);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> @@ -937,7 +937,7 @@ static int mc_init_interrupts(struct platform_device =
*pdev, struct plda_pcie_rp
>  	}
> =20
>  	/* Plug the INTx chained handler */
> -	irq_set_chained_handler_and_data(intx_irq, mc_handle_intx, port);
> +	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
> =20
>  	msi_irq =3D irq_create_mapping(port->event_domain,
>  				     EVENT_LOCAL_PM_MSI_INT_MSI);
> @@ -945,10 +945,10 @@ static int mc_init_interrupts(struct platform_devic=
e *pdev, struct plda_pcie_rp
>  		return -ENXIO;
> =20
>  	/* Plug the MSI chained handler */
> -	irq_set_chained_handler_and_data(msi_irq, mc_handle_msi, port);
> +	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
> =20
>  	/* Plug the main event chained handler */
> -	irq_set_chained_handler_and_data(irq, mc_handle_event, port);
> +	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
> =20
>  	return 0;
>  }
> @@ -976,7 +976,7 @@ static int mc_platform_init(struct pci_config_window =
*cfg)
>  		return ret;
> =20
>  	/* Address translation is up; safe to enable interrupts */
> -	ret =3D mc_init_interrupts(pdev, &port->plda);
> +	ret =3D plda_init_interrupts(pdev, &port->plda);
>  	if (ret)
>  		return ret;
> =20
> --=20
> 2.17.1
>=20

--F31FkVq73C2/I0uC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQCdAAKCRB4tDGHoIJi
0pgbAQCeJ+n8TSa7ZxRNcnZx1y/lor0y4L5sVYCdFOy+LWpfbgEAgReOSwLpPF7r
Sk2yc+sSLuZx1lTwMw4DSEMvk+7f7gg=
=gz8G
-----END PGP SIGNATURE-----

--F31FkVq73C2/I0uC--
