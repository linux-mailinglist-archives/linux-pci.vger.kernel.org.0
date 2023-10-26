Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9197D87FC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJZSGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZSGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 14:06:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6836C2;
        Thu, 26 Oct 2023 11:06:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCB252F4;
        Thu, 26 Oct 2023 11:07:16 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D78E3F738;
        Thu, 26 Oct 2023 11:06:33 -0700 (PDT)
Message-ID: <6790b6ea-4874-4a8c-a8fd-d9ab6caaf1d4@arm.com>
Date:   Thu, 26 Oct 2023 19:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-GB
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@huawei.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <20231023123202.GA3515@willie-the-truck>
 <cf72afb6-44c7-45f0-bfaa-6881f6782ebf@arm.com>
 <5b695595-d243-4ea5-97bb-f4c74398fc27@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5b695595-d243-4ea5-97bb-f4c74398fc27@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/10/2023 10:29 am, Shuai Xue wrote:
> + Will, Jonathan, Bjorn and Yicong for probe and hotplug handing.
> 
> On 2023/10/24 02:51, Robin Murphy wrote:
>> On 2023-10-23 13:32, Will Deacon wrote:
>> [...]
>>>> +
>>>> +    /*
>>>> +     * The Group#1 event measures the amount of data processed in 16-byte
>>>> +     * units. Simplify the end-user interface by multiplying the counter
>>>> +     * at the point of read.
>>>> +     */
>>>> +    if (event_id >= 0x20 && event_id <= 0x23)
>>>> +        return (((u64)hi << 32) | lo) << 4;
>>>> +    else
>>>> +        return (((u64)hi << 32) | lo);
>>>
>>> nit, but I think it would be clearer to do:
>>>
>>>      ret = ((u64)hi << 32) | lo;
>>>
>>>      /* ... */
>>>      if (event_id >= 0x20 && event_id <= 0x23)
>>>          ret <<= 4;
>>
>> Nit: "ret *= 16;" since the comment says it's multiplying a value, not moving a bitfield. The compiler already knows the most efficient way to implement constant multiplication.
> 
> Cool, will use multiplication directly.
> 
>>
>>>
>>>      return ret;
>>>
>> [...]
>>>> +static int __init dwc_pcie_pmu_init(void)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>>>> +                      "perf/dwc_pcie_pmu:online",
>>>> +                      dwc_pcie_pmu_online_cpu,
>>>> +                      dwc_pcie_pmu_offline_cpu);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    dwc_pcie_pmu_hp_state = ret;
>>>> +
>>>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
>>>> +    if (ret)
>>>> +        goto platform_driver_register_err;
>>>> +
>>>> +    dwc_pcie_pmu_dev = platform_device_register_simple(
>>>> +                "dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>>>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
>>>> +        ret = PTR_ERR(dwc_pcie_pmu_dev);
>>>> +        goto platform_device_register_error;
>>>> +    }
>>>
>>> I'm a bit confused as to why you're having to create a platform device
>>> for a PCI device -- is this because the main designware driver has already
>>> bound to it? A comment here explaining why you need to do this would be
>>> very helpful. In particular, is there any dependency on another driver
>>> to make sure that e.g. config space accesses work properly? If so, we
>>> probably need to enforce module load ordering or something like that.
>>
>> AFAICS the platform device/driver serve no purpose other than being a hilariously roundabout way to run the for_each_pci_dev() loop in dwc_pcie_pmu_probe() upon module init, and to save explicitly freeing the PMU name/data. Furthermore the devres action for dwc_pcie_pmu_remove_cpuhp_instance() is apparently going for even more style points at module exit by not even relying on the corresponding .remove callback of the tenuous platform driver to undo what its .probe did, but (ab)using the device's devres list to avoid having to keep track of an explicit list of PMU instances at all.
> 
> You are right.
> 
>>
>> Frankly I think it would be a lot more straightforward to just maintain that explicit list of PMU instances, do the PMU creation directly in dwc_pcie_pmu_init(), then unregister and free them in dwc_pcie_pmu_exit(). Not every driver has to contain a literal struct device_driver.
> 
> Agreed, it might be more straightforward. But personally speaking, I prefer
> current implementation.
> 
>      - standard driver creation / probe flow is more normal

It's really not, though. We have a weird singleton platform device 
appearing out of nowhere which effectively represents the module being 
loaded, rather than anything about the actual underlying hardware. If 
you want this to look like "normal" driver model usage, then create a 
separate platform device for each physical PCI PMU instance you discover 
(potentially via both a one-time scan at module_init and an ADD_DEVICE 
hotplug notifier later), then have the platform driver just register the 
corresponding PMU device in .probe and unregister it in .remove, without 
confusing devres action tricks.

Thanks,
Robin.

>      - it avoid maintaining list of PMU instances
>      - IMHO, both of them are temporary solution, if PCI core addes a
>        standard mechanism to discover and enbale PCIe VSEC/DVSEC capability,
>        the driver will use the standard way.
> 
> 
>>
>> It also smells a bit odd that it handles PCI hot-remove but not hot-add - if the underlying device really is hotpluggable, wouldn't we also want to handle new ones turning up after module load? Conversely if it isn't, why pretend to handle it being removed? Even if it's not to do with physical hotplug of the PMU but with the user unloading the PCI controller driver itself (since there's no module/driver-level dependency enforced) and thus tearing down the whole PCI bus, then the same point still applies - if that *can* happen, then what if the user then re-loads it again, or indeed if this module loads first to begin with; wouldn't we want to be able to (re-)discover the PMUs rather than leave the whole PMU driver degraded to a useless state?
>>
> 
> I see you point, there are three casees:
> 1. hot-remove PCI root port firstly and then load the PMU module, the PMU
> of the removed PCI device will not be registered.
> 
> I think it is the expected behavior.
> 
> 2. load the PMU module firstly and then hot-remove PCI root port, the PMU
> of the removed PCI device will be unregistered.
> 
> it is what the dwc_pcie_pmu_unregister_nb() does upon BUS_NOTIFY_DEL_DEVICE
> 
> 3. load the PMU module firstly, hot-remove PCI root port, and then hot-plug
> the PCI root port the PMU of the hot-pluged device will not load again by
> current design upon BUS_NOTIFY_DEL_DEVICE.
> 
> I guess it is the really problem. It can be workaround be reload the PMU
> module. It has been a bit complex around how the following interact:
> 
>      - Driver loading/unloading
>      - CPU hotplug events
>      - PCI device add/del events
> 
> We can also add action for BUS_NOTIFY_ADD_DEVICE to address the problem,
> 
>      - scan all PCI device
>       - check RAS_DES cap
>       - check cached PMU node
>       - registers its PMU
> 
> But I prefer leave as it is, just as x86 does in uncore_bus_notify().
> Certainly, if the community deems it necessary to implement
> BUS_NOTIFY_ADD_DEVICE action, I also would like to extend it.
