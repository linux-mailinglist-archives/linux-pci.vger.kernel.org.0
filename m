Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4438C15006D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 03:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBCCEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Feb 2020 21:04:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37326 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgBCCEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Feb 2020 21:04:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so13294693oic.4;
        Sun, 02 Feb 2020 18:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xM8qnfr4+ufIsNOSL9bq+gr1OL50xMz2+2uYLYmITCU=;
        b=J/o6E/QOMlK+hlpHX1+A9kZx5Mgtq0cr3vW8AiUgA7z9sUaAMOtpDa2MvqOgmcauO7
         CNc5N2Q3LL34b+1MlosJPIMTMsXLc+FwsLwmXkBcfPmaHl7BY5nP9lPiIJC22qfmeAgb
         yftcvYePw3uYByhN3HbXFLkdz/blgGkM/l70CQwrZjNKqWNCgvxSGHN598p2FGOgfO6U
         1U4le9A8KPXP/BX2AvIdD8zOm/NwE9WeylwPycrmpzat+sUxVkehSOdsjw64bSNliVKS
         K4PD7sngmQPd636n0RagLVB+WKXAQN4kyBmIa0ejjLPmJDv36mzOxFkRQWEONQ1KR/s7
         5/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xM8qnfr4+ufIsNOSL9bq+gr1OL50xMz2+2uYLYmITCU=;
        b=A6SmbZXQLGhX93U/p9xV+Nwzb+vSdWk0fs3TxIlobh2jH1fvcLbMfqFITY+kaOyKNT
         vMsaEDZ4q31MVjGYR0AsCwstHEo34iXqpKfrGQitnA5wyTdPMilFMvN74bxsb/GcdF5C
         mBKX/9HmIYQzbq6Ca9R4D3BZXqr3EokKHhXvJ7OL5PF6E/xO8xQHa8ynSV3w9AwdoqhF
         HRjxzxsfsG1HbS+LrEbNP3l42vqsF+MgNqfs7uaCDqGhTMKz7pXLTyY6Bk/8G2Wex9Tn
         cU1BJq9IFACEh/eYUaFjJ8DJHT7Kiy0ODwQ+QjZ/zXu0isFCDNA7+gl4XHk5gfsG+Phx
         hgMQ==
X-Gm-Message-State: APjAAAV/+OifKJ1OmcRpezc2lD9/nBHuD2BdcJqMu8d1Jg7xvbkW/oeF
        Q7HRb8IS/xON/HmGzcdQIOMRv7Vb4FuwlWepbV4=
X-Google-Smtp-Source: APXvYqxrf/hTN8f92ICEpDM/BV4OvPCN13XsfgERb5VDKVYxN3hJh/wlOrVvZke6AXV3cwqJLY4L7PbZyU6ejTbHVrU=
X-Received: by 2002:aca:d502:: with SMTP id m2mr12724916oig.41.1580695493500;
 Sun, 02 Feb 2020 18:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20200120023326.GA149019@google.com> <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
 <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de> <CAPM=9twvggZqVu=HmXZMN70+-6hAPGdog-dGFnM7jp3RhjAB9w@mail.gmail.com>
In-Reply-To: <CAPM=9twvggZqVu=HmXZMN70+-6hAPGdog-dGFnM7jp3RhjAB9w@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 3 Feb 2020 12:04:41 +1000
Message-ID: <CAPM=9tz9dOLL=onbA-73T-hwzFYMXjSywCufqmnM7bP5dT_x0Q@mail.gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth notification"
To:     Lucas Stach <l.stach@pengutronix.de>,
        Alex Deucher <alexdeucher@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>, karolherbst@gmail.com
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

On Mon, 3 Feb 2020 at 11:56, Dave Airlie <airlied@gmail.com> wrote:
>
> On Tue, 21 Jan 2020 at 21:11, Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > On Mo, 2020-01-20 at 10:01 -0600, Alex G. wrote:
> > >
> > > On 1/19/20 8:33 PM, Bjorn Helgaas wrote:
> > > > [+cc NVMe, GPU driver folks]
> > > >
> > > > On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> > > > > I think we have a problem with link bandwidth change notifications
> > > > > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > > > >
> > > > > Here's a recent bug report where Jan reported "_tons_" of these
> > > > > notifications on an nvme device:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> > > > >
> > > > > There was similar discussion involving GPU drivers at
> > > > > https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> > > > >
> > > > > The current solution is the CONFIG_PCIE_BW config option, which
> > > > > disables the messages completely.  That option defaults to "off" (no
> > > > > messages), but even so, I think it's a little problematic.
> > > > >
> > > > > Users are not really in a position to figure out whether it's safe to
> > > > > enable.  All they can do is experiment and see whether it works with
> > > > > their current mix of devices and drivers.
> > > > >
> > > > > I don't think it's currently useful for distros because it's a
> > > > > compile-time switch, and distros cannot predict what system configs
> > > > > will be used, so I don't think they can enable it.
> > > > >
> > > > > Does anybody have proposals for making it smarter about distinguishing
> > > > > real problems from intentional power management, or maybe interfaces
> > > > > drivers could use to tell us when we should ignore bandwidth changes?
> > > >
> > > > NVMe, GPU folks, do your drivers or devices change PCIe link
> > > > speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> > > > the PCI core interprets changes like that as problems that need to be
> > > > reported.
> > > >
> > > > If drivers do change link speed/width, can you point me to where
> > > > that's done?  Would it be feasible to add some sort of PCI core
> > > > interface so the driver could say "ignore" or "pay attention to"
> > > > subsequent link changes?
> > > >
> > > > Or maybe there would even be a way to move the link change itself into
> > > > the PCI core, so the core would be aware of what's going on?
> > >
> > > Funny thing is, I was going to suggest an in-kernel API for this.
> > >    * Driver requests lower link speed 'X'
> > >    * Link management interrupt fires
> > >    * If link speed is at or above 'X' then do not report it.
> > > I think an "ignore" flag would defeat the purpose of having link
> > > bandwidth reporting in the first place. If some drivers set it, and
> > > others don't, then it would be inconsistent enough to not be useful.
> > >
> > > A second suggestion is, if there is a way to ratelimit these messages on
> > > a per-downstream port basis.
> >
> > Both AMD and Nvidia GPUs have embedded controllers, which are
> > responsible for the power management. IIRC those controllers can
> > autonomously initiate PCIe link speed changes depending on measured bus
> > load. So there is no way for the driver to signal the requested bus
> > speed to the PCIe core.
> >
> > I guess for the GPU usecase the best we can do is to have the driver
> > opt-out of the link bandwidth notifications, as the driver knows that
> > there is some autonomous entity on the endpoint mucking with the link
> > parameters.
> >
>
> Adding Alex and Ben for AMD and NVIDIA info (and Karol).
>
> Dave.
