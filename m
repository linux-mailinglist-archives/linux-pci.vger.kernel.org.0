Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950AB456C1C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 10:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhKSJJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 04:09:53 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14956 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSJJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 04:09:53 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HwW2004LlzZdB3;
        Fri, 19 Nov 2021 17:04:24 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 19 Nov 2021 17:06:34 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 17:06:34 +0800
Subject: Re: [PATCH v11 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>
References: <20211029093632.4350-1-liuqi115@huawei.com>
 <20211029093632.4350-3-liuqi115@huawei.com>
 <CAC52Y8Zc5oRRBDiZq+zQNGw2CbURN2SRsfW9ek_gw96qDHB1zw@mail.gmail.com>
 <acb5a232-dd09-9292-5b24-25e8e29e98e7@huawei.com>
 <YZdYcOYxta3FQFR8@rocinante>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <65023305-f05b-cfc3-16bf-a27e2b6da87f@huawei.com>
Date:   Fri, 19 Nov 2021 17:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YZdYcOYxta3FQFR8@rocinante>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/11/19 15:55, Krzysztof Wilczyński wrote:
> Hi Qi,
> 
> Thank you for looking into things I've mentioned!
> 
> [...]
>>> Would the above "bdf" be the PCI addressing schema?  If so, then we could
>>> capitalise the acronym to keep it consistent with how it's often referred
>>> to in the PCI world.
>>>
> [...]
>> got it, will change it to Bdf to keep the consistent, thanks.
> 
> Just to make sure - the "Bus, Device, Function" in the world of PCI usually
> uses the acronym of "BDF", all uppercase letters.
> 

got it, thanks.
>>> [...]
>>>> +static int __init hisi_pcie_module_init(void)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
>>>> +                                   "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
>>>> +                                   hisi_pcie_pmu_online_cpu,
>>>> +                                   hisi_pcie_pmu_offline_cpu);
>>>> +     if (ret) {
>>>> +             pr_err("Failed to setup PCIe PMU hotplug, ret = %d.\n", ret);
>>>> +             return ret;
>>>> +     }
>>>
>>> The above error message could be made to be a little more aligned in terms
>>> of format with the other messages, thus it would be as follows:
>>>
>>>     pr_err("Failed to setup PCIe PMU hotplug: %d.\n", ret);
>>>
>>> Interestingly, there would be then no need to add the final dot (period) at
>>> the end here, and that would be true everywhere else.
>>>
>>
>> thanks for your reminder , I'll fix that printout message to keep align.
> 
> Thank you!
> 
> Don't forget to drop the trailing dot after the error code (it makes it
> easier to read or even parse in a script, etc.).
> 

will drop all the final dot in next version, thanks : )

Thanks,
Qi

> Again, thank you so much for working on this driver!  An amazing work!
> 
> 	Krzysztof
> .
> 
