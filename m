Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCD4343C4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 05:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJTDSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 23:18:55 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36923 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTDSy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 23:18:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Ut.VXiu_1634699798;
Received: from 30.225.212.40(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Ut.VXiu_1634699798)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 11:16:39 +0800
Message-ID: <997efa76-20b4-bf0e-2249-e5c850e52fbf@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 11:16:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/2] ACPI: APEI: Filter the PCI MCFG address with an
 arch-agnostic method
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>
References: <20211019192332.GA2381550@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211019192332.GA2381550@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 20/10/2021 03:23, Bjorn Helgaas wrote:
> [+cc Huang in case I'm misinterpreting EINJ resource requests]
> 
> On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
>> The commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
>> level") fixes the issue that the ACPI/APEI can not access the PCI MCFG
>> address on x86 platform, but this issue can also happen on other
>> architectures, for instance, we got below error message on arm64 platform:
>> ...
>> APEI: Can not request [mem 0x50100000-0x50100003] for APEI EINJ Trigger registers
> 
> I'm guessing this address is something in the MCFG area?  

Right, correct! The address 0x50100000 is within the MCFG area.

> I wish we
> could also include the matching MCFG info For x86, we put something
> like this in the dmesg log, but I guess pci_mcfg.c doesn't do this:
> 
>   PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> 
I can add the similar dmesg log in pci_mcfg.c to make it's consistent between different arches

>> This patch will try to handle this case in a more common way instead of the
>> original 'arch' specific solution, which will be beneficial to all the
>> APEI-dependent platforms after that.
> 
> This actually doesn't say anything about what the patch does or how it
> works.  It says "handles this case in a more common way" but with no
> details.

Good suggestion, I'll give more details about that...
> The EINJ table contains "injection instructions" that can read or
> write "register regions" described by generic address structures (see
> ACPI v6.3, sec 18.6.2 and 18.6.3), and __einj_error_trigger() requests
> those register regions with request_mem_region() or request_region()
> before executing the injections instructions.
> 
> IIUC, this patch basically says "if this region is part of the MCFG
> area, we don't need to reserve it." That leads to the questions of why
> we need to reserve *any* of the areas

AFAIK, the MCFG area is reserved since the ECAM module will provide a
generic Kernel Programming Interfaces(KPI), e.g, pci_generic_config_read(...),
so all the drivers are allowed to access the pci config space only by those
KPIs in a consistent and safe way, direct raw access will break the rule.
Correct me if I am missing sth.

> and why it's safe to simply skip
> reserving regions that are part of the MCFG area.

Actual there is a commit d91525eb8ee6("ACPI, EINJ: Enhance error injection tolerance
level") before to address this issue, the entire commit log as below:

    Some BIOSes utilize PCI MMCFG space read/write opertion to trigger
    specific errors. EINJ will report errors as below when hitting such
    cases:
    
    APEI: Can not request [mem 0x83f990a0-0x83f990a3] for APEI EINJ Trigger registers
    
    It is because on x86 platform ACPI based PCI MMCFG logic has
    reserved all MMCFG spaces so that EINJ can't reserve it again.
    We already trust the ACPI/APEI code when using the EINJ interface
    so it is not a big leap to also trust it to access the right
    MMCFG addresses. Skip address checking to allow the access.
    
    Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
    Signed-off-by: Tony Luck <tony.luck@intel.com>

Except that the above explanation, IMO the EINJ is only a RAS debug framework, 
in this code path, sometimes we need to acesss the address within the MCFG space
directly to trigger kind of HW error, which behavior does not like the normal
device driver's, in this case some possible unsafe operations(bypass the ecam ops)
can be mitigated because the touched device will generate some HW errors and the
RAS handling part will preempt its corresponding drivers to fix/log the HW error, 
that's my understanding about that.

> 
>> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Rafael. J. Wysocki <rafael@kernel.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>  arch/x86/pci/mmconfig-shared.c | 28 --------------------------
>>  drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
>>  2 files changed, 30 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
>> index 0b961fe6..12f7d96 100644
>> --- a/arch/x86/pci/mmconfig-shared.c
>> +++ b/arch/x86/pci/mmconfig-shared.c
>> @@ -605,32 +605,6 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>>  	return 0;
>>  }
>>  
>> -#ifdef CONFIG_ACPI_APEI
>> -extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
>> -				     void *data), void *data);
>> -
>> -static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
>> -				     void *data), void *data)
>> -{
>> -	struct pci_mmcfg_region *cfg;
>> -	int rc;
>> -
>> -	if (list_empty(&pci_mmcfg_list))
>> -		return 0;
>> -
>> -	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>> -		rc = func(cfg->res.start, resource_size(&cfg->res), data);
>> -		if (rc)
>> -			return rc;
>> -	}
>> -
>> -	return 0;
>> -}
>> -#define set_apei_filter() (arch_apei_filter_addr = pci_mmcfg_for_each_region)
>> -#else
>> -#define set_apei_filter()
>> -#endif
>> -
>>  static void __init __pci_mmcfg_init(int early)
>>  {
>>  	pci_mmcfg_reject_broken(early);
>> @@ -665,8 +639,6 @@ void __init pci_mmcfg_early_init(void)
>>  		else
>>  			acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>>  		__pci_mmcfg_init(1);
>> -
>> -		set_apei_filter();
>>  	}
>>  }
>>  
>> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
>> index c7fdb12..daae75a 100644
>> --- a/drivers/acpi/apei/apei-base.c
>> +++ b/drivers/acpi/apei/apei-base.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/init.h>
>> +#include <linux/pci.h>
>>  #include <linux/acpi.h>
>>  #include <linux/slab.h>
>>  #include <linux/io.h>
>> @@ -448,13 +449,34 @@ static int apei_get_nvs_resources(struct apei_resources *resources)
>>  	return acpi_nvs_for_each_region(apei_get_res_callback, resources);
>>  }
>>  
>> -int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
>> -				     void *data), void *data);
>> -static int apei_get_arch_resources(struct apei_resources *resources)
>> +#ifdef CONFIG_PCI
>> +extern struct list_head pci_mmcfg_list;
>> +static int apei_filter_mcfg_addr(struct apei_resources *res,
>> +			struct apei_resources *mcfg_res)
>> +{
>> +	int rc = 0;
>> +	struct pci_mmcfg_region *cfg;
>> +
>> +	if (list_empty(&pci_mmcfg_list))
>> +		return 0;
>> +
>> +	apei_resources_init(mcfg_res);
>> +	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>> +		rc = apei_res_add(&mcfg_res->iomem, cfg->res.start, resource_size(&cfg->res));
>> +		if (rc)
>> +			return rc;
>> +	}
>>  
>> +	/* filter the mcfg resource from current APEI's */
>> +	return apei_resources_sub(res, mcfg_res);
>> +}
>> +#else
>> +static inline int apei_filter_mcfg_addr(struct apei_resources *res,
>> +			struct apei_resources *mcfg_res)
>>  {
>> -	return arch_apei_filter_addr(apei_get_res_callback, resources);
>> +	return 0;
>>  }
>> +#endif
>>  
>>  /*
>>   * IO memory/port resource management mechanism is used to check
>> @@ -486,15 +508,9 @@ int apei_resources_request(struct apei_resources *resources,
>>  	if (rc)
>>  		goto nvs_res_fini;
>>  
>> -	if (arch_apei_filter_addr) {
>> -		apei_resources_init(&arch_res);
>> -		rc = apei_get_arch_resources(&arch_res);
>> -		if (rc)
>> -			goto arch_res_fini;
>> -		rc = apei_resources_sub(resources, &arch_res);
>> -		if (rc)
>> -			goto arch_res_fini;
>> -	}
>> +	rc = apei_filter_mcfg_addr(resources, &arch_res);
>> +	if (rc)
>> +		goto arch_res_fini;
>>  
>>  	rc = -EINVAL;
>>  	list_for_each_entry(res, &resources->iomem, list) {
>> @@ -544,8 +560,7 @@ int apei_resources_request(struct apei_resources *resources,
>>  		release_mem_region(res->start, res->end - res->start);
>>  	}
>>  arch_res_fini:
>> -	if (arch_apei_filter_addr)
>> -		apei_resources_fini(&arch_res);
>> +	apei_resources_fini(&arch_res);
>>  nvs_res_fini:
>>  	apei_resources_fini(&nvs_resources);
>>  	return rc;
>> -- 
>> 1.8.3.1
>>
