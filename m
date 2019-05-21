Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4372824D4E
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfEUKzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:55:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52729 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUKy7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:54:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so2490807wmm.2;
        Tue, 21 May 2019 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17nYfbdzzIwCOeEA+32Sv30sZvfqih6k6/KJfQXHU0U=;
        b=ZeCYc5/F8knOo4+9a9x6Xq+QFpVOaFI3oIhMnprKcgXcpS0kD1HJciICKcvMlghVW0
         XfCl+74pJ6lL6G113gPktUgcftO4/FlnnjbiPOLrTZDSKGg5HHEUWd+4Cb+9Cd+ADIt/
         xpvfN1/LZjXz5OwL5kj7NUy58RxlnTo7kTgJPRKNy0E2Ue4hxsX9YDXcxe1kYVglKBEo
         dmUC+Oeiw5Img+KeBRlGuX8erP29OpjFE7kWGMG89WJR2wRKoLjIbWEkNXiEY2sp8Pbh
         CvguTnOhYmiwt65ikaarYkabr/g4bzFtFYHlcbCRamQ1gHzQv4pp3EEo4bznfCNvDJT0
         kVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=17nYfbdzzIwCOeEA+32Sv30sZvfqih6k6/KJfQXHU0U=;
        b=tKzBRpkzrbkXkl/Yey/bX2Yn0JvxDqkukq02AWSxRcsu/ItuADtWyo4b1zWbEDmtIY
         QJXAoAFl7wgX3FV1PxXt8z+VC2Z7tZTsiESjziCSyrpbBOkc/Cr0GuA6dhWLH4onikE4
         8Iabov/MDeHPEFo/pCt1lIaNsioj77QQ8FFSHDhCJUm61LpXPiuWyp9ir/BdP58gjpx8
         yrL70YoMrJOIGtB8oq1fOUyh9s+AhDMFe6WHfrqT9Jul1uyVpELnLHwJppHL1Qe2vSba
         pTeM9g1AKUgDCCU9YYc/oURUPuXIArBBymNBhFJn3uDwvFQ+EYy61b7mlNAAcwwWHfhS
         WPiQ==
X-Gm-Message-State: APjAAAWFa0SgVJw1RUg9Rb/qv8p78rjFkWpbUizPe/G5cWBtPrRClrCQ
        dQqxbbEqaIqXC10Fo2fOMaU=
X-Google-Smtp-Source: APXvYqz60C1gN4ScjH6m6U5kFd88ETnN9gWQBtpWy+PHfqfM7Bq7SOcnQmw1+nRlZkREwZl5nQ9N7w==
X-Received: by 2002:a1c:65c3:: with SMTP id z186mr2831904wmb.93.1558436096773;
        Tue, 21 May 2019 03:54:56 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k8sm7245236wrp.74.2019.05.21.03.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:54:56 -0700 (PDT)
Date:   Tue, 21 May 2019 12:54:55 +0200
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
Subject: Re: [PATCH V7 12/15] arm64: tegra: Enable PCIe slots in P2972-0000
 board
Message-ID: <20190521105455.GK29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-13-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-13-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:43PM +0530, Vidya Sagar wrote:
> Enable PCIe controller nodes to enable respective PCIe slots on
> P2972-0000 board. Following is the ownership of slots by different
> PCIe controllers.
> Controller-0 : M.2 Key-M slot
> Controller-1 : On-board Marvell eSATA controller
> Controller-3 : M.2 Key-E slot
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * Arranged PCIe nodes in the order of their addresses
>=20
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
> index 73801b48d1d8..a22704e76a84 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -167,4 +167,45 @@
>  			};
>  		};
>  	};
> +
> +	pcie@14100000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_hsio_0>;
> +		phy-names =3D "p2u-0";
> +	};
> +
> +	pcie@14140000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_hsio_7>;
> +		phy-names =3D "p2u-0";
> +	};
> +
> +	pcie@14180000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
> +		       <&p2u_hsio_5>;
> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3";
> +	};
> +
> +	pcie@141a0000 {
> +		status =3D "disabled";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
> +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
> +
> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
> +			    "p2u-5", "p2u-6", "p2u-7";
> +	};

This last controller is disabled by default. Why do we need to include
all of this if it's not going to be used anyway?

Thierry

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj2P8ACgkQ3SOs138+
s6EDeA/9EVyT1aT46kUCfatlTu/Dz99vr8HzGHDju/DqmmIWFuXT6U/7e/iziS8m
LcoCBu23buFnDYZe9UBTKkKtTUSOipOpE+TW0MR/h3Rk0E7sB29RljYCoooRJbrZ
cRBl1HbLt4NueaYck621spKCghRw84gPRDOtCEIP1ET/kpkDCRYBtuoMhOufrqgQ
8Zddc+5YzhNC7dYdV+DLi6WvKjmi12Tz3HNFgwxIXSgfEieCnzwms63qZLULA2tf
dvwCNKS9w8x6EsOmu8iXxfYv9gr823Yge1pCJTKW+LxTaACRSzKMiGAotDMqCxWG
VIb39bG+wsiSLb8PjKT3X34wW6VPtsAWCCxeXJ8EsZuT3YGVskswBQ/tLyDvpooJ
ni/zobjMTFqJl9ePCgEauo+Zhdf665JwZO6vkRql7+ZFquFBHVwY8IOag0qM/kx5
pv4Q8Ov3GQr/QYPfn+CtvYJ1Iq61NJBhNC6zQwxw8DonLLt1OL64gGpF32x2155I
Toi6a3SAnJVYe1rJirldNME8Xb3HbyBhItj5GVMkf+jMxrsxs3GL9nzNfLi4gmDT
EXleRiiWixks2F/DATusE28tPhE9j+Fo9ZUXyLZ9rJiCuvqcZKGgtnboipXrn0+o
bRdy6xLv9PhLEkwYzxqnn9odSa3LHH40b39t+xOgdr9Yw8QZ0ZM=
=xv9D
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--
