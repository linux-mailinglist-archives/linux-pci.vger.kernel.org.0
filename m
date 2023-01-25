Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5485467B358
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjAYNeI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 08:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYNeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 08:34:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FE4CE47;
        Wed, 25 Jan 2023 05:34:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F7C361449;
        Wed, 25 Jan 2023 13:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F7C433D2;
        Wed, 25 Jan 2023 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674653643;
        bh=CzW3zBsYmO2eQ//HaKiDjgXblnunSy6jgP+bU4BqWoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4WLmbpJI8HKn3osqJ8KAZo5aHIkW3hBs7gPzTOOOST0azfTJ8nwZJZgEEe6KcFmB
         0NYqXXkQQBDiJZ3WFP2TvfRbr31EaUzHtmhH1yIhS3fyecMkexfPk139LsG8CM1MYj
         6bbBfRaGsF7tz2AwG6rx1xYLVRCBuMlONGUwgXhU=
Date:   Wed, 25 Jan 2023 14:34:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>, "robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y9EvyRqdpzJCcD63@kroah.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
 <Y862WTT03/JxXUG8@kroah.com>
 <Y9EBSmOoE5+83jS5@axis.com>
 <Y9EgrKT3hDyx+ULy@kroah.com>
 <Y9EpUnRDmWPobcrL@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EpUnRDmWPobcrL@axis.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 25, 2023 at 02:06:26PM +0100, Vincent Whitchurch wrote:
> On Wed, Jan 25, 2023 at 01:29:32PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 25, 2023 at 11:15:38AM +0100, Vincent Whitchurch wrote:
> > > I hope it's clear from my other replies in this thread that the entire
> > > purpose of this driver is to allow arbitrary platform devices to be used
> > > via a PCI device in virtual environments like User Mode Linux in order
> > > to test existing platform drivers using mocked hardware.
> > 
> > That still feels wrong, why is PCI involved here at all?
> >
> > Don't abuse platform devices like this please, mock up a platform device
> > framework instead if you want to test them that way, don't think that
> > adding a platform device "below" a PCI device is somehow allowed at all.
> 
> As you know, PCI allows exposing an MMIO region to the host, so the host
> can use ioremap() and readl()/writel() on it.  This allows reusing
> platform drivers even though the device is on the other side of a PCI
> bus.
> 
> There is hardware already supported by the kernel since a long time ago
> which is handled by putting platform devices below PCI devices.  See
> add_bus_probe() in arch/x86/kernel/devicetree.c.

Those are not platform devices below a PCI device from what I can tell,
and if it is, it's wrong and should be fixed up.  Don't perpetuate bad
design decisions of the past please.

> And this hardware also wants to do the same thing:
> 
>  https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@amd.com/

That too is wrong.

That is NOT what the platform devices and drivers are for at all, make
them some other type of device please, which is why the aux bus was
created.

> Also, UML already supports out-of-process PCI, and there is ongoing work
> in QEMU to add support for out-of-process PCI emulation.  So using PCI
> will allow this to work on different kinds of virtual environments
> without having to invent a new method specifically for platform devices.

I don't see how PCI is relevant here, sorry.

> > > The auxiliary bus cannot be used since it naturally does
> > > not support platform devices.
> > 
> > The aux bus can support any type of bus (it's there to be used as you
> > want, it's just that people are currently using it for PCI devices right
> > now).
> 
> I assume we're talking about drivers/base/auxiliary.c?  The kernel doc
> says:
> 
>  * A key requirement for utilizing the auxiliary bus is that there is no
>  * dependency on a physical bus, device, register accesses or regmap support.
>  * These individual devices split from the core cannot live on the platform bus
>  * as they are not physical devices that are controlled by DT/ACPI.
> 
> But this case the sub-devices do need standard register access with
> readl()/writel() and _are_ controlled by devicetree.

Ok, let's make a new bus for them then.  As obviously they are not
platform devices if they live on the PCI bus.

> > > A hard coded list of sub-devices cannot be used since arbitrary
> > > platform devices with arbitrary devicetree properties need to be
> > > supported.
> > 
> > Then make a new bus type and again, do not abuse platform devices.
> 
> How can existing platform drivers be re-used if you invent a new bus
> type and don't create platform devices?

The same way we reuse lots of drivers for devices on different busses
today.

> > > I could move this driver to drivers/bus/ and pitch it as a
> > > "PCI<->platform bridge for testing in virtual environments", if that
> > > makes more sense.
> > 
> > Again, nope, a platform device is NOT ever a child of a PCI device.
> > That's just not how PCI works at all.
> > 
> > Would you do the attempt to do this for USB?  (hint, no.)  So why is PCI
> > somehow special here?
> 
> PCI is special because it allows exposing an MMIO region to the host and
> allowing the host to access it like any other I/O memory.  USB doesn't
> allow that.

So you are saying that just because a bus type exports MMIO regions, it
should be allowed to be a platform device?  Sorry, but make that a new
bus type as obviously it is something else.  Maybe these are all just
real PCI devices (or sub devices), so treat them like that please.

thanks,

greg k-h
