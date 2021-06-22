Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F043B0F05
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 22:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFVUyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 16:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFVUyj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 16:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36FCF6128E;
        Tue, 22 Jun 2021 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624395143;
        bh=hH4t4IGj4VR4J+cMWVqFBU8N8id8Mph8TdU2rMr6BuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+qMj8oCx6iFhCWYi3Tg7wObCN34IfWuVcYzg/UhxwSnK/4kFAwPmIUugwHxT7tEH
         DtaZOtv5tya7FXdwWZ4nAv1a+ALj6Je6qlqE0qx980ErTe1zEfHomOluLvHBTkvCIP
         rCViBqfCLdvPf6IguiuMibn7yvu9MjGrhQaqadIHzRwKclh03VMXTSayKdis/3V+VQ
         aBNT5a2Ps1U81zAF+cb2V5ZvcS9BXXdm/HwmE0GKcWGmB1zzPrPyYn+btQATBTiTCm
         hnLUwQkXMPSVBkeTGddX2MgyGcd89ZOtmTlCpNuf29yvPqow9VB0lcEqQZgVJiOB9X
         hKRZPpI9nKt+A==
Received: by pali.im (Postfix)
        id B4C89889; Tue, 22 Jun 2021 22:52:20 +0200 (CEST)
Date:   Tue, 22 Jun 2021 22:52:20 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linus.walleij@linaro.org, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210622205220.ypu22tuxhpdn2jwz@pali>
References: <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
 <20210622110627.aqzxxtf2j3uxfeyl@pali>
 <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
 <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 22 June 2021 19:27:37 Kishon Vijay Abraham I wrote:
> Hi Luca, Pali,
> 
> On 22/06/21 7:01 pm, Luca Ceresoli wrote:
> > Hi,
> > 
> > On 22/06/21 14:16, Pali Rohár wrote:
> >> On Tuesday 22 June 2021 12:56:04 Lorenzo Pieralisi wrote:
> >>> [Adding Linus for GPIO discussion, thread:
> >>> https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net]
> >>>
> >>> On Tue, Jun 22, 2021 at 01:06:27PM +0200, Pali Rohár wrote:
> >>>> Hello!
> >>>>
> >>>> On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> >>>>> Nothing happened after a few weeks... I understand that knowing the
> >>>>> correct reset timings is relevant, but unfortunately I cannot help much
> >>>>> in finding out the correct values.
> >>>>>
> >>>>> However I'm wondering what should happen to this patch. It *does* fix a
> >>>>> real bug, but potentially with an incorrect or non-optimal usleep range.
> >>>>> Do we really want to ignore a bugfix because we are not sure about how
> >>>>> long this delay should be?
> >>>>
> >>>> As there is no better solution right now, I'm fine with your patch. But
> >>>> patch needs to be approved by Lorenzo, so please wait for his final
> >>>> answer.
> >>>
> >>> I am not a GPIO expert and I have a feeling this is platform specific
> >>> beyond what the PCI specification can actually define architecturally.
> >>
> >> In my opinion timeout is not platform specific as I wrote in email:
> >> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
> >>
> >> My experiments already proved that some PCIe cards needs to be in reset
> >> state for some minimal time otherwise they cannot be enumerated. And it
> >> does not matter to which platform you connect those (endpoint) cards.
> >>
> >> I do not think that timeout itself is platform specific. GPIO controls
> >> PERST# pin and therefore specified sleep value directly drives how long
> >> is card on the other end of PCIe slot in Warm Reset state. PCIe CEM spec
> >> directly says that PERST# signal controls PCIe Warm Reset.
> >>
> >> What is here platform specific thing is that PERST# signal is controlled
> >> by GPIO. But value of signal (high / low) and how long is in signal in
> >> which state for me sounds like not an platform specific thing, but as
> >> PCIe / CEM related.
> > 
> > That's exactly my understanding of this matter. At least for the dra7xx
> > controller it works exactly like this, PERSTn# is nothing but a GPIO
> > output from the SoC that drives the PERSTn# input of the external chip
> > without affecting the controller directly.
> > 
> 
> While the patch itself is correct, this kind-of changes the behavior on
> already upstreamed platforms. Previously the driver expected #PERST to
> be asserted be external means (or default power-up state) and only takes
> care of de-asserting the #PERST line.
> 
> There are 2 platforms that will be impacted due to this change
> 1) arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi (has an inverter on
> GPIO line)
> 2) arch/arm/boot/dts/am571x-idk.dts (directly connected to #PERST)
> 
> For 1), gpiod_set_value(reset, 0) will assert the PERST line due to the
> inverter (and GPIO_ACTIVE_LOW)
> For 2), gpiod_set_value(reset, 0) will assert the PERST line because we
> have GPIO_ACTIVE_HIGH

Ou! This is a problem in DT. It needs to be defined in a way that state
is same for every DTS device which uses this driver.

> So this patch should have to be accompanied with DT changes (and this
> patch also breaks old DT compatibility).

This of course needs to be fixed somehow prior accepting this patch. It
is blocker as in current state it breaks some platforms.

> 
> Thanks
> Kishon
