Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3D77D6C6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbjHOXs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 19:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbjHOXsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 19:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499D19A1;
        Tue, 15 Aug 2023 16:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B78260BBB;
        Tue, 15 Aug 2023 23:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F07C433C8;
        Tue, 15 Aug 2023 23:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692143285;
        bh=hvQa0+PA1x5P04FdvbsMe+rPAF6SEQvQ58h8KBdm64Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gXvSuq+vNebbVgfoDY8B5OgegkAsaVd5xG38AoweP023741iIj56Sy1RUt2jBTEDx
         0FqIf+NOW/c6vFv/FHB8orf8+aDLzNCqG+70MCnyfyk4TwfJAvOUdbhCAqF/H4PyZq
         hv/E0dVUJxtq94deuh3b1APGnOXzr0S3JJANOavk+VCGOlugDR0+iHI2gLu9tr4jkq
         rgydn5X9+Sw17CFc8hJgFQQpeim8t0dInxZ5B0tG1Log8kKU9Uppj+Oxt88kbxomaT
         8uJhBsbonbKoknuVWwpgjgjcV6LIqA0IRbRZ7WF+CckDXCj6x5opGqguEpxOtSLTUv
         2a+7Hjf2AZfKA==
Date:   Tue, 15 Aug 2023 18:48:03 -0500
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
Subject: Re: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI
 target state fallback policy
Message-ID: <20230815234803.GA272829@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809185453.40916-10-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 01:54:53PM -0500, Mario Limonciello wrote:
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

Why would we not use the same policy as Windows 11?

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
> logic (if marked for wakeup use deepest state that PME works)
> * If not marked for wakeup choose D3hot

Apparently this is based on constraints from the _DSM method of a
PNP0D80 device (and Intel x86 and AMD have different _DSM methods)?

Isn't this something that needs to be part of the ACPI spec?  I don't
see PNP0D80 mentioned there.  Obviously we also have ARM64 and other
arches now using ACPI, so I'm not really comfortable with these bits
scrounged from Microsoft and Intel white papers.  That seems hard to
maintain in the future, and this is hard enough now.

> Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v10->v11:
>  * Fix kernel kernel build robot errors and various sparse warnings
>    related to new handling of pci_power_t.
>  * Use the new helpers introduced in previous patches
> ---
>  drivers/pci/pci-acpi.c | 12 ++++++++++++
>  drivers/pci/pci.c      | 17 ++++++++++++++++-
>  drivers/pci/pci.h      |  5 +++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b5b65cdfa3b8b..9f418ec87b6a5 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1081,6 +1081,18 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	return false;
>  }
>  
> +/**
> + * acpi_pci_device_constraint - return any PCI power state constraints
> + * @dev: PCI device to check
> + *
> + * Returns: Any valid constraint specified by platform for a device.
> + * Otherwise PCI_POWER_ERROR.
> + */
> +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
> +{
> +	return map_acpi_to_pci(acpi_get_lps0_constraint(&dev->dev));
> +}
> +
>  static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>  {
>  	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 693f4ca90452b..567443726974b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> +static inline pci_power_t platform_get_constraint(struct pci_dev *dev)
> +{
> +	if (pci_use_mid_pm())
> +		return PCI_POWER_ERROR;
> +
> +	return acpi_pci_device_constraint(dev);
> +}
> +
>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> @@ -2685,11 +2693,13 @@ static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
>   */
>  static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  {
> +	pci_power_t state;
> +
>  	if (platform_pci_power_manageable(dev)) {
>  		/*
>  		 * Call the platform to find the target state for the device.
>  		 */
> -		pci_power_t state = platform_pci_choose_state(dev);
> +		state = platform_pci_choose_state(dev);
>  
>  		switch (state) {
>  		case PCI_POWER_ERROR:
> @@ -2715,6 +2725,11 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  	else if (!dev->pm_cap)
>  		return PCI_D0;
>  
> +	/* if platform indicates preferred state device constraint, use it */
> +	state = platform_get_constraint(dev);
> +	if (state != PCI_POWER_ERROR)
> +		return state;
> +
>  	if (wakeup && dev->pme_support)
>  		return pci_get_wake_pme_state(dev);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c3974340576..410fca4b88837 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
>  int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
>  bool acpi_pci_power_manageable(struct pci_dev *dev);
>  bool acpi_pci_bridge_d3(struct pci_dev *dev);
> +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev);
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
>  pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
>  void acpi_pci_refresh_power_state(struct pci_dev *dev);
> @@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  {
>  	return false;
>  }
> +static inline pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
> +{
> +	return PCI_POWER_ERROR;
> +}
>  static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
>  	return -ENODEV;
> -- 
> 2.34.1
> 
