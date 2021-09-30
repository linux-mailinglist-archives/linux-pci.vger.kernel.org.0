Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E969941D628
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349310AbhI3JW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 05:22:28 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:55108 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349293AbhI3JW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 05:22:27 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 9e48778a;
        Thu, 30 Sep 2021 11:20:42 +0200 (CEST)
Date:   Thu, 30 Sep 2021 11:20:42 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com,
        kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st,
        Robin.Murphy@arm.com, joey.gouly@arm.com, joro@8bytes.org,
        kernel-team@android.com
In-Reply-To: <87fstmtrv2.wl-maz@kernel.org> (message from Marc Zyngier on Thu,
        30 Sep 2021 09:00:49 +0100)
Subject: Re: [PATCH v5 10/14] arm64: apple: Add pinctrl nodes
References: <20210929163847.2807812-1-maz@kernel.org>
        <20210929163847.2807812-11-maz@kernel.org>
        <CACRpkdaXbrmvoQQNRdyv6rJ+dHYAKMN+J_sc-3_c1d6D2dsfbQ@mail.gmail.com> <87fstmtrv2.wl-maz@kernel.org>
Message-ID: <561497c161587be0@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Thu, 30 Sep 2021 09:00:49 +0100
> From: Marc Zyngier <maz@kernel.org>

Hi Linus and Marc,

> On Wed, 29 Sep 2021 20:05:42 +0100,
> Linus Walleij <linus.walleij@linaro.org> wrote:
> > 
> > On Wed, Sep 29, 2021 at 6:56 PM Marc Zyngier <maz@kernel.org> wrote:
> > 
> > > From: Mark Kettenis <kettenis@openbsd.org>
> > >
> > > Add pinctrl nodes corresponding to the gpio,t8101 nodes in the
> > > Apple device tree for the Mac mini (M1, 2020).
> > >
> > > Clock references are left out at the moment and will be added once
> > > the appropriate bindings have been settled upon.
> > >
> > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Link: https://lore.kernel.org/r/20210520171310.772-3-mark.kettenis@xs4all.nl
> > (...)
> > > +               pinctrl_ap: pinctrl@23c100000 {
> > > +                       compatible = "apple,t8103-pinctrl", "apple,pinctrl";
> > > +                       reg = <0x2 0x3c100000 0x0 0x100000>;
> > > +
> > > +                       gpio-controller;
> > > +                       #gpio-cells = <2>;
> > > +                       gpio-ranges = <&pinctrl_ap 0 0 212>;
> > 
> > In other discussions it turns out that the driver is abusing these gpio-ranges
> > to find out how many pins are in each pinctrl instance. This is not the
> > idea with gpio-ranges, these can be multiple and map different sets,
> > so we need something like
> > 
> > apple,npins = <212>;
> > (+ bindings)
> > 
> > or so...
> 
> Is it the driver that needs updating? Or the binding? I don't really
> care about the former, but the latter is more disruptive as it has
> impacts over both u-boot and at least OpenBSD.

I don't have a finished OpenBSD driver yet, and U-Boot support is
still in the process of being upstreamed, so tweaking the binding a
bit is not out of the question at this point.  And as long as the
gpio-ranges property continues to be there, things won't break anyway.

> How is that solved on other pinctrl blocks? I can't see anyone having
> a similar a similar property.

I suspect most pinctrl blocks have a well-defined number of pins that
is simply a #define in the driver.  Here we don't really know what the
hardware provides but the "Apple device tree" has a property that
describes the number of pins, which varies between the different
blocks.

Since there is a simple 1:1 mapping between pins and gpios it seemed
natural to me to simply use the value from gpio-ranges.  My thinking
was that having a separate property to encode the number of pins just
increases the chances of the two getting out of sync.  But maybe that
is the whole point Linus is trying to make; not all pins may actually
provide GPIO functionality and gpio-ranges can be used to map only
those pins that actually do.  In this particular case I don't think it
makes sense to map multiple ranges though as we will probably never
know full details for all the pins.

FWIW, there are other U-Boot drivers that use gpio-ranges to get the
pin count.  But I suppose U-Boot has somewhat different standards than
the Linux kernel, prioritising code size and such.
