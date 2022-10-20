Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AFF6055DA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 05:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJTDQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 23:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiJTDQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 23:16:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3D161C0731;
        Wed, 19 Oct 2022 20:16:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8BxLtuUvVBjjOwAAA--.4712S3;
        Thu, 20 Oct 2022 11:16:36 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuCTvVBjiq0BAA--.6867S3;
        Thu, 20 Oct 2022 11:16:36 +0800 (CST)
Subject: Re: [PATCH V3 1/4] ACPI / PCI: fix LPIC irq model default PCI IRQ
 polarity
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20221019160529.GA18372@bhelgaas>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <0ebec963-d835-39cc-537a-bd58855b0171@loongson.cn>
Date:   Thu, 20 Oct 2022 11:16:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221019160529.GA18372@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPuCTvVBjiq0BAA--.6867S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF4ruF17Kw1DuryUAF1xAFb_yoW8Kr1fpF
        Za9an0yrW8tF4DXrs2k3WxXF13XwnakryjkFZ8AanrCFsxur4SvF1IgFy5JryDCFZ5Za18
        Zr1jyF18WasruaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok, thanks, I'll improve them as your suggestion.

On 2022/10/20 上午12:05, Bjorn Helgaas wrote:
> In the subject and the commit log below, figure out whether you want
> to use "irq" or "IRQ" and do it consistently.  I vote for "IRQ".  Also
> consider subject lines for the other patches.  Stuff like this is
> trivial, but it's an excuse for whoever will handle this (not me in
> this case) to put it off.  I also add "()" after function names for
> clarity.
> 
> On Sun, Oct 09, 2022 at 02:44:28PM +0800, Jianmin Lv wrote:
>> On LoongArch ACPI based systems, the irq trigger type of PCI devices
>> is high level, so high level triggered type is required to pass
>> to acpi_register_gsi when create irq mapping for PCI devices.
> 
> This isn't worded quite right.  The trigger type of PCI devices
> doesn't change just because you plug them into a LoongArch system
> instead of an x86 system.  The comment in the code reads better: The
> IRQs are active low from the perspective of PCI, but are inverted
> before the interrupt controller.
> 
> Including a reference here to the spec that mentions this inversion
> would help a lot.
> 
> s/when create mapping/when creating mappings/
> 
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/acpi/pci_irq.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
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
>> -- 
>> 2.31.1
>>

