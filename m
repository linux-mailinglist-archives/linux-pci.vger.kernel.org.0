Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E882779AD9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Aug 2023 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjHKWzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKWzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 18:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5E2684;
        Fri, 11 Aug 2023 15:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9976699C;
        Fri, 11 Aug 2023 22:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB14C433C7;
        Fri, 11 Aug 2023 22:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691794504;
        bh=Q7V6f7/a5wP37cs01XRxe2wZwIO73qbygkYyOw3BkFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZYWoaL8RsWyaAYVEnKcLFqSuK0f1ISsWkHQLVktDvPTAoOzkLQ8IlCzMeESoIHxn7
         Dh6VXuaZyGKX6CVbCr3t08TF8cNcFQKFqyGzg50Wg1wPDJixzknxolW1mE4SvgR4UH
         UgHUJqDKw/ftaxOFbQFijVoiMIcTGL+dRRuksMkkEpo/q+9Lv7UIVGMCbKkuNbSsS9
         fBE5bv9eKazXyhOHbtekF77k1uSBa2kt3CWj5XzjozvWmRxFB2HTln0U5Cht9XaEO+
         TaGqa61nOqPs+ZrSVlExJ/V7WP1Y1NlXj8d2XBEvO4cDJeULK7BGPNJ0K1eESooaEM
         R2MW1qpf7FP+Q==
Date:   Fri, 11 Aug 2023 17:55:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Li Yi <liyi@loongson.cn>, linux-pci@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Remove vgaarb related workarounds
Message-ID: <20230811225500.GA118486@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801185607.703295-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 02:56:07AM +0800, Sui Jingfeng wrote:
> When we have a better approach[1] to handle multiple video cards problems
> on Loongarch, we want to drop the vgaarb related workaround.
> 
> [1] https://patchwork.freedesktop.org/patch/550708/?series=121740&rev=1

If I understand correctly, this patch depends on [1].  The way you do
this is to send both patches in a single series, e.g.,

  [PATCH 0/2] <cover letter>
  [PATCH 1/2] PCI/VGA: Make the vga_is_firmware_default() less arch-independent
  [PATCH 2/2] LoongArch: Remove vgaarb related workarounds

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Li Yi <liyi@loongson.cn>
> Cc: linux-pci@vger.kernel.org
> Cc: loongson-kernel@lists.loongnix.cn
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  arch/loongarch/pci/pci.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> index 2726639150bc..4319b5d75872 100644
> --- a/arch/loongarch/pci/pci.c
> +++ b/arch/loongarch/pci/pci.c
> @@ -8,13 +8,10 @@
>  #include <linux/acpi.h>
>  #include <linux/types.h>
>  #include <linux/pci.h>
> -#include <linux/vgaarb.h>
>  #include <asm/cacheflush.h>
>  #include <asm/loongson.h>
>  
>  #define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
> -#define PCI_DEVICE_ID_LOONGSON_DC1      0x7a06
> -#define PCI_DEVICE_ID_LOONGSON_DC2      0x7a36
>  
>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>  						int reg, int len, u32 *val)
> @@ -82,19 +79,3 @@ int pcibios_alloc_irq(struct pci_dev *dev)
>  		return 0;
>  	return acpi_pci_irq_enable(dev);
>  }
> -
> -static void pci_fixup_vgadev(struct pci_dev *pdev)
> -{
> -	struct pci_dev *devp = NULL;
> -
> -	while ((devp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, devp))) {
> -		if (devp->vendor != PCI_VENDOR_ID_LOONGSON) {
> -			vga_set_default_device(devp);
> -			dev_info(&pdev->dev,
> -				"Overriding boot device as %X:%X\n",
> -				devp->vendor, devp->device);
> -		}
> -	}
> -}
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC1, pci_fixup_vgadev);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC2, pci_fixup_vgadev);
> -- 
> 2.34.1
> 
