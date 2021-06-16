Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC673AA5BC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhFPU60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 16:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233698AbhFPU60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 16:58:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 665B5613BD;
        Wed, 16 Jun 2021 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623876979;
        bh=o2+SNoyiiMwUqF0/aveyTkIMUSrA4DUtSr3Ox3Vyg/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ahS+J8SpK5EmayCyRJ+YCftv5CYNc7zve3whYyGRhxQIVZH0kpGL3uSKKO1NlTTUO
         P6dXpZl5Vfn2i7LpzZRTpULwKGm388ylFrWmlio2ikozo1G3sTZoF/svk5A04rQg17
         yDIc4nXpd+Xr6BdvqQfWGnxRXByiKxQUUVdzuuy+fGktu6/HJkMGy6Ig5SRkvXV7N9
         1ewriWLGJBt+zjaBKYOcca+dT/O4ykjXqzckjfs/ndVBcQAnN0w/JWTFurmgPG1zeL
         fOq3JU/5IDweXTAtBaUNdY7v9gjz43YIJJ3esRCUYvksHg9mtCTpp1q0WeEW4WfwKB
         RP/I9h5S0xD3g==
Date:   Wed, 16 Jun 2021 15:56:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] acpi: pci_irq: Fixed a control flow style issue
Message-ID: <20210616205618.GA3002486@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612195730.1069667-1-majortomtosourcecontrol@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 12, 2021 at 01:57:31PM -0600, Clayton Casciato wrote:
> Fixed coding style issue.

I don't object to this, and in fact, I prefer the style you propose.
I don't know whether Rafael thinks it's worth the churn since it
doesn't actually fix anything.

But do take note of the commit log conventions.  Run

  $ git log --oneline drivers/acpi/pci_irq.c

and match the style.  Probably something like this:

  ACPI: PCI: Simplify acpi_reroute_boot_interrupt() coding style

And note that the commit log should use imperative mood and be a
little more specific about what the commit does.  [1] has several
great hints.

More below.

> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> ---
>  drivers/acpi/pci_irq.c | 45 +++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 08e15774fb9f..6eea3cf7b158 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -260,30 +260,29 @@ static int bridge_has_boot_interrupt_variant(struct pci_bus *bus)
>  static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
>  				       struct acpi_prt_entry *entry)
>  {
> -	if (noioapicquirk || noioapicreroute) {
> +	if (noioapicquirk || noioapicreroute)
>  		return 0;
> -	} else {
> -		switch (bridge_has_boot_interrupt_variant(dev->bus)) {
> -		case 0:
> -			/* no rerouting necessary */
> -			return 0;
> -		case INTEL_IRQ_REROUTE_VARIANT:
> -			/*
> -			 * Remap according to INTx routing table in 6700PXH
> -			 * specs, intel order number 302628-002, section
> -			 * 2.15.2. Other chipsets (80332, ...) have the same
> -			 * mapping and are handled here as well.
> -			 */
> -			dev_info(&dev->dev, "PCI IRQ %d -> rerouted to legacy "
> -				 "IRQ %d\n", entry->index,
> -				 (entry->index % 4) + 16);
> -			entry->index = (entry->index % 4) + 16;
> -			return 1;
> -		default:
> -			dev_warn(&dev->dev, "Cannot reroute IRQ %d to legacy "
> -				 "IRQ: unknown mapping\n", entry->index);
> -			return -1;
> -		}
> +
> +	switch (bridge_has_boot_interrupt_variant(dev->bus)) {
> +	case 0:
> +		/* no rerouting necessary */
> +		return 0;
> +	case INTEL_IRQ_REROUTE_VARIANT:
> +		/*
> +		 * Remap according to INTx routing table in 6700PXH
> +		 * specs, intel order number 302628-002, section
> +		 * 2.15.2. Other chipsets (80332, ...) have the same
> +		 * mapping and are handled here as well.
> +		 */
> +		dev_info(&dev->dev, "PCI IRQ %d -> rerouted to legacy "
> +			 "IRQ %d\n", entry->index,
> +			 (entry->index % 4) + 16);
> +		entry->index = (entry->index % 4) + 16;
> +		return 1;
> +	default:
> +		dev_warn(&dev->dev, "Cannot reroute IRQ %d to legacy "
> +			 "IRQ: unknown mapping\n", entry->index);
> +		return -1;

Looking at this a little closer, this was added by e1d3a90846b4 ("pci,
acpi: reroute PCI interrupt to legacy boot interrupt equivalent") [2].

It looks like it might be a little over-engineered.  It added
MAX_IRQ_REROUTE_VARIANTS, which is an indication that
irq_reroute_variant is a 2-bit bitfield.  But in the last 13 years
we've never needed more than the single INTEL_IRQ_REROUTE_VARIANT bit.

So I would consider reworking it like this:

  unsigned int intel_irq_reroute:1;

  static void acpi_reroute_boot_interrupt(...)
  {
    if (noioapicquirk || noioapicreroute)
      return;

    if (bridge_has_intel_irq_reroute(dev->bus)) {
      dev_info(..., "PCI IRQ %d -> rerouted ...");
      entry->index = (entry->index % 4) + 16;
    }
  }

[1] https://chris.beams.io/posts/git-commit/
[2] https://git.kernel.org/linus/e1d3a90846b4

>  	}
>  }
>  #endif /* CONFIG_X86_IO_APIC */
> -- 
> 2.31.1
> 
