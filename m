Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D774F55FA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 08:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiDFFnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455327AbiDFD7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 23:59:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B5216A7A
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 17:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AEFBB81B94
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 00:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA953C385A0;
        Wed,  6 Apr 2022 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649204384;
        bh=YRaZEYdBSERzq8cyztJx1Wo3hwRSa7F4pBp2VIm7P7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=omNltD2o34bhZsLgb0QC3M6i6vviXJJ/RpiZkGlWTWJqMk93I6AzvL8ejbgYpI36t
         aHMPtKwXGkLOHUs28A8/dlxCcYEeSqXm1H2dQ2GfoiKCNZ0c5jRLAw75Zo/yxRPs1Y
         Mi4UcNjOuCscF60SQMP/Nie45ZGdVXoMdeeywbQ5z4p2u0CZxXi5SUnaQYCKfHV7Az
         eDF2RnvVEAYltZKbvtFk+Prb+Nl0YH7JMpRqLZXqg/mkKaAiFTbeZHFRD4S28Kxcb4
         xw+V8cxn1I9o/tTmbKdVfHVIP4oz20gtADsX6Yt8WY/a6BgazAnrYoz+rpOwJFpaUG
         u2URpawF7Mehg==
Date:   Tue, 5 Apr 2022 19:19:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220406001942.GA74862@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c5de03-a3a4-8444-d7f6-496fa119d830@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 04, 2022 at 10:45:10AM +0200, Hans de Goede wrote:
> On 3/30/22 13:35, Bjorn Helgaas wrote:
> > On Mon, Mar 28, 2022 at 02:54:42PM +0200, Hans de Goede wrote:

> >> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
> >> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
> >> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
> >> and see if that makes it boot again ?

> >> From b8080a6d2d889847900e1408f71d0c01c73f5c94 Mon Sep 17 00:00:00 2001
> >> From: Hans de Goede <hdegoede@redhat.com>
> >> Date: Mon, 28 Mar 2022 14:47:41 +0200
> >> Subject: [PATCH] x86/PCI: Limit "e820 entry fully covers window" check to non
> >>  ISA MMIO addresses
> >>
> >> Commit FIXME ("x86/PCI: Preserve host bridge windows completely
> >> covered by E820") added a check to skip e820 table entries which
> >> fully cover a PCI bride's memory window when clipping PCI bridge
> >> memory windows.
> >>
> >> This check also caused ISA MMIO windows to not get clipped when
> >> fully covered, which is causing some coreboot based Chromebooks
> >> to not boot.
> >>
> >> Modify the fully covered check to not apply to ISA MMIO windows.

> >> Fixes: FIXME ("x86/PCI: Preserve host bridge windows completely covered by E820")
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  arch/x86/kernel/resource.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> >> index 6be82e16e5f4..d9ec913619c3 100644
> >> --- a/arch/x86/kernel/resource.c
> >> +++ b/arch/x86/kernel/resource.c
> >> @@ -46,8 +46,12 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
> >>  		 * devices.  But if it covers the *entire* resource, it's
> >>  		 * more likely just telling us that this is MMIO space, and
> >>  		 * that doesn't need to be removed.
> >> +		 * Note this *entire* resource covering check is only
> >> +		 * intended for 32 bit memory resources for the 16 bit
> >> +		 * isa window we always apply the e820 entries.
> >>  		 */
> >> -		if (e820_start <= avail->start && avail->end <= e820_end) {
> >> +		if (avail->start >= ISA_END_ADDRESS &&
> > 
> > What is the justification for needing to check ISA_END_ADDRESS here?
> > The commit log basically says "this makes it work", which isn't very
> > satisfying.
> 
> I did not have a log with the:
> 
> >   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
> >   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
> >   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
> 
> messages. Instead I was looking at this log:
> 
> https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
> 
> With the following messages (as I quoted higher up in the email-thread):
> 
> """
>  1839 17:54:41.406548  <6>[    0.000000] BIOS-provided physical RAM map:
>  1840 17:54:41.413121  <6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] type 16
>  1841 17:54:41.419712  <6>[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
>  1842 17:54:41.430192  <6>[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
>  1843 17:54:41.436207  <6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
>  1844 17:54:41.446353  <6>[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
>  1845 17:54:41.453290  <6>[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x000000007a9fcfff] usable
>  1846 17:54:41.459966  <6>[    0.000000] BIOS-e820: [mem 0x000000007a9fd000-0x000000007affffff] type 16
>  1847 17:54:41.469549  <6>[    0.000000] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
>  1848 17:54:41.476685  <6>[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
>  1849 17:54:41.486439  <6>[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>  1850 17:54:41.492994  <6>[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed17fff] reserved
>  1851 17:54:41.503008  <6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
> ...
>  2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>  2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
> """
> 
> ###
> 
> What I find weird here is that this boot with a somewhat earlier kernel has:
> 
>  2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>  2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]
> 
> Where as the boot with the clipped messages has:
> 
> <6>[    0.313705] acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
> <6>[    0.314702] acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
> <6>[    0.315747] PCI host bridge to bus 0000:00
> <6>[    0.316118] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> <6>[    0.316703] pci_bus 0000:00: root bus resource [io  0x1000-0xffff window]
> <6>[    0.317298] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
> <6>[    0.317703] pci_bus 0000:00: root bus resource [bus 00-ff]
> 
> So in the boot with the clipped messages we are getting 3 windows from _CRS
> where as before we were getting only 2?  I know that we are now applying
> the clipping directly when we are parsing the resources. So I guess that
> before we somehow also merged the 2 resources which are back to back together
> before the "root bus resource" messages get printed. This caused me to just
> see the "root bus resource [mem 0x7b800000-0xe0000000 window]" which is
> not fully covered which is why I focused on the ISA MMIO window.

Yes, we do merge adjacent windows together.  See 7c3855c423b1 ("PCI:
Coalesce host bridge contiguous apertures") [1].  This is because our
BAR assignment isn't smart enough to assign space from two ajacent
resources to one BAR.

We have (at least) three apertures, and the latter two would be merged
together:

  acpi PNP0A08:00: ... [mem 0x000a0000-0x000bffff window] ...
  acpi PNP0A08:00: ... [mem 0x7b800000-0x7fffffff window] ...
  acpi PNP0A08:00: ... [mem 0x80000000-0xe0000000 window] ...

The boot at [2] was with 5.17.0-rc7-next-20220310, which includes
7f7b4236f204 ("x86/PCI: Ignore E820 reservations for bridge windows on
newer systems") [3], so we ignored E820 completely and we found two
windows (the VGA framebuffer and the big merged window):

  Linux version 5.17.0-rc7-next-20220310 (KernelCI@build-j608383-x86-64-gcc-10-x86-64-defconfig-x86-chromebooc26pc) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP PREEMPT Fri Mar 11 17:23:28 UTC 2022
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]

The boot at [4] was with d13f73e9108a ("x86/PCI: Log host bridge
window clipping for E820 regions") [5].  In addition to logging,
d13f73e9108a also does the clipping *before* the merging:

  Linux version 5.17.0-rc7 (KernelCI@0bd4b548bde7) (gcc (Debian 10.2.1-6) 
  acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
  acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
  acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
  pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]

Here we clipped the VGA framebuffer and [mem 0x7b800000-0x7fffffff]
completely out, so we ignored them, and we clipped the big window to
avoid [mem 0xd0000000-0xd0ffffff], so all we have left is
[mem 0x80000000-0xcfffffff].

> > The Asus log of the last good commit shows:
> > 
> >   PCI: 00:0d.0 [8086/5a92] enabled
> >   constrain_resources: PCI: 00:0d.0 10 base d0000000 limit d0ffffff mem (fixed)
> >   ...
> >   BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
> >   BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
> >   BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> >   ...
> >   acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
> >   acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
> >   acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
> >   acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
> >   acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])

> > From the firmware part of the log, it looks like 00:0d.0 is a hidden
> > device that consumes [mem d0000000-0xd0ffffff].  Linux doesn't
> > enumerate 00:0d.0, so firmware should have carved that out of the [mem
> > 0x80000000-0xe0000000 window] in _CRS.
> > 
> > We don't have a log with 5949965ec934 ("x86/PCI: Preserve host bridge
> > windows completely covered by E820") applied, but I think it would
> > show this:
> > 
> >   acpi PNP0A08:00: resource [mem 0x000a0000-0x000bffff window] fully covered by e820 entry [mem 0x000a0000-0x000fffff]
> >   acpi PNP0A08:00: resource [mem 0x7b800000-0x7fffffff window] fully covered by e820 entry [mem 0x7b000000-0x7fffffff]
> > 
> > instead of clipping those windows.  But none of the devices we
> > enumerate appears to be using either of those windows.
> 
> Not with a working kernel no, because they are clipped of, but
> with the don't clip fully-covered _CRS windows change, the 
> [mem 0x7b000000-0x7fffffff] all of a sudden becomes fair game
> to assign BARs to.
> 
> I agree that we will get a fully-covered msg for that one with
> the patch, which would change:
> 
> [    0.317298] pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]
> 
> to:
> 
> [    0.317298] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]
> 
> and I believe that likely is our culprit.

I think you're probably right.  We started with this:

  BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
  BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
  BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
  BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
  acpi PNP0A08:00: ... [mem 0x000a0000-0x000bffff window] ...
  acpi PNP0A08:00: ... [mem 0x7b800000-0x7fffffff window] ...
  acpi PNP0A08:00: ... [mem 0x80000000-0xe0000000 window] ...

After 5949965ec934, clipping will give us this:

  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x7b800000-0x7fffffff window]
  pci_bus 0000:00: root bus resource [mem 0x80000000-0xcfffffff window]

and merging will give us this:

  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]

BIOS left a 00:18.2 BAR here [6]:

  pci 0000:00:18.2: reg 0x10: [mem 0xde000000-0xde000fff 64bit]

That BAR is outside the windows we know about, so we'll move it,
probably to 0x7b800000 and maybe it doesn't work there.

> So to fix this I guess that we first need to merge back-to-back
> windows coming from _CRS into a single window, before calling
> remove_e820_regions()
> 
> That would pass [mem 0x7b800000-0xe0000000 window] to
> remove_e820_regions() in a single call (as I expected from the
> logs), which should result in both the top and the bottom still
> getting clipped as before.

So I think the progression is:

  1) Remove anything mentioned in E820 from _CRS (4dc2287c1805 [7]).
     This worked around some issues on Dell systems.

  2) Remove things mentioned in E820 unless they cover the entire
     window (5949965ec934 [8])

  3) Coalesce adjacent _CRS windows, *then* remove things mentioned in
     E820 unless they cover the entire (coalesced) window (current
     proposal)

Even 3) leaves us with the 00:18.2 BAR above that will be moved when
it doesn't need to be.  That could lead us to something like this:

  4) Coalesce adjacent _CRS windows, *then* remove things mentioned in
     E820 unless they cover the entire (coalesced) window (current
     proposal), but punch holes instead of lopping entire sections, so 
     we would end up with these windows:

      pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
      pci_bus 0000:00: root bus resource [mem 0x7b800000-0xcfffffff window]
      pci_bus 0000:00: root bus resource [mem 0xd0100000-0xdfffffff window]

But I don't think this is leading to a maintainable result.  We
shouldn't be using E820 at all in an ACPI system (and again, the fact
that we *do* use it is my fault, and I'll take my beatings).  We need
to *reduce* or at least contain that E820 usage instead of expanding
it.

[1] https://git.kernel.org/linus/7c3855c423b1
[2] https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html#L2030
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/?id=7f7b4236f204
[4] https://lava.collabora.co.uk/scheduler/job/5937945#L2023
[5] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/?id=d13f73e9108a
[6] https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html#L2084
[7] https://git.kernel.org/linus/4dc2287c1805
[8] https://lore.kernel.org/all/20220304035110.988712-4-helgaas@kernel.org/
