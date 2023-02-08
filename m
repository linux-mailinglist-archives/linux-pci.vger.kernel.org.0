Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65868EE11
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjBHLhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBHLhS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:37:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7945F52;
        Wed,  8 Feb 2023 03:37:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v13so19961593eda.11;
        Wed, 08 Feb 2023 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7rM1HpK4gZIplaubBndxjo7qgPO1F4IIRGIk/8punk=;
        b=Qgk6huMhPW+u3iA6hX9Fne2XJf9OwWr9U2AliXVPCE6Vk9KEumI8ypmQ+gybTgo5Wx
         JGIx45TTZEZDTS39/hdZUVnm2olOdftM60t7OCcZF/wDWgK+neqqlJGTuxRJgLYtkqDJ
         USZVYg/nGfUhjmd1qEaHfRlhavhWb4un7kQOJMIQELRvvGwuR1RRogembEcylDEi0owO
         fhHkLOI/sIMNOO2N7v4aH0+3xKZfBB2O6iHN9xDa3n+CD9SPka4Tb7fdlkPZXQqlwv1e
         s80rUl/heKD8sDsV6yhNEDUbRPYzy4E0PgPMR7jEuZgbysGcz89Uzqrr9qxHBKDFfzZW
         ecBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7rM1HpK4gZIplaubBndxjo7qgPO1F4IIRGIk/8punk=;
        b=R+iVj0j4wbv0l0mDSB/PQ/mUYpnEcAV+TsvxDwnh/PZGscGNg/cSIVWNEfcnntPe59
         EixN7SEn7loie5ks1pl1xagFFehjvLlJOF5Y0zv05E+wLzGTc7DS1WnKtbUdbYBoyKiQ
         ioS3pbsbXqoNggd+8bGG9WQU7aHTqTYSL/JR78dFv6riVNXpJu3YpQ9YZGgoOVdYCgdB
         xW14SC4ycW/X8qXjldEX6l9ntG/ecgafSoXmos4hIIlxc6HaYFjlgaGSlmBFEjmv0lJ2
         JcOtqt0dTUcri9+o4DeBpf6gQXOERmdZIcEuwHENkuWBXOv27OKe49y4/1/UWo6zpl/s
         N6lQ==
X-Gm-Message-State: AO0yUKXMmqWR+ocoYAZsA5Mc2QzHUqZ6kaLSLmXX32qqyWbl9yT7GoYu
        2qQd4W157TrhDWTnFcQ6I3w=
X-Google-Smtp-Source: AK7set9kHhg8iyB0DxRAXAEc44CXnaCMcnULvNey9nytql+VC0AoWkQpPxcOBWGi47a19twA1l932g==
X-Received: by 2002:a50:ccd4:0:b0:4aa:9f59:b6a9 with SMTP id b20-20020a50ccd4000000b004aa9f59b6a9mr7063169edj.12.1675856234949;
        Wed, 08 Feb 2023 03:37:14 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t1-20020a056402020100b004615f7495e0sm7789645edv.8.2023.02.08.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 03:37:14 -0800 (PST)
Date:   Wed, 8 Feb 2023 12:37:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Message-ID: <Y+OJaGY6mcxM0JOF@orome>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JZEp7O0NQU6aBHB0"
Content-Disposition: inline
In-Reply-To: <20230208111645.3863534-5-mmaddireddy@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--JZEp7O0NQU6aBHB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
> Add PCIe port node under the PCIe controller-1 device tree node to support
> PCIe WAKE# interrupt for WiFi.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>=20
> Changes in v14:
> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
>=20
>  .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dt=
s b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> index 8a9747855d6b..9c89be263141 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> @@ -2147,6 +2147,17 @@ pcie@14100000 {
> =20
>  			phys =3D <&p2u_hsio_3>;
>  			phy-names =3D "p2u-0";
> +
> +			pci@0,0 {
> +				reg =3D <0x0000 0 0 0 0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				ranges;
> +
> +				interrupt-parent =3D <&gpio>;
> +				interrupts =3D <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
> +				interrupt-names =3D "wakeup";
> +			};

Don't we need to wire this to the PMC interrupt controller and the wake
event corresponding to the L2 GPIO? Otherwise none of the wake logic in
PMC will get invoked.

Thierry

--JZEp7O0NQU6aBHB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjiWgACgkQ3SOs138+
s6G+yw//Vzt4WBBLRqLINDOG56vSGm0UH36xsFvInTordR1zQsj3/gkwz89sToTs
mVIfJuJBtRwhl0YhSwiWV/jsV2g7gYZ1L+p2ssnguhcltzcdzbp/OInT/PWsUblS
IKQEWwb+/dLzh9Md7aQYXeSv7pJSwp0rnnBxLS7lF6oaVGC7bffKYn+aAFsCPZgm
uewFDk6xIVyOkQzokYV4OYQxH2W3mC8SW8Q5moAgRhSqKTMwRJdme6WNCZrwcAVI
ketseSQHLQ2ryKFgVeI6Htn3ubySw+9rdnFOKadkj57PA/BAekpfLn0LCkPP1Hb5
rKQJJJsavePW8BNaFNt7+BUrspSwa0CV9kXeZGKcFuXPAjJQwkHxFqGIPDOV15jA
XnjkOmhW3yT0zp5buq4VEEaJc7qIbVtnCthUXWs32uJ3ovKpQh98cZm+HG1AHLVV
jD0DlNq+njNQfKyXpgU80uWeH5i7VYype281ILyhDDH4LUMnZlHb8Hx4dvLQagXw
7zkTvFkgC8goTLGFWneL9djvnZDsemOgJ5rv812BrakhMr6bBxnzLCVzicf1O7Ti
pOfMlRkZZr6rtLtXk0apXbJ/F6pdTKyOSrnZCtSnKARFwJ1cBFyQijHqH4dOtFOp
aJuc3sEmDh8d2FfRFM7nMvRar4DYShijDRW0FP7twJyTPIx9g64=
=+nx7
-----END PGP SIGNATURE-----

--JZEp7O0NQU6aBHB0--
