Return-Path: <linux-pci+bounces-32173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D1B062D9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C611894471
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5F1E834F;
	Tue, 15 Jul 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoOGDjgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10C137923;
	Tue, 15 Jul 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593114; cv=none; b=VyKlxz+BDw6UnSICWaVZnKKjKKEL5rP7nof2WmZMK0ceMagow2L7A2S5zbB7Xp2tpHm4LjkzgJsqJp24TPwpt3shr94QmngOmjpWQIK5fRLa3X8DBQuhU+R8HTXRdsiAK2ULGjiCUrQRQ25RmBC3gbx8OxilyyvFgVLreKyBDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593114; c=relaxed/simple;
	bh=+iZhsBUWZSulP41RkMskAokjoebc7RkoZj+v+sID3+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKWGJVbGwZIQE/dDEirIP9oV9+42dCrxTto4Ko7KLcnrYBUTnWXQDFqMkPn9qnJj3//y6Wvg5j2OBsdW8ZlPM2WnWCuH1vB7lBbF8Zmadov01j8a2NE5D6IGpfULe41p9KvGnu3V0QJxkKF8Bzz1SlfVMOAqx6RSuwLFAuYCnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoOGDjgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9974DC4AF0B;
	Tue, 15 Jul 2025 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752593113;
	bh=+iZhsBUWZSulP41RkMskAokjoebc7RkoZj+v+sID3+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YoOGDjgFRp7HK1g5v9jpXVwss1E7P+fld3vFuN3PW900mdZ2CIwKK2cp5ZcvL7d0y
	 9rRd/bpND3G2dqZehY4LWofXABaXOQgm/nb+1xttzDLiQjJdi5jL7ugbavQg82q+3b
	 AGBvubAtgWiE5n5to9Jx9ziV0YD1VxPMz4+BkxJn+IGMoVDb1XsES5DIOQuW/g9a5t
	 duyU3WBsecV2D7qMPMaSHGSfgsD4D9rm3fTl6t2UqTys7O3DyAr/2W7dAETILAdjRa
	 qEMQr+XDIkQVK93cS4IC2Fftunhcd514xknZWlivvD4vvMxF9CcGIbO9BGGbOCqsBs
	 9dEzTc4bNiYtA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11550798a12.3;
        Tue, 15 Jul 2025 08:25:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaC7wOHtmzFHzzWFV/wO5xYjjy0RF75TS/SfbRFgBxkQM3bHL7WfwnbNGXw/tggWDzjOtqwkeLc+eA@vger.kernel.org, AJvYcCUaXWxvraVWOrYLLIiaHgG+s1afnYPhRlrdwLV+A79UgbfdgXSVO1tYjlAhh7BvtNGmTBvWXxDi0rRmaQ==@vger.kernel.org, AJvYcCUsNgg8+875qY/NEEXbSer9QpJjF18d0WXRi80UHkQS7DiHkluHfxtUJ20v4XIGDiEt+71+drHqOmpjhuaa@vger.kernel.org, AJvYcCVsUI0CRjfWmlL6bTQxo57ZlBpfdYbelWD5oM+tWKjhgwsBq7wk74JI6bKaCWTWes+nDhvP9ctPBegI@vger.kernel.org
X-Gm-Message-State: AOJu0YzBy+NVPsZmgyiDQ+A0K4kvbLvWoPkD3oMtvDRcvdkp7fnhpP+t
	PnMr1etxwBMNrQqH3vVSp3ilbrQd43uZXyjzmW2mwLE22EMdFG/fZ8jwvmC2G38QuZQVtda/D3w
	U20mavIJPLw6SProeOiPYQHx0KCf67A==
X-Google-Smtp-Source: AGHT+IFhI1Gf1QWnLIvPSTSWf4gnALh46fJcdiVacHnkECq+ju3RTb7CbKGPKrz2qlxBZ7zAD9wzoI4qtasBTfMiC+U=
X-Received: by 2002:a17:907:8689:b0:ae4:85d:76fc with SMTP id
 a640c23a62f3a-ae6fcbc35bfmr1706242066b.30.1752593112041; Tue, 15 Jul 2025
 08:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com> <20250715034320.2553837-7-jacky_chou@aspeedtech.com>
In-Reply-To: <20250715034320.2553837-7-jacky_chou@aspeedtech.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Jul 2025 10:25:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4yeYGAyCwHi=4CBurxGOc5oAqTQqun+5+Ps4hxwDU9Q@mail.gmail.com>
X-Gm-Features: Ac12FXx6Zdty1kF4V51gulFmHIQBgnZZ8rlts-SPK0sS7WQh8WbpLuYAl_mXY8I
Message-ID: <CAL_JsqJ4yeYGAyCwHi=4CBurxGOc5oAqTQqun+5+Ps4hxwDU9Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ARM: dts: aspeed-g6: Add PCIe RC node
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:43=E2=80=AFPM Jacky Chou <jacky_chou@aspeedtech.=
com> wrote:
>
> The AST2600 has one PCIe RC, and add the relative configure regmap.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 61 +++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/=
aspeed/aspeed-g6.dtsi
> index 8ed715bd53aa..ed99780b6860 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -379,6 +379,67 @@ rng: hwrng@1e6e2524 {
>                                 quality =3D <100>;
>                         };
>
> +                       pcie_phy1: syscon@1e6ed200 {
> +                               compatible =3D "aspeed,pcie-phy", "syscon=
";
> +                               reg =3D <0x1e6ed200 0x100>;

This looks like part of something else? It should be a child of that.

If this is the controls for the PCIe PHY, then use the PHY binding
instead of your own custom phandle property.

> +                       };
> +
> +                       pcie_cfg: syscon@1e770000 {
> +                               compatible =3D "aspeed,pcie-cfg", "syscon=
";
> +                               reg =3D <0x1e770000 0x80>;

Looks like this is really part of the PCIe block as a h/w block isn't
going to start at offset 0xc0.


> +                       };
> +
> +                       pcie0: pcie@1e7700c0 {
> +                               compatible =3D "aspeed,ast2600-pcie";
> +                               device_type =3D "pci";
> +                               reg =3D <0x1e7700c0 0x40>;
> +                               linux,pci-domain =3D <0>;

No need for this. You only have 1 PCI host.

> +                               #address-cells =3D <3>;
> +                               #size-cells =3D <2>;
> +                               interrupts =3D <GIC_SPI 168 IRQ_TYPE_LEVE=
L_HIGH>;
> +                               bus-range =3D <0x80 0xff>;

Does this h/w not support bus 0-0x7f for some reason?

> +
> +                               ranges =3D <0x01000000 0x0 0x00018000 0x0=
0018000 0x0 0x00008000
> +                                         0x02000000 0x0 0x70000000 0x700=
00000 0x0 0x10000000>;
> +
> +                               status =3D "disabled";
> +
> +                               resets =3D <&syscon ASPEED_RESET_H2X>;
> +                               reset-names =3D "h2x";
> +
> +                               #interrupt-cells =3D <1>;
> +                               msi-parent =3D <&pcie0>;
> +                               msi-controller;
> +
> +                               aspeed,ahbc =3D <&ahbc>;
> +                               aspeed,pciecfg =3D <&pcie_cfg>;
> +
> +                               interrupt-map-mask =3D <0 0 0 7>;
> +                               interrupt-map =3D <0 0 0 1 &pcie_intc0 0>=
,
> +                                               <0 0 0 2 &pcie_intc0 1>,
> +                                               <0 0 0 3 &pcie_intc0 2>,
> +                                               <0 0 0 4 &pcie_intc0 3>;
> +                               pcie_intc0: interrupt-controller {
> +                                       interrupt-controller;
> +                                       #address-cells =3D <0>;
> +                                       #interrupt-cells =3D <1>;
> +                               };
> +
> +                               pcie@8,0 {
> +                                       reg =3D <0x804000 0 0 0 0>;
> +                                       #address-cells =3D <3>;
> +                                       #size-cells =3D <2>;
> +                                       device_type =3D "pci";
> +                                       resets =3D <&syscon ASPEED_RESET_=
PCIE_RC_O>;
> +                                       reset-names =3D "perst";
> +                                       clocks =3D <&syscon ASPEED_CLK_GA=
TE_BCLK>;
> +                                       pinctrl-names =3D "default";
> +                                       pinctrl-0 =3D <&pinctrl_pcierc1_d=
efault>;
> +                                       aspeed,pciephy =3D <&pcie_phy1>;
> +                                       ranges;
> +                               };
> +                       };
> +
>                         gfx: display@1e6e6000 {
>                                 compatible =3D "aspeed,ast2600-gfx", "sys=
con";
>                                 reg =3D <0x1e6e6000 0x1000>;
> --
> 2.43.0
>

