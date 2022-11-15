Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786686295C8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 11:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiKOK1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 05:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiKOK1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 05:27:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7224BF5;
        Tue, 15 Nov 2022 02:27:26 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBMmZ5xwlzHvxR;
        Tue, 15 Nov 2022 18:26:54 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 18:27:23 +0800
Message-ID: <61edd390-af20-2787-565c-207222f0510f@huawei.com>
Date:   Tue, 15 Nov 2022 18:27:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Leon Romanovsky <leon@kernel.org>
CC:     Oliver O'Halloran <oohall@gmail.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>
References: <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com> <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com> <Y3I+Fs0/dXH/hnpL@unreal>
 <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com> <Y3JOvTfBwpaldtZJ@unreal>
 <CAOSf1CG+VGdeXGQetfMArwpafAx2yj3nmA_y7rN4SNdt=1=08w@mail.gmail.com>
 <Y3NOo3DaLKb219IV@unreal> <638b2550-7da8-1b48-4038-52f71947ff05@huawei.com>
 <Y3NjslijVKfLQo3W@unreal>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <Y3NjslijVKfLQo3W@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/11/15 18:02, Leon Romanovsky 写道:
> On Tue, Nov 15, 2022 at 05:36:38PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>>
>>
>> 在 2022/11/15 16:32, Leon Romanovsky 写道:
>>> On Tue, Nov 15, 2022 at 12:50:34PM +1100, Oliver O'Halloran wrote:
>>>> On Tue, Nov 15, 2022 at 1:27 AM Leon Romanovsky <leon@kernel.org> wrote:
>>>>>
>>>>> *snip*
>>>>>
>>>>> Anyway, I'm aware of big cloud providers who are pretty happy with live
>>>>> migration in production.
>>>>
>>>> I could see someone sufficiently cloudbrained deciding that rebooting
>>>> the hypervisor is fine provided the downtime doesn't violate any
>>>> customer uptime SLAs. Personally I'd only be brave enough to do that
>>>> for a HV hosting internal services which I know are behind a load
>>>> balancer, but apparently there are people at Huawei far braver than I.
>>>
>>> My main point in this discussion that Huawei team doesn't actually
>>> provide any meaningful justification why it is great idea to add new
>>> sysfs file. They use HPC as an argument, but in that world, you won't
>>> see many VMs on one server, as it is important to provide separate MSI-X
>>> vectors and CPUs to each VM.
>>>
>>> They ask from us optimization (do not add device hierarchy for existing HW)
>>> that doesn't exist in the kernel.
>>>
>>> I would say that they are trying to meld SIOV architecture of subfunctions
>>> (SFs) into PCI and SR-IOV world.
>>>
>> I may not agree with you on this point.
> 
> The bright side of open source that you don't need to agree with everyone.
> If you success to convince others, it will be merged.
> 
Yes, but patches be merged is not the only purpose of open source, but 
learning from the disscussion is much more important.
I'm not care about these patches will be merged or not, at least you've 
pointed some disadvantages of this solution.

>> The sriov_numvfs interface mixes the
>> operation of enabling hardware VFs and the addition of VFs. I just want to
>> split these two operations and also can selectively add some VFs earlier
>> than others. I think there's no violation of PCI spec.
> 
> Right, it just doesn't fit into Linux kernel device initialization model.
> 
> Thanks
> 
>>
>>> Thanks
>>> .
> .
