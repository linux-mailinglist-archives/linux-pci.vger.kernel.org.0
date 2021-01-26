Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7263041F5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406180AbhAZPNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 10:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406146AbhAZPNm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 10:13:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28555230FE;
        Tue, 26 Jan 2021 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611673981;
        bh=tM2ZGZtebRMNTzA2KWnyD4jOaGSBwjO2UoGhLfP6FaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wv2ezM78v4R9QdSCFElyya3UNUycQaDzENiEDfXOHVrlVKcVQMkSObALAiJgvRJlO
         SNPzoXkvq9Xo8evLUBZb1hQYluBcLUtHS86ACo943DiQskkUP9Yb6YGwd6xzhqyUwY
         9dBOf70pKSdEwSlY7utQQujG3oW7zq34llF9LgXLH/kJbCDx8Vi7nkGgchkItuA5Bz
         OgFQD4c5N6DcMR3+DRo+4bNYSfnytwqJzhCZkt+IQBecn+eswR82UqoSQOTHMCb8wn
         i0Ov2ZPLT3HIwBPL5vJiV6TBSr+xULxag7GyzndQP1T/HldGajQVDpgJY2QypJJ5le
         xb6O1vDknhfjQ==
Date:   Tue, 26 Jan 2021 09:12:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, mstowe@redhat.com
Subject: Re: [PATCH] pci-driver: Add driver load messages
Message-ID: <20210126151259.GA2886142@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1917ff0c-7d7a-9580-be8a-bb65a970c5bb@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prarit,

On Tue, Jan 26, 2021 at 09:05:23AM -0500, Prarit Bhargava wrote:
> On 1/26/21 8:53 AM, Leon Romanovsky wrote:
> > On Tue, Jan 26, 2021 at 08:42:12AM -0500, Prarit Bhargava wrote:
> >> On 1/26/21 8:14 AM, Leon Romanovsky wrote:
> >>> On Tue, Jan 26, 2021 at 07:54:46AM -0500, Prarit Bhargava wrote:
> >>>>   Leon Romanovsky <leon@kernel.org> wrote:
> >>>>> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
> >>>>>> There are two situations where driver load messages are helpful.
> >>>>>>
> >>>>>> 1) Some drivers silently load on devices and debugging driver or system
> >>>>>> failures in these cases is difficult.  While some drivers (networking
> >>>>>> for example) may not completely initialize when the PCI driver probe() function
> >>>>>> has returned, it is still useful to have some idea of driver completion.
> >>>>>
> >>>>> Sorry, probably it is me, but I don't understand this use case.
> >>>>> Are you adding global to whole kernel command line boot argument to debug
> >>>>> what and when?
> >>>>>
> >>>>> During boot:
> >>>>> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
> >>>>> If device fails, you should get an error from that device (fix the
> >>>>> device to return an error), or something immediately won't work and
> >>>>> you won't see it in sysfs.
> >>>>
> >>>> What if there is a panic during boot?  There's no way to get to sysfs.
> >>>> That's the case where this is helpful.
> >>>
> >>> How? If you have kernel panic, it means you have much more worse problem
> >>> than not-supported device. If kernel panic was caused by the driver, you
> >>> will see call trace related to it. If kernel panic was caused by
> >>> something else, supported/not supported won't help here.
> >>
> >> I still have no idea *WHICH* device it was that the panic occurred on.
> > 
> > The kernel panic is printed from the driver. There is one driver loaded
> > for all same PCI devices which are probed without relation to their
> > number.>
> > If you have host with ten same cards, you will see one driver and this
> > is where the problem and not in supported/not-supported device.
> 
> That's true, but you can also have different cards loading the same driver.
> See, for example, any PCI_IDs list in a driver.
> 
> For example,
> 
> 10:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
> 20:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3108 [Invader] (rev 02)
> 
> Both load the megaraid driver and have different profiles within the
> driver.  I have no idea which one actually panicked until removing
> one card.
> 
> It's MUCH worse when debugging new hardware and getting a panic
> from, for example, the uncore code which binds to a PCI mapped
> device.  One device might work and the next one doesn't.  And then
> you can multiply that by seeing *many* panics at once and trying to
> determine if the problem was on one specific socket, die, or core.

Would a dev_panic() interface that identified the device and driver
help with this?

For driver_load_messages, it doesn't seem necessarily PCI-specific.
If we want a message like that, maybe it could be in
driver_probe_device() or similar?  There are already a few pr_debug()
calls in that path.  There are some enabled by initcall_debug that
include the return value from the probe; would those be close to what
you're looking for?

Bjorn
