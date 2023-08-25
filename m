Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E695788699
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 14:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjHYMHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbjHYMGo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 08:06:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4A198E;
        Fri, 25 Aug 2023 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692965201; x=1724501201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXZ6bzIVvukLVZe+64ksePMBn1FoVHz2IoY48+UZhDs=;
  b=M9hDWYzd8BiXG0digA1/3jaUtJrRlOZapTAXzQfFEh5AwO8VHcofjSfS
   0yeP1WSe6lyDboABVuY4KrUEPDC85g0/8AIqOxSbrIM/MCipXuyTtBTQ/
   yB9Fkw0A8rwWiFrGR85OQt3phbAESUL0I0rp1t/uenpfEcugWc/S7VZP9
   xbPMrFXvLlIpi38SGesWtLOMYrbSStGjJADF46IrZcvgLx2jS5O20iak7
   z3DoLtlxEswLTeRggII64Jz+22njUoSLEEDbox2EDoNfW+8eetvo/448g
   Zz+vSIPQp45T3IiUjVhIzHlfyh4Yz4Zyiu0T2kS0A55mzkHAruwBMXSCC
   w==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="asc'?scan'208";a="168287738"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 05:06:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 05:06:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 25 Aug 2023 05:06:34 -0700
Date:   Fri, 25 Aug 2023 13:05:53 +0100
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v4 07/11] PCI: microchip: Rename IRQ init function
Message-ID: <20230825-numbness-easel-e0c827e97b99@wendy>
References: <20230825090129.65721-1-minda.chen@starfivetech.com>
 <20230825090129.65721-8-minda.chen@starfivetech.com>
 <20230825-undusted-detached-1d67370c0a18@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kCQ7FYlnMjRV44l9"
Content-Disposition: inline
In-Reply-To: <20230825-undusted-detached-1d67370c0a18@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--kCQ7FYlnMjRV44l9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:56:03PM +0100, Conor Dooley wrote:
> Hey Minda,
>=20
> I would like Daire to take a look at this, but I have a few more
> smaller comments on this.

And another one that is nitpickery..

>=20
> On Fri, Aug 25, 2023 at 05:01:25PM +0800, Minda Chen wrote:
> > Rename IRQ init function and prepare for re-use
> > IRQ init function.
> > Add plda_pcie_ops function pointer data structure,
> > PolarFire PCIe uses function pointer to get
> > their events num.
> >=20
> > rename list:
> > mc_init_interrupts()     -> plda_init_interrupts()
> > mc_pcie_init_irq_domain()-> plda_pcie_init_irq_domains()
> >=20
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > ---
> >  .../pci/controller/plda/pcie-microchip-host.c | 49 ++++++++++++++-----
> >  drivers/pci/controller/plda/pcie-plda.h       | 14 ++++++
> >  2 files changed, 51 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/driver=
s/pci/controller/plda/pcie-microchip-host.c
> > index b1d5b5b3cee5..03e8e93ea7e4 100644
> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > @@ -416,7 +416,10 @@ static void mc_handle_event(struct irq_desc *desc)
> > =20
> >  	chained_irq_enter(chip, desc);
> > =20
> > -	events =3D get_events(port);
> > +	if (port->ops && port->ops->get_events)
> > +		events =3D port->ops->get_events(port);
> > +	else
> > +		events =3D get_events(port);
>=20
> I don't really understand why we are going to having two different sorts
> of event acquirers here. Is there a reason to not "just" register=20
> get_events() as the default callback & remove the special casing?
>=20
> > =20
> >  	for_each_set_bit(bit, &events, NUM_EVENTS)
> >  		generic_handle_domain_irq(port->event_domain, bit);
> > @@ -562,11 +565,12 @@ static int mc_pcie_init_clks(struct device *dev)
> >  	return 0;
> >  }
> > =20
> > -static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
> > +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struc=
t plda_evt *evt)
>=20
> Could you just spell out the word "event" in all of these data
> structures and variables? The existing code seems to always spell it
> out, so its a boon for consistency too.
>=20
> >  {
> >  	struct device *dev =3D port->dev;
> >  	struct device_node *node =3D dev->of_node;
> >  	struct device_node *pcie_intc_node;
> > +	const struct irq_domain_ops *ops;
> > =20
> >  	/* Setup INTx */
> >  	pcie_intc_node =3D of_get_next_child(node, NULL);
> > @@ -575,8 +579,9 @@ static int mc_pcie_init_irq_domains(struct plda_pci=
e_rp *port)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, NUM_EVEN=
TS,
> > -						   &event_domain_ops, port);
> > +	ops =3D evt->domain_ops ? evt->domain_ops : &event_domain_ops;
> > +	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, port->nu=
m_events,
> > +						   ops, port);
> >  	if (!port->event_domain) {
> >  		dev_err(dev, "failed to get event domain\n");
> >  		of_node_put(pcie_intc_node);
> > @@ -661,14 +666,15 @@ static void mc_disable_interrupts(struct mc_pcie =
*port)
> >  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
> >  }
> > =20
> > -static int mc_init_interrupts(struct platform_device *pdev, struct pld=
a_pcie_rp *port)
> > +static int plda_init_interrupts(struct platform_device *pdev,
> > +				struct plda_pcie_rp *port, struct plda_evt *evt)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> >  	int irq;
> >  	int i, intx_irq, msi_irq, event_irq;
> >  	int ret;
> > =20
> > -	ret =3D mc_pcie_init_irq_domains(port);
> > +	ret =3D plda_pcie_init_irq_domains(port, evt);
> >  	if (ret) {
> >  		dev_err(dev, "failed creating IRQ domains\n");
> >  		return ret;
> > @@ -678,15 +684,18 @@ static int mc_init_interrupts(struct platform_dev=
ice *pdev, struct plda_pcie_rp
> >  	if (irq < 0)
> >  		return -ENODEV;
> > =20
> > -	for (i =3D 0; i < NUM_EVENTS; i++) {
> > +	for (i =3D 0; i < port->num_events; i++) {
> >  		event_irq =3D irq_create_mapping(port->event_domain, i);
> >  		if (!event_irq) {
> >  			dev_err(dev, "failed to map hwirq %d\n", i);
> >  			return -ENXIO;
> >  		}
> > =20
> > -		ret =3D devm_request_irq(dev, event_irq, mc_event_handler,
> > -				       0, event_cause[i].sym, port);
> > +		if (evt->request_evt_irq)
> > +			ret =3D evt->request_evt_irq(port, event_irq, i);
> > +		else
> > +			ret =3D devm_request_irq(dev, event_irq, plda_event_handler,
> > +					       0, NULL, port);
> >  		if (ret) {
> >  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
> >  			return ret;
> > @@ -694,7 +703,7 @@ static int mc_init_interrupts(struct platform_devic=
e *pdev, struct plda_pcie_rp
> >  	}
> > =20
> >  	intx_irq =3D irq_create_mapping(port->event_domain,
> > -				      EVENT_LOCAL_PM_MSI_INT_INTX);
> > +				      evt->intx_evt);
> >  	if (!intx_irq) {
> >  		dev_err(dev, "failed to map INTx interrupt\n");
> >  		return -ENXIO;
> > @@ -704,7 +713,7 @@ static int mc_init_interrupts(struct platform_devic=
e *pdev, struct plda_pcie_rp
> >  	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
> > =20
> >  	msi_irq =3D irq_create_mapping(port->event_domain,
> > -				     EVENT_LOCAL_PM_MSI_INT_MSI);
> > +				     evt->msi_evt);
> >  	if (!msi_irq)
> >  		return -ENXIO;
> > =20
> > @@ -717,6 +726,17 @@ static int mc_init_interrupts(struct platform_devi=
ce *pdev, struct plda_pcie_rp
> >  	return 0;
> >  }
> > =20
> > +static int mc_request_evt_irq(struct plda_pcie_rp *plda, int event_irq,
> > +			      int evt)
> > +{
> > +	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
> > +				0, event_cause[evt].sym, plda);
> > +}
> > +
> > +static const struct plda_pcie_ops plda_ops =3D {
> > +	.get_events =3D get_events,
> > +};
>=20
> This struct gets left behind in the microchip driver file, but is named
> "plda_ops". That doesn't make sense to me, I think it should have an
> "mc" prefix like other stuff in the file (and the microchip version of
> get_events() should also grow a prefix IMO).
>=20
> Thanks,
> Conor.
>=20
> > +
> >  static int mc_platform_init(struct pci_config_window *cfg)
> >  {
> >  	struct device *dev =3D cfg->parent;
> > @@ -724,6 +744,9 @@ static int mc_platform_init(struct pci_config_windo=
w *cfg)
> >  	void __iomem *bridge_base_addr =3D
> >  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> >  	struct pci_host_bridge *bridge =3D platform_get_drvdata(pdev);
> > +	struct plda_evt evt =3D {&event_domain_ops, mc_request_evt_irq,
> > +			       EVENT_LOCAL_PM_MSI_INT_INTX,
> > +			       EVENT_LOCAL_PM_MSI_INT_MSI};

Isn't this the normal style for struct initialisers?
	struct plda_evt evt =3D {
		&event_domain_ops, mc_request_evt_irq,
		EVENT_LOCAL_PM_MSI_INT_INTX,
		EVENT_LOCAL_PM_MSI_INT_MSI
	};

> >  	int ret;
> > =20
> >  	/* Configure address translation table 0 for PCIe config space */
> > @@ -740,7 +763,7 @@ static int mc_platform_init(struct pci_config_windo=
w *cfg)
> >  		return ret;
> > =20
> >  	/* Address translation is up; safe to enable interrupts */
> > -	ret =3D mc_init_interrupts(pdev, &port->plda);
> > +	ret =3D plda_init_interrupts(pdev, &port->plda, &evt);
> >  	if (ret)
> >  		return ret;
> > =20
> > @@ -761,6 +784,8 @@ static int mc_host_probe(struct platform_device *pd=
ev)
> > =20
> >  	plda =3D &port->plda;
> >  	plda->dev =3D dev;
> > +	plda->num_events =3D NUM_EVENTS;
> > +	plda->ops =3D &plda_ops;
> > =20
> >  	port->axi_base_addr =3D devm_platform_ioremap_resource(pdev, 1);
> >  	if (IS_ERR(port->axi_base_addr))
> > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/cont=
roller/plda/pcie-plda.h
> > index 315d9874b899..ef33c1365b3e 100644
> > --- a/drivers/pci/controller/plda/pcie-plda.h
> > +++ b/drivers/pci/controller/plda/pcie-plda.h
> > @@ -104,6 +104,12 @@
> > =20
> >  #define PM_MSI_TO_MASK_OFFSET			19
> > =20
> > +struct plda_pcie_rp;
> > +
> > +struct plda_pcie_ops {
> > +	u32 (*get_events)(struct plda_pcie_rp *pcie);
> > +};
> > +
> >  struct plda_msi {
> >  	struct mutex lock;		/* Protect used bitmap */
> >  	struct irq_domain *msi_domain;
> > @@ -119,10 +125,18 @@ struct plda_pcie_rp {
> >  	struct irq_domain *event_domain;
> >  	raw_spinlock_t lock;
> >  	struct plda_msi msi;
> > +	const struct plda_pcie_ops *ops;
> >  	void __iomem *bridge_addr;
> >  	int num_events;
> >  };
> > =20
> > +struct plda_evt {
> > +	const struct irq_domain_ops *domain_ops;
> > +	int (*request_evt_irq)(struct plda_pcie_rp *pcie, int evt_irq, int ev=
ent);
> > +	int intx_evt;
> > +	int msi_evt;
> > +};
> > +
> >  void plda_handle_msi(struct irq_desc *desc);
> >  int plda_allocate_msi_domains(struct plda_pcie_rp *port);
> >  irqreturn_t plda_event_handler(int irq, void *dev_id);
> > --=20
> > 2.17.1
> >=20



--kCQ7FYlnMjRV44l9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOiZIQAKCRB4tDGHoIJi
0nNQAP9EUnN5uu1kvz2sWBgqVeJIUpYFRdRBReSv4Yey7yanqgEAvSiSfZCXOOIv
36nXKXBSqFl/3d9gZIbS4jrIxCn5pA0=
=415q
-----END PGP SIGNATURE-----

--kCQ7FYlnMjRV44l9--
