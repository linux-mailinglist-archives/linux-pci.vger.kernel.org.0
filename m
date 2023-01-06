Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4359165F856
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 01:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjAFAul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 19:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjAFAui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 19:50:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792561329;
        Thu,  5 Jan 2023 16:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672966237; x=1704502237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7r33uxFZaEZ3sirZC2Q1R9GU+Zmntk4xR0BpDvqw8CU=;
  b=E7vizuzeA+V/v4cd7rEeUtzFXwRZNBYCqj3oVmONixnw+RKkBW5S18xv
   RNBRPM9kC99aXuj+OUkbMUgVZ50lEeYhb13z1bEvQaxSYPzYXWMDyCyFK
   FRogTJR+Ppv18zEZeN0Gh6qTRn072aTTf+GEaWOtiIGwM4bwMpgnEFDX1
   ao0JoslQrhItAyLeQEtnYueK6EG/yqLig1ygiZxSP1JQuqgGNTVa0di78
   txCo56E8VMsnpGzRiXvIOsZoAZZ1zVqC/jE7lAbhqn0DTG3kZaks9Rl1P
   GoCa0qqrKHhMS4K/AszpFVx42W/4oQPmCEpee2d0bFY5zPeFAe96zZkIr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408619139"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408619139"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 16:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763339807"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="763339807"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2023 16:50:35 -0800
Received: from [10.252.211.52] (kliang2-mobl1.ccr.corp.intel.com [10.252.211.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 582DE580418;
        Thu,  5 Jan 2023 16:50:33 -0800 (PST)
Message-ID: <edb001f3-d685-4c57-b614-02f2c8d33ff1@linux.intel.com>
Date:   Thu, 5 Jan 2023 19:50:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, hdegoede@redhat.com, kernelorg@undead.fr,
        kjhambrick@gmail.com, 2lprbe78@duck.com,
        nicholas.johnson-opensource@outlook.com.au, benoitg@coeus.ca,
        mika.westerberg@linux.intel.com, wse@tuxedocomputers.com,
        mumblingdrunkard@protonmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.e.box@intel.com,
        yunying.sun@intel.com, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20230105223257.GA1177387@bhelgaas>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230105223257.GA1177387@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-01-05 5:32 p.m., Bjorn Helgaas wrote:
> [+cc Tony, Dan]
> 
> On Wed, Jan 04, 2023 at 09:39:56AM -0500, Liang, Kan wrote:
>> Hi Bjorn,
>>
>> Happy new year!
>>
>> We found some PCI issues with the latest 6.2-rc2.
>>
>> - Using the lspci -xxxx, the extended PCI config space of all PCI
>> devices are missed with the latest 6.2-rc2. The system we used had 932
>> PCI devices, at least 800 which have extended space as seen when booted
>> into a 5.15 kernel. But none of them appeared in 6.2-rc2.
>> - The drivers which rely on the information in the extended PCI config
>> space don't work anymore. We have confirmed that the perf uncore driver
>> (uncore performance monitoring) and Intel VSEC driver (telemetry) don't
>> work in 6.2-rc2. There could be more drivers which are impacted.
>>
>> After a bisect, we found the regression is caused by the below commit
>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
>> After reverting the commit, the issues are gone.
> 
> Can you try this patch (based on v6.2-rc1):
> 
> > commit 89a0067217b0 ("x86/pci: Treat EfiMemoryMappedIO as reservation
of ECAM space")
> parent 1b929c02afd3
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jan 5 16:02:58 2023 -0600
> 
>     x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space
>     
>     Normally we reject ECAM space unless it is reported as reserved in the E820
>     table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
>     means extended config space (offsets 0x100-0xfff) may not be accessible.
>     
>     Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
>     mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
>     normally converted to an E820 entry by a bootloader or EFI stub.
>     
>     07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
>     E820 entries that correspond to EfiMemoryMappedIO regions because some
>     other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
>     E820 entries prevent Linux from allocating BAR space for hot-added devices.
>     
>     Allow use of ECAM for extended config space when the region is covered by
>     an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
>     _CRS.
>     
>     Fixes: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
>     Link: https://lore.kernel.org/r/ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com
> 

The patch fixes the issue I reported.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 758cbfe55daa..4adc587a4c94 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/bitmap.h>
> @@ -442,6 +443,25 @@ static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
>  	return mcfg_res.flags;
>  }
>  
> +static bool is_efi_reserved(u64 start, u64 end, enum e820_type not_used)
> +{
> +	efi_memory_desc_t *md;
> +	u64 size, mmio_start, mmio_end;
> +
> +	for_each_efi_memory_desc(md) {
> +		if (md->type == EFI_MEMORY_MAPPED_IO) {
> +			size = md->num_pages << EFI_PAGE_SHIFT;
> +			mmio_start = md->phys_addr;
> +			mmio_end = mmio_start + size - 1;
> +
> +			if (mmio_start <= start && end <= mmio_end)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
>  
>  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
> @@ -452,7 +472,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  	u64 size = resource_size(&cfg->res);
>  	u64 old_size = size;
>  	int num_buses;
> -	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
> +	char *method = with_e820 ? "E820" : "ACPI motherboard resources or EFI";
>  
>  	while (!is_reserved(addr, addr + size, E820_TYPE_RESERVED)) {
>  		size >>= 1;
> @@ -502,15 +522,17 @@ pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int e
>  	if (!early && !acpi_disabled) {
>  		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
>  			return true;
> +		if (is_mmconf_reserved(is_efi_reserved, cfg, dev, 0))
> +			return true;
>  
>  		if (dev)
>  			dev_info(dev, FW_INFO
> -				 "MMCONFIG at %pR not reserved in "
> +				 "MMCONFIG at %pR not reserved in EFI "
>  				 "ACPI motherboard resources\n",
>  				 &cfg->res);
>  		else
>  			pr_info(FW_INFO PREFIX
> -			       "MMCONFIG at %pR not reserved in "
> +			       "MMCONFIG at %pR not reserved in EFI or "
>  			       "ACPI motherboard resources\n",
>  			       &cfg->res);
>  	}
