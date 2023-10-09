Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC647BE100
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377617AbjJINqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377489AbjJINpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 09:45:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F1134;
        Mon,  9 Oct 2023 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696859147; x=1728395147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hz+kfQuBUxxU8Y+PSM82mM39soRTXn/pPst9P6FcQAc=;
  b=KAhj+b69jOrB3cYBgXCz6deQ17cYmWctyrr77fR0xHUbyhZLsYBVJLfv
   D5ax784gc6p6UsXL3FT70vvrz2NGO0HV7hAvizPkPI50A4so+4UeDC984
   VxOg8B0IPGpiEe4M8/u2qCJ/Ot1WpmbJFQN92Nk8SXhpYx0jZSeb5d7xH
   +cZJxHlVbKqTb73dVjsaYQjXczd6e+UEfPsSagzHkRpK+bXzy8kY0PYw3
   JW8coAhmjLMd7GDBH2M+dOdB1CHdnCQX9x0ZJBsldZol5yvcNd57Evrl1
   7COvofZkN100EsH83ZfyvpCrKSYN3XoL859y1I7I7u7sq7+cnGvL+4Qg6
   A==;
X-CSE-ConnectionGUID: MvdzK2qwS7idKzGlgdOLQQ==
X-CSE-MsgGUID: 4j9/r3djQzacLBhdltZ1sA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="asc'?scan'208";a="176448541"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 06:45:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 06:45:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 06:45:42 -0700
Date:   Mon, 9 Oct 2023 14:45:22 +0100
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
Subject: Re: [PATCH v7 11/19] PCI: microchip: Add request_event_irq()
 callback function
Message-ID: <20231009-darkroom-tantrum-87c8ae61143d@wendy>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
 <20230927100802.46620-12-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TETxY3uZg/QuT+Jz"
Content-Disposition: inline
In-Reply-To: <20230927100802.46620-12-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--TETxY3uZg/QuT+Jz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 27, 2023 at 06:07:54PM +0800, Minda Chen wrote:
> PolarFire register 28 interrupts symbols name.
> PLDA just reguster 13 interrupts, it is not require to
> register symbol name. So add a callback functions
> to support StarFive and Microchip platforms.

I'm not really sure how the number of interrupts relates to whether or
not symbol names need to be registered.

The code itself (again) seems okay to me, but I think this commit
message doesn't really explain the rationale behind the patch to someone
who is not really familiar with the interrupt handling here.

Thanks,
Conor.

>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 25 ++++++++++++++++---
>  drivers/pci/controller/plda/pcie-plda.h       |  5 ++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index d9dd63084e2b..e3c7d5e66150 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -798,6 +798,17 @@ static int mc_pcie_init_clks(struct device *dev)
>  	return 0;
>  }
> =20
> +static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
> +				int event)
> +{
> +	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
> +				0, event_cause[event].sym, plda);
> +}
> +
> +static const struct plda_event mc_event =3D {
> +	.request_event_irq      =3D mc_request_event_irq,
> +};
> +
>  static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev =3D port->dev;
> @@ -897,7 +908,9 @@ static void mc_disable_interrupts(struct mc_pcie *por=
t)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
> =20
> -static int plda_init_interrupts(struct platform_device *pdev, struct pld=
a_pcie_rp *port)
> +static int plda_init_interrupts(struct platform_device *pdev,
> +				struct plda_pcie_rp *port,
> +				const struct plda_event *event)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	int irq;
> @@ -921,8 +934,12 @@ static int plda_init_interrupts(struct platform_devi=
ce *pdev, struct plda_pcie_r
>  			return -ENXIO;
>  		}
> =20
> -		ret =3D devm_request_irq(dev, event_irq, mc_event_handler,
> -				       0, event_cause[i].sym, port);
> +		if (event->request_event_irq)
> +			ret =3D event->request_event_irq(port, event_irq, i);
> +		else
> +			ret =3D devm_request_irq(dev, event_irq, plda_event_handler,
> +					       0, NULL, port);
> +
>  		if (ret) {
>  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
>  			return ret;
> @@ -976,7 +993,7 @@ static int mc_platform_init(struct pci_config_window =
*cfg)
>  		return ret;
> =20
>  	/* Address translation is up; safe to enable interrupts */
> -	ret =3D plda_init_interrupts(pdev, &port->plda);
> +	ret =3D plda_init_interrupts(pdev, &port->plda, &mc_event);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/contro=
ller/plda/pcie-plda.h
> index 5b09ffed623c..4e0712c9365e 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -153,6 +153,11 @@ struct plda_pcie_rp {
>  	int num_events;
>  };
> =20
> +struct plda_event {
> +	int (*request_event_irq)(struct plda_pcie_rp *pcie,
> +				 int event_irq, int event);
> +};
> +
>  irqreturn_t plda_event_handler(int irq, void *dev_id);
>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
> --=20
> 2.17.1
>=20

--TETxY3uZg/QuT+Jz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQD8gAKCRB4tDGHoIJi
0ldRAQDzgq28nzRuO+EiOuhzCjCVyftsf9FeS4NQ3NABSGb6SgEAun1KAHB3xnBc
Y8Btcb2v4FSvG1XghK7y3x1KzvMmkAE=
=mdQF
-----END PGP SIGNATURE-----

--TETxY3uZg/QuT+Jz--
