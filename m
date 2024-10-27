Return-Path: <linux-pci+bounces-15394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F059B1D62
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 12:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5010AB21197
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F61514C9;
	Sun, 27 Oct 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T1d2eAb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE71465B8
	for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730028486; cv=none; b=eQt3tFZqO1Z/Gy1y61NtGYPPsfSw7UPlRoRVgxbp/Ecjlxfixq0a4lhBrNcEP0yC/iEi2PMFSJmFuLvluzx8dYpBBe/Tjk4xY5ikxmUKD42G070ylM8Rw3ZJGS9dafMxXjDx1QmWU58cDrbvbfgGb3Gmn/tTyaCzhZPH00YBob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730028486; c=relaxed/simple;
	bh=VuKJDG266cXHH/tjX7LtgrRYflBqMpSCHHivTRBSIco=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsfHOHHjDWEIFCbb69Cmq4FCm3EZKvwdi00bwu1ji/Rz1tLVsqBSI/HTyG0nUHaH8LcHpPkcBdcfrEpJsOodFDYC+fmlPD+tyucbVZEhdv0nHjS6ifRMFCZj+DzIl2FgDWcMNCkrUv4jGIVsfXzCukt7EDw+2NFp171iaYcsVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T1d2eAb9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so241600366b.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2024 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730028481; x=1730633281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cPFShITTIvH/DlQLcbPYfMWua0oqN7/wabrQnP5/RY=;
        b=T1d2eAb9N2HuHrZFTLZpeW+Cdvp5t0rsi4/TNGhOju3HzPhx7zkqEhZjHw4UhBHIni
         oHufcrp2J7zY1ZuBO7T3L2Wc9bswBB6Hp2NwSoyNztyHYH+Wr1cM29uvQo6z+Jp0rDmQ
         VFv9OEbMHJhe+ZWqe/IAdbiycz43/orn7DVXz/d9cRSWPjE6gazhcpILNsJ7iwXOlLO3
         /ufq6RR18Hi3FyvTs3nme+pw+qgEHcb0uJLTnV276wnqVXNUjBZlEZcrVaJv77MSO1xJ
         WKEHoojlNWeMMmITeW8gKBajVgGz5jhLHlIwIVWJ7CVkSMgUKyQgDq7NG38Up4qYyacZ
         RuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730028481; x=1730633281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cPFShITTIvH/DlQLcbPYfMWua0oqN7/wabrQnP5/RY=;
        b=drqSPHaAZ/sGsMBJs8w9f1TiPk56UQKPrAZvNzT7QoKBtx5ue/3hhVFoE1N1+HhDJV
         9BfpTAGzwe9KrcDYwIVYefwWg8xayTDhOrdXhC2zp7OdKjwmPyH6wEqQo2gZ1D27GCz4
         ap/PqL11Bjjpn1DYJ6dQJcH/l0CZFDzzMNS/AZEdqt4q0UC1HYtI0upHVx7I3e5hjXP8
         GjwrRKKu1fD4AM3sQflkaWnFXIBdVf8hbhW7g6jVwZIvObmHc1wLoWP7j8NqTd4izDZN
         WCAHUZAZkRZj/wi9lEbJrVszafaT+c2pH+M1uPurXBYk26Ak5HaFNi4Ho5M6W4bAyu6f
         ynLg==
X-Forwarded-Encrypted: i=1; AJvYcCXu236lFxEqHS1JsMT7SGN9dFvdxcrybbmwqLgvaO/yW6Sufzzcgy8iq4C2BVNO4V0PQ6RM1M04QzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBovcoqXT+QuoULRaAsVQ3lq5KH3BqqLg8ddvUgr/1aGUjnXf
	rxX5Kmmd+k/JUrUNbF2HVMP8YGkXaeC2morGEU3inr3EZe/JYXq8h34qDG0Ky/g=
X-Google-Smtp-Source: AGHT+IHDe3aK5safK/g97VZSuOAzRy7Z2gXlHXYzn/JhQ/9v/lVnM4Ln7FVM4yZYPgeb/pi28OnT4g==
X-Received: by 2002:a05:6402:5244:b0:5c9:45b5:6077 with SMTP id 4fb4d7f45d1cf-5cbbfa72da0mr6049967a12.23.1730028481000;
        Sun, 27 Oct 2024 04:28:01 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63487fcsm2268240a12.91.2024.10.27.04.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 04:28:00 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sun, 27 Oct 2024 12:28:23 +0100
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	St efan Wahren <wahrenst@gmx.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	phil@raspberrypi.com, jonathan@raspberrypi.com
Subject: Re: [PATCH v2 08/14] clk: rp1: Add support for clocks provided by RP1
Message-ID: <Zx4j1-y26si9Ojp8@apocalypse>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <022cf4920f8147cc720eaf02fd52c0fa56f565c5.1728300189.git.andrea.porta@suse.com>
 <611de50b5f083ea4c260f920ccc0e300.sboyd@kernel.org>
 <ZxkX5gnDkWrTynRv@apocalypse>
 <21fe104262989f04fadf9ec57dcac6df.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21fe104262989f04fadf9ec57dcac6df.sboyd@kernel.org>

Hi Stephen,

On 14:52 Wed 23 Oct     , Stephen Boyd wrote:
> Quoting Andrea della Porta (2024-10-23 08:36:06)
> > Hi Stephen,
> > 
> > On 15:08 Wed 09 Oct     , Stephen Boyd wrote:
> > > Quoting Andrea della Porta (2024-10-07 05:39:51)
> > > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > > index 299bc678ed1b..537019987f0c 100644
> > > > --- a/drivers/clk/Kconfig
> > > > +++ b/drivers/clk/Kconfig
> > > > @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
> > > >           These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
> > > >           Clkout1 is always on, Clkout2 can off by control register.
> > > >  
> > > > +config COMMON_CLK_RP1
> > > > +       tristate "Raspberry Pi RP1-based clock support"
> > > > +       depends on PCI || COMPILE_TEST
> > > 
> > > A better limit would be some ARCH_* config.
> > 
> > I've avoided ARCH_BCM2835 since the original intention is for this driver
> > to work (in the future) also for custom PCI cards with RP1 on-board, and not
> > only for Rpi5.
> 
> How will that custom PCI card work? It will need this driver to probe?

AFAICT there's no commercially available PCI card slot sporting an RP1 on-board,
but this driver should be used to probe and use that card too.

> Is the iomem going to be exposed through some PCI config space?

Yes, just as leverage in this driver through BAR1.

> 
> It's not great to depend on CONFIG_PCI because then the driver is forced
> to be =m if PCI ever becomes tristate (unlikely, but still makes for bad
> copy/pasta). I understand this line is trying to limit the availability
> of the config symbol. Maybe it should simply depend on ARM or ARM64? Or
> on nothing at all.

I see, Herve proposed CONFIG_MISC_RP1 that is enabled whenever this driver is
selected, and it makes a lot of sense to me.

> 
> > 
> > > > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > > > new file mode 100644
> > > > index 000000000000..9016666fb27d
> > > > --- /dev/null
> > > > +++ b/drivers/clk/clk-rp1.c
> > > 
> > > > +#include <linux/clk.h>
> > > 
> > > Preferably this include isn't included.
> > 
> > This include is currently needed by devm_clk_get_enabled() to retrieve
> > the xosc. Since that clock is based on a crystal (so it's fixed and
> > always enabled), I'm planning to hardcode it in the driver. This will
> > not only get rid of the devm_clk_get_enabled() call (and hence of the
> > clk.h include), but it'll also simplify the top devicetree. No promise
> > though, I need to check a couple of things first.
> 
> A clk provider (clk-provider.h) should ideally not be a clk consumer
> (clk.h).

Ack.

> 
> > 
> > 
> > > > +
> > > > +static int rp1_pll_ph_set_rate(struct clk_hw *hw,
> > > > +                              unsigned long rate, unsigned long parent_rate)
> > > > +{
> > > > +       struct rp1_pll_ph *pll_ph = container_of(hw, struct rp1_pll_ph, hw);
> > > > +       const struct rp1_pll_ph_data *data = pll_ph->data;
> > > > +
> > > > +       /* Nothing really to do here! */
> > > 
> > > Is it read-only? Don't define a set_rate function then and make the rate
> > > determination function return the same value all the time.
> > 
> > Not 100% sure about it, maybe Raspberry Pi colleagues can explain.
> > By 'rate determination function' you're referring (in this case) to
> > rp1_pll_ph_recalc_rate(), right?
> 
> Yes.
> 
> > If so, that clock type seems to have
> > a fixed divider but teh resulting clock depends on the parent rate, so
> > it has to be calculated.
> 
> Sure, it has to be calculated, but it will return the rate that causes
> no change to the hardware. When that happens, the set_rate() op should
> be skipped, and you can see that with clk_divider_ro_ops not having a
> set_rate() function pointer.

Ack.

> 
> > 
> > > > +static int rp1_clock_determine_rate(struct clk_hw *hw,
> > > > +                                   struct clk_rate_request *req)
> > > > +{
> > > > +       struct clk_hw *parent, *best_parent = NULL;
> > > > +       unsigned long best_rate = 0;
> > > > +       unsigned long best_prate = 0;
> > > > +       unsigned long best_rate_diff = ULONG_MAX;
> > > > +       unsigned long prate, calc_rate;
> > > > +       size_t i;
> > > > +
> > > > +       /*
> > > > +        * If the NO_REPARENT flag is set, try to use existing parent.
> > > > +        */
> > > > +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT)) {
> > > 
> > > Is this flag ever set?
> > 
> > Not right now, but it will be used as soon as I'll add the video clocks,
> > so I thought to leave it be to avoid adding it back in the future.
> > For this minimal support is not needed though, so let me know if you
> > want it removed.
> > 
> 
> Ok sure.
> 
> > 
> > > > +
> > > > +       [RP1_CLK_ETH_TSU] = REGISTER_CLK(.name = "clk_eth_tsu",
> > > > +                               .parents = {"rp1-xosc"},
> > > > +                               .num_std_parents = 0,
> > > > +                               .num_aux_parents = 1,
> > > > +                               .ctrl_reg = CLK_ETH_TSU_CTRL,
> > > > +                               .div_int_reg = CLK_ETH_TSU_DIV_INT,
> > > > +                               .sel_reg = CLK_ETH_TSU_SEL,
> > > > +                               .div_int_max = DIV_INT_8BIT_MAX,
> > > > +                               .max_freq = 50 * MHz,
> > > > +                               .fc0_src = FC_NUM(5, 7),
> > > > +                               ),
> > > > +
> > > > +       [RP1_CLK_SYS] = REGISTER_CLK(.name = "clk_sys",
> > > > +                               .parents = {"rp1-xosc", "-", "pll_sys"},
> > > 
> > > Please use struct clk_parent_data or clk_hw directly. Don't use strings
> > > to describe parents.
> > 
> > Describing parents as as strings allows to directly assign it to struct
> > clk_init_data, as in rp1_register_clock():
> > 
> > const struct rp1_clock_data *clock_data = data;
> > struct clk_init_data init = { };
> > ...
> > init.parent_names = clock_data->parents;
> > 
> > otherwise we should create an array and populate from clk_parent_data::name,
> > which is of course feasible but a bit less compact. Are you sure you want
> > to change it?
> > 
> 
> Do not use strings to describe parents. That's the guiding principle
> here. I agree using strings certainly makes it easy to describe things
> but that doesn't mean it is acceptable.

Ack.

> 
> > > > +       struct clk *clk_xosc;
> > > > +       struct clk_hw **hws;
> > > > +       unsigned int i;
> > > > +
> > > > +       clockman = devm_kzalloc(dev, struct_size(clockman, onecell.hws, asize),
> > > > +                               GFP_KERNEL);
> > > > +       if (!clockman)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       spin_lock_init(&clockman->regs_lock);
> > > > +       clockman->dev = dev;
> > > > +
> > > > +       clockman->regs = devm_platform_ioremap_resource(pdev, 0);
> > > > +       if (IS_ERR(clockman->regs))
> > > > +               return PTR_ERR(clockman->regs);
> > > > +
> > > > +       clk_xosc = devm_clk_get_enabled(dev, NULL);
> > > > +       if (IS_ERR(clk_xosc))
> > > > +               return PTR_ERR(clk_xosc);
> > > > +
> > > > +       clockman->hw_xosc = __clk_get_hw(clk_xosc);
> > > 
> > > Please use struct clk_parent_data::index instead.
> > 
> > Sorry, I didn't catch what you mean here. Can you please elaborate?
> > 
> 
> Don't use __clk_get_hw() at all. Also, don't use clk_get() and friends
> in clk provider drivers. Use struct clk_parent_data so that the
> framework can do the work for you at the right time.

Ack.

Many thanks,
Andrea

