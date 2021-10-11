Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D4429074
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbhJKOJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 10:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240365AbhJKOGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 10:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633961088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHw/Q0shVTHnj0rQBow2YlLn+FO5RqvPp9WGmOcYTHU=;
        b=QLOh1gCh1TCBoUoDRN9v4Cy1XP6YuH0OCdx2v8iJvmgy+TpHuMopJ+JEQ3csSN4vsphPzz
        Sh2adaYVb3QTvuVYMLDY34MVK+M1y9kKdbgZsY0rhE48nbmPwb01ye+6WfFWezDHz0IC2+
        HWmm0B04PPw7/nC726061im5qmHfbqc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-aXazxcOsNCadEwb8vPG3jw-1; Mon, 11 Oct 2021 10:04:47 -0400
X-MC-Unique: aXazxcOsNCadEwb8vPG3jw-1
Received: by mail-ed1-f69.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso16019661edn.4
        for <linux-pci@vger.kernel.org>; Mon, 11 Oct 2021 07:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cHw/Q0shVTHnj0rQBow2YlLn+FO5RqvPp9WGmOcYTHU=;
        b=hcoYvNs0WeYA9YVIP9y80fSfOi4SI6TTsqByhokqGwxNO6Vkg9dnzqIMYPO9q0YhZd
         0Blto8SLgB3csMJ8g2wMsZE4KpW1axkUHc9bUu9mnTlZ3B86E8msXLnPvtTd6wccXfNt
         RhXMQhsdtaqLPBykcW/Ytj1rZIpT+Mv5B7KrOCC7Loz/NvKLDr/6gLi85N+A8uCS22AX
         LLEHqApRuwGsQ1vRT7co6XnteYuJJV7M7exL3m91WEnVmqiteRFjqaCPvUpOyvVvBxVk
         EnoJzAvqpMsjAixn5/6Du8jIgzs9HSJjVCJ8MeNiHn681ISqvYx2vxjOlAReFmPvQ81T
         IqvA==
X-Gm-Message-State: AOAM5304EvhEOcsVsjWJvAbs6Uh8HxzAD6Xe7m7UtVB420ygU9SkoBmT
        g5FMMH9NbDRUqT7xPtnVm30z3mNt9PIXefRpMb63C6yRtsumrsgdMBFR0AxyjhYSF2/3BDwnEpC
        VL8VsYi6FLaXgI9oWZj03
X-Received: by 2002:a17:906:d0d8:: with SMTP id bq24mr19470209ejb.402.1633961086422;
        Mon, 11 Oct 2021 07:04:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGsx+haF/Pc6Piek6aLWeY8pHRh0jjsuW+vOfBsWxP9XcYh+AjVpcsJGC+hlVsKlS/4P9+0w==
X-Received: by 2002:a17:906:d0d8:: with SMTP id bq24mr19470176ejb.402.1633961086146;
        Mon, 11 Oct 2021 07:04:46 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id au26sm3551036ejc.53.2021.10.11.07.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 07:04:45 -0700 (PDT)
Subject: Re: [PATCH v2] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <20211011090531.244762-1-hdegoede@redhat.com>
 <YWRBvRcuTx8BrmX0@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7102c9cd-1568-4789-1a36-0eb5043c1d35@redhat.com>
Date:   Mon, 11 Oct 2021 16:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWRBvRcuTx8BrmX0@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/11/21 3:53 PM, Mika Westerberg wrote:
> Hi Hans,
> 
> On Mon, Oct 11, 2021 at 11:05:31AM +0200, Hans de Goede wrote:
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
>> attempts to assign memory to PCI BARs which have not been setup by the BIOS
>> to fail. For example here are the relevant dmesg bits from a
>> Lenovo IdeaPad 3 15IIL 81WE:
>>
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>> Ideally Linux would fully stop honoring E820 reservations for PCI mem
>> allocations, but then the old systems this was added for will regress.
>> Instead keep the old behavior for old systems, while ignoring the E820
>> reservations like Windows does for any systems from now on.
>>
>> Old systems are defined here as BIOS year < 2018, this was chosen to
>> make sure that pci_use_e820 will not be set on the currently affected
>> systems, while at the same time also taking into account that the
>> systems for which the E820 checking was orignally added may have
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
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Thanks for fixing this! Few comments below. Otherwise looks good,

You're welcome, I hope this solution is acceptable to everyone and
that we can finally leave this problem behind us.

> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you.

>> ---
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
>>  		routeirq	Do IRQ routing for all PCI devices.
>>  				This is normally done in pci_enable_device(),
>>  				so this option is a temporary workaround
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 490411dba438..e45d661f81de 100644
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
> 
> Is this really needed?

Yes, otherwise the compiler becomes unhappy with the new:

#include <asm/pci_x86.h>

in arch/x86/kernel/resource.c .  So far the missing forward declaration
was likely not an issue because other consumers of pci_x86.h where already
including some other header which declares struct pci_dev.




> 
>> +
>>  struct irq_info {
>>  	u8 bus, devfn;			/* Bus, device and function */
>>  	struct {
>> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>>  # define x86_default_pci_init_irq	NULL
>>  # define x86_default_pci_fixup_irqs	NULL
>>  #endif
>> +
>> +#if defined CONFIG_PCI && defined CONFIG_ACPI
> 
> Should these be using parentheses?
> 
> #if defined(CONFIG_PCI) && defined(CONFIG_ACPI)

Both forms are used, the form I've chosen is e.g. also used in:

arch/x86/include/asm/vdso.h

If there is a strong preference for switching to the style
with the parentheses I'll happily do a v3 with that fixed.

If that ends up being the only objection to this patch
I'm quite happy to respin :)





> 
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
>> +	 */
>> +	if (year >= 0 && year < 2018)
>> +		pci_use_e820 = true;
>> +
>> +	if (pci_probe & PCI_NO_E820)
>> +		pci_use_e820 = false;
>> +	else if (pci_probe & PCI_USE_E820)
>> +		pci_use_e820 = true;
> 
> Should it check if both are passed at the same time and complain, or we
> don't care?

This mirrors the similar code for pci_use_crs which also prefers the
nocrs/no_e820 option over the use_crs/_e820 option and which also does
not warn if both are present.

> 
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
>>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>>  	} else if (!strcmp(str, "big_root_window")) {
>>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
>> -- 
>> 2.31.1
> 

Regards,

Hans

