Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6D1511AE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 22:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCVQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 16:16:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCVQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2020 16:16:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so7967702wrs.10;
        Mon, 03 Feb 2020 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opfjLSdigP2ndhX8c80fuY703duf4BrjjlfxGpOQ3AY=;
        b=D/OEeS7noMUbtuzIB1adezYd90/zXT1hrGqPyHh3WcqQ6EuTQvmDmlhC1pCF4y015R
         1nuYlxbkyU0WBYF4LAHAEpIVRQe1jEMy+uNAKheCaL81oJ7Sln/1nUOgpDkA0lGcG3Tl
         Yp59eOls7vlTVLxgmn2RWDaz0ACt5CN1YeldHfXepPInMiBCGa3juBN+4TUtOoHDAgsS
         P1bokBxkOkmUgqH4pA2uCNjPVSeI1wyY5DRnVTWLTy/hNQQCMg/k3jULZ4CRIhuoQcVq
         w56cUUmQ+Nzlh80WN4tNZAAEKCtDLdbkQkM/bVbZQkNTwsHwPceGMkimGMmVN7Q1Ob9r
         p5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opfjLSdigP2ndhX8c80fuY703duf4BrjjlfxGpOQ3AY=;
        b=M+J/C+YFuKfKvU5GehQ1SDNSW7rQUtqr+CbGyixEt/zEulAhXscvX6Lx1IflNr1Tf4
         dkG65mVPIJX0C6xlEH2Zg3GXPBfzFy2W36dnMTGK7t+5DTfrWNw2IcGAqXMjwVY4zEwi
         0nmSh1GGrNwRtaCEJ+RW7HviTut/HnuaFpDc8aooL7U7en21CMeQcGInxyL93zBdtatq
         GUSeFWZDolm3JA+YGxIHPcEriZawPFmNWWFX5bSZCIqNncAcfHmv/ukB9nWJK1+GCMMd
         fyA9wPwSPzj+vCqQhxhGVQs87IOXXSCVbZCT6qUOyK6d37faXuk2ViQI8V+gq/logYe4
         AeMQ==
X-Gm-Message-State: APjAAAVHeRT9BB2OCeVTFDG9tVahIeVfP6a1bHR1lGE6cu1nz2C4+J2r
        14mkkb0WVGWWOLhHgTNTBX4fXZMnfE3sQa4rSHk=
X-Google-Smtp-Source: APXvYqza7SB/usP7VTMeO50Hq+uuEl5hp/nTcbV7KytSXsAvb5p+jad7mlxne2SnQaZSTvK1cll8vmw3G8NGYktsoUE=
X-Received: by 2002:adf:a50b:: with SMTP id i11mr16396742wrb.362.1580764607074;
 Mon, 03 Feb 2020 13:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20200120023326.GA149019@google.com> <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
 <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
 <CAPM=9twvggZqVu=HmXZMN70+-6hAPGdog-dGFnM7jp3RhjAB9w@mail.gmail.com> <CAPM=9tz9dOLL=onbA-73T-hwzFYMXjSywCufqmnM7bP5dT_x0Q@mail.gmail.com>
In-Reply-To: <CAPM=9tz9dOLL=onbA-73T-hwzFYMXjSywCufqmnM7bP5dT_x0Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 3 Feb 2020 16:16:36 -0500
Message-ID: <CADnq5_PRQJmG_NYHmqWhv2R1utaNf0LcTVgFA7LMeYr75fy55w@mail.gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth notification"
To:     Dave Airlie <airlied@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Ben Skeggs <skeggsb@gmail.com>,
        Karol Herbst <karolherbst@gmail.com>,
        "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 2, 2020 at 9:04 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Mon, 3 Feb 2020 at 11:56, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Tue, 21 Jan 2020 at 21:11, Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > On Mo, 2020-01-20 at 10:01 -0600, Alex G. wrote:
> > > >
> > > > On 1/19/20 8:33 PM, Bjorn Helgaas wrote:
> > > > > [+cc NVMe, GPU driver folks]
> > > > >
> > > > > On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> > > > > > I think we have a problem with link bandwidth change notifications
> > > > > > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > > > > >
> > > > > > Here's a recent bug report where Jan reported "_tons_" of these
> > > > > > notifications on an nvme device:
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> > > > > >
> > > > > > There was similar discussion involving GPU drivers at
> > > > > > https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> > > > > >
> > > > > > The current solution is the CONFIG_PCIE_BW config option, which
> > > > > > disables the messages completely.  That option defaults to "off" (no
> > > > > > messages), but even so, I think it's a little problematic.
> > > > > >
> > > > > > Users are not really in a position to figure out whether it's safe to
> > > > > > enable.  All they can do is experiment and see whether it works with
> > > > > > their current mix of devices and drivers.
> > > > > >
> > > > > > I don't think it's currently useful for distros because it's a
> > > > > > compile-time switch, and distros cannot predict what system configs
> > > > > > will be used, so I don't think they can enable it.
> > > > > >
> > > > > > Does anybody have proposals for making it smarter about distinguishing
> > > > > > real problems from intentional power management, or maybe interfaces
> > > > > > drivers could use to tell us when we should ignore bandwidth changes?
> > > > >
> > > > > NVMe, GPU folks, do your drivers or devices change PCIe link
> > > > > speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> > > > > the PCI core interprets changes like that as problems that need to be
> > > > > reported.
> > > > >
> > > > > If drivers do change link speed/width, can you point me to where
> > > > > that's done?  Would it be feasible to add some sort of PCI core
> > > > > interface so the driver could say "ignore" or "pay attention to"
> > > > > subsequent link changes?
> > > > >
> > > > > Or maybe there would even be a way to move the link change itself into
> > > > > the PCI core, so the core would be aware of what's going on?
> > > >
> > > > Funny thing is, I was going to suggest an in-kernel API for this.
> > > >    * Driver requests lower link speed 'X'
> > > >    * Link management interrupt fires
> > > >    * If link speed is at or above 'X' then do not report it.
> > > > I think an "ignore" flag would defeat the purpose of having link
> > > > bandwidth reporting in the first place. If some drivers set it, and
> > > > others don't, then it would be inconsistent enough to not be useful.
> > > >
> > > > A second suggestion is, if there is a way to ratelimit these messages on
> > > > a per-downstream port basis.
> > >
> > > Both AMD and Nvidia GPUs have embedded controllers, which are
> > > responsible for the power management. IIRC those controllers can
> > > autonomously initiate PCIe link speed changes depending on measured bus
> > > load. So there is no way for the driver to signal the requested bus
> > > speed to the PCIe core.
> > >
> > > I guess for the GPU usecase the best we can do is to have the driver
> > > opt-out of the link bandwidth notifications, as the driver knows that
> > > there is some autonomous entity on the endpoint mucking with the link
> > > parameters.
> > >
> >
> > Adding Alex and Ben for AMD and NVIDIA info (and Karol).

AMD has had a micro-controller on the GPU handling pcie link speeds
and widths dynamically (in addition to GPU clocks and voltages) for
about 12 years or so at this point to save power when the GPU is idle
and improve performance when it's required.  The micro-controller
changes the link parameters dynamically based on load independent of
the driver.  The driver can tweak the heuristics, or even disable the
dynamic changes, but by default it's enabled when the driver loads.
The ucode for this micro-controller is loaded by the driver so you'll
see fixed clocks and widths prior to the driver loading.  We'd need
some sort of opt out I suppose for periods when the driver has enabled
dynamic pcie power management in the micro-controller.

Alex
