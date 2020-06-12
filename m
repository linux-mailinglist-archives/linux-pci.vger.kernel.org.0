Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A351F71B0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 03:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFLB0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 21:26:41 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56360 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbgFLB0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 21:26:38 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2uG2OJeckpBAA--.2793S3;
        Fri, 12 Jun 2020 09:21:11 +0800 (CST)
Subject: Re: [PATCH] PCI: Loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200611202604.GA1607130@bjorn-Precision-5520>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3027869e-ae17-5387-ce98-f89b6b1e4915@loongson.cn>
Date:   Fri, 12 Jun 2020 09:21:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200611202604.GA1607130@bjorn-Precision-5520>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxz2uG2OJeckpBAA--.2793S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3uFyxCr4kKr4kuw15Arb_yoW8CFWxpr
        15Ja17KF4ftFs8C3ZFqw4DG3Z8ZF9xGa48CFW5u3W2gF9xX3W5WrnFk3WFvF4UJrWDJa18
        ZFWkCayrCa15Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHpB-UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/12/2020 04:26 AM, Bjorn Helgaas wrote:
> Subject line:
>
>    PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for bridge_class_quirk()
>
> (Driver names are conventionally lower case.)
>
> Lorenzo will probably silently fix this when applying, so this is
> mostly just a reminder in case you need to revise this or for future
> patches.
Hi Bjorn,

Thanks for your reminder, sorry for that.
I will modify it and then send v2.

>
> On Wed, Jun 10, 2020 at 10:39:50AM +0800, Tiezhu Yang wrote:
>> Use DECLARE_PCI_FIXUP_EARLY instead of DECLARE_PCI_FIXUP_HEADER
>> for bridge_class_quirk() in pci-loongson.c, otherwise the fixup
>> has no effect.
>>
>> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> This patch is based on mips-next tree.
>>
>>   drivers/pci/controller/pci-loongson.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index 459009c..58b862a 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -37,11 +37,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
>>   {
>>   	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>   }
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   			DEV_PCIE_PORT_0, bridge_class_quirk);
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   			DEV_PCIE_PORT_1, bridge_class_quirk);
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON,
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   			DEV_PCIE_PORT_2, bridge_class_quirk);
>>   
>>   static void system_bus_quirk(struct pci_dev *pdev)
>> -- 
>> 2.1.0
>>

