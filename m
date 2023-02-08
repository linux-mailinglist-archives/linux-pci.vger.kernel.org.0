Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC93968F2EF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjBHQOK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 11:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBHQOK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 11:14:10 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30FB4A206;
        Wed,  8 Feb 2023 08:14:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gr7so52403096ejb.5;
        Wed, 08 Feb 2023 08:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYG5PD7dbKaNKYs/ubsHHBhPjaWtLkpK6btkRG/jkM0=;
        b=DDMt3dOpyFyyVI2WTGlfQaz9N/WCY+1lI2SHnzeIfeSAiqqYzxl01kZpB5DNCcLseA
         TisUEkz6tjW7a0g1spZmcZ/EX2/H+UYbf20Is589WqAa9jxVTNeeAVvsrRFHmpmE0v5p
         R6S0BqRzHQTz9Uc1Q10rUSdDgT9hVJLoCXdWBzAdwibk2mrkWSzNeIwzKwKa/K90qt6n
         /OTkIzTZigzwU2aTkFfUitHrsqlScuZ86RWaZNWuRHQXiicbDAGjWrAAThi7xMH/IDTN
         Jud1flYcNi3gGuvnTrb9BvWkrD/EPmYFvPGMCxT+ktCjK9fWhNHVIdCIfDARDR7OON85
         7RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYG5PD7dbKaNKYs/ubsHHBhPjaWtLkpK6btkRG/jkM0=;
        b=pWhp686Qp2M4KcAtvN8nBRV+4xYxqps6/1FdWN+ooX+hwBaY2sg16msN8ayuXHjebW
         m25cnDtS28zWqHcO3q5urnTM+5wbCvTHXINwn1I8LJ+sTWkCJoJSmMwg2LHOeT9TA8AS
         ++c4y3VGjBknVJxamu7aW2G78ly+is5K4gPlWyLYETCFk5OpKmMgkhvC25jx/1rJZZto
         3VlMszmJ4DBHZcZuf9VGVG7LDKcHqxBhKSzzdHDSV9Qj/M/yX16NStUWmiBp+2Yn4el4
         C/alIWLxw1KCrsW5rKjONVV0pgzlkIzz6MPkOt1s/iPk0LdPP4bZmh1NDTkQxwsXF/PB
         +Blg==
X-Gm-Message-State: AO0yUKXVc7iqL9wc2w1WBiiIb+EKN2F2WgMI+6V1ECHZTlNiwSAZF81r
        6nz9KNGEpD0cI9PYoJMmXhc=
X-Google-Smtp-Source: AK7set+401vwRKb0yki0/knYX8QgRvAvUQe8tTdDwJhTuerst/mRXgHfimD/UV/0cGJBD4kB1q9diA==
X-Received: by 2002:a17:906:ca0f:b0:8a6:93a4:c897 with SMTP id jt15-20020a170906ca0f00b008a693a4c897mr8841126ejb.33.1675872847254;
        Wed, 08 Feb 2023 08:14:07 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906195500b008779b5c7db6sm8448605eje.107.2023.02.08.08.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:14:06 -0800 (PST)
Date:   Wed, 8 Feb 2023 17:14:04 +0100
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
Message-ID: <Y+PKTNEAuPHBdwqX@orome>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <Y+OJaGY6mcxM0JOF@orome>
 <1b24e9f5-539a-dd0f-6485-5dbf3757ef27@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/k1dyoR/zukO1rxq"
Content-Disposition: inline
In-Reply-To: <1b24e9f5-539a-dd0f-6485-5dbf3757ef27@nvidia.com>
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


--/k1dyoR/zukO1rxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 05:43:35PM +0530, Manikanta Maddireddy wrote:
>=20
> On 2/8/2023 5:07 PM, Thierry Reding wrote:
> > On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
> > > Add PCIe port node under the PCIe controller-1 device tree node to su=
pport
> > > PCIe WAKE# interrupt for WiFi.
> > >=20
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > >=20
> > > Changes in v14:
> > > New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Or=
in.
> > >=20
> > >   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 ++++++++=
+++
> > >   1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-000=
0.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > index 8a9747855d6b..9c89be263141 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > @@ -2147,6 +2147,17 @@ pcie@14100000 {
> > >   			phys =3D <&p2u_hsio_3>;
> > >   			phy-names =3D "p2u-0";
> > > +
> > > +			pci@0,0 {
> > > +				reg =3D <0x0000 0 0 0 0>;
> > > +				#address-cells =3D <3>;
> > > +				#size-cells =3D <2>;
> > > +				ranges;
> > > +
> > > +				interrupt-parent =3D <&gpio>;
> > > +				interrupts =3D <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
> > > +				interrupt-names =3D "wakeup";
> > > +			};
> > Don't we need to wire this to the PMC interrupt controller and the wake
> > event corresponding to the L2 GPIO? Otherwise none of the wake logic in
> > PMC will get invoked.
> >=20
> > Thierry
> PCIe wake is gpio based not pmc, only wake support is provided by PMC
> controller.
> I verified this patch and able to wake up Tegra from suspend.
> Petlozu, correct me if my understanding is wrong.

The way that this usually works is that you need to use something like
this:

	interrupt-parent =3D <&pmc>;
	interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
	interrupt-names =3D "wakeup";

This will then cause the PMC's interrupt chip callbacks to setup all the
wake-related interrupts and use the internal wake event tables to
forward the GPIO/IRQ corresponding to the PMC wake event to the GPIO
controller or GIC, respectively.

If you use &gpio as the interrupt parent, none of the PMC logic will be
invoked, so unless this is somehow set up correctly by default, the PMC
wouldn't be able to wake up the system.

Thierry

--/k1dyoR/zukO1rxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjykwACgkQ3SOs138+
s6HZGA//TdSXsFLTgVmkZ6PXU0yOasPm2tuDlJGey7FwCCVqzKyQ/dbdqrnfl/Vj
JRcbXKKomD+oVLvRepvBSVk5HfDeL60Kf4N4iyectGJ+31UjRLMucnM/YMqgOoi2
yQPfcd8B9rJ5l1R9nVlLlP8jfLGusaUixSvdC2TaqsNzJmmtPaCgD3UXcHEMMI00
wrsVdK0TinpV7EqD93j9crNZkGoXl+8qjczoHeMLzf5XRac+ff6Js9120FJAfAbq
y5BPEYRsIyDDVG/iYz55t8YoS2xR4Hc5gcPR/euxwFk6QrnN0CnuULhWO4Ihfa66
h/NYwuBt477NY0Za/EbH/X1w3k7TzFUSxch1wkIhMirQYWrwDptcgg5T1C46sw0r
LHi1F553vy7QIjprEKLzpT9iEyjfzqRsNvXttNONXZK3zA83CMGaatqSK8UYcOxx
8i7t8E9ZKzOzattJ0X7hXrfGsRfE5hJP7HmQql91RPoOcHxFA2WWWKWYQoE3/Qp5
qHl0tQQB8qtMmg//kzrxoC2s4557786dRjcATnkOt4NbrniHTdSDTWe+7WjFT+sU
Mj7FVyIrnrbfj9qSngbZVmzwvaqysxPYfLWXZ/kBSdRiZ2WSWF7dQs32hVn0TsLK
0i1WObI5YyF/sSl+uxbfXoPea5Pc61EelCRKdeQXzLtU+RYyMj0=
=P8ai
-----END PGP SIGNATURE-----

--/k1dyoR/zukO1rxq--
