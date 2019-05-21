Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A486A24D6B
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEULA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 07:00:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55867 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEULA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 07:00:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so2500734wmb.5;
        Tue, 21 May 2019 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ah/A2lukvDbpHRiGOZpPj5URmPK2Vy/a2P44wSu38s=;
        b=Aor3HelpyfmyjGRK39CzK56bf/wdjOTdMTdrPVKSNxTMdnbniuMQcjqU/tjUw2gW5x
         raRl3UHiRSfUGgEoEr4kNuywmJ5bL7l1iN1hkzXnHEwcXmqiZDKGH6pj5gbDpurY4MGE
         RfLj3kmQqC/rtXnAg7vBnrMQiq03v+G6Aza6gqqzY/ULFddvJu8RVB/tnN2PBkbx2WFO
         QY+2uSYJr4c3OC30CdQyhu79hIPk2sX8BXcT4kIV1vTyhTFEiiZNSSyk8PP5LMDpVJvq
         tnwhs6DqUVwQgbMdISsXdvbj89BoxXJRnkj7VXkV3NIO6CFvYyXtKkqw8YKn49WDs9hn
         j67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ah/A2lukvDbpHRiGOZpPj5URmPK2Vy/a2P44wSu38s=;
        b=h4MkREMYxw8M7DHXthWW7myIwvHJz1Nb7u0dfSTaIVasOTzdnRaLnXSFHdXxXY8ZlF
         PCanI/xBL16Hl7JQ60sBOYVKF0yVF5U9jBlzyWOAaVha0qtu3Xi2Rd6WveHsH/6USv2d
         O7PGTkBmEZUOG6OLwAjnJvTRi849JNLpJSSJFVDVcHWdvlvLP8fbBhGHst9muZxrELBl
         PCyuQhe9DXz7yXE+7ZSUEidVlw9rvShM97tW2C19bUhRayEa9a+P3HvijFvXgkPVYByr
         nnmwGGLGI0sQYK/Z69BylEZYLLxLKga0OxId9GpWU64DSz2onWQNJEqT4KFLqMC84CGK
         4DAA==
X-Gm-Message-State: APjAAAWWzqjA7xOwddL/lxzIc+gr7nUrzT4RBoGlNjEQd8HWJ4xGwM6d
        1pQ3xcDyfH42U8408/cMpK0=
X-Google-Smtp-Source: APXvYqx7e8R2F0j8IQWeqDS/r2kbmLTpKs95SqlnomFZ+00BfNy7tWFZFF1QTOG9jfkSyy3ltmbo5A==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr3097492wme.61.1558436454827;
        Tue, 21 May 2019 04:00:54 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z21sm2999097wmf.25.2019.05.21.04.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 04:00:54 -0700 (PDT)
Date:   Tue, 21 May 2019 13:00:53 +0200
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
Subject: Re: [PATCH V7 13/15] phy: tegra: Add PCIe PIPE2UPHY support
Message-ID: <20190521110053.GM29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-14-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-14-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:44PM +0530, Vidya Sagar wrote:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * Addressed review comments from Thierry
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * Rebased on top of linux-next top of the tree
>=20
> Changes since [v2]:
> * Replaced spaces with tabs in Kconfig file
> * Sorted header file inclusion alphabetically
>=20
> Changes since [v1]:
> * Added COMPILE_TEST in Kconfig
> * Removed empty phy_ops implementations
> * Modified code according to DT documentation file modifications
>=20
>  drivers/phy/tegra/Kconfig             |   7 ++
>  drivers/phy/tegra/Makefile            |   1 +
>  drivers/phy/tegra/pcie-p2u-tegra194.c | 109 ++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c
>=20
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index a3b1de953fb7..06d423fa85b4 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called phy-tegra-xusb.
> +
> +config PHY_TEGRA194_PCIE_P2U
> +	tristate "NVIDIA Tegra P2U PHY Driver"

One more thing: perhaps make this description consistent with the driver
description in the source file.

Thierry

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj2mUACgkQ3SOs138+
s6ExSw//TFkjS9gh0++pEdMlDKh7fSzke2s2bcJz/Ph4T4aO+6p6iFE6pWLbZVZ3
/7C0QwM2i18gVP1OFuOkydreo5R4sxPrSnvpUn99dYjSVHgj1lro4O7Z/rH32KgI
c/1dUoUhJu9mynuCP2VSiUwVwhsbd1wQVDXwNW7QosmqovAYhNyPJncoSLyinU8q
IuDmi3g+EUcC+ky7Hg7ba0F9plE+HJgWyvRCrNnMoWiC9AIbbV5vU0gGtVt+u2Bs
nUxq6BRVCL7Xh8rLzGfA04i1c/BD9HOxVkZ21m/SzJ7SAJqPH2ow0DKXpID0B1mu
mF9WUO0NB21kPJR/ozuzf2Z6wT/LMxNiwl+oSK0wGBYVSopuZrV8xrisy01734VV
qqOzcztHF6QZrHWHzsaRNuWgBUwJsxNq/DLpKz6GGYv6pJedwfBQjmoWSq78dOtq
uGRcIFOtqng11KY33EP6z6EhImDI3Q1t86kmMy8xydeEh1C9yjOZhw+Fa/UHRXp6
WNHFhPHBwJnu+BcMsQ1+y2eOGeMTgvcs0VbcykfkvUxxWIHJedyqCzvVHqP/Iuya
OLa32wjLLv2gUghlswSyizpwGEHcGDdH4bLsFqCZRScyjbL74g8qY6U//yyy8x3j
T4okdiJoC7OcK2Ao3f7u9Xn/nWkybyNfrHcK5a4E0Fn/H+bhG6I=
=M2WT
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
