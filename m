Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505974C8BA7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 13:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiCAMc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 07:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiCAMc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 07:32:27 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB739681F;
        Tue,  1 Mar 2022 04:31:46 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id w16so960975ybi.12;
        Tue, 01 Mar 2022 04:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaTIMLNruS+dxEOAlL7KpOrpDbigzmi7+nOXqPGN0d0=;
        b=UPHqb0ULs8BIO+yirWkjDRNjNBw6lVXlw7cUEdXIfSUMXz7cSBM9n8BzSf3WZK1RbC
         DOGJEazQ5E/COcdPVDlPk0XOIgQ4TJSereVH2FLEskLa8c/kyayrVnzsqfge6U2STRKY
         h5qvI0RlKzMm7m2inNAdA1lbs9HBlLWtaZ+HQRNrAFjUmr+qtVLGerQN/GacbuQedxO5
         N7YnvZVW9i/RR/qVU1ZyNHCR4iFTsIOcAFt8BtNHaALoRCe3+APedW+GcvFrUgSTBDZU
         DhJvOMepppRLjQbey0rZxpZ5j4SfiRvW0mrkmzZtN7n94ljvgaQpxbNMvI6MDlqr3sVT
         mK9w==
X-Gm-Message-State: AOAM531y/6AJoo9EVHd72uDRdmycPTQDiatR+fEJLOsTftgNB+4xbIuB
        KaJ0bnEuRy2lk6F5+xDIHuYRhVpKsgeUtlSH6u8zRFrJ
X-Google-Smtp-Source: ABdhPJypqno3PJ6US5bKKCGYfosOnQ1nI12x3AAT2mS3PXz99WpzKQsvGxwjyUCb1OOYQ/A2xL7JBZZ4SfAPU7o9oro=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr21733061ybe.365.1646137905624; Tue, 01
 Mar 2022 04:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20220228105259.230903-1-hdegoede@redhat.com> <20220228105259.230903-2-hdegoede@redhat.com>
In-Reply-To: <20220228105259.230903-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 13:31:34 +0100
Message-ID: <CAJZ5v0idYTBJV_NikVpF6hF6GOdWDjP3OUny4PqK7YD9t4MOqQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/PCI: Disable exclusion of E820 reserved addressed
 in some cases
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 28, 2022 at 11:55 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some fw has a bug where the PCI bridge window returned by the ACPI
> resources partly overlaps with some other address range, causing issues.
> To workaround this Linux excludes E820 reserved addresses when allocating
> addresses from the PCI bridge window. 2 known examples of such fw bugs are:
>
> 1. The returned window contains addresses which map to system RAM,
> see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
> address space").
>
> 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
> reserved range and the ACPI provided PCI bridge window:
>  efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
> then the system fails to resume after a suspend.
>
> Recently (2019) some systems have shown-up with EFI memmap MMIO entries
> covering the entire ACPI provided PCI bridge window. These memmap entries
> get converted into e820_table entries, causing all attempts to assign
> memory to PCI BARs which have not been setup by the BIOS to fail.
> For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
>  efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
>  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
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

Applied (subject fixed up), thanks!

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
>   *     (c) 1999 Martin Mares <mj@ucw.cz>
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
> +
>  struct irq_info {
>         u8 bus, devfn;                  /* Bus, device and function */
>         struct {
> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>  # define x86_default_pci_init_irq      NULL
>  # define x86_default_pci_fixup_irqs    NULL
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
>                           resource_size_t end)
> @@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
>         int i;
>         struct e820_entry *entry;
>
> +       if (!pci_use_e820)
> +               return;
> +
>         for (i = 0; i < e820_table->nr_entries; i++) {
>                 entry = &e820_table->entries[i];
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
>                 res->start == 0xCF8 && res->end == 0xCFF;
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
> +       unsigned long long start, end;
> +       efi_memory_desc_t *md;
> +
> +       if (!(res->flags & IORESOURCE_MEM))
> +               return false;
> +
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return false;
> +
> +       for_each_efi_memory_desc(md) {
> +               if (md->type != EFI_MEMORY_MAPPED_IO)
> +                       continue;
> +
> +               start = md->phys_addr;
> +               end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
> +
> +               if (res->start >= start && res->end <= end)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  {
>         struct acpi_device *device = ci->bridge;
> @@ -300,9 +359,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>
>         status = acpi_pci_probe_root_resources(ci);
>         if (pci_use_crs) {
> -               resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
> +               resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>                         if (resource_is_pcicfg_ioport(entry->res))
>                                 resource_list_destroy_entry(entry);
> +                       else if (resource_is_efi_mmio_region(entry->res)) {
> +                               dev_info(&device->dev,
> +                                       "host bridge window %pR is marked by EFI as MMIO\n",
> +                                       entry->res);
> +                               pci_use_e820 = false;
> +                       }
> +               }
>                 return status;
>         }
>
> --
> 2.35.1
>
