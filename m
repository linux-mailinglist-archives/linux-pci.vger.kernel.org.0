Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B8612C5D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfECL1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:27:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54109 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECL1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:27:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so6684382wmf.3;
        Fri, 03 May 2019 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+STCk8lkhn2EMGrmWWOJnwKAHaye6MrOKuwobW7Ffyw=;
        b=Hn0+ae2RVQUkEg8KJ9vqDa6wvcfoucf5Bkh5dCex2giBknGyExKhLscPZNBMctQyiS
         vj6IW8k8OlAIBqGtXyRbl65EWeEvHqIoP5rp6wiPXbc2r6QRxJq85R8u/Igdl5HMqlZQ
         cAq8UTqF/s9oxgnxWWu1SgPGbVqjEdGMOvfrkyqVArd+HmG3iB29yeXCBMLZrzB7otxl
         Dnm4kKrJAT1OQ9wFZqxhdfTHbkjWXCbo3SAPF5zuUx4Xf9Z6lwuAbv7Ja1FZIytgyUrt
         fohOb8XJFrdeTs+ExhyQaLW+fkXkmexL/lbI88wn3lgeN67vP85wx/bhtPT2rDUiQ8zw
         3zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+STCk8lkhn2EMGrmWWOJnwKAHaye6MrOKuwobW7Ffyw=;
        b=EoWxNFfk9146MKZ7Qg0l7gMSagqRE93vhY4+wd1+4WL9kFAMV9u1D7kbaK1S8P/eDh
         BnEzqd5u+DkAv/8b6BTsGVfpUPkS+PvpUTCIDZWF/YeWQ+v+kJ1H/r9PwFg+dL3R4bcD
         Lq2sqhl9fejTeeRi+Uw59nit1iX8ghrrnAVB36kyV/h89nUgGKfheCGJ/+F0n95S37aa
         f6mR4qxtJlzHZhq0O1P7QLX0IjsTvuFVibj0ZEmxGo4hTCh2W8wmkCUrV0+poyrfGTyO
         GgDHnrYihd8AMJxt5ux99c//HrB5G6LIuDVNGW7WI6RNLx7viCigf/slJphdj37/9nDP
         6frA==
X-Gm-Message-State: APjAAAVOA7kySUR4kdgPw5n5mvtaqSzyCGSJkt5X6ZGVM5Xr0rx+SvWa
        gvj2DStxhO0TkeReoq5XQYA=
X-Google-Smtp-Source: APXvYqwQrxKNaLICLGkYq38/wgnqvaPrZNOSheS067NT8/BmmHPNXUeg9NSyFiuVMn7NIkQ0UQJzGg==
X-Received: by 2002:a7b:c053:: with SMTP id u19mr5695704wmc.63.1556882873012;
        Fri, 03 May 2019 04:27:53 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id d29sm1413751wrb.61.2019.05.03.04.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:27:52 -0700 (PDT)
Date:   Fri, 3 May 2019 13:27:51 +0200
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
Subject: Re: [PATCH V5 13/16] arm64: tegra: Enable PCIe slots in P2972-0000
 board
Message-ID: <20190503112751.GG32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-14-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-14-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:50:01AM +0530, Vidya Sagar wrote:
> Enable PCIe controller nodes to enable respective PCIe slots on
> P2972-0000 board. Following is the ownership of slots by different
> PCIe controllers.
> Controller-0 : M.2 Key-M slot
> Controller-1 : On-board Marvell eSATA controller
> Controller-3 : M.2 Key-E slot
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Changed P2U label names to reflect new format that includes 'hsio'/'nvh=
s'
>   strings to reflect UPHY brick they belong to
>=20
> Changes since [v1]:
> * Dropped 'pcie-' from phy-names property strings
>=20
>  .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  2 +-
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 41 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra194-p2888.dtsi
> index 0fd5bd29fbf9..30a83d4c5b69 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> @@ -191,7 +191,7 @@
>  						regulator-boot-on;
>  					};
> =20
> -					sd3 {
> +					vdd_1v8ao: sd3 {
>  						regulator-name =3D "VDD_1V8AO";
>  						regulator-min-microvolt =3D <1800000>;
>  						regulator-max-microvolt =3D <1800000>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index b62e96945846..7411c64e24a6 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -169,4 +169,45 @@
>  			};
>  		};
>  	};
> +
> +	pcie@14180000 {
[...]
> +	pcie@14100000 {
[...]

Again, these should be sorted by unit-address.

Thierry

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMJbcACgkQ3SOs138+
s6HqvA/+M9cG4kk4zwslByULuSa3GW5lU3VrIoR10dZx2JrclNuFl6eQDq7V4k+j
deUegnpbG0goInypfsnJjE1+hIea6yuNBfNdJjSlZFh5rQHkUMTQjn3S+N50UHEL
otKt7xqpY963RRujKLQg+E+SUNi9unfKWy3hK2UhaZHVO77bP7hcsV7ViukhPwD3
mPKyhbC5JEFjj4rPCGbLYfc2JhE0Gn7/f6Y9AZtIjIOm6MWSJwQyfcPMRkhlnnxn
J++oHYUprmbOtJ91v8Wm3RFj19UmDDgac2cqxivu+p4JlH3FgJc7LRZsBr46OQcm
hBwpLOQWcyDYx9hHOBbZZl7XuYb1wQQMhQMZzKapkcgNnRGKnN/Yhbm+Ac4ekopZ
UKN/v4MEmHM9DpTgzVG+A3i6iTIvLJsQt3/vwgTfO65FwYUo8wUigUQJIPiSvtOJ
OGtM18DBINzIJVGuPzcAMLiVNJb1p1mECu7fyS+/tgHT2xS55D3Q5QIpFiqvhqAG
Vd81Jim/e2dBO0kJ17wSWbSM77AN0ETMkngiB7Jc3A98R5bNVQvwtGBq0xfRE1Yp
R8KHqW7TP2/Iin6yJywqg6OyK7SBMlP+Mh1pU6rfz94JQ1CKCl6w/9zG0/tzMapP
SQckzgvfGXJrSbBq7K/RQKbNdrC5f9cNKoPCXaqwze6sx5qw7L8=
=/a8a
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
