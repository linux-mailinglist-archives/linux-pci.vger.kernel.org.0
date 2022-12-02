Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECF641047
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 22:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLBV6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 16:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbiLBV6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:58:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED4F466D;
        Fri,  2 Dec 2022 13:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A8DFB822BB;
        Fri,  2 Dec 2022 21:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D5C433D6;
        Fri,  2 Dec 2022 21:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670018293;
        bh=JQfzBY7w+BMB6G8p1pow4OS6vMBpG0LUSHGgYMKPwxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pmWTEjyGDvqIJZlqbuKQhE2eO3DEOj5wDMoLq5PgVdwY8ELR1FMPZh69C84f/mEeF
         ZaCVqO6LA6MUnP3w9ZnvrY769dUiiy4crkyAmHRAtihG0i+CkfMG8iJbWMNt8hOoVv
         kK+PBhpe7c6QmOw+wphd4f91/96kb4tDZItF30iTMCRE1OW2VtcsZsCEnjPfZxXVy2
         MbyhwBT88Iol0BpC4QlreWua3MG0g4RV2x9rG4G+eCQL1pIuPsTaGkuaxFk5Dvm+Lo
         bastDzW49fIknNFNV/tc0Oi6H9BGOyME3ZdCkrpzIk6uGTkZXPp3sbksobeHfdY6iC
         WqO+kT9VwoBqQ==
Date:   Fri, 2 Dec 2022 15:58:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxkernelml@undead.fr,
        Florent DELAHAYE <kernelorg@undead.fr>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Disable E820 reserved region clipping for Clevo
 NL4XLU laptops
Message-ID: <20221202215811.GA1063109@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9203d47-5b85-c035-3ec7-973dcb6a840a@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 12, 2022 at 10:23:12AM +0200, Hans de Goede wrote:
> On 10/11/22 19:40, Bjorn Helgaas wrote:
> > On Mon, Oct 10, 2022 at 05:02:06PM +0200, Hans de Goede wrote:
> >> Clevo NL4XLU barebones have the same E820 reservation covering
> >> the entire _CRS 32-bit window issue as the Lenovo *IIL* and
> >> Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):
> >> ...
> >> Add a no_e820 quirk for these models to fix the touchpad not working
> >> (due to Linux being unable to assign a PCI BAR for the i2c-controller).
> > 
> > I do plan to apply this, but a little food for thought below.
> > 
> > I explored this issue a little bit with the ACPI/UEFI folks (see
> > https://members.uefi.org/wg/aswg/mail/thread/9265 if you have access).  
> > 
> > One aspect I had glossed over earlier is that on most recent machines,
> > the "E820 map" Linux uses is actually constructed internally by Linux
> > based on the UEFI memory map, and that construction conflates several
> > EFI types into E820_TYPE_RESERVED; see
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/x86-stub.c?id=v5.19#n576

Critical error on my part here: the E820 map is passed to Linux by the
bootloader or the EFI stub, NOT constructed by Linux.

> > From a response in the ACPI/UEFI discussion:
> > 
> >   The reason EfiMemoryMappedIO[1] exist in the UEFI memory map is to
> >   request a virtual mapping for UEFI Runtime Services.
> >   ...
> >   Thus the EfiMemoryMappedIO entries just exist to pass up the
> >   EFI_MEMORY_RUNTIME attribute in the UEFI Memory Map. This is the part
> >   of the contract for UEFI Runtime Service to use virtual mappings
> >   provided by the OS. So from an OS point of view EfiMemoryMappedIO has
> >   no other purpose.
> >   
> >   [1] UEFI: Table 7-5 Memory Type Usage before ExitBootServices() "Used
> >   by system firmware to request that a memory-mapped IO region be
> >   mapped by the OS to a virtual address so it can be accessed by EFI
> >   runtime services."

> > I'm a little leery of changing that UEFI->E820 conversion because of
> > other possible implications, but it may be that omitting
> > EfiMemoryMappedIO entries from the E820 map and keeping the original
> > "avoid E820 regions" (4dc2287c1805) would also solve this problem.
> 
> Actually during my many attempts to fix this I did write a patch
> adding a new E820_TYPE_MMIO to the generated e820-memmap which
> would only show up in the EFI -> E820 entry generation case
> and then used that to not exclude that E820 region, see
> this RFC series:
> 
> https://lore.kernel.org/linux-pci/20220214151759.98267-1-hdegoede@redhat.com/

Yes :)  I tried something similar and of course it didn't work because
it didn't change the E820 map coming from the bootloader.

> I also did another series which used the EfiMemoryMappedIO type as
> an input to heuristics to automatically set pci=no_e820, see:
> 
> https://lore.kernel.org/linux-pci/20220228105259.230903-1-hdegoede@redhat.com/
> 
> IIRC that patch eventually got replaced by a similar but simpler
> heuristic from you. Which IIRC eventually got dropped again because
> it was causing regressions on some models again.
> 
> So we ended up with the current set pci=no_e820 using DMI based quirks +
> try to enable it for all BIOS-es with date >= 2023 approach,
> with the plan to do DMI quirks setting pci=use_e820 if any (buggy)
> 2023 BIOS-es show up which need this.

I gave up on figuring out what went wrong in this path.

Anyway, I've had the patch below in -next for a couple weeks, but I
plan to drop it and replace it with the series here:
https://lore.kernel.org/linux-pci/20221202211838.1061278-1-helgaas@kernel.org/

Bjorn

> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  arch/x86/pci/acpi.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> >> index 2f82480fd430..45ef65d31a40 100644
> >> --- a/arch/x86/pci/acpi.c
> >> +++ b/arch/x86/pci/acpi.c
> >> @@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
> >>  			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> >>  		},
> >>  	},
> >> +
> >> +	/*
> >> +	 * Clevo NL4XLU barebones have the same E820 reservation covering
> >> +	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
> >> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
> >> +	 */
> >> +	{
> >> +		.callback = set_no_e820,
> >> +		.ident = "Clevo NL4XLU Barebone",
> >> +		.matches = {
> >> +			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
> >> +		},
> >> +	},
> >>  	{}
> >>  };
> >>  
> >> -- 
> >> 2.37.3
> >>
> > 
> 
