Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55817575CF5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiGOIF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGOIF2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 04:05:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0103661D65
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 01:05:26 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9G4H9FiH04gAA--.25088S3;
        Fri, 15 Jul 2022 16:05:13 +0800 (CST)
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220715034402.GA1047213@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <8eed6209-aa73-83db-440a-469af6528aba@loongson.cn>
Date:   Fri, 15 Jul 2022 16:05:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220715034402.GA1047213@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb9G4H9FiH04gAA--.25088S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1rJw43JF4DZF1fZF18Zrb_yoW7Aw43pa
        45Za15Kr4rtr15Crs8Z395GFnYvF1fAry5CFZrW3W2k3Z7A348XryagFy5tFsxZr4kXr42
        vFZ5uw409ayq9F7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
        0_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/7/15 上午11:44, Bjorn Helgaas wrote:
> On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
>> From: Jianmin Lv <lvjianmin@loongson.cn>
>>
>> In LS7A, multifunction device use same PCI PIN (because the PIN register
>> report the same INTx value to each function) but we need different IRQ
>> for different functions, so add a quirk to fix it for standard PCI PIN
>> usage.
>>
>> This patch only affect ACPI based systems (and only needed by ACPI based
>> systems, too). For DT based systems, the irq mappings is defined in .dts
>> files and be handled by of_irq_parse_pci().
> 
> I'm sorry, I know you've explained this before, but I don't understand
> yet, so let's try again.  I *think* you're saying that:
> 
>    - These devices integrated into LS7A all report 0 in their Interrupt
>      Pin registers.  Per spec, this means they do not use INTx (PCIe
>      r6.0, sec 7.5.1.1.13).
> 
>    - However, these devices actually *do* use INTx.  Function 0 uses
>      INTA, function 1 uses INTB, ..., function 4 uses INTA, ...
> 
>    - The quirk overrides the incorrect values read from the Interrupt
>      Pin registers.
> 

Yes, right.


> That much makes sense to me.
> 
> And I even see that in of_irq_parse_pci(), if there's a DT node for
> the device, of_irq_parse_one() gets the interrupt info from DT and
> returns the IRQ all the way back up to (I think) loongson_map_irq().
> 

Agree, I think so for DT.


> But I'm still confused about how loongson_map_irq() gets called.  The
> only likely path I see is here:
> 
>    pci_device_probe                            # pci_bus_type.probe
>      pci_assign_irq
>        pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
>        if (pin)
> 	bridge->swizzle_irq(dev, &pin)
> 	irq = bridge->map_irq(dev, slot, pin)
> 
> where bridge->map_irq points to loongson_map_irq().  But
> pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
> wouldn't call bridge->map_irq().  Obviously I'm missing something.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/setup-irq.c?id=v5.18#n37
> 

For ACPI, bridge->map_irq is NULL, so in above path,
the pci_assign_irq will return because of !(hbrg->map_irq) as following:

         if (!(hbrg->map_irq)) {
                 pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
                 return;
         }

And again as I explained in previous version patch, dev->irq is set in
acpi_pci_irq_enable() in the following path for ACPI:

pci_device_probe
   ->pcibios_alloc_irq
     ->acpi_pci_irq_enable
       ->acpi_pci_irq_lookup

And the reason that we fixed the pin is to get an correct entry in prt
table when calling acpi_pci_irq_lookup. With out the fix, we can't find
out a entry.

After found an entry, we get gsi, and map irq as following:

         rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
         if (rc < 0) {
                 dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
                          pin_name(pin));
                 kfree(entry);
                 return rc;
         }
         dev->irq = rc;

Here, dev->irq is set like in pci_assign_irq for DT.


>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   drivers/pci/controller/pci-loongson.c | 32 +++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index 05997b51c86d..4043b57bcc86 100644
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
>> @@ -103,6 +110,31 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
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
>> 2.31.1
>>

