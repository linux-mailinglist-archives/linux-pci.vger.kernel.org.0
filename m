Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553DB4A7798
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243619AbiBBSNX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 13:13:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42326 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiBBSNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 13:13:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B156189A;
        Wed,  2 Feb 2022 18:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE88C004E1;
        Wed,  2 Feb 2022 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643825600;
        bh=W7XCI06/Ylc9GMz/SPCh+EaDCTdMMnEF4ru0ssHogmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p6gbM9RaaXjLYLTMPY3DdcD/bfNZZIb75BBjPYCWjrHK53ulGt8CVyO8CH5SFGTEH
         ir34jm8h1mMyZcsLlgOA2QAZ5Jt9Pit8pGPRTFBvzQQ76ilr7z4piokRLR/ndg+7aS
         ghwA2qIKTM7eCkHwhkIKau+DYxWktipAg2WohVy1BBQXvzXcwXJbl2SLEnzwg3UYc/
         s0OEsRBOXsHF1RBU1pA78jqUezUWQ2c8OPBNEnjttUncMLpjQYikS+/kwbCWNK/8g6
         vk1iFxiBpmRrWa/PL5yeqRJ2DW6vcDGEhI9/wM56MROHxp88Tfo0/TUgdR+r5KBoqP
         uEgpYdyRGTYLQ==
Date:   Wed, 2 Feb 2022 12:13:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Brent Spillner <spillner@acm.org>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Improve log message when IRQ cannot be
 identified
Message-ID: <20220202181318.GA26584@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfiBfdAf9uHYTf4T@jupiter.dyndns.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 12:40:29AM +0000, Brent Spillner wrote:
> The existing code always suggests trying the pci=biosirq kernel parameter, but
> this option is only recognized when CONFIG_PCI_BIOS is set, which in turn
> depends on CONFIG_X86_32, so it is never appropriate on x86_64.
> kernel-parameters.txt confirms that pci=biosirq is intended to be supported
> only on X86-32.
> 
> The new version tries to be more helpful by recommending changes to ACPI
> settings if appropriate, and only mentioning pci=biosirq (and the manual
> pirq= option) for kernels that support it. Additionally, it encourages
> the user to file bug reports so faulty firmware can be identified and
> potentially handled via known quirks in a future kernel release.
> 
> ACPI is relevant to these warnings because it will significantly change
> the path taken through the PCI discovery (and later interrupt routing)
> code. Booting with acpi=noirq should be highly unusual and likely
> indicates an attempt to work around faulty motherboard firmware, so I
> added a new log message in pci_acpi_init() for this case, with yet
> another recommendation to file a bug report.
> 
> Signed-off-by: Brent Spillner <spillner@acm.org>

IIUC pirq_enable_irq() is only used for non-ACPI, non-DT, non-Xen,
non-Intel MID systems, so this is a real legacy path.

I don't think it's really worth cluttering an error case in a path
that should be rarely used in the first place.

Are you seeing a problem where you're getting the wrong error message
today?  Can we just fix that problem instead so no kernel parameter is
needed in the first place?

> ---
> Changes in v2:
>  - Tried to make the code more legible by reducing use of #ifdef (only
>    used where required to guard reference to acpi_noirq)
>  - The tradeoff is there's now an idiosyncratic use of do {...} while (0),
>    but that lets me early-out from the acpi_noirq case without more #ifdefs
>    or duplicated if statements.
>  - Included a warning for acpi_noirq in pci_acpi_init() per maintainer suggestion
>  - Encourage user to file bug reports in all warning messages
> 
>  arch/x86/pci/acpi.c |  4 +++-
>  arch/x86/pci/irq.c  | 22 +++++++++++++++++++---
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 052f1d78a562..12f894d345a9 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -401,8 +401,10 @@ int __init pci_acpi_init(void)
>  {
>  	struct pci_dev *dev = NULL;
>  
> -	if (acpi_noirq)
> +	if (acpi_noirq) {
> +		printk(KERN_WARNING "PCI: ACPI IRQ routing disabled; please submit a bug report if this was required to work around firmware defects\n");
>  		return -ENODEV;
> +	}
>  
>  	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
>  	acpi_irq_penalty_init();
> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> index 97b63e35e152..393b036e773b 100644
> --- a/arch/x86/pci/irq.c
> +++ b/arch/x86/pci/irq.c
> @@ -1519,10 +1519,26 @@ static int pirq_enable_irq(struct pci_dev *dev)
>  			} else
>  				msg = "; probably buggy MP table";
>  #endif
> -		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
> +		} else if (pci_probe & PCI_BIOS_IRQ_SCAN) {
>  			msg = "";
> -		else
> -			msg = "; please try using pci=biosirq";
> +		} else {
> +			do {	/* just one iteration; allows break to minimize code duplication */
> +#ifdef CONFIG_ACPI
> +				if (acpi_noirq) {
> +				    msg = "; consider removing acpi=noirq, and file a bug report if that does not help";
> +					break;		/* out of remainder of one-iteration do {} loop */
> +				}
> +#endif
> +				if (IS_ENABLED(CONFIG_PCI_BIOS))
> +					/* pci=biosirq and pirq= are valid only on x86_32, and should never be necessary */
> +					msg = "; try using pci=biosirq or manual pirq=, and file a bug report for this device";
> +				else if (!IS_ENABLED(CONFIG_ACPI))
> +					/* ACPI will change code path through PCI subsystem, and is worth trying */
> +					msg = "; try enabling ACPI if feasible, and file a bug report for this device";
> +				else
> +					msg = "; please file a bug report for failure to discover device IRQ via ACPI";
> +			} while (0);
> +		}
>  
>  		/*
>  		 * With IDE legacy devices the IRQ lookup failure is not
> -- 
> 2.35.1
> 
