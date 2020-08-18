Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659924874F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHROXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgHROXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:36 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0585220786;
        Tue, 18 Aug 2020 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597760616;
        bh=+GOujhHAY+gAEigj74Monf6Mzd+lgkl+g0F3Tv3WS8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=URvpGZeB90KNMmrakNX0199Z+p6eJK53RHlpKE8iE+cnXzL6kGjr0FV70wFlRDu0b
         +4iIc5cxrXz4PPqUbVLnwGreeJ9OPV2INoNFJYHssg+lFDduRK2D990Zji5oSQG8mm
         r73S8S0ktI7fb8elJGj03MMRXYlceUxXz4PW8kQw=
Received: by mail-oo1-f48.google.com with SMTP id z11so4182621oon.5;
        Tue, 18 Aug 2020 07:23:35 -0700 (PDT)
X-Gm-Message-State: AOAM532MU8Uw9JQfb3/Z+jyhuluhrppxh35Y7A2apLxlVPNynDVSzc5b
        aVfBw+t9S+d0grKESJiVEMRxgGFjBvknJl63jA==
X-Google-Smtp-Source: ABdhPJx/OxIxzT0i2pOqWVTEd+J0VZRhMCUcmr0cGzPYOXpagNM4BQrXXTT1e4HT0/tDAhSgVCFIOUZ0yyBT/uxJqAc=
X-Received: by 2002:a4a:a60a:: with SMTP id e10mr15069228oom.25.1597760615266;
 Tue, 18 Aug 2020 07:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200815125112.462652-2-maz@kernel.org> <20200815232228.GA1325245@bjorn-Precision-5520>
 <87pn7qnabq.wl-maz@kernel.org> <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
 <e2cde177e82fbdf158732ad73ccdc6c5@kernel.org>
In-Reply-To: <e2cde177e82fbdf158732ad73ccdc6c5@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Aug 2020 08:23:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1_d2grS3Pz6NNeVAOMPbx_hAe+MrseQeQp=bHRQ7rfQ@mail.gmail.com>
Message-ID: <CAL_JsqL1_d2grS3Pz6NNeVAOMPbx_hAe+MrseQeQp=bHRQ7rfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rockchip: Work around missing device_type
 property in DT
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 18, 2020 at 1:35 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-08-17 17:12, Rob Herring wrote:
> > On Sun, Aug 16, 2020 at 4:40 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On Sun, 16 Aug 2020 00:22:28 +0100,
> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> >
> >> > On Sat, Aug 15, 2020 at 01:51:11PM +0100, Marc Zyngier wrote:
> >> > > Recent changes to the DT PCI bus parsing made it mandatory for
> >> > > device tree nodes describing a PCI controller to have the
> >> > > 'device_type = "pci"' property for the node to be matched.
> >> > >
> >> > > Although this follows the letter of the specification, it
> >> > > breaks existing device-trees that have been working fine
> >> > > for years.  Rockchip rk3399-based systems are a prime example
> >> > > of such collateral damage, and have stopped discovering their
> >> > > PCI bus.
> >> > >
> >> > > In order to paper over the blunder, let's add a workaround
> >> > > to the pcie-rockchip driver, adding the missing property when
> >> > > none is found at boot time. A warning will hopefully nudge the
> >> > > user into updating their DT to a fixed version if they can, but
> >> > > the insentive is obviously pretty small.
> >> >
> >> > s/insentive/incentive/ (Lorenzo or I can fix this up)
> >> >
> >> > > Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> >> > > Suggested-by: Roh Herring <robh+dt@kernel.org>
> >> >
> >> > s/Roh/Rob/ (similarly)
> >>
> >> Clearly not my day when it comes to proofreading commit messages.
> >> Thanks for pointing this out, and in advance for fixing it up.
> >>
> >> >
> >> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> >> >
> >> > This looks like a candidate for v5.9, since 2f96593ecc37 was merged
> >> > during the v5.9 merge window, right?
> >>
> >> Absolutely.
> >>
> >> > I wonder how many other DTs are similarly broken?  Maybe Rob's DT
> >> > checker has already looked?
> >>
> >> I've just managed to run the checker, which comes up with all kinds of
> >> goodies. Apart from the above, it also spots the following:
> >>
> >> - arch/arm64/boot/dts/mediatek/mt7622.dtsi: Has a device_type property
> >>   in its main PCIe node, but not in the child nodes. It isn't obvious
> >>   to me whether that's a violation or not (the spec doesn't say
> >>   whether the property should be set on a per-port basis). Rob?
> >
> > The rule is bridge nodes should have 'device_type = "pci"'. But what's
> > needed to fix these cases is setting device_type where we are parsing
> > ranges or dma-ranges which we're not doing on the child ndes.
> > Otherwise, I don't think it matters in this case unless you have child
> > (grandchild here) nodes for PCI devices. If you did have child nodes,
> > the address translation was already broken before this change.
>
> Fair enough.
>
> >> - arch/arm64/boot/dts/qcom/msm8996.dtsi: Only one out of the three
> >>   PCIe nodes has the device_type property, probably broken similarly
> >>   to rk3399.
> >
> > The only upstream board is DB820c, so probably not as wide an impact...
> >
> > There are also 92 (lots of duplicates due to multiple boards) more
> > cases in arch/arm/. A log is here[1].
>
> Mostly Broadcom stuff, apparently. I'll see if I can have a stab
> at it (although someone will have to test it).
>
> >
> >> I could move the workaround to drivers/pci/of.c, and have it called
> >> from the individual drivers. I don't have the HW to test those though.
> >>
> >> Thoughts?
> >
> > I think we should go with my other suggestion of looking at the node
> > name. Looks like just checking 'pcie' is enough. We can skip 'pci' as
> > I don't see any cases.
>
> I really dislike it.
>
> Once we put this node name matching in, there is no incentive for
> people to write their DT correctly at all. It also sound pretty
> fragile (what if the PCIe node is named something else?).

That would require 2 wrongs. Both missing device_type and wrong node
name. You could still warn if we matched on node name.

This is just one possible error out of thousands. It's not the
kernel's job to validate DTs (if it is, we're doing a horrible job).
We have a solution for this with schema. The question is how to get to
the point the schema checks are part of the main build flow. The
primary issue is just getting to some platforms being warning free,
and then they could opt in. There's effort around some platforms
(Rockchip is not one), but I think we have a ways to go. The other
aspect is what's the coverage with the schema. There's 2900 remaining
bindings to convert to schema. We're doing about 100-200 a cycle, so
that's what the next ~5 years looks like for me. :(

> My preference goes towards having point fixes in the affected drivers,
> clearly showing that this is addressing a firmware bug.

I didn't filter down how many drivers all the failures equates to in
terms of drivers. I guess all of Broadcom is just one. If you want to
fixup all the drivers, then I'm fine with that.

Rob
