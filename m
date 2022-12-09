Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA2648146
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 12:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLILF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 06:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLILFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 06:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB312A8B
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670583897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30T7QhM08K4gjwiweJHt8pVLSWuAKQjH4tR5LjWex3Q=;
        b=S5x5mOHDkmGFbuBEJeyzKoyOOHndJElFyiLeBqHuaOSTyjt+1P4f7jghCiZC7hGBWwAxsU
        ISTftAzP8twEa1ePL7GH9KwnO9QUnDAUzDfWiJQcRTJaLGM2lSEBTNyvnEHti6cVK6Oksu
        +KYTx6EhEtKC/0/OKg63vKvJcL1VGXU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-9BeDW_YxN4CYXxSSLhPGSA-1; Fri, 09 Dec 2022 06:04:56 -0500
X-MC-Unique: 9BeDW_YxN4CYXxSSLhPGSA-1
Received: by mail-ed1-f70.google.com with SMTP id m18-20020a056402511200b0046db14dc1c9so1183942edd.10
        for <linux-pci@vger.kernel.org>; Fri, 09 Dec 2022 03:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30T7QhM08K4gjwiweJHt8pVLSWuAKQjH4tR5LjWex3Q=;
        b=j6g8nNCSwg5K1d9ob7xxQlfYSaiaQW68cp/EGi/agIBmAPYTApX1Q4WWEZOOSLGP3d
         KFiPZDu1Axapd8JGlM+z0s4NsQT9Bud4jr0mXtC4hw97H/N4ur6oyFZvgn5hqjzn5Kgu
         y5dS36PlmR/GboONPVsSJ+TQWKkigSVB8v9Jgx7MkBFeN6WMYJve1pw9IkGIpiYFeBDz
         jmpaGc1Wl2CgIDy/j9DKHlOlqyltcReywXMbFvNLFQXhci571k2rCNzwRhHYGxcw7A6R
         loiRWjp2WOYVLPAXZqEkncv8H74ewEc2N30j/LE5AfAlM5LQFU6xF6UC9OgKoOCt8ifp
         yrCA==
X-Gm-Message-State: ANoB5pn0UsixKJ+/Xs20kkgLZHkQatAhB4UMVgh8Jd43T+0umpyGAGHY
        ee3RS8hoh230ODZPXp7CY4IJm0I+7Rzo4XFL+j9zpE90ie4FGitSUBcPB9UDG3dTB7uy37Rui0c
        CpLu4UhOwwCLhZm61RjsD
X-Received: by 2002:a17:906:2806:b0:7c1:29ef:790b with SMTP id r6-20020a170906280600b007c129ef790bmr3005068ejc.69.1670583895236;
        Fri, 09 Dec 2022 03:04:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50RWJVTwQHYigVCfTjQcbIRn/1tJTNunep4Ib8pen2Jlc5mxHQ3JeahdxVAsrbFXdXpP0Ocg==
X-Received: by 2002:a17:906:2806:b0:7c1:29ef:790b with SMTP id r6-20020a170906280600b007c129ef790bmr3005051ejc.69.1670583894944;
        Fri, 09 Dec 2022 03:04:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906300400b00734bfab4d59sm427036ejz.170.2022.12.09.03.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 03:04:54 -0800 (PST)
Message-ID: <c7418ea8-6b1a-f648-da5f-bf6ae412e359@redhat.com>
Date:   Fri, 9 Dec 2022 12:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/4] efi/x86: Remove EfiMemoryMappedIO from E820 map
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221208190341.1560157-1-helgaas@kernel.org>
 <20221208190341.1560157-2-helgaas@kernel.org>
 <805ea628-77a2-a1c1-10fe-edf2203e9c86@redhat.com>
In-Reply-To: <805ea628-77a2-a1c1-10fe-edf2203e9c86@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/9/22 09:06, Hans de Goede wrote:
> Hi,
> 
> One comment (logging bug in patch) below:
> 
> On 12/8/22 20:03, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Firmware can use EfiMemoryMappedIO to request that MMIO regions be mapped
>> by the OS so they can be accessed by EFI runtime services, but should have
>> no other significance to the OS (UEFI r2.10, sec 7.2).  However, most
>> bootloaders and EFI stubs convert EfiMemoryMappedIO regions to
>> E820_TYPE_RESERVED entries, which prevent Linux from allocating space from
>> them (see remove_e820_regions()).
>>
>> Some platforms use EfiMemoryMappedIO entries for PCI MMCONFIG space and PCI
>> host bridge windows, which means Linux can't allocate BAR space for
>> hot-added devices.
>>
>> Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
>> problem.
>>
>> Leave small (< 256KB) EfiMemoryMappedIO regions alone because on some
>> platforms, these describe non-window space that's included in host bridge
>> _CRS.  If we assign that space to PCI devices, they don't work.  On the
>> Lenovo X1 Carbon, this leads to suspend/resume failures.
>>
>> The previous solution to the problem of allocating BARs in these regions
>> was to add pci_crs_quirks[] entries to disable E820 checking for these
>> machines (see d341838d776a ("x86/PCI: Disable E820 reserved region clipping
>> via quirks")):
>>
>>   Acer   DMI_PRODUCT_NAME    Spin SP513-54N
>>   Clevo  DMI_BOARD_NAME      X170KM-G
>>   Lenovo DMI_PRODUCT_VERSION *IIL*
>>
>> Florent reported the BAR allocation issue on the Clevo NL4XLU.  We could
>> add another quirk for the NL4XLU, but I hope this generic change can solve
>> it for many machines without having to add quirks.
>>
>> This change has been tested on Clevo X170KM-G (Konrad) and Lenovo Ideapad
>> Slim 3 (Matt) and solves the problem even when overriding the existing
>> quirks by booting with "pci=use_e820".
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565     Clevo NL4XLU
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206459#c78 Clevo X170KM-G
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1868899    Ideapad Slim 3
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2029207    X1 Carbon
>> Reported-by: Florent DELAHAYE <kernelorg@undead.fr>
>> Tested-by: Konrad J Hambrick <kjhambrick@gmail.com>
>> Tested-by: Matt Hansen <2lprbe78@duck.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/x86/platform/efi/efi.c | 46 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index ebc98a68c400..dee1852e95cd 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -303,6 +303,50 @@ static void __init efi_clean_memmap(void)
>>  	}
>>  }
>>  
>> +/*
>> + * Firmware can use EfiMemoryMappedIO to request that MMIO regions be
>> + * mapped by the OS so they can be accessed by EFI runtime services, but
>> + * should have no other significance to the OS (UEFI r2.10, sec 7.2).
>> + * However, most bootloaders and EFI stubs convert EfiMemoryMappedIO
>> + * regions to E820_TYPE_RESERVED entries, which prevent Linux from
>> + * allocating space from them (see remove_e820_regions()).
>> + *
>> + * Some platforms use EfiMemoryMappedIO entries for PCI MMCONFIG space and
>> + * PCI host bridge windows, which means Linux can't allocate BAR space for
>> + * hot-added devices.
>> + *
>> + * Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
>> + * problem.
>> + *
>> + * Retain small EfiMemoryMappedIO regions because on some platforms, these
>> + * describe non-window space that's included in host bridge _CRS.  If we
>> + * assign that space to PCI devices, they don't work.
>> + */
>> +static void __init efi_remove_e820_mmio(void)
>> +{
>> +	efi_memory_desc_t *md;
>> +	u64 size, start, end;
>> +	int i = 0;
>> +
>> +	for_each_efi_memory_desc(md) {
>> +		if (md->type == EFI_MEMORY_MAPPED_IO) {
>> +			size = md->num_pages << EFI_PAGE_SHIFT;
>> +			if (size >= 256*1024) {
>> +				start = md->phys_addr;
>> +				end = start + size - 1;
>> +				pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
>> +					i, start, end, size >> 20);
>> +				e820__range_remove(start, size,
>> +						   E820_TYPE_RESERVED, 1);
>> +			} else {
>> +				pr_info("Not removing mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluKB) from e820 map\n",
>> +					i, start, end, size >> 10);
> 
> The logging in this else is re-using the start and end from the previous section which was actually removed.
> 
> E.g. Matt's latest log from:
> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> has:
> 
> [    0.000000] e820: remove [mem 0xfc800000-0xfe7fffff] reserved
> [    0.000000] efi: Not removing mem46: MMIO range=[0xfc800000-0xfe7fffff] (4KB) from e820 map
> [    0.000000] efi: Not removing mem47: MMIO range=[0xfc800000-0xfe7fffff] (32KB) from e820 map
> [    0.000000] efi: Not removing mem49: MMIO range=[0xfc800000-0xfe7fffff] (8KB) from e820 map
> [    0.000000] efi: Not removing mem50: MMIO range=[0xfc800000-0xfe7fffff] (4KB) from e820 map
> 
> Notice how all the "Not removing ..." lines log the same range as
> the actually removed map entry above them.

I realize the fix is very obvious, but since I just fixed this in my
local tree anyways, here is my fix for this:

--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -331,9 +331,9 @@ static void __init efi_remove_e820_mmio(void)
 	for_each_efi_memory_desc(md) {
 		if (md->type == EFI_MEMORY_MAPPED_IO) {
 			size = md->num_pages << EFI_PAGE_SHIFT;
+			start = md->phys_addr;
+			end = start + size - 1;
 			if (size >= 256*1024) {
-				start = md->phys_addr;
-				end = start + size - 1;
 				pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
 					i, start, end, size >> 20);
 				e820__range_remove(start, size,

Regards,

Hans






>> +			}
>> +		}
>> +		i++;
>> +	}
>> +}
>> +
>>  void __init efi_print_memmap(void)
>>  {
>>  	efi_memory_desc_t *md;
>> @@ -474,6 +518,8 @@ void __init efi_init(void)
>>  	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>>  	efi_clean_memmap();
>>  
>> +	efi_remove_e820_mmio();
>> +
>>  	if (efi_enabled(EFI_DBG))
>>  		efi_print_memmap();
>>  }
> 

