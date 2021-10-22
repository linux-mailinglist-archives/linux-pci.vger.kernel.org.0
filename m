Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D7437513
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 11:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhJVJyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 05:54:37 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34990 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhJVJyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 05:54:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UtFIpYa_1634896335;
Received: from 30.25.215.124(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UtFIpYa_1634896335)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 17:52:16 +0800
Message-ID: <36685ccd-f1d6-5db4-f282-878d29515f8b@linux.alibaba.com>
Date:   Fri, 22 Oct 2021 17:52:15 +0800
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
References: <20211021165755.GA2697570@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211021165755.GA2697570@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 22/10/2021 00:57, Bjorn Helgaas wrote:
> On Thu, Oct 21, 2021 at 11:46:40PM +0800, Xuesong Chen wrote:
>> On 21/10/2021 02:50, Bjorn Helgaas wrote:
>>> On Wed, Oct 20, 2021 at 11:16:38AM +0800, Xuesong Chen wrote:
>>>> On 20/10/2021 03:23, Bjorn Helgaas wrote:
>>>>> On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
> 
>>>>>> This patch will try to handle this case in a more common way
>>>>>> instead of the original 'arch' specific solution, which will be
>>>>>> beneficial to all the APEI-dependent platforms after that.
>>>>>
>>>>> This actually doesn't say anything about what the patch does or
>>>>> how it works.  It says "handles this case in a more common way"
>>>>> but with no details.
>>>>
>>>> Good suggestion, I'll give more details about that...
>>>>
>>>>> The EINJ table contains "injection instructions" that can read
>>>>> or write "register regions" described by generic address
>>>>> structures (see ACPI v6.3, sec 18.6.2 and 18.6.3), and
>>>>> __einj_error_trigger() requests those register regions with
>>>>> request_mem_region() or request_region() before executing the
>>>>> injections instructions.
>>>>>
>>>>> IIUC, this patch basically says "if this region is part of the
>>>>> MCFG area, we don't need to reserve it." That leads to the
>>>>> questions of why we need to reserve *any* of the areas
>>>>
>>>> AFAIK, the MCFG area is reserved since the ECAM module will
>>>> provide a generic Kernel Programming Interfaces(KPI), e.g,
>>>> pci_generic_config_read(...), so all the drivers are allowed to
>>>> access the pci config space only by those KPIs in a consistent
>>>> and safe way, direct raw access will break the rule.  Correct me
>>>> if I am missing sth.
>>>>
>>>>> and why it's safe to simply skip reserving regions that are part
>>>>> of the MCFG area.
>>>>
>>>> Actual there is a commit d91525eb8ee6("ACPI, EINJ: Enhance error
>>>> injection tolerance level") before to address this issue, the
>>>> entire commit log as below:
>>>>
>>>>     Some BIOSes utilize PCI MMCFG space read/write opertion to trigger
>>>>     specific errors. EINJ will report errors as below when hitting such
>>>>     cases:
>>>>     
>>>>     APEI: Can not request [mem 0x83f990a0-0x83f990a3] for APEI EINJ Trigger registers
>>>>     
>>>>     It is because on x86 platform ACPI based PCI MMCFG logic has
>>>>     reserved all MMCFG spaces so that EINJ can't reserve it again.
>>>>     We already trust the ACPI/APEI code when using the EINJ interface
>>>>     so it is not a big leap to also trust it to access the right
>>>>     MMCFG addresses. Skip address checking to allow the access.
>>>
>>> I'm not really convinced by that justification because I don't
>>> think the issue here is *trust*.  If all we care about is trust,
>>> and we trust the ACPI/APEI code, why do we need to reserve
>>> anything at all when executing EINJ actions?
>>>
>>> I think the resource reservation issue is about coordinating
>>> multiple users of the address space.  A driver reserves the MMIO
>>> address space of a device it controls so no other driver can
>>> reserve it at the same time and cause conflicts.
>>>
>>> I'm not really convinced by this mutual exclusion argument either,
>>> because I haven't yet seen a situation where we say "EINJ needs a
>>> resource that's already in use by somebody else, so we can't use
>>> EINJ."  When conflicts arise, the response is always "we'll just
>>> stop reserving this conflicting resource but use it anyway."
>>>
>>> I think the only real value in apei_resources_request() is a
>>> little bit of documentation in /proc/iomem.  For ERST and EINJ,
>>> even that only lasts for the tiny period when we're actually
>>> executing an action.
>>>
>>> So convince me there's a reason why we shouldn't just remove
>>> apei_resources_request() completely :)
>>
>> I have to confess that currently I have no strong evidence/reason to
>> convince you that it's absolute safe to remove
>> apei_resources_request(),  probably in some conditions it *does*
>> require to follow the mutual exclusion usage model.  The ECAM/MCFG
>> maybe a special case not like other normal device driver, since all
>> its MCFG space has been reserved during the initialization. Anyway,
>> it's another topic and good point well worth discussing in the
>> future.
> 
> This is missing the point.  It's not the MCFG reservation during
> initialization that would make this safe.  What would make it safe is
> the fact that ECAM does not require mutual exclusion.
> 
> When the hardware implements ECAM correctly, PCI config accesses do
> not require locking because a config access requires a single MMIO
> load or store.
> 
I don't quite understand here, we're talking about apei_resources_request()
which is a mechanism to void resource conflict,"request_mem_region() tells the
kernel that your driver is going to use this range of I/O addresses, which
will prevent other drivers to make any overlapping call to the same region
through request_mem_region()", but according to the context of 'a single MMIO
load or store', are you talking about something like the mutex lock primitive?

> Many non-ECAM config accessors *do* require locking because they use
> several register accesses, e.g., the 0xCF8/0xCFC address/data pairs
> used by pci_conf1_read().  If EINJ actions used these, we would have
> to enforce mutual exclusion between EINJ config accesses and those
> done by other drivers.

I take a look at the pci_conf1_read() function, there's only a pair of
raw_spin_lock_irqsave() and raw_spin_unlock_irqrestore(), if that's the
mutual exclusion you mentioned, seems it's not related to the
apei_resources_request() we're talking about... 

> 
> Some ARM64 platforms do not implement ECAM correctly, e.g.,
> tegra194_map_bus() programs an outbound ATU and xgene_pcie_map_bus()
> sets an RTDID register before the MMIO load/store.  Platforms like
> this *do* require mutual exclusion between an EINJ config access and
> other config accesses.

What's the mutual exclusion for those quirk functions(tegra194 and xgene)?
*mutual* is not applied for single side. I can see neither locking nor
request_mem_region() in those bus map functions. 
> 
> These platforms are supported via quirks in pci_mcfg.c, so they will
> have resources in the pci_mcfg_list, and if we just ignore all the
> MCFG resources in apei_resources_request(), there will be nothing to
> prevent ordinary driver config accesses from being corrupted by EINJ
> accesses.
> 
> I think in general, is probably *is* safe to remove MCFG resources
> from the APEI reservations, but it would be better if we had some way
> to prevent EINJ from using MCFG on platforms like tegra194 and xgene.

Just as I mentioned, since there's no mutual exclusion applied for the
tegra194 and xgene(correct me if I am wrong), putting their MCFG resources
into the APEI reservation(so the apei_resources_request() applied) does nothing 

Thanks,
Xuesong
> 
>> From the patch set itself, I don't think it's a nice idea to make a
>> dramatic change regarding the apei_resources_request() part, I
>> suggest to keep the original rationale untouched and based on that
>> to fix the real issue at hand in a more generic way.
> 
> There *was* no original rationale.  The whole point of this
> conversation is to figure out what the real rationale is.
> 
>>>> Except that the above explanation, IMO the EINJ is only a RAS
>>>> debug framework, in this code path, sometimes we need to acesss
>>>> the address within the MCFG space directly to trigger kind of HW
>>>> error, which behavior does not like the normal device driver's,
>>>> in this case some possible unsafe operations (bypass the ecam
>>>> ops) can be mitigated because the touched device will generate
>>>> some HW errors and the RAS handling part will preempt its
>>>> corresponding drivers to fix/log the HW error, that's my
>>>> understanding about that.
>>>
>>>>>> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: James Morse <james.morse@arm.com>
>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>> Cc: Rafael. J. Wysocki <rafael@kernel.org>
>>>>>> Cc: Tony Luck <tony.luck@intel.com>
>>>>>> Cc: Tomasz Nowicki <tn@semihalf.com>
>>>>>> ---
>>>>>>  arch/x86/pci/mmconfig-shared.c | 28 --------------------------
>>>>>>  drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
>>>>>>  2 files changed, 30 insertions(+), 43 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
>>>>>> index 0b961fe6..12f7d96 100644
>>>>>> --- a/arch/x86/pci/mmconfig-shared.c
>>>>>> +++ b/arch/x86/pci/mmconfig-shared.c
>>>>>> @@ -605,32 +605,6 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> -#ifdef CONFIG_ACPI_APEI
>>>>>> -extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
>>>>>> -				     void *data), void *data);
>>>>>> -
>>>>>> -static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
>>>>>> -				     void *data), void *data)
>>>>>> -{
>>>>>> -	struct pci_mmcfg_region *cfg;
>>>>>> -	int rc;
>>>>>> -
>>>>>> -	if (list_empty(&pci_mmcfg_list))
>>>>>> -		return 0;
>>>>>> -
>>>>>> -	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>>>>>> -		rc = func(cfg->res.start, resource_size(&cfg->res), data);
>>>>>> -		if (rc)
>>>>>> -			return rc;
>>>>>> -	}
>>>>>> -
>>>>>> -	return 0;
>>>>>> -}
>>>>>> -#define set_apei_filter() (arch_apei_filter_addr = pci_mmcfg_for_each_region)
>>>>>> -#else
>>>>>> -#define set_apei_filter()
>>>>>> -#endif
>>>>>> -
>>>>>>  static void __init __pci_mmcfg_init(int early)
>>>>>>  {
>>>>>>  	pci_mmcfg_reject_broken(early);
>>>>>> @@ -665,8 +639,6 @@ void __init pci_mmcfg_early_init(void)
>>>>>>  		else
>>>>>>  			acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>>>>>>  		__pci_mmcfg_init(1);
>>>>>> -
>>>>>> -		set_apei_filter();
>>>>>>  	}
>>>>>>  }
>>>>>>  
>>>>>> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
>>>>>> index c7fdb12..daae75a 100644
>>>>>> --- a/drivers/acpi/apei/apei-base.c
>>>>>> +++ b/drivers/acpi/apei/apei-base.c
>>>>>> @@ -21,6 +21,7 @@
>>>>>>  #include <linux/kernel.h>
>>>>>>  #include <linux/module.h>
>>>>>>  #include <linux/init.h>
>>>>>> +#include <linux/pci.h>
>>>>>>  #include <linux/acpi.h>
>>>>>>  #include <linux/slab.h>
>>>>>>  #include <linux/io.h>
>>>>>> @@ -448,13 +449,34 @@ static int apei_get_nvs_resources(struct apei_resources *resources)
>>>>>>  	return acpi_nvs_for_each_region(apei_get_res_callback, resources);
>>>>>>  }
>>>>>>  
>>>>>> -int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
>>>>>> -				     void *data), void *data);
>>>>>> -static int apei_get_arch_resources(struct apei_resources *resources)
>>>>>> +#ifdef CONFIG_PCI
>>>>>> +extern struct list_head pci_mmcfg_list;
>>>>>> +static int apei_filter_mcfg_addr(struct apei_resources *res,
>>>>>> +			struct apei_resources *mcfg_res)
>>>>>> +{
>>>>>> +	int rc = 0;
>>>>>> +	struct pci_mmcfg_region *cfg;
>>>>>> +
>>>>>> +	if (list_empty(&pci_mmcfg_list))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	apei_resources_init(mcfg_res);
>>>>>> +	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>>>>>> +		rc = apei_res_add(&mcfg_res->iomem, cfg->res.start, resource_size(&cfg->res));
>>>>>> +		if (rc)
>>>>>> +			return rc;
>>>>>> +	}
>>>>>>  
>>>>>> +	/* filter the mcfg resource from current APEI's */
>>>>>> +	return apei_resources_sub(res, mcfg_res);
>>>>>> +}
>>>>>> +#else
>>>>>> +static inline int apei_filter_mcfg_addr(struct apei_resources *res,
>>>>>> +			struct apei_resources *mcfg_res)
>>>>>>  {
>>>>>> -	return arch_apei_filter_addr(apei_get_res_callback, resources);
>>>>>> +	return 0;
>>>>>>  }
>>>>>> +#endif
>>>>>>  
>>>>>>  /*
>>>>>>   * IO memory/port resource management mechanism is used to check
>>>>>> @@ -486,15 +508,9 @@ int apei_resources_request(struct apei_resources *resources,
>>>>>>  	if (rc)
>>>>>>  		goto nvs_res_fini;
>>>>>>  
>>>>>> -	if (arch_apei_filter_addr) {
>>>>>> -		apei_resources_init(&arch_res);
>>>>>> -		rc = apei_get_arch_resources(&arch_res);
>>>>>> -		if (rc)
>>>>>> -			goto arch_res_fini;
>>>>>> -		rc = apei_resources_sub(resources, &arch_res);
>>>>>> -		if (rc)
>>>>>> -			goto arch_res_fini;
>>>>>> -	}
>>>>>> +	rc = apei_filter_mcfg_addr(resources, &arch_res);
>>>>>> +	if (rc)
>>>>>> +		goto arch_res_fini;
>>>>>>  
>>>>>>  	rc = -EINVAL;
>>>>>>  	list_for_each_entry(res, &resources->iomem, list) {
>>>>>> @@ -544,8 +560,7 @@ int apei_resources_request(struct apei_resources *resources,
>>>>>>  		release_mem_region(res->start, res->end - res->start);
>>>>>>  	}
>>>>>>  arch_res_fini:
>>>>>> -	if (arch_apei_filter_addr)
>>>>>> -		apei_resources_fini(&arch_res);
>>>>>> +	apei_resources_fini(&arch_res);
>>>>>>  nvs_res_fini:
>>>>>>  	apei_resources_fini(&nvs_resources);
>>>>>>  	return rc;
>>>>>> -- 
>>>>>> 1.8.3.1
>>>>>>
