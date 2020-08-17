Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16245246F84
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbgHQRsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 13:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388746AbgHQQNM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:13:12 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72C820882;
        Mon, 17 Aug 2020 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680791;
        bh=gOa0eYxDEsJl2GQzrDLlhSJ5bJ/ZSXUtDonvSlh0ISI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vLRATeCcDCX/WCszaMIH4H6QE5Q8qaxo+6lOPhJY3rU/qC3/KnPHOgpGDtINee7Gq
         VcWIayKF3Q5vcKl+04xcwMH7/dbSBKTxAP7wJHZxqdCIaZTaY9H7oqkp8AkQMziwc8
         C466cFsSL7D9DSNpN4oisiuWqbgpp5MlAwUUJYj4=
Received: by mail-ot1-f43.google.com with SMTP id h22so13818866otq.11;
        Mon, 17 Aug 2020 09:13:10 -0700 (PDT)
X-Gm-Message-State: AOAM531NhY7Wt0pAoz/CGBobj3yGVukH2RMWCgIJe/MsLh2Zs4iCYRgU
        XEGus4Y64M0JWEZhp8O1r0TWjGYLEjztDfWyJw==
X-Google-Smtp-Source: ABdhPJyXcxsLxb+WyZgDqUvX+ZXB5O5RvpOgmleI0+UY8O6F4IJdy3paAveojUJFPRMuv9DQhsNQTGig0iW3qRkFcQI=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr11916864otp.192.1597680790121;
 Mon, 17 Aug 2020 09:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200815125112.462652-2-maz@kernel.org> <20200815232228.GA1325245@bjorn-Precision-5520>
 <87pn7qnabq.wl-maz@kernel.org>
In-Reply-To: <87pn7qnabq.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Aug 2020 10:12:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
Message-ID: <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
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

On Sun, Aug 16, 2020 at 4:40 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 16 Aug 2020 00:22:28 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sat, Aug 15, 2020 at 01:51:11PM +0100, Marc Zyngier wrote:
> > > Recent changes to the DT PCI bus parsing made it mandatory for
> > > device tree nodes describing a PCI controller to have the
> > > 'device_type = "pci"' property for the node to be matched.
> > >
> > > Although this follows the letter of the specification, it
> > > breaks existing device-trees that have been working fine
> > > for years.  Rockchip rk3399-based systems are a prime example
> > > of such collateral damage, and have stopped discovering their
> > > PCI bus.
> > >
> > > In order to paper over the blunder, let's add a workaround
> > > to the pcie-rockchip driver, adding the missing property when
> > > none is found at boot time. A warning will hopefully nudge the
> > > user into updating their DT to a fixed version if they can, but
> > > the insentive is obviously pretty small.
> >
> > s/insentive/incentive/ (Lorenzo or I can fix this up)
> >
> > > Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> > > Suggested-by: Roh Herring <robh+dt@kernel.org>
> >
> > s/Roh/Rob/ (similarly)
>
> Clearly not my day when it comes to proofreading commit messages.
> Thanks for pointing this out, and in advance for fixing it up.
>
> >
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> >
> > This looks like a candidate for v5.9, since 2f96593ecc37 was merged
> > during the v5.9 merge window, right?
>
> Absolutely.
>
> > I wonder how many other DTs are similarly broken?  Maybe Rob's DT
> > checker has already looked?
>
> I've just managed to run the checker, which comes up with all kinds of
> goodies. Apart from the above, it also spots the following:
>
> - arch/arm64/boot/dts/mediatek/mt7622.dtsi: Has a device_type property
>   in its main PCIe node, but not in the child nodes. It isn't obvious
>   to me whether that's a violation or not (the spec doesn't say
>   whether the property should be set on a per-port basis). Rob?

The rule is bridge nodes should have 'device_type = "pci"'. But what's
needed to fix these cases is setting device_type where we are parsing
ranges or dma-ranges which we're not doing on the child ndes.
Otherwise, I don't think it matters in this case unless you have child
(grandchild here) nodes for PCI devices. If you did have child nodes,
the address translation was already broken before this change.

> - arch/arm64/boot/dts/qcom/msm8996.dtsi: Only one out of the three
>   PCIe nodes has the device_type property, probably broken similarly
>   to rk3399.

The only upstream board is DB820c, so probably not as wide an impact...

There are also 92 (lots of duplicates due to multiple boards) more
cases in arch/arm/. A log is here[1].

> I could move the workaround to drivers/pci/of.c, and have it called
> from the individual drivers. I don't have the HW to test those though.
>
> Thoughts?

I think we should go with my other suggestion of looking at the node
name. Looks like just checking 'pcie' is enough. We can skip 'pci' as
I don't see any cases.

Rob

[1] https://gitlab.com/robherring/linux-dt-bindings/-/jobs/688752562
