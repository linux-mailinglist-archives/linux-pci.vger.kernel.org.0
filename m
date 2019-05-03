Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63B12BF0
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfECLCE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:02:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34203 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLCD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:02:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id e9so7360022wrc.1;
        Fri, 03 May 2019 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGfgCQXG08efjjx2XWvqXdQV7y9Ll65hvnLfZn3O1ag=;
        b=bgWOxyzuPG//QO2JUiLSKloKw++xzOzO4bBxyiHmHbyJIK1PggjN3UQ+TaymK810Pu
         Ancw4z6IABPZColxV3nbSsFbOyh5GLhSpSSw3CcxpiFmLREAr0XkGyTwp2aZgpSXUISA
         zfX9l/hrJ76Yfj8mqDKmpiKkuCkPyBGZ+HwABA/fWnKh1fjMML4dburNQSZqC/HrmEnI
         nMxegD0LT1/WjgLYeT64jzkKSvOGBSwr0Ph2m7wQW57c7eQf3VpYUyuGzUnN2/NI/2V8
         jCn3gLgzIZFg1KsovV8Xb5h8ciQI159W0G/hsmnIV5aroqKatBfhcuqDIrlK1RV72dMH
         k7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGfgCQXG08efjjx2XWvqXdQV7y9Ll65hvnLfZn3O1ag=;
        b=LBJujmcLeO6/jEOmLcZMiNBwLI7F96ZmgvHAqxbn8WszH9lCgCEdK8oSG+wDnp7pe2
         A8OxbfTZo5Fk4IaDmydDP9sOxHEV86KPmrXhG08Ur5XZgk6OQvJ6D/jlBl1xvdA/3N+V
         Ox6YAAE+2jM4Dk3okKWf04kdt1c123/nMICI7l5UNevZrIcX14oQrD7WDRDGlAsZy/ne
         XL/piQRBZVjmqgPN9XM4kjgarV8MZ3LbljvfuLyVQGW/05eg0jykEdtmUwAhiQPLavn/
         6ehIPMtbpLEk5ZtRe25CgRPbpV6cnWCvYNTcTW2fWIPOWUTlfYiTZ4G0mTZgHAYIxUTt
         56yg==
X-Gm-Message-State: APjAAAXECwt3BUKdzSNszVz/gMJmrSbxnL6W+XF1/iM/Y9OWp8CWLymz
        q9aGCOZEmVpcv1yzMDoH1XE=
X-Google-Smtp-Source: APXvYqyZrCi9BgSuSGPoKfa+sfrnKJfwljqkgF9FkpEdGOxfOe/jX4Ra5F+4c3H7nv9LPTNjKbL2ZQ==
X-Received: by 2002:a05:6000:9:: with SMTP id h9mr6692149wrx.194.1556881321143;
        Fri, 03 May 2019 04:02:01 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x18sm1635766wrw.14.2019.05.03.04.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:02:00 -0700 (PDT)
Date:   Fri, 3 May 2019 13:01:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 02/16] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190503110159.GB32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-3-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:49:50AM +0530, Vidya Sagar wrote:
> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
> using this API be able to build as loadable modules.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from [v4]:
> * None
>=20
> Changes from [v3]:
> * None
>=20
> Changes from [v2]:
> * Exported pcie_pme_no_msi() API after making pcie_pme_msi_disabled a sta=
tic
>=20
> Changes from [v1]:
> * This is a new patch in v2 series
>=20
>  drivers/pci/pcie/pme.c     | 14 +++++++++++++-
>  drivers/pci/pcie/portdrv.h | 16 +++-------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 54d593d10396..d5e0ea4a62fc 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -25,7 +25,19 @@
>   * that using MSI for PCIe PME signaling doesn't play well with PCIe PME=
-based
>   * wake-up from system sleep states.
>   */
> -bool pcie_pme_msi_disabled;
> +static bool pcie_pme_msi_disabled;
> +
> +void pcie_pme_disable_msi(void)
> +{
> +	pcie_pme_msi_disabled =3D true;
> +}
> +EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
> +
> +bool pcie_pme_no_msi(void)
> +{
> +	return pcie_pme_msi_disabled;
> +}
> +EXPORT_SYMBOL_GPL(pcie_pme_no_msi);
> =20
>  static int __init pcie_pme_setup(char *str)
>  {
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1d50dc58ac40..7c8c3da4bd58 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -125,22 +125,12 @@ void pcie_port_bus_unregister(void);
>  struct pci_dev;
> =20
>  #ifdef CONFIG_PCIE_PME
> -extern bool pcie_pme_msi_disabled;
> -
> -static inline void pcie_pme_disable_msi(void)
> -{
> -	pcie_pme_msi_disabled =3D true;
> -}
> -
> -static inline bool pcie_pme_no_msi(void)
> -{
> -	return pcie_pme_msi_disabled;
> -}
> -
> +void pcie_pme_disable_msi(void);
> +bool pcie_pme_no_msi(void);
>  void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
>  #else /* !CONFIG_PCIE_PME */
>  static inline void pcie_pme_disable_msi(void) {}
> -static inline bool pcie_pme_no_msi(void) { return false; }
> +static inline bool pcie_pme_no_msi(void) {}

This looks wrong.

Thierry

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMH6YACgkQ3SOs138+
s6E4xw//dFTo8a4I8XRjFuw8mmRxoi0ZrVcgaoQ/hqpIqu/cew7PXc9XaqiB0JIK
KJjArrSz8XHoez/vrmk4CBNk5ECEAeVV6Eyrm3R99fPoBuBihH+B3QYkeMALa6hh
l2WUQRuDIYbRF71GjZlcgslAqZ8Bde19bxdwPg1T9kyOZmQrAiFq/PsRUPGscz1T
b5EVJMR+GiKQ/dceyluUz1bqp0JFpdX6Ae6IgCKrw2Z1plVvGi39Pzix1Za1Q3pY
EAlwOo6cebEhx0D7j/W/PLQM8+nQhBBAZiUWlwCOq/lsaL8Gt3r0RoLZchbX11Fp
hOmz1535bjHaUx/NT6zz2QgKvJ8tErCCooq+RUlubv6QLdOTIegaLDVpCAa4CsTv
wByyM7+oWwCvmIkWmv+nfllINKUiRFZOWASJ7aXAQh/1GGpx6wU/eaI+fbGMI/XJ
c0n031xH/GPAL5fx9BnX5M0mYBUkxTEWWvMuAwrodEtJEqc++RIs9CHGXNICSqPs
39NNzOS3tlhFDdR/KMe86vNYl8vfhjbM7m5v+8hmLwi4tOFO2KYY4KUXHNSgfnIi
tMbUOjs3ojI3E3vvLqiYYPQ1F0xLCuY1KshgaZ/V7tdqn/pzPQtYaEedA3jh7XVd
FVqPM1w7coRP7ty0PfJtfkUjOiV16jmSZdeMbzIJUqd7+9u5h74=
=+xfr
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
