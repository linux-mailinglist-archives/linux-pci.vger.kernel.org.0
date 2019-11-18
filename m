Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6D100653
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 14:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKRNUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 08:20:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39607 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfKRNUA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 08:20:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so18809735wmi.4;
        Mon, 18 Nov 2019 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CznWx6o2MewY8T9Kn1p86E+oBC1oRaBzPU9VecClKJE=;
        b=RMdOox4nCZPcaQTZZNevZIBUQTNnoSReBTPfIY5XRsDDf+Iu/iUSb2QFmItvVnZsoo
         cHF0+mw2JEPK+9dz65WUBDvR6fa7RwY+1nAbj6DtcfpHaU3LQM7IcNXC2m9VZ/QuxpEP
         GQoHVrq4M/SonW3Vq275MwDSlv1wHqiuDcjXTvGsx6SMaPZdhpe+bHY3zRTPRJW8r+rD
         hplUO36LBTPDLyPUZtesIqxAtpYLjvePT1C4BKbXNhhCX/Prkx/DwZU1br9iaZx7zFyt
         Wfkn7attstGUk46DYlpjs4Pge6A5pchdorUIOxR6LrO4ZHRmpzNPFoqcZ1X1y2Br3rae
         7jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CznWx6o2MewY8T9Kn1p86E+oBC1oRaBzPU9VecClKJE=;
        b=RxJUVMampWsSrtdNmYN19o8iKulTHGYsPN457/NTHvmBujyU3Oe5Az9cIyRNc32l4z
         NY2RAHGyW6CpgTNlE50Fk4/19xH3BFxQuBrnbHR1Trm7MBHaAxop6UoHAhVayIoJKaaS
         JiWKOwakkhk6OCTSm2VfseqGDtBcnuewwxZyy2riZwPop4XphSOGKWuTe0Faq5f0d4Ia
         MxjnlHHqXFtFkxfx0pitlvBk40cDrix6sXZDpk/DjtKVHDXlURBDoS4GXFZp9xOxrRZY
         psx9qa0SbotMJz1LUxlvTgbdqlvVOUSzx1gaXwjEMBqvTjUSENKkmUahIAbVBvfTA88J
         czKA==
X-Gm-Message-State: APjAAAXGrNorL/Sj3PRkbAHrKGiyMhxu8fO+T9ioIQkeGbQSRXE/0yTz
        aaggcPSGTUgxFDh7NBgpE6I=
X-Google-Smtp-Source: APXvYqyEepHC4e28Befj8Uvbh/R9vcLSo3pr6X4/H7lUiOa4VnXYrpUJG8TZ1yCdK2V0h/9m7chVUQ==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr28217684wmg.12.1574083196357;
        Mon, 18 Nov 2019 05:19:56 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id j11sm22740145wrq.26.2019.11.18.05.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:19:55 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:19:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <20191118131953.GA2246533@ulmo>
References: <1574075478-41136-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1574075478-41136-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 07:11:18PM +0800, zhengbin wrote:
> Fixes coccicheck warning:
>=20
> drivers/pci/controller/pci-tegra.c:1365:1-3: WARNING: PTR_ERR_OR_ZERO can=
 be used
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Please don't. This is a completely useless conversion. Having this
rolled up into one just makes the diff harder to read the next time we
need to add some error checking to this function.

Thierry

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 673a172..8503ae5 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1362,10 +1362,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie=
 *pcie)
>  		return PTR_ERR(pcie->afi_rst);
>=20
>  	pcie->pcie_xrst =3D devm_reset_control_get_exclusive(dev, "pcie_x");
> -	if (IS_ERR(pcie->pcie_xrst))
> -		return PTR_ERR(pcie->pcie_xrst);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
>  }
>=20
>  static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
> --
> 2.7.4
>=20

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3SmnYACgkQ3SOs138+
s6EkKg/8DH+hD0/cGbKk475LlY80c9X7TQEEydVnPKgfFy41V3kiK6hxHfcHgi4R
FEOd46hLn6fMLKVg9W739HXYzsw/vKY2Wwww+OIpuNBwn8x2wJNNCWGVSJa0s5LF
CX1z6zps9GV4cvXWBBFzBUNo9x4ATI+0Duc+FrcZdJZWTsdsNmk6SfL3p2raQ3fB
uSwofm2pJjiRgxPMx134V7UgIzApfPTRzPkmjhLHurMgRzLB59cQC7+t0pTaN4Dg
NCaC6o1FiAE4R003Agwm424ulJDChJHObhbBxO0PjgSzilGLqD38hqmrgBFzewUv
XE2EcDuc3bgHT9wWBaK0+Zv81xSM0kUfh+F876dCWirewXRWFZmXXreqydkKTStp
bp6dSmZR1VG7NkMSceNFXvQjy2rAF7w+U7XxmAdMGAYVv7xXm4amHSvgCBPnxW84
gwVOITdiJM4XLo51pPeMkq7hxa+cAmglCAJYn/XO7hy2/fvX57NV/oM7pslJ+VnV
LgAhaU4vVCSEHMt36kLx+4fwUvPH/QQ/vJ0SBwt75bDWXEcwf1/pmylP6PC4zyjz
FtNSZNWXaUvTbylT2bjz/X8iobSxhya4nieUu6HydzFNP5cOrhmOFHT9mzDlOoub
vWFG7f4Zn3J79GmBLgGRDXlKVfySGu755eOUC7zDgNYbAMK774w=
=/Bp+
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
