Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F292A549E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbgKCVNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 16:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389146AbgKCVNB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 16:13:01 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DED20757;
        Tue,  3 Nov 2020 21:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604437980;
        bh=upWyisctmfa/CJCkL30cnZl2vLFgPOoeXTJUMhzlavk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kNCephVWVCkQmD9RzbwVyxWWKg+uF9uDwjhdbm0HicbvDP5FhonRK5SubbCO6kL5h
         RLhqC68YTMrZ5Xa+J2YN5F9ayHBjAcSU/9fzXCPlxI8bSPMAKYi/XAkhkiBTrYqfzb
         5X5NoOwGKFsqCb8vRvJTssaOwXPEtizp6n7KzcaI=
Date:   Tue, 3 Nov 2020 15:12:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Remove trailing whitespace
Message-ID: <20201103211259.GA265488@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102133641.474413-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 02:36:41PM +0100, Maximilian Luz wrote:
> Remove trailing whitespace and fix some whitespace inconsitencies while
> at it.

I'm OK with this as long as somebody fixes the
s/inconsitencies/inconsistencies/
above.  I assume you've scanned all of drivers/acpi/ for similar
issues so they can all be fixed at once.

This is up to Rafael, of course.

> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/acpi/pci_irq.c           |  2 +-
>  drivers/acpi/pci_link.c          | 12 ++++++------
>  drivers/acpi/power.c             |  4 ++--
>  drivers/acpi/processor_perflib.c |  4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index dea8a60e18a4..14ee631cb7cf 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -175,7 +175,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
>  	 * configure the IRQ assigned to this slot|dev|pin.  The 'source_index'
>  	 * indicates which resource descriptor in the resource template (of
>  	 * the link device) this interrupt is allocated from.
> -	 * 
> +	 *
>  	 * NOTE: Don't query the Link Device for IRQ information at this time
>  	 *       because Link Device enumeration may not have occurred yet
>  	 *       (e.g. exists somewhere 'below' this _PRT entry in the ACPI
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 606da5d77ad3..fb4c5632a232 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -6,8 +6,8 @@
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>   *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
>   *
> - * TBD: 
> - *      1. Support more than one IRQ resource entry per link device (index).
> + * TBD:
> + *	1. Support more than one IRQ resource entry per link device (index).
>   *	2. Implement start/stop mechanism and use ACPI Bus Driver facilities
>   *	   for IRQ management (e.g. start()->_SRS).
>   */
> @@ -249,8 +249,8 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
>  		}
>  	}
>  
> -	/* 
> -	 * Query and parse _CRS to get the current IRQ assignment. 
> +	/*
> +	 * Query and parse _CRS to get the current IRQ assignment.
>  	 */
>  
>  	status = acpi_walk_resources(link->device->handle, METHOD_NAME__CRS,
> @@ -396,7 +396,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>  /*
>   * "acpi_irq_balance" (default in APIC mode) enables ACPI to use PIC Interrupt
>   * Link Devices to move the PIRQs around to minimize sharing.
> - * 
> + *
>   * "acpi_irq_nobalance" (default in PIC mode) tells ACPI not to move any PIC IRQs
>   * that the BIOS has already set to active.  This is necessary because
>   * ACPI has no automatic means of knowing what ISA IRQs are used.  Note that
> @@ -414,7 +414,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>   *
>   * Note that PCI IRQ routers have a list of possible IRQs,
>   * which may not include the IRQs this table says are available.
> - * 
> + *
>   * Since this heuristic can't tell the difference between a link
>   * that no device will attach to, vs. a link which may be shared
>   * by multiple active devices -- it is not optimal.
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 837b875d075e..9c4c3196cb07 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -13,7 +13,7 @@
>   * 1. via "Device Specific (D-State) Control"
>   * 2. via "Power Resource Control".
>   * The code below deals with ACPI Power Resources control.
> - * 
> + *
>   * An ACPI "power resource object" represents a software controllable power
>   * plane, clock plane, or other resource depended on by a device.
>   *
> @@ -690,7 +690,7 @@ int acpi_device_sleep_wake(struct acpi_device *dev,
>  
>  /*
>   * Prepare a wakeup device, two steps (Ref ACPI 2.0:P229):
> - * 1. Power on the power resources required for the wakeup device 
> + * 1. Power on the power resources required for the wakeup device
>   * 2. Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
>   *    State Wake) for the device, if present
>   */
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 5909e8fa4013..f00e66de6c53 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -627,7 +627,7 @@ int acpi_processor_preregister_performance(
>  		goto err_ret;
>  
>  	/*
> -	 * Now that we have _PSD data from all CPUs, lets setup P-state 
> +	 * Now that we have _PSD data from all CPUs, lets setup P-state
>  	 * domain info.
>  	 */
>  	for_each_possible_cpu(i) {
> @@ -693,7 +693,7 @@ int acpi_processor_preregister_performance(
>  			if (match_pdomain->domain != pdomain->domain)
>  				continue;
>  
> -			match_pr->performance->shared_type = 
> +			match_pr->performance->shared_type =
>  					pr->performance->shared_type;
>  			cpumask_copy(match_pr->performance->shared_cpu_map,
>  				     pr->performance->shared_cpu_map);
> -- 
> 2.29.2
> 
