Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC522026E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 04:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgGOCg6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 22:36:58 -0400
Received: from mail.loongson.cn ([114.242.206.163]:50126 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbgGOCg6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 22:36:58 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxidS0aw5ffNAEAA--.1431S3;
        Wed, 15 Jul 2020 10:36:37 +0800 (CST)
Subject: Re: [PATCH v2] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1591925417-27665-1-git-send-email-yangtiezhu@loongson.cn>
 <43b4409d-ff0f-9711-0b8f-1cfb19d31f24@loongson.cn>
 <20200714150822.GB14416@e121166-lin.cambridge.arm.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3dc48f99-68bd-89a9-6cbe-16274e1cf86a@loongson.cn>
Date:   Wed, 15 Jul 2020 10:36:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200714150822.GB14416@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9CxidS0aw5ffNAEAA--.1431S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw48tryDGFy5Gw4kGw48JFb_yoW5Jw18pr
        yrJa12kF4FqFs8AwnF9wsrWasI9as3Ca4kCFWru3ZF9r9IqF15Wr97KFyF9r4UXrW8Xa10
        v3ykC3yfAa1Uur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUomiiDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/14/2020 11:08 PM, Lorenzo Pieralisi wrote:
> On Tue, Jul 14, 2020 at 03:37:51PM +0800, Tiezhu Yang wrote:
>> On 06/12/2020 09:30 AM, Tiezhu Yang wrote:
>>> Use DECLARE_PCI_FIXUP_EARLY instead of DECLARE_PCI_FIXUP_HEADER
>>> for bridge_class_quirk() in pci-loongson.c, otherwise the fixup
>>> has no effect.
>>>
>>> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>
>>> v2:
>>>     - modify the patch subject used with lower case "loongson"
>>>
>>> This patch is based on mips-next tree.
>>>
>>>    drivers/pci/controller/pci-loongson.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>>> index 459009c..58b862a 100644
>>> --- a/drivers/pci/controller/pci-loongson.c
>>> +++ b/drivers/pci/controller/pci-loongson.c
>>> @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
>>>    {
>>>    	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>>    }
>>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>    			DEV_PCIE_PORT_0, bridge_class_quirk);
>>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>    			DEV_PCIE_PORT_1, bridge_class_quirk);
>>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>    			DEV_PCIE_PORT_2, bridge_class_quirk);
>>>    static void system_bus_quirk(struct pci_dev *pdev)
>> Hi,
>>
>> Any comments?

Hi Lorenzo,

Thanks for your reply.

> (1) how was this driver tested if this patch is required ? Is it because
>      you are testing on a different platform ?

According to the datasheet of Loongson LS7A bridge chip, the old
version of Loongson LS7A PCIE port has a hardware bug about PCI
class.

As far as I know, the latest version has already fixed this bug.
I test it on the old version which has hardware bug.

> (2) Please explain why it is needed (I mean describe what happens
>      in current code and how this fixes it) in the commit log, it is
>      useful for people who may need to tweak this code further

OK, this patch is to maintain downward compatibility, I will add
more info to the commit message and then send v3.

Thanks,
Tiezhu

>
> I will apply it then, thanks.
>
> Lorenzo
>
>> Could you please apply this patch?
>>
>> Thanks,
>> Tiezhu
>>

