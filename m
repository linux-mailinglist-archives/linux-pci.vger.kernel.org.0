Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC47BE1E5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377589AbjJINzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377599AbjJINzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 09:55:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098B9B9;
        Mon,  9 Oct 2023 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696859715; x=1728395715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyAyyVVpeXrkP6kYXa6+1hGK7jwZaqHDO7BPBGN0kt4=;
  b=b00qfY6XO5TgKGsHWnQjxlc/FdjKG7r6j8KR8V7ousu2w38b41zUN7bF
   7SjyVFv+xN73AHxxRwIpVlphux0p0oWgGtHXBVoBKz+8ngDOHZfJdDUTY
   8PXn1zpY/2K1bswPCARyKsRyK7jmw0NuLaAnreRKll3QSo/YqfotTEIeB
   AMNWgWxJXDiRP51Ob52NIsbanE7SPLRW6mDGjOrKuSG3k6xUXWvGlupzm
   OBNhujXilGGyPo3BHa9ZuKZ+SYeF5BarLhhq45/WvJT0oDB/vQ7WWVK9s
   HrmkIFtKw0VJT+edZHY2MW9SfI8ueFJwbBhRRpEwDnJ1PEYQLonwckcnD
   Q==;
X-CSE-ConnectionGUID: BCeMba0SR+ms7gMS9QQd6g==
X-CSE-MsgGUID: BpGGr/ejTDuwg8VyZ1RHXw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="asc'?scan'208";a="9287955"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 06:55:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 06:55:11 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 06:55:08 -0700
Date:   Mon, 9 Oct 2023 14:54:47 +0100
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
Subject: Re: [PATCH v7 14/19] PCI: microchip: Add event IRQ domain ops to
 struct plda_event
Message-ID: <20231009-walk-tranquil-915f1a35f58c@wendy>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
 <20230927100802.46620-15-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m6KZbs29qDbK8z+n"
Content-Disposition: inline
In-Reply-To: <20230927100802.46620-15-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--m6KZbs29qDbK8z+n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 27, 2023 at 06:07:57PM +0800, Minda Chen wrote:
> For register different event domain ops, Add domain_ops
> pointer to struct plda_event.

Again, the motivation for making this change should, IMO, be mentioned
in the commit message. The code change itself seems fine to me.

Thanks,
Conor.

>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 12 +++++++++---
>  drivers/pci/controller/plda/pcie-plda.h           |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index 875bdb03ce22..49e09d24eb8f 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -810,13 +810,15 @@ static const struct plda_event_ops mc_event_ops =3D=
 {
>  };
> =20
>  static const struct plda_event mc_event =3D {
> +	.domain_ops             =3D &mc_event_domain_ops,
>  	.event_ops              =3D &mc_event_ops,
>  	.request_event_irq      =3D mc_request_event_irq,
>  	.intx_event             =3D EVENT_LOCAL_PM_MSI_INT_INTX,
>  	.msi_event              =3D EVENT_LOCAL_PM_MSI_INT_MSI,
>  };
> =20
> -static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> +				      const struct irq_domain_ops *ops)
>  {
>  	struct device *dev =3D port->dev;
>  	struct device_node *node =3D dev->of_node;
> @@ -830,7 +832,8 @@ static int plda_pcie_init_irq_domains(struct plda_pci=
e_rp *port)
>  	}
> =20
>  	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, port->num_=
events,
> -						   &mc_event_domain_ops, port);
> +						   ops, port);
> +
>  	if (!port->event_domain) {
>  		dev_err(dev, "failed to get event domain\n");
>  		of_node_put(pcie_intc_node);
> @@ -923,13 +926,16 @@ static int plda_init_interrupts(struct platform_dev=
ice *pdev,
>  	int irq;
>  	int i, intx_irq, msi_irq, event_irq;
>  	int ret;
> +	const struct irq_domain_ops *irq_dom_ops;
> =20
>  	if (!event->event_ops || !event->event_ops->get_events) {
>  		dev_err(dev, "no get events ops\n");
>  		return -EINVAL;
>  	}
> =20
> -	ret =3D plda_pcie_init_irq_domains(port);
> +	irq_dom_ops =3D event->domain_ops ? event->domain_ops : &mc_event_domai=
n_ops;
> +
> +	ret =3D plda_pcie_init_irq_domains(port, irq_dom_ops);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/contro=
ller/plda/pcie-plda.h
> index 48d7bc471137..122084a3318a 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -155,6 +155,7 @@ struct plda_pcie_rp {
>  };
> =20
>  struct plda_event {
> +	const struct irq_domain_ops *domain_ops;
>  	const struct plda_event_ops *event_ops;
>  	int (*request_event_irq)(struct plda_pcie_rp *pcie,
>  				 int event_irq, int event);
> --=20
> 2.17.1
>=20

--m6KZbs29qDbK8z+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQGJwAKCRB4tDGHoIJi
0gYuAP9YmN8fqrCvIcDZ84hExyo6Vu/F1CIxaPdG74xU36uKvQEAqgc/XKWQMzpn
ynbUEg/q3dgQSY95wyw26lrTyWvOrAg=
=jw9K
-----END PGP SIGNATURE-----

--m6KZbs29qDbK8z+n--
