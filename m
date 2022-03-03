Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF44CB413
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiCCAls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 19:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCCAls (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 19:41:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE26245;
        Wed,  2 Mar 2022 16:41:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666C9B822BC;
        Thu,  3 Mar 2022 00:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA44FC004E1;
        Thu,  3 Mar 2022 00:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646268060;
        bh=f1wXkjavZEegdLfZM4+Xjf3Xoe2Bhm05K6wqA9b6Vaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S1RT3v0UaUujRv1Yo/V8f5WAS0Kh0QTn9tTmTUPlRA02l0jwYc/IduShkADWXalHZ
         Imj2Zt7tmM3JtwzJt11cqBUXHg0xwJK+y84qMXFj/OfPTuKumw/npEGT+/zJ26FHVu
         MdA+KT0rtCa9mzXU4m0s6P+iRcq5DQIxSr5k+AOTXIAojv57AgUNSZWCWp0ROl2B/v
         2RpMjghGwLJstsG/VLhsUvsxYzIWhYoHzg3Fz/j16PUppFhMFh6X+ipogI5b29EbCb
         x+uAM8usATGHUZWqynyqIHwGhCBmFUYoLWggtURsJcZFk5Rtuf6DPxHQHZmzGjwSII
         5Kxvac1ktatww==
Date:   Wed, 2 Mar 2022 18:40:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Disable exclusion of E820 reserved addressed
 in some cases
Message-ID: <20220303004058.GA610543@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228105259.230903-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 11:52:59AM +0100, Hans de Goede wrote:

I know Rafael has already applied this, but I'm still trying to
understand this because it looks like a very complicated maintenance
problem.

> Some fw has a bug where the PCI bridge window returned by the ACPI
> resources partly overlaps with some other address range, causing issues.
> To workaround this Linux excludes E820 reserved addresses when allocating
> addresses from the PCI bridge window. 2 known examples of such fw bugs are:
>
> 1. The returned window contains addresses which map to system RAM,
> see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
> address space").

Bug report is https://bugzilla.kernel.org/show_bug.cgi?id=16228
First dmesg log https://bugzilla.kernel.org/attachment.cgi?id=26811
shows:

  BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
  pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]
  pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
  pci 0000:00:1f.2: BAR 5: assigned [mem 0xbff00000-0xbff007ff]
  ahci 0000:00:1f.2: controller reset failed (0xffffffff)
  ahci 0000:00:1f.2: failed to stop engine (-5)

The problem is that _CRS advertises [mem 0xbff00000-0xdfffffff], and
we assigned [mem 0xbff00000-0xbff007ff] to 00:1f.2, but
0xbff00000-0xbfffffff is not usable for PCI devices.  My guess is that
it contains host bridge registers, but all we really know is that it
doesn't work.

I think the _CRS that includes non-usable space is clearly a BIOS
defect.

The fix from 4dc2287c1805 was to avoid that region based on the
0xbfe4dc00-0xc0000000 E820 entry, and the result is in
https://bugzilla.kernel.org/attachment.cgi?id=30662:

  BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
  pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xf7ffffff]
  pci_root PNP0A03:00: host bridge window [mem 0xff980000-0xff980fff]
  pci 0000:00:1f.2: reg 24: [mem 0xff970000-0xff9707ff]   # BAR 5
  pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
  pci 0000:00:1f.2: BAR 5: assigned [mem 0xff980800-0xff980fff]

The patch below doesn't affect this workaround.

> 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
> reserved range and the ACPI provided PCI bridge window:
>  efi: mem46: [MMIO] range=              [0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>  BIOS-e820:                         [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>  pci_bus 0000:00: root bus resource [mem         0xdfa00000-        0xfebfffff window]
> If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
> then the system fails to resume after a suspend.

I think this is from https://bugzilla.redhat.com/show_bug.cgi?id=2029207

If I understand correctly, the log in comment 23 from Ivan
(https://bugzilla.redhat.com/attachment.cgi?id=1859801) is a
case where resume doesn't work:

  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
  pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff]

And the log in comment 38, also from Ivan,
(https://bugzilla.redhat.com/attachment.cgi?id=1861539) is a case
where resume *does* work:

  BIOS-e820: [mem 0x00000000dcf00000-0x00000000dfa0ffff] reserved
  efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
  pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]

_CRS advertises [mem 0xdfa00000-0xfebfffff], but when we assign the
0xdfa00000-0xdfafffff region to the 00:1c.0 MMIO window, resume fails.

I don't see a theory about what the root cause is.  It's possible this
is similar to case 1 above, where _CRS is defective.  But here we're
only assigning the 00:1c.0 MMIO window, and 00:1c.0 is a bridge to
[bus 02], and there are no devices on bus 02.  There should be no
transactions that use that MMIO window, so it's not clear why this
should matter.

If this is a _CRS defect similar to case 1, it's possible there are
host bridge registers in 0xdfa00000-0xdfafffff, and BIOS might use
those during resume, and assigning that area to the 00:1c.0 MMIO
window might interfere with that.  But that's a lot of speculation.

If you have a good Lenovo contact, they might be able to confirm or
deny this.

I'm missing some things here that should be obvious; can you help me
out?

  - Why did the 4dc2287c1805 workaround not apply here?  The E820
    region overlaps the _CRS window just like in case 1, so why did we
    assign 0xdfa00000?

  - How does this patch work around the problem?  This patch checks if
    a host bridge window is completely contained in an EFI MMIO
    region, but I don't see such an EFI region here.

It might be interesting to poke around in the 0xdfa00000-0xdfafffff
range.  For example, if Ivan tried things like this, it's possible
we'd find something we could identify as registers:

  # ./rdwrmem -b 4 -m -s 0xdfa00000 -l 256
  # ./rdwrmem -b 4 -m -s 0xdfa40000 -l 256
  # ./rdwrmem -b 4 -m -s 0xdfa80000 -l 256
  # ./rdwrmem -b 4 -m -s 0xdfac0000 -l 256

This tool is from https://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c

> Recently (2019) some systems have shown-up with EFI memmap MMIO entries
> covering the entire ACPI provided PCI bridge window. These memmap entries
> get converted into e820_table entries, causing all attempts to assign
> memory to PCI BARs which have not been setup by the BIOS to fail.
> For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
>  efi: mem63: [MMIO] range=              [0x0000000065400000-0x00000000cfffffff] (1708MB)
>  BIOS-e820:                         [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem         0x65400000-        0xbfffffff window]
>  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> 
> To fix this, check if the ACPI provided PCI bridge window is fully
> contained within in EFI memmap MMIO region and in that case disable
> the "exclude E820 reserved addresses" workaround, fixing the problem
> of not being able to find free space for unassigned BARs.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> BugLink: https://bugs.launchpad.net/bugs/1878279
> BugLink: https://bugs.launchpad.net/bugs/1931715
> BugLink: https://bugs.launchpad.net/bugs/1932069
> BugLink: https://bugs.launchpad.net/bugs/1921649
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add a couple of missing includes to arch/x86/include/asm/pci_x86.h
>   to fix i386 build errors Reported-by: kernel test robot <lkp@intel.com>
> - Do not call resource_is_efi_mmio_region() on resource-list entries which
>   have just been destroyed because they match resource_is_pcicfg_ioport()
>   Reported-by: kernel test robot <oliver.sang@intel.com>
> - Add (res->flags & IORESOURCE_MEM) check to resource_is_efi_mmio_region()
> ---
>  arch/x86/include/asm/pci_x86.h | 10 +++++
>  arch/x86/kernel/resource.c     |  4 ++
>  arch/x86/pci/acpi.c            | 68 +++++++++++++++++++++++++++++++++-
>  3 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 490411dba438..4ce61ab01a4f 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -5,7 +5,9 @@
>   *	(c) 1999 Martin Mares <mj@ucw.cz>
>   */
>  
> +#include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/spinlock.h>
>  
>  #undef DEBUG
>  
> @@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
>  
>  /* pci-irq.c */
>  
> +struct pci_dev;

Both the above look like fixes to an unrelated asm/pci_x86.h
problem that happened to be exposed by including it in
arch/x86/kernel/resource.c.  Most users of asm/pci_x86.h
include linux/pci.h first, which covers up the problem.

>  struct irq_info {
>  	u8 bus, devfn;			/* Bus, device and function */
>  	struct {
> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>  # define x86_default_pci_init_irq	NULL
>  # define x86_default_pci_fixup_irqs	NULL
>  #endif
> +
> +#if defined CONFIG_PCI && defined CONFIG_ACPI
> +extern bool pci_use_e820;
> +#else
> +#define pci_use_e820 true
> +#endif
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 9b9fb7882c20..e8dc9bc327bd 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/ioport.h>
>  #include <asm/e820/api.h>
> +#include <asm/pci_x86.h>
>  
>  static void resource_clip(struct resource *res, resource_size_t start,
>  			  resource_size_t end)
> @@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
>  	int i;
>  	struct e820_entry *entry;
>  
> +	if (!pci_use_e820)
> +		return;
> +
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		entry = &e820_table->entries[i];
>  
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 052f1d78a562..fce05e03ba9e 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/init.h>
> @@ -21,6 +22,7 @@ struct pci_root_info {
>  
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg;
> +bool pci_use_e820 = true;
>  
>  static int __init set_use_crs(const struct dmi_system_id *id)
>  {
> @@ -291,6 +293,63 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
>  		res->start == 0xCF8 && res->end == 0xCFF;
>  }
>  
> +/*
> + * Some fw has a bug where the PCI bridge window returned by the ACPI resources
> + * partly overlaps with some other address range, causing issues. To workaround
> + * this Linux excludes E820 reserved addresses when allocating addresses from
> + * the PCI bridge window. 2 known examples of such firmware bugs are:
> + *
> + * 1. The returned window contains addresses which map to system RAM, see
> + * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
> + *
> + * 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
> + * reserved range and the ACPI provided PCI bridge window:
> + *  efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
> + *  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
> + *  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> + * If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
> + * then the system fails to resume after a suspend.
> + *
> + * Recently (2019) some systems have shown-up with EFI memmap MMIO entries
> + * covering the entire ACPI provided PCI bridge window. These memmap entries
> + * get converted into e820_table entries, causing all attempts to assign
> + * memory to PCI BARs which have not been setup by the BIOS to fail.
> + * For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
> + *  efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
> + *  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> + *  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> + *  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> + *  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> + *
> + * To code below checks if the ACPI provided PCI bridge window is fully
> + * contained within in EFI memmap MMIO region and in that case disables
> + * the "exclude E820 reserved addresses" workaround to avoid this issue.
> + */
> +static bool resource_is_efi_mmio_region(const struct resource *res)
> +{
> +	unsigned long long start, end;
> +	efi_memory_desc_t *md;
> +
> +	if (!(res->flags & IORESOURCE_MEM))
> +		return false;
> +
> +	if (!efi_enabled(EFI_MEMMAP))
> +		return false;
> +
> +	for_each_efi_memory_desc(md) {
> +		if (md->type != EFI_MEMORY_MAPPED_IO)
> +			continue;
> +
> +		start = md->phys_addr;
> +		end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
> +
> +		if (res->start >= start && res->end <= end)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  {
>  	struct acpi_device *device = ci->bridge;
> @@ -300,9 +359,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  
>  	status = acpi_pci_probe_root_resources(ci);
>  	if (pci_use_crs) {
> -		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
> +		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>  			if (resource_is_pcicfg_ioport(entry->res))
>  				resource_list_destroy_entry(entry);
> +			else if (resource_is_efi_mmio_region(entry->res)) {
> +				dev_info(&device->dev,
> +					"host bridge window %pR is marked by EFI as MMIO\n",
> +					entry->res);
> +				pci_use_e820 = false;

This message suggests that marking the host bridge window as MMIO in
EFI is a defect, or at least something unusual and worthy of being
flagged.  But I think it's perfectly legal.

UEFI v2.8, sec 7.2, says EfiMemoryMappedIO means:

  Used by system firmware to request that a memory-mapped IO region be
  mapped by the OS to a virtual address so it can be accessed by EFI
  runtime services.


> +			}
> +		}
>  		return status;
>  	}
>  
> -- 
> 2.35.1
> 
