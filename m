Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5904B77D1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 21:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbiBORVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 12:21:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiBORVO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 12:21:14 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7341D315;
        Tue, 15 Feb 2022 09:21:04 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id o19so57921565ybc.12;
        Tue, 15 Feb 2022 09:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC73NoewyQZLFmEe3kZ6ovOMbujHh+xwQW66fTjFghM=;
        b=Rk3XsczuU9pZdjdbJcQysKu3NnZdQtDjP8U1h4nhocsoX6gNS1A0X5LLcsqCXqvrsV
         CacL75wEg8hkJfGPEfIJjDu6BCIQnzgOxKHF/FfKXSQoVRQQHk0hea8PBErfe29YyRI5
         uP/HcBTl75GOatkNYmJDpVliqVzK8udlsGwb3thN+ifGd9+NW7G3S0e2JWeADH5jmrGk
         s3XVF/JfDNkh4Bkl/PHZfOu4KY91W/2dQu/PFJCCkWxZOktf96tpH/IR2upzHx4KbOlI
         mMANGot8nJaZdA0K5FaanpZHVaCM9VJrpnNtxS2Y5MpmLt88OksrnUzSX4pIN+B5QQbI
         RPtA==
X-Gm-Message-State: AOAM533QCe2v88iWXFK1/YnZi/BTOTqgUJYqPGiS/1xkXcPcPH76VK9e
        /LMXqVWGWxuMyHuYpWD1/JsX2JKBakOPe3/MqwQ=
X-Google-Smtp-Source: ABdhPJyumJDmiiJXNP6kejIKT1H8Hap2mV31nxKpsXlBb5GpX3LVPHU7UIjrPu1aHpP9hhGMQnrlGHWXnd1ho6SzHdw=
X-Received: by 2002:a81:1290:: with SMTP id 138mr2179197yws.19.1644945664017;
 Tue, 15 Feb 2022 09:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20220214151759.98267-1-hdegoede@redhat.com> <05332ea8-2849-e567-1db3-3bdee97c2193@redhat.com>
In-Reply-To: <05332ea8-2849-e567-1db3-3bdee97c2193@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 18:20:53 +0100
Message-ID: <CAJZ5v0ieyKDzwPUZwfcznhABmM24fm3U7Pzea7tBoaCs9hKizw@mail.gmail.com>
Subject: Re: [RFC 0/2] x86/PCI: Ignore EFI memmap MMIO entries
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

On Tue, Feb 15, 2022 at 5:12 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> On 2/14/22 16:17, Hans de Goede wrote:
> > Hi All,
> >
> > Here is a new attempt at fixing the issue where on some laptops
> > there are EFI memmap MMIO entries covering the entire PCI bridge
> > mem window, causing Linux to be unable to find free space to
> > assign to unassigned BARs.
> >
> > This is marked as RFC atm because I'm waiting for feedback from
> > testers.
>
> Unfortunately the troublesome 0xdfa00000-0xdfa0ffff region on
> the Lenovo X1 carbon gen 2 is marked as MMIO by the EFI memmap,
> so the approach from this series won't work.
>
> Interestingly enough this RFC series does seem to help to fix
> the suspend/resume on this x1c2, since for some reason merely
> splitting the original:
>
> BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>
> range into:
>
> BIOS-e820: [mem 0x00000000dceff000-0x00000000df9fffff] reserved
> BIOS-e820: [mem 0x00000000dfa00000-0x00000000dfa0ffff] MMIO
>
> causes the PCI resource allocation code to pick slightly
> different resources avoiding the troublesome overlap, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> for logs.
>
> But I don't think we should rely in this, since from a
> arch_remove_reservations() pov the troublesome overlap area
> which is now marked as MMIO is fair game for PCI bars with
> the change to allow MMIO areas for PCI bars, so things seem
> to mostly work by sheer luck after this RFC series.
>
> So now I have yet another plan to fix this (see below) I'll get
> that tested and assuming it works post that as a proper patch.
>
> Regards,
>
> Hans
>
>
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 490411dba438..573e1323f490 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -64,6 +64,8 @@ void pcibios_scan_specific_bus(int busn);
>
>  /* pci-irq.c */
>
> +struct pci_dev;
> +
>  struct irq_info {
>         u8 bus, devfn;                  /* Bus, device and function */
>         struct {
> @@ -232,3 +234,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
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
> index 052f1d78a562..7167934819b3 100644
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
> @@ -291,6 +293,28 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
>                 res->start == 0xCF8 && res->end == 0xCFF;
>  }
>
> +static bool resource_matches_efi_mmio_region(const struct resource *res)

I would call this resource_is_efi_mmio() FWIW.

> +{
> +       unsigned long long start, end;
> +       efi_memory_desc_t *md;
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
> @@ -300,9 +324,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>
>         status = acpi_pci_probe_root_resources(ci);
>         if (pci_use_crs) {
> -               resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
> +               resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>                         if (resource_is_pcicfg_ioport(entry->res))
>                                 resource_list_destroy_entry(entry);
> +                       if (resource_matches_efi_mmio_region(entry->res)) {

I would add a pci_use_e820 check to this.

> +                               dev_info(&device->dev,
> +                                       "host bridge window %pR is marked by EFI as MMIO\n",
> +                                       entry->res);
> +                               pci_use_e820 = false;
> +                       }
> +               }
>                 return status;
>         }

Overall, it looks reasonable to me.
