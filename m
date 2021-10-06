Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04242465D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhJFTAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 15:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhJFTAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 15:00:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F24260FF2;
        Wed,  6 Oct 2021 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633546724;
        bh=BrN9DZemZ8hoX2bxvUst8/KdBJIpbuojdOqUUhWaURM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sXZ7tDgTZ/NuDdHCT2qLEkuHF4wsk2U9FC5GsaLmvzZQg2BHcoz6mOaV6WBxgK6G/
         cZ0v/bbw5FTNx4WJnpS0NNCj1OPoZm50TfAuItN9bLd+gpj4Ng32bw2R6LDla0ZPL2
         zhNK/9J8VXVpPMN0X0f6RLqhg74EDJCTe3Rtupj9cUjqeZbypMo0BkR4KQlyUS4ylL
         f+h9nJbdQvfJMIRLSyw+4s8GL1B31ySUcCox2V5hEeH8Yq/V1jnIoX5bxQMfr3Lvey
         dkYZSR/JhtvRwDFKYcmDL6mdw8j4oE8vROo7YL+HXeg5lnwf7QTSGl/6bhH/8j2+Bk
         PcFAg/wcxFR1w==
Date:   Wed, 6 Oct 2021 13:58:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: ACPI: Check parent pointer in
 acpi_pci_find_companion()
Message-ID: <20211006185842.GA1172531@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5523582.DvuYhMxLoT@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 03:58:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If acpi_pci_find_companion() is called for a device whose parent
> pointer is NULL, it will crash when attempting to get the ACPI
> companion of the parent due to a NULL pointer dereference in
> the ACPI_COMPANION() macro.
> 
> This was not a problem before commit 375553a93201 ("PCI: Setup ACPI
> fwnode early and at the same time with OF") that made pci_setup_device()
> call pci_set_acpi_fwnode() and so it allowed devices with NULL parent
> pointers to be passed to acpi_pci_find_companion() which is the case
> in pci_iov_add_virtfn(), for instance.
> 
> Fix this issue by making acpi_pci_find_companion() check the device's
> parent pointer upfront and bail out if it is NULL.
> 
> While pci_iov_add_virtfn() can be changed to set the device's parent
> pointer before calling pci_setup_device() for it, checking pointers
> against NULL before dereferencing them is prudent anyway and looking
> for ACPI companions of virtual functions isn't really useful.
> 
> Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
> Link: https://lore.kernel.org/linux-acpi/8e4bbd5c59de31db71f718556654c0aa077df03d.camel@linux.ibm.com/
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-acpi.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1243,6 +1243,9 @@ static struct acpi_device *acpi_pci_find
>  	bool check_children;
>  	u64 addr;
>  
> +	if (!dev->parent)
> +		return NULL;
> +
>  	down_read(&pci_acpi_companion_lookup_sem);
>  
>  	adev = pci_acpi_find_companion_hook ?
> 
> 
> 
