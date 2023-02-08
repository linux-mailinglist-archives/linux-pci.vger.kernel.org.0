Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141D68EE15
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBHLiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBHLiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:38:08 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C4845BCC;
        Wed,  8 Feb 2023 03:38:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u22so5880495ejj.10;
        Wed, 08 Feb 2023 03:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci8JTMReAjFCcT3SLQC5hr52c0hQKJY/NV1yhOMx0uY=;
        b=J6O6AOjwv+pmFs0XpFc/Co4+WJWT3sLJgcMISQAw/FGJ9l0rkz/FyHLEU2RAjwEwGQ
         b2wdbD7ysoanIonxJ+8JUDIHzAPNnI9CaI7KOkt3mDeuKcOpfRW8bZEpDEWNvsERSLUK
         p8WoCJMAaV57/5/IrqcvIreu29rxy80vFNpKAYfZzEtZ/OduHXSiClLxtgECdk/6HWP8
         SPbGcUYbNOP1N79TwJjj4yDlKwmtZlRGkTXL5KCmzTUIBjLXBCLCekZVBmvan7QBumCw
         UjIRNoA0TyeFWA/TFN1Bp1dyEVmKLnyEnRHw8F8vdguqv3sQBLekDp6OehjIPmJzQn/h
         kTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci8JTMReAjFCcT3SLQC5hr52c0hQKJY/NV1yhOMx0uY=;
        b=EsCyE/CAbEWjNJqudyhZbkY9Lzb2IsKmXPWVpX4nsSMTVORvJzhIkHfnDYuW8ZO6+v
         CRi+/3kklN69PKTPnUipL+9sSINW52rk+SZ7KDcIpK41wx/NqSceo3Lbt9XDvLBbtYGe
         oasBfl762dBi5As3mRnJ66aCo2BY+lbzO033+4LPx5Ne5z830Y+0AQsEFB+V8+VZKo1+
         sHrA3hWmd9KmY0uQLYNLAHt86CULDbKFctn+a5BtgeCkSEUIT4WfPDM/wC4UMzzxPFvi
         GQGx66x2cKD3umAvEB3ABD0coGOsvdO8n/UgoP5rU7LuhSuAhym8tK8WRHPEpree+xs8
         gK7A==
X-Gm-Message-State: AO0yUKUGZTwsRI3WEzsCu0DTAX2PShQuiGgHB3EUOykK4QKt4nalCyEg
        T55YdPsTO1RhAPm20AQ7foU=
X-Google-Smtp-Source: AK7set/2DuGVCbWmyUhoiKZ7djYyr51e9CYLQws4bUQYBy6Nr0m0bw6bOssSy2xKA3/A3Qb/cK9m2A==
X-Received: by 2002:a17:907:75f2:b0:7c1:5248:4f3a with SMTP id jz18-20020a17090775f200b007c152484f3amr7629392ejc.56.1675856285666;
        Wed, 08 Feb 2023 03:38:05 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b0084cb4d37b8csm8257469ejb.141.2023.02.08.03.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 03:38:05 -0800 (PST)
Date:   Wed, 8 Feb 2023 12:38:03 +0100
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
Subject: Re: [RFC,v14 5/5] soc/tegra: pmc: Add Tegra234 PCIe wake event
Message-ID: <Y+OJmwo9rnM8Pf7C@orome>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-6-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dnbnZrtOx6z+VY5P"
Content-Disposition: inline
In-Reply-To: <20230208111645.3863534-6-mmaddireddy@nvidia.com>
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


--dnbnZrtOx6z+VY5P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 04:46:45PM +0530, Manikanta Maddireddy wrote:
> Enable PCIe wake event for the Tegra234 SoC.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>=20
> Changes in v14:
> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
>=20
>  drivers/soc/tegra/pmc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index cf4cfbf9f7c5..139ee853c32b 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -4225,6 +4225,7 @@ static const char * const tegra234_reset_sources[] =
=3D {
>  };
> =20
>  static const struct tegra_wake_event tegra234_wake_events[] =3D {
> +	TEGRA_WAKE_GPIO("pcie", 1, 0, TEGRA234_MAIN_GPIO(L, 2)),

What about wake events for other PCIe controllers? Do we need/want to
distinguish by name for those?

Thierry

--dnbnZrtOx6z+VY5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjiZsACgkQ3SOs138+
s6FTQQ//bp+B9n3mYGVuvDzX9NWcWCHqc2XpUYQR18NCUHsooWsDWcMThpRyIuTE
WPb0w2m6Su1pSl00uBf/be6yRX5kf/VFpxwRvQNBEx7pYtKVKHfVBHobRFMrODd2
baY2qAKGEFKGM0bKjnYLP46NsNGCthYv8xE5iuMKORZt6Vl6oWJ4ijNF62xiPRya
VfCIBQ30rHdgYZv6Zewg7u1g8mSsDnGi7tXj4PmXoX9BBtLCuA0J5a4oFEMOSrNL
lfw+cyKNFj4jBLFvzA9rshYCNs1W52FTUPGB+Voz3OsKv9oaaQl0GVhSH6w/32gD
GoYIPYymI60cKh2Epy5fz6xtM4DOTZ7a6AEuy5DSilKv4Fgc19ZCJskAe/4LkZKG
BDpCEbCB2ZUkw7xVO+2l14KO2rGnbofvLnbozoGwQOO3LBKr2sQ9YDfc8VQP5nVq
fzKXMYGN+8i375PkifKpK3QjoKBfFVCAvlHQG/nT298i+IAWdo3MieLfqhWnmmYW
rmydUuIi0ZWsAJd6FF0G8s8biuo87NQQa4xOu78GBZCz2NQPYuE6YWupnyl07Hpv
AQj9EwsdKh9WXKyOQoL/zCWkHh3D74MUPyfZKcFV3aH6ij95bnsOysu5P5/u/6Cc
Xmu/QjgFo3oxMaPNzWdNMwR5iN0okECXxwzvRf7eTrK7KNOUEHU=
=LtGa
-----END PGP SIGNATURE-----

--dnbnZrtOx6z+VY5P--
