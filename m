Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF66473D58E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 03:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjFZBac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Jun 2023 21:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZBab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Jun 2023 21:30:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B50B1194;
        Sun, 25 Jun 2023 18:30:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Dx+cUu6phk6woCAA--.3208S3;
        Mon, 26 Jun 2023 09:30:22 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx5sws6phkgX0IAA--.18114S3;
        Mon, 26 Jun 2023 09:30:20 +0800 (CST)
Message-ID: <f676d9e0-bb88-283a-5189-f1ae945ee4dd@loongson.cn>
Date:   Mon, 26 Jun 2023 09:30:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] PCI: Align pci memory space base address with page
 size
From:   bibo mao <maobibo@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20230619014715.3792883-1-maobibo@loongson.cn>
Content-Language: en-US
In-Reply-To: <20230619014715.3792883-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx5sws6phkgX0IAA--.18114S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF48Xw4UJry3AFy5tF4kXwc_yoW5uw13pF
        yxA3ZrCrW8Gr13G398t3s7uF4fXa97KFWY9ryrCa4rGF9rCryUC3s8XryagayDAr4DWrW0
        qFnYkF1Yqa1Yq3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
        AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
        UUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

gentle ping.

在 2023/6/19 09:47, Bibo Mao 写道:
> Some PCI devices have only 4K memory space size, it is normal in general
> machines and aligned with page size. However some architectures which
> support different page size, default page size on LoongArch is 16K, and
> ARM64 supports page size varying from 4K to 64K. On machines where larger
> page size is use, memory space region of two different pci devices may be
> in one page. It is not safe with mmu protection, also VFIO pci device
> driver requires base address of pci memory space page aligned, so that it
> can be memory mapped to qemu user space when it is passed-through to vm.
> 
> It consumes more pci memory resource with page size alignment requirement,
> here extra option PCI_MEMRES_PAGE_ALIGN is added, it can be enabled by
> different architectures, currently arm64/loongarch enable this option.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> Change history
> v5: enable option PCI_MEMRES_PAGE_ALIGN on arm64. Verified on LoongArch
> and pass to compile on arm64 with defconfig
> 
> v4: add extra kernel option PCI_MEMRES_PAGE_ALIGN to set memory resource
>     page aligned
> 
> v3: move alignment requirement to generic pci code
> 
> v2: add pci resource alignment requirement in arch specified function
>     pcibios_align_resource on arm64/LoongArch platforms
> 
> ---
>  arch/arm64/Kconfig      | 1 +
>  arch/loongarch/Kconfig  | 1 +
>  drivers/pci/Kconfig     | 3 +++
>  drivers/pci/setup-res.c | 7 +++++++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 343e1e1cae10..24858bbf2b72 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -232,6 +232,7 @@ config ARM64
>  	select OF_EARLY_FLATTREE
>  	select PCI_DOMAINS_GENERIC if PCI
>  	select PCI_ECAM if (ACPI && PCI)
> +	select PCI_MEMRES_PAGE_ALIGN if PCI
>  	select PCI_SYSCALL if PCI
>  	select POWER_RESET
>  	select POWER_SUPPLY
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931..7dbde5e5b351 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -140,6 +140,7 @@ config LOONGARCH
>  	select PCI_DOMAINS_GENERIC
>  	select PCI_ECAM if ACPI
>  	select PCI_LOONGSON
> +	select PCI_MEMRES_PAGE_ALIGN
>  	select PCI_MSI_ARCH_FALLBACKS
>  	select PCI_QUIRKS
>  	select PERF_USE_VMALLOC
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9309f2469b41..9be5f85ff9dc 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -128,6 +128,9 @@ config PCI_LOCKLESS_CONFIG
>  config PCI_BRIDGE_EMUL
>  	bool
>  
> +config PCI_MEMRES_PAGE_ALIGN
> +	bool
> +
>  config PCI_IOV
>  	bool "PCI IOV support"
>  	select PCI_ATS
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 967f9a758923..6ad76734a670 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -339,6 +339,13 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
>  		return -EINVAL;
>  	}
>  
> +#ifdef CONFIG_PCI_MEMRES_PAGE_ALIGN
> +	/*
> +	 * force minimum page alignment for vfio pci usage
> +	 */
> +	if (res->flags & IORESOURCE_MEM)
> +		align = max_t(resource_size_t, PAGE_SIZE, align);
> +#endif
>  	size = resource_size(res);
>  	ret = _pci_assign_resource(dev, resno, size, align);
>  

