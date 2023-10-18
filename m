Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F097CDA5B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJRLbG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjJRLbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:31:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC691112;
        Wed, 18 Oct 2023 04:31:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B421DC433BA;
        Wed, 18 Oct 2023 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697628662;
        bh=2a3fF360HQENIx57U7Wbr+82JHRHzTNfIBguTuTew0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hO7SQdvI1JxwSmUngjOaS4yakSuhGvtWB6tzEVexM7TNSgntP6UcvUTUerAeqBBW5
         H3p7HpIbJWPb54PjGdwY2HcubMDAunf+3AoJ46P9bifevmiPMe0AKpvldc2zVrU0iG
         xqBxGUNf4OkyBCp8bPD0ZrvglNjU60SKPblgaqrY4rHw2g2vL2re0M3MFOs+56Y76/
         OUTduFs351QSnEqOFENB/S0n4tIZDa4xo81KQN/pQWW3Dq8u3r4s2Fvb8+pEe+0lvq
         r10U7elHuk4IB5eP9mZJ40FKuFpXmzM3UiH/0lC+CVRqHp4ScXL4WXoZrrj/zSDcla
         aHE4S5t7K3nvg==
Date:   Wed, 18 Oct 2023 12:30:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: Re: [PATCH v8 16/22] PCI: microchip: Add event IRQ domain ops to
 struct plda_event
Message-ID: <20231018-worrier-sizably-b13023f54b36@spud>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
 <20231011110514.107528-17-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="58kJN2dw4v2LbZBq"
Content-Disposition: inline
In-Reply-To: <20231011110514.107528-17-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--58kJN2dw4v2LbZBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 07:05:08PM +0800, Minda Chen wrote:
> PolarFire Implements none-PLDA event interrupts. So the whole event
> domain ops can not be re-used.

IIRC, the reason things are like this is to work around the lack of an
msi controller and are not as a result of changes made to the PLDA IP
by us.

> PLDA event domain ops instances will be implemented
> in later patch.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 9 ++++++---
>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index fca1520d56c9..2825c1f5563d 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -811,13 +811,15 @@ static const struct plda_event_ops mc_event_ops =3D=
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
> @@ -831,7 +833,8 @@ static int plda_pcie_init_irq_domains(struct plda_pci=
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
> @@ -930,7 +933,7 @@ static int plda_init_interrupts(struct platform_devic=
e *pdev,
>  		return -EINVAL;
>  	}
> =20
> -	ret =3D plda_pcie_init_irq_domains(port);
> +	ret =3D plda_pcie_init_irq_domains(port, event->domain_ops);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/contro=
ller/plda/pcie-plda.h
> index 6571a4befac9..080932cbe8c4 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -129,6 +129,7 @@ struct plda_pcie_rp {
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

--58kJN2dw4v2LbZBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS/B8AAKCRB4tDGHoIJi
0po5APiWGDsBhIIXOhjo24t9Ngvjf+qyTiHcD80kNJRtBXqJAP4gSLIomdwIbCJf
Fp3FqROWnjnrkrANykQjljJiBa2nDw==
=5HzY
-----END PGP SIGNATURE-----

--58kJN2dw4v2LbZBq--
