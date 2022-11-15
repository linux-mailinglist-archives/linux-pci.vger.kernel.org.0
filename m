Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459CF628F6C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 02:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiKOBk4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 20:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiKOBi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 20:38:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F4189;
        Mon, 14 Nov 2022 17:38:26 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NB7yQ0PrSzqSR9;
        Tue, 15 Nov 2022 09:34:38 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:38:23 +0800
Message-ID: <5f54794e-0278-e665-7a3c-c0aa7655002e@huawei.com>
Date:   Tue, 15 Nov 2022 09:38:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Leon Romanovsky <leon@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jianjay.zhou@huawei.com>,
        <zhuangshengen@huawei.com>, <arei.gonglei@huawei.com>,
        <yechuan@huawei.com>, <huangzhichao@huawei.com>,
        <xiehong@huawei.com>
References: <20221111142722.1172-1-longpeng2@huawei.com>
 <Y256ty6xGyUpkFn9@unreal> <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
 <Y3Hoi4zGFY4Fz1l4@unreal> <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com>
 <Y3I+Fs0/dXH/hnpL@unreal> <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com>
 <Y3JOvTfBwpaldtZJ@unreal>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <Y3JOvTfBwpaldtZJ@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



在 2022/11/14 22:20, Leon Romanovsky 写道:
> On Mon, Nov 14, 2022 at 10:06:49PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>>
>>
>> 在 2022/11/14 21:09, Leon Romanovsky 写道:
>>> On Mon, Nov 14, 2022 at 08:38:42PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>>>>
>>>>
>>>> 在 2022/11/14 15:04, Leon Romanovsky 写道:
>>>>> On Sun, Nov 13, 2022 at 09:47:12PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>>>>>> Hi leon,
>>>>>>
>>>>>> 在 2022/11/12 0:39, Leon Romanovsky 写道:
>>>>>>> On Fri, Nov 11, 2022 at 10:27:18PM +0800, Longpeng(Mike) wrote:
>>>>>>>> From: Longpeng <longpeng2@huawei.com>
>>>>>>>>
>>>>>>>> We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
>>>>>>>> this operation needs to spend lots of time if there has a large amount of VFs.
>>>>>>>> For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
>>>>>>>> concurrently would cost about 200-250ms. However most of them are not need to be
>>>>>>>> used at the moment, so we can enable SRIOV first but add VFs on demand.
>>>>>>>
>>>>>>> It is unclear what took 200-250ms, is it physical VF creation or bind of
>>>>>>> the driver to these VFs?
>>>>>>>
>>>>>> It is neither. In our test, we already created physical VFs before, so we
>>>>>> skipped the 100ms waiting when writing PCI_SRIOV_CTRL. And our driver only
>>>>>> probes PF, it just returns an error if the function is VF.
>>>>>
>>>>> It means that you didn't try sriov_drivers_autoprobe. Once it is set to
>>>>> true, It won't even try to probe VFs.
>>>>>
>>>>>>
>>>>>> The hotspot is the sriov_add_vfs (but no driver probe in fact) which is a
>>>>>> long procedure. Each step costs only a little, but the total cost is not
>>>>>> acceptable in some time-sensitive cases.
>>>>>
>>>>> This is also cryptic to me. In standard SR-IOV deployment, all VFs are
>>>>> created and configured while operator booted the machine with sriov_drivers_autoprobe
>>>>> set to false. Once this machine is ready, VFs are assigned to relevant VMs/users
>>>>> through orchestration SW (IMHO, it is supported by all orchestration SW).
>>>>>
>>>>> And only last part (assigning to users) is time-sensitive operation.
>>>>>
>>>> The VF creation and configuration are also time-sensitive in some cases, for
>>>> example, the hypervisor live update case (such as [1]):
>>>>    save VMs -> kexec -> restore VMs
>>>>
>>>> After the new kernel starts, the VFs must be added into the system, and then
>>>> assign the original VFs to the QEMU. This means we must enable all 2K+ VFs
>>>> at once and increase the downtime.
>>>>
>>>> If we can enable the VFs that are used by existing VMs then restore the VMs
>>>> and enable other unused VFs at last, the downtime would be significantly
>>>> reduced.
>>>>
>>>> [1] https://static.sched.com/hosted_files/kvmforum2022/65/kvmforum2022-Preserving%20IOMMU%20states%20during%20kexec%20reboot-v4.pdf
>>>
>>> Like it is written in presentation, the standard way of doing it is done
>>> by VFIO live migration feature, where 2K+ VMs are migrated to another server
>>> at the time first server is scheduled for maintenance.
>>>
>> Live migration is not the best choice in production environment, it's too
>> heavy. Some cloud providers prefer to using hypervisor live update in their
>> system, such as AWS's nitro hypervisor.
> 
> How is AWS nitro relevant to our discussion about adding sysfs file to Linux?
> Can you please point us to the source code of that hypervisor? Does it even
> run on Linux?
> 
Um...You can google for more information about the AWS nitro system.

Yes, it's digressive, so let's back to the discussion about adding sysfs 
file.

> Anyway, I'm aware of big cloud providers who are pretty happy with live
> migration in production.
> 
We're having trouble coming to an agreement on this point, but it does't 
matter. Please see below.

>>
>>> However, even in live update case mentioned in the presentation, you
>>> should disable ALL PFs/VFs and enable ALL PFs/VFs at the same time,
>>> so you don't need per-VF id enable knob.
>>>
>> The presentation is just a reference, some points could be optimized
>> including disable PFs/VFs and enable PFs/VFs.
>>
>> Hypervisor live update can finish in less than 1 second, so the cost of
>> disabling PFs/VFs and enabling PFs/VFs (~200-250ms or even worst) is too
>> high.
>>
>>>>
>>>>>>
>>>>>> What’s more, the sriov_add_vfs adds the VFs of a PF one by one. So we can
>>>>>> mostly support 10 concurrent calls if there has 10 PFs.
>>>>>
>>>>> I wondered, are you using real HW? or QEMU SR-IOV? What is your server
>>>>> that supports such large number of VFs?
>>>>>
>>>> Physical device. Some devices in the market support the large number of VFs,
>>>> especially in the hardware offloading area, e.g DPU/IPU. I think the SR-IOV
>>>> software should keep pace with times too.
>>>
>>> Our devices (and Intel too) support many VFs too. The thing is that
>>> servers are unlikely to be able to support 10 physical devices with 2K+
>>> VFs. There are many limitations that will make such is not usable.
>>> Like, global MSI-X pool and PCI bandwidth to support all these devices.
>>>
>>>>
>>>>> BTW, Your change will probably break all SR-IOV devices in the market as
>>>>> they rely on PCI subsystem to have VFs ready and configured.
>>>>>
>>>> I see, but maybe this change could be a choice for some users.
>>>
>>> It should come with relevant driver changes and very strong justification why
>>> such functionality is needed now and can't be achieved by anything else
>>> except user-facing sysfs.
>>>
>> Adding 2K+ VFs to the sysfs need too much time.
>>
>> Look at the bottomhalf of the hypervisor live update:
>> kexec --> add 2K VFs --> restore VMs
>>
>> The downtime can be reduced if the sequence is:
>> kexec --> add 100 VFs（the VMs used） --> resotre VMs --> add 1.9K VFs
> 
> Addition of VFs is serial operation, you can fire your VMs once you
> counted 100 VFs in sysfs directory.
> 
According to the current implementation, the addition of VFs must be in 
order, so this can not properly work.

For example, the VM uses VF200, VF202, VF204, but the sriov_add_vfs can 
only add VFs in the order VF0, VF1, VF2 ... The limitation is introduced 
by the software, not the PCI spec.

>>
>>
>>> I don't see anything in this presentation and discussion that supports
>>> need of such UAPI.
>>>   > Thanks
>>>
>>>>
>>>>> Thanks
>>>>> .
>>> .
> .
