Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B643B38E5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXVol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 17:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXVok (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 17:44:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF4A3613B7;
        Thu, 24 Jun 2021 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624570940;
        bh=XX/ufAUGd6uDScCXNLgP0Pd9TE16/LbErumHmWXu4Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL+zs803ZcJET6SiAcOEa3dx9STWejvD5E5KE/9WbcrkCsgtsctIIQKhLAKaDAKBG
         A/xbTBP8AjCW1Fi4+2qoT0xmx8yvXvKIlXzWIz32JrzEF7uHL24pZvJ6SJvS3YNAZ6
         PDqVLyK+4/ZtFruUy2HoDsHYuYJSOOJkC46k4BsrSAymkiyorJliAFrZk/p442zdq6
         x1WRBQMmurheTdl/46PZ6qqR4wxI93ybRXpHmtJiVWX7HYKBEcC9Dmz6hIM7fBWZgv
         KspSc/06xkFXrApz/CLzeTe9gu4TmZmgZ32tKkqCvqCpg9dn6lOFt6z2NVxUEwIweQ
         RG+1O/gQh8CWA==
Received: by pali.im (Postfix)
        id 83B5C8A3; Thu, 24 Jun 2021 23:42:17 +0200 (CEST)
Date:   Thu, 24 Jun 2021 23:42:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linus.walleij@linaro.org, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210624214217.dlbjhfbnyyoqdskl@pali>
References: <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
 <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
 <20210622205220.ypu22tuxhpdn2jwz@pali>
 <2873969e-ac56-a41f-0cc9-38e387542aa1@lucaceresoli.net>
 <20210622211901.ikulpy32d6qlr4yw@pali>
 <588741e4-b085-8ae2-3311-27037c040a57@lucaceresoli.net>
 <20210622222328.3lfgkrhsdy6izedv@pali>
 <51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 June 2021 23:31:10 Luca Ceresoli wrote:
> Hi Pali,
> 
> On 23/06/21 00:23, Pali Rohár wrote:
> > On Tuesday 22 June 2021 23:36:35 Luca Ceresoli wrote:
> >> Hi Pali,
> >>
> >> On 22/06/21 23:19, Pali Rohár wrote:
> >>> On Tuesday 22 June 2021 23:08:07 Luca Ceresoli wrote:
> >>>> On 22/06/21 22:52, Pali Rohár wrote:
> >>>>> On Tuesday 22 June 2021 19:27:37 Kishon Vijay Abraham I wrote:
> >>>>>> Hi Luca, Pali,
> >>>>>>
> >>>>>> On 22/06/21 7:01 pm, Luca Ceresoli wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On 22/06/21 14:16, Pali Rohár wrote:
> >>>>>>>> On Tuesday 22 June 2021 12:56:04 Lorenzo Pieralisi wrote:
> >>>>>>>>> [Adding Linus for GPIO discussion, thread:
> >>>>>>>>> https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]
> >>>>>>>>>
> >>>>>>>>> On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
> >>>>>>>>>> Hello!
> >>>>>>>>>>
> >>>>>>>>>> On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> >>>>>>>>>>> Nothing happened after a few weeks... I understand that knowing the
> >>>>>>>>>>> correct reset timings is relevant, but unfortunately I cannot help much
> >>>>>>>>>>> in finding out the correct values.
> >>>>>>>>>>>
> >>>>>>>>>>> However I'm wondering what should happen to this patch. It *does* fix a
> >>>>>>>>>>> real bug, but potentially with an incorrect or non-optimal usleep range.
> >>>>>>>>>>> Do we really want to ignore a bugfix because we are not sure about how
> >>>>>>>>>>> long this delay should be?
> >>>>>>>>>>
> >>>>>>>>>> As there is no better solution right now, I'm fine with your patch. But
> >>>>>>>>>> patch needs to be approved by Lorenzo, so please wait for his final
> >>>>>>>>>> answer.
> >>>>>>>>>
> >>>>>>>>> I am not a GPIO expert and I have a feeling this is platform specific
> >>>>>>>>> beyond what the PCI specification can actually define architecturally.
> >>>>>>>>
> >>>>>>>> In my opinion timeout is not platform specific as I wrote in email:
> >>>>>>>> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> >>>>>>>>
> >>>>>>>> My experiments already proved that some PCIe cards needs to be in reset
> >>>>>>>> state for some minimal time otherwise they cannot be enumerated. And it
> >>>>>>>> does not matter to which platform you connect those (endpoint) cards.
> >>>>>>>>
> >>>>>>>> I do not think that timeout itself is platform specific. GPIO controls
> >>>>>>>> PERST# pin and therefore specified sleep value directly drives how long
> >>>>>>>> is card on the other end of PCIe slot in Warm Reset state. PCIe CEM spec
> >>>>>>>> directly says that PERST# signal controls PCIe Warm Reset.
> >>>>>>>>
> >>>>>>>> What is here platform specific thing is that PERST# signal is controlled
> >>>>>>>> by GPIO. But value of signal (high / low) and how long is in signal in
> >>>>>>>> which state for me sounds like not an platform specific thing, but as
> >>>>>>>> PCIe / CEM related.
> >>>>>>>
> >>>>>>> That's exactly my understanding of this matter. At least for the dra7xx
> >>>>>>> controller it works exactly like this, PERSTn# is nothing but a GPIO
> >>>>>>> output from the SoC that drives the PERSTn# input of the external chip
> >>>>>>> without affecting the controller directly.
> >>>>>>>
> >>>>>>
> >>>>>> While the patch itself is correct, this kind-of changes the behavior on
> >>>>>> already upstreamed platforms. Previously the driver expected #PERST to
> >>>>>> be asserted be external means (or default power-up state) and only takes
> >>>>>> care of de-asserting the #PERST line.
> >>>>>>
> >>>>>> There are 2 platforms that will be impacted due to this change
> >>>>>> 1) arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi (has an inverter on
> >>>>>> GPIO line)
> >>>>>> 2) arch/arm/boot/dts/am571x-idk.dts (directly connected to #PERST)
> >>>>>>
> >>>>>> For 1), gpiod_set_value(reset, 0) will assert the PERST line due to the
> >>>>>> inverter (and GPIO_ACTIVE_LOW)
> >>>>>> For 2), gpiod_set_value(reset, 0) will assert the PERST line because we
> >>>>>> have GPIO_ACTIVE_HIGH
> >>>>>
> >>>>> Ou! This is a problem in DT. It needs to be defined in a way that state
> >>>>> is same for every DTS device which uses this driver.
> >>>>
> >>>> Why?
> >>>
> >>> I'm starting to be confused by triple or more negations (asserting,
> >>> signal inverter, active low)...
> >>>
> >>> In your patch is GPIO set value to 0 and Kishon wrote that GPIO set
> >>> value to 0 for those two boards assert PERST# line. Asserting PERST#
> >>> line cause endpoint PCIe card to be in reset state. And in pci-dra7xx.c
> >>> driver there is no other code which de-asserts PERST# line.
> >>>
> >>> So based on all this information I deduced that your patch will cause
> >>> putting PCIe cards into reset state (forever) and therefore they would
> >>> not work.
> >>>
> >>> Or do I have here some mistake?
> >>
> >> Uhm, at time time in the night I'm not sure I can do much more than
> >> adding a few notes on top of the commit message. I hope it helps anyway.
> >>
> >> The PCIe PERSTn reset pin is active low and should be asserted, then
> >> deasserted.
> >>
> >> The current implementation only drives the pin once in "HIGH" position,
> >> thus presumably it was intended to deassert the pin. This has two problems:
> >>
> >>   1) it assumes the pin was asserted by other means before loading the
> >>      driver [Note: Kishon confirmed so far]
> > 
> > This is easily solvable. Just assert PERST# pin explicitly via
> > gpiod_set_value() call prior calling that sleep function. And it would
> > work whatever state that pin has at init time. This has advantage that
> > reader of that code does not need to do too much investigation to check
> > at which state is GPIO at probe time and what implication it has...
> 
> I agree, it's what my patch does.
> 
> > Some other driver are doing it too, e.g. pci-aardvark.c.
> > 
> > Due to fact that also bootloader may use PCIe bus (maybe not now, but in
> > future; like it happened with pci-aardvark after introducing boot
> > support from NVMe disks), initial state may change.
> > 
> >>   2) it has the wrong polarity, since "HIGH" means "active", and the pin is
> >>      presumably configured as active low coherently with the PCIe
> >>      convention, thus it is driven physically to 0, keeping the device
> >>      under reset unless the pin is configured as active high.
> >>      [Note: the curren 2 DTS files pointed to by Kishon have different
> >>       polarities]
> >>
> >> Fix both problems by:
> >>
> >>   1) keeping devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH) as is, but
> >>      assuming the pin is correctly configured as "active low" this now
> >>      becomes a reset assertion
> >>   2) adding gpiod_set_value(reset, 0) after a delay to deassert reset
> >> [Note: this is exactly the current idea, but with the additional need to
> >> fix (=invert) the current polarities in DT]
> > 
> > Lorenzo asked a good question how GPIO drives PERST#. And maybe it would
> > be a good idea to unify all pci controller drivers to use same GPIO
> > value for asserting PERST# pin. If it is possible. As we can see it is a
> > big mess.
> 
> I might be short-righted, but I can think of only one way the code
> should look like in controller drivers. Which is, unsurprisingly, what
> my patch does:
> 
>   /* 1 == assert reset == put device under reset */
>   gpiod_set_value(reset, 1);
>   /* or: devm_gpiod_get_optional(..., GPIOD_OUT_HIGH); */
> 
>   usleep_range(/* values under discussion */);
> 
>   /* 0 == deassert reset == release device from reset */
>   gpiod_set_value(reset, 0);

This logic looks to be correct.

> The PCI controller driver should and can't care about any line
> inversion. It's board-dependent, and as such it should be marked in
> device tree (or ACPI or whatever -- I'm assuming ACPI can describe this it).

Exactly! I agree with you. And it has to be specified in DTS correctly
(or ACPI or whatever is used).

> Am I overlooking anything?

I'm still confused by sentence "gpiod_set_value(reset, 0) will assert
the PERST line" written by Kishon as you wrote that: 0 == deassert...

So I will wait for a new patch with comments and hopefully Kishon either
review that new patch is correct or find out if there is an issue
(either in some DTS file or driver code).

> -- 
> Luca
> 
