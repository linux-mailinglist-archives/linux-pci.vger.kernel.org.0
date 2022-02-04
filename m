Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62C44AA413
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 00:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiBDXOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 18:14:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55932 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376312AbiBDXOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 18:14:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DA1B83967;
        Fri,  4 Feb 2022 23:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6035C004E1;
        Fri,  4 Feb 2022 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016487;
        bh=MYi9IiU+yOAAJGTml3/Ykmnyb/j5FaPAwu6TFeCrUZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ktZ8UwMt+zeZvooJjXKnCO2gqgxOWADcs8ome7KbMkZu4Mybjenx7sWEHRUj9Ag0h
         7hzbyt11+9DkMT/xI/jtxBszrD68q/kvf2/gl7j2ibb9n1pn87xGLvDxI6n+QiLWuD
         FJOGGOvj6jZaubCYmgoWrBFJJ9RoP/VM72fvN+8BqWrebs6+JQql9vQpc10Xo4BoiI
         a/qvT8H0RuKjRv+gHfXtpWigxr1kPJZUi21FYNvP5/PCUff3/JMhPx+hjqPWdkIoTZ
         eeb0oLDXwjeD0iK18DQNll9rFUDaD0woS+PEZy3qeVWED/QzykAvMRoHgqJTd6aEUV
         7LiXFGha71Gkg==
Date:   Fri, 4 Feb 2022 17:14:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: ACPI: Replace acpi_bus_get_device()
Message-ID: <20220204231444.GA228064@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11930209.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 12:40:13AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied with Mika's Reviewed-by to pci/acpi for v5.18, thanks!

> ---
> 
> -> v2: Fix typo (superfluous paren) in acpiphp_ibm.c.
> 
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |    7 ++++---
>  drivers/pci/hotplug/acpiphp_ibm.c  |    5 +++--
>  drivers/pci/pci-acpi.c             |    6 +++---
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
> @@ -226,9 +226,9 @@ static void acpiphp_post_dock_fixup(stru
>  static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
>  				       void **rv)
>  {
> +	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
>  	struct acpiphp_bridge *bridge = data;
>  	struct acpiphp_context *context;
> -	struct acpi_device *adev;
>  	struct acpiphp_slot *slot;
>  	struct acpiphp_func *newfunc;
>  	acpi_status status = AE_OK;
> @@ -238,6 +238,9 @@ static acpi_status acpiphp_add_context(a
>  	struct pci_dev *pdev = bridge->pci_dev;
>  	u32 val;
>  
> +	if (!adev)
> +		return AE_OK;
> +
>  	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
>  	if (ACPI_FAILURE(status)) {
>  		if (status != AE_NOT_FOUND)
> @@ -245,8 +248,6 @@ static acpi_status acpiphp_add_context(a
>  				"can't evaluate _ADR (%#x)\n", status);
>  		return AE_OK;
>  	}
> -	if (acpi_bus_get_device(handle, &adev))
> -		return AE_OK;
>  
>  	device = (adr >> 16) & 0xffff;
>  	function = adr & 0xffff;
> Index: linux-pm/drivers/pci/hotplug/acpiphp_ibm.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/hotplug/acpiphp_ibm.c
> +++ linux-pm/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -433,8 +433,9 @@ static int __init ibm_acpiphp_init(void)
>  		goto init_return;
>  	}
>  	pr_debug("%s: found IBM aPCI device\n", __func__);
> -	if (acpi_bus_get_device(ibm_acpi_handle, &device)) {
> -		pr_err("%s: acpi_bus_get_device failed\n", __func__);
> +	device = acpi_fetch_acpi_dev(ibm_acpi_handle);
> +	if (!device) {
> +		pr_err("%s: acpi_fetch_acpi_dev failed\n", __func__);
>  		retval = -ENODEV;
>  		goto init_return;
>  	}
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -89,9 +89,9 @@ int acpi_get_rc_resources(struct device
>  		return -ENODEV;
>  	}
>  
> -	ret = acpi_bus_get_device(handle, &adev);
> -	if (ret)
> -		return ret;
> +	adev = acpi_fetch_acpi_dev(handle);
> +	if (!adev)
> +		return -ENODEV;
>  
>  	ret = acpi_get_rc_addr(adev, res);
>  	if (ret) {
> 
> 
> 
