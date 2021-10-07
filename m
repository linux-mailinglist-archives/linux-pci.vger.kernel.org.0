Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2142587C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhJGQ52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 12:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhJGQ52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 12:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B38C161245;
        Thu,  7 Oct 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633625734;
        bh=ZXU51Cc2I0trn9FmL/4F0sRgE4s/aXbfO2rKPjVmzNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qaW2xFZyQ0BjObzKfkl7QgPiyN5hl/4X07ePvni8HeFnZLsElRk0puucBqAc1Ipuk
         GaXdaCq762Db6KXC4TI4MojsvzBPnc+UaP82wKlKk3+jqp7L2WO8Cz/3gOQKPZEEY7
         nmsdgGDwXjMgm6ABGxLZaJxV/vqALkn+ZQEKruPx+jlNdummPUyiiglVVzs/w38QsS
         YJk5KXFQ2CKD4CoLbt+84FwS4/LO3VNGb6dPqeAQUsv872NIfroUz79oi5a/+U58PM
         one6cAK63ZEyvwHy/+FjdpAf3QAVk1shcT293kiRCYtMHWZJjj0f/LsRlcWm7I1m+L
         thNSrhYg5l2hw==
Date:   Thu, 7 Oct 2021 11:55:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hui.wang@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] x86/PCI: Add pci=no_e820 cmdline option to ignore E820
 reservations for bridge windows
Message-ID: <20211007165532.GA1241708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005150956.303707-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Hui, Rafael, Myron; this looks like the same issue Hui encountered:
https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com]

On Tue, Oct 05, 2021 at 05:09:56PM +0200, Hans de Goede wrote:
> Some BIOS-es contain a bug where they add addresses which map to system RAM
> in the PCI bridge memory window returned by the ACPI _CRS method, see
> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space").
> 
> To avoid this Linux by default excludes E820 reservations when allocating
> addresses since 2010. Windows however ignores E820 reserved regions for PCI
> mem allocations, instead it avoids these BIOS bugs by allocates addresses
> top-down.
> 
> Recently (2020) some systems have shown-up with E820 reservations which
> cover the entire _CRS returned PCI bridge memory window, causing all
> attempts to assign memory to PCI bars which have not been setup by the BIOS
> to fail. For example here are the relevant dmesg bits from a
> Lenovo IdeaPad 3 15IIL 81WE:
> 
> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> 
> Add a pci=no_e820 option which allows disabling the E820 reservations
> check, while still honoring the _CRS provided resources.
> 
> And automatically enable this on the "Lenovo IdeaPad 3 15IIL05" to fix
> the touchpad not working on this laptop.
> 
> Also add a pci=use_e820 option to allow overruling the results of
> DMI quirks defaulting to no_e820 on some systems.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279

Probably the same issue (from Hui's patch):

  BugLink: http://bugs.launchpad.net/bugs/1931715
  BugLink: http://bugs.launchpad.net/bugs/1932069
  BugLink: http://bugs.launchpad.net/bugs/1921649

I think 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space") was a mistake (my fault!).

The relationship between E820 and ACPI _CRS is not really very clear.
ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:

  This range of addresses is in use or reserved by the system and is
  not to be included in the allocatable memory pool of the operating
  system's memory manager.

and it may be used when:

  The address range is in use by a memory-mapped system device.

Furthermore, sec 15.2 says:

  Address ranges defined for baseboard memory-mapped I/O devices, such
  as APICs, are returned as reserved.

I think a PCI host bridge qualifies as a baseboard memory-mapped I/O
device, and its apertures are in use and certainly should not be
included in the general allocatable pool, so the fact that this BIOS
reports the PCI aperture as "reserved" in E820 doesn't seem like a
bug.

So I think I made a mistake in 4dc2287c1805 by excluding E820 regions.
Of course, if we don't exclude them, it still leaves the issue on Dell
systems that 4dc2287c1805 addressed.  There we had:

  BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
  pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]

but PCI devices placed at 0xbff00000 don't work.  I think this case IS
a clear BIOS bug because _CRS gave us a faulty window.  4dc2287c1805
worked around it by trimming off the 0xbff00000-0xc0000000 piece based
on the E820 reservation.

So what to do?  4dc2287c1805 made a generic change for a BIOS bug.
This patch makes a quirk-based change for what I think is *not* a BIOS
bug.  That seems backwards, and I'm afraid quirks will be impractical
because we already have a pretty big list:

  Lenovo Ideapad S145   # Launchpad 1931715, 1921649
  Lenovo Ideapad BS145  # Launchpad 1932069
  Lenovo Ideapad 5      # Launchpad 1878279
  Lenovo Ideapad 3      # Launchpad 1878279 #27 #88, 1880172
  Lenovo Ideapad Slim 7 # Launchpad 1878279 #89
  Lenovo V15-IIL        # Launchpad 1878279 #119

I think we should figure out a better approach than 4dc2287c1805 for
working around the Dell BIOS bugs, but I don't have any great ideas.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/x86/include/asm/pci_x86.h | 10 ++++++++++
>  arch/x86/kernel/resource.c     | 17 +++++++++++++++++
>  arch/x86/pci/acpi.c            | 26 ++++++++++++++++++++++++++
>  arch/x86/pci/common.c          |  6 ++++++
>  4 files changed, 59 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 490411dba438..e45d661f81de 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -39,6 +39,8 @@ do {						\
>  #define PCI_ROOT_NO_CRS		0x100000
>  #define PCI_NOASSIGN_BARS	0x200000
>  #define PCI_BIG_ROOT_WINDOW	0x400000
> +#define PCI_USE_E820		0x800000
> +#define PCI_NO_E820		0x1000000
>  
>  extern unsigned int pci_probe;
>  extern unsigned long pirq_table_addr;
> @@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
>  
>  /* pci-irq.c */
>  
> +struct pci_dev;
> +
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
> +#define pci_use_e820 false
> +#endif
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 9b9fb7882c20..6069d86021f0 100644
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
> @@ -23,11 +24,27 @@ static void resource_clip(struct resource *res, resource_size_t start,
>  		res->start = end + 1;
>  }
>  
> +/*
> + * Some BIOS-es contain a bug where they add addresses which map to system RAM
> + * in the PCI bridge memory window returned by the ACPI _CRS method, see
> + * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
> + * To avoid this Linux by default excludes E820 reservations when allocating
> + * addresses since 2010. Windows however ignores E820 reserved regions for PCI
> + * mem allocations, instead it avoids these BIOS bugs by allocates addresses
> + * top-down.
> + * Recently (2020) some systems have shown-up with E820 reservations which
> + * cover the entire _CRS returned PCI bridge memory window, causing all
> + * attempts to assign memory to PCI bars which have not been setup by the BIOS
> + * to fail. The pci_use_e820 check is there as a workaround for these systems.
> + */
>  static void remove_e820_regions(struct resource *avail)
>  {
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
> index 948656069cdd..4fc95f5308e3 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -21,6 +21,8 @@ struct pci_root_info {
>  
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg = false;
> +/* Consumed in arch/x86/kernel/resource.c */
> +bool pci_use_e820 = true;
>  
>  static int __init set_use_crs(const struct dmi_system_id *id)
>  {
> @@ -34,6 +36,12 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
>  	return 0;
>  }
>  
> +static int __init set_no_e820(const struct dmi_system_id *id)
> +{
> +	pci_use_e820 = false;
> +	return 0;
> +}
> +
>  static int __init set_ignore_seg(const struct dmi_system_id *id)
>  {
>  	printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
> @@ -135,6 +143,16 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
>  		},
>  	},
> +	/* https://bugzilla.redhat.com/show_bug.cgi?id=1868899 */
> +	{
> +		.callback = set_no_e820,
> +		.ident = "Lenovo IdeaPad 3 15IIL05",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "81WE"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad 3 15IIL05"),
> +		},
> +	},
>  	{}
>  };
>  
> @@ -160,6 +178,14 @@ void __init pci_acpi_crs_quirks(void)
>  	       "if necessary, use \"pci=%s\" and report a bug\n",
>  	       pci_use_crs ? "Using" : "Ignoring",
>  	       pci_use_crs ? "nocrs" : "use_crs");
> +
> +	if (pci_probe & PCI_NO_E820)
> +		pci_use_e820 = false;
> +	else if (pci_probe & PCI_USE_E820)
> +		pci_use_e820 = true;
> +
> +	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> +	       pci_use_e820 ? "Honoring" : "Ignoring");
>  }
>  
>  #ifdef	CONFIG_PCI_MMCONFIG
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 3507f456fcd0..091ec7e94fcb 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
>  	} else if (!strcmp(str, "nocrs")) {
>  		pci_probe |= PCI_ROOT_NO_CRS;
>  		return NULL;
> +	} else if (!strcmp(str, "use_e820")) {
> +		pci_probe |= PCI_USE_E820;
> +		return NULL;
> +	} else if (!strcmp(str, "no_e820")) {
> +		pci_probe |= PCI_NO_E820;
> +		return NULL;
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  	} else if (!strcmp(str, "big_root_window")) {
>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
> -- 
> 2.31.1
> 
