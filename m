Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD73818B69
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfEIOOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:14:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37231 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEIOOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:14:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id y5so3433472wma.2;
        Thu, 09 May 2019 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0EeZ9Zgv1njSgiZTS/taQaV9MALqwUHr13/+iMfXnLY=;
        b=hqmy+GzXrfB+1GuVkpmfpzXe39ym2ojXaiJL+tv27B2PXNClIbXFIF9NZtlXs0ItZP
         z6CuVplSvucdJFNn40tChTaN7b0M6RO+f2xbdZL80REgrMsUGyIwS+5W6x0ueebejX+0
         zd/0bJkQRzN6Fn0AF8VxA+7dQWbfSztYnaHPPy4CedDtYcmyeMQStFRfbFbqTNR3XiLA
         +w6Ix1aA+ehhNDXHQGzZ6LEpdHzg7OgAE/5jbx0o5VsKLE9imBbQzImiTUmVHjBQI6/Z
         DeDdVKafaNximsNsiuTMrWhbHmDEBzKDY59OWB9FIhvcxZo1su5pZZ3cqj7MG0UcY7Q0
         +Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EeZ9Zgv1njSgiZTS/taQaV9MALqwUHr13/+iMfXnLY=;
        b=KoqImr1Ik+sBDZeBxQ+Pngc4MthqVpFCGpCKrwRd/VU+ph/udOL3K0caOsk+RR7isV
         o1GBq1GFuKe70Bs6FyTnkfL9YDFCxa2BFx28KLtZxcxUQ6bN0MHYC7vkNlLc5z/9y8UA
         aALf9VZKhbVHDYvmvOCb2231xCW77DgSsBeLt6DzU83mXy9eCVGgkS99qjWJ2Iwl3qyQ
         doRbV+zPvSxuHo4BGpLrNLaUzgupoVwbkFolf5WQ1pVP2wSv4iZl5KrPmoNjc05hnotu
         PDOmm8r60CwGloigCbHpEGNyc3iJs5ZEa6rvYPwa4+9uZAx6Jm2dV5bOm0ALxKPfYhH4
         pvCA==
X-Gm-Message-State: APjAAAUmmP713dFmxVW13Ck7c6RNNxLv8Chah65PVxvKD7TCauh9mXqy
        6fdT1Dd0k/AdbuBUe5fnOkHPTtpz+tI=
X-Google-Smtp-Source: APXvYqxqwgme8u8XTaCTx46fjKDo6RdW/wlB5EZSan+DH2wbY3Dzy4foNJlN5GwNRjb7MvcX0/qc8g==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr3160340wmb.82.1557411280723;
        Thu, 09 May 2019 07:14:40 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c131sm2695991wma.31.2019.05.09.07.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:14:39 -0700 (PDT)
Date:   Thu, 9 May 2019 16:14:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 05/28] PCI: tegra: Fix PCIe host power up sequence
Message-ID: <20190509141438.GE8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-6-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-6-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:02PM +0530, Manikanta Maddireddy wrote:
> PCIe host power up sequence involves programming AFI(AXI to FPCI bridge)
> registers first and then PCIe registers. Otherwise AFI register settings
> may not latch to PCIe IP.
>=20
> PCIe root port starts LTSSM as soon as PCIe xrst is deasserted.
> So deassert PCIe xrst after programming PCIe registers.
>=20
> Modify PCIe power up sequence as follows,
>  - Power ungate PCIe partition
>  - Enable AFI clock
>  - Deassert AFI reset
>  - Program AFI registers
>  - Enable PCIe clock
>  - Deassert PCIe reset
>  - Program PCIe PHY
>  - Program PCIe pad control registers
>  - Program PCIe root port registers
>  - Deassert PCIe xrst to start LTSSM
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Error cleanup changes are moved to new patch and only sequence
> correction is done in this patch.
>=20
>  drivers/pci/controller/pci-tegra.c | 51 +++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 8c0ad038699d..ed0cfd355b28 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -949,9 +949,6 @@ static void tegra_pcie_enable_controller(struct tegra=
_pcie *pcie)
>  		afi_writel(pcie, value, AFI_FUSE);
>  	}
> =20
> -	/* take the PCIe interface module out of reset */
> -	reset_control_deassert(pcie->pcie_xrst);
> -
>  	/* finally enable PCIe */
>  	value =3D afi_readl(pcie, AFI_CONFIGURATION);
>  	value |=3D AFI_CONFIGURATION_EN_FPCI;
> @@ -981,13 +978,11 @@ static void tegra_pcie_power_off(struct tegra_pcie =
*pcie)
>  	int err;
> =20
>  	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> =20
>  	clk_disable_unprepare(pcie->pll_e);
>  	if (soc->has_cml_clk)
>  		clk_disable_unprepare(pcie->cml_clk);
>  	clk_disable_unprepare(pcie->afi_clk);
> -	clk_disable_unprepare(pcie->pex_clk);
> =20
>  	if (!dev->pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> @@ -1015,25 +1010,19 @@ static int tegra_pcie_power_on(struct tegra_pcie =
*pcie)
>  	if (err < 0)
>  		dev_err(dev, "failed to enable regulators: %d\n", err);
> =20
> -	if (dev->pm_domain) {
> -		err =3D clk_prepare_enable(pcie->pex_clk);
> +	if (!dev->pm_domain) {
> +		err =3D tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
>  		if (err) {
> -			dev_err(dev, "failed to enable PEX clock: %d\n", err);
> +			dev_err(dev, "failed to power ungate: %d\n", err);
>  			goto regulator_disable;
>  		}
> -		reset_control_deassert(pcie->pex_rst);
> -	} else {
> -		err =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
> -							pcie->pex_clk,
> -							pcie->pex_rst);
> +		err =3D tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
>  		if (err) {
> -			dev_err(dev, "powerup sequence failed: %d\n", err);
> -			goto regulator_disable;
> +			dev_err(dev, "failed to remove clamp: %d\n", err);
> +			goto powergate;
>  		}
>  	}
> =20
> -	reset_control_deassert(pcie->afi_rst);
> -
>  	err =3D clk_prepare_enable(pcie->afi_clk);
>  	if (err < 0) {
>  		dev_err(dev, "failed to enable AFI clock: %d\n", err);
> @@ -1054,6 +1043,8 @@ static int tegra_pcie_power_on(struct tegra_pcie *p=
cie)
>  		goto disable_cml_clk;
>  	}
> =20
> +	reset_control_deassert(pcie->afi_rst);
> +
>  	return 0;
> =20
>  disable_cml_clk:
> @@ -1062,9 +1053,6 @@ static int tegra_pcie_power_on(struct tegra_pcie *p=
cie)
>  disable_afi_clk:
>  	clk_disable_unprepare(pcie->afi_clk);
>  powergate:
> -	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> -	clk_disable_unprepare(pcie->pex_clk);
>  	if (!dev->pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>  regulator_disable:
> @@ -2114,7 +2102,12 @@ static void tegra_pcie_enable_ports(struct tegra_p=
cie *pcie)
>  			 port->index, port->lanes);
> =20
>  		tegra_pcie_port_enable(port);
> +	}
> =20
> +	/* Start LTSSM from Tegra side */
> +	reset_control_deassert(pcie->pcie_xrst);
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>  		if (tegra_pcie_port_check_link(port))
>  			continue;
> =20
> @@ -2129,6 +2122,8 @@ static void tegra_pcie_disable_ports(struct tegra_p=
cie *pcie)
>  {
>  	struct tegra_pcie_port *port, *tmp;
> =20
> +	reset_control_assert(pcie->pcie_xrst);
> +
>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>  		tegra_pcie_port_disable(port);
>  }
> @@ -2490,10 +2485,12 @@ static int __maybe_unused tegra_pcie_pm_suspend(s=
truct device *dev)
>  			dev_err(dev, "failed to power off PHY(s): %d\n", err);
>  	}
> =20
> +	reset_control_assert(pcie->pex_rst);
> +	clk_disable_unprepare(pcie->pex_clk);
> +
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_disable_msi(pcie);
> =20
> -	reset_control_assert(pcie->pcie_xrst);
>  	tegra_pcie_power_off(pcie);
> =20
>  	return 0;
> @@ -2515,11 +2512,18 @@ static int __maybe_unused tegra_pcie_pm_resume(st=
ruct device *dev)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_enable_msi(pcie);
> =20
> +	err =3D clk_prepare_enable(pcie->pex_clk);
> +	if (err) {
> +		dev_err(dev, "failed to enable PEX clock: %d\n", err);
> +		goto poweroff;
> +	}
> +	reset_control_deassert(pcie->pex_rst);

Can you use a blank line after block statements for better readability?
With that:

Acked-by: Thierry Reding <treding@nvidia.com>

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUNc4ACgkQ3SOs138+
s6GwcxAAhjKVj8xAhGAYir+ZEOw4G7yNvcJJUxDEisD7WARQvdPYIhLM/z5wL3N9
8eVS4u6syoyIr7Jb6xx5J7lgXRaeIjMwdus73yV0hkMcCE0oTgWed/8/t4k2AUpI
p0EaI3Asfazt+3xgynY2qNzgJk0phJF1r/umVZaqDsDSrMIlb7Lz10wTCfff0+HB
Ttil5aEEbH/qezKQwgArYyM+R0Rd3dQpfpwXacgPclwqmArQKuSZMdBktTt7/veW
hPSJczYezSqxYJQND8VEk2Q41g/HVPA5WxPHt/ClrP1QpjXVYju3HafEHbESM94z
AGxMcdxgO8IJNtC7blj7EabV3z2e0Ag2cavJjBFG5mcTBk2m2bbdtGUxywNQy11s
a4YANcodrqfAXY/CC4L69DWaA7yTXUFYq9JiHyvuAAn4BOgYABg9W+28bwv1ccg4
iAeZ9KEnD8zFs++4S6WEA3AwGIzZ7juzwn4ArTd9RBMS517+YePL9nnx+lXuEgBY
X7J4R/0QwZba/Yh3KOePWG5z44BKNeV/RzinBStzsi6ikf1oVDWuSH74Q1RJuWcd
ns051v/hGFijBI5DE88xG3Ml/kkbmGt8vEdYUT5HILPSramM2N92A//4uzhhoVBu
XOSM+iFeMBTGiLPuuj48zWtpuAnDNBil+RbB1LVnRstBtGLEDPQ=
=6dUx
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
