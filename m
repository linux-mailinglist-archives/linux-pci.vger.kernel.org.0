Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B335DA2B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGCBDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfGCBDG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:03:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6331721871;
        Tue,  2 Jul 2019 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562098399;
        bh=oiyxtfK7M35SdgF9TLOGYB8qTNTecCfmWOOqN0GIClQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3vrIcZpBDnA/vNnTdKLssc+IIlJbrCPInKqwmH8RnXWAVefCaG5MlE+uz1EQdavp
         kCeI8YNk7EoGai4ONb99/39zhRBFNnHYMwHrmSjIonr15UvpP4iYojqffz0Hxahz36
         /pboLPuorrf/kondW+kWgwjIauL0wZW+m3aAKkqM=
Date:   Tue, 2 Jul 2019 15:13:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 2/3] PCI/ACPI: Allow _OSC request without ASPM support
Message-ID: <20190702201318.GC128603@google.com>
References: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com>
 <20190701204515.23374-1-asierra@xes-inc.com>
 <20190701204515.23374-3-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701204515.23374-3-asierra@xes-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 03:45:14PM -0500, Aaron Sierra wrote:
> Some use cases favor resiliency over efficiency. In my company's case,
> the power savings offered by Active State Power Management (ASPM) are
> entirely secondary to ensuring robust operation. For that same reason we
> want to stay aware of events reportable via Advanced Error Reporting
> (AER). We found, on x86 platforms, that AER has an erroneous implicit
> dependency on ASPM within negotiate_os_control().
> 
> This patch updates negotiate_os_control() to be less ASPM-centric in
> order to allow other features (notably AER) to work without enabling
> ASPM (either at compile time or at run time).
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/acpi/pci_root.c | 49 +++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 21aa56f9ca54..9b8a44391ea0 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -53,9 +53,13 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  }
>  
>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> -				| OSC_PCI_ASPM_SUPPORT \
> -				| OSC_PCI_CLOCK_PM_SUPPORT \
>  				| OSC_PCI_MSI_SUPPORT)

This change so we can use AER even if the OS has no ASPM support makes
sense to me.

But Rafael added ACPI_PCIE_REQ_SUPPORT with 415e12b23792 ("PCI/ACPI:
Request _OSC control once for each root bridge (v3)") [1], apparently
related to a bug [2].  I assume there was some reason for requiring
all those things together, so I'd really like his comments.

[1] https://git.kernel.org/linus/415e12b23792
[2] https://bugzilla.kernel.org/show_bug.cgi?id=20232

> +#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
> +				| OSC_PCI_ASPM_SUPPORT \
> +				| OSC_PCI_CLOCK_PM_SUPPORT)
> +#define OSC_CONTROL_BITS_ASPM (OSC_PCI_EXPRESS_CAPABILITY_CONTROL \
> +				| OSC_PCI_EXPRESS_LTR_CONTROL \
> +				| OSC_PCI_EXPRESS_PME_CONTROL)
>  
>  static const struct acpi_device_id root_device_ids[] = {
>  	{"PNP0A03", 0},
> @@ -422,6 +426,11 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> +static inline bool osc_have_support(u32 support, u32 required)
> +{
> +	return ((support & required) == required);
> +}

This is used to test both "support" bitmasks and "control" bitmasks,
so the name is a little confusing.  Maybe the function could have a
more generic name, and the "osc" and "support/control" hints could
come from the arguments passed to it?  It actually does nothing
_OSC-specific, so we probably don't even need a hint for that.

Maybe it would be overkill, but this could be added with a separate
preliminary patch so the "allow AER with ASPM" patch becomes even
simpler.

>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  				 bool is_pcie)
>  {
> @@ -475,38 +484,47 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		return;
>  	}
>  
> -	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> +	/*
> +	 * Require the least restrictive set needed to satisfy at least one
> +	 * kernel feature.
> +	 */
> +	if (!osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
>  		decode_osc_support(root, "not requesting OS control; OS requires",
>  				   ACPI_PCIE_REQ_SUPPORT);
>  		return;
>  	}

It seems like the changes below could be a separate patch?  Or do they
actually depend on the ACPI_PCIE_REQ_SUPPORT change?  Changing
ACPI_PCIE_REQ_SUPPORT is fairly significant, so I'd like to isolate it
as much as possible.

I think it's fine to pull out the OSC_PCI_EXPRESS_CAPABILITY_CONTROL
dependency into each feature that requires it, but theoretically that
would be cosmetic with no real functional change, so it could be in
its own separate patch.

> -	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -		| OSC_PCI_EXPRESS_PME_CONTROL;
> +	control = 0;
> +
> +	if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
> +		control |= OSC_CONTROL_BITS_ASPM;

I think this would actually be easier to read without the
OSC_CONTROL_BITS_ASPM #define because then it would be directly
parallel with the other cases below, e.g., as

  if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
    control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
               OSC_PCI_EXPRESS_LTR_CONTROL |
               OSC_PCI_EXPRESS_PME_CONTROL;

Also, since OSC_CONTROL_BITS_ASPM includes both
OSC_PCI_EXPRESS_LTR_CONTROL and OSC_PCI_EXPRESS_PME_CONTROL, this
change seems to connect PME to ASPM, and I'm not sure why.  Those are
two different features, and it seems like we should be able to request
PME control even if the OS doesn't have ASPM support.

It seems like maybe the OSC_PCI_EXPRESS_PME_CONTROL part should depend
on CONFIG_PCIE_PME, the same way OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
depends on CONFIG_HOTPLUG_PCI_PCIE.  That would be a potential
behavior change and should be its own separate patch.

Rafael is the PME expert, so maybe he has an opinion on this, too.

> -	if (IS_ENABLED(CONFIG_PCIEASPM))
> -		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> +	if (!control)
> +		*no_aspm = 1;
>  
>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +			   OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>  
>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> -		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +			   OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>  
>  	if (pci_aer_available()) {
>  		if (aer_acpi_firmware_first())
>  			dev_info(&device->dev,
>  				 "PCIe AER handled by firmware\n");
>  		else
> -			control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +			control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +				   OSC_PCI_EXPRESS_AER_CONTROL;
>  	}
>  
>  	requested = control;
> -	status = acpi_pci_osc_control_set(handle, &control,
> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> +	acpi_pci_osc_control_set(handle, &control, 0);
>  	decode_osc_control(root, "OS requested", requested);
>  	decode_osc_control(root, "platform granted", control);
> -	if (ACPI_SUCCESS(status)) {
> +
> +	if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {
>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>  			/*
>  			 * We have ASPM control, but the FADT indicates that
> @@ -516,9 +534,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
>  			*no_aspm = 1;
>  		}
> -	} else {
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
