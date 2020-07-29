Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69953232563
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 21:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2T05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 15:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgG2T05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 15:26:57 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F2112068F;
        Wed, 29 Jul 2020 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596050816;
        bh=AirH2OQ4nadnD65L6nuTQ8eqcT0Ym4SbFJyuHgPYE8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qxjjvPxvQ6q2UiQHaRxvQ1lbfC0lEf+ARwpOzrQCJPYdv1y+M24QbnCR7GnoKimS+
         b4W4s6jSPrzq1BCojYuCRoHurgJs8aMuQHwdsHOHAKPlvspCcsLeA2xBMsYN2OY1z9
         O5RSD2OtZ7N0iwOMn8TIYHZENAface3cH9yd4Td8=
Date:   Wed, 29 Jul 2020 14:26:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] PCI: Remove pci_lost_interrupt
Message-ID: <20200729192654.GA1956120@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e328d059-3068-6a40-28df-f81f616d15a0@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 11:03:41PM +0200, Heiner Kallweit wrote:
> 388c8c16abaf ("PCI: add routines for debugging and handling lost
> interrupts") added pci_lost_interrupt() that apparently never has
> had a single user. So remove it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/misc for v5.9, thanks!

> ---
>  drivers/pci/irq.c   | 50 ---------------------------------------------
>  include/linux/pci.h |  7 -------
>  2 files changed, 57 deletions(-)
> 
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index a1de501a2..12ecd0aaa 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -6,61 +6,11 @@
>   * Copyright (C) 2017 Christoph Hellwig.
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/pci.h>
>  
> -static void pci_note_irq_problem(struct pci_dev *pdev, const char *reason)
> -{
> -	struct pci_dev *parent = to_pci_dev(pdev->dev.parent);
> -
> -	pci_err(pdev, "Potentially misrouted IRQ (Bridge %s %04x:%04x)\n",
> -		dev_name(&parent->dev), parent->vendor, parent->device);
> -	pci_err(pdev, "%s\n", reason);
> -	pci_err(pdev, "Please report to linux-kernel@vger.kernel.org\n");
> -	WARN_ON(1);
> -}
> -
> -/**
> - * pci_lost_interrupt - reports a lost PCI interrupt
> - * @pdev:	device whose interrupt is lost
> - *
> - * The primary function of this routine is to report a lost interrupt
> - * in a standard way which users can recognise (instead of blaming the
> - * driver).
> - *
> - * Returns:
> - * a suggestion for fixing it (although the driver is not required to
> - * act on this).
> - */
> -enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *pdev)
> -{
> -	if (pdev->msi_enabled || pdev->msix_enabled) {
> -		enum pci_lost_interrupt_reason ret;
> -
> -		if (pdev->msix_enabled) {
> -			pci_note_irq_problem(pdev, "MSIX routing failure");
> -			ret = PCI_LOST_IRQ_DISABLE_MSIX;
> -		} else {
> -			pci_note_irq_problem(pdev, "MSI routing failure");
> -			ret = PCI_LOST_IRQ_DISABLE_MSI;
> -		}
> -		return ret;
> -	}
> -#ifdef CONFIG_ACPI
> -	if (!(acpi_disabled || acpi_noirq)) {
> -		pci_note_irq_problem(pdev, "Potential ACPI misrouting please reboot with acpi=noirq");
> -		/* currently no way to fix acpi on the fly */
> -		return PCI_LOST_IRQ_DISABLE_ACPI;
> -	}
> -#endif
> -	pci_note_irq_problem(pdev, "unknown cause (not MSI or ACPI)");
> -	return PCI_LOST_IRQ_NO_INFORMATION;
> -}
> -EXPORT_SYMBOL(pci_lost_interrupt);
> -
>  /**
>   * pci_request_irq - allocate an interrupt line for a PCI device
>   * @dev:	PCI device to operate on
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2a2d00e9d..814d652f2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1053,13 +1053,6 @@ void pci_sort_breadthfirst(void);
>  
>  /* Generic PCI functions exported to card drivers */
>  
> -enum pci_lost_interrupt_reason {
> -	PCI_LOST_IRQ_NO_INFORMATION = 0,
> -	PCI_LOST_IRQ_DISABLE_MSI,
> -	PCI_LOST_IRQ_DISABLE_MSIX,
> -	PCI_LOST_IRQ_DISABLE_ACPI,
> -};
> -enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
>  int pci_find_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
>  int pci_find_ext_capability(struct pci_dev *dev, int cap);
> -- 
> 2.27.0
> 
