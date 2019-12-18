Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F1124285
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 10:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRJQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 04:16:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfLRJQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Dec 2019 04:16:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C970B752B66CF392781B;
        Wed, 18 Dec 2019 17:16:11 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 17:16:04 +0800
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
To:     <bjorn@helgaas.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <andrew.murray@arm.com>,
        <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>
References: <20191206181051.GA121021@google.com>
 <6ebfcfc7-f9f0-bee0-172c-89c93530d94b@huawei.com>
 <CABhMZUX8spN93es+qtZWtMSUi3M+c99649ect4ZAkcrPLqfO=g@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <5ec52f21-8fd6-86f0-88ad-e316a274024d@huawei.com>
Date:   Wed, 18 Dec 2019 17:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CABhMZUX8spN93es+qtZWtMSUi3M+c99649ect4ZAkcrPLqfO=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/12/11 12:10, Bjorn Helgaas wrote:
> On Tue, Dec 10, 2019 at 9:28 PM Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
>>
>>
>>
>> On 2019/12/7 2:10, Bjorn Helgaas wrote:
>>> On Fri, Dec 06, 2019 at 03:01:45PM +0800, Xiongfeng Wang wrote:
>>>> HiSilicon PCI Network Processor 5896 devices misreport the class type as
>>>> 'NOT_DEFINED', but it is actually a network device. Also the size of
>>>> BAR3 is reported as 265T, but this BAR is actually unused.
>>>> This patch modify the class type to 'CLASS_NETWORK' and disable the
>>>> unused BAR3.
>>>
>>> "NOT_DEFINED" is not the value in the Class Code register.  The commit
>>> message should include the actual value.
>>
>> The actual value is 0, I will update the commit message.
>>
>>>
>>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>>> ---
>>>>  drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
>>>>  include/linux/pci_ids.h |  1 +
>>>>  2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 4937a08..b9adebb 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -5431,3 +5431,32 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>>>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>>>>                            PCI_CLASS_DISPLAY_VGA, 8,
>>>>                            quirk_reset_lenovo_thinkpad_p50_nvgpu);
>>>> +
>>>> +static void quirk_hisi_fixup_np_class(struct pci_dev *pdev)
>>>> +{
>>>> +    u32 class = pdev->class;
>>>> +
>>>> +    pdev->class = PCI_BASE_CLASS_NETWORK << 8;
>>>> +    pci_info(pdev, "PCI class overriden (%#08x -> %#08x)\n",
>>>> +             class, pdev->class);
>>>> +}
>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
>>>> +                    quirk_hisi_fixup_np_class);
>>>> +
>>>> +/*
>>>> + * HiSilicon NP 5896 devices BAR3 size is reported as 256T and causes problem
>>>> + * when assigning the resources. But this BAR is actually unused by the driver,
>>>> + * so let's disable it.
>>>
>>> The question is not whether the BAR is used by the driver; the
>>> question is whether the device responds to accesses to the region
>>> described by the BAR when PCI_COMMAND_MEMORY is turned on.
>>
>> I asked the hardware engineer. He said I can not write an address into that BAR.
> 
> If the BAR is not writable, I think sizing should fail, so I suspect
> some of the bits are actually writable.

Sorry for the delayed response. It's not so convenient for me to get to the hardware guys.
BAR0 BAR1 BAR2 are 32-bit and can be used to access the registers and memory within
5896 devices. These three BARs can meet the need for most scenario.
BAR3 is 64-bit and can be used to access all the registers and memory within 5896 devices.
(BAR3 is writable. Sorry for the non-confirmed information before.)
But BAR3 is not used by the driver and the size is very large（larger than 100G, still didn't
get the precise size）.
So I think maybe we can disable this BAR for now, otherwise the unassigned resource will cause
'pci_enable_device()' returning failure.

Thanks,
Xiongfeng

> 
> What do you see in dmesg when this device is enumerated?  Can you
> instrument the code in __pci_read_base() and see what we read/write to
> that BAR?
> 
> Per spec, if the BAR is not implemented, it should be read-only zero.
> But obviously the whole reason for the quirk is that the device
> doesn't comply with the spec.




> 
> Bjorn
> 
> .
> 

