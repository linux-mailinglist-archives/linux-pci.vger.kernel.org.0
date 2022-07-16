Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FA576C60
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGPHgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGPHgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 03:36:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA69E2E9DC
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 00:36:00 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax+eBSatJio0oiAA--.3205S3;
        Sat, 16 Jul 2022 15:35:46 +0800 (CST)
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220716032334.GA1228076@bhelgaas>
 <6e56ee68-4b87-4b04-9a43-c223dcd1b0fe@loongson.cn>
Message-ID: <c749c3b9-2916-1a3f-6be5-4217c469b4c5@loongson.cn>
Date:   Sat, 16 Jul 2022 15:35:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6e56ee68-4b87-4b04-9a43-c223dcd1b0fe@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Ax+eBSatJio0oiAA--.3205S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyxCrWDuw1DXF1kAFW7CFg_yoW5KFyfpr
        WrJF1UtFWUGr18Ar1qyw18AFyjqr45Ja45Xr1DJFyxGw4qvr1Yqr4UXr4qgF17Jr48Jr1j
        vrW5JryxZr1UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY
        0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
        Av8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/7/16 下午2:12, Jianmin Lv wrote:
> 
> 
> On 2022/7/16 上午11:23, Bjorn Helgaas wrote:
>> On Sat, Jul 16, 2022 at 10:27:00AM +0800, Jianmin Lv wrote:
>>> On 2022/7/16 上午12:37, Bjorn Helgaas wrote:
>>>> On Fri, Jul 15, 2022 at 04:05:12PM +0800, Jianmin Lv wrote:
>>>>> On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
>>>>>> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
>>>>>>> From: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>>>
>>>>>>> In LS7A, multifunction device use same PCI PIN (because the
>>>>>>> PIN register report the same INTx value to each function)
>>>>>>> but we need different IRQ for different functions, so add a
>>>>>>> quirk to fix it for standard PCI PIN usage.
>>>>>>>
>>>>>>> This patch only affect ACPI based systems (and only needed
>>>>>>> by ACPI based systems, too). For DT based systems, the irq
>>>>>>> mappings is defined in .dts files and be handled by
>>>>>>> of_irq_parse_pci().
>>>>>>
>>>>>> I'm sorry, I know you've explained this before, but I don't
>>>>>> understand yet, so let's try again.  I *think* you're saying
>>>>>> that:
>>>>>>
>>>>>>      - These devices integrated into LS7A all report 0 in their
>>>>>>      Interrupt Pin registers.  Per spec, this means they do not
>>>>>>      use INTx (PCIe r6.0, sec 7.5.1.1.13).
>>>>>>
>>>>>>      - However, these devices actually *do* use INTx.  Function
>>>>>>      0 uses INTA, function 1 uses INTB, ..., function 4 uses
>>>>>>      INTA, ...
>>>>>>
>>>>>>      - The quirk overrides the incorrect values read from the
>>>>>>      Interrupt Pin registers.
>>>>>
>>>>> Yes, right.
>>>
>>> Sorry, I didn't see the first item here carefully, so I have to
>>> correct it: all the integrated devices in 7A report 1 in PIN reg
>>> instead of 0.
>>
>>>>>> But I'm still confused about how loongson_map_irq() gets called.  The
>>>>>> only likely path I see is here:
>>>>>>
>>>>>>      pci_device_probe                            # pci_bus_type.probe
>>>>>>        pci_assign_irq
>>>>>>          pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
>>>>>>          if (pin)
>>>>>>     bridge->swizzle_irq(dev, &pin)
>>>>>>     irq = bridge->map_irq(dev, slot, pin)
>>>>>>
>>>>>> where bridge->map_irq points to loongson_map_irq().  But
>>>>>> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
>>>>>> wouldn't call bridge->map_irq().  Obviously I'm missing something.
>>>>>>
>>>
>>> Same thing, PCI_INTERRUPT_PIN reports 1, so bridge->map_irq() will be
>>> called.
>>
>> OK, that makes a lot more sense, thank you!
>>
>> But it does leave another question: the quirk applies to
>> DEV_PCIE_PORT_0 (0x7a09), DEV_PCIE_PORT_1 (0x7a19), and
>> DEV_PCIE_PORT_2 (0x7a29).
>>
>> According to the .dtsi [1], all those root ports are at function 0,
>> and if they report INTA, the quirk will also compute INTA.  So why do
>> you need to apply the quirk for them?
>>
> 
> Oh, yes, I don't think they are required either. The fix is only 
> required for multi-func devices of 7A.
> 
> Huacai, we should remove PCIE ports from the patch.
> 
>> The same would apply to any Device ID that only appears at function 0,
>> which looks like it also includes DEV_LS7A_OHCI (0x7a24), and
>> DEV_LS7A_GPU (0x7a15).
>>

Same thing, they are also not required.

>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/loongson/ls7a-pch.dtsi?id=v5.18#n231 
>>
>>
> 
> 

