Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9618C35
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEIOpd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:45:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEIOpd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:45:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so3425733wrm.8;
        Thu, 09 May 2019 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+j6enYkOBnSNkyu2eM7te0ntdtQJlHA891U/RcLzMOk=;
        b=kHe04ueLrXXM9xAYkzCl/tdnpOFhua3fwQg4FFoeQ52eAyKgtfGKUOcUgxg542fWrH
         2KQhPbIhOqbtfRj//JoNRQilkvcOBbcRmTatcJ6GC2lqOuT1KqhUXw5/7gXz+44A4mZr
         cn54lXSug2YzBXx4bwx9WYZFwquHCMBrNAtpEQyzkkxZEssWO9jN6csI5kq805PpQWzI
         vRhP3cv+X2JHUGWejMfWrySXLXLI7TWJ6lU4iyN4biSpQF3mkcI8ArfI03ZLTlEIP0p9
         YaSZtbgWInwNuQT0cQkcxHz1UJsz3mjsy9+exVSheE5EJOlZjvrzbq20UXQEZPGubs4x
         lvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+j6enYkOBnSNkyu2eM7te0ntdtQJlHA891U/RcLzMOk=;
        b=S+eXGsNEwCwmXyiJz6GphFrn2uzqJNV2Yq+REff2hgtVkKFQPtfnUXfa3ufEVccf0e
         5gC75E6h5KCYJMRt3uXXe7ogSSNCRjN0gYFgmVNA6nWgZ1K+X39IELqlOesbKKTdhIqr
         gd4HUQSStTJmJqwM/Ty8G9X9R25DGjSSSEW2zm/IH0lEVTRsv43aIGXUok8qoKCSPvpp
         Uww0H+90HZENh94o4e2TUeTKaQVUyz0iFndjtVk6Y8baG9yWypygWH9cs/tDEFUHZSlC
         dG3tXo6pa6Yqbz6T3BbsOQyhDu21+6qTqPBIbxElokTJuOhZJy13blJhwBILkLEwcrhk
         nOwA==
X-Gm-Message-State: APjAAAWqtUDAUpkONPXhrX4mXCxY59S2lHPINuTDYtDYyxhkXcJXSaqz
        4JWtCzlVcCHnqutDJKxb3Do=
X-Google-Smtp-Source: APXvYqwPUayhHjNPJSch0iyycrJiUPgfYnBHtqIvmVX8IHBFD+1qP+oBJpmFODSeisfJvP0n+1Rsvg==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr3394468wrr.63.1557413130481;
        Thu, 09 May 2019 07:45:30 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v184sm3678347wma.6.2019.05.09.07.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:45:29 -0700 (PDT)
Date:   Thu, 9 May 2019 16:45:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 27/28] PCI: tegra: Add support for GPIO based PCIe
 reset
Message-ID: <20190509144528.GX8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-28-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dQ+ozEaLk2y6HH72"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-28-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dQ+ozEaLk2y6HH72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:24PM +0530, Manikanta Maddireddy wrote:
> Add support for GPIO based PERST# instead of SFIO mode controlled by AFI.
> GPIO number comes from per port PCIe device tree node.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard "reset-gpio" property
>=20
>  drivers/pci/controller/pci-tegra.c | 36 +++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 72d344858e25..09b3b3e847c5 100644
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
> @@ -26,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> @@ -400,6 +402,8 @@ struct tegra_pcie_port {
>  	unsigned int lanes;
> =20
>  	struct phy **phys;
> +
> +	int reset_gpio;

Please store the struct gpio_desc * here.

>  };
> =20
>  struct tegra_pcie_bus {
> @@ -583,15 +587,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie=
_port *port)
>  	unsigned long value;
> =20
>  	/* pulse reset signal */
> -	value =3D afi_readl(port->pcie, ctrl);
> -	value &=3D ~AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (gpio_is_valid(port->reset_gpio)) {
> +		gpiod_set_value(gpio_to_desc(port->reset_gpio), 0);

Then there's no need for the conversion between the integer and the
descriptor.

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
> +	if (gpio_is_valid(port->reset_gpio)) {
> +		gpiod_set_value(gpio_to_desc(port->reset_gpio), 1);
> +	} else {
> +		value =3D afi_readl(port->pcie, ctrl);
> +		value |=3D AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
>  }
> =20
>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> @@ -2299,6 +2311,18 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *=
pcie)
>  		if (IS_ERR(rp->base))
>  			return PTR_ERR(rp->base);
> =20
> +		rp->reset_gpio =3D of_get_named_gpio(port, "reset-gpio", 0);

You can use devm_gpiod_get_from_of_node() to achieve this. Also, that
function allows you to pass in flags, so you no longer need the below
extra step to configure the GPIO.

> +		if (gpio_is_valid(rp->reset_gpio)) {
> +			err =3D devm_gpio_request_one(dev, rp->reset_gpio,
> +						    GPIOF_OUT_INIT_LOW,
> +						    "pex_reset");

Perhaps we want to include the port in the label somehow?

> +			if (err < 0) {
> +				dev_err(dev, "failed to request reset-gpio: %d\n",

Something like the below would be more consistent with the rest of the
driver:

	"failed to request reset GPIO: %d\n"

Thierry

> +					err);
> +				return err;
> +			}
> +		}
> +
>  		list_add_tail(&rp->list, &pcie->ports);
>  	}
> =20
> --=20
> 2.17.1
>=20

--dQ+ozEaLk2y6HH72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUPQgACgkQ3SOs138+
s6HTshAAo2nf73sYvfmc+JCqaBR7ml4YFK+9SSm6ElRVC5cTk5lg3smZ24UgVk+1
jjECxHHPNRBlB66HEiz0Q6sZX65pY2bl5J16Dh98Ud+qMmccb10iWB5EF5OPZxar
fx5iM7rxmTvwxEVruILwbP5JqZq3cIoRmaM3GbSWD6OCRMEAhPqCqZD9kHymAf34
ZME75DKF4oOgJzcPJpIkWmyEwdJAX8Eb+UmDLEzSa4J2MyXfoYScH5+EeKfwZLdj
ros2sqkdac4v8Abz/tWKjXkg1A5ogKSubGzJgOMHc/X0bWX9mKqrE3ScEIcjQoNp
OrhzREgUPHiEIoqPCgC1ZUywiYQcHUt5bl7uU3RyM+pltOnI4ZIB2OD1BjSQ8VtN
4sQLqMivSlTOAAzatQwbyA80Z6+HRUxoOx71nmTnS5XKlxYJWRPPsV/qwEzO/75V
/JZHpCIUtO/UfHi5X9Ik80fXmBLTZ60V+g9TCqjalVNJ5HAugAWZVyMaCYO8m/qx
r70cSCFgC4Zzek4VPNwzqXelu900cqDjLsy73nJWQn9a/vG9T6uFvt6a1T3ZjuO2
LvOfvuJ1sKF3AijVJ7uHw8rOAsbhGH7/fap/XpHG/t5lq/fRuJG8gRI/7YYm9fR9
r1YixEr1koRlLcEePJ8pW5plztzgpFeEA9L2IdDW1ili6OrZgDU=
=rsaI
-----END PGP SIGNATURE-----

--dQ+ozEaLk2y6HH72--
