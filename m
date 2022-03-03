Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B294CBEE2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiCCNaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 08:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiCCNaX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 08:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B72B188A2D
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646314175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hm9nPvkOIfJeoDF9aZf1lbKJY5zFksWJ9/IiMToaKE=;
        b=gj8R8MVe7bJnZ0nKvedYf99DWnPz8LYevgRPhj4gz9m0J1QOzsjmWXwW+8Yx/Yd5OsVwGl
        z+zLHECG3057P5TN12nowP3rx1ZX90ks2QV/5Hzbss0lb0kdpfU6WjWanYIUQt9owUzq1g
        ODjxh7ityBvmgAPTGAj6Rl/hQTHQKgM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-Lg4kI277PFuVQvIqjiHwPg-1; Thu, 03 Mar 2022 08:29:34 -0500
X-MC-Unique: Lg4kI277PFuVQvIqjiHwPg-1
Received: by mail-ej1-f69.google.com with SMTP id l24-20020a170906a41800b006da873d66b6so1487950ejz.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Mar 2022 05:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5hm9nPvkOIfJeoDF9aZf1lbKJY5zFksWJ9/IiMToaKE=;
        b=rC7FFZDBOgIso/SJS/b5COik57ic7w9OFYgwCY1E079BVvr/XE2sZYlxpXLBX2cdqA
         JCasdsTUaQN93PNllXuxyanBtK7k3fCPJeEiVYxmzRQew0Osbf/rsbe3GC/TorASGft0
         ZuZykOoSNw3mt1tU3O/8Q1TY+o4ZOKu8Gnxwl8PFcOevx3smRA0MolKs3+regSCb+FEu
         SFoaf6nWkLyDWLaMkH+lIan8L2QidBNGESI23PuiLZ4WZ42EYRCYrl9rw7ovJ52o2xCS
         vFrKTbwU3LhHrbq2FJcj6Rs6M7oGVYuRxWhpP7yL8Tkd9pIZoQ1/HlgLDcVoy3IXfPf4
         XYMg==
X-Gm-Message-State: AOAM532QZH9bHO6/Vmd3hPknQLwX47ihYdwOOwwcz73PYbCjar86c9Kz
        bZONgpnneWVjRPuAzAzPA6rUIW0bLSdqdSxiR4/iHBiYucwZGlZHptzQX3VdVpV1DgvJFq2bQ+U
        dB+1DrQFFLYg82IByoQhv
X-Received: by 2002:a17:906:c114:b0:6d8:cfd4:f746 with SMTP id do20-20020a170906c11400b006d8cfd4f746mr7290141ejc.538.1646314172359;
        Thu, 03 Mar 2022 05:29:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfMuQ9yUcJyVxYOynovimYSiinHK0NhW6m1Rp6Vv26Di/JSVofi0Q2xFVOeyHq75vhAke9PA==
X-Received: by 2002:a17:906:c114:b0:6d8:cfd4:f746 with SMTP id do20-20020a170906c11400b006d8cfd4f746mr7290106ejc.538.1646314171834;
        Thu, 03 Mar 2022 05:29:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id u1-20020aa7d0c1000000b004132c0a9ee3sm837183edo.84.2022.03.03.05.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 05:29:31 -0800 (PST)
Message-ID: <55c6d785-e29a-872e-ddbe-3d9f9b11be8e@redhat.com>
Date:   Thu, 3 Mar 2022 14:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] x86/PCI: Disable exclusion of E820 reserved addressed
 in some cases
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220303004058.GA610543@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220303004058.GA610543@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/3/22 01:40, Bjorn Helgaas wrote:
> On Mon, Feb 28, 2022 at 11:52:59AM +0100, Hans de Goede wrote:
> 
> I know Rafael has already applied this, but I'm still trying to
> understand this because it looks like a very complicated maintenance
> problem.
> 
>> Some fw has a bug where the PCI bridge window returned by the ACPI
>> resources partly overlaps with some other address range, causing issues.
>> To workaround this Linux excludes E820 reserved addresses when allocating
>> addresses from the PCI bridge window. 2 known examples of such fw bugs are:
>>
>> 1. The returned window contains addresses which map to system RAM,
>> see commit 4dc2287c1805 ("x86: avoid E820 regions when allocating
>> address space").
> 
> Bug report is https://bugzilla.kernel.org/show_bug.cgi?id=16228
> First dmesg log https://bugzilla.kernel.org/attachment.cgi?id=26811
> shows:
> 
>   BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
>   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]
>   pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
>   pci 0000:00:1f.2: BAR 5: assigned [mem 0xbff00000-0xbff007ff]
>   ahci 0000:00:1f.2: controller reset failed (0xffffffff)
>   ahci 0000:00:1f.2: failed to stop engine (-5)
> 
> The problem is that _CRS advertises [mem 0xbff00000-0xdfffffff], and
> we assigned [mem 0xbff00000-0xbff007ff] to 00:1f.2, but
> 0xbff00000-0xbfffffff is not usable for PCI devices.  My guess is that
> it contains host bridge registers, but all we really know is that it
> doesn't work.
> 
> I think the _CRS that includes non-usable space is clearly a BIOS
> defect.
> 
> The fix from 4dc2287c1805 was to avoid that region based on the
> 0xbfe4dc00-0xc0000000 E820 entry, and the result is in
> https://bugzilla.kernel.org/attachment.cgi?id=30662:
> 
>   BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
>   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xf7ffffff]
>   pci_root PNP0A03:00: host bridge window [mem 0xff980000-0xff980fff]
>   pci 0000:00:1f.2: reg 24: [mem 0xff970000-0xff9707ff]   # BAR 5
>   pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
>   pci 0000:00:1f.2: BAR 5: assigned [mem 0xff980800-0xff980fff]
> 
> The patch below doesn't affect this workaround.
> 
>> 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
>> reserved range and the ACPI provided PCI bridge window:
>>  efi: mem46: [MMIO] range=              [0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>>  BIOS-e820:                         [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>>  pci_bus 0000:00: root bus resource [mem         0xdfa00000-        0xfebfffff window]
>> If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
>> then the system fails to resume after a suspend.
> 
> I think this is from https://bugzilla.redhat.com/show_bug.cgi?id=2029207

Correct.

> If I understand correctly, the log in comment 23 from Ivan
> (https://bugzilla.redhat.com/attachment.cgi?id=1859801) is a
> case where resume doesn't work:
> 
>   BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff]
> 
> And the log in comment 38, also from Ivan,
> (https://bugzilla.redhat.com/attachment.cgi?id=1861539) is a case
> where resume *does* work:
> 
>   BIOS-e820: [mem 0x00000000dcf00000-0x00000000dfa0ffff] reserved
>   efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]
> 
> _CRS advertises [mem 0xdfa00000-0xfebfffff], but when we assign the
> 0xdfa00000-0xdfafffff region to the 00:1c.0 MMIO window, resume fails.

Correct this "when we assign the 0xdfa00000-0xdfafffff region to
the 00:1c.0 MMIO window, resume fails" is my conclusion too.

> I don't see a theory about what the root cause is.

Correct, because I have no theory, I merely observed that:

1. 0xdfa00000-0xdfa0ffff (note the 0 between the a and ffff)
is reserved in the E820 ranges (this was first seen with
classic BIOS boot, but also reproduces with EFI bootiung)

2. If the kernel assigns PCI resources to it despite it being
reserved the reporter reports resume being broken.

I indeed do not know the exact cause of this.

> It's possible this
> is similar to case 1 above, where _CRS is defective.

I definitely consider this another case of _CRS being defective
and it is similar to 1 in that regards, yes.

> But here we're
> only assigning the 00:1c.0 MMIO window, and 00:1c.0 is a bridge to
> [bus 02], and there are no devices on bus 02.  There should be no
> transactions that use that MMIO window, so it's not clear why this
> should matter.
> 
> If this is a _CRS defect similar to case 1, it's possible there are
> host bridge registers in 0xdfa00000-0xdfafffff, and BIOS might use
> those during resume, and assigning that area to the 00:1c.0 MMIO
> window might interfere with that.  But that's a lot of speculation.
> 
> If you have a good Lenovo contact, they might be able to confirm or
> deny this.
> 
> I'm missing some things here that should be obvious; can you help me
> out?
> 
>   - Why did the 4dc2287c1805 workaround not apply here?  The E820
>     region overlaps the _CRS window just like in case 1, so why did we
>     assign 0xdfa00000?

The 4dc2287c1805 workaround does apply here. The problem is that
my earlier patch which Rafael merged to not honor e820 reservations
on newer BIOS-es broke suspend/resume since that patch disables
the 4dc2287c1805 workaround on this machine.

The comment tries to mention this issue as a second case of
why the 4dc2287c1805 workaround is necessary.

The goal of this part of the comment is to explain why we
cannot just disable the 4dc2287c1805 workaround.

>   - How does this patch work around the problem?  This patch checks if
>     a host bridge window is completely contained in an EFI MMIO
>     region, but I don't see such an EFI region here.

It does not help with case 2 from the comment, since that
case is already effectively fixed by the 4dc2287c1805 workaround.

This patch is a replacement for my earlier fix to disable
the 4dc2287c1805 workaround on newer systems. Since that patch
was causing the regression reported in the Red Hat 2029207
the patch to disable the 4dc2287c1805 workaround on newer systems
has been reverted.

So this is yet another attempt to fix the case where
the PCI subsystem cannot assign resources to some PCI
devices because the entire root bridge window is covered
by an EFI memtable MMIO entry, which gets translated into
an e820_table reserved entry.

What this patch does is identify systems which have the
problem of the entire root bridge window being covered
by an EFI memtable MMIO entry and only disable the
4dc2287c1805 workaround there.

The idea here is to only disable arch_remove_reservations()
taking e820 reservations into account on as narrow a set of
systems as possible.

Keeping it enabled on all other systems, including recent
systems. Since recent systems also benefit from the
4dc2287c1805 workaround as the regression from my patch
to disable it on recent systems has shown us.

I hope this helps understand things better.

Regards,

Hans





>> Recently (2019) some systems have shown-up with EFI memmap MMIO entries
>> covering the entire ACPI provided PCI bridge window. These memmap entries
>> get converted into e820_table entries, causing all attempts to assign
>> memory to PCI BARs which have not been setup by the BIOS to fail.
>> For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
>>  efi: mem63: [MMIO] range=              [0x0000000065400000-0x00000000cfffffff] (1708MB)
>>  BIOS-e820:                         [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>  pci_bus 0000:00: root bus resource [mem         0x65400000-        0xbfffffff window]
>>  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>>  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
>>
>> To fix this, check if the ACPI provided PCI bridge window is fully
>> contained within in EFI memmap MMIO region and in that case disable
>> the "exclude E820 reserved addresses" workaround, fixing the problem
>> of not being able to find free space for unassigned BARs.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2029207
>> BugLink: https://bugs.launchpad.net/bugs/1878279
>> BugLink: https://bugs.launchpad.net/bugs/1931715
>> BugLink: https://bugs.launchpad.net/bugs/1932069
>> BugLink: https://bugs.launchpad.net/bugs/1921649
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Add a couple of missing includes to arch/x86/include/asm/pci_x86.h
>>   to fix i386 build errors Reported-by: kernel test robot <lkp@intel.com>
>> - Do not call resource_is_efi_mmio_region() on resource-list entries which
>>   have just been destroyed because they match resource_is_pcicfg_ioport()
>>   Reported-by: kernel test robot <oliver.sang@intel.com>
>> - Add (res->flags & IORESOURCE_MEM) check to resource_is_efi_mmio_region()
>> ---
>>  arch/x86/include/asm/pci_x86.h | 10 +++++
>>  arch/x86/kernel/resource.c     |  4 ++
>>  arch/x86/pci/acpi.c            | 68 +++++++++++++++++++++++++++++++++-
>>  3 files changed, 81 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 490411dba438..4ce61ab01a4f 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -5,7 +5,9 @@
>>   *	(c) 1999 Martin Mares <mj@ucw.cz>
>>   */
>>  
>> +#include <linux/init.h>
>>  #include <linux/ioport.h>
>> +#include <linux/spinlock.h>
>>  
>>  #undef DEBUG
>>  
>> @@ -64,6 +66,8 @@ void pcibios_scan_specific_bus(int busn);
>>  
>>  /* pci-irq.c */
>>  
>> +struct pci_dev;
> 
> Both the above look like fixes to an unrelated asm/pci_x86.h
> problem that happened to be exposed by including it in
> arch/x86/kernel/resource.c.  Most users of asm/pci_x86.h
> include linux/pci.h first, which covers up the problem.
> 
>>  struct irq_info {
>>  	u8 bus, devfn;			/* Bus, device and function */
>>  	struct {
>> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>>  # define x86_default_pci_init_irq	NULL
>>  # define x86_default_pci_fixup_irqs	NULL
>>  #endif
>> +
>> +#if defined CONFIG_PCI && defined CONFIG_ACPI
>> +extern bool pci_use_e820;
>> +#else
>> +#define pci_use_e820 true
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
>> index 052f1d78a562..fce05e03ba9e 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -1,4 +1,5 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +#include <linux/efi.h>
>>  #include <linux/pci.h>
>>  #include <linux/acpi.h>
>>  #include <linux/init.h>
>> @@ -21,6 +22,7 @@ struct pci_root_info {
>>  
>>  static bool pci_use_crs = true;
>>  static bool pci_ignore_seg;
>> +bool pci_use_e820 = true;
>>  
>>  static int __init set_use_crs(const struct dmi_system_id *id)
>>  {
>> @@ -291,6 +293,63 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
>>  		res->start == 0xCF8 && res->end == 0xCFF;
>>  }
>>  
>> +/*
>> + * Some fw has a bug where the PCI bridge window returned by the ACPI resources
>> + * partly overlaps with some other address range, causing issues. To workaround
>> + * this Linux excludes E820 reserved addresses when allocating addresses from
>> + * the PCI bridge window. 2 known examples of such firmware bugs are:
>> + *
>> + * 1. The returned window contains addresses which map to system RAM, see
>> + * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
>> + *
>> + * 2. The Lenovo X1 carbon gen 2 BIOS has an overlap between an EFI/E820
>> + * reserved range and the ACPI provided PCI bridge window:
>> + *  efi: mem46: [MMIO] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
>> + *  BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved
>> + *  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
>> + * If Linux assigns the overlapping 0xdfa00000-0xdfa0ffff range to a PCI BAR
>> + * then the system fails to resume after a suspend.
>> + *
>> + * Recently (2019) some systems have shown-up with EFI memmap MMIO entries
>> + * covering the entire ACPI provided PCI bridge window. These memmap entries
>> + * get converted into e820_table entries, causing all attempts to assign
>> + * memory to PCI BARs which have not been setup by the BIOS to fail.
>> + * For example see these dmesg snippets from a Lenovo IdeaPad 3 15IIL 81WE:
>> + *  efi: mem63: [MMIO] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
>> + *  BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>> + *  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>> + *  pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>> + *  pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
>> + *
>> + * To code below checks if the ACPI provided PCI bridge window is fully
>> + * contained within in EFI memmap MMIO region and in that case disables
>> + * the "exclude E820 reserved addresses" workaround to avoid this issue.
>> + */
>> +static bool resource_is_efi_mmio_region(const struct resource *res)
>> +{
>> +	unsigned long long start, end;
>> +	efi_memory_desc_t *md;
>> +
>> +	if (!(res->flags & IORESOURCE_MEM))
>> +		return false;
>> +
>> +	if (!efi_enabled(EFI_MEMMAP))
>> +		return false;
>> +
>> +	for_each_efi_memory_desc(md) {
>> +		if (md->type != EFI_MEMORY_MAPPED_IO)
>> +			continue;
>> +
>> +		start = md->phys_addr;
>> +		end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
>> +
>> +		if (res->start >= start && res->end <= end)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>>  {
>>  	struct acpi_device *device = ci->bridge;
>> @@ -300,9 +359,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>>  
>>  	status = acpi_pci_probe_root_resources(ci);
>>  	if (pci_use_crs) {
>> -		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
>> +		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>>  			if (resource_is_pcicfg_ioport(entry->res))
>>  				resource_list_destroy_entry(entry);
>> +			else if (resource_is_efi_mmio_region(entry->res)) {
>> +				dev_info(&device->dev,
>> +					"host bridge window %pR is marked by EFI as MMIO\n",
>> +					entry->res);
>> +				pci_use_e820 = false;
> 
> This message suggests that marking the host bridge window as MMIO in
> EFI is a defect, or at least something unusual and worthy of being
> flagged.  But I think it's perfectly legal.
> 
> UEFI v2.8, sec 7.2, says EfiMemoryMappedIO means:
> 
>   Used by system firmware to request that a memory-mapped IO region be
>   mapped by the OS to a virtual address so it can be accessed by EFI
>   runtime services.
> 
> 
>> +			}
>> +		}
>>  		return status;
>>  	}
>>  
>> -- 
>> 2.35.1
>>
> 

