Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33B7DB257
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 04:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJ3DxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Oct 2023 23:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3DxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2023 23:53:12 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51209B;
        Sun, 29 Oct 2023 20:53:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vv5D-ur_1698637982;
Received: from 30.240.112.195(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vv5D-ur_1698637982)
          by smtp.aliyun-inc.com;
          Mon, 30 Oct 2023 11:53:03 +0800
Message-ID: <889576c1-4761-4329-9f3b-63a2930c391d@linux.alibaba.com>
Date:   Mon, 30 Oct 2023 11:53:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
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
 <6790b6ea-4874-4a8c-a8fd-d9ab6caaf1d4@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <6790b6ea-4874-4a8c-a8fd-d9ab6caaf1d4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/27 02:06, Robin Murphy wrote:
...
>>>>      return ret;
>>>>
>>> [...]
>>>>> +static int __init dwc_pcie_pmu_init(void)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>>>>> +                      "perf/dwc_pcie_pmu:online",
>>>>> +                      dwc_pcie_pmu_online_cpu,
>>>>> +                      dwc_pcie_pmu_offline_cpu);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    dwc_pcie_pmu_hp_state = ret;
>>>>> +
>>>>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
>>>>> +    if (ret)
>>>>> +        goto platform_driver_register_err;
>>>>> +
>>>>> +    dwc_pcie_pmu_dev = platform_device_register_simple(
>>>>> +                "dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>>>>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
>>>>> +        ret = PTR_ERR(dwc_pcie_pmu_dev);
>>>>> +        goto platform_device_register_error;
>>>>> +    }
>>>>
>>>> I'm a bit confused as to why you're having to create a platform device
>>>> for a PCI device -- is this because the main designware driver has already
>>>> bound to it? A comment here explaining why you need to do this would be
>>>> very helpful. In particular, is there any dependency on another driver
>>>> to make sure that e.g. config space accesses work properly? If so, we
>>>> probably need to enforce module load ordering or something like that.
>>>
>>> AFAICS the platform device/driver serve no purpose other than being a hilariously roundabout way to run the for_each_pci_dev() loop in dwc_pcie_pmu_probe() upon module init, and to save explicitly freeing the PMU name/data. Furthermore the devres action for dwc_pcie_pmu_remove_cpuhp_instance() is apparently going for even more style points at module exit by not even relying on the corresponding .remove callback of the tenuous platform driver to undo what its .probe did, but (ab)using the device's devres list to avoid having to keep track of an explicit list of PMU instances at all.
>>
>> You are right.
>>
>>>
>>> Frankly I think it would be a lot more straightforward to just maintain that explicit list of PMU instances, do the PMU creation directly in dwc_pcie_pmu_init(), then unregister and free them in dwc_pcie_pmu_exit(). Not every driver has to contain a literal struct device_driver.
>>
>> Agreed, it might be more straightforward. But personally speaking, I prefer
>> current implementation.
>>
>>      - standard driver creation / probe flow is more normal
> 
> It's really not, though. We have a weird singleton platform device appearing out of nowhere which effectively represents the module being loaded, rather than anything about the actual underlying hardware. If you want this to look like "normal" driver model usage, then create a separate platform device for each physical PCI PMU instance you discover (potentially via both a one-time scan at module_init and an ADD_DEVICE hotplug notifier later), then have the platform driver just register the corresponding PMU device in .probe and unregister it in .remove, without confusing devres action tricks.
> 

Got it. If IIUC, I should register a platform device for each matched pci
device in module_init() or when BUS_NOTIFY_ADD_DEVICE event triggered, and
unwind it in module exit() and when BUS_NOTIFY_DEL_DEVICE event triggered.

Thank you for valuable comments.

Best Regards,
Shuai
