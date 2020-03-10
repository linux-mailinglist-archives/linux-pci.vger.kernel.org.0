Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3C17F392
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCJJ2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 05:28:41 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34386 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbgCJJ2k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 05:28:40 -0400
Received: from [10.130.0.70] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axf+i4XWdeRCAZAA--.7S3;
        Tue, 10 Mar 2020 17:28:25 +0800 (CST)
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:[PATCH_1/6]_PCI:_Add_Loongson_vend?=
 =?UTF-8?Q?or_ID_and_7A1000_device_IDs?=
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
 <1583742206-29163-2-git-send-email-yangtiezhu@loongson.cn>
 <170be7ca00e.133ea84fa2305.7803335422925759322@flygoat.com>
 <2ba6de2e-7880-d322-a0f6-5cea2647ea50@loongson.cn>
 <7262AFE6-B850-4F34-A79F-2B59341C9B88@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f718993e-4b76-0af6-14a9-a8f71fb35243@loongson.cn>
Date:   Tue, 10 Mar 2020 17:28:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7262AFE6-B850-4F34-A79F-2B59341C9B88@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axf+i4XWdeRCAZAA--.7S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48uFWfWw4xArW3Zw15XFb_yoW5WF1rpr
        1jvFs5tFs7Jry7J3Z7twn8GrZayan8tryUWFySgr4UXFnIqw18GrnFyr4Y9rWIqrs3Xry7
        Zr1qk3y3Crnxt37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUb0D73UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/10/2020 10:37 AM, Jiaxun Yang wrote:
>
> 于 2020年3月10日 GMT+08:00 上午10:31:56, Tiezhu Yang <yangtiezhu@loongson.cn> 写到:
>> On 03/09/2020 04:50 PM, Jiaxun Yang wrote:
>>>    ---- 在 星期一, 2020-03-09 16:23:21 Tiezhu Yang
>> <yangtiezhu@loongson.cn> 撰写 ----
>>>    > Add the Loongson vendor ID and 7A1000 device IDs to pci_ids.h
>>>    > to be used by the controller driver in the future.
>>>    >
>>>    > The Loongson IDs can be found at the following link:
>>>    >
>> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids
>>>    >
>>>    > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>    > ---
>>>    >  include/linux/pci_ids.h | 18 ++++++++++++++++++
>>>    >  1 file changed, 18 insertions(+)
>>>    >
>>>    > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>>>    > index 352c0d7..0125ab4 100644
>>>    > --- a/include/linux/pci_ids.h
>>>    > +++ b/include/linux/pci_ids.h
>>>    > @@ -3113,4 +3113,22 @@
>>>    >
>>>    >  #define PCI_VENDOR_ID_NCUBE        0x10ff
>>>    >
>>>    > +#define PCI_VENDOR_ID_LOONGSON            0x0014
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HT    0x7a00
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_APB    0x7a02
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GMAC    0x7a03
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OTG    0x7a04
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DC    0x7a06
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_HDA    0x7a07
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SATA    0x7a08
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X1    0x7a09
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_SPI    0x7a0b
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_LPC    0x7a0c
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_DMA    0x7a0f
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_EHCI    0x7a14
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_GPU    0x7a15
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X4    0x7a19
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_OHCI    0x7a24
>>>    > +#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X8    0x7a29
>>>
>>> Devices IDs are unlikely to be reused by mutiple subsystems, so
>> probably we don't need
>>> to add them here?
>> Hi Jiaxun,
>>
>> I think it is better to define the device IDs in pci_ids.h,
>> otherwise it seems a little disorganized.
> Please read the comment at the start of this file.
> New entries should be added only if they're shared by multiple drivers.
>
> That's the rule.
>
> And probably you can split these two patches into a new series
> as they're likely to be accepted.

OK, that makes sense.

Let me split the two patches 1/6 and 2/6 into a new series,
the first patch only adds the Loongson vendor ID to pci_ids.h.

Thanks,

Tiezhu Yang

>
> Thanks.
>
>> Thanks,
>>
>> Tiezhu Yang
>>
>>>    
>>>> +
>>>    >  #endif /* _LINUX_PCI_IDS_H */
>>>    > --
>>>    > 2.1.0
>>>    >
>>>    >

