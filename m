Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07572341DAE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCSNF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 09:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhCSNFa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 09:05:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA4D364EA4;
        Fri, 19 Mar 2021 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616159129;
        bh=5HnkaYDqgYWmtnvl2eRAc8rKWx84CNdG+L4ZxmeQ2gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4+aVnv65nHSqNA8tWqWlZGoDKorVim2cEhAI+FwAMKW6T6iSGhvxEa1TGo8AWcya
         80Q1OWeZMjKyLV9DZl4e2dsRmOBg3lHGnIOU6R9GdTgUseqRqPHgQzZ+EpumUAQyM4
         TcazElkJuMZz6E1McAsE2k7vuLazr7Ng96/lPiSLATwVq8u1fvUGc/lb/eiUTUXLmR
         jO1LBl3V8167RDBf5W3V1yVLFz6BxSTcN7i1Mr2wQuAYTnkqw99buburulovAyJBe2
         oRMmfwHC8+tfVvZbUwCmxT47iioA3DoGeMlJzOTZM3sLeWM9KXT/M4W0y0618M3xOa
         OtH34JWFEs2GQ==
Date:   Fri, 19 Mar 2021 15:05:25 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFShlUgePr1BNnRI@unreal>
References: <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal>
 <20210318174344.yslqpfyct6ziwypd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318174344.yslqpfyct6ziwypd@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 11:13:44PM +0530, Amey Narkhede wrote:
> On 21/03/18 07:35PM, Leon Romanovsky wrote:
> > On Thu, Mar 18, 2021 at 10:31:43PM +0530, Amey Narkhede wrote:
> > > On 21/03/18 04:57PM, Leon Romanovsky wrote:
> > > > On Thu, Mar 18, 2021 at 07:52:52PM +0530, Amey Narkhede wrote:
> > > > > On 21/03/18 11:09AM, Leon Romanovsky wrote:
> > > > > > On Wed, Mar 17, 2021 at 11:31:40AM -0600, Alex Williamson wrote:
> > > > > > > On Wed, 17 Mar 2021 15:58:40 +0200
> > > > > > > Leon Romanovsky <leon@kernel.org> wrote:
> >
> > <...>
> >
> > > > > > I'm lost here, does vfio-pci use sysfs interface or internal to the kernel API?
> > > > > >
> > > > > > If it is latter then we don't really need sysfs, if not, we still need
> > > > > > some sort of DB to create second policy, because "supported != working".
> > > > > > What am I missing?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > Can you explain bit more about why supported != working?
> > > >
> > > > It is written in the commit message of this patch.
> > > > https://lore.kernel.org/lkml/20210312173452.3855-1-ameynarkhede03@gmail.com/
> > > > "This feature aims to allow greater control of a device for use cases
> > > > as device assignment, where specific device or platform issues may
> > > > interact poorly with a given reset method, and for which device specific
> > > > quirks have not been developed."
> > > >
> > > > You wrote it and also repeated it a couple of times during the discussion.
> > > >
> > > > If device can understand that specific reset doesn't work, it won't
> > > > perform it in first place.
> > > >
> > > > Thanks
> > > Is it possible for device to understand whether or not specific reset
> > > will work or not prior to performing reset and after it indicates
> > > support for that reset method? Maybe theres problem with that particular
> > > piece of hardware in that machine.
> > > How can database be maintained if a particular machines have
> > > particular piece of faulty HW?
> >
> > It was exactly the reason why I think that VM usecase presented by
> > you is not viable.
> >
> Well I didn't present it as new use case. I just gave existing
> usecase based on existing reset attribute. Nothing new here.
> Nothing really changes wrt that use case.

Of course it is new, please see Alex's response, he said that vfio uses
in-kernel API and not sysfs.

> > > If for some reason reset doesn't work it will just give -ENOTTY.
> > > This isn't any different from existing behavior.Actually it informs user
> > > that the reset method didn't reset the device and user can use different
> > > reset method instead of implicitly using different reset method.
> > > If user doesn't explicitly set preferred reset method then
> > > we go ahead with existing implicit fall through behavior which will try all
> > > available reset methods until any one of them works.
> > > If you have device that doesn't support reset at all then you have
> > > option to completely disable it unlike existing reset attribute where
> > > you cannot disable reset. So it gives greater control where you can
> > > disable the reset altogether when quirk isn't developed yet.
> >
> > I explicitly asked to hear usecase, right now, I got an explanation from
> > Alex for policy decision (which doesn't need sysfs) and from you about
> > overcoming HW bugs with expectation that user will be guru of PCI reset
> > methods.
> >
> > >
> > > We can't expect to develop quirk for every device in existence.
> >
> > It doesn't give us an excuse do not try.
> >
> > > For example on my laptop elantech touchpad still doesn't work in 2021
> > > with vanilla kernel, arch linux applies the patch which was reverted in
> > > mainline kernel for some reason.
> >
> > I see it as a good example of cheap solution. Vendor won't fix your
> > touchpad because distros provide workaround. The same will be with reset.
> >
> > Thanks
> >
> As mentioned earlier not all vendors care about Linux and not
> all of the population can afford to buy new HW just to run Linux.

Sorry, but you are not consistent. At the beginning, we talked about new HW
that has bugs but don't have quirks yet. Here we are talking about old HW
that still doesn't have quirks.

Thanks

> 
> Thanks,
> Amey
