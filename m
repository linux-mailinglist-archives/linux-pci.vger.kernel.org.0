Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274AE43AEDA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 11:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhJZJTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 05:19:18 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37832 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234550AbhJZJTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 05:19:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UtlbGpV_1635239808;
Received: from 30.225.212.42(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UtlbGpV_1635239808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 17:16:48 +0800
Message-ID: <1e186336-aa68-d845-307e-aa6e1133322f@linux.alibaba.com>
Date:   Tue, 26 Oct 2021 17:16:47 +0800
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
References: <20211025233737.GA50860@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211025233737.GA50860@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 26/10/2021 07:37, Bjorn Helgaas wrote:
> On Fri, Oct 22, 2021 at 05:52:15PM +0800, Xuesong Chen wrote:
>> On 22/10/2021 00:57, Bjorn Helgaas wrote:
>>> On Thu, Oct 21, 2021 at 11:46:40PM +0800, Xuesong Chen wrote:
>>>> On 21/10/2021 02:50, Bjorn Helgaas wrote:
>>>>> On Wed, Oct 20, 2021 at 11:16:38AM +0800, Xuesong Chen wrote:
>>>>>> On 20/10/2021 03:23, Bjorn Helgaas wrote:
>>>>>>> On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
>>>
>>>>>>>> This patch will try to handle this case in a more common way
>>>>>>>> instead of the original 'arch' specific solution, which will be
>>>>>>>> beneficial to all the APEI-dependent platforms after that.
>>>>>>>
>>>>>>> This actually doesn't say anything about what the patch does or
>>>>>>> how it works.  It says "handles this case in a more common way"
>>>>>>> but with no details.
>>>>>>
>>>>>> Good suggestion, I'll give more details about that...
>>>>>>
>>>>>>> The EINJ table contains "injection instructions" that can read
>>>>>>> or write "register regions" described by generic address
>>>>>>> structures (see ACPI v6.3, sec 18.6.2 and 18.6.3), and
>>>>>>> __einj_error_trigger() requests those register regions with
>>>>>>> request_mem_region() or request_region() before executing the
>>>>>>> injections instructions.
>>>>>>>
>>>>>>> IIUC, this patch basically says "if this region is part of the
>>>>>>> MCFG area, we don't need to reserve it." That leads to the
>>>>>>> questions of why we need to reserve *any* of the areas
>>>>>>
>>>>>> AFAIK, the MCFG area is reserved since the ECAM module will
>>>>>> provide a generic Kernel Programming Interfaces(KPI), e.g,
>>>>>> pci_generic_config_read(...), so all the drivers are allowed to
>>>>>> access the pci config space only by those KPIs in a consistent
>>>>>> and safe way, direct raw access will break the rule.  Correct me
>>>>>> if I am missing sth.
>>>>>>
>>>>>>> and why it's safe to simply skip reserving regions that are part
>>>>>>> of the MCFG area.
>>>>>>
>>>>>> Actual there is a commit d91525eb8ee6("ACPI, EINJ: Enhance error
>>>>>> injection tolerance level") before to address this issue, the
>>>>>> entire commit log as below:
>>>>>>
>>>>>>     Some BIOSes utilize PCI MMCFG space read/write opertion to trigger
>>>>>>     specific errors. EINJ will report errors as below when hitting such
>>>>>>     cases:
>>>>>>     
>>>>>>     APEI: Can not request [mem 0x83f990a0-0x83f990a3] for APEI EINJ Trigger registers
>>>>>>     
>>>>>>     It is because on x86 platform ACPI based PCI MMCFG logic has
>>>>>>     reserved all MMCFG spaces so that EINJ can't reserve it again.
>>>>>>     We already trust the ACPI/APEI code when using the EINJ interface
>>>>>>     so it is not a big leap to also trust it to access the right
>>>>>>     MMCFG addresses. Skip address checking to allow the access.
>>>>>
>>>>> I'm not really convinced by that justification because I don't
>>>>> think the issue here is *trust*.  If all we care about is trust,
>>>>> and we trust the ACPI/APEI code, why do we need to reserve
>>>>> anything at all when executing EINJ actions?
>>>>>
>>>>> I think the resource reservation issue is about coordinating
>>>>> multiple users of the address space.  A driver reserves the MMIO
>>>>> address space of a device it controls so no other driver can
>>>>> reserve it at the same time and cause conflicts.
>>>>>
>>>>> I'm not really convinced by this mutual exclusion argument either,
>>>>> because I haven't yet seen a situation where we say "EINJ needs a
>>>>> resource that's already in use by somebody else, so we can't use
>>>>> EINJ."  When conflicts arise, the response is always "we'll just
>>>>> stop reserving this conflicting resource but use it anyway."
>>>>>
>>>>> I think the only real value in apei_resources_request() is a
>>>>> little bit of documentation in /proc/iomem.  For ERST and EINJ,
>>>>> even that only lasts for the tiny period when we're actually
>>>>> executing an action.
>>>>>
>>>>> So convince me there's a reason why we shouldn't just remove
>>>>> apei_resources_request() completely :)
>>>>
>>>> I have to confess that currently I have no strong evidence/reason to
>>>> convince you that it's absolute safe to remove
>>>> apei_resources_request(),  probably in some conditions it *does*
>>>> require to follow the mutual exclusion usage model.  The ECAM/MCFG
>>>> maybe a special case not like other normal device driver, since all
>>>> its MCFG space has been reserved during the initialization. Anyway,
>>>> it's another topic and good point well worth discussing in the
>>>> future.
>>>
>>> This is missing the point.  It's not the MCFG reservation during
>>> initialization that would make this safe.  What would make it safe is
>>> the fact that ECAM does not require mutual exclusion.
>>>
>>> When the hardware implements ECAM correctly, PCI config accesses do
>>> not require locking because a config access requires a single MMIO
>>> load or store.
>>
>> I don't quite understand here, we're talking about
>> apei_resources_request() which is a mechanism to void resource
>> conflict,"request_mem_region() tells the kernel that your driver is
>> going to use this range of I/O addresses, which will prevent other
>> drivers to make any overlapping call to the same region through
>> request_mem_region()", but according to the context of 'a single
>> MMIO load or store', are you talking about something like the mutex
>> lock primitive?
> 
> My point was that when ECAM is implemented correctly, a CPU does a
> single MMIO load to do a PCI config read and a single MMIO store to do
> a PCI config write.  In that case there no need for any locking, so
> there's no need for APEI to reserve those resources.

Ah, got it. That means the PCI ECAM has a implicit mutual exclusion with EINJ
if the hardware implemention is correct, so we can remove the MCFG from
the APEI's safely.

> 
> This is what d91525eb8ee6 ("ACPI, EINJ: Enhance error injection
> tolerance level") does.  That code change makes sense, but the commit
> log does not -- it has nothing to do with trusting the ACPI/APEI code;
> it's just that no matter what the EINJ actions do with the MCFG
> regions, they cannot interfere with other drivers.
> 
>>> Many non-ECAM config accessors *do* require locking because they use
>>> several register accesses, e.g., the 0xCF8/0xCFC address/data pairs
>>> used by pci_conf1_read().  If EINJ actions used these, we would have
>>> to enforce mutual exclusion between EINJ config accesses and those
>>> done by other drivers.
>>
>> I take a look at the pci_conf1_read() function, there's only a pair of
>> raw_spin_lock_irqsave() and raw_spin_unlock_irqrestore(), if that's the
>> mutual exclusion you mentioned, seems it's not related to the
>> apei_resources_request() we're talking about... 
> 
> This was an example of a case where EINJ mutual exclusion *would* be
> required.  I do not expect EINJ actions to use the 0xCF8/0xCFC
> registers because there is no mechanism to coordinate that with the OS
> use of the same registers.
> 
>>> Some ARM64 platforms do not implement ECAM correctly, e.g.,
>>> tegra194_map_bus() programs an outbound ATU and xgene_pcie_map_bus()
>>> sets an RTDID register before the MMIO load/store.  Platforms like
>>> this *do* require mutual exclusion between an EINJ config access and
>>> other config accesses.
>>
>> What's the mutual exclusion for those quirk functions (tegra194 and
>> xgene)?  *mutual* is not applied for single side. I can see neither
>> locking nor request_mem_region() in those bus map functions. 
> 
> These currently depend on the pci_lock.  See PCI_OP_READ() in
> drivers/pci/access.c.
> 
> EINJ actions cannot acquire the pci_lock, so EINJ actions cannot
> safely use ECAM space on those platforms> 
>>> These platforms are supported via quirks in pci_mcfg.c, so they will
>>> have resources in the pci_mcfg_list, and if we just ignore all the
>>> MCFG resources in apei_resources_request(), there will be nothing to
>>> prevent ordinary driver config accesses from being corrupted by EINJ
>>> accesses.
>>>
>>> I think in general, is probably *is* safe to remove MCFG resources
>>> from the APEI reservations, but it would be better if we had some way
>>> to prevent EINJ from using MCFG on platforms like tegra194 and xgene.
>>
>> Just as I mentioned, since there's no mutual exclusion applied for
>> the tegra194 and xgene (correct me if I am wrong), putting their MCFG
>> resources into the APEI reservation (so the apei_resources_request()
>> applied) does nothing 
> 
> I think apei_resources_request() should continue to reserve MCFG areas
> on tegra194 and xgene, but it does not need to reserve them on other
> ARM64 platforms.

As a summary: we need to reserve the MCFG areas on those platforms with a
quirk ECAM implementation since there's no lockless method to access the
configuration space, on other platforms we don't need to reserve the MCFG
resources (so can remove it safely).

So we need to add another patch to handle the case of tegra194 and xgene...
I will try to figure it out. 


Thanks,
Xuesong

> 
> Bjorn
> 
