Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A325EF6B5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiI2NfH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiI2NfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 09:35:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AD0D4DB35;
        Thu, 29 Sep 2022 06:35:02 -0700 (PDT)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTWv8njVj0dQjAA--.6155S3;
        Thu, 29 Sep 2022 21:34:52 +0800 (CST)
Subject: Re: [PATCH V1 1/2] irqchip/loongson-pch-pic: Support to set irq type
 for ACPI path
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <1660615291-35409-1-git-send-email-lvjianmin@loongson.cn>
 <1660615291-35409-2-git-send-email-lvjianmin@loongson.cn>
 <86leq37duw.wl-maz@kernel.org>
 <71fc2d5b-fc3c-0a2d-65ce-df7d5bb26503@loongson.cn>
 <86ill67bwt.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <ab89a8b3-9b92-6afb-f3d4-660b5826c87f@loongson.cn>
Date:   Thu, 29 Sep 2022 21:34:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <86ill67bwt.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTWv8njVj0dQjAA--.6155S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW8Cw1kXryfAF1rCF1UAwb_yoW7uFy8pF
        Wj9FW2yw4kJFyxArn29w18AFyaywnIkrWxWFs8t3WxXrnI9r1xCF17urWruF1vyF4fCr42
        vr1vvFW7WFy7AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r
        yrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/9/29 下午5:44, Marc Zyngier wrote:
> On Wed, 28 Sep 2022 22:35:17 -0400,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> On 2022/9/28 下午10:49, Marc Zyngier wrote:
>>> On Mon, 15 Aug 2022 22:01:30 -0400,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>>
>>>> For ACPI path, the translate callback used IRQ_TYPE_NONE and ignored
>>>> the irq type in fwspec->param[1]. For supporting to set type for
>>>> irqs of the irqdomain, fwspec->param[1] should be used to get irq
>>>> type.
>>>>
>>>> On Loongson platform, the irq trigger type of PCI devices is
>>>> high level, so high level triggered type is inputed to acpi_register_gsi
>>>> when create irq mapping for PCI devices.
>>>>
>>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>> ---
>>>>    drivers/acpi/pci_irq.c                 |  3 ++-
>>>>    drivers/irqchip/irq-loongson-pch-pic.c | 10 ++++++----
>>>>    2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> $ ./scripts/get_maintainer.pl drivers/acpi/pci_irq.c
>>> Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
>>> "Rafael J. Wysocki" <rafael@kernel.org> (supporter:ACPI)
>>> Len Brown <lenb@kernel.org> (reviewer:ACPI)
>>> linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
>>> linux-acpi@vger.kernel.org (open list:ACPI)
>>> linux-kernel@vger.kernel.org (open list)
>>>
>>> How about you start Cc-ing some of the relevant people?
>>>
>> Ok, thanks, I'll cc relevant people list here.
>>
>>>>
>>>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>>>> index 08e1577..34483b3 100644
>>>> --- a/drivers/acpi/pci_irq.c
>>>> +++ b/drivers/acpi/pci_irq.c
>>>> @@ -393,7 +393,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>>>>    	 * controller and must therefore be considered active high
>>>>    	 * as default.
>>>>    	 */
>>>> -	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
>>>> +	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
>>>> +		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
>>>>    				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>>>
>>> The comment just above this only talks about ARM. Should it be
>>> updated?
>>
>> Ok, I'll update the comment.
>>
>>
>>> Is this a limitation of the underlying interrupt controller?
>>>
>> It's the limitation that pci interrupt source of LoongArch only sends
>> high level trigger signal to interrupt controller(though, pci spec
>> requires asserted low).
> 
> Right, so this is the opposite problem ARM has.
> 
> But is it *always* intended to be built like this? Or is it a one-off
> for this generation of Loongarch systems, to be fixed at a later time?
> 

Yes, new generations will always keep this unchanged.

>>
>>
>>>>    	char *link = NULL;
>>>>    	char link_desc[16];
>>>> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
>>>> index b6f1392..5067010 100644
>>>> --- a/drivers/irqchip/irq-loongson-pch-pic.c
>>>> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
>>>> @@ -177,13 +177,15 @@ static int pch_pic_domain_translate(struct irq_domain *d,
>>>>    	if (fwspec->param_count < 1)
>>>>    		return -EINVAL;
>>>>    -	if (of_node) {
>>>> +	if (of_node)
>>>>    		*hwirq = fwspec->param[0] + priv->ht_vec_base;
>>>> -		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>>> -	} else {
>>>> +	else
>>>>    		*hwirq = fwspec->param[0] - priv->gsi_base;
>>>> +
>>>> +	if (fwspec->param_count > 1)
>>>> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>>> +	else
>>>>    		*type = IRQ_TYPE_NONE;
>>>
>>> Isn't that a change in behaviour if of_node is non-NULL and
>>> param_count==1?
>>>
>>
>> It seems that current code here has bug that if fwspec->param_count==1
>> and of_node is non-null, fwspec->param[1] will be accessed, which is
>> introduced from previous patch(irqchip/loongson-pch-pic: Add ACPI init
>> support). Before the patch, for non-null of_node, translate
>> callback(use irq_domain_translate_twocell) will return -EINVAL if
>> fwspec->param_count < 2.
>>
>> For ACPI path, fwspec->param_count can be 1 or 2.
>>
>> So in this patch, I'll fix the bug and change the code as following:
>>
>>          if (fwspec->param_count < 1)
>>                  return -EINVAL;
>>
>>          if (of_node) {
>>                  if (fwspec->param_count < 2)
>>                          return -EINVAL;
>>
>>                  *hwirq = fwspec->param[0] + priv->ht_vec_base;
>>                  *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>          } else {
>>                  *hwirq = fwspec->param[0] - priv->gsi_base;
>>
>>                  if (fwspec->param_count > 1)
>>                          *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>                  else
>>                          *type = IRQ_TYPE_NONE;
>>          }
>>
>>
>>>> -	}
>>>>      	return 0;
>>>>    }
>>>
>>> This irqchip change should probably be a separate patch.
>>>
>>
>> As a separate patch, the input trigger type of pci devices will be low
>> level because of lacking of workaround to acpi_pci_irq_enable, which
>> will cause kernel hang, unless the patch of workaround to
>> acpi_pci_irq_enable is in front of this separated patch.
> 
> That seems like a sensible requirement, but I really want to
> understand whether PCI Loongarch will *always* generate INTx as
> ACTIVE_HIGH or not. Because if that is ever going to change, we will
> need a different way to inform the irqchip about the polarity
> inversion.
> 

Above same. And in future, in case some generation use ACTIVE_LOW, I 
think we can use use *Source*(means link) with triggering and polarity 
property in pci route table of DSDT as following code to override 
ACTIVE_HIGH, rather than *Source index*(gsi).

       if (entry->link)
             gsi = acpi_pci_link_allocate_irq(entry->link,
                                               entry->index,
                                               &triggering, &polarity,
                                               &link);


Because of a lot of machines outside have been shipped with firmware 
using *Source index*, for compatibility with such firmware, the 
workaround to acpi_pci_irq_enable is required.


> 	M.
> 

