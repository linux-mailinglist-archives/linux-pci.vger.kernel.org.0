Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E86C74A91C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 04:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGGCrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGGCrv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 22:47:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13AC91BE9;
        Thu,  6 Jul 2023 19:47:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxlPDSfKdkH08BAA--.4928S3;
        Fri, 07 Jul 2023 10:47:46 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8zRfKdk_2EgAA--.55042S3;
        Fri, 07 Jul 2023 10:47:45 +0800 (CST)
Message-ID: <bdc6eb71-482d-5dd6-d527-c2f2f68dfb38@loongson.cn>
Date:   Fri, 7 Jul 2023 10:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] PCI: Align pci memory space base address with page
 size
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
To:     Will Deacon <will@kernel.org>, loongson-kernel@lists.loongnix.cn
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Reply-To: Bjorn Helgaas <bhelgaas@google.com>,
          Huacai Chen <chenhuacai@kernel.org>
References: <20230619014715.3792883-1-maobibo@loongson.cn>
 <f676d9e0-bb88-283a-5189-f1ae945ee4dd@loongson.cn>
In-Reply-To: <f676d9e0-bb88-283a-5189-f1ae945ee4dd@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8zRfKdk_2EgAA--.55042S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4fJFyxZFWDWF4xtr4xAFc_yoWrWw48pF
        yfA3ZrCrW8Jr13Gwsaq34kuFsxZ397KrW5Kry5Ca4rGF9ruryUCry5WryagayDArs8WrW0
        qFn5KF1Yva15XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PU
        UUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjourn, Hucai,

ping again.

The is such issue on only LoongArch system since 16K page size is used.

Should we add code in general framework  or in LoongArch specified code
in v1?  

If you do not think that it is problem, I can give up. LoongArch system
is not only for myself own, I do not care about it also since LoongArch
Maintainer think it is not a issue.

Regards
Bibo Mao

在 2023/6/26 09:30, bibo mao 写道:
> gentle ping.
> 
> 在 2023/6/19 09:47, Bibo Mao 写道:
>> Some PCI devices have only 4K memory space size, it is normal in general
>> machines and aligned with page size. However some architectures which
>> support different page size, default page size on LoongArch is 16K, and
>> ARM64 supports page size varying from 4K to 64K. On machines where larger
>> page size is use, memory space region of two different pci devices may be
>> in one page. It is not safe with mmu protection, also VFIO pci device
>> driver requires base address of pci memory space page aligned, so that it
>> can be memory mapped to qemu user space when it is passed-through to vm.
>>
>> It consumes more pci memory resource with page size alignment requirement,
>> here extra option PCI_MEMRES_PAGE_ALIGN is added, it can be enabled by
>> different architectures, currently arm64/loongarch enable this option.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> Change history
>> v5: enable option PCI_MEMRES_PAGE_ALIGN on arm64. Verified on LoongArch
>> and pass to compile on arm64 with defconfig
>>
>> v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory resource
>>     page aligned
>>
>> v3: move alignment requirement to generic pci code
>>
>> v2: add pci resource alignment requirement in arch specified function
>>     pcibios_align_resource on arm64/LoongArch platforms
>>
>> ---
>>  arch/arm64/Kconfig      | 1 +
>>  arch/loongarch/Kconfig  | 1 +
>>  drivers/pci/Kconfig     | 3 +++
>>  drivers/pci/setup-res.c | 7 +++++++
>>  4 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 343e1e1cae10..24858bbf2b72 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -232,6 +232,7 @@ config ARM64
>>  	select OF_EARLY_FLATTREE
>>  	select PCI_DOMAINS_GENERIC if PCI
>>  	select PCI_ECAM if (ACPI && PCI)
>> +	select PCI_MEMRES_PAGE_ALIGN if PCI
>>  	select PCI_SYSCALL if PCI
>>  	select POWER_RESET
>>  	select POWER_SUPPLY
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index d38b066fc931..7dbde5e5b351 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -140,6 +140,7 @@ config LOONGARCH
>>  	select PCI_DOMAINS_GENERIC
>>  	select PCI_ECAM if ACPI
>>  	select PCI_LOONGSON
>> +	select PCI_MEMRES_PAGE_ALIGN
>>  	select PCI_MSI_ARCH_FALLBACKS
>>  	select PCI_QUIRKS
>>  	select PERF_USE_VMALLOC
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 9309f2469b41..9be5f85ff9dc 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
>>  config PCI_BRIDGE_EMUL
>>  	bool
>>  
>> +config PCI_MEMRES_PAGE_ALIGN
>> +	bool
>> +
>>  config PCI_IOV
>>  	bool "PCI IOV support"
>>  	select PCI_ATS
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 967f9a758923..6ad76734a670 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
>>  		return -EINVAL;
>>  	}
>>  
>> +#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
>> +	/*
>> +	 * force minimum page alignment for vfio pci usage
>> +	 */
>> +	if (res->flags & IORESOURCE_MEM)
>> +		align = max_t(resource_size_t, PAGE_SIZE, align);
>> +#endif
>>  	size = resource_size(res);
>>  	ret = _pci_assign_resource(dev, resno, size, align);
>>  
> 
> _______________________________________________
> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn

