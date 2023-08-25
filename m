Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E827886AC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjHYMK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244418AbjHYMKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 08:10:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A69E6B;
        Fri, 25 Aug 2023 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692965445; x=1724501445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7WOd2tGjgKOiq0ZivZVRqSVMJmTMZHLUBWKTtr0MnyE=;
  b=iE9V7ajmWHoCs9GnNPVglRdzYJVwr3MgsLV7nyY3Cauj5yaSgCK4Mr/U
   KNq51KkZ3vVjU6rvGxQVHRx6sH0X3ucknVER0J7o/qT3X0UkLpqhoBXzA
   cZhVMgm6pVI83XCgtQU39FpWl031htxEhobE/U37W62x2xwI3yssR8HjP
   waqfqLckQzejT/BXuUsLKtkdp0snJkLIJscz49nrUBFba1nqhXuioxKo9
   ORqo0QZqeymT1IfVVH7243SPkbGVuVV8gPkDFoEuD5TxZ+wf+I7Newlxr
   OI0sGDqSgDHE/W0h4XU8+VMbxyCioGFn6T0472OccvuhwPyrKFjFNq8Wi
   w==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="asc'?scan'208";a="231709314"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 05:10:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 05:09:57 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 25 Aug 2023 05:09:54 -0700
Date:   Fri, 25 Aug 2023 13:09:13 +0100
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
Subject: Re: [PATCH v4 08/11] PCI: microchip: Move IRQ init functions to
 pcie-plda-host.c
Message-ID: <20230825-sip-pentagon-e1760dcfce58@wendy>
References: <20230825090129.65721-1-minda.chen@starfivetech.com>
 <20230825090129.65721-9-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Mzadswy/UgLR3pW"
Content-Disposition: inline
In-Reply-To: <20230825090129.65721-9-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--3Mzadswy/UgLR3pW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Daire, can you look at this one too please?

On Fri, Aug 25, 2023 at 05:01:26PM +0800, Minda Chen wrote:
> Move IRQ init functions to pcie-plda-host.c.
> mc_handle_event() is merged to plda_handle_event().
> Set most of the IRQ functions to static in pcie-plda-host.c
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

> -void plda_handle_event(struct irq_desc *desc)
> +static void plda_handle_event(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> @@ -264,14 +268,18 @@ void plda_handle_event(struct irq_desc *desc)
> =20
>  	chained_irq_enter(chip, desc);
> =20
> -	val =3D readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
> -	origin =3D val;
> -	val =3D val >> A_ATR_EVT_POST_ERR_SHIFT;
> -	events |=3D val & 0xff;
> -	if (origin & PM_MSI_INT_INTX_MASK)
> -		events |=3D BIT(EVENT_PM_MSI_INT_INTX);
> -	val =3D (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
> -	events |=3D val << EVENT_PM_MSI_INT_MSI;
> +	if (port->ops && port->ops->get_events) {

I still don't love the dancing here. Can you just always register a
callback?

Thanks,
Conor.

> +		events =3D port->ops->get_events(port);
> +	} else {
> +		val =3D readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
> +		origin =3D val;
> +		val =3D val >> A_ATR_EVT_POST_ERR_SHIFT;
> +		events |=3D val & 0xff;
> +		if (origin & PM_MSI_INT_INTX_MASK)
> +			events |=3D BIT(EVENT_PM_MSI_INT_INTX);
> +		val =3D (origin >> PM_MSI_INT_MSI_SHIFT) & 0xf;
> +		events |=3D val << EVENT_PM_MSI_INT_MSI;
> +	}
> =20
>  	for_each_set_bit(bit, &events, port->num_events)
>  		generic_handle_domain_irq(port->event_domain, bit);

--3Mzadswy/UgLR3pW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOiZ6QAKCRB4tDGHoIJi
0vy8AQCbzdPqfIsg4Rb+K+nCGb0DwA4IC2wBkiUhYzZPvjqQLQEApoBsItvyi8Rf
Ge4Jyp0msR/nVvWuYP8BEVG8nnZTgQI=
=zD2O
-----END PGP SIGNATURE-----

--3Mzadswy/UgLR3pW--
