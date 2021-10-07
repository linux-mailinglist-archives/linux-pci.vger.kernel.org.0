Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59123425AE1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbhJGSiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 14:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243685AbhJGSh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 14:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633631765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDRS3NwqD/m1bSWuVpP3VZiu/nyxWljkMjjbeif4Lyk=;
        b=i8aWvSY6as/lVk27FdMlOAzYgSxXS4ZfGNaw31y3O6uKhxa01Usc66R+bR0jpoxuxGB9Wn
        27mMZgC0v/lyp0kKg8494GS2bWpxqTCxIjIaSUiXiH5Qml6V1YsQhZ1dMu26UFmAbS1r3w
        XISBqI1hBs307eEWkRA4xNBmQUeikKA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Ru1NFmH2OvmeFF7torSaZg-1; Thu, 07 Oct 2021 14:36:04 -0400
X-MC-Unique: Ru1NFmH2OvmeFF7torSaZg-1
Received: by mail-ed1-f71.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so6775098edb.8
        for <linux-pci@vger.kernel.org>; Thu, 07 Oct 2021 11:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gDRS3NwqD/m1bSWuVpP3VZiu/nyxWljkMjjbeif4Lyk=;
        b=YX20jhCgU2Qk2UWLaE5qwdS+9yMNpDDDuVjqLCjDn8RZZI10sYkFKB+YYqArEShElq
         mHoAeZx5i14UW7qcJf8Mob7oyEoM7n35Ej6WvhxRCsCscAW/5cm7011S9cIGkuce4Jv2
         iuwV14V/1lp60iOD397VSLBoXxo1QHOOvhZNzuV5zWUI3P2PXh6mwjspfzR/jGA4DYvb
         Ig7moXI8MK6ZFXhkRBcHVVPKjpdscsKU0Z2kXjK1xDbuLP1n2ZuHotW8Q6d66sCDDxBO
         +Hr3CDMU1LywLXJ6l0NDd97x6vf9Y0OKVGcxaRFPKk8ibt4C4odbMIRtqdJ6taplXIju
         EWpw==
X-Gm-Message-State: AOAM530i2FRP7FAkdl86JLO9Wo9rAH8FX0YHm+KoBmkG3r+lV238lwPD
        59cuegrO5QzSRexQgM25WhtcJ+lpkC9TZJ2f8Ka7ilgyU60AUhVX7mJzLahOUU/APYt2OCluVvZ
        BAm6AyuC8K7MXHZifdX81
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr8423953edb.398.1633631762406;
        Thu, 07 Oct 2021 11:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvg6o3X4vu9FWznC6hSURAxVFwVKBq7go6Hmt1AI4us+2htuAmhBv8qMZONY23A+dhz247zw==
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr8423922edb.398.1633631762127;
        Thu, 07 Oct 2021 11:36:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h8sm74825ejj.22.2021.10.07.11.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 11:36:01 -0700 (PDT)
Subject: Re: [PATCH] x86/PCI: Add pci=no_e820 cmdline option to ignore E820
 reservations for bridge windows
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hui.wang@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Myron Stowe <myron.stowe@redhat.com>
References: <20211007165532.GA1241708@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f83feee5-259a-2580-5faa-425785c7891e@redhat.com>
Date:   Thu, 7 Oct 2021 20:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007165532.GA1241708@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 10/7/21 6:55 PM, Bjorn Helgaas wrote:
> [+cc Hui, Rafael, Myron; this looks like the same issue Hui encountered:
> https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com]
> 
> On Tue, Oct 05, 2021 at 05:09:56PM +0200, Hans de Goede wrote:
>> Some BIOS-es contain a bug where they add addresses which map to system RAM
>> in the PCI bridge memory window returned by the ACPI _CRS method, see
>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>> space").
>>
>> To avoid this Linux by default excludes E820 reservations when allocating
>> addresses since 2010. Windows however ignores E820 reserved regions for PCI
>> mem allocations, instead it avoids these BIOS bugs by allocates addresses
>> top-down.
>>
>> Recently (2020) some systems have shown-up with E820 reservations which
>> cover the entire _CRS returned PCI bridge memory window, causing all
>> attempts to assign memory to PCI bars which have not been setup by the BIOS
>> to fail. For example here are the relevant dmesg bits from a
>> Lenovo IdeaPad 3 15IIL 81WE:
>>
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>> Add a pci=no_e820 option which allows disabling the E820 reservations
>> check, while still honoring the _CRS provided resources.
>>
>> And automatically enable this on the "Lenovo IdeaPad 3 15IIL05" to fix
>> the touchpad not working on this laptop.
>>
>> Also add a pci=use_e820 option to allow overruling the results of
>> DMI quirks defaulting to no_e820 on some systems.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
> 
> Probably the same issue (from Hui's patch):
> 
>   BugLink: http://bugs.launchpad.net/bugs/1931715
>   BugLink: http://bugs.launchpad.net/bugs/1932069
>   BugLink: http://bugs.launchpad.net/bugs/1921649

Ack.

> I think 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> space") was a mistake (my fault!).

I would not be to hard on yourself about that, that commit is from
2010, so it has not caused any issues for approx. 10 years which
is pretty good in my book :)

But yes in hindsight we should not be taking the E820 regions into
account, while Windows is know to ignore them.

> The relationship between E820 and ACPI _CRS is not really very clear.
> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
> 
>   This range of addresses is in use or reserved by the system and is
>   not to be included in the allocatable memory pool of the operating
>   system's memory manager.
> 
> and it may be used when:
> 
>   The address range is in use by a memory-mapped system device.
> 
> Furthermore, sec 15.2 says:
> 
>   Address ranges defined for baseboard memory-mapped I/O devices, such
>   as APICs, are returned as reserved.
> 
> I think a PCI host bridge qualifies as a baseboard memory-mapped I/O
> device, and its apertures are in use and certainly should not be
> included in the general allocatable pool, so the fact that this BIOS
> reports the PCI aperture as "reserved" in E820 doesn't seem like a
> bug.
> 
> So I think I made a mistake in 4dc2287c1805 by excluding E820 regions.
> Of course, if we don't exclude them, it still leaves the issue on Dell
> systems that 4dc2287c1805 addressed.  There we had:
> 
>   BIOS-e820: 00000000bfe4dc00 - 00000000c0000000 (reserved)
>   pci_root PNP0A03:00: host bridge window [mem 0xbff00000-0xdfffffff]
> 
> but PCI devices placed at 0xbff00000 don't work.  I think this case IS
> a clear BIOS bug because _CRS gave us a faulty window.  4dc2287c1805
> worked around it by trimming off the 0xbff00000-0xc0000000 piece based
> on the E820 reservation.
> 
> So what to do?  4dc2287c1805 made a generic change for a BIOS bug.
> This patch makes a quirk-based change for what I think is *not* a BIOS
> bug.  That seems backwards, and I'm afraid quirks will be impractical
> because we already have a pretty big list:
> 
>   Lenovo Ideapad S145   # Launchpad 1931715, 1921649
>   Lenovo Ideapad BS145  # Launchpad 1932069
>   Lenovo Ideapad 5      # Launchpad 1878279
>   Lenovo Ideapad 3      # Launchpad 1878279 #27 #88, 1880172
>   Lenovo Ideapad Slim 7 # Launchpad 1878279 #89
>   Lenovo V15-IIL        # Launchpad 1878279 #119
> 
> I think we should figure out a better approach than 4dc2287c1805 for
> working around the Dell BIOS bugs, but I don't have any great ideas.

Right the reason why I've taken the pci=no_e820 setting approach
is to avoid regressing these older Dell machines (and probably others
from the same era like them). Machines from 2010 are 64 bit machines,
probably the first gen core (i5 / i7) machines. So these are actually
still pretty usable (I've a couple still of use as office/home-work
machines in my own home).

Given that we don't want to regress these older 2010 era machines and
that we agree that going forward we want to ignore the e820 reservations
I think the best solution is to both have our cake and eat it.

What I mean is use the old behavior on machines where the bios-date
year < 2019 and add new behavior where we ignore e820 reservations
for bios year >= 2019. Pretty much like how we disable _CRS use
for bios year < 2008.

(It could even be 2020 instead of 2019 I believe from the bug
reports, but 2019 gives use some leeway.)

I realize that this is not the prettiest solution, but it gives
us the desired behavior of ignoring the e820 reservations going
forward, while preserving the old behavior for old machines
avoiding regressions.

And if you look at the code of my patch (replacing the DMI
quirk with the bios-year check) then code wise this does not
look too bad / ugly.

If you agree with this approach I'll happily do a v2 implementing
this.

Regards,

Hans




> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/x86/include/asm/pci_x86.h | 10 ++++++++++
>>  arch/x86/kernel/resource.c     | 17 +++++++++++++++++
>>  arch/x86/pci/acpi.c            | 26 ++++++++++++++++++++++++++
>>  arch/x86/pci/common.c          |  6 ++++++
>>  4 files changed, 59 insertions(+)
>>
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
>> +extern bool pci_use_e820;
>> +#else
>> +#define pci_use_e820 false
>> +#endif
>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>> index 9b9fb7882c20..6069d86021f0 100644
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
>> @@ -23,11 +24,27 @@ static void resource_clip(struct resource *res, resource_size_t start,
>>  		res->start = end + 1;
>>  }
>>  
>> +/*
>> + * Some BIOS-es contain a bug where they add addresses which map to system RAM
>> + * in the PCI bridge memory window returned by the ACPI _CRS method, see
>> + * commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address space").
>> + * To avoid this Linux by default excludes E820 reservations when allocating
>> + * addresses since 2010. Windows however ignores E820 reserved regions for PCI
>> + * mem allocations, instead it avoids these BIOS bugs by allocates addresses
>> + * top-down.
>> + * Recently (2020) some systems have shown-up with E820 reservations which
>> + * cover the entire _CRS returned PCI bridge memory window, causing all
>> + * attempts to assign memory to PCI bars which have not been setup by the BIOS
>> + * to fail. The pci_use_e820 check is there as a workaround for these systems.
>> + */
>>  static void remove_e820_regions(struct resource *avail)
>>  {
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
>> index 948656069cdd..4fc95f5308e3 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -21,6 +21,8 @@ struct pci_root_info {
>>  
>>  static bool pci_use_crs = true;
>>  static bool pci_ignore_seg = false;
>> +/* Consumed in arch/x86/kernel/resource.c */
>> +bool pci_use_e820 = true;
>>  
>>  static int __init set_use_crs(const struct dmi_system_id *id)
>>  {
>> @@ -34,6 +36,12 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
>>  	return 0;
>>  }
>>  
>> +static int __init set_no_e820(const struct dmi_system_id *id)
>> +{
>> +	pci_use_e820 = false;
>> +	return 0;
>> +}
>> +
>>  static int __init set_ignore_seg(const struct dmi_system_id *id)
>>  {
>>  	printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
>> @@ -135,6 +143,16 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
>>  		},
>>  	},
>> +	/* https://bugzilla.redhat.com/show_bug.cgi?id=1868899 */
>> +	{
>> +		.callback = set_no_e820,
>> +		.ident = "Lenovo IdeaPad 3 15IIL05",
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "81WE"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad 3 15IIL05"),
>> +		},
>> +	},
>>  	{}
>>  };
>>  
>> @@ -160,6 +178,14 @@ void __init pci_acpi_crs_quirks(void)
>>  	       "if necessary, use \"pci=%s\" and report a bug\n",
>>  	       pci_use_crs ? "Using" : "Ignoring",
>>  	       pci_use_crs ? "nocrs" : "use_crs");
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
>>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>>  	} else if (!strcmp(str, "big_root_window")) {
>>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
>> -- 
>> 2.31.1
>>
> 

