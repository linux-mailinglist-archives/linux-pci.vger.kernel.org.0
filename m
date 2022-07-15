Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A00575A10
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 05:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiGODoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 23:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 23:44:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D813D3C
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 20:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99E63B82A62
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 03:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D286AC34114;
        Fri, 15 Jul 2022 03:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657856645;
        bh=u3brOy8+gbii12UWUIU774cAO1EQhkZV8wyCzCwE62w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oQCPDtV8BtcjhT5EAYojd1JQP93Y+7UmmyXlGvd7uuoce+w1Zb6ObNUPIghlh+sog
         haZX1sD7dQgTPZUMA9q0edqBQYejuJohCxIs2yIn6QiMEfv0nj0vVkAd1D+/icahhF
         k4jZkFWf1MLiTtGaBkdazbjMKPAN+F6oLoUJRKEyGFW7HcNGEdToRW0yJwAhm1B2Ky
         SEleakuniz98JbCTsBnA5dKNq5WrS0n0dvEJZolJK7qwE9JvXYMM+k82DJQoTeQwso
         +eQW6VXhgz4A+N/5y4EqRJjqihQIIk6fSiukSTIRhXGnT7Lxit5PfwyngmVDPfV8fs
         Nh/cAnP7wNhtQ==
Date:   Thu, 14 Jul 2022 22:44:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20220715034402.GA1047213@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714124216.1489304-8-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 08:42:16PM +0800, Huacai Chen wrote:
> From: Jianmin Lv <lvjianmin@loongson.cn>
> 
> In LS7A, multifunction device use same PCI PIN (because the PIN register
> report the same INTx value to each function) but we need different IRQ
> for different functions, so add a quirk to fix it for standard PCI PIN
> usage.
> 
> This patch only affect ACPI based systems (and only needed by ACPI based
> systems, too). For DT based systems, the irq mappings is defined in .dts
> files and be handled by of_irq_parse_pci().

I'm sorry, I know you've explained this before, but I don't understand
yet, so let's try again.  I *think* you're saying that:

  - These devices integrated into LS7A all report 0 in their Interrupt
    Pin registers.  Per spec, this means they do not use INTx (PCIe
    r6.0, sec 7.5.1.1.13).

  - However, these devices actually *do* use INTx.  Function 0 uses
    INTA, function 1 uses INTB, ..., function 4 uses INTA, ...

  - The quirk overrides the incorrect values read from the Interrupt
    Pin registers.

That much makes sense to me.

And I even see that in of_irq_parse_pci(), if there's a DT node for
the device, of_irq_parse_one() gets the interrupt info from DT and
returns the IRQ all the way back up to (I think) loongson_map_irq().

But I'm still confused about how loongson_map_irq() gets called.  The
only likely path I see is here:

  pci_device_probe                            # pci_bus_type.probe
    pci_assign_irq
      pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin)
      if (pin)
	bridge->swizzle_irq(dev, &pin)
	irq = bridge->map_irq(dev, slot, pin)

where bridge->map_irq points to loongson_map_irq().  But
pci_assign_irq() should read 0 from PCI_INTERRUPT_PIN [1], so it
wouldn't call bridge->map_irq().  Obviously I'm missing something.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/setup-irq.c?id=v5.18#n37

> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 05997b51c86d..4043b57bcc86 100644
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
> @@ -103,6 +110,31 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
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
> 2.31.1
> 
