Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4312367B2F5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjAYNGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 08:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAYNGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 08:06:32 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8F46709;
        Wed, 25 Jan 2023 05:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674651989;
  x=1706187989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dA62bXJWySP2KDvSzEIUHP6wxBANByXrR0XSLtGkoh8=;
  b=dZxw4ectAA83DhW9WUTE+xnHThCzlmwnvv1YUW9BsZsyRgle3mBbUk7S
   ZGHLjGd6Qmr5CHdA8wZaxWMsckGwsAcfYx3dOqtp6E1vDvOMmcXHvVLQT
   9fs09n/zunq2s6g5WsYKwWKo/EYPWEbt6szdy+jv5HSUlH8s+OB9tVBX5
   peg+V3jOyuk5cUt5FMeRAPXJUkYSflQ/Y2W2ApbP2oMOuYICtDVhId7LH
   72htdGenkj9QxI0NosT1XxIW4Ur9/E4DR3J6eleni4vidj8/kckhp9v6I
   VjA81rC6YP0liq9Z8tvMdW0j5kwSHCQBBMbX7S9Kxcf3zCtJvKYHmti5Z
   A==;
Date:   Wed, 25 Jan 2023 14:06:26 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Lee Jones <lee@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>, "robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH] mfd: Add Simple PCI MFD driver
Message-ID: <Y9EpUnRDmWPobcrL@axis.com>
References: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
 <Y86op9oh5ldrZQyG@google.com>
 <Y862WTT03/JxXUG8@kroah.com>
 <Y9EBSmOoE5+83jS5@axis.com>
 <Y9EgrKT3hDyx+ULy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9EgrKT3hDyx+ULy@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 25, 2023 at 01:29:32PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 25, 2023 at 11:15:38AM +0100, Vincent Whitchurch wrote:
> > I hope it's clear from my other replies in this thread that the entire
> > purpose of this driver is to allow arbitrary platform devices to be used
> > via a PCI device in virtual environments like User Mode Linux in order
> > to test existing platform drivers using mocked hardware.
> 
> That still feels wrong, why is PCI involved here at all?
>
> Don't abuse platform devices like this please, mock up a platform device
> framework instead if you want to test them that way, don't think that
> adding a platform device "below" a PCI device is somehow allowed at all.

As you know, PCI allows exposing an MMIO region to the host, so the host
can use ioremap() and readl()/writel() on it.  This allows reusing
platform drivers even though the device is on the other side of a PCI
bus.

There is hardware already supported by the kernel since a long time ago
which is handled by putting platform devices below PCI devices.  See
add_bus_probe() in arch/x86/kernel/devicetree.c.

And this hardware also wants to do the same thing:

 https://lore.kernel.org/lkml/1674183732-5157-1-git-send-email-lizhi.hou@amd.com/

Also, UML already supports out-of-process PCI, and there is ongoing work
in QEMU to add support for out-of-process PCI emulation.  So using PCI
will allow this to work on different kinds of virtual environments
without having to invent a new method specifically for platform devices.

> > Given this "hardware", it's not clear what a "real driver" would do
> > differently.
> 
> Again, you can not have a platform device below a PCI device, that's not
> what a platform device is for at all.

See above.

> > The auxiliary bus cannot be used since it naturally does
> > not support platform devices.
> 
> The aux bus can support any type of bus (it's there to be used as you
> want, it's just that people are currently using it for PCI devices right
> now).

I assume we're talking about drivers/base/auxiliary.c?  The kernel doc
says:

 * A key requirement for utilizing the auxiliary bus is that there is no
 * dependency on a physical bus, device, register accesses or regmap support.
 * These individual devices split from the core cannot live on the platform bus
 * as they are not physical devices that are controlled by DT/ACPI.

But this case the sub-devices do need standard register access with
readl()/writel() and _are_ controlled by devicetree.

> > A hard coded list of sub-devices cannot be used since arbitrary
> > platform devices with arbitrary devicetree properties need to be
> > supported.
> 
> Then make a new bus type and again, do not abuse platform devices.

How can existing platform drivers be re-used if you invent a new bus
type and don't create platform devices?

> > I could move this driver to drivers/bus/ and pitch it as a
> > "PCI<->platform bridge for testing in virtual environments", if that
> > makes more sense.
> 
> Again, nope, a platform device is NOT ever a child of a PCI device.
> That's just not how PCI works at all.
> 
> Would you do the attempt to do this for USB?  (hint, no.)  So why is PCI
> somehow special here?

PCI is special because it allows exposing an MMIO region to the host and
allowing the host to access it like any other I/O memory.  USB doesn't
allow that.
