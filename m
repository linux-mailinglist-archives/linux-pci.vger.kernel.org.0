Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65560576B4F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 04:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiGPC1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGPC1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 22:27:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04BF566BB5
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 19:27:14 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD9H0IdJi4PMhAA--.27210S3;
        Sat, 16 Jul 2022 10:27:01 +0800 (CST)
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220715163740.GA1137874@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <3a49465c-cd70-927f-1fd9-9454fa9c44ab@loongson.cn>
Date:   Sat, 16 Jul 2022 10:27:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220715163740.GA1137874@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxD9H0IdJi4PMhAA--.27210S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15Zw48GFy3Xr4DXry7ZFb_yoWrWry7pa
        y5W3Z8Krs2qr18Jr4q9wnavr1Yvr45J345Wrn5J3savrs0934xtr45WrWYkFZrur48Jr40
        9rW5tFWxua1UZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
        62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/7/16 上午12:37, Bjorn Helgaas wrote:
> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
>> On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
>>>>
>>>> In LS7A, multifunction device use same PCI PIN (because the PIN register
>>>> report the same INTx value to each function) but we need different IRQ
>>>> for different functions, so add a quirk to fix it for standard PCI PIN
>>>> usage.
>>>>
>>>> This patch only affect ACPI based systems (and only needed by ACPI based
>>>> systems, too). For DT based systems, the irq mappings is defined in .dts
>>>> files and be handled by of_irq_parse_pci().
>>>
>>> I'm sorry, I know you've explained this before, but I don't understand
>>> yet, so let's try again.  I *think* you're saying that:
>>>
>>>     - These devices integrated into LS7A all report 0 in their Interrupt
>>>       Pin registers.  Per spec, this means they do not use INTx (PCIe
>>>       r6.0, sec 7.5.1.1.13).
>>>
>>>     - However, these devices actually *do* use INTx.  Function 0 uses
>>>       INTA, function 1 uses INTB, ..., function 4 uses INTA, ...
>>>
>>>     - The quirk overrides the incorrect values read from the Interrupt
>>>       Pin registers.
>>
>> Yes, right.
>>

Sorry, I didn't see the first item here carefully, so I have to correct 
it: all the integrated devices in 7A report 1 in PIN reg instead of 0.

>>> That much makes sense to me.
>>>
>>> And I even see that in of_irq_parse_pci(), if there's a DT node for
>>> the device, of_irq_parse_one() gets the interrupt info from DT and
>>> returns the IRQ all the way back up to (I think) loongson_map_irq().
>>
>> Agree, I think so for DT.
>>
>>> But I'm still confused about how loongson_map_irq() gets called.  The
>>> only likely path I see is here:
>>>
>>>     pci_device_probe                            # pci_bus_type.probe
>>>       pci_assign_irq
>>>         pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
>>>         if (pin)
>>> 	bridge->swizzle_irq(dev, &pin)
>>> 	irq = bridge->map_irq(dev, slot, pin)
>>>
>>> where bridge->map_irq points to loongson_map_irq().  But
>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
>>> wouldn't call bridge->map_irq().  Obviously I'm missing something.
>>>

Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will be 
called.

>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/setup-irq.c?id=v5.18#n37
>>
>> For ACPI, bridge->map_irq is NULL, so in above path,
>> the pci_assign_irq will return because of !(hbrg->map_irq) as following:
>>
>>          if (!(hbrg->map_irq)) {
>>                  pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
>>                  return;
>>          }
>>
>> And again as I explained in previous version patch, dev->irq is set in
>> acpi_pci_irq_enable() in the following path for ACPI:
>>
>> pci_device_probe
>>    ->pcibios_alloc_irq
>>      ->acpi_pci_irq_enable
>>        ->acpi_pci_irq_lookup
>>
>> And the reason that we fixed the pin is to get an correct entry in prt
>> table when calling acpi_pci_irq_lookup. With out the fix, we can't find
>> out a entry.
>>
>> After found an entry, we get gsi, and map irq as following:
>>
>>          rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
>>          if (rc < 0) {
>>                  dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
>>                           pin_name(pin));
>>                  kfree(entry);
>>                  return rc;
>>          }
>>          dev->irq = rc;
>>
>> Here, dev->irq is set like in pci_assign_irq for DT.
> 
> Yes.  The above explains how things work for ACPI, but I'm not asking
> about that.
> 
> I'm asking how this works in the *DT* case.  I see that
> pci_assign_irq() is called for both ACPI and DT, and I see that it
> does nothing in the ACPI path because bridge->map_irq hasn't been set.
> 
> What I *don't* see is how pci_assign_irq() works in the DT case
> because it reads PCI_INTERRUPT_PIN, which should return 0 for these
> broken devices, and if "pin == 0", it never calls ->map_irq().
> 
> Is ->map_irq() called via some other path?
> 

Same as above.

> Bjorn
> 

