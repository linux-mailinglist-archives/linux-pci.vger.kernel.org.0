Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34B539B18
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 04:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbiFACHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 22:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiFACHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 22:07:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BA51E7B
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2022 19:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8518B81753
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 02:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA0C385A9;
        Wed,  1 Jun 2022 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654049260;
        bh=wQCNarAZpwDIZGfNL4rIxLmqpDeo3vHPhefx290CNfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lte/MsUffwvdcHFtaAHNfJ30anUlcmg4CvW4MHBHlqBSW78RvbCova8WBOyrN68Xb
         NDpWrZbwE17X0h8DWFMp5uazwEvx9DGtNOyxXiiekQ2QNUlMRL86wt2K1FmHHAuRk5
         UgdGFGZGwcYgnB1AsIfUUMrafFmzHq1LTcqqXhEtVAAgRqHh5niQVNGOVccGfZMbgw
         dSYBJfOnV6//P71SRjMD/qMpyrwhhGHKdl9TgZWfEwvuO8kllG6NhnWZSM98UWX4jj
         1OBvH0vQVn1VFgxOCJ2HMo+q8E35Q9wMir11vJHnFqN8p6l4bXH0cMACq3Yyf0uZem
         kotupuLZ2fvUA==
Date:   Tue, 31 May 2022 21:07:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: Re: [PATCH V13 6/6] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20220601020737.GA798493@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430084846.3127041-7-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 04:48:46PM +0800, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> In LS7A, multifunction device use same PCI PIN (because the PIN register
> report the same INTx value to each function) but we need different IRQ
> for different functions, so add a quirk to fix it for standard PCI PIN
> usage.

Is this because your _PRT is missing or broken?  of_irq_parse_pci()
reads and relies on PCI_INTERRUPT_PIN, too, so it seems like the _PRT
could contain the same routing information you're getting from DT.

> This patch only affect ACPI based systems (and only needed by ACPI based
> systems, too). For DT based systems, the irq mappings is defined in .dts
> files and be handled by of_irq_parse_pci().
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 49d8b8c24ffb..024542a31a8c 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -22,6 +22,13 @@
>  #define DEV_LS2K_APB	0x7a02
>  #define DEV_LS7A_CONF	0x7a10
>  #define DEV_LS7A_LPC	0x7a0c
> +#define DEV_LS7A_GMAC	0x7a03
> +#define DEV_LS7A_DC1	0x7a06
> +#define DEV_LS7A_DC2	0x7a36
> +#define DEV_LS7A_GPU	0x7a15
> +#define DEV_LS7A_AHCI	0x7a08
> +#define DEV_LS7A_EHCI	0x7a14
> +#define DEV_LS7A_OHCI	0x7a24
>  
>  #define FLAG_CFG0	BIT(0)
>  #define FLAG_CFG1	BIT(1)
> @@ -102,6 +109,31 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
>  
> +static void loongson_pci_pin_quirk(struct pci_dev *pdev)
> +{
> +	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_DC1, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_DC2, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_GPU, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_GMAC, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_AHCI, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_EHCI, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_LS7A_OHCI, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
> +			DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
> -- 
> 2.27.0
> 
