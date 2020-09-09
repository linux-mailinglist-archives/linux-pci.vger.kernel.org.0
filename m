Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4382263680
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIITOS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 15:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIITOR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 15:14:17 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD9421D43
        for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2020 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599678856;
        bh=TePhmGky6jkSs6zzIefPjKAq0/m8+cyB4RTLI2u/9/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFkuy/k0LMkKjGOJCSwyNJF/fglZpvjoD/5GYIa1FvD/DNSwOFRSQ+LAvCAi+L2Rm
         xW4s4omdLaHauWXmjgH1tYrmmNhl3CvB20WCg7MhoYNuslmhtwLwZBDkh79zWXUAr1
         uj6i+FFdC67E9xCtd3S/zrNV8gbOIKbg/tNMkD50=
Received: by mail-oi1-f177.google.com with SMTP id c13so3473442oiy.6
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2020 12:14:16 -0700 (PDT)
X-Gm-Message-State: AOAM532FMHFgvnIX89Co7Tve4FgdWRP7AcNwf+5ixxNsNOL/SYZABEQc
        CrT5bLJZOi2spALvWfJi9KxeTiV7otvpMnvPVw==
X-Google-Smtp-Source: ABdhPJwV+m7G+wRLnYK8h+UogMc3R8itkZwsHel5jNtZyKuZkGJC3We6KUGLIt0ARo8GgSndj7E3kOYGEByjo00f3+M=
X-Received: by 2002:aca:1711:: with SMTP id j17mr1646279oii.152.1599678855483;
 Wed, 09 Sep 2020 12:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200908100231.GA22909@e121166-lin.cambridge.arm.com> <20200908220843.GA643026@bjorn-Precision-5520>
In-Reply-To: <20200908220843.GA643026@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Sep 2020 13:14:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK3OKVx_1OXz_xbspW8JJQpxh5j_CcYrOUo=DmETu6Ftg@mail.gmail.com>
Message-ID: <CAL_JsqK3OKVx_1OXz_xbspW8JJQpxh5j_CcYrOUo=DmETu6Ftg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Fix bus checks in rockchip_pcie_valid_device()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 8, 2020 at 4:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 08, 2020 at 11:02:31AM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Sep 04, 2020 at 03:09:04PM +0100, Lorenzo Pieralisi wrote:
> > > The root bus checks rework in:
> > >
> > > commit d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> > >
> > > caused a regression whereby in rockchip_pcie_valid_device() if
> > > the bus parameter is the root bus and the dev value == 0 the
> > > function should return 1 (ie true) without checking if the
> > > bus->parent pointer is a root bus because that triggers a NULL
> > > pointer dereference.
> > >
> > > Fix this by streamlining the root bus detection.
> > >
> > > Fixes: d84c572de1a3 ("PCI: rockchip: Use pci_is_root_bus() to check if bus is root bus")
> > > Reported-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > > ---
> > >  drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > Hi Bjorn,
> >
> > this is a fix for a patch we merged in the last merge window, can
> > we send it for one of the upcoming -rcX please ?
>
> Sure.  I added Samuel's tested-by and put this on for-linus for v5.9.
>
> But is there any chance we can figure out a way to make all these
> "valid_device" functions look more similar?  They're a real potpourri
> of styles:

I'm definitely trying to head in that direction, but trying to make
the all the copy-n-paste the same is an exercise in frustration.
Really, we need to factor out the copy-n-paste.

I expect now (in the DWC cleanup series) that we can support different
ops for root and child buses, we can refactor these a bit. For
Rockchip in particular, it looks like it is actually a Cadence
controller, so I'd like to get the Cadence driver working on Rockchip
and we can remove this one. Interestingly, the Cadence driver has no
such 'Do not read more than one device on the bus directly attached to
RC's downstream side.' check, so I suspect that's not really needed.
Though it could also be the same issue as the Neoverse N1 quirk. I
need to get a different Rockchip board because it seems PCIe doesn't
work on the Rock960c I have.

>   - Most return bool, a couple return int.
>
>   - Some take PCI_SLOT(devfn); others take devfn.
>
>   - Some reject "devfn > 0", others reject only "dev > 0".  Maybe this
>     is a real difference, I dunno.

If not just poor naming, it's just limited testing I'd guess. Or the
root bridge is always a single function? I imagine lots of these Arm
drivers are never tested with more than a handful of single devices
(most h/w is a single soldered device or M2 slot). There were numerous
cases I found where only 0 for root bus number would have worked.
Those should be fixed now.

Given filtering out root bus 'dev > 0' is fairly common, I'm wondering
if it should just be a bridge feature/quirk flag that the PCI core
could handle.

>   - A few do unusual things that *look* like pci_is_root_bus():
>       bus->primary == to_pci_host_bridge(bus->bridge)->busnr
>       bus->number == cfg->busr.start
>       bus->number == pcie->root_bus_nr

I think I've cleaned-up most of these. At least how we check for root
bus is consistent.

The checks with bus->primary are the oddballs which I don't really understand.

>   - Some check for a negated condition first ("!pci_is_root_bus()"),
>     i.e., I always prefer something like this:
>
>       if (pci_is_root_bus(bus))
>         return devfn == 0;
>
>       return pcie_link_up();
>
>     over this (from nwl_pcie_valid_device()):
>
>       if (!pci_is_root_bus(bus)) {
>         if (!pcie_link_up())
>           return false;
>       } else if (devfn > 0)
>         return false;
>
>       return true;
>
>   - About half check whether the link is up.

I think we agree that's a pointless, racy check. Happy to go rip those
out. Of course, the testing probably won't happen until a -rc1. :(

Rob
