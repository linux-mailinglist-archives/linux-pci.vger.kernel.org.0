Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0A4EBFE3
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 13:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiC3Lhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbiC3Lhi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 07:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646481E95E4
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 04:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 002A4615E2
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 11:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A836C340EC;
        Wed, 30 Mar 2022 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648640152;
        bh=HduqPcEgf+yBi46Me+EwvPq6CIoHOC8BK/Ma18H6rlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X5KKvmCIlQszqTa4m40GUt9llw6XAL2/+k+1g7Z3+JImY62QxbvjFILyY4QeniaUz
         frkKremkF9EvVRyUMwlK31R6FGL5k5gav0HJbVSbK0I4SnukfI1uwNl1XOPMkrK6my
         E315SH1Q7NvyxnFRSs51BrUq11GFU6o5Og8SVTDm1obivn5BOxG57mugqdok3LfAEX
         LCID0nXH/Bsrdb9AQRtdpfrKTri0/SVbHLB1XESQ+UbFk8VnFw4sIYkKvV2/l6ijkg
         3BM+erAtbpEFPQrvmq5nCBDsIxWcOdwcbCbdE70LrW9bNJvvZvK2k4cUtB9aV08QDk
         vtjyMLt2q6eSg==
Date:   Wed, 30 Mar 2022 06:35:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220330113550.GA1638045@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 02:54:42PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 3/24/22 23:19, Mark Brown wrote:
> > On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
> > 
> >> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
> >> kernel build from next + the test patch ?
> > 
> > I can't directly unfortunately as the board is in Collabora's lab but
> > Guillaume (who's already CCed) ought to be able to, and I can generally
> > prod and try to get that done.
> 
> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
> and see if that makes it boot again ?
> 
> Regards,
> 
> Hans

> From b8080a6d2d889847900e1408f71d0c01c73f5c94 Mon Sep 17 00:00:00 2001
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Mon, 28 Mar 2022 14:47:41 +0200
> Subject: [PATCH] x86/PCI: Limit "e820 entry fully covers window" check to non
>  ISA MMIO addresses
> 
> Commit FIXME ("x86/PCI: Preserve host bridge windows completely
> covered by E820") added a check to skip e820 table entries which
> fully cover a PCI bride's memory window when clipping PCI bridge
> memory windows.
> 
> This check also caused ISA MMIO windows to not get clipped when
> fully covered, which is causing some coreboot based Chromebooks
> to not boot.
> 
> Modify the fully covered check to not apply to ISA MMIO windows.

I'd like to include URLs to the kernelci results unless they are
ephemeral.  There's a lot of valuable information in these:

  Asus C523NA-A20057-coral with the last good commit:
  https://lava.collabora.co.uk/scheduler/job/5937945

  https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
  https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html

> Fixes: FIXME ("x86/PCI: Preserve host bridge windows completely covered by E820")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/x86/kernel/resource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 6be82e16e5f4..d9ec913619c3 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -46,8 +46,12 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>  		 * devices.  But if it covers the *entire* resource, it's
>  		 * more likely just telling us that this is MMIO space, and
>  		 * that doesn't need to be removed.
> +		 * Note this *entire* resource covering check is only
> +		 * intended for 32 bit memory resources for the 16 bit
> +		 * isa window we always apply the e820 entries.
>  		 */
> -		if (e820_start <= avail->start && avail->end <= e820_end) {
> +		if (avail->start >= ISA_END_ADDRESS &&

What is the justification for needing to check ISA_END_ADDRESS here?
The commit log basically says "this makes it work", which isn't very
satisfying.

The Asus log of the last good commit shows:

  PCI: 00:0d.0 [8086/5a92] enabled
  constrain_resources: PCI: 00:0d.0 10 base d0000000 limit d0ffffff mem (fixed)
  ...
  BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
  BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
  BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
  ...
  acpi PNP0A08:00: clipped [mem 0x000a0000-0x000bffff window] to [mem 0x00100000-0x000bffff window] for e820 entry [mem 0x000a0000-0x000fffff]
  acpi PNP0A08:00: clipped [mem 0x7b800000-0x7fffffff window] to [mem 0x80000000-0x7fffffff window] for e820 entry [mem 0x7b000000-0x7fffffff]
  acpi PNP0A08:00: clipped [mem 0x80000000-0xe0000000 window] to [mem 0x80000000-0xcfffffff window] for e820 entry [mem 0xd0000000-0xd0ffffff]
  acpi PNP0A08:00: ignoring host bridge window [mem 0x00100000-0x000bffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])
  acpi PNP0A08:00: ignoring host bridge window [mem 0x80000000-0x7fffffff window] (conflicts with PCI mem [mem 0x00000000-0x7fffffffff])

It looks like _CRS gave us [mem 0x80000000-0xe0000000 window], which
is one byte too big (it should end at 0xdfffffff).

From the firmware part of the log, it looks like 00:0d.0 is a hidden
device that consumes [mem d0000000-0xd0ffffff].  Linux doesn't
enumerate 00:0d.0, so firmware should have carved that out of the [mem
0x80000000-0xe0000000 window] in _CRS.

We don't have a log with 5949965ec934 ("x86/PCI: Preserve host bridge
windows completely covered by E820") applied, but I think it would
show this:

  acpi PNP0A08:00: resource [mem 0x000a0000-0x000bffff window] fully covered by e820 entry [mem 0x000a0000-0x000fffff]
  acpi PNP0A08:00: resource [mem 0x7b800000-0x7fffffff window] fully covered by e820 entry [mem 0x7b000000-0x7fffffff]

instead of clipping those windows.  But none of the devices we
enumerate appears to be using either of those windows.

We do have this:

  pci 0000:00:18.2: reg 0x10: [mem 0xde000000-0xde000fff 64bit]
  pci 0000:00:18.2: reg 0x18: [mem 0xc2b31000-0xc2b31fff 64bit]
  pci 0000:00:18.2: can't claim BAR 0 [mem 0xde000000-0xde000fff 64bit]: no compatible bridge window
  pci 0000:00:18.2: BAR 0: assigned [mem 0x80000000-0x80000fff 64bit]

Where the original [mem 0xde000000-0xde000fff 64bit] assignment was
perfectly legal, but we clipped [mem 0x80000000-0xe0000000 window] to
[mem 0x80000000-0xcfffffff window] instead of just punching a hole for
the 00:0d.0 carve-out.

Maybe 5949965ec934 puts 00:18.2 BAR 0 somewhere that doesn't work,
or maybe the clipping to [mem 0x00100000-0x000bffff window] or
[mem 0x80000000-0x7fffffff window] doesn't work as expected?
They are supposed to be interpreted as "empty", but certainly
resource_size([0x00100000-0x000bffff]) is != 0.

> +		    e820_start <= avail->start && avail->end <= e820_end) {
>  			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>  				 avail, e820_start, e820_end);
>  			continue;
> -- 
> 2.35.1
> 

