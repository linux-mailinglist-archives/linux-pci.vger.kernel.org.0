Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909481072FF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfKVNUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 08:20:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33989 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKVNUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 08:20:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so8640071wrr.1;
        Fri, 22 Nov 2019 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6sg6rDS5zsmnONV3JVTno5+5UKGIXJNaE0e1hOOttVA=;
        b=LwMro+DWviHvcawXAIPhdJi5PSeHe95tuxMmk4eMaDwhHeli14vHK63rrBLaytZBX4
         gaSOx7PJ3CGfHdepQUlIq3YTfnqBQOzl+iT4n0q/aBWAeOUJpLc0clmfZ7HK/j6OK/N+
         pe/SrMQuc5TA4FWwm/mEBbHxIXRc+0H6ENtlw3uqXJw9RA8i0By7ESmIVWmxQKJixodi
         pDSUWqfK3QeRlK45U4Zzm18W1zZ1bN6spDNvo5Dihj5gbZrw9cktKqKRaUaMw7iETrJL
         nJ/K8N5R4ZvmyvqZ6GvAC9dqrOZg8uVAPAYpPEFV3HYzGjeIrzXp3uvwj8VLaDhtDiLp
         sIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6sg6rDS5zsmnONV3JVTno5+5UKGIXJNaE0e1hOOttVA=;
        b=d1i9chdBrQ6JVKmCQxVYT8XdkEDMZO61kBL9Ju3hOkzYuwmW/mPTj6tpkgpVj/jDli
         fsH/wwfn/c7SggyGOLRZy2cJ6Rmr9xsbwnkd1QIrE2GQJQ11VeN1+IwjRcZWkoa714+M
         3yjVtfiU9qm/9vS5Jj9H/SAi/9Y2PtTMygJp5w6fjniueOQvTGk0caG3rZKW96cAC5ws
         7z3n/K55c38hzsOCuW5vMuzw0huz4hcdh8h6FY6GR/z+Fx/7v5hddMu9g5K4Gf+eGj9F
         llszNb6DpLd5rHjN3uv5mT8q6XfDF3sdMKUTzb7XewTOd/OfcuFP94/h15pem2qMudfx
         wHrA==
X-Gm-Message-State: APjAAAV+gKpApOAQWoHO5rrUlb+W5ajHKv/iN2fVnJc2CFBfzFCeU7Gp
        wDe9r2xz+xsdehqPkKFoSCU=
X-Google-Smtp-Source: APXvYqzrCqSjrtUVRHlaOa9Gk4HuJFCQ1LF9bmXEW4d7Zmwj4NkDmsR4lDd8rOe+2g7t/R+8gHhFoQ==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr18371366wrm.213.1574428810111;
        Fri, 22 Nov 2019 05:20:10 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id 16sm3808746wmf.0.2019.11.22.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 05:20:08 -0800 (PST)
Date:   Fri, 22 Nov 2019 14:20:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 5/6] arm64: tegra: Enable GPIO controllers nodes for
 P2972-0000 platform
Message-ID: <20191122132007.GC1315704@ulmo>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20191122104505.8986-6-vidyas@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2019 at 04:15:04PM +0530, Vidya Sagar wrote:
> Enable GPIO controllers nodes for P2972-0000 platform which are required
> by other controllers in the SoC for example when PCIe C5 controller
> operates in endpoint mode.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)

The GPIO controllers are enabled by default, so there's no need to
explicitly enable them.

Thierry

>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 353a6a22196d..7eb64b816e08 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -37,6 +37,14 @@
>  			status =3D "okay";
>  		};
> =20
> +		gpio@2200000 {
> +			status =3D "okay";
> +		};
> +
> +		gpio@c2f0000 {
> +			status =3D "okay";
> +		};
> +
>  		pwm@c340000 {
>  			status =3D "okay";
>  		};
> --=20
> 2.17.1
>=20

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3X4IcACgkQ3SOs138+
s6FpAQ/+JotZz8/2JN3IdtE0k+8HWLGaEx1OOv0qlI9Im7TRT6KIdSgkmlOjyWc8
3JJ8fSte/65M3AqAJl+321hN4dhmnh4VDxHXfKsmx3q5PaZr02AByCD8sCNqkpt2
/mDeVZ8rwWhtGOA3L20pPbRLeEKNlhzWPX02saLkTSH2eL34fHu/eg1YZAeW9Cu8
oNg3i/2aqHKoyMoUvXE9MlrbibcGQAB3ZL9samNeotzBYF0r/jUTPVe/8Hb/M8+l
9VFAHuw8Rv5VQCiHkiwtBZccd40PXeNISeGsrIuDPYY2MY8qmJncvYYqJLtsILyg
R2bztDz4+5F77NLP92ktl6AXfO6pR0bG+PYMMauh95yxtJ9it5I51LKXTOXSxXCy
fBmzIyR4rWYMtZE8TH8bahyR0nScsIFUlYT74w4CRchW5j4OEd/AhV/CECdPVOU0
j9ANfV1g+OCPx/J3NOSxmIJDrDIjOwKqNCofb1ijc11kVketJ1ubmObS8bgu3oLV
uE32RVxblix0IT0geVDMDP4r4z7nDNE6PmCptvhtyiVmtdSWKoMLod1nxZ7qGbT2
BrEEozE/f/kNpQvLDp1uhCdtkgOi+hxqPze6p5FJhrJJ1ftzB+mdinqgOU9Jm8yQ
En+CE7rFd5SFf2RRD/5r+bb93b8DBwNYbh1B0AGjT5EpTqi2Qbg=
=kby4
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
