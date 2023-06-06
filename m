Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6416723F06
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFFKOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 06:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFKOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 06:14:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7DCE42;
        Tue,  6 Jun 2023 03:14:01 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxCeobBX9k4xYAAA--.103S3;
        Tue, 06 Jun 2023 18:06:19 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxReQMBX9kkCcCAA--.9410S3;
        Tue, 06 Jun 2023 18:06:04 +0800 (CST)
Message-ID: <57c428e9-6d7c-c0b7-be5f-365373ab1b9c@loongson.cn>
Date:   Tue, 6 Jun 2023 18:06:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] PCI: Align pci memory space base address with page
 size
Content-Language: en-US
From:   "bibo, mao" <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230606084539.1694441-1-maobibo@loongson.cn>
In-Reply-To: <20230606084539.1694441-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxReQMBX9kkCcCAA--.9410S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw1xGry5Ar18WFW7Kr1xWFX_yoW8Kw4kpF
        WxCFn8CrWkKr1fGws2qw1DuF4fWws2gFWYkrWIkas0k3Z7JasFyry7GrW5Cry8Wrs3Gr1j
        qFs8tr1xXa48ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
        6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        9SdDUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Huacai,

Although I post this patch, I think this should be arch specified rather than general problem.
X86 has solved this problem, arm64 with 64K page size is not popular. However LoongArch
has this problem, page size is 16K rather than 4K. It is the problem of LoongArch system
rather than generic issue.

There is such discussion before:
https://patchwork.kernel.org/project/linux-pci/patch/22400b8828ad44ddbccb876cc5ca3b11@FE-MBX1012.de.bosch.com/#19319457

UEFI bios sets pci memory space 4K aligned, however Loongarch kernel rescans the pci
bus and reassigns pci memory resource. So it it strange like this, here is pci memory info on
 my 7A2000 board.
root@user-pc:~# lspci -vvv | grep Region
        Region 5: Memory at e003526e800 (32-bit, non-prefetchable) [size=1K]
        Region 0: Memory at e003526ec00 (64-bit, non-prefetchable) [size=1K]

Regards
Bibo, Mao

在 2023/6/6 16:45, Bibo Mao 写道:
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
> it should not be a problem on 64 bit system.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/pci/setup-res.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 967f9a758923..55440ae0128d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -339,6 +339,14 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
>  		return -EINVAL;
>  	}
>  
> +#ifdef CONFIG_64BIT
> +	/*
> +	 * force minimum page alignment for vfio pci usage
> +	 * supposing there is enough pci memory resource on 64bit system
> +	 */
> +	if (res->flags & IORESOURCE_MEM)
> +		align = max_t(resource_size_t, PAGE_SIZE, align);
> +#endif
>  	size = resource_size(res);
>  	ret = _pci_assign_resource(dev, resno, size, align);
>  

