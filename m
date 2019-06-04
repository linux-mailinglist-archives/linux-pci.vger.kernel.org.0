Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BC3488E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfFDNWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:22:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34549 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfFDNWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:22:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so7558881wrn.1;
        Tue, 04 Jun 2019 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imfzoOCI28c1rhcWQ19fTlkcploUXYivZXnCZNjHofI=;
        b=OjPQvmbBEMmwpJMHybcnjOPe8hMHiwomtN3ahib/o3zhJ7niVZ9FeX3oQ4jhpms4Eq
         +Q6jrZPnylDYx55WyA7HAJb/Ne2cE7USN+HsXvB34E1DOUHCi16YTLtJm00N2fYefzyA
         k/1Ivg70mNJww88vzegO9gE8fU378jGi1DFWNzRqxnNxyHEV6ja0MIih23xvB5e0UGoR
         gJk+Oni5tXB07KLqr3svakkb73aPd9bcZN3x2Qj65CmJBUnxvaWMv9aXxYXNyCbs2QrD
         AJROWvwVLADW8Df5h5gjlV23twjMgy3gygtLJld09LF0z4UHWma+y4ZMb4GOkhdMBRBk
         xZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imfzoOCI28c1rhcWQ19fTlkcploUXYivZXnCZNjHofI=;
        b=TkfYflMIwt5RbA92S2htABMp157v9Gb2BE6H4MC6WgGh2HoyMtTKKzFnKE23bOvu64
         zHzc4rRIZeBBwZBR6tw6XlmRWSZHMx04VwN53PVhtlYSNVB2ViuZV/OW7CKA/hLnN+BN
         Qa1d1w+6wHcM8d9WR9ktJZas4vo9yhG6sVj2QEghGEcl3u6XIW8NL97EOyXyBOqUsiv3
         SLrz2OtVtAMke6hZHB4I96TV49qfSHamcuc3gU9uT5uoShICKP6INoI8/GqbOZlPmNme
         /xYF4z6tQs+oLvnE3c0TxmBPrN5827rTqOeE0Y+hiD2peBs6EYvjNVdUgrsGCmq3/b3U
         bZuA==
X-Gm-Message-State: APjAAAU3C7gZWSToyYuwYQO6jBY0ETYOZEV5rNZb4YNYYhYQwp9wL0cf
        nzdgJpxPU5Urja9iC7aGd9o=
X-Google-Smtp-Source: APXvYqyjszUWPoHuZ2CTU2/u0fFp/yvcVISlmohtTEs9gj7yWGudJNM2+xDmOtpZxl5rktEv4mTBKw==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr20058534wrq.156.1559654555674;
        Tue, 04 Jun 2019 06:22:35 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v3sm7816181wmh.31.2019.06.04.06.22.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 06:22:34 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:22:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190604132233.GT16519@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-28-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-28-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 11:23:06AM +0530, Manikanta Maddireddy wrote:
> Add support for GPIO based PERST# signal. GPIO number comes from per port
> PCIe device tree node.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4: Using devm_gpiod_get_from_of_node() to get reset-gpios
>=20
> V3: Using helper function to get reset-gpios
>=20
> V2: Using standard "reset-gpio" property
>=20
>  drivers/pci/controller/pci-tegra.c | 41 +++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 06b99fcbf382..09b4d384ba38 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -17,6 +17,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/export.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> @@ -400,6 +401,8 @@ struct tegra_pcie_port {
>  	unsigned int lanes;
> =20
>  	struct phy **phys;
> +
> +	struct gpio_desc *reset_gpiod;

Nit: I'd leave away the "d" at the end there. Or perhaps even the _gpio
suffix entirely. But it's fine either way.

>  };
> =20
>  struct tegra_pcie_bus {
> @@ -583,15 +586,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie=
_port *port)
>  	unsigned long value;
> =20
>  	/* pulse reset signal */
> -	value =3D afi_readl(port->pcie, ctrl);
> -	value &=3D ~AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (port->reset_gpiod) {
> +		gpiod_set_value(port->reset_gpiod, 0);

So is this actually deasserting the reset pin, or is it asserting a
low-active reset? I think it's the latter, because ...

> +	} else {
> +		value =3D afi_readl(port->pcie, ctrl);
> +		value &=3D ~AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
> =20
>  	usleep_range(1000, 2000);
> =20
> -	value =3D afi_readl(port->pcie, ctrl);
> -	value |=3D AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (port->reset_gpiod) {
> +		gpiod_set_value(port->reset_gpiod, 1);

After this the port should be functional, right? I think it'd be better
to reverse the logic here and move the polarity of the GPIO into device
tree. gpiod_set_value() takes care of inverting the level internally if
the GPIO is marked as low-active in DT.

The end result is obviously the same, but it makes the usage much
clearer. If somebody want to write a DT for their board, they will look
at the schematics and see a low-active reset line and may be tempted to
describe it as such in DT, but with your current code that would be
exactly the wrong way around.

> +	} else {
> +		value =3D afi_readl(port->pcie, ctrl);
> +		value |=3D AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
>  }
> =20
>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> @@ -2238,6 +2249,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *p=
cie)
>  		struct tegra_pcie_port *rp;
>  		unsigned int index;
>  		u32 value;
> +		char *label;
> =20
>  		err =3D of_pci_get_devfn(port);
>  		if (err < 0) {
> @@ -2296,6 +2308,23 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *=
pcie)
>  		if (IS_ERR(rp->base))
>  			return PTR_ERR(rp->base);
> =20
> +		label =3D kasprintf(GFP_KERNEL, "pex-reset-%u", index);

devm_kasprintf()?

Thierry

> +		if (!label) {
> +			dev_err(dev, "failed to create reset GPIO label\n");
> +			return -ENOMEM;
> +		}
> +
> +		rp->reset_gpiod =3D devm_gpiod_get_from_of_node(dev, port,
> +							      "reset-gpios", 0,
> +							      GPIOD_OUT_LOW,
> +							      label);
> +		kfree(label);
> +		if (IS_ERR(rp->reset_gpiod)) {
> +			err =3D PTR_ERR(rp->reset_gpiod);
> +			dev_err(dev, "failed to get reset GPIO: %d\n", err);
> +			return err;
> +		}
> +
>  		list_add_tail(&rp->list, &pcie->ports);
>  	}
> =20
> --=20
> 2.17.1
>=20

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2cJkACgkQ3SOs138+
s6HSFw//eP/VCDXncQLm+r5DEpanlW+Sq3fRXMjdM9VBwcndbfAme7NHXjnOzXiv
6wCwXa9PD/DVqV9hAt7Vp4rmaBqrIGZGv8RL+74qpawXfCfUBmmDsIkRsWkCGa5c
GtSnisdLeYkjmk0cL4djm78yRQOiFcKe1xQIfJ4iK4NJHO92KhUbi4TDUx1d2fHM
Q33r7jd8U536pLi0GMmENddS6Zy6tzp7j9rGbRHpkAdNQkv9dKUAVEONT5CpWhjM
KCmFNFOb7uo68sIBXUSQUuhKEt1+j779vlKkTQovih4LjyDmt4bDrnmGrwpu6H2U
8xik/vrigI6vrda5y8aeSCHPMMez/rybl9t2av8gEX4auOus7Q19IKQmDeCaM2/w
ecobgKwHb6teyJhYVW99igSKZps6bLNiM9SMmQ2bQ5nrA2G0mJNB52/Vywn2CR4k
GKtnNSIh9QA5pR3Ib6VhWRlYQ6J+tBB6iW0nqoWvyZVXd0t3mUerin8whik9xS/w
PKKSzuUtztt0Bv0qGcGnlI9kr7h6NU20rilC8WC3ZsSDEA18N9okKFlU2o4IsMWd
2GIPJjqTuWewusxLv19Xj6zknZXNoU+acWFBCwq9WuqZccTZlEl0cYffdyoBuTB/
4IGYVsrmA51fq+hIPM9yQgyjm/+REYfGAhVYyUj1wXM0NnwWdEM=
=fEUv
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--
