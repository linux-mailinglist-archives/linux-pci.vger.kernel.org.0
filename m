Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592B539E67
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiFAHg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 03:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiFAHg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 03:36:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803438CB0A
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 00:36:25 -0700 (PDT)
Received: from [192.168.10.143] (unknown [123.117.60.26])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX0_tFpdijE0LAA--.3754S3;
        Wed, 01 Jun 2022 15:36:14 +0800 (CST)
Subject: Re: [PATCH V13 6/6] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220601020737.GA798493@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <6286fb6e-8a4c-d0aa-115f-f6d11300193f@loongson.cn>
Date:   Wed, 1 Jun 2022 15:36:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220601020737.GA798493@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxX0_tFpdijE0LAA--.3754S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyxuw4fGrWkuF47uryrtFb_yoWrZrWUpr
        1rZF43KFWrtr1rCrn8XrZ5GFyFvF4fA34UCFW7KF1jk3Z7J340gry2gF1FgrsrZr4kJF42
        vFZ8Cw4S9FWq9r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBpB-UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2022/6/1 上午10:07, Bjorn Helgaas wrote:
> On Sat, Apr 30, 2022 at 04:48:46PM +0800, Huacai Chen wrote:
>> From: Jianmin Lv <lvjianmin@loongson.cn>
>>
>> In LS7A, multifunction device use same PCI PIN (because the PIN register
>> report the same INTx value to each function) but we need different IRQ
>> for different functions, so add a quirk to fix it for standard PCI PIN
>> usage.
> Is this because your _PRT is missing or broken?  of_irq_parse_pci()
> reads and relies on PCI_INTERRUPT_PIN, too, so it seems like the _PRT
> could contain the same routing information you're getting from DT.
>

Thanks for your reply first.

In _PRT, we have following packages for pci device 6(a multi-fun device),


Package (0x04)
{
     0x0006FFFF,
     Zero,
     Zero,
     0x5D
     },

Package (0x04)
{
     0x0006FFFF,
     One,
     Zero,
     0x5C
},

the 'Pin' in two packages must be diffirent(0-INTA, 1-INTB, 2-INTC, 
3-INTD) because that the 'Pin' of the _PRT entry will be compared with 
the pin in the PIN register of pci config space for a pci device in 
following code path:

pci_device_probe
  ->pcibios_alloc_irq
    ->acpi_pci_irq_enable
      ->acpi_pci_irq_lookup
        ->acpi_pci_irq_find_prt_entry
          ->acpi_pci_irq_check_entry

and in acpi_pci_irq_check_entry(), there is following code:

         if (((prt->address >> 16) & 0xffff) != device ||
             prt->pin + 1 != pin)
                 return -ENODEV;

In LS7A, the PIN register returns same value(0) for all the different 
function, so, we have to fix it first.

I don't know if there is any other way to address it.


>> This patch only affect ACPI based systems (and only needed by ACPI based
>> systems, too). For DT based systems, the irq mappings is defined in .dts
>> files and be handled by of_irq_parse_pci().
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/pci/controller/pci-loongson.c | 32 +++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index 49d8b8c24ffb..024542a31a8c 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -22,6 +22,13 @@
>>   #define DEV_LS2K_APB	0x7a02
>>   #define DEV_LS7A_CONF	0x7a10
>>   #define DEV_LS7A_LPC	0x7a0c
>> +#define DEV_LS7A_GMAC	0x7a03
>> +#define DEV_LS7A_DC1	0x7a06
>> +#define DEV_LS7A_DC2	0x7a36
>> +#define DEV_LS7A_GPU	0x7a15
>> +#define DEV_LS7A_AHCI	0x7a08
>> +#define DEV_LS7A_EHCI	0x7a14
>> +#define DEV_LS7A_OHCI	0x7a24
>>   
>>   #define FLAG_CFG0	BIT(0)
>>   #define FLAG_CFG1	BIT(1)
>> @@ -102,6 +109,31 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>   			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
>>   
>> +static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>> +{
>> +	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_DC1, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_DC2, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_GPU, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_GMAC, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_AHCI, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_EHCI, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_LS7A_OHCI, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
>> +			DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
>> +
>>   static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>>   {
>>   	struct pci_config_window *cfg;
>> -- 
>> 2.27.0
>>

