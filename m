Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF21431EF5F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 20:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBRTL0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 14:11:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhBRTGq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 14:06:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 253C464EBA;
        Thu, 18 Feb 2021 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613675165;
        bh=k3+7fc8CdUnNEQLHcaMBqyGBPAU9umGK5dQB98gWQWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fsAZ0/ka91kSsdtS0ZDxTXiUEGQhRiMwBROYkLFyulvaTiQLTo1NNjUAyFRorLO2z
         nE+bRIs7puA6WECIVoU0zycnJT9BGz4GIS5g1jE+j6bvS+W8icgR1ETJJy5ibHqkwX
         nxLNyaljXhFKwUnCDJg5QcG5MApUXkigxgY9sVlxM9mSgUwNSAb42rnfFb4qRFS8Sw
         a7xCbUmqoZ/S1V6Y43N7ivbSgqwgiPzzhMLlvAHaS1CdoqbTmQjl5A1D8EdKvuQFEZ
         G4egKcmgcn2hOJq9Gv/2q1m7JhzlEHHOWSG0gAOC8fgtG0QibQasrnOpRE+MS28rKb
         vEDiNimegEYuw==
Date:   Thu, 18 Feb 2021 13:06:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
Subject: Re: [PATCH] pci-driver: Add driver load messages
Message-ID: <20210218190603.GA993998@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea3517c-8f2f-9a18-81d2-ab6468354040@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 18, 2021 at 01:36:35PM -0500, Prarit Bhargava wrote:
> On 1/26/21 10:12 AM, Bjorn Helgaas wrote:
> > On Tue, Jan 26, 2021 at 09:05:23AM -0500, Prarit Bhargava wrote:
> >> On 1/26/21 8:53 AM, Leon Romanovsky wrote:
> >>> On Tue, Jan 26, 2021 at 08:42:12AM -0500, Prarit Bhargava wrote:
> >>>> On 1/26/21 8:14 AM, Leon Romanovsky wrote:
> >>>>> On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
> >>>>>>   Leon Romanovsky <leon@kernel.org> wrote:
> >>>>>>> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
> >>>>>>>> There are two situations where driver load messages are helpful.
> >>>>>>>>
> >>>>>>>> 1) Some drivers silently load on devices and debugging driver or system
> >>>>>>>> failures in these cases is difficult.  While some drivers (networking
> >>>>>>>> for example) may not completely initialize when the PCI driver probe() function
> >>>>>>>> has returned, it is still useful to have some idea of driver completion.
> >>>>>>>
> >>>>>>> Sorry, probably it is me, but I don't understand this use case.
> >>>>>>> Are you adding global to whole kernel command line boot argument to debug
> >>>>>>> what and when?
> >>>>>>>
> >>>>>>> During boot:
> >>>>>>> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
> >>>>>>> If device fails, you should get an error from that device (fix the
> >>>>>>> device to return an error), or something immediately won't work and
> >>>>>>> you won't see it in sysfs.
> >>>>>>
> >>>>>> What if there is a panic during boot?  There's no way to get to sysfs.
> >>>>>> That's the case where this is helpful.
> >>>>>
> >>>>> How? If you have kernel panic, it means you have much more worse problem
> >>>>> than not-supported device. If kernel panic was caused by the driver, you
> >>>>> will see call trace related to it. If kernel panic was caused by
> >>>>> something else, supported/not supported won't help here.
> >>>>
> >>>> I still have no idea *WHICH* device it was that the panic occurred on.
> >>>
> >>> The kernel panic is printed from the driver. There is one driver loaded
> >>> for all same PCI devices which are probed without relation to their
> >>> number.>
> >>> If you have host with ten same cards, you will see one driver and this
> >>> is where the problem and not in supported/not-supported device.
> >>
> >> That's true, but you can also have different cards loading the same driver.
> >> See, for example, any PCI_IDs list in a driver.
> >>
> >> For example,
> >>
> >> 10:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
> >> 20:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3108 [Invader] (rev 02)
> >>
> >> Both load the megaraid driver and have different profiles within the
> >> driver.  I have no idea which one actually panicked until removing
> >> one card.
> >>
> >> It's MUCH worse when debugging new hardware and getting a panic
> >> from, for example, the uncore code which binds to a PCI mapped
> >> device.  One device might work and the next one doesn't.  And
> >> then you can multiply that by seeing *many* panics at once and
> >> trying to determine if the problem was on one specific socket,
> >> die, or core.
> > 
> > Would a dev_panic() interface that identified the device and
> > driver help with this?
> 
> ^^ the more I look at this problem, the more a dev_panic() that
> would output a device specific message at panic time is what I
> really need.
> 
> > For driver_load_messages, it doesn't seem necessarily
> > PCI-specific.  If we want a message like that, maybe it could be
> > in driver_probe_device() or similar?  There are already a few
> > pr_debug() calls in that path.  There are some enabled by
> > initcall_debug that include the return value from the probe; would
> > those be close to what you're looking for?
> 
> I took a look at those, and unfortunately they do not meet my
> requirements.  Ultimately, at panic time, I need to know that a
> driver was loaded on a device at a specific location in the PCI
> space.
> 
> The driver_probe_device() pr_debug calls tell me the location and
> the driver, but not anything to uniquely identify the device (ie,
> the PCI vendor and device IDs).
> 
> It sounds like you've had some thoughts about a dev_panic()
> implementation.  Care to share them with me?  I'm more than willing
> to implement it but just want to get your more experienced view of
> what is needed.

A dev_panic() might indeed be useful.  It would be nice to capture the
device information at the *first* crash instead of having to boot
again with initcall_debug and try to reproduce the crash.

include/linux/dev_printk.h has a whole mess of #defines for dev_info()
et al, and maybe that could be extended for dev_panic().  Or maybe the
dev_WARN() definition at the bottom, which basically just pastes the
driver and device info at the beginning of the string, would be
better.

Even if you do add a dev_panic(), I would also take a look through
drivers/base/dd.c and similar files to see whether the
pr_warn/pr_debug/etc they do could be converted to
dev_warn/dev_dbg/etc.

  $ git grep -A2 pr_ drivers/base | grep dev_name

finds several likely-looking candidates.  Here are some past patches
along that line:

  64b3eaf3715d ("xenbus: Use dev_printk() when possible")
  a88a7b3eb076 ("vfio: Use dev_printk() when possible")
  780da9e4f5bf ("iommu: Use dev_printk() when possible")

Bjorn
