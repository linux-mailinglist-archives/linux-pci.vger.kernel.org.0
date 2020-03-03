Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF644177781
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgCCNi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:38:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42187 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgCCNi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:38:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id z11so4342310wro.9;
        Tue, 03 Mar 2020 05:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRymEURxG29TkCLI3sdfDoyr9GF4aobVx9HepebY0JQ=;
        b=i2HHyha2l7WtQStsxE4ZCZMX6GRBeq34abSjXuFniTbuXvl0jzB0M2oNWKpwg3BzRv
         +oLl4b5c9dAiNbIM5pLuMjCILVVw/PViw/3LtxoxvJbQDPyS/plpr+keGENeMWCAXbLX
         FGpFirPQG3nECFhfxcXCwDJ9ZRq/viSU7vKsK3q87qnHS9rg0XR84iSqVGS8FQrA1gdx
         o6mh2vfrC7JhwYM4A0Wpbr+r49kf+1FGDsWV0YSvGHf3E7K03csqQ0zp1mLMi/uAicXM
         r3CJrSKfbBcCV0LxV5dmuH21ayEOfQR04q6rMWdwSiuX1QYILodb3zos8daFHqAuIDUB
         uDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRymEURxG29TkCLI3sdfDoyr9GF4aobVx9HepebY0JQ=;
        b=tAcXiG+d523mY1K6hBVcBpT8GHpxmlDDvbTadnrchciPLJQ7dUl6rm/A+CvvqbSad/
         /l+aaBKzQJRmpVtPolUjj/AbgMHxvGpLqa9IumAcyi8Y7WZbgUpqXDMzHmcZPLT/MVwF
         pTAZWUqDmQIkIOlPZANX8rgvxZcnHTq1z1jx2rTsHhCloniCKPMZiuNLzOGZSs94UZOg
         Uf9OOJ4ZCqu9uYBWGvesSPhm6ESHmvSDE/DWoi99LoBJXXBuWYQ5srG3U3w7fylV2ka0
         WVI39P2PM8fhFnbFGfR0LqrQuhrD6Bl2eX16Qf74TlNehuxM2eNjvQ0q11S3n3nCaNKD
         HgyA==
X-Gm-Message-State: ANhLgQ1+7MN6qLxYXInDVoNI1X7M/j01/KX7OiYiwFtZ0S172cix7G86
        q86e97Mpto9jbq1YjSEPkH4=
X-Google-Smtp-Source: ADFU+vvtajUmcHxy1nP7CuGiIwApLuN21TbJVtjyuHeuiUnic+JoV9sDwPIAvu65DSjAgKrIuDsb+g==
X-Received: by 2002:adf:dd47:: with SMTP id u7mr4550046wrm.130.1583242736437;
        Tue, 03 Mar 2020 05:38:56 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id n11sm211775wrw.11.2020.03.03.05.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:38:55 -0800 (PST)
Date:   Tue, 3 Mar 2020 14:38:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200303133854.GA2854899@ulmo>
References: <20200303105418.2840-1-vidyas@nvidia.com>
 <20200303105418.2840-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20200303105418.2840-6-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 04:24:18PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Addressed Lorenzo's review comments
> * Started using threaded irqs instead of kthreads
>=20
> V3:
> * Addressed Thierry's review comments
>=20
> V2:
> * Addressed Bjorn's review comments
> * Made changes as part of addressing review comments for other patches
>=20
>  drivers/pci/controller/dwc/Kconfig         |  30 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 681 ++++++++++++++++++++-
>  2 files changed, 693 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0830dfcfa43a..169cde58dd92 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -248,14 +248,38 @@ config PCI_MESON
>  	  implement the driver.
> =20
>  config PCIE_TEGRA194
> -	tristate "NVIDIA Tegra194 (and later) PCIe controller"
> +	tristate
> +
> +config PCIE_TEGRA194_HOST
> +	tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
>  	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PHY_TEGRA194_P2U
> +	select PCIE_TEGRA194
> +	default y
> +	help
> +	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> +	  work in host mode. There are two instances of PCIe controllers in
> +	  Tegra194. This controller can work either as EP or RC. In order to
> +	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
> +	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> +	  selected. This uses the DesignWare core.
> +
> +config PCIE_TEGRA194_EP
> +	tristate "NVIDIA Tegra194 (and later) PCIe controller - Endpoint Mode"
> +	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PHY_TEGRA194_P2U
> +	select PCIE_TEGRA194
>  	help
> -	  Say Y here if you want support for DesignWare core based PCIe host
> -	  controller found in NVIDIA Tegra194 SoC.
> +	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> +	  work in host mode. There are two instances of PCIe controllers in
> +	  Tegra194. This controller can work either as EP or RC. In order to
> +	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
> +	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> +	  selected. This uses the DesignWare core.
> =20
>  config PCIE_UNIPHIER
>  	bool "Socionext UniPhier PCIe controllers"
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index cbe95f0ea0ca..81810e644b23 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -14,6 +14,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/kfifo.h>
> +#include <linux/kthread.h>

After moving to threaded IRQs, do you still need these includes?

Acked-by: Thierry Reding <treding@nvidia.com>

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5eXd4ACgkQ3SOs138+
s6EVjA/+MiWicLPXeikoOsrDyo2yGmbfVl1gjhiqLmFIk0cXDwDfBegX6JWoT9CB
p7Ffs0byZ8Bi8xza+wfpO4LVjANLOxW3DMtt4tFaOu2W+OsvaNbJasvo6X07Sr7k
I+dmrxkWuPz3mN6LFbR458HY0B7YxLDKwPzyEdYss5ETaZ3asVul3cnbDPViQY8v
tjcKk2ccScCYqAdjD4AW3ijxHECa5dEaLp13qQF76VVdHd3wyQox+SHvV9NNJo1o
d5RRTlj3z6hWsqE1Bp7hDqqYWSOg1brcpuzdy+y2sV6mWaRTXL4JQzI+B8fTPUhO
JvLZbx9JqyVtmqxq+PIekzdCGGRcqpEWL6+VIL4tWKL9OhUBJzHs/BKYW46Lx7Tv
cAdBMJkkif27Y2iUR3T00cYmKLpaCPtUXZicHglrrWDVwNVbYiiGy8WiVLsQohSj
SkRsnd7w09t/ZJ7JyzSnDfk2dR8qMBNDf64iiYhpmpXZSleF7ifla4fZrikXXnHG
HjNaSxR+Euwnnlf1rDhyfDSzJWjFvWM18wnxKydS5TwGt9wA0acTQrWrv1RePl1Y
ArDnpj1xfbhJhHEFO69Fjg9kr605SSmeXLmX+r6XR/5gkfF6FfRRyN2x3nRU9Fqb
i/AtQye/0U9iTr6Rc/NVIGD86+/Fq9gik3hhR8a5o81wRdyxpr8=
=q+we
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
