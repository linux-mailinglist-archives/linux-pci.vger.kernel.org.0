Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9745DE08
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356241AbhKYPyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 10:54:51 -0500
Received: from foss.arm.com ([217.140.110.172]:52606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356252AbhKYPwu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 10:52:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8819E1FB;
        Thu, 25 Nov 2021 07:49:34 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B2A3F73B;
        Thu, 25 Nov 2021 07:49:30 -0800 (PST)
Message-ID: <38bfa372-54c8-2e81-adab-ca24051a0fe6@arm.com>
Date:   Thu, 25 Nov 2021 15:49:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/6] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
Content-Language: en-GB
To:     Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
        helgaas@kernel.org, alexander.shishkin@linux.intel.com,
        lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     zhangshaokun@hisilicon.com, liuqi115@huawei.com,
        linuxarm@huawei.com, prime.zeng@huawei.com
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-3-yangyicong@hisilicon.com>
 <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
 <3644ad6e-d800-c84b-9d62-6dda8462450f@hisilicon.com>
 <e7d4afb7-e4e4-e581-872b-2477850ad8da@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e7d4afb7-e4e4-e581-872b-2477850ad8da@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-18 09:01, Yicong Yang via iommu wrote:
> Hi Robin,
> 
> On 2021/11/16 19:37, Yicong Yang wrote:
>> On 2021/11/16 18:56, Robin Murphy wrote:
>>> On 2021-11-16 09:06, Yicong Yang via iommu wrote:
>>> [...]
>>>> +/*
>>>> + * Get RMR address if provided by the firmware.
>>>> + * Return 0 if the IOMMU doesn't present or the policy of the
>>>> + * IOMMU domain is passthrough or we get a usable RMR region.
>>>> + * Otherwise a negative value is returned.
>>>> + */
>>>> +static int hisi_ptt_get_rmr(struct hisi_ptt *hisi_ptt)
>>>> +{
>>>> +    struct pci_dev *pdev = hisi_ptt->pdev;
>>>> +    struct iommu_domain *iommu_domain;
>>>> +    struct iommu_resv_region *region;
>>>> +    LIST_HEAD(list);
>>>> +
>>>> +    /*
>>>> +     * Use direct DMA if IOMMU does not present or the policy of the
>>>> +     * IOMMU domain is passthrough.
>>>> +     */
>>>> +    iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>>>> +    if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>>>> +        return 0;
>>>> +
>>>> +    iommu_get_resv_regions(&pdev->dev, &list);
>>>> +    list_for_each_entry(region, &list, list)
>>>> +        if (region->type == IOMMU_RESV_DIRECT &&
>>>> +            region->length >= HISI_PTT_TRACE_BUFFER_SIZE) {
>>>> +            hisi_ptt->trace_ctrl.has_rmr = true;
>>>> +            hisi_ptt->trace_ctrl.rmr_addr = region->start;
>>>> +            hisi_ptt->trace_ctrl.rmr_length = region->length;
>>>> +            break;
>>>> +        }
>>>> +
>>>> +    iommu_put_resv_regions(&pdev->dev, &list);
>>>> +    return hisi_ptt->trace_ctrl.has_rmr ? 0 : -ENOMEM;
>>>> +}
>>>
>>> No.
>>>
>>> The whole point of RMRs is for devices that are already configured to access the given address range in a manner beyond the kernel's control. If you can do this, it proves that you should not have an RMR in the first place.
>>>
>>> The notion of a kernel driver explicitly configuring its device to DMA into any random RMR that looks big enough is so egregiously wrong that I'm almost lost for words...
>>>
>>
>> our bios will reserve such a region and reported it through iort. the device will write to the region and in the driver we need to access the region
>> to get the traced data. the region is reserved exclusively and will not be accessed by kernel or other devices.
>>
>> is it ok to let bios configure the address to the device and from CPU side we just read it?
>>
> 
> Any suggestion?  Is this still an issue you concern if we move the configuration of the device address to BIOS and just read from the CPU side?

If the firmware configures the device so that it's actively tracing and 
writing out to memory while the kernel boots, then that is a valid 
reason to have an RMR. However what you're doing in the driver is still 
complete nonsense. As far as I can follow, the way it's working is this:

- At probe time, the initial state of the hardware is entirely ignored. 
If it *is* already active, there appears to be a fun chance of crashing 
if TRACE_INT_MASK is clear and an interrupt happens to fire before 
anyone has got round to calling perf_aux_output_begin() to make 
trace_ctrl.handle.rb non-NULL.

- Later, once the user starts a tracing session, a buffer is set up 
*either* as a completely normal DMA allocation, or by memremap()ing some 
random IOVA carveout which may or may not be whatever memory the 
firmware was tracing to.

- The hardware is then reset and completely reprogrammed to use the new 
buffer, again without any consideration of its previous state (other 
than possibly timing out and failing if it's already running and that 
means it never goes idle).

Therefore the driver does not seem to respect any prior configuration of 
the device by firmware, does not seem to expect it to be running at boot 
time, does not seem to have any way to preserve and export any trace 
data captured in an RMR if it *was* running at boot time, and thus 
without loss of generality could simply use the dma_alloc_coherent() 
path all the time. Am I missing anything?

As things stand, RMRs are not yet supported upstream (FYI we're still 
working on fixing the spec...), so the code above is at best dead, and 
at worst actively wrong. Furthermore, if the expected usage model *is* 
that the kernel driver completely resets and reprograms the hardware, 
then even if there is an RMR for boot-time tracing I would rather expect 
it to be flagged as remappable, and thus potentially end up as an 
IOMMU_RESV_DIRECT_RELAXABLE reservation which you wouldn't match anyway.

And after all that, if you really do have a genuine need to respect and 
preserve prior firmware configuration of the device, then I would surely 
expect to see the driver actually doing exactly that. Presumably: at 
probe time, look at TRACE_CTRL; if the device is already configured, 
read out that configuration - especially including TRACE_ADDR_* - and 
make sure to reuse it. Not go off on a tangent blindly poking into 
internal IOMMU API abstractions in the vain hope that the first thing 
you find happens to be sort-of-related to the information that you 
actually care about.

Thanks,
Robin.
