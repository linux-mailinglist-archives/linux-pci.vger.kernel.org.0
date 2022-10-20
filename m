Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE3606627
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJTQr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiJTQrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 12:47:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016C1CD31B;
        Thu, 20 Oct 2022 09:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99FA2B828AE;
        Thu, 20 Oct 2022 16:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED999C433D6;
        Thu, 20 Oct 2022 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666284440;
        bh=i2MxslQTn19sPCgAavDX/R8BnJavJaB9fvKHaUuXvsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MWN7oC5hi/4+3tLMYX3dO5X/w68hAQRuOaylnk1rkAt0muhiSPMJs7BjKNfl3WJnB
         KWjakKCZBHA2GnSypMFC0jBa6Yrxr/7SKc5P1n/1McgtNqzFfe8iGj5HtgEwoM7Ahw
         GNEFYFV0q7C62dO69GWAb9ny5sCeH4elomWkd72uSuhpyDZaleMHgqLxvRZl5Z8Yio
         LryF36J38pR05ePvkTSaDYnUbKeRaQkt1joW4w0IEVZeklDV7Du1c4ZzZ2grRxG2IX
         VrpZAVTYt59GCAzXygXxE/MhqgVrM1L5pRUFILzj9dwLf7Mr0nboRpVhGBIFpDm91A
         aefgjE+iSfO2g==
Date:   Thu, 20 Oct 2022 11:47:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V4 1/4] ACPI / PCI: fix LPIC IRQ model default PCI IRQ
 polarity
Message-ID: <20221020164718.GA127832@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020082205.20505-2-lvjianmin@loongson.cn>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 04:22:02PM +0800, Jianmin Lv wrote:
> On LoongArch ACPI based systems, the PCI devices (e.g. sata
> controlers and PCI-to-to PCI bridge controlers) existed in
> Loongson chipsets output high-level interrupt signal to the
> interrupt controller they connected to,

I assume the active high behavior is hardware behavior that is
independent of the fact that you're using ACPI firmware on the
hardware.  If so, I would omit "ACPI based".

s/sata/SATA/
s/controlers/controllers/ (twice)
s/PCI-to-to PCI/PCI-to-PCI/
s/existed in/in/
s/they connected/they are connected/

> while the IRQs are
> active low from the perspective of PCI(in 2.2.6. Interrupt
> Pins, "Interrupts on PCI are optional and defined as level
> sensitive, asserted low),

I don't think you need this spec reference, since "asserted low" is
the standard thing that happens everywhere.  But if you do want it, it
needs to specify which spec it refers to, e.g., "Conventional PCI
r3.0, sec 2.2.6" so it's not confused with the PCIe spec.

The quote from the spec itself should be terminated with a close quote
("), i.e., 

  "Interrupts on PCI ... asserted low"

> which means that the interrupt
> output of PCI devices plugged into PCI-to-to PCI bridges of
> Loongson chipset will be also converted to high-level. So
> high level triggered type is required to be passed to
> acpi_register_gsi() when creating mappings for PCI devices.

This is the part where I was hoping for a reference to a spec that
talks about how PCI interrupts are inverted.  The inverter is the part
that's special here.

I see that ACPI r6.5, sec 5.2.12, mentions LPIC, but it doesn't
mention the inverter.  It has a lot more mentions of GIC, but also no
details about an inverter.  I suppose that would be in the GIC spec,
which I'm not familiar with.

The point is that one should be able to write this code from a spec,
without having to empirically discover the interrupt polarity.  What
spec tells you about using ACTIVE_HIGH here?

s/PCI-to-to PCI/PCI-to-PCI/ again

Rewrap the log to fill 75 columns like the rest of the history.

> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  drivers/acpi/pci_irq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 08e15774fb9f..ff30ceca2203 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -387,13 +387,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  	u8 pin;
>  	int triggering = ACPI_LEVEL_SENSITIVE;
>  	/*
> -	 * On ARM systems with the GIC interrupt model, level interrupts
> +	 * On ARM systems with the GIC interrupt model, or LoongArch
> +	 * systems with the LPIC interrupt model, level interrupts

Is "LoongArch" required in this comment?  Might the LPIC model be used
on non-LoongArch systems?

I see it follows the example of "ARM systems".  In my opinion, "ARM"
probably should be removed, too, because the code checks only for GIC
or LPIC; it doesn't check for ARM or LoongArch.

If GIC is restricted to ARM and LPIC is restricted to LoongArch,
that's fine, but that constraint should be expressed somewhere else
and doesn't need to be repeated here.

>  	 * are always polarity high by specification; PCI legacy
>  	 * IRQs lines are inverted before reaching the interrupt
>  	 * controller and must therefore be considered active high
>  	 * as default.
>  	 */
> -	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> +	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
> +		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
>  				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>  	char *link = NULL;
>  	char link_desc[16];
> -- 
> 2.31.1
> 
