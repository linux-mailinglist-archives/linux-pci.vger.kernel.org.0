Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6168150067
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 02:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBCB4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Feb 2020 20:56:33 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45770 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBCB4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Feb 2020 20:56:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so13229851oic.12;
        Sun, 02 Feb 2020 17:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2BAnnFqBl0ny/UG9avlBqD34L7kMVfx2OwCIBjO+No=;
        b=FoJy5s+Vjtqt/WYVTotJ9W30/xIwYF5UOfD1EF1k00/rJrpmxqRc1Bdgs9qIIq96io
         EEsFWCmUVy3Mh3bWYC2PJsZ39kvh27XWIeCYkoeFXUJNO1Zojs9ymuhSJSURGu1k4Mv7
         GsJOoQtAM1nDrGuNGr4Bjq3VA/WK5kPoBUCFBsaMXAVau9lwZ8mOW4YrOx1YQ+jeoV85
         L9gx0hMd0CZpKuCq/GXlKilrgn10beOVARaqJXqscJwMdVDwQOjwnvTy6I5KYBRX+2BH
         MKxlIrk2vZqgW8sDDB0FHxKY+IuQa76EoBlAhp8/AZ2zjDxfDb848Vyx/O+WTwEZMvv5
         WBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2BAnnFqBl0ny/UG9avlBqD34L7kMVfx2OwCIBjO+No=;
        b=Q1nepnNUixWiTeLDtwVJn/0HEYo1uXCOZKss1Fo2Ib+hBVU2lsCdk4sMbWmwThAPJY
         NrnKj3npMZyEUjWr/cT6vR7YwbBVX2JyNG/wYxyHZ9mOmDFzmJ9ZNlEPyS0ZrMFZS3H6
         uWgQnzvdLqrOrNANLEbxJ2GKFmKeYqdqPUKf0Eiuh0Dbm3m25ukXtw5r9sfnuyxojbRZ
         8kJNZvcabgorduny7IcQEUd72AKGHNMZppqkPMgU94jqiYILfvCX4mbtpQZP05QPv0+m
         Gf9I1q86S9Kr++tLld7r4WlXmS+MCJaKO/aiVqEAXIBDqtIaDP0p8b7sXn51x3nf5/vx
         4FfA==
X-Gm-Message-State: APjAAAXJ8CYglsD6ecUZuwnW+J2oVAEOnfktXoZNDe8fJZKwQVt/tyqI
        Uu4M64ykoCXFc1so1gXkQQjTVqYOxkezkMgLIfz8Yw==
X-Google-Smtp-Source: APXvYqzYVyWHsYbCf5iLnzCcMJtqYB3/GbQNuRQPHhRjiyDYYPVMb0DwR8G40Oj0GaXrMl+kxGk3cEi4DfsSo7xVb/4=
X-Received: by 2002:aca:d502:: with SMTP id m2mr12708577oig.41.1580694992545;
 Sun, 02 Feb 2020 17:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20200120023326.GA149019@google.com> <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
 <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
In-Reply-To: <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 3 Feb 2020 11:56:20 +1000
Message-ID: <CAPM=9twvggZqVu=HmXZMN70+-6hAPGdog-dGFnM7jp3RhjAB9w@mail.gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth notification"
To:     Lucas Stach <l.stach@pengutronix.de>,
        Alex Deucher <alexdeucher@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>
Cc:     "Alex G." <mr.nuke.me@gmail.com>,
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

On Tue, 21 Jan 2020 at 21:11, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> On Mo, 2020-01-20 at 10:01 -0600, Alex G. wrote:
> >
> > On 1/19/20 8:33 PM, Bjorn Helgaas wrote:
> > > [+cc NVMe, GPU driver folks]
> > >
> > > On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> > > > I think we have a problem with link bandwidth change notifications
> > > > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > > >
> > > > Here's a recent bug report where Jan reported "_tons_" of these
> > > > notifications on an nvme device:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> > > >
> > > > There was similar discussion involving GPU drivers at
> > > > https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> > > >
> > > > The current solution is the CONFIG_PCIE_BW config option, which
> > > > disables the messages completely.  That option defaults to "off" (no
> > > > messages), but even so, I think it's a little problematic.
> > > >
> > > > Users are not really in a position to figure out whether it's safe to
> > > > enable.  All they can do is experiment and see whether it works with
> > > > their current mix of devices and drivers.
> > > >
> > > > I don't think it's currently useful for distros because it's a
> > > > compile-time switch, and distros cannot predict what system configs
> > > > will be used, so I don't think they can enable it.
> > > >
> > > > Does anybody have proposals for making it smarter about distinguishing
> > > > real problems from intentional power management, or maybe interfaces
> > > > drivers could use to tell us when we should ignore bandwidth changes?
> > >
> > > NVMe, GPU folks, do your drivers or devices change PCIe link
> > > speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> > > the PCI core interprets changes like that as problems that need to be
> > > reported.
> > >
> > > If drivers do change link speed/width, can you point me to where
> > > that's done?  Would it be feasible to add some sort of PCI core
> > > interface so the driver could say "ignore" or "pay attention to"
> > > subsequent link changes?
> > >
> > > Or maybe there would even be a way to move the link change itself into
> > > the PCI core, so the core would be aware of what's going on?
> >
> > Funny thing is, I was going to suggest an in-kernel API for this.
> >    * Driver requests lower link speed 'X'
> >    * Link management interrupt fires
> >    * If link speed is at or above 'X' then do not report it.
> > I think an "ignore" flag would defeat the purpose of having link
> > bandwidth reporting in the first place. If some drivers set it, and
> > others don't, then it would be inconsistent enough to not be useful.
> >
> > A second suggestion is, if there is a way to ratelimit these messages on
> > a per-downstream port basis.
>
> Both AMD and Nvidia GPUs have embedded controllers, which are
> responsible for the power management. IIRC those controllers can
> autonomously initiate PCIe link speed changes depending on measured bus
> load. So there is no way for the driver to signal the requested bus
> speed to the PCIe core.
>
> I guess for the GPU usecase the best we can do is to have the driver
> opt-out of the link bandwidth notifications, as the driver knows that
> there is some autonomous entity on the endpoint mucking with the link
> parameters.
>

Adding Alex and Ben for AMD and NVIDIA info

Dave.
