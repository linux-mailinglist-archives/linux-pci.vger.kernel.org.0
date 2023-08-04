Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE876F8F4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 06:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjHDEab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 00:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHDEaa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 00:30:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C6335BE;
        Thu,  3 Aug 2023 21:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691123429; x=1722659429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7SU+OnhENlKD0/sf+9S44cv0vNFtLHvqcGpWrAJLLlM=;
  b=YX52LJlEcEFVvEMKj51u64xFMxabYMABhzQ20OsMTRx42XdIqbPOs9EU
   iddJN2FoUElT+ntd30nRAODs0zIZVLFiaA571rEidsaAsCOJo2TZ1thzl
   cx+OpxbobD/mRr0LM3EwznzkYjYy+IYo0z8o8qSYI3OGApBAMcZT6z89q
   ApdthwVnKLSAbtoGtFYkfpq3q9aM3uX0bU0kYec621SwRAXWJKguf/fp7
   9sBf9kH52KIAQjM/KkSaQBlTe4CX8fPHeP3Yvy1/N2yW2wU/mDNMaMi9t
   eHJ1STCry+LvlbKo19J7b/dGs6v+tbZAMUb4mznmanq9Ib2CAgOEAhsIs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="401017267"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="401017267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="853565264"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="853565264"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2023 21:30:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRmSH-009c7u-0F;
        Fri, 04 Aug 2023 07:30:25 +0300
Date:   Fri, 4 Aug 2023 07:30:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v9 3/3] PCI/ACPI: Use device constraints to decide PCI
 target state fallback policy
Message-ID: <ZMx+4CxT/b8ShiWR@smile.fi.intel.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
 <20230804010229.3664-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804010229.3664-4-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 08:02:29PM -0500, Mario Limonciello wrote:
> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
> storing a value to the `bridge_d3` variable in the `struct pci_dev`
> structure.
> 
> pci_power_manageable() uses this variable to indicate a PCIe port can
> enter D3.
> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> decide whether to try to put a device into its target state for a sleep
> cycle via pci_prepare_to_sleep().
> 
> For devices that support D3, the target state is selected by this policy:
> 1. If platform_pci_power_manageable():
>    Use platform_pci_choose_state()
> 2. If the device is armed for wakeup:
>    Select the deepest D-state that supports a PME.
> 3. Else:
>    Use D3hot.
> 
> Devices are considered power manageable by the platform when they have
> one or more objects described in the table in section 7.3 of the ACPI 6.5
> specification.
> 
> When devices are not considered power manageable; specs are ambiguous as
> to what should happen.  In this situation Windows 11 leaves PCIe
> ports in D0 while Linux puts them into D3 due to the above mentioned
> commit.
> 
> In Windows systems that support Modern Standby specify hardware
> pre-conditions for the SoC to achieve the lowest power state by device
> constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
> They can be marked as disabled or enabled and when enabled can specify
> the minimum power state required for an ACPI device.
> 
> When it is ambiguous what should happen, adjust the logic for
> pci_target_state() to check whether a device constraint is present
> and enabled.
> * If power manageable by ACPI use this to get to select target state
> * If a device constraint is present but disabled then choose D0
> * If a device constraint is present and enabled then use it
> * If a device constraint is not present, then continue to existing
>   logic (if marked for wakeup use deepest state that PME works)
> * If not marked for wakeup choose D3hot

...

> +/**
> + * acpi_get_lps0_constraint - get any LPS0 constraint for a device
> + * @dev: device to get constraint for
> + *
> + * If a constraint has been specified in the _DSM method for the device,
> + * and the constraint is enabled return it.  If the constraint is disabled,
> + * return 0. Otherwise, return -ENODEV.
> + */

I believe you get a kernel-doc warning. Always test kernel doc with

	scripts/kernel-doc -v -none -Wall ...your file...

...

> +/**
> + * acpi_pci_device_constraint - determine if the platform has a contraint for the device
> + * @dev: PCI device to check
> + * @result (out): the constraint specified by the platform
> + *
> + * If the platform has specified a constraint for a device, this function will
> + * return 0 and set @result to the constraint.
> + * Otherwise, it will return an error code.
> + */

Ditto.

...

> +int acpi_pci_device_constraint(struct pci_dev *dev, int *result)
> +{
> +	int constraint;
> +
> +	constraint = acpi_get_lps0_constraint(&dev->dev);

> +	pci_dbg(dev, "ACPI device constraint: %d\n", constraint);

Does it make sense before the below check? Why can we be interested in the
_exact_ negative values? (Note that non-printing is already a sign that either
we don't call this or have negative constraint.)

> +	if (constraint < 0)
> +		return constraint;
> +	*result = constraint;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


