Return-Path: <linux-pci+bounces-26085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F71A919B3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C29619E4479
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2985022DF90;
	Thu, 17 Apr 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pYcnVdLJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E822DFAA
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886937; cv=none; b=LRKuWxHuJxtDjUHIaDaJcB/Ni+e6b0htWD162aH9Za2DDufwCwB4nu8j2Ya/V6iNC0+XQVVGpOQxnvcAjna+qvQT1pFptwFxaoc76JgN2aOylNsBu445koDHNct5dY2JJwGh7DF7ra/y1AMYBZLrDHk8yYCSpHrG0zwhTA56OCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886937; c=relaxed/simple;
	bh=4pibXglK3gGf+8wEN4aAfoyWh7nWBoz3QMuio9PyFtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Efa7aGb8RBVemvaTZF4GGyQr2d6IiQywbMGcqkCxXLaYYfBA/wIFf6rpytn0I7QJrECYltY/PAk8zp1t7FgxYfhDEX1oB2IPMQ3aQ4AYI9HVk7tyyqFpzrpiYe68hwOTINT3o41rO7F4MBA4WSAF3f5NEJ3plsbVjmCy07+UFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pYcnVdLJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7053f85f059so4838577b3.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1744886933; x=1745491733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FQmq6mPm5BcVKIvGNINkYwYP9M0N7suMdJCV/VEqS4=;
        b=pYcnVdLJClODBLL3cEhaZyq02F25oC8gldZrLr+fyxKbi0cqeQ3ujT2q+7gyIny5vw
         im5KVilXZgrKh7aJQ6mm2iw1ocqdQdPpJQZfNgHk70pG5FRoPuvwCxDBH8LRjFP5IHHj
         dWpEvik4bFQuwIsUaf6vAZPnD7kkFWct3Jd5ByG3XZllNveFpHxZ63QX+WsUOUquYMor
         10qPc77NZN7e+fZfMqMSqMebES4L7hotNWt0x/I9HdQgtNQ7oi1sm0p3FHsPmzaXWbI2
         n5X0a+PAUJLKeDxavD/k3uKZOjOJoFqXTUX+Idu7uFuYhuEOnGy7XjJjcX8tqbp2tLhH
         +/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744886933; x=1745491733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FQmq6mPm5BcVKIvGNINkYwYP9M0N7suMdJCV/VEqS4=;
        b=VYeZi5rqt06E6nj0YK0qf5veu4MSspoMnTG9KyoPxw6gN/wtzAFbVCBnNNchaxSIXc
         SnX6bkL78iWsP0OSIqQoRTUq2Ju4ivRxJVk8pH1zIKCqMmGAigGwZR3GfE9gPx9T1iU2
         jDqm8lF7iFbyAfv+23J7nGo3CwDEuRLRmvmSeMrcyihiw1hb6N1oN/H8S+RDGaJNJMCh
         KFx4jds3hgAjHOJIGXoy36oURZewPJJ0JxsfewdFLXSsHhiowcyzRhaU2IkiKmYaOwaF
         mdtKJsyWQIx1UvFHdE3Afo0BcSfUrA2T3zi+w1pvZsgOJuG1G5T4D2bp4SRUpFDaFMgu
         NFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW8/2wxfZdYZnAWNEBxTV9K1yccpDACxayTijWrxMmn/tGnCU3+S5TD2FiVTIJkumTbaR4133S3/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluOOkm/KGC1TsJ37may4Zy592eoYAqx9SC7R11tWKYZNABTxC
	4agQLds1cNKBrlTV6/NDewhOb26+8ECIR7RXmSP9WfOHwGkWf3iF4ngU2hVSx1fHYH9HVvKVJZG
	zOSNUJBJjwViZiHhWSvWzzu3jsRwlxRNkCFMbqg==
X-Gm-Gg: ASbGncsZuOfyfy9d1+Ugl50ZALnL3fO4aIYyE8d0/2evQa50Zvytl+uqvRu2ovxheBf
	mTL0ECebQ2GbP3mVeLoBpp0b4HuX4S85Pomc9p92d/OtO7gulZPhg9o7brgQlb2jw4maj6UohET
	Pnj7cXVbS7mZQ0tJsa99soo3XiLt+eLeBgFN6rbv4Ih7QTh3Dy6n+z8Q==
X-Google-Smtp-Source: AGHT+IGLKmF80adLXuj1efSVNgIqhTYlmIxxyWRh7p0wE2BMSJ0PxoGhtbuAHVljmhe5c9jUioDN6HwA2xV5k59yvpc=
X-Received: by 2002:a05:690c:670c:b0:700:b389:9246 with SMTP id
 00721157ae682-706b3392ea3mr77881107b3.38.1744886933054; Thu, 17 Apr 2025
 03:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742418429.git.andrea.porta@suse.com> <370137263691f4fc14928e4b378b27f75bfd0826.1742418429.git.andrea.porta@suse.com>
 <23ac3d05-5fb7-4cd8-bb87-cf1f3eab521d@gmx.net> <Z__alTyVJOwu_1gR@apocalypse>
In-Reply-To: <Z__alTyVJOwu_1gR@apocalypse>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 17 Apr 2025 11:48:34 +0100
X-Gm-Features: ATxdqUEMIuDD2WyNd1OQ61A-4i5J24ssAwpI3St8SjdqbRIE5I7kKrXYJo4vPvA
Message-ID: <CAPY8ntD2W5xAHGCD+uBL-0QgyYNj6k9MExns=DFvxU1WGYtO5g@mail.gmail.com>
Subject: Re: [PATCH v8 05/13] clk: rp1: Add support for clocks provided by RP1
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>, kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrea & Stefan.

On Wed, 16 Apr 2025 at 17:26, Andrea della Porta <andrea.porta@suse.com> wrote:
>
> Hi Stefan,
>
> On 14:09 Mon 14 Apr     , Stefan Wahren wrote:
> > Hi Andrea,
> >
> > Am 19.03.25 um 22:52 schrieb Andrea della Porta:
> > > RaspberryPi RP1 is an MFD providing, among other peripherals, several
> > > clock generators and PLLs that drives the sub-peripherals.
> > > Add the driver to support the clock providers.
> > >
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > ---
> > >   MAINTAINERS           |    5 +
> > >   drivers/clk/Kconfig   |    9 +
> > >   drivers/clk/Makefile  |    1 +
> > >   drivers/clk/clk-rp1.c | 1512 +++++++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 1527 insertions(+)
> > >   create mode 100644 drivers/clk/clk-rp1.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 896a307fa065..75263700370d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19748,6 +19748,11 @@ S: Maintained
> > >   F:        Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> > >   F:        drivers/media/platform/raspberrypi/rp1-cfe/
> > >
> > > +RASPBERRY PI RP1 PCI DRIVER
> > > +M: Andrea della Porta <andrea.porta@suse.com>
> > > +S: Maintained
> > > +F: drivers/clk/clk-rp1.c
> > > +
> > >   RC-CORE / LIRC FRAMEWORK
> > >   M:        Sean Young <sean@mess.org>
> > >   L:        linux-media@vger.kernel.org
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index 713573b6c86c..cff90de71409 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
> > >       These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
> > >       Clkout1 is always on, Clkout2 can off by control register.
> > >
> > > +config COMMON_CLK_RP1
> > > +   tristate "Raspberry Pi RP1-based clock support"
> > > +   depends on MISC_RP1 || COMPILE_TEST
> > > +   default MISC_RP1
> > > +   help
> > > +     Enable common clock framework support for Raspberry Pi RP1.
> > > +     This multi-function device has 3 main PLLs and several clock
> > > +     generators to drive the internal sub-peripherals.
> > > +
> > >   config COMMON_CLK_HI655X
> > >     tristate "Clock driver for Hi655x" if EXPERT
> > >     depends on (MFD_HI655X_PMIC || COMPILE_TEST)
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > index bf4bd45adc3a..ff3993ed7e09 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -84,6 +84,7 @@ obj-$(CONFIG_CLK_LS1028A_PLLDIG)  += clk-plldig.o
> > >   obj-$(CONFIG_COMMON_CLK_PWM)              += clk-pwm.o
> > >   obj-$(CONFIG_CLK_QORIQ)                   += clk-qoriq.o
> > >   obj-$(CONFIG_COMMON_CLK_RK808)            += clk-rk808.o
> > > +obj-$(CONFIG_COMMON_CLK_RP1)            += clk-rp1.o
> > >   obj-$(CONFIG_COMMON_CLK_HI655X)           += clk-hi655x.o
> > >   obj-$(CONFIG_COMMON_CLK_S2MPS11)  += clk-s2mps11.o
> > >   obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
> > > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > > new file mode 100644
> > > index 000000000000..72c74e344c1d
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-rp1.c
> > > @@ -0,0 +1,1512 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > ...
> > > +
> > > +static int rp1_pll_divider_set_rate(struct clk_hw *hw,
> > > +                               unsigned long rate,
> > > +                               unsigned long parent_rate)
> > > +{
> > > +   struct rp1_clk_desc *divider = container_of(hw, struct rp1_clk_desc, div.hw);
> > > +   struct rp1_clockman *clockman = divider->clockman;
> > > +   const struct rp1_pll_data *data = divider->data;
> > > +   u32 div, sec;
> > > +
> > > +   div = DIV_ROUND_UP_ULL(parent_rate, rate);
> > > +   div = clamp(div, 8u, 19u);
> > > +
> > > +   spin_lock(&clockman->regs_lock);
> > > +   sec = clockman_read(clockman, data->ctrl_reg);
> > > +   sec &= ~PLL_SEC_DIV_MASK;
> > > +   sec |= FIELD_PREP(PLL_SEC_DIV_MASK, div);
> > > +
> > > +   /* Must keep the divider in reset to change the value. */
> > > +   sec |= PLL_SEC_RST;
> > > +   clockman_write(clockman, data->ctrl_reg, sec);
> > > +
> > > +   /* TODO: must sleep 10 pll vco cycles */
> > Is it possible to implement this with some kind of xsleep or xdelay?
>
> I guess so... unless anyone knows a better method such as checking
> for some undocumented register flag which reveals when the clock is stable
> so it can be enabled (Phil, Dave, please feel free to step in with advice
> if you have any), I think this line could solve the issue:
>
> ndelay (10 * div * NSEC_PER_SEC / parent_rate);

I've checked with those involved in the hardware side.
There's no hardware flag that the clock is stable, so the ndelay is
probably the best option. The VCO can go as low as 600MHz, so the max
delay would be 166ns.

Thanks for your continuing work on this.

  Dave

> Many thanks,
> Andrea
>
> > > +   sec &= ~PLL_SEC_RST;
> > > +   clockman_write(clockman, data->ctrl_reg, sec);
> > > +   spin_unlock(&clockman->regs_lock);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >

