Return-Path: <linux-pci+bounces-15154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA819AD6F5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 23:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F2E1C21B02
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 21:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211D1E32D9;
	Wed, 23 Oct 2024 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzU0hZh6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959622615;
	Wed, 23 Oct 2024 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720361; cv=none; b=uXNtI9685F89hmXtrkGxBmo8WpTAgf5oAg1c7Fwd7pPM6HfdMrofRMXnfZeyNYVjKxSWXeXerxaW/FBP0uRDCD1JOEDnq7OEILXYOuk10VNK4PDuG3Wg9sFiwkbK4wt3mqqVmKsKBcnzVCCKvnIu3TWVTklktx9qNS3f5Ur6WYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720361; c=relaxed/simple;
	bh=9bVyAQpQFt/Z58ZQ5nW+bBDA1LTmojglQ5M0fRlRTUw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DkoSPjQvvPet3Rif+luFZx0G1rUq80jDkVPcBokrwp7ypYwQxDA0LQMmvk+Mqn8Bjxm12zR5XVdRT0k0nKnXNzpMeLhVBqF9EfKesOad3v3NwZwyNPVq3NI/eKo+0LqUTBKfsf84NwKosSidQDjn6jOVL3UymFRJoE8hXJSQIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzU0hZh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D7BC4CEC6;
	Wed, 23 Oct 2024 21:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729720361;
	bh=9bVyAQpQFt/Z58ZQ5nW+bBDA1LTmojglQ5M0fRlRTUw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GzU0hZh6NYm598rTpJ5Dh1ikSZ+Utkx8zujjS8pRtxDERtuIXop5M206OgofFX2Rt
	 HwHahYElDKTG1ymAyvDvBKztLnH3Zf3i3HXfEYcj04JmZwWJz0J4eRMJs0Q2DHseEQ
	 xWAy1vUFOLcHRTjeMMkfeC/S9HvTAjJBShtHq1ijLxHQewlUSTIFAhfq2BA3W4U9BX
	 DXdhujrsCmjlL2w6gzbEakj6H1ILJJLPsqXTXTVJHOHdBSFhE5n3zXlDUnmS5kFkEB
	 vj56Vv1Ki92EetFKmG2t5b6YH3k84L8OnfCHHhL28752UOAL+cRBA894BtIm6O2d5P
	 Y6vtqsY2ccBfQ==
Message-ID: <21fe104262989f04fadf9ec57dcac6df.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZxkX5gnDkWrTynRv@apocalypse>
References: <cover.1728300189.git.andrea.porta@suse.com> <022cf4920f8147cc720eaf02fd52c0fa56f565c5.1728300189.git.andrea.porta@suse.com> <611de50b5f083ea4c260f920ccc0e300.sboyd@kernel.org> <ZxkX5gnDkWrTynRv@apocalypse>
Subject: Re: [PATCH v2 08/14] clk: rp1: Add support for clocks provided by RP1
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, St
  efan Wahren <wahrenst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com, jonathan@raspberrypi.com
To: Andrea della Porta <andrea.porta@suse.com>
Date: Wed, 23 Oct 2024 14:52:38 -0700
User-Agent: alot/0.10

Quoting Andrea della Porta (2024-10-23 08:36:06)
> Hi Stephen,
>=20
> On 15:08 Wed 09 Oct     , Stephen Boyd wrote:
> > Quoting Andrea della Porta (2024-10-07 05:39:51)
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index 299bc678ed1b..537019987f0c 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
> > >           These multi-function devices have two fixed-rate oscillator=
s, clocked at 32KHz each.
> > >           Clkout1 is always on, Clkout2 can off by control register.
> > > =20
> > > +config COMMON_CLK_RP1
> > > +       tristate "Raspberry Pi RP1-based clock support"
> > > +       depends on PCI || COMPILE_TEST
> >=20
> > A better limit would be some ARCH_* config.
>=20
> I've avoided ARCH_BCM2835 since the original intention is for this driver
> to work (in the future) also for custom PCI cards with RP1 on-board, and =
not
> only for Rpi5.

How will that custom PCI card work? It will need this driver to probe?
Is the iomem going to be exposed through some PCI config space?

It's not great to depend on CONFIG_PCI because then the driver is forced
to be =3Dm if PCI ever becomes tristate (unlikely, but still makes for bad
copy/pasta). I understand this line is trying to limit the availability
of the config symbol. Maybe it should simply depend on ARM or ARM64? Or
on nothing at all.

>=20
> > > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > > new file mode 100644
> > > index 000000000000..9016666fb27d
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-rp1.c
> >=20
> > > +#include <linux/clk.h>
> >=20
> > Preferably this include isn't included.
>=20
> This include is currently needed by devm_clk_get_enabled() to retrieve
> the xosc. Since that clock is based on a crystal (so it's fixed and
> always enabled), I'm planning to hardcode it in the driver. This will
> not only get rid of the devm_clk_get_enabled() call (and hence of the
> clk.h include), but it'll also simplify the top devicetree. No promise
> though, I need to check a couple of things first.

A clk provider (clk-provider.h) should ideally not be a clk consumer
(clk.h).

>=20
>=20
> > > +
> > > +static int rp1_pll_ph_set_rate(struct clk_hw *hw,
> > > +                              unsigned long rate, unsigned long pare=
nt_rate)
> > > +{
> > > +       struct rp1_pll_ph *pll_ph =3D container_of(hw, struct rp1_pll=
_ph, hw);
> > > +       const struct rp1_pll_ph_data *data =3D pll_ph->data;
> > > +
> > > +       /* Nothing really to do here! */
> >=20
> > Is it read-only? Don't define a set_rate function then and make the rate
> > determination function return the same value all the time.
>=20
> Not 100% sure about it, maybe Raspberry Pi colleagues can explain.
> By 'rate determination function' you're referring (in this case) to
> rp1_pll_ph_recalc_rate(), right?

Yes.

> If so, that clock type seems to have
> a fixed divider but teh resulting clock depends on the parent rate, so
> it has to be calculated.

Sure, it has to be calculated, but it will return the rate that causes
no change to the hardware. When that happens, the set_rate() op should
be skipped, and you can see that with clk_divider_ro_ops not having a
set_rate() function pointer.

>=20
> > > +static int rp1_clock_determine_rate(struct clk_hw *hw,
> > > +                                   struct clk_rate_request *req)
> > > +{
> > > +       struct clk_hw *parent, *best_parent =3D NULL;
> > > +       unsigned long best_rate =3D 0;
> > > +       unsigned long best_prate =3D 0;
> > > +       unsigned long best_rate_diff =3D ULONG_MAX;
> > > +       unsigned long prate, calc_rate;
> > > +       size_t i;
> > > +
> > > +       /*
> > > +        * If the NO_REPARENT flag is set, try to use existing parent.
> > > +        */
> > > +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT)) {
> >=20
> > Is this flag ever set?
>=20
> Not right now, but it will be used as soon as I'll add the video clocks,
> so I thought to leave it be to avoid adding it back in the future.
> For this minimal support is not needed though, so let me know if you
> want it removed.
>=20

Ok sure.

>=20
> > > +
> > > +       [RP1_CLK_ETH_TSU] =3D REGISTER_CLK(.name =3D "clk_eth_tsu",
> > > +                               .parents =3D {"rp1-xosc"},
> > > +                               .num_std_parents =3D 0,
> > > +                               .num_aux_parents =3D 1,
> > > +                               .ctrl_reg =3D CLK_ETH_TSU_CTRL,
> > > +                               .div_int_reg =3D CLK_ETH_TSU_DIV_INT,
> > > +                               .sel_reg =3D CLK_ETH_TSU_SEL,
> > > +                               .div_int_max =3D DIV_INT_8BIT_MAX,
> > > +                               .max_freq =3D 50 * MHz,
> > > +                               .fc0_src =3D FC_NUM(5, 7),
> > > +                               ),
> > > +
> > > +       [RP1_CLK_SYS] =3D REGISTER_CLK(.name =3D "clk_sys",
> > > +                               .parents =3D {"rp1-xosc", "-", "pll_s=
ys"},
> >=20
> > Please use struct clk_parent_data or clk_hw directly. Don't use strings
> > to describe parents.
>=20
> Describing parents as as strings allows to directly assign it to struct
> clk_init_data, as in rp1_register_clock():
>=20
> const struct rp1_clock_data *clock_data =3D data;
> struct clk_init_data init =3D { };
> ...
> init.parent_names =3D clock_data->parents;
>=20
> otherwise we should create an array and populate from clk_parent_data::na=
me,
> which is of course feasible but a bit less compact. Are you sure you want
> to change it?
>=20

Do not use strings to describe parents. That's the guiding principle
here. I agree using strings certainly makes it easy to describe things
but that doesn't mean it is acceptable.

> > > +       struct clk *clk_xosc;
> > > +       struct clk_hw **hws;
> > > +       unsigned int i;
> > > +
> > > +       clockman =3D devm_kzalloc(dev, struct_size(clockman, onecell.=
hws, asize),
> > > +                               GFP_KERNEL);
> > > +       if (!clockman)
> > > +               return -ENOMEM;
> > > +
> > > +       spin_lock_init(&clockman->regs_lock);
> > > +       clockman->dev =3D dev;
> > > +
> > > +       clockman->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > > +       if (IS_ERR(clockman->regs))
> > > +               return PTR_ERR(clockman->regs);
> > > +
> > > +       clk_xosc =3D devm_clk_get_enabled(dev, NULL);
> > > +       if (IS_ERR(clk_xosc))
> > > +               return PTR_ERR(clk_xosc);
> > > +
> > > +       clockman->hw_xosc =3D __clk_get_hw(clk_xosc);
> >=20
> > Please use struct clk_parent_data::index instead.
>=20
> Sorry, I didn't catch what you mean here. Can you please elaborate?
>=20

Don't use __clk_get_hw() at all. Also, don't use clk_get() and friends
in clk provider drivers. Use struct clk_parent_data so that the
framework can do the work for you at the right time.

