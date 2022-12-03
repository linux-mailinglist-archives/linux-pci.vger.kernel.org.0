Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE45641830
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 18:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLCR5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Dec 2022 12:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLCR5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2022 12:57:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC25CE07;
        Sat,  3 Dec 2022 09:57:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B16B60C94;
        Sat,  3 Dec 2022 17:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D47C433D6;
        Sat,  3 Dec 2022 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670090265;
        bh=3BxAyDMQ6DLgOIPlEm/X4fZvyp4mZVWnTBHlAqFkK2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RX7z2oBk1L/jmS/KCDcdYduxx+lbwbNfnsU8XG9PDkNlh2jAMBCDs+fBT+2BF3ibD
         qC/ScHV8GmC6iv1yRDd8LRtJQLf8gQYEdqCzsUZwSAMaUqiOvvEWwiFuHpKs8uHT9c
         oGIf7k3SY3Gi/rMgkT4gvCeIRc/bwXdfqeATVIblRvG7S8kpPjHg81knl2NplJHMiR
         FsYSI4uJlqeffzrx0bq7mykgGWZ2YQDgUxKvgyg69Om/kKlOw0MGkQI7V+QP0iR5Sx
         JWZJXAGtij4j0gFvYy1JywBuSPp3LfeyxwwUh4TMH0ITnHo+FtBbEuRS6DXsnlsERI
         cxIsn+sWSqetg==
Date:   Sat, 3 Dec 2022 11:57:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pci@vger.kernel.org, Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Message-ID: <20221203175743.GA1121812@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7fd3e67-89cf-17ed-c680-f5d44a6952e7@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 03, 2022 at 01:44:10PM +0100, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 12/2/22 22:18, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > When allocating space for PCI BARs, Linux avoids allocating space mentioned
> > in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
> > E820 regions when allocating address space") to work around BIOS defects
> > that included unusable space in host bridge _CRS.
> > 
> > Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
> > apertures, and bootloaders and EFI stubs convert those to E820 regions,
> > which means we can't allocate space for hot-added PCI devices (often a
> > dock) or for devices the BIOS didn't configure (often a touchpad)
> > 
> > The current strategy is to add DMI quirks that disable the E820 filtering
> > on these machines and to disable it entirely starting with 2023 BIOSes:
> > 
> >   d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
> >   0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")
> > 
> > But the quirks are problematic because it's really hard to list all the
> > machines that need them.
> > 
> > This series is an attempt at a more generic approach.  I'm told by firmware
> > folks that EfiMemoryMappedIO means "the OS should map this area so EFI
> > runtime services can use it in virtual mode," but does not prevent the OS
> > from using it.
> > 
> > The first patch removes any EfiMemoryMappedIO areas from the E820 map.
> > This doesn't affect any virtual mapping of those areas (that would have to
> > be done directly from the EFI memory map) but it means Linux can allocate
> > space for PCI MMIO.
> > 
> > The rest are basically cosmetic log message changes.
> 
> Thank you for working on this. I'm a bit worried about this series though.
> 
> The 2 things which I worry about are:
> 
> 
> 1. I think this will not help when people boot in BIOS (CSM) mode rather
> then UEFI mode which quite a few Linux users still do because they learned
> to do this years ago when Linux EFI support (and EFI fw itself) was still
> a bit in flux.
> 
> IIRC from the last time we looked at this in CSM mode the BIOS itself
> translates the EfiMemoryMappedIO areas to reserved E820 regions. So when
> people use the BIOS CSM mode to boot, then this patch will not help
> since the kernel lacks the info to do the translation.

Right, if BIOS CSM puts EfiMemoryMappedIO in the E820 map the same way
bootloaders do, and the kernel doesn't have the EFI memory map, this
series won't help.

> We may also hit the same case when the bootloader has done the
> translation which I believe is what upstream grub does. Fedora grub
> has been patched to use the kernel EFI stub when booting a kernel
> on EFI, so just an EFI equivalent of "exec" on the kernel EFI binary.
> 
> Where as upstream grub does a more BIOS like boot, where it skips the
> EFI stub and instead does a whole bunch of stuff itself and then
> jumps to the kernel's start vector. So this might also not work with
> upstream grub, which is what I believe Ubuntu and Debian use.
>
> Although I case in this case we will still have access to the EFI
> memory map and I see that your patch removes the entries stemming
> from the EfiMemoryMappedIO areas from the E820 map, rather then
> never adding them. So I guess this will also work in the case
> when the bootloader has done the translation (leaving just
> the BIOS CSM case as an issue)?
>
> This won't cause regressions, but it does mean that e.g. the
> touchpad i2c-controller / hotplugged PCI devices will still not
> work when booted in BIOS (CSM) mode / through upstream grub.

Yes, I agree CSM could still be broken if BIOS puts EfiMemoryMappedIO
in the E820 map.

I'm not clear on the grub cases.  Do some grub versions hide the EFI
memory map from the kernel?  If they do, they could be broken the same
way as CSM.

> 2. I am afraid that now allowing PCI MMIO space to be allocated
> in regions marked as EfiMemoryMappedIO will cause regressions
> on some systems. Specifically when I tried something similar
> the last time I looked at this (using the BIOS date cut-off
> approach IIRC) there was a suspend/resume regression on
> a Lenovo ThinkPad X1 carbon (20A7) model:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> 
> Back then I came to the conclusion that the problem is that not
> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
> listed in the EFI memmap as:
> 
> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
> 
> And with current kernels with the extra logging added for this
> the following is logged related to this:
> 
> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
> 
> I believe patch 1/4 of this set will make this clipping go away,
> re-introducing the suspend/resume problem.

Yes, I'm afraid you're right.  Comparing the logs at comment #31
(fails) and comment #38 (works):

  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
  pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
  pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works

Since 0xdfa00000 is included in the host bridge _CRS, but isn't
usable, my guess is this is a _CRS bug.

Or maybe BIOS is using the producer/consumer bit in _CRS to identify
this as register space as opposed to a window?  I thought we couldn't
rely on that bit, but it's been a long time since I looked at it.  An
acpidump might have a clue.

Bjorn
