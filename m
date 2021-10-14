Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F142D81E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhJNL0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 07:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhJNL0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 07:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634210667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPRIOFVHOX7he1jSqwslJXf29i8yYE1ZatBZ4ZEv92k=;
        b=LnBQQ5yvKD0s3U38X2q0F51PSzCHI7Es+7wcJznRdKJkZ1phxY55fM6rjguXu4Ot1J4DB4
        IgGLrIEvctAezgy+CMCzobDdL7MxfQqKtm74hcRIYy9IzP40u4BqXJRRJ82W1NLzRbuBT6
        VljE5y5xcul9bMzXm0DDSy5uf9SP0qg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-5kWyTriYODmvZLEiTPaxTg-1; Thu, 14 Oct 2021 07:24:26 -0400
X-MC-Unique: 5kWyTriYODmvZLEiTPaxTg-1
Received: by mail-ed1-f70.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so4908318edb.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Oct 2021 04:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LPRIOFVHOX7he1jSqwslJXf29i8yYE1ZatBZ4ZEv92k=;
        b=IJwZtlSF2S84qJlmzdxER/lR7vLIOJxWCyJMZd4RtRTvDSz7RWc42X6HdDJ8sp96Dx
         +1mLJqz2hvIigkJ+tb7y9BOjpMXZeok2JiKFf20qSo59Wbc6KK899pgJcnUGEAXdLOOL
         oxqAlolbaimk1aajBMay1wxeYKsxHB878TWWI4BOUEnxGEKRDGqFi7EW64ZC9KQXEpLp
         g5rdHykQs/5l+Y7x4KjjEpLHjjcxyOTGErvnTU6ZNaK/lG1a4qCc6ll3NjZGjNdgutQ6
         Q7wb3GJ9cbpNeHk8DosD52/Fg7GjR24G0gFjSKS9jOTd6TNEvzx3ElAWEGm+tjTAIKJL
         SZvQ==
X-Gm-Message-State: AOAM530ED+3RUB4Xumcjnb242lvaNnOnr19weeaiZLTxNBXDS8zLpSU2
        kMikfeEdlH1VhNOFciwZK/s9Q8sBM0fx9MYXHZMm1pk5SvHqj6g5LCqhUMk85f08yuWG36C7ZGv
        I3zHyoizmNYtoN8RG/3QP
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr7778378edz.215.1634210664967;
        Thu, 14 Oct 2021 04:24:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza3Loi8vzUt6vxJHsEEpBV8wwBsxVZpMwQDd7chPzHr++H+3aIpEkKvCZdW3WN4px1lhKmQA==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr7778342edz.215.1634210664705;
        Thu, 14 Oct 2021 04:24:24 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c1e-bf00-6fd7-b500-c1ca-784d.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:6fd7:b500:c1ca:784d])
        by smtp.gmail.com with ESMTPSA id d3sm1755865ejb.35.2021.10.14.04.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 04:24:24 -0700 (PDT)
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <20211014110357.17957-1-hdegoede@redhat.com>
 <CAJZ5v0hiQXhLs4Y2ij_8YaVupmWYdTEYBpJLFg1CPk6RocP1_A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <22c25ecc-c43e-53e6-0aa1-51e548406363@redhat.com>
Date:   Thu, 14 Oct 2021 13:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hiQXhLs4Y2ij_8YaVupmWYdTEYBpJLFg1CPk6RocP1_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 14-10-2021 13:14, Rafael J. Wysocki wrote:
> On Thu, Oct 14, 2021 at 1:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some BIOS-es contain a bug where they add addresses which map to system RAM
>> in the PCI bridge memory window returned by the ACPI _CRS method, see
>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>> space").
>>
>> To avoid this Linux by default excludes E820 reservations when allocating
>> addresses since 2010. Windows however ignores E820 reserved regions for PCI
>> mem allocations, so in hindsight Linux honoring them is a problem.
>>
>> Recently (2020) some systems have shown-up with E820 reservations which
>> cover the entire _CRS returned PCI bridge memory window, causing all
>> attempts to assign memory to PCI BARs which have not been setup by the
>> BIOS to fail. For example here are the relevant dmesg bits from a
>> Lenovo IdeaPad 3 15IIL 81WE:
>>
>>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>> Ideally Linux would fully stop honoring E820 reservations for PCI mem
>> allocations, but then the old systems this was added for will regress.
>> Instead keep the old behavior for old systems, while ignoring the E820
>> reservations like Windows does for any systems from now on.
>>
>> Old systems are defined here as BIOS year < 2018, this was chosen to
>> make sure that pci_use_e820 will not be set on the currently affected
>> systems, while at the same time also taking into account that the
>> systems for which the E820 checking was originally added may have
>> received BIOS updates for quite a while (esp. CVE related ones),
>> giving them a more recent BIOS year then 2010.
>>
>> Also add pci=no_e820 and pci=use_e820 options to allow overriding
>> the BIOS year heuristic.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>> BugLink: https://bugs.launchpad.net/bugs/1878279
>> BugLink: https://bugs.launchpad.net/bugs/1931715
>> BugLink: https://bugs.launchpad.net/bugs/1932069
>> BugLink: https://bugs.launchpad.net/bugs/1921649
>> Cc: Benoit Grégoire <benoitg@coeus.ca>
>> Cc: Hui Wang <hui.wang@canonical.com>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you.

> with one tiny nit below.
> 
> Or please let me know if you want me to pick this up.

Since all of the changes are under arch/x86/ I expect the x86/tip
folks to pick this up ?

> 
>> ---
>> Changes in v3:
>> - Commit msg tweaks (drop dmesg timestamps, typo fix)
>> - Use "defined(CONFIG_...)" instead of "defined CONFIG_..."
>> - Add Mika's Reviewed-by
>>
>> Changes in v2:
>> - Replace the per model DMI quirk approach with disabling E820 reservations
>>   checking for all systems with a BIOS year >= 2018
>> - Add documentation for the new kernel-parameters to
>>   Documentation/admin-guide/kernel-parameters.txt
>> ---
>> Other patches trying to address the same issue:
>> https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com
>> https://lore.kernel.org/r/20200617164734.84845-1-mika.westerberg@linux.intel.com
>> V1 patch:
>> https://lore.kernel.org/r/20211005150956.303707-1-hdegoede@redhat.com
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>>  arch/x86/include/asm/pci_x86.h                | 10 +++++++
>>  arch/x86/kernel/resource.c                    |  4 +++
>>  arch/x86/pci/acpi.c                           | 29 +++++++++++++++++++
>>  arch/x86/pci/common.c                         |  6 ++++
>>  5 files changed, 55 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 43dc35fe5bc0..969cde5d74c8 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3949,6 +3949,12 @@
>>                                 please report a bug.
>>                 nocrs           [X86] Ignore PCI host bridge windows from ACPI.
>>                                 If you need to use this, please report a bug.
>> +               use_e820        [X86] Honor E820 reservations when allocating
>> +                               PCI host bridge memory. If you need to use this,
>> +                               please report a bug.
>> +               no_e820         [X86] ignore E820 reservations when allocating
>> +                               PCI host bridge memory. If you need to use this,
>> +                               please report a bug.
>>                 routeirq        Do IRQ routing for all PCI devices.
>>                                 This is normally done in pci_enable_device(),
>>                                 so this option is a temporary workaround
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 490411dba438..0bb4e7dd0ffc 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -39,6 +39,8 @@ do {                                          \
>>  #define PCI_ROOT_NO_CRS                0x100000
>>  #define PCI_NOASSIGN_BARS      0x200000
>>  #define PCI_BIG_ROOT_WINDOW    0x400000
>> +#define PCI_USE_E820           0x800000
>> +#define PCI_NO_E820            0x1000000
>>
>>  extern unsigned int pci_probe;
>>  extern unsigned long pirq_table_addr;
>> @@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
>>
>>  /* pci-irq.c */
>>
>> +struct pci_dev;
>> +
>>  struct irq_info {
>>         u8 bus, devfn;                  /* Bus, device and function */
>>         struct {
>> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>>  # define x86_default_pci_init_irq      NULL
>>  # define x86_default_pci_fixup_irqs    NULL
>>  #endif
>> +
>> +#if defined(CONFIG_PCI) && defined(CONFIG_ACPI)
>> +extern bool pci_use_e820;
>> +#else
>> +#define pci_use_e820 false
>> +#endif
>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>> index 9b9fb7882c20..e8dc9bc327bd 100644
>> --- a/arch/x86/kernel/resource.c
>> +++ b/arch/x86/kernel/resource.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <linux/ioport.h>
>>  #include <asm/e820/api.h>
>> +#include <asm/pci_x86.h>
>>
>>  static void resource_clip(struct resource *res, resource_size_t start,
>>                           resource_size_t end)
>> @@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
>>         int i;
>>         struct e820_entry *entry;
>>
>> +       if (!pci_use_e820)
>> +               return;
>> +
>>         for (i = 0; i < e820_table->nr_entries; i++) {
>>                 entry = &e820_table->entries[i];
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index 948656069cdd..6c2febe84b6f 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -21,6 +21,8 @@ struct pci_root_info {
>>
>>  static bool pci_use_crs = true;
>>  static bool pci_ignore_seg = false;
>> +/* Consumed in arch/x86/kernel/resource.c */
>> +bool pci_use_e820 = false;
>>
>>  static int __init set_use_crs(const struct dmi_system_id *id)
>>  {
>> @@ -160,6 +162,33 @@ void __init pci_acpi_crs_quirks(void)
>>                "if necessary, use \"pci=%s\" and report a bug\n",
>>                pci_use_crs ? "Using" : "Ignoring",
>>                pci_use_crs ? "nocrs" : "use_crs");
>> +
>> +       /*
>> +        * Some BIOS-es contain a bug where they add addresses which map to system
>> +        * RAM in the PCI bridge memory window returned by the ACPI _CRS method, see
>> +        * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
>> +        * To avoid this Linux by default excludes E820 reservations when allocating
>> +        * addresses since 2010. Windows however ignores E820 reserved regions for
>> +        * PCI mem allocations, so in hindsight Linux honoring them is a problem.
>> +        * In 2020 some systems have shown-up with E820 reservations which cover the
>> +        * entire _CRS returned PCI bridge memory window, causing all attempts to
>> +        * assign memory to PCI BARs to fail if Linux honors the E820 reservations.
>> +        *
>> +        * Ideally Linux would fully stop honoring E820 reservations for PCI mem
>> +        * allocations, but then the old systems this was added for will regress.
>> +        * Instead keep the old behavior for old systems, while ignoring the E820
>> +        * reservations like Windows does for any systems from now on.
>> +        */
>> +       if (year >= 0 && year < 2018)
>> +               pci_use_e820 = true;
>> +
>> +       if (pci_probe & PCI_NO_E820)
>> +               pci_use_e820 = false;
>> +       else if (pci_probe & PCI_USE_E820)
>> +               pci_use_e820 = true;
>> +
>> +       printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
>> +              pci_use_e820 ? "Honoring" : "Ignoring");
> 
> Why not pr_info()?

This file is using printk(KERN_... consistently everywhere. I'm just following
the existing style here. I very much dislike mixing styles in a single file. 

If we want to change this for this file then IMHO the right thing to do would
be a follow up patch changing all the printk-s at once.

Regards,

Hans



> 
>>  }
>>
>>  #ifdef CONFIG_PCI_MMCONFIG
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 3507f456fcd0..091ec7e94fcb 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
>>         } else if (!strcmp(str, "nocrs")) {
>>                 pci_probe |= PCI_ROOT_NO_CRS;
>>                 return NULL;
>> +       } else if (!strcmp(str, "use_e820")) {
>> +               pci_probe |= PCI_USE_E820;
>> +               return NULL;
>> +       } else if (!strcmp(str, "no_e820")) {
>> +               pci_probe |= PCI_NO_E820;
>> +               return NULL;
>>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>>         } else if (!strcmp(str, "big_root_window")) {
>>                 pci_probe |= PCI_BIG_ROOT_WINDOW;
>> --
> 

