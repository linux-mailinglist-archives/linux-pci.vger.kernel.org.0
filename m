Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197E777BAB7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHNN4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHNN4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 09:56:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC0F170C;
        Mon, 14 Aug 2023 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692021384; x=1723557384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwTl7FoVXzeyWZyOruZWQM/vpqIr7zcT8t87H4sv/6o=;
  b=YISsjN46Aj6i7fipR9aWBVR2yWa0aJWPljUYohL5JGL9HoVAiz15K3YV
   2nDuKkusuBkkc54i/aAwbLW+LJBd28ecNvIhTLyagHHQ/ttky51yLAT3g
   WE3lmu34AAAfA6R7Oyz4cR4me8tRqw6jrt89A5hlpQC3zjTFh8NsJ2Voe
   +gkWUZISfJj2kT/frLP3yajBZ6pJJOBKHDABHT6mO8oDzCeRo5DDfl5Kb
   J8fUA9cpdEi3xUTKH6WjCxb4xMRVDsU9ZUsTltou4sboaJWCRHGPdkewZ
   +oMC9f51Qkz38V1T1GohS7wwaz0FV8yc6/qXIMDEpQxcU5Pcn0O3mxu0M
   A==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="225314377"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 06:56:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 06:56:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 06:56:19 -0700
Date:   Mon, 14 Aug 2023 14:55:40 +0100
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
Subject: Re: [PATCH v3 07/11] PCI: microchip: Rename IRQ init function
Message-ID: <20230814-vividness-disgrace-115283ea6f9a@wendy>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-8-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hd1d+M8rsCdBs80F"
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-8-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Hd1d+M8rsCdBs80F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:20:12PM +0800, Minda Chen wrote:
> Rename IRQ init function and prepare for re-use
> IRQ init function.
>=20
> rename list:
> mc_init_interrupts -> plda_init_interrupts
> mc_pcie_init_irq_domain-> plda_pcie_init_irq_domains
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 37 +++++++++++++------
>  drivers/pci/controller/plda/pcie-plda.h       |  7 ++++
>  2 files changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index b42f1aac3ec3..140e7ca1a5cb 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -559,7 +559,7 @@ static int mc_pcie_init_clks(struct device *dev)
>  	return 0;
>  }
> =20
> -static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port, struct =
plda_evt *evt)
>  {
>  	struct device *dev =3D port->dev;
>  	struct device_node *node =3D dev->of_node;
> @@ -572,8 +572,8 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_=
rp *port)
>  		return -EINVAL;
>  	}
> =20
> -	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
> -						   &event_domain_ops, port);
> +	port->event_domain =3D irq_domain_add_linear(pcie_intc_node, port->num_=
events,
> +						   evt->domain_ops, port);
>  	if (!port->event_domain) {
>  		dev_err(dev, "failed to get event domain\n");
>  		of_node_put(pcie_intc_node);
> @@ -658,14 +658,15 @@ static void mc_disable_interrupts(struct mc_pcie *p=
ort)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
> =20
> -static int mc_init_interrupts(struct platform_device *pdev, struct plda_=
pcie_rp *port)
> +static int plda_init_interrupts(struct platform_device *pdev,
> +				struct plda_pcie_rp *port, struct plda_evt *evt)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	int irq;
>  	int i, intx_irq, msi_irq, event_irq;
>  	int ret;
> =20
> -	ret =3D mc_pcie_init_irq_domains(port);
> +	ret =3D plda_pcie_init_irq_domains(port, evt);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> @@ -675,15 +676,18 @@ static int mc_init_interrupts(struct platform_devic=
e *pdev, struct plda_pcie_rp
>  	if (irq < 0)
>  		return -ENODEV;
> =20
> -	for (i =3D 0; i < NUM_EVENTS; i++) {
> +	for (i =3D 0; i < port->num_events; i++) {
>  		event_irq =3D irq_create_mapping(port->event_domain, i);
>  		if (!event_irq) {
>  			dev_err(dev, "failed to map hwirq %d\n", i);
>  			return -ENXIO;
>  		}
> =20
> -		ret =3D devm_request_irq(dev, event_irq, mc_event_handler,
> -				       0, event_cause[i].sym, port);
> +		if (evt->request_evt_irq)
> +			ret =3D evt->request_evt_irq(port, event_irq, i);
> +		else
> +			ret =3D devm_request_irq(dev, event_irq, plda_event_handler,
> +					       0, NULL, port);

Is there a particular reason this if/else addition ended up in this
patch, but the if/else addition in plda_handle_event() ended up in the
next one?

Otherwise, this looks fine to me.

--Hd1d+M8rsCdBs80F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNoyXAAKCRB4tDGHoIJi
0uB+AP9gjLStAfRzFpKp3mEswylGIjBBR1gl7TtbEkK6nH03LgD/W2C+fihWQiZi
7BAhqXi8t0ZG1uBUHTJz0v62pVBWVAk=
=H1ht
-----END PGP SIGNATURE-----

--Hd1d+M8rsCdBs80F--
