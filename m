Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4450C56F7B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZRUR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 13:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFZRUR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 13:20:17 -0400
Received: from localhost (c-67-164-175-55.hsd1.co.comcast.net [67.164.175.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A2D208E3;
        Wed, 26 Jun 2019 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561569615;
        bh=VZwWqCv8XEw1n6uNNQqcy4uX5gio41h/Ap0e47nK4x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1CjXM12FbV0gZg50b7BUoAEH7fF234u6Zp93P1EK1qGSI6Twekr+IxRLOjdB5fAcz
         twsl53cZ2XQesCgIfWOJQ7vgObjaKK9cMeZXQBoljpgublZN33WgS9UOMmmChMIrml
         w4V/eVYdFABjWiTrDwOakQRNHmAsBZACgUQ+mbfo=
Date:   Wed, 26 Jun 2019 12:20:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: Improve _OSC control request granularity
Message-ID: <20190626172013.GA183605@google.com>
References: <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
 <20190213213242.21920-1-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213213242.21920-1-asierra@xes-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Aaron,

On Wed, Feb 13, 2019 at 03:32:42PM -0600, Aaron Sierra wrote:
> This patch reorganizes negotiate_os_control() to be less ASPM-centric in
> order to:
> 
>     1. allow other features (notably AER) to work without enabling ASPM
>     2. better isolate feature-specific tests for readability/maintenance
> 
> Each feature (ASPM, PCIe hotplug, SHPC hotplug, and AER) now has its own
> inline function for setting its _OSC control requests.

Can you split this into three patches?

IIUC, 1) above is a functional change that allows us to use AER even
if CONFIG_PCIEASPM is unset or we booted with "pcie_aspm=off".  This
seems like a reasonable thing to do, although I would want to dig out
the commit that added the requirement in the first place to see if
there's some reason for requiring Linux support for all those
features.  It would also be nice to have the commit log for this patch
mention the use case.

And 2) seems like basically a cleanup with no functional change?  It
does make the code in negotiate_os_control() a little prettier, but I
have to admit that while reviewing this, I found the additional
indirection made it harder to untangle the dependencies, so I'm not
100% convinced yet.  _OSC is just such an ugly interface to begin with
that I'm not sure how it can really be improved.

> Part of making this function more generic, required eliminating a test
> for overall success/failure that previously caused two different types
> of messages to be printed. Now, printed messages are streamlined to
> always show requested _OSC control versus what was granted.
> 
> Previous output (success):
> 
>   acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
> 
> Previous output (failure):
> 
>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>   acpi PNP0A08:00: _OSC: platform willing to grant []
> 
> New output:
> 
>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>   acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]

I like this output change.  Can it be split into a separate third
patch that only changes the output, without changing the actual
behavior?

> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
> 
> v3:
>   * Dropped patch moving the pcie_ports_disabled check
>   * Removed underscore prefix from new inline functions
>   * Defined ASPM_OSC_CONTROL_BITS and removed __osc_have_aspm_control()
>   * Refactored OSC control bit-setting functions to return the bits they want
>     to set, instead of an ignored error code, and converted most conditionals
>     from inverted logic, (!x || !y), to positive logic, (x && y)
>   * Renamed OSC control bit-setting functions from __osc_set_X_control()
>     to osc_get_X_control_bits()
> 
> v2:
>   * Rebased from the mainline kernel (4.19-rc7) to Bjorn Helgaas's
>     pci/aspm branch [1]
>   * Factored moving the pcie_ports_disabled check to the top of
>     negotiate_os_control into its own patch
>   * Simplified new __osc_check_support function and renamed it to
>     __osc_have_support
>   * No longer messes with _OSC general availability test and related
>     error message (i.e. _OSC failed ... disabling ASPM)
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> 
>  drivers/acpi/pci_root.c | 111 ++++++++++++++++++++++++++++++----------
>  1 file changed, 83 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 707aafc7c2aa..ac74bd42399d 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -53,9 +53,13 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  }
>  
>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> -				| OSC_PCI_ASPM_SUPPORT \
> -				| OSC_PCI_CLOCK_PM_SUPPORT \
>  				| OSC_PCI_MSI_SUPPORT)
> +#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
> +				| OSC_PCI_ASPM_SUPPORT \
> +				| OSC_PCI_CLOCK_PM_SUPPORT)
> +#define OSC_CONTROL_BITS_ASPM (OSC_PCI_EXPRESS_CAPABILITY_CONTROL \
> +				| OSC_PCI_EXPRESS_LTR_CONTROL \
> +				| OSC_PCI_EXPRESS_PME_CONTROL)
>  
>  static const struct acpi_device_id root_device_ids[] = {
>  	{"PNP0A03", 0},
> @@ -421,6 +425,67 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> +static inline bool osc_have_support(u32 support, u32 required)
> +{
> +	return ((support & required) == required);
> +}
> +
> +static inline u32 osc_get_aspm_control_bits(struct acpi_pci_root *root,
> +					    u32 support)
> +{
> +	u32 control = 0;
> +
> +	if (IS_ENABLED(CONFIG_PCIEASPM) &&
> +	    osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT)) {
> +		control = OSC_CONTROL_BITS_ASPM;
> +	}
> +
> +	return control;

If we end up keeping these wrappers, they would be a little simpler
as:

    static inline u32 osc_get_aspm_control_bits(...)
    {
      if (IS_ENABLED(CONFIG_PCIEASPM) &&
	  osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
	    return OSC_CONTROL_BITS_ASPM;
      return 0;
    }

But really, it seems a little convoluted to have to pass in "support",
since it doesn't depend on any _OSC results or even on which host
bridge this is.  It's just a function of config options and sometimes
global kernel boot parameters.  So I'm not sure whether the overall
readability is better.

> +}
> +
> +static inline u32 osc_get_pciehp_control_bits(struct acpi_pci_root *root,
> +					      u32 support)
> +{
> +	u32 control = 0;
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
> +	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
> +		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +			  OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +	}
> +
> +	return control;
> +}
> +
> +static inline u32 osc_get_shpchp_control_bits(struct acpi_pci_root *root,
> +					      u32 support)
> +{
> +	u32 control = 0;
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC) &&
> +	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
> +		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +			  OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +	}
> +
> +	return control;
> +}
> +
> +static inline u32 osc_get_aer_control_bits(struct acpi_pci_root *root,
> +					   u32 support)
> +{
> +	if (!pci_aer_available() ||
> +	    !osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
> +		return 0;
> +
> +	if (aer_acpi_firmware_first()) {
> +		dev_info(&root->device->dev, "PCIe AER handled by firmware\n");
> +		return 0;
> +	}
> +
> +	return OSC_PCI_EXPRESS_CAPABILITY_CONTROL | OSC_PCI_EXPRESS_AER_CONTROL;
> +}
> +
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  				 bool is_pcie)
>  {
> @@ -479,31 +544,24 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		return;
>  	}
>  
> -	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -		| OSC_PCI_EXPRESS_PME_CONTROL;
> -
> -	if (IS_ENABLED(CONFIG_PCIEASPM))
> -		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> -
> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> -
> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> -		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +	control = osc_get_aspm_control_bits(root, support);
> +	if (!control)
> +		*no_aspm = 1;
>  
> -	if (pci_aer_available()) {
> -		if (aer_acpi_firmware_first())
> -			dev_info(&device->dev,
> -				 "PCIe AER handled by firmware\n");
> -		else
> -			control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +	control |= osc_get_pciehp_control_bits(root, support);
> +	control |= osc_get_shpchp_control_bits(root, support);
> +	control |= osc_get_aer_control_bits(root, support);
> +	if (!control) {
> +		dev_info(&device->dev, "_OSC: not requesting OS control\n");
> +		return;
>  	}
>  
>  	requested = control;
> -	status = acpi_pci_osc_control_set(handle, &control,
> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> -	if (ACPI_SUCCESS(status)) {
> -		decode_osc_control(root, "OS now controls", control);
> +	acpi_pci_osc_control_set(handle, &control, 0);
> +	decode_osc_control(root, "OS requested", requested);
> +	decode_osc_control(root, "platform granted", control);
> +
> +	if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {
>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>  			/*
>  			 * We have ASPM control, but the FADT indicates that
> @@ -513,11 +571,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
>  			*no_aspm = 1;
>  		}
> -	} else {
> -		decode_osc_control(root, "OS requested", requested);
> -		decode_osc_control(root, "platform willing to grant", control);
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> -			acpi_format_exception(status));
> +	} else if (!*no_aspm) {
> +		dev_info(&device->dev, "_OSC failed; disabling ASPM\n");
>  
>  		/*
>  		 * We want to disable ASPM here, but aspm_disabled
> -- 
> 2.17.1
> 
