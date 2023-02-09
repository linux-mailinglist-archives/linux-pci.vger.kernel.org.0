Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E83690638
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBILM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 06:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBILMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 06:12:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915537D9B;
        Thu,  9 Feb 2023 03:12:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l12so1877085edb.0;
        Thu, 09 Feb 2023 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7jADkVcHyEI+ZFTBiWOZYaGwIwnYp4U9ZLL7RuVuyw=;
        b=W41jSixcZ1F4MtMo5vf0zDFnhgIpXcMZTKJFFYUXhqRNZMlqU6j2xV0fDkxewMtea/
         I6iVK1i9Q26BIFZjQ0oSr8OyZ29jn6VAhSoSyVyWHhFUJ64+OVl2EZLVQTlrVnAHHW+Z
         hH6GGOrAwaTNqEBSsoSV+aBYnLjzH8+0S9GGW+RsnQRfP/BPyK0zL3iRMVzMLAO7DN0i
         JwASqFBIsEjEnyTKdQVajYnlBxpc5imH8g6T7h21rCeA7Kw1Un5cANLEwVLLaDq0rieb
         gHTs/XovYW7Ry2soqC9biUvmoQtJZh2iQFO+jvo4YkfBw5Wx4C+zrOa8tRBcbZPU75Ga
         NlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7jADkVcHyEI+ZFTBiWOZYaGwIwnYp4U9ZLL7RuVuyw=;
        b=nEY22SuDrfTv0gUl6RvybsPvrfa6H57SvKqwMKgXdpnTtf3yj4qgajfyE+jR1KkxdE
         38cEBtmDNHkKB3LYeyRcs9Lt3s0q1nqH8d3JuG57abhLSwFWpLk4r2ySy6BBZsZaJEra
         0HIPfQsc4LAuO2Z2EfG9Qt2CuPK4HzBszUGvhMKvbFvRwytSlAwYgtkscIFSC5ge7DMF
         8oKZYR67ijDWDzZSAwPYE9nFWkhbySVGqEnhg0uTCIkR9lKyM9twdXjjVPSPGbsJcCDh
         jJ2gpxbzIAaFK7GxKjr73UBmNQP81NeVyYA5U/VzxixCvJaYOi7ZXl7fopVvmuPIhjMQ
         QcLw==
X-Gm-Message-State: AO0yUKUp48axJiWjYSCx4uCGHRBAIIkw5Nlmic71klwhaaaQc2goUT9r
        vkSK4MIGh/tnYwID3rnRsCs=
X-Google-Smtp-Source: AK7set+cBqnu2NjkpbodBt3B7G15qVEMJXnF0ZL5X2yvyD2Q9eCg6ah8fa/f9WQqC4cray235uOhMA==
X-Received: by 2002:a50:cc9a:0:b0:4aa:b24f:c09b with SMTP id q26-20020a50cc9a000000b004aab24fc09bmr11923980edi.40.1675941149961;
        Thu, 09 Feb 2023 03:12:29 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p15-20020a50cd8f000000b0049e19136c22sm597849edi.95.2023.02.09.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 03:12:29 -0800 (PST)
Date:   Thu, 9 Feb 2023 12:12:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Message-ID: <Y+TVG4gUbbw5Vehi@orome>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <Y+OJaGY6mcxM0JOF@orome>
 <1b24e9f5-539a-dd0f-6485-5dbf3757ef27@nvidia.com>
 <Y+PKTNEAuPHBdwqX@orome>
 <DM6PR12MB316420D07FBB9F8CE9AF5CD3B5D99@DM6PR12MB3164.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oI+597r9ve6kB/tz"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB316420D07FBB9F8CE9AF5CD3B5D99@DM6PR12MB3164.namprd12.prod.outlook.com>
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


--oI+597r9ve6kB/tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2023 at 10:53:25AM +0000, Petlozu Pravareshwar wrote:
> >=20
> > On Wed, Feb 08, 2023 at 05:43:35PM +0530, Manikanta Maddireddy wrote:
> > >
> > > On 2/8/2023 5:07 PM, Thierry Reding wrote:
> > > > On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy
> > wrote:
> > > > > Add PCIe port node under the PCIe controller-1 device tree node to
> > > > > support PCIe WAKE# interrupt for WiFi.
> > > > >
> > > > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > > ---
> > > > >
> > > > > Changes in v14:
> > > > > New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX
> > Orin.
> > > > >
> > > > >   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11
> > +++++++++++
> > > > >   1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git
> > > > > a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > > b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > > index 8a9747855d6b..9c89be263141 100644
> > > > > ---
> > > > > a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > > > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-
> > 0000.dt
> > > > > +++ s
> > > > > @@ -2147,6 +2147,17 @@ pcie@14100000 {
> > > > >   			phys =3D <&p2u_hsio_3>;
> > > > >   			phy-names =3D "p2u-0";
> > > > > +
> > > > > +			pci@0,0 {
> > > > > +				reg =3D <0x0000 0 0 0 0>;
> > > > > +				#address-cells =3D <3>;
> > > > > +				#size-cells =3D <2>;
> > > > > +				ranges;
> > > > > +
> > > > > +				interrupt-parent =3D <&gpio>;
> > > > > +				interrupts =3D <TEGRA234_MAIN_GPIO(L, 2)
> > IRQ_TYPE_LEVEL_LOW>;
> > > > > +				interrupt-names =3D "wakeup";
> > > > > +			};
> > > > Don't we need to wire this to the PMC interrupt controller and the
> > > > wake event corresponding to the L2 GPIO? Otherwise none of the wake
> > > > logic in PMC will get invoked.
> > > >
> > > > Thierry
> > > PCIe wake is gpio based not pmc, only wake support is provided by PMC
> > > controller.
> > > I verified this patch and able to wake up Tegra from suspend.
> > > Petlozu, correct me if my understanding is wrong.
> >=20
> > The way that this usually works is that you need to use something like
> > this:
> >=20
> > 	interrupt-parent =3D <&pmc>;
> > 	interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>;
> > 	interrupt-names =3D "wakeup";
> >=20
> > This will then cause the PMC's interrupt chip callbacks to setup all th=
e wake-
> > related interrupts and use the internal wake event tables to forward the
> > GPIO/IRQ corresponding to the PMC wake event to the GPIO controller or
> > GIC, respectively.
> >=20
> > If you use &gpio as the interrupt parent, none of the PMC logic will be
> > invoked, so unless this is somehow set up correctly by default, the PMC
> > wouldn't be able to wake up the system.
> >=20
> > Thierry
> Thierry,
> Since PMC's IRQ domain is made as parent of GPIO controller's IRQ domain,
> I think, for GPIO based wakes setting &gpio as the interrupt parent can s=
till
> invoke PMC logic to program the required registers to enable such wakes.
> Related commit in this regard:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/drivers/gpio/gpio-tegra186.c?id=3D2a36550567307b881ce570a81189682ae1c9d08d

Heh... nicely self-owned =3D). You're right, no need for the detour in DT
with those, the GPIO driver will hook up the IRQ hierarchy itself. We
already do this for the "power" key in the various gpio-keys, so it
should work fine.

Sorry for the noise,
Thierry

--oI+597r9ve6kB/tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPk1RsACgkQ3SOs138+
s6HqwQ//Zpt5GNboNT6FQXO5Dl4h4mISvUB+mcMRdY9LdmHEZs4O8Xp85ftbrubB
uHR7S0Fvqt1EDlaPg+tzUYMBGtq/QpUy46Pi69fqHLUsTp8HnrKnIXbQ7KwEpR0z
RDrfO7dhYMo7Zv4KxuC3H8LmRIqJ54HevvW3sAx/mA2G9Et5CGcWCfUpTYnE8M6P
DFe4aSPVuetKatXz1oRz7NWR4d2S2ZsEfi7tNqhLnnSuPlJm+400Zz46+k/fmjzt
m+BKqyTjVwzvNfDdzryZiMMaC9tJMRaU9mAM4KtKwTcbQF78aHmizGdLwcegzCaj
9kCvG5tnaPhrfm6HZ1mQvgW4GgpXLola7Jpm58WoxuAGt9rjVSek1+taji44dGwV
N1Q5YrAqBzUTE6Pqm8CcaGP2LR02Jf8d2kJ0HMd7L+/OM1qCoepAepprllBW4hjM
AbHSu3hLBNt3h9IdYOLMyuTp9HqblZXaUcTsO8YNOTWcNjTSU+NT8BHmmrdOWrHj
emjW6zsMf0s3aZci5lCDa1MA6IjIjZciEPR1R6+NCKWIoccKCsqhNyAQyKblAX6L
fJFFg4bBGcy665BGBPogy9jH7L8wstPU+CItRuGrLNIfzjOhIYS6uRmP0gMCFBLS
34r9vuyy0mx7nApzj1XU4Yaoq8Gt5f9afCgxHdD+T0qCvFzuTxM=
=0MpZ
-----END PGP SIGNATURE-----

--oI+597r9ve6kB/tz--
