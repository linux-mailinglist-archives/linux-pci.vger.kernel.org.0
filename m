Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30584CC79
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfFTLBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 07:01:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35803 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfFTLBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 07:01:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so2728780wml.0;
        Thu, 20 Jun 2019 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IF1UrzkwmllV6FGnyrzvVneNFAPUj7twgof+cG/GUpc=;
        b=JD+NNQgW19oNRgSd06HC2uGvQaFBvrgQWSYwgHBKr2S+ufx9hPwHzpDMDfLBbW7hsn
         cLD5QhMs+C5t15puHlS0opsPJRgBlCMJ7Hmyubc5EVWjc9uW8k2iVp3J54aMAO4nR0jN
         uBcYsH+rap54RR+4JqGAl9QkfOTHvtmKQLoKRtqVd35dQiulpfyAi1VjEB6swbgGlvsd
         CzRyw/WTeBfQvnkufg2C8wMV0bhO13fsZITOeO1W2jqPnDv3w8a7glpcD6glYjgBiJ0p
         NCxH7XcY61mHCrQlx+kePNlXVw3jQtyyEL4qeB5vi6RE36iQKyR1BXjoqA3Lmj2ZQLIo
         PfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IF1UrzkwmllV6FGnyrzvVneNFAPUj7twgof+cG/GUpc=;
        b=S5N45vDAj2IRnG+D8YtCVQ6pTAXYYeokzc/3dozDlirZtX52nUUyxmlZoWYF15KmU8
         YFUvahWU5l/eQoueamA4nArmuj/9WoC3CEuNn6QQtwmNuEhsqs+oTVJ65/z1Qpi8CXeL
         jqQM5OUsnFKigLlVL9rs+9L+UDO408LyP13FLJANs+mnQVrunNFSmbTvE7vYLvDMnjQt
         zIcSrqoJ1e0/wKk6ie1MGXyq781MrHPimx2d1aZBsagSywTOIK1+0bbJYBzGHDrVPsJH
         Re/65G1e40bB28Zq1PCt5UH07zp3PzgAG3kQMjaYmzc055pHYArq//HTvWOw+aJC0Yv+
         i4Rw==
X-Gm-Message-State: APjAAAXt6SaqY0SFbOb8b3H74BQFw3GzjSWiNcPNdig8nXLlolKWVxkF
        qdunEBYgmLNUGoeCULqH0II=
X-Google-Smtp-Source: APXvYqwNWQMemI2u6x6OPYvPpZUAnjFUhDWBD6VyDhpD1JiXbXPDS5UK7eBLywUJkgssbzISohn3eA==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr2365032wmi.146.1561028503945;
        Thu, 20 Jun 2019 04:01:43 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y133sm6010161wmg.5.2019.06.20.04.01.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 04:01:43 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:01:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V10 12/15] arm64: tegra: Enable PCIe slots in P2972-0000
 board
Message-ID: <20190620110141.GB15892@ulmo>
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-13-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20190612095339.20118-13-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 03:23:36PM +0530, Vidya Sagar wrote:
> Enable PCIe controller nodes to enable respective PCIe slots on
> P2972-0000 board. Following is the ownership of slots by different
> PCIe controllers.
> Controller-0 : M.2 Key-M slot
> Controller-1 : On-board Marvell eSATA controller
> Controller-3 : M.2 Key-E slot
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v9]:
> * None
>=20
> Changes since [v8]:
> * None
>=20
> Changes since [v7]:
> * None
>=20
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

Applied to for-5.3/arm64/dt, thanks.

Thierry

> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/=
boot/dts/nvidia/tegra194-p2888.dtsi
> index 9f5810765efc..62e07e1197cc 100644
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
> index 6e6df650a4b0..eb79663b2af8 100644
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
>  };
> --=20
> 2.17.1
>=20

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LZ5UACgkQ3SOs138+
s6E0OxAAqHtlSQS8hK55p9RUs8cm+q25f/x4sLncet4I7dGg+1mwumU92ACOOAo5
phKrW0oi/ZaR2KpU9T9edmuaWP3dDjXIvUBjJ+vIQTBvA5FzB8xOO+LGcvgj6Sj8
W/9pozwzVswEtxv/EolG7HIqNV4rbb8yKzIagqXc8pQBElS8NPJkUEz+VSj6+1b+
9QqFl/bqp+iQzdLvCCMKcIUKISJM4JVnqLQ3dgeJuRajAqVm7UzQOtg7Yhm3hGML
QEU48F8vmeutUyu6wziMkOX+EBGBx9ogiTi5J+IwZHnsVN8kn9aMAKmZyoZW0aOa
WQI4sy/6WWnKqisRNc6H+gepjdw0MG+ToJKjDFNfMld+8CRrqm9YlwpTVgRx6MT7
MPY2CJ7mUQzj/+tUrq7WueQOLI+kmqpB2PNeWe2pPDFCyE0tZgW99S8C7YKMF3Zp
n77aTAOXTAWvbB78nakTik4DQmzuETZl2XEoqHDYVJ7WBzjXH2t1nFaU2+9Yx6kI
EIiWYuSyR3NFzBuK368HQlJ3hyAmR0dvKapobzGz4zZrW+rAFT6INeQet+Snolhm
IQ6shdCKCkD8p90VrV8UOowNJSo7df5mr6LdGv/zWhEU0YnqhI6cv0XtYs1yUh/1
ZNbJfLMebxvjqwmB4n7pCnpt1otenWTcKgEfw0fxDiD2hJK51vw=
=sH4H
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
