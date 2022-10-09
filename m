Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE05F88DE
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 04:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJIC0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Oct 2022 22:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJIC0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Oct 2022 22:26:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD4533642A;
        Sat,  8 Oct 2022 19:26:30 -0700 (PDT)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJNMUJjMAMpAA--.18058S3;
        Sun, 09 Oct 2022 10:26:21 +0800 (CST)
Subject: Re: [PATCH V2 1/2] irqchip/loongson-pch-pic: Support to set irq type
 for ACPI path
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20221008025150.10734-1-lvjianmin@loongson.cn>
 <20221008025150.10734-2-lvjianmin@loongson.cn> <87v8othkgz.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <7d3894f9-9708-0b4f-b485-f167408feede@loongson.cn>
Date:   Sun, 9 Oct 2022 10:26:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v8othkgz.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOJNMUJjMAMpAA--.18058S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr45CFWxKF43Wr1ktw1xAFb_yoW5AF13pF
        Wfua1ayF4DJFy7Zr92kw48Jr1fZwn3trWUGF4Fy3W29rsxCr4fuF17WFy5Zr97CF43Ca12
        vrn0vFWUua47CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY
        0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
        Av8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok, thanks, I'll separate this patch, so we have to make the patch 
fixing PCI INTx handling to be after the patch supporting for the LPIC 
model to avoid kernel hang, yes?

On 2022/10/9 上午9:08, Marc Zyngier wrote:
> On Sat, 08 Oct 2022 03:51:49 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> For ACPI path, the translate callback used IRQ_TYPE_NONE and ignored
>> the irq type in fwspec->param[1]. For supporting to set type for
>> irqs of the irqdomain, fwspec->param[1] should be used to get irq
>> type.
>>
>> On Loongson platform, the irq trigger type of PCI devices is
>> high level, so high level triggered type is inputed to acpi_register_gsi
>> when create irq mapping for PCI devices.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/acpi/pci_irq.c                 | 6 ++++--
>>   drivers/irqchip/irq-loongson-pch-pic.c | 9 ++++++++-
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>> index 08e15774fb9f..ff30ceca2203 100644
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -387,13 +387,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>>   	u8 pin;
>>   	int triggering = ACPI_LEVEL_SENSITIVE;
>>   	/*
>> -	 * On ARM systems with the GIC interrupt model, level interrupts
>> +	 * On ARM systems with the GIC interrupt model, or LoongArch
>> +	 * systems with the LPIC interrupt model, level interrupts
>>   	 * are always polarity high by specification; PCI legacy
>>   	 * IRQs lines are inverted before reaching the interrupt
>>   	 * controller and must therefore be considered active high
>>   	 * as default.
>>   	 */
>> -	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
>> +	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
>> +		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
>>   				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>>   	char *link = NULL;
>>   	char link_desc[16];
> 
> This is one patch adding support for the LPIC model.
> 
>> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
>> index c01b9c257005..5576c97fec85 100644
>> --- a/drivers/irqchip/irq-loongson-pch-pic.c
>> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
>> @@ -159,11 +159,18 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>>   		return -EINVAL;
>>   
>>   	if (of_node) {
>> +		if (fwspec->param_count < 2)
>> +			return -EINVAL;
>> +
> 
> This is another patch fixing a regression introduced by bcdd75c596c8.
> 
>>   		*hwirq = fwspec->param[0] + priv->ht_vec_base;
>>   		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>   	} else {
>>   		*hwirq = fwspec->param[0] - priv->gsi_base;
>> -		*type = IRQ_TYPE_NONE;
>> +
>> +		if (fwspec->param_count > 1)
>> +			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>> +		else
>> +			*type = IRQ_TYPE_NONE;
> 
> This is yet another patch fixing PCI INTx handling. You can also move
> the check against 'param_count < 1' in this block.
> 
>>   	}
>>   
>>   	return 0;
> 
> 	M.
> 

