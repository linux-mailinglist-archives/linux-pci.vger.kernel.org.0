Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8099242DFE8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhJNRIf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 13:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233386AbhJNRIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 13:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634231189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkEo0g2D3Iide8EWMYtZgdJW1SeTeDXtu6MQ3b8t6EA=;
        b=KYaqSgrgYZSYYVXB+kF+9QLYDOtZdANKaI6c1pNUws0gaVP3qeYW2YAlb3Q35IJULi7okF
        uyXArSqEsKYGAAZHpDZP0TRGaRvVEcLQeXFDS5Ailo9o7uq0WFcklUK2z7FXYq+jEPz2QU
        0UzdSMf2daWu2spI0tN1JuXF+Pf/5k0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-DqIrIDwQPBWobrZy0-UPLA-1; Thu, 14 Oct 2021 13:06:27 -0400
X-MC-Unique: DqIrIDwQPBWobrZy0-UPLA-1
Received: by mail-ed1-f72.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso5771501edn.4
        for <linux-pci@vger.kernel.org>; Thu, 14 Oct 2021 10:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WkEo0g2D3Iide8EWMYtZgdJW1SeTeDXtu6MQ3b8t6EA=;
        b=ilUDqbLkteS3lxHCQM+Rp7H0EopFTmj+tWPkmInLMhfkPNrXqTyL6OgDwschYXu+Af
         My2ugBCJKmfO8BnnW5U5NAtocUJM0qmS9UqbSFc4ZYgFGoAuGa7iQmQABbVkb1Cgqfr9
         fN4sf2GPyhP6uwM76u7nJP/Vubl0YQnHvHZ5riq2ViAP53S+3QfzEjMYLu7zJUn63OuT
         BNVavzem5mA7vES3ovKDjB3yE18ia9PLriTDgi24/bEEboxTLvpL0Ct4weKjmeXeyxP5
         HKei7c5Z9KSRTGbIm3gPIt3Niw3Z+qpl4je67mdXJYUSNa2VF/hxO7ZySEglonAMm6eM
         kWnw==
X-Gm-Message-State: AOAM533LH+5/PGjP1oVTLSZFyYtuv+URzYgUS8a+PxEQMX8GCulb0PGo
        D4C5MlMtX5B2InQsY3Hg2jne2zBbmFjZO6xX1L2hIW5IsUi6zsVcsmxwzPVC8XvA0HZAJ9O7NvV
        4PysNopXD8J6ypir8xM40
X-Received: by 2002:a17:906:abd3:: with SMTP id kq19mr125566ejb.285.1634231186284;
        Thu, 14 Oct 2021 10:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgstQu/qRWXHs0pX3nR5Ux3cPgjmduXCXZOgiX8TmnOO+rCltjF10EB1pche+Kzw856l62gw==
X-Received: by 2002:a17:906:abd3:: with SMTP id kq19mr125510ejb.285.1634231185873;
        Thu, 14 Oct 2021 10:06:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t6sm2924197edj.27.2021.10.14.10.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 10:06:24 -0700 (PDT)
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <20211014154906.GA2029160@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <49405979-97c2-17ab-7deb-77c8d31092bb@redhat.com>
Date:   Thu, 14 Oct 2021 19:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211014154906.GA2029160@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On 10/14/21 5:49 PM, Bjorn Helgaas wrote:
> On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
>> Some BIOS-es contain a bug where they add addresses which map to system RAM
>> in the PCI bridge memory window returned by the ACPI _CRS method, see
>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>> space").
>>
>> To avoid this Linux by default excludes E820 reservations when allocating
>> addresses since 2010. Windows however ignores E820 reserved regions for PCI
>> mem allocations, so in hindsight Linux honoring them is a problem.
> 
> This is a problem not because Windows ignores E820, but because the
> spec does not support excluding based on E820.  We should cite the
> spec and include the relevant text here.

Ok, for v5 I will replace this with your info on the specs from this email:
https://lore.kernel.org/linux-pci/20211008110149.GA1313872@bhelgaas/T/#t

> 
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
>>  				please report a bug.
>>  		nocrs		[X86] Ignore PCI host bridge windows from ACPI.
>>  				If you need to use this, please report a bug.
>> +		use_e820	[X86] Honor E820 reservations when allocating
>> +				PCI host bridge memory. If you need to use this,
>> +				please report a bug.
>> +		no_e820		[X86] ignore E820 reservations when allocating
>> +				PCI host bridge memory. If you need to use this,
>> +				please report a bug.
> 
> Inconsistent capitalization.
> 
> Should use same terminology as nocrs, i.e., "PCI host bridge windows",
> not "PCI host bridge memory".
> 
> I don't think "Honor E820 reservations" is the right way to describe
> this.  It's not a question of upholding something we *should* be
> doing.  That would be a matter of working around a BIOS defect.
> Maybe something like this:
> 
>   Use E820 reservations to exclude parts of PCI host bridge windows.
>   This is a workaround for BIOS defects in host bridge _CRS methods.
>   If you need to use this, please report a bug to
>   linux-pci@vger.kernel.org so we can apply it automatically.

Ok, that works for me, I'll use the above text for v5.


> Not 100% sure we need "no_e820" since that should be the default.  But
> I guess it's conceivable some system might need it.  I just hate
> adding additional things for people to try and then spread the
> resulting misinformation as a "fix" on random forums.

no_e820 will be the default for BIOS-year >= 2018, but on older
systems my patch preserves the old behavior of use_e820.

So to allow people to easily test if no_e820 behavior helps on
older systems we need it.

I fully agree with your worry about 'misinformation as a "fix"
on random forums', but I don't have a solution for that.

I guess we could completely omit both cmdline options, but
that will make debugging issues a lot header. IMHO it is
worthwhile to have this options to allow users to quickly
test things when we ask them to do so.

> 
>>  		routeirq	Do IRQ routing for all PCI devices.
>>  				This is normally done in pci_enable_device(),
>>  				so this option is a temporary workaround
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 490411dba438..0bb4e7dd0ffc 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -39,6 +39,8 @@ do {						\
>>  #define PCI_ROOT_NO_CRS		0x100000
>>  #define PCI_NOASSIGN_BARS	0x200000
>>  #define PCI_BIG_ROOT_WINDOW	0x400000
>> +#define PCI_USE_E820		0x800000
>> +#define PCI_NO_E820		0x1000000
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
>>  	u8 bus, devfn;			/* Bus, device and function */
>>  	struct {
>> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>>  # define x86_default_pci_init_irq	NULL
>>  # define x86_default_pci_fixup_irqs	NULL
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
>>  			  resource_size_t end)
>> @@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
>>  	int i;
>>  	struct e820_entry *entry;
>>  
>> +	if (!pci_use_e820)
>> +		return;
>> +
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>>  		entry = &e820_table->entries[i];
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
>>  	       "if necessary, use \"pci=%s\" and report a bug\n",
>>  	       pci_use_crs ? "Using" : "Ignoring",
>>  	       pci_use_crs ? "nocrs" : "use_crs");
>> +
>> +	/*
>> +	 * Some BIOS-es contain a bug where they add addresses which map to system
>> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method, see
>> +	 * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
>> +	 * To avoid this Linux by default excludes E820 reservations when allocating
>> +	 * addresses since 2010. Windows however ignores E820 reserved regions for
>> +	 * PCI mem allocations, so in hindsight Linux honoring them is a problem.
>> +	 * In 2020 some systems have shown-up with E820 reservations which cover the
>> +	 * entire _CRS returned PCI bridge memory window, causing all attempts to
>> +	 * assign memory to PCI BARs to fail if Linux honors the E820 reservations.
>> +	 *
>> +	 * Ideally Linux would fully stop honoring E820 reservations for PCI mem
>> +	 * allocations, but then the old systems this was added for will regress.
>> +	 * Instead keep the old behavior for old systems, while ignoring the E820
>> +	 * reservations like Windows does for any systems from now on.
> 
> Wrap this to fit in 80 columns like the rest of the file.  More
> important for the file to be internally consistent than any new
> guidelines.

Already fixed in v4 (the only change in v4). I'll also drop the "Windows..."
sentence which you did not like in the commit msg for v5.

> 
>> +	 */
>> +	if (year >= 0 && year < 2018)
>> +		pci_use_e820 = true;
>> +
>> +	if (pci_probe & PCI_NO_E820)
>> +		pci_use_e820 = false;
>> +	else if (pci_probe & PCI_USE_E820)
>> +		pci_use_e820 = true;
>> +
>> +	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
>> +	       pci_use_e820 ? "Honoring" : "Ignoring");
>>  }
>>  
>>  #ifdef	CONFIG_PCI_MMCONFIG
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 3507f456fcd0..091ec7e94fcb 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -595,6 +595,12 @@ char *__init pcibios_setup(char *str)
>>  	} else if (!strcmp(str, "nocrs")) {
>>  		pci_probe |= PCI_ROOT_NO_CRS;
>>  		return NULL;
>> +	} else if (!strcmp(str, "use_e820")) {
>> +		pci_probe |= PCI_USE_E820;
>> +		return NULL;
>> +	} else if (!strcmp(str, "no_e820")) {
>> +		pci_probe |= PCI_NO_E820;
>> +		return NULL;
> 
> Why does pci_probe have to be involved here?  Couldn't we just set
> pci_use_e820 directly?

This code runs early on, before the heuristics which set
pci_use_e820 gets set based on the BIOS year, so this is
done indirectly so that the code doing the heuristics
(and checking DMI quirks/exceptions if we add any)
can set a default and then these flags are checked to
override the default.

> Same argument applies to PCI_USE__CRS and PCI_ROOT_NO_CRS of course,
> and I probably added those, so maybe there was a reason, or maybe I
> just screwed up that too.

What I wrote above, also applies to the use_crs handling, which is
handled the same for the same reason :)

Regards,

Hans

