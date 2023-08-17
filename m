Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74A977FE7E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353725AbjHQT0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbjHQTZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 15:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1491FF3;
        Thu, 17 Aug 2023 12:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB7B63BEA;
        Thu, 17 Aug 2023 19:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B104C433C7;
        Thu, 17 Aug 2023 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692300339;
        bh=bbUm/yQsQGcpPFjhnNc3alRihcKjttz87Q4PRDBCiH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nnbdkdvXY9lEMdvBJvZ3GVOkjbJaGsJrpCLwfs0biU4T8ArHWI3IKDAWMa76HpDFR
         nDOCMjJUBgHGyqC26Y2NpW4OPl0uaxevM35d7QGx8aKp/OqPiSrMr/XEy8C0QkRcdE
         MV3c3BTAIAZaJT3KO26OzPx8w8Ul4dbQ7j19AxGlQk+NVB/X2L+NnJ3Bk8SrbWSIXj
         ZQZP7A/sKXmaMX9ckEX4GNuSZyP0yZGRgk9M4p2pEJooI2LmY8pJ8ozjtZSY1ZTCAq
         dTWU18LxNxMEBarqotsYyl29ByVBpQIDIWCIXwlV545HHGeAo1UHZyRTNL0VtIf+RQ
         UuMg4LyBC73Sw==
Date:   Thu, 17 Aug 2023 14:25:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for
 PCI devices
Message-ID: <20230817192537.GA322922@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204143.66281-10-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 03:41:43PM -0500, Mario Limonciello wrote:
> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
> storing a value to the `bridge_d3` variable in the `struct pci_dev`
> structure.
> ...

> +static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
> +{
> +	pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
> +
> +	if (pdev->current_state == target)
> +		return;
> +
> +	/* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
> +	if (target == ACPI_STATE_D3_HOT &&

ACPI_STATE_D3_HOT is not a valid pci_power_t value.

> +	    (pdev->current_state == PCI_D3hot ||
> +	     pdev->current_state == PCI_D3cold))
> +		return;
> +
> +	if (pm_debug_messages_on)
> +		acpi_handle_info(entry->handle,
> +				 "LPI: PCI device in %s, not in %s\n",
> +				 acpi_power_state_string(pdev->current_state),
> +				 acpi_power_state_string(target));
> +
> +	/* don't try with things that PCI core hasn't touched */
> +	if (pdev->current_state == PCI_UNKNOWN) {
> +		entry->handle = NULL;
> +		return;
> +	}
> +
> +	pci_set_power_state(pdev, target);

It doesn't seem logical for a "check_constraints()" function that
takes no parameters and returns nothing to actively set the PCI power
state.

lpi_check_constraints() returns nothing, and from the fact that it was
previously only called when "pm_debug_messages_on", I infer that it
should have no side effects.

IMHO "lpi_check_constraints" is not a great name because "check"
doesn't suggest anything specific about what it does.
"dump_constraints()" -- fine.  "log_unmet_constraints()" -- fine
(seems like the original intention of 726fb6b4f2a8 ("ACPI / PM: Check
low power idle constraints for debug only"), which added it.

> +}
> +
>  static void lpi_check_constraints(void)
>  {
>  	struct lpi_constraints *entry;
>  
>  	for_each_lpi_constraint(entry) {
>  		struct acpi_device *adev = acpi_fetch_acpi_dev(entry->handle);
> +		struct device *dev;
>  
>  		if (!adev)
>  			continue;
>  
> +		/* Check and adjust PCI devices explicitly */
> +		dev = acpi_get_first_physical_node(adev);
> +		if (dev && dev_is_pci(dev)) {
> +			lpi_check_pci_dev(entry, to_pci_dev(dev));
> +			continue;
> +		}
> +		if (!entry->enabled)
> +			continue;
>  		acpi_handle_debug(entry->handle,
>  			"LPI: required min power state:%s current power state:%s\n",
>  			acpi_power_state_string(entry->min_dstate),
>  			acpi_power_state_string(adev->power.state));
>  
> -		if (!adev->flags.power_manageable) {
> -			acpi_handle_info(entry->handle, "LPI: Device not power manageable\n");
> -			entry->handle = NULL;
> -			continue;
> -		}
> -
> -		if (adev->power.state < entry->min_dstate)
> +		if (pm_debug_messages_on &&
> +		    adev->flags.power_manageable &&
> +		    adev->power.state < entry->min_dstate)
>  			acpi_handle_info(entry->handle,
>  				"LPI: Constraint not met; min power state:%s current power state:%s\n",
>  				acpi_power_state_string(entry->min_dstate),
> @@ -512,8 +546,7 @@ int acpi_s2idle_prepare_late(void)
>  	if (!lps0_device_handle || sleep_no_lps0)
>  		return 0;
>  
> -	if (pm_debug_messages_on)
> -		lpi_check_constraints();
> +	lpi_check_constraints();
>  
>  	/* Screen off */
>  	if (lps0_dsm_func_mask > 0)
> -- 
> 2.34.1
> 
