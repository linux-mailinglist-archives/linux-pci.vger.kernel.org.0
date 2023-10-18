Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886F7CDAE7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJRLqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjJRL1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFA114;
        Wed, 18 Oct 2023 04:27:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC50C433C8;
        Wed, 18 Oct 2023 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697628438;
        bh=zlW+WXJ03AHaq8TEskzb4g7xW6mVxN5qwb3rME6hGQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWFJEp+Xmwvqe1PFdvZVgupKgddtwchKLguWXYSy2opIYYHnnucRppdNIOI8hvmOL
         8tn8h6rrY3/6hNMSC9Ysudo5/+2jx6i0aLDx4yyJH5hfKHiEc27hB9D2zHvtIIHiWo
         lkE1MjpbhdqG/iMyT1Xi7ubTqK32DQT9kwnF9VINOU4CBWL+YbMGpVoUDepNe5pvtv
         LK1xOym53SCRV8VbCl3ahcq8ZQgZc7wv9A6KboruZTX7Tng5vAnmOfJGXNDaeKTWBH
         iegx8qrA/LBME+Sc2Vll002vBDr/hTKxEqqdjSvgqOb4GmZX+7KOkUxbqsIT9bTzXY
         LRAsSME3qYBjQ==
Date:   Wed, 18 Oct 2023 12:27:12 +0100
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
Subject: Re: [PATCH v8 15/22] PCI: microchip: Add get_events() callback
 function
Message-ID: <20231018-landed-sampling-2fcec42943c8@spud>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
 <20231011110514.107528-16-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6ZiTasWF0vb64gL"
Content-Disposition: inline
In-Reply-To: <20231011110514.107528-16-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--r6ZiTasWF0vb64gL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 07:05:07PM +0800, Minda Chen wrote:


> For different interrupts to event num mapping function,
> add get_events() function pointer.
> For extenting event ops in the fucture, Add struct
> plda_event_ops data structure.

I still think these commit messages are a bit weak and should point out
the reasons why these are needed, rather than handwaving about future
users.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> plda_handle_events() will call the get_events() callback
> function pointer directly. For the robustness of codes,
> add checking in plda_init_interrupts().
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 14 +++++++++++++-
>  drivers/pci/controller/plda/pcie-plda.h           |  8 ++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index e99498b5b563..fca1520d56c9 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -647,7 +647,7 @@ static void plda_handle_event(struct irq_desc *desc)
> =20
>  	chained_irq_enter(chip, desc);
> =20
> -	events =3D mc_get_events(port);
> +	events =3D port->event_ops->get_events(port);
> =20
>  	for_each_set_bit(bit, &events, port->num_events)
>  		generic_handle_domain_irq(port->event_domain, bit);
> @@ -806,7 +806,12 @@ static int mc_request_event_irq(struct plda_pcie_rp =
*plda, int event_irq,
>  				0, event_cause[event].sym, plda);
>  }
> =20
> +static const struct plda_event_ops mc_event_ops =3D {
> +	.get_events =3D mc_get_events,
> +};
> +
>  static const struct plda_event mc_event =3D {
> +	.event_ops              =3D &mc_event_ops,
>  	.request_event_irq      =3D mc_request_event_irq,
>  	.intx_event             =3D EVENT_LOCAL_PM_MSI_INT_INTX,
>  	.msi_event              =3D EVENT_LOCAL_PM_MSI_INT_MSI,
> @@ -920,6 +925,11 @@ static int plda_init_interrupts(struct platform_devi=
ce *pdev,
>  	int i, intx_irq, msi_irq, event_irq;
>  	int ret;
> =20
> +	if (!event->event_ops || !event->event_ops->get_events) {
> +		dev_err(dev, "no get events ops\n");
> +		return -EINVAL;
> +	}
> +
>  	ret =3D plda_pcie_init_irq_domains(port);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
> @@ -930,6 +940,8 @@ static int plda_init_interrupts(struct platform_devic=
e *pdev,
>  	if (irq < 0)
>  		return -ENODEV;
> =20
> +	port->event_ops =3D event->event_ops;
> +
>  	for (i =3D 0; i < port->num_events; i++) {
>  		event_irq =3D irq_create_mapping(port->event_domain, i);
>  		if (!event_irq) {
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/contro=
ller/plda/pcie-plda.h
> index 5ad1b81c0086..6571a4befac9 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -102,6 +102,12 @@
>  #define EVENT_PM_MSI_INT_SYS_ERR		12
>  #define NUM_PLDA_EVENTS				13
> =20
> +struct plda_pcie_rp;
> +
> +struct plda_event_ops {
> +	u32 (*get_events)(struct plda_pcie_rp *pcie);
> +};
> +
>  struct plda_msi {
>  	struct mutex lock;		/* Protect used bitmap */
>  	struct irq_domain *msi_domain;
> @@ -117,11 +123,13 @@ struct plda_pcie_rp {
>  	struct irq_domain *event_domain;
>  	raw_spinlock_t lock;
>  	struct plda_msi msi;
> +	const struct plda_event_ops *event_ops;
>  	void __iomem *bridge_addr;
>  	int num_events;
>  };
> =20
>  struct plda_event {
> +	const struct plda_event_ops *event_ops;
>  	int (*request_event_irq)(struct plda_pcie_rp *pcie,
>  				 int event_irq, int event);
>  	int intx_event;
> --=20
> 2.17.1
>=20

--r6ZiTasWF0vb64gL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS/BEAAKCRB4tDGHoIJi
0m/cAQCOrCJ2bYXCB7wvpZnWAUAeEFiNVKT5N+U+TgJyh1aYPgEA5fNtx3R0qwom
tjpc0UtKhVAbjP8MwJIzQFwaIgq+ig8=
=OugO
-----END PGP SIGNATURE-----

--r6ZiTasWF0vb64gL--
