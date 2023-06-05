Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B27229CC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjFEOvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjFEOvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 10:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E36FD;
        Mon,  5 Jun 2023 07:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6ADC62635;
        Mon,  5 Jun 2023 14:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3672DC4339B;
        Mon,  5 Jun 2023 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976705;
        bh=tVVido3T4gfgRQ2GgQgMcTHENzpErpk9i+d9AUbaNCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWKJ6gPeqOP6il8lQWEbrboryM9xwV2fxcEB++ou1yyIfWHenYszJ2u26Hf3XVWBI
         fY8A46jIVuWGZSKd/zSO+yTFNjq1kcn9Bu9TdKpgm0qXmLJv7B7ZFrjeZ55fXJAwWE
         siQonTg9nP0EDD4wGUwUsJKdra59ZUY6oP9p3KeGo+ztJ/BlBbDGhe7V2/qew6kP+H
         HkGsO2oC9ayDnN+9GrpgREKYX2b4OP++ScgOXa9iwb/1Wq3/ppGifcc6PxXGN+DASv
         X7CAi9twr9V/eVgb/76ghkfIfM10kQu7+9vzxhhj8bU10Bf+q4qoy1ECTwV+bTTDac
         YhMJha3x97jEA==
Date:   Mon, 5 Jun 2023 15:51:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2] PCI: Align pci memory space base address with page
 size
Message-ID: <20230605145138.GH21212@willie-the-truck>
References: <20230605034423.1528206-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605034423.1528206-1-maobibo@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 11:44:23AM +0800, Bibo Mao wrote:
> Some PCI devices has only 4K memory space size, it is normal in general
> machines and aligned with page size. However some architectures which
> support different page size, default page size on LoongArch is 16K, and
> ARM64 supports page size varying from 4K to 64K. On machines where larger
> page size is use, memory space region of two different pci devices may be
> in one page. It is not safe with mmu protection, also VFIO pci device
> driver requires base address of pci memory space page aligned, so that it
> can be memory mapped to qemu user space when it is pass-through to vm.
> 
> It consumes more pci memory resource with page size alignment requirement,
> on 64 bit system it should not be a problem. And UEFI bios set pci memory
> base address with 4K fixed-size aligned, the safer solution is to align
> with larger size on UEFI BIOS stage on these architectures, linux kernel
> can reuse resource from UEFI bios. For new devices such hotplug pci
> devices and sriov devices, pci resource is assigned in Linux kernel side.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/arm64/kernel/pci.c  | 13 +++++++++++++
>  arch/loongarch/pci/pci.c | 18 ++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 2276689b5411..e2f7b176b156 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -232,4 +232,17 @@ void pcibios_remove_bus(struct pci_bus *bus)
>  	acpi_pci_remove_bus(bus);
>  }
>  
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +				resource_size_t size, resource_size_t align)
> +{
> +	resource_size_t start = res->start;
> +
> +	/*
> +	 * align base address of pci memory resource with page size
> +	 */
> +	if ((res->flags & IORESOURCE_MEM) && (align < PAGE_SIZE))
> +		start = ALIGN(start, PAGE_SIZE);
> +
> +	return start;
> +}
>  #endif

If this is needed by all architectures with !4k page size, why don't we
instead handle the alignment in the core code, given that it is aware
of the page size?

Will
