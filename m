Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E94721E24
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFEGb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEGb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 02:31:58 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C754ADA;
        Sun,  4 Jun 2023 23:31:55 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxP_BYgX1kuAUAAA--.151S3;
        Mon, 05 Jun 2023 14:31:52 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxUORYgX1kDgMAAA--.134S3;
        Mon, 05 Jun 2023 14:31:52 +0800 (CST)
Message-ID: <749898e2-01c2-9f74-f939-fac36227431a@loongson.cn>
Date:   Mon, 5 Jun 2023 14:31:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] PCI: Align pci memory space base address with page
 size
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20230605034423.1528206-1-maobibo@loongson.cn>
 <CAAhV-H6O+_EnmDU6kE-19PP+8tD3wwbzzuakE_vHZGCtjZWDbg@mail.gmail.com>
From:   "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H6O+_EnmDU6kE-19PP+8tD3wwbzzuakE_vHZGCtjZWDbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxUORYgX1kDgMAAA--.134S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryUWr4UCFy8Cr4xCF43twc_yoWrWF1rpF
        yxAan8CF45Gr17GwsIqw1DWFs3uws2kw43ArW3Jry3KFyDZ34xXF15Jry5urW8Aws8GrW0
        vF4Ykr17CFyDXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aDUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/6/5 11:58, Huacai Chen 写道:
> Hi, Bibo,
> 
> Three suggestions:
> 1, split to two patches.
will do.
> 2, the "(align < PAGE_SIZE)" condition can be removed.
With  "(align < PAGE_SIZE)" condition, there is little modification compared
to the weak function.
resource_size_t __weak pcibios_align_resource(void *data,
                                              const struct resource *res,
                                              resource_size_t size,
                                              resource_size_t align)
{       
       return res->start;
}

or do you mean something this?
       if (res->flags & IORESOURCE_MEM) {
		align = max_t(resource_size_t, PAGE_SIZE, align);
		start = ALIGN(start, align);
	}
   

> 3, you can unify the comments between ARM64 and LoongArch.
will do.

Regards
Bibo, Mao

> 
> Huacai
> 
> On Mon, Jun 5, 2023 at 11:44 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Some PCI devices has only 4K memory space size, it is normal in general
>> machines and aligned with page size. However some architectures which
>> support different page size, default page size on LoongArch is 16K, and
>> ARM64 supports page size varying from 4K to 64K. On machines where larger
>> page size is use, memory space region of two different pci devices may be
>> in one page. It is not safe with mmu protection, also VFIO pci device
>> driver requires base address of pci memory space page aligned, so that it
>> can be memory mapped to qemu user space when it is pass-through to vm.
>>
>> It consumes more pci memory resource with page size alignment requirement,
>> on 64 bit system it should not be a problem. And UEFI bios set pci memory
>> base address with 4K fixed-size aligned, the safer solution is to align
>> with larger size on UEFI BIOS stage on these architectures, linux kernel
>> can reuse resource from UEFI bios. For new devices such hotplug pci
>> devices and sriov devices, pci resource is assigned in Linux kernel side.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  arch/arm64/kernel/pci.c  | 13 +++++++++++++
>>  arch/loongarch/pci/pci.c | 18 ++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 2276689b5411..e2f7b176b156 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -232,4 +232,17 @@ void pcibios_remove_bus(struct pci_bus *bus)
>>         acpi_pci_remove_bus(bus);
>>  }
>>
>> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>> +                               resource_size_t size, resource_size_t align)
>> +{
>> +       resource_size_t start = res->start;
>> +
>> +       /*
>> +        * align base address of pci memory resource with page size
>> +        */
>> +       if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
>> +               start = ALIGN(start, PAGE_SIZE);
>> +
>> +       return start;
>> +}
>>  #endif
>> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
>> index 2726639150bc..943a48e60fb1 100644
>> --- a/arch/loongarch/pci/pci.c
>> +++ b/arch/loongarch/pci/pci.c
>> @@ -83,6 +83,24 @@ int pcibios_alloc_irq(struct pci_dev *dev)
>>         return acpi_pci_irq_enable(dev);
>>  }
>>
>> +/*
>> + * memory space size of some pci cards is 4K, it is separated with
>> + * different pages for generic architectures, so that mmu protection can
>> + * work with different pci cards. However page size for LoongArch system
>> + * is 16K, memory space of different pci cards may share the same page
>> + * on LoongArch, it is not safe here.
>> + */
>> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>> +                               resource_size_t size, resource_size_t align)
>> +{
>> +       resource_size_t start = res->start;
>> +
>> +       if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
>> +               start = ALIGN(start, PAGE_SIZE);
>> +
>> +       return start;
>> +}
>> +
>>  static void pci_fixup_vgadev(struct pci_dev *pdev)
>>  {
>>         struct pci_dev *devp = NULL;
>> --
>> 2.27.0
>>
> _______________________________________________
> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn

