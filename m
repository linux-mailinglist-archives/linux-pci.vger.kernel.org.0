Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C758F76E74F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjHCLt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjHCLt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 07:49:27 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E7A2737;
        Thu,  3 Aug 2023 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691063366; x=1722599366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEo+8ervmGfBamk8ouhbLZLmAQ0j8klZRD1dua5HLuY=;
  b=Ta+D3Ga511kVvc0dGVVUPbeQUO6//phiZhlLMEPx8xG+rikiKp+P63F/
   FpwFZAgzpWic1wpZssbBNpV2HQSnBqmEmfa5/U6nLRPmRHS7JhrVHzyPx
   uDfF7SOjXukPk60ZWSTA8W6KD67iMTZ05xvHh1YGXvp0dbNkgTRfoo9ex
   HZ5Co7Ot/Jmg7eU4XRt5ehuc7O6wYmysW7kTsJc9qzgx8Q8rkboSi0Jhl
   8c7YyfFZJj/6dHxDFHNIZlmeAAiNPb09o+WU3aFge4z+mQhXzgvMP4K25
   eYBG07m2LThWFE7juLKIizrLo4BrVutlR9i1gq5dlg3RrpzCZ5i7+hwCk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373481153"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373481153"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729529863"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="729529863"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2023 04:49:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRWpV-00AsQj-2S;
        Thu, 03 Aug 2023 14:49:21 +0300
Date:   Thu, 3 Aug 2023 14:49:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Message-ID: <ZMuUQb4AcZpMB2Gq@smile.fi.intel.com>
References: <20230802201013.910-1-mario.limonciello@amd.com>
 <20230802201013.910-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201013.910-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 03:10:13PM -0500, Mario Limonciello wrote:
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
> to what should happen.  In this situation Windows 11 seems to leave PCIe
> root ports in D0 while Linux puts them into D3 due to the above mentioned
> commit.
> 
> In Windows systems that support Modern Standby specify hardware
> pre-conditions for the SoC to achieve the lowest power state by device
> constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
> They can be marked as disabled or enabled and when enabled can specify
> the minimum power state required for an ACPI device.
> 
> Instead of using a time based heuristic to decide if a port should go
> into D3 use device constraints to decide.
> * If the constraint is not present or disabled then choose D0.
> * If the constraint is enabled, then enable D3 if the constraint is set
>   to 3 or greater.

...

> +/*
> + * acpi_get_lps0_constraint - get any LPS0 constraint for an acpi device
> + * @handle: ACPI handle of the device
> + *
> + * If a constraint has been specified in the _DSM method for the device,
> + * return it.  Otherwise, return -ENODEV.
> + */
> +int acpi_get_lps0_constraint(struct device *dev)
> +{

> +	acpi_handle handle = ACPI_HANDLE(dev);

(see below)

> +	int i;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	for (i = 0; i < lpi_constraints_table_size; ++i) {

> +		if (lpi_constraints_table[i].handle != handle)

Maybe

	device_match_acpi_handle()

?

> +			continue;
> +		return lpi_constraints_table[i].min_dstate;
> +	}
> +
> +	return -ENODEV;
> +}

...

> +/*

Is it deliberately non-kernel-doc while mimicking it?

> + * acpi_pci_device_constraint_d3 - determine if device constraints require D3
> + * @dev: PCI device to check
> + *
> + * Returns true if the PEP constraints for the device is enabled and
> + * requires D3.
> + */
> +bool acpi_pci_device_constraint_d3(struct pci_dev *dev)
> +{

> +	int constraint = acpi_get_lps0_constraint(&dev->dev);
> +
> +	if (constraint < 0) {

I slightly prefer

	int constraint;

	constraint = acpi_get_lps0_constraint(&dev->dev);
	if (constraint < 0) {

> +		pci_dbg(dev, "ACPI device constraint not present\n");
> +		return false;
> +	}
> +
> +	return constraint >= 3;
> +}

-- 
With Best Regards,
Andy Shevchenko


