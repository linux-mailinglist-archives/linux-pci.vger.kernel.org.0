Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63E54AB86
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiFNIPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiFNIPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 04:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68C3F3FBDA
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655194533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9Zc9wCIpLbAd4jBfyMUl844wfhz2xkE3MXngp1dQqs=;
        b=L8pcJ5/H99VcXSf39S6W+fLOvz2d6jvNeXXK45k0gu2TB1ec1BR8HIe7KOYVyIDO4GKDMv
        0BowAq2yz6Ny81tUS1Uvt8f21Lj/rjxeiDa1HpPFeXKL/AvatGE/L/I2x32o/mnhzGfhi0
        +vVsmUfw5i7w5nSVksZc1Jz0q+0ejok=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-A2wVkKBCNCyMJz8K7fO0ew-1; Tue, 14 Jun 2022 04:15:32 -0400
X-MC-Unique: A2wVkKBCNCyMJz8K7fO0ew-1
Received: by mail-ej1-f72.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso2562702ejs.12
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l9Zc9wCIpLbAd4jBfyMUl844wfhz2xkE3MXngp1dQqs=;
        b=Q8eOudSpAf/mMc16uUvBEFxG6kzITE0gY6/NOClks0JWZDI3Ns3o5sQ6EVAE8Izz3U
         CfnNc5igB4WYxuSu+YRXdxHCYNmcgHG43VorfhhYN8q8BbJ7Vx0BeykO+TgbAyDQP7dp
         vm6cnlyN6jbdUXllwiAJGyiMiaPeGPe5oxH5K7GI+Zt0C8MBCtcJN+1GphbMqC77SMrk
         8fUPRwKd/X+Rwb2c9v4V/Aaig4X2ZFSU5YTd4eiVwDkC5k7CVUKPxNye63N6Geldnx1b
         0RadtzWS20dIEkDZ8a5cb2Hh2dIUT3lAm5g5d6KTqNsusu/IpIQud8ILQhZOQsl9Qjw5
         1I0g==
X-Gm-Message-State: AJIora9cbvJgGZ3SbVt6l2utr563x2zbFOroR+PM0R9H2IYErliq0y5u
        2roksPXdjcEr5GShFj8Pyzkf7RbmKMKNQ+zbPRRGcAbr/BCfVh1j5NpXkia0tzv/3CpO5SkkeSL
        IBWGeodROzfVKAdtodDQW
X-Received: by 2002:a17:906:7295:b0:712:2241:2c3f with SMTP id b21-20020a170906729500b0071222412c3fmr3225326ejl.523.1655194530767;
        Tue, 14 Jun 2022 01:15:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfw5fLxxDEGhZzCdJd093Ss0BooyMXikguimh5E7whRCP9wkHVKSAv5g9muKWd8yhROhhnoA==
X-Received: by 2002:a17:906:7295:b0:712:2241:2c3f with SMTP id b21-20020a170906729500b0071222412c3fmr3225303ejl.523.1655194530530;
        Tue, 14 Jun 2022 01:15:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id qh21-20020a170906ecb500b006feaa22e367sm4707525ejb.165.2022.06.14.01.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 01:15:29 -0700 (PDT)
Message-ID: <5b1753ef-0bfb-f937-cab1-ad960bdf6772@redhat.com>
Date:   Tue, 14 Jun 2022 10:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] x86/PCI: Revert: "Clip only host bridge windows for E820
 regions"
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20220613231539.GA722481@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220613231539.GA722481@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/14/22 01:15, Bjorn Helgaas wrote:
> On Sun, Jun 12, 2022 at 04:43:25PM +0200, Hans de Goede wrote:
>> Clipping the bridge windows directly from pci_acpi_root_prepare_resources()
>> instead of clipping from arch_remove_reservations(), has a number of
>> unforseen consequences.
>>
>> If there is an e820 reservation in the middle of a bridge window, then
>> the smallest of the 2 remaining parts of the window will be also clipped
>> off. Where as the previous code would clip regions requested by devices,
>> rather then the entire window, leaving regions which were either entirely
>> above or below a reservation in the middle of the window alone.
>>
>> E.g. on the Steam Deck this leads to this log message:
>>
>> acpi PNP0A08:00: clipped [mem 0x80000000-0xf7ffffff window] to [mem 0xa0100000-0xf7ffffff window]
>>
>> which then gets followed by these log messages:
>>
>> pci 0000:00:01.2: can't claim BAR 14 [mem 0x80600000-0x806fffff]: no compatible bridge window
>> pci 0000:00:01.3: can't claim BAR 14 [mem 0x80500000-0x805fffff]: no compatible bridge window
>>
>> and many more of these. Ultimately this leads to the Steam Deck
>> no longer booting properly, so revert the change.
>>
>> Note this is not a clean revert, this revert keeps the later change
>> to make the clipping dependent on a new pci_use_e820 bool, moving
>> the checking of this bool to arch_remove_reservations().
> 
> 4c5e242d3e93 was definitely a mistake (my fault).  My intent was to
> mainly to improve logging of the clipping, but I didn't implement it
> well.
> 
> That said, I'd like to understand the connection between the messages
> you mention and the failure.  There are four bridges whose MMIO
> windows were in the [mem 0x80000000-0x9fffffff] area that we clipped
> out.  The log shows that we moved all those windows and the devices in
> them to the [mem 0xa0100000-0xf7ffffff] area that remained after
> clipping.
> 
> So I think this *should* have worked even though we moved things
> around unnecessarily.  What am I missing?

I don't know? My guess is that maybe the ACPI table do MMIO accesses
somewhere to hardcoded addresses and moving things breaks the ACPI
tables.

> 
> The E820 map reports [mem 0xa0000000-0xa00fffff] in the middle of the
> _CRS, and we currently trim that out.  We think this is a firmware
> defect, so it's likely to break in 2023 if we stop clipping by
> default.  I'm concerned that there may be other things in _CRS that we
> need to avoid, but firmware isn't telling us about them.
> 
> Or there's some dependency in the devices that we moved on their
> original addresses, e.g., firmware on the device latched the address
> and didn't notice the reassignment.

Right this is the most likely cause I believe.

Regards,

Hans



> 
> [1] https://bugzilla.kernel.org/attachment.cgi?id=301154
> 
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216109
>> Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
>> Reported-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/x86/include/asm/e820/api.h |  5 -----
>>  arch/x86/include/asm/pci_x86.h  |  8 ++++++++
>>  arch/x86/kernel/resource.c      | 14 +++++++++-----
>>  arch/x86/pci/acpi.c             |  8 +-------
>>  4 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
>> index 5a39ed59b6db..e8f58ddd06d9 100644
>> --- a/arch/x86/include/asm/e820/api.h
>> +++ b/arch/x86/include/asm/e820/api.h
>> @@ -4,9 +4,6 @@
>>  
>>  #include <asm/e820/types.h>
>>  
>> -struct device;
>> -struct resource;
>> -
>>  extern struct e820_table *e820_table;
>>  extern struct e820_table *e820_table_kexec;
>>  extern struct e820_table *e820_table_firmware;
>> @@ -46,8 +43,6 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
>>  
>>  extern int  e820__get_entry_type(u64 start, u64 end);
>>  
>> -extern void remove_e820_regions(struct device *dev, struct resource *avail);
>> -
>>  /*
>>   * Returns true iff the specified range [start,end) is completely contained inside
>>   * the ISA region.
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index f52a886d35cf..70533fdcbf02 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -69,6 +69,8 @@ void pcibios_scan_specific_bus(int busn);
>>  
>>  /* pci-irq.c */
>>  
>> +struct pci_dev;
>> +
>>  struct irq_info {
>>  	u8 bus, devfn;			/* Bus, device and function */
>>  	struct {
>> @@ -246,3 +248,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
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
>> index db2b350a37b7..bba1abd05bfe 100644
>> --- a/arch/x86/kernel/resource.c
>> +++ b/arch/x86/kernel/resource.c
>> @@ -1,7 +1,8 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> -#include <linux/dev_printk.h>
>>  #include <linux/ioport.h>
>> +#include <linux/printk.h>
>>  #include <asm/e820/api.h>
>> +#include <asm/pci_x86.h>
>>  
>>  static void resource_clip(struct resource *res, resource_size_t start,
>>  			  resource_size_t end)
>> @@ -24,14 +25,14 @@ static void resource_clip(struct resource *res, resource_size_t start,
>>  		res->start = end + 1;
>>  }
>>  
>> -void remove_e820_regions(struct device *dev, struct resource *avail)
>> +static void remove_e820_regions(struct resource *avail)
>>  {
>>  	int i;
>>  	struct e820_entry *entry;
>>  	u64 e820_start, e820_end;
>>  	struct resource orig = *avail;
>>  
>> -	if (!(avail->flags & IORESOURCE_MEM))
>> +	if (!pci_use_e820)
>>  		return;
>>  
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>> @@ -41,7 +42,7 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>  
>>  		resource_clip(avail, e820_start, e820_end);
>>  		if (orig.start != avail->start || orig.end != avail->end) {
>> -			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
>> +			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
>>  				 &orig, avail, e820_start, e820_end);
>>  			orig = *avail;
>>  		}
>> @@ -55,6 +56,9 @@ void arch_remove_reservations(struct resource *avail)
>>  	 * the low 1MB unconditionally, as this area is needed for some ISA
>>  	 * cards requiring a memory range, e.g. the i82365 PCMCIA controller.
>>  	 */
>> -	if (avail->flags & IORESOURCE_MEM)
>> +	if (avail->flags & IORESOURCE_MEM) {
>>  		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
>> +
>> +		remove_e820_regions(avail);
>> +	}
>>  }
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index a4f43054bc79..2f82480fd430 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -8,7 +8,6 @@
>>  #include <linux/pci-acpi.h>
>>  #include <asm/numa.h>
>>  #include <asm/pci_x86.h>
>> -#include <asm/e820/api.h>
>>  
>>  struct pci_root_info {
>>  	struct acpi_pci_root_info common;
>> @@ -20,7 +19,7 @@ struct pci_root_info {
>>  #endif
>>  };
>>  
>> -static bool pci_use_e820 = true;
>> +bool pci_use_e820 = true;
>>  static bool pci_use_crs = true;
>>  static bool pci_ignore_seg;
>>  
>> @@ -387,11 +386,6 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>>  
>>  	status = acpi_pci_probe_root_resources(ci);
>>  
>> -	if (pci_use_e820) {
>> -		resource_list_for_each_entry(entry, &ci->resources)
>> -			remove_e820_regions(&device->dev, entry->res);
>> -	}
>> -
>>  	if (pci_use_crs) {
>>  		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
>>  			if (resource_is_pcicfg_ioport(entry->res))
>> -- 
>> 2.36.0
>>
> 

