Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623973A3461
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJUAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 16:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJUAh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 16:00:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47300613F1;
        Thu, 10 Jun 2021 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623355120;
        bh=kyGuLMDF162Fna1fj5F+84zmcept7WSNEY+f7MK484o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IjPcbRt0GQZMWhtPbUMb8xgQSM+Ne/eCj9jDaMprVwqnCoSXLqvxRninjdI7S19vt
         7MTs0MMAQWQ2Nj0z295gOE9LqQD6XLetok1Wm2WXBLBEElgSlyYaDP9zzK/8sz/KMM
         0QLGtRKJY7tMXeMPgjKrA71orT4ccuaFcIkUgQjwsChWIFwZA2ojO7idmCQ7ZyLff7
         ODE4Fe7sVY/p72UUmPGtBCqp6128pP4O5QDqVVLvUoZ1RoFJXCsWVq2p36kQpnVCmi
         3uR0DeuTuhiFHnGTtg0usbYvZ7tofQRp2bNv0yQddM2Ma9lSUlmxDyMp5WB4/Jbj+1
         C7gatqt3P016A==
Date:   Thu, 10 Jun 2021 14:58:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH v3 2/4] PCI: of: Relax the condition for warning about
 non-prefetchable memory aperture size
Message-ID: <20210610195838.GA2763134@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2bhkdxd.fsf@stealth>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 11:11:10PM +0900, Punit Agrawal wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Wed, Jun 09, 2021 at 12:36:08AM +0530, Vidya Sagar wrote:
> >> On 6/7/2021 4:58 PM, Punit Agrawal wrote:
> >> > 
> >> > Commit fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
> >> > aperture size is > 32-bit") introduced a warning for non-prefetchable
> >> > resources that need more than 32bits to resolve. It turns out that the
> >> > check is too restrictive and should be applicable to only resources
> >> > that are limited to host bridge windows that don't have the ability to
> >> > map 64-bit address space.
> >>
> >> I think the host bridge windows having the ability to map 64-bit address
> >> space is different from restricting the non-prefetchable memory aperture
> >> size to 32-bit.
> >
> >> Whether the host bridge uses internal translations or not to map the
> >> non-prefetchable resources to 64-bit space, the size needs to be programmed
> >> in the host bridge's 'Memory Limit Register (Offset 22h)' which can
> >> represent sizes only fit into 32-bits.
> >
> >> Host bridges having the ability to map 64-bit address spaces gives
> >> flexibility to utilize the vast 64-bit space for the (restrictive)
> >> non-prefetchable memory (i.e. mapping non-prefetchable BARs of endpoints to
> >> the 64-bit space in CPU's view) and get it translated internally and put a
> >> 32-bit address on the PCIe bus finally.
> >
> > The vastness of the 64-bit space in the CPU view only helps with
> > non-prefetchable memory if you have multiple host bridges with
> > different CPU-to-PCI translations.  Each root bus can only carve up
> > 4GB of PCI memory space for use by its non-prefetchable memory
> > windows.
> >
> > Of course, if we're willing to give up the performance, there's
> > nothing to prevent us from using non-prefetchable space for
> > *prefetchable* resources, as in my example below.
> >
> > I think the fede8526cc48 commit log is incorrect, or at least
> > incomplete:
> >
> >   As per PCIe spec r5.0, sec 7.5.1.3.8 only 32-bit BAR registers are defined
> >   for non-prefetchable memory and hence a warning should be reported when
> >   the size of them go beyond 32-bits.
> >
> > 7.5.1.3.8 is talking about non-prefetchable PCI-to-PCI bridge windows,
> > not BARs.  AFAIK, 64-bit BARs may be non-prefetchable.  The warning is
> > in pci_parse_request_of_pci_ranges(), which isn't looking at
> > PCI-to-PCI bridge windows; it's looking at PCI host bridge windows.
> > It's legal for a host bridge to have only non-prefetchable windows,
> > and prefetchable PCI BARs can be placed in them.
> >
> > For example, we could have the following:
> >
> >   pci_bus 0000:00: root bus resource [mem 0x80000000-0x1_ffffffff] (6GB)
> >   pci 0000:00:00.0: PCI bridge to [bus 01-7f]
> >   pci 0000:00:00.0:   bridge window [mem 0x80000000-0xbfffffff] (1GB)
> >   pci 0000:00:00.0:   bridge window [mem 0x1_00000000-0x1_7fffffff 64bit pref] (2GB)
> >   pci 0000:00:00.1: PCI bridge to [bus 80-ff]
> >   pci 0000:00:00.1:   bridge window [mem 0xc0000000-0xffffffff] (1GB)
> >   pci 0000:00:00.1:   bridge window [mem 0x1_80000000-0x1_ffffffff 64bit pref] (2GB)
> >
> > Here the host bridge window is 6GB and is not prefetchable.  The
> > PCI-to-PCI bridge non-prefetchable windows are 1GB each and the bases
> > and limits fit in 32 bits.  The prefetchable windows are 2GB each, and
> > we're allowed but not required to put these in prefetchable host
> > bridge windows.
> >
> > So I'm not convinced this warning is valid to begin with.  It may be
> > that this host bridge configuration isn't optimal, and we might want
> > an informational message, but I think it's *legal*.
> 
> By "optimal" - are you referring to the use of non-prefetchable space
> for prefetchable window?

Yes.  I just meant that we don't know the specific capabilities of the
host bridge, and firmware or the native driver may not have configured
it in the optimal way.

> Also, if the warning doesn't apply to PCI host bridge windows, should I
> drop it in the next update? Or leave out this and the next patch to be
> dealt with separately.

I'd like to hear Vidya's thoughts on this first in case I'm
misinterpreting something.

In the meantime, I think it's not terrible if you leave this as-is for
now.  Worst-case we'll get some warnings that we might not need, but
IIUC, patches 2/4 and 3/4 don't fix a functional problem.

I don't know whether the IORESOURCE_PREFETCH bit on host bridge
windows is important or not.  I *think* it's common for ACPI host
bridge descriptions to have no windows described as "prefetchable" (at
least, my garden-variety laptop has none):

  pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
  pci 0000:00:01.0: PCI bridge to [bus 01]
  pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
  pci 0000:00:1c.1: PCI bridge to [bus 03]
  pci 0000:00:1c.1:   bridge window [mem 0xd2100000-0xd2afffff 64bit pref]
  pci 0000:00:1d.6: PCI bridge to [bus 06-3e]
  pci 0000:00:1d.6:   bridge window [mem 0x90000000-0xb1ffffff 64bit pref]

I guess we must just rely on the fact that BIOS has already programmed
those prefetchable windows?  I really don't know how this works, to be
honest.

Bjorn
