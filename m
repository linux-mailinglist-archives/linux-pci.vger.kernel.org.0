Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F417D18BEF
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfEIOhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:37:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:37:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so3431384wrs.0;
        Thu, 09 May 2019 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=scZqm+KlBASQ62/vyfD/Q70v+lSojYa6bfoMXjOirYA=;
        b=kSvTJBR6jOdHEYIzDH/Zymfw0RciPCuKKqiJ05qmrhvS05/XyWJoWk9fswTX7WSR4y
         NNpNmWNGB7/MrYxzzbLkqWfktSahA4JtqyguxzXWiqTZaXie78B790laZYI1ccm64c5k
         tVJ0AQxgtH31geB3sockb/YmVzV8EJ7gplLDY2G9JL1SHVyBnxi3/ifn/UNPSl8hvYhB
         PGy7fr4ef6yUbOhFiAbX4Q2CwZBVoEXm30yNJRzmp5Xd2y6xnITaLPGs4k+duxccTZbA
         8/H7F9UrEgKqxpjd3yUIwjIJ7284cC5E8chosP0VBwrlyCUliRi2+Rd++zbBFsxE86Ys
         4R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=scZqm+KlBASQ62/vyfD/Q70v+lSojYa6bfoMXjOirYA=;
        b=DMp1OG/t93izGgblZ1LOF+tkmc6mask9Er3msoOHIE3pGCeylfbaCcjUyAEcs5v+wR
         UfI/uE/JQAFFSO5inKW9ib7CsOs4HDR/Jt08+bU5MUhyzq8Ib2gaXcy7ePsEGxf0Sk9F
         12zf2fTsjkDxXLIJuUUF8YhL+Z9zj6JJEAdaCOg5YUSLDaw9BPTiel49pBkX2s5BGbFR
         1heL2kv08WiERAEqR5/R3l2KQSSNQ6uyhi7uRq6F2eL3ljS+sTdek7LDpIs24fWfiK9d
         /Py5Y2Btbx2Wk+JHpMGaxtJ3dMq0WUKwPQt/QvCGUwGVMWXaKDCrJil0gsSdbdWTq918
         bkNA==
X-Gm-Message-State: APjAAAWwhHXNFxs+3tQ0fN+ce5HcW+5PYmvoS+/UuEQI8T5NNwTsZE2e
        Wo3iT/scl5P5LlLW2Kzy3ag=
X-Google-Smtp-Source: APXvYqzmDGLPIW8DFizuHkydjFp253uJ0MSyrwKODi20Qb4+qC9QP8aftgvi4x8Fsfe/6DwWBF4gBQ==
X-Received: by 2002:a5d:56cf:: with SMTP id m15mr3661829wrw.182.1557412653659;
        Thu, 09 May 2019 07:37:33 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n17sm2233273wrw.77.2019.05.09.07.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:37:30 -0700 (PDT)
Date:   Thu, 9 May 2019 16:37:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 26/28] dt-bindings: pci: tegra: Document reset-gpio
 optional prop
Message-ID: <20190509143729.GU8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m1rwLFmcefDs/2Y3"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--m1rwLFmcefDs/2Y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:23PM +0530, Manikanta Maddireddy wrote:
> Document "reset-gpio" optional property which supports GPIO based PERST#
> signal.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard "reset-gpio" property
>=20
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt          | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 7939bca47861..4e75e017f660 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -162,6 +162,10 @@ Required properties:
>    - Root port 0 uses 4 lanes, root port 1 is unused.
>    - Both root ports use 2 lanes.
> =20
> +Optional properties:
> +- reset-gpio: If GPIO is used as PERST# signal instead of available
> +  SFIO, add this property with phandle to GPIO controller and GPIO numbe=
r.
> +
>  Required properties for Tegra124 and later:
>  - phys: Must contain an phandle to a PHY for each entry in phy-names.
>  - phy-names: Must include an entry for each active lane. Note that the n=
umber
> @@ -626,6 +630,7 @@ SoC DTSI:
>  			ranges;
> =20
>  			nvidia,num-lanes =3D <2>;
> +			reset-gpio =3D <&gpio TEGRA_GPIO(A, 3) 0>;

Nit: it's customary to put vendor-specific properties below generic
ones.

Thierry

--m1rwLFmcefDs/2Y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOykACgkQ3SOs138+
s6FsNQ//W3EmnqNBZ49wEPEqFU/6J8fYdmwzJCzpo7KbxVWzpKGaJVmZ4F1IvEWE
Q+0U12iYXyLXrUzdysNSbu9Vb1wUf2iCFP7fA9yr2PBPcPHwnMlgTKl+RB4nSLM2
iFyaSbLPd94sCJP10Qzt1CZtPkp3uigFHDuM0W1sz6DLxVygV5FqGkDBFyI9KpCZ
SW4BsNTHw5nZWM9CUOgZ806SCsPmzcbRRAnJGYC+QwkNu8Z8wIxBrQcsslrQVCpo
YZs6yULR59o3uQ/m4jh6FLnaCM9KjjiB4WoKJU0fvf3vAQja/l2q4f4FwGdGO4W9
rz+jfzs95SN4O3mUONrB1w33Mg3i626MSB7PeF6oz+gAGOk/3TWLjnzcBwrorDu5
mJIn3khVvK4OF9i+USWbloWR5KQzq77rR0yeUOWx1gvSms7XKm+hQJHVagP93Xca
Bulp1nfPTZKIZB4QsU1lDvRrDiv6hMZBNwrDf36Q/V/h7J5FqGWoh1aI8SJUov39
LFTNs1nhO1cVo6fMCGlnOUrmnhTwYZ5tfMDnpA4Tq3vyQIjQ2YngMfWXYBZo0V3Z
rMdHvvDjjERN9IpLP1V02VU4qy9aeS+UU6RexE9WET/NMKdGt1FhYhnBwTLRyc+o
lFM1PpauQXQULwVPOaNNCNQOHcw0llrL7Z8tlMGFJlpQinAKUJg=
=/G0X
-----END PGP SIGNATURE-----

--m1rwLFmcefDs/2Y3--
