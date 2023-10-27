Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57C7D97ED
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 14:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJ0MZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0MZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 08:25:29 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081B10A;
        Fri, 27 Oct 2023 05:25:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vv-ygIX_1698409518;
Received: from 30.240.112.233(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vv-ygIX_1698409518)
          by smtp.aliyun-inc.com;
          Fri, 27 Oct 2023 20:25:21 +0800
Message-ID: <3b2f8b0f-ca94-400f-ae13-ac1de84591b1@linux.alibaba.com>
Date:   Fri, 27 Oct 2023 20:25:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@huawei.com>,
        chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <20231023123202.GA3515@willie-the-truck>
 <cf72afb6-44c7-45f0-bfaa-6881f6782ebf@arm.com>
 <5b695595-d243-4ea5-97bb-f4c74398fc27@linux.alibaba.com>
 <20231026144428.00005db8@Huawei.com>
 <8f8a2e42-f6ed-4328-9457-5f986d761224@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <8f8a2e42-f6ed-4328-9457-5f986d761224@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/27 00:52, Robin Murphy wrote:
> On 26/10/2023 2:44 pm, Jonathan Cameron wrote:
>> On Tue, 24 Oct 2023 17:29:34 +0800
>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>> + Will, Jonathan, Bjorn and Yicong for probe and hotplug handing.
>>>
...
>>>>>> +
>>>>>> +    dwc_pcie_pmu_hp_state = ret;
>>>>>> +
>>>>>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
>>>>>> +    if (ret)
>>>>>> +        goto platform_driver_register_err;
>>>>>> +
>>>>>> +    dwc_pcie_pmu_dev = platform_device_register_simple(
>>>>>> +                "dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>>>>>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
>>>>>> +        ret = PTR_ERR(dwc_pcie_pmu_dev);
>>>>>> +        goto platform_device_register_error;
>>>>>> +    }
>>>>>
>>>>> I'm a bit confused as to why you're having to create a platform device
>>>>> for a PCI device -- is this because the main designware driver has already
>>>>> bound to it? A comment here explaining why you need to do this would be
>>>>> very helpful. In particular, is there any dependency on another driver
>>>>> to make sure that e.g. config space accesses work properly? If so, we
>>>>> probably need to enforce module load ordering or something like that.
>>>>
>>>> AFAICS the platform device/driver serve no purpose other than being a hilariously roundabout way to run the for_each_pci_dev() loop in dwc_pcie_pmu_probe() upon module init, and to save explicitly freeing the PMU name/data. Furthermore the devres action for dwc_pcie_pmu_remove_cpuhp_instance() is apparently going for even more style points at module exit by not even relying on the corresponding .remove callback of the tenuous platform driver to undo what its .probe did, but (ab)using the device's devres list to avoid having to keep track of an explicit list of PMU instances at all.
>>>
>>> You are right.
>>
>> Also provides a (potential) parent for the PMU devices which is something
>> we were trying to clean up for existing PMUs (which end up in the
>> wrong directly in sysfs because they typically don't have parents).
> 
> Surely the relevant PCI device would be an even more appropriate parent, though, since that's the true topology?
> 

I see, I will add its parent.

Thank you.
Best Regards,
Shuai
