Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B77604CC0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiJSQGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiJSQGe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:06:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3F182C6F;
        Wed, 19 Oct 2022 09:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0769AB824C4;
        Wed, 19 Oct 2022 16:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F133C433D6;
        Wed, 19 Oct 2022 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666195531;
        bh=DIW+v8xkiPis7AGg4MAy9kjNE+tuDnmqL4alFuqnN0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=boUh9bXBug5QWmLoVGC89zpgd81p6NwxyoNVdcXYhM3QtRmBo1DKrEG9H+z9s7UyN
         +u1QGHlZan8ofhlkJ4/jVvFcSMeLfZX0iffS5ZSpGY4vkeWjaSlsqE3wP2m7TfTORq
         WWTOClc2lI+IZWVubi2PaVqDuHDhAA8XHO7gfgaivsj8PeU6l+Y0UWqyE/PPmef96i
         O/Gr+qDR8nO0XT5t6Zp7I/7pUz39kSkFmSQtmuu5DPPk0uOMolzmdXSg2cKQ08JXas
         1mWhpDm4YqUTI05r/g6byFjDwQz1Z6FYzyTC9Z9O4oAt12Hqjd9xkNbOOaajlSbqfh
         iiR4w75JJ3pLQ==
Date:   Wed, 19 Oct 2022 11:05:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V3 1/4] ACPI / PCI: fix LPIC irq model default PCI IRQ
 polarity
Message-ID: <20221019160529.GA18372@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009064431.18839-2-lvjianmin@loongson.cn>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the subject and the commit log below, figure out whether you want
to use "irq" or "IRQ" and do it consistently.  I vote for "IRQ".  Also
consider subject lines for the other patches.  Stuff like this is
trivial, but it's an excuse for whoever will handle this (not me in
this case) to put it off.  I also add "()" after function names for
clarity.

On Sun, Oct 09, 2022 at 02:44:28PM +0800, Jianmin Lv wrote:
> On LoongArch ACPI based systems, the irq trigger type of PCI devices
> is high level, so high level triggered type is required to pass
> to acpi_register_gsi when create irq mapping for PCI devices.

This isn't worded quite right.  The trigger type of PCI devices
doesn't change just because you plug them into a LoongArch system
instead of an x86 system.  The comment in the code reads better: The
IRQs are active low from the perspective of PCI, but are inverted
before the interrupt controller.

Including a reference here to the spec that mentions this inversion
would help a lot.

s/when create mapping/when creating mappings/

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
