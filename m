Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560E32D71F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 16:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhCDPvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 10:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhCDPvW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 10:51:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B05A560230;
        Thu,  4 Mar 2021 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614873042;
        bh=wQ0PUkMAPriKUZRWfHBPQn5zZ1IErGigM15osFPlP1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N7ZcSdIU426bAspbzcApfAK315ZCRbEFOZJKDaN1mloCttlEqwCtgmjvuZuCw2csL
         Gy4JG7U/Wgt1nGwarXVvx3oGy9FGlGbzysqn3Az35wDnfAki7z64oQmJYL37j7AnJG
         hDfOhAH7ntoYLJKXEwQH9iDspIUU817Eta4vXgmI0MhvbpubN9WebW12CYm1WrsJk5
         Ul4qoosx1DtLPcuWroArme7eP//qQ7IJVtAmUM4PEpy8c2Tx5zf8Twl8H73rfyERPG
         OhkoIaPpVib6oLaOkFw42x59azFqxS7E4i9y2GnI7tjvCyqOgB8Ah08KDRjHmranCS
         kQygnW7w6XezA==
Date:   Thu, 4 Mar 2021 09:50:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
Subject: Re: [PATCH] pci-driver: Add driver load messages
Message-ID: <20210304155040.GA844982@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a584957-24d5-54c8-07f8-36fd7d2e9fce@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 04, 2021 at 09:42:44AM -0500, Prarit Bhargava wrote:
> 
> 
> On 2/18/21 2:06 PM, Bjorn Helgaas wrote:
> > On Thu, Feb 18, 2021 at 01:36:35PM -0500, Prarit Bhargava wrote:
> >> On 1/26/21 10:12 AM, Bjorn Helgaas wrote:
> >>> On Tue, Jan 26, 2021 at 09:05:23AM -0500, Prarit Bhargava wrote:
> >>>> On 1/26/21 8:53 AM, Leon Romanovsky wrote:
> >>>>> On Tue, Jan 26, 2021 at 08:42:12AM -0500, Prarit Bhargava wrote:
> >>>>>> On 1/26/21 8:14 AM, Leon Romanovsky wrote:
> >>>>>>> On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
> >>>>>>>>   Leon Romanovsky <leon@kernel.org> wrote:
> >>>>>>>>> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
> >>>>>>>>>> There are two situations where driver load messages are helpful.
> >>>>>>>>>>
> >>>>>>>>>> 1) Some drivers silently load on devices and debugging driver or system
> >>>>>>>>>> failures in these cases is difficult.  While some drivers (networking
> >>>>>>>>>> for example) may not completely initialize when the PCI driver probe() function
> >>>>>>>>>> has returned, it is still useful to have some idea of driver completion.
> >>>>>>>>>
> >>>>>>>>> Sorry, probably it is me, but I don't understand this use case.
> >>>>>>>>> Are you adding global to whole kernel command line boot argument to debug
> >>>>>>>>> what and when?
> >>>>>>>>>
> >>>>>>>>> During boot:
> >>>>>>>>> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
> >>>>>>>>> If device fails, you should get an error from that device (fix the
> >>>>>>>>> device to return an error), or something immediately won't work and
> >>>>>>>>> you won't see it in sysfs.
> >>>>>>>>
> >>>>>>>> What if there is a panic during boot?  There's no way to get to sysfs.
> >>>>>>>> That's the case where this is helpful.
> >>>>>>>
> >>>>>>> How? If you have kernel panic, it means you have much more worse problem
> >>>>>>> than not-supported device. If kernel panic was caused by the driver, you
> >>>>>>> will see call trace related to it. If kernel panic was caused by
> >>>>>>> something else, supported/not supported won't help here.
> >>>>>>
> >>>>>> I still have no idea *WHICH* device it was that the panic occurred on.
> >>>>>
> >>>>> The kernel panic is printed from the driver. There is one driver loaded
> >>>>> for all same PCI devices which are probed without relation to their
> >>>>> number.>
> >>>>> If you have host with ten same cards, you will see one driver and this
> >>>>> is where the problem and not in supported/not-supported device.
> >>>>
> >>>> That's true, but you can also have different cards loading the same driver.
> >>>> See, for example, any PCI_IDs list in a driver.
> >>>>
> >>>> For example,
> >>>>
> >>>> 10:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
> >>>> 20:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3108 [Invader] (rev 02)
> >>>>
> >>>> Both load the megaraid driver and have different profiles within the
> >>>> driver.  I have no idea which one actually panicked until removing
> >>>> one card.
> >>>>
> >>>> It's MUCH worse when debugging new hardware and getting a panic
> >>>> from, for example, the uncore code which binds to a PCI mapped
> >>>> device.  One device might work and the next one doesn't.  And
> >>>> then you can multiply that by seeing *many* panics at once and
> >>>> trying to determine if the problem was on one specific socket,
> >>>> die, or core.
> >>>
> >>> Would a dev_panic() interface that identified the device and
> >>> driver help with this?
> >>
> >> ^^ the more I look at this problem, the more a dev_panic() that
> >> would output a device specific message at panic time is what I
> >> really need.
> 
> I went down this road a bit and had a realization.  The issue isn't
> with printing something at panic time, but the *data* that is
> output.  Each PCI device is associated with a struct device.  That
> device struct's name is output for dev_dbg(), etc., commands.  The
> PCI subsystem sets the device struct name at drivers/pci/probe.c:
> 1799
> 
> 	        dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
>                      dev->bus->number, PCI_SLOT(dev->devfn),
>                      PCI_FUNC(dev->devfn));
> 
> My problem really is that the above information is insufficient when
> I (or a user) need to debug a system.  The complexities of debugging
> multiple broken driver loads would be much easier if I didn't have
> to constantly add this output manually :).

This *should* already be in the dmesg log:

  pci 0000:00:00.0: [8086:5910] type 00 class 0x060000
  pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  pci 0000:00:02.0: [8086:591b] type 00 class 0x030000

So if you had a dev_panic(), that message would include the
bus/device/function number, and that would be enough to find the
vendor/device ID from when the device was first enumerated.

Or are you saying you can't get the part of the dmesg log that
contains those vendor/device IDs?

> Would you be okay with adding a *debug* parameter to expand the
> device name to include the vendor & device ID pair?  FWIW, I'm
> somewhat against yet-another-kernel-option but that's really the
> information I need.  I could then add dev_dbg() statements in the
> local_pci_probe() function.
