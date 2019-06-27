Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA125799C
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF0CoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 22:44:04 -0400
Received: from xes-mad.com ([162.248.234.2]:50474 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfF0CoE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 22:44:04 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2019 22:44:03 EDT
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 8FF1D20218;
        Wed, 26 Jun 2019 21:38:37 -0500 (CDT)
Date:   Wed, 26 Jun 2019 21:38:36 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Message-ID: <99840928.514731.1561603116552.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190626172013.GA183605@google.com>
References: <1540483292-24049-1-git-send-email-asierra@xes-inc.com> <20190213213242.21920-1-asierra@xes-inc.com> <20190626172013.GA183605@google.com>
Subject: Re: [PATCH v3] PCI/ACPI: Improve _OSC control request granularity
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC72 (Linux)/8.7.5_GA_1764)
Thread-Topic: PCI/ACPI: Improve _OSC control request granularity
Thread-Index: q3PLdZo64XFwoxWkMS8/CU12SBgrQg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> Sent: Wednesday, June 26, 2019 12:20:13 PM

> Hi Aaron,
> 
> On Wed, Feb 13, 2019 at 03:32:42PM -0600, Aaron Sierra wrote:
>> This patch reorganizes negotiate_os_control() to be less ASPM-centric in
>> order to:
>> 
>>     1. allow other features (notably AER) to work without enabling ASPM
>>     2. better isolate feature-specific tests for readability/maintenance
>> 
>> Each feature (ASPM, PCIe hotplug, SHPC hotplug, and AER) now has its own
>> inline function for setting its _OSC control requests.

Hi Bjorn,

Thanks for the review.

> Can you split this into three patches?

Sure.

> IIUC, 1) above is a functional change that allows us to use AER even
> if CONFIG_PCIEASPM is unset or we booted with "pcie_aspm=off".  This
> seems like a reasonable thing to do, although I would want to dig out
> the commit that added the requirement in the first place to see if
> there's some reason for requiring Linux support for all those
> features.  It would also be nice to have the commit log for this patch
> mention the use case.

That is correct. I will elaborate on the use case in the new patch for
this change. It boils down to wanting to keep PCIe links fully active
for reliability while still being able to know about error conditions on
the links.

> And 2) seems like basically a cleanup with no functional change?  It
> does make the code in negotiate_os_control() a little prettier, but I
> have to admit that while reviewing this, I found the additional
> indirection made it harder to untangle the dependencies, so I'm not
> 100% convinced yet.  _OSC is just such an ugly interface to begin with
> that I'm not sure how it can really be improved.

That is a fair assessment. I point out a functional change following your
last comment below.

>> Part of making this function more generic, required eliminating a test
>> for overall success/failure that previously caused two different types
>> of messages to be printed. Now, printed messages are streamlined to
>> always show requested _OSC control versus what was granted.
>> 
>> Previous output (success):
>> 
>>   acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
>> 
>> Previous output (failure):
>> 
>>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>>   acpi PNP0A08:00: _OSC: platform willing to grant []
>> 
>> New output:
>> 
>>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>>   acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]
> 
> I like this output change.  Can it be split into a separate third
> patch that only changes the output, without changing the actual
> behavior?

OK
 
>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> ---
>> 
>> v3:
>>   * Dropped patch moving the pcie_ports_disabled check
>>   * Removed underscore prefix from new inline functions
>>   * Defined ASPM_OSC_CONTROL_BITS and removed __osc_have_aspm_control()
>>   * Refactored OSC control bit-setting functions to return the bits they want
>>     to set, instead of an ignored error code, and converted most conditionals
>>     from inverted logic, (!x || !y), to positive logic, (x && y)
>>   * Renamed OSC control bit-setting functions from __osc_set_X_control()
>>     to osc_get_X_control_bits()
>> 
>> v2:
>>   * Rebased from the mainline kernel (4.19-rc7) to Bjorn Helgaas's
>>     pci/aspm branch [1]
>>   * Factored moving the pcie_ports_disabled check to the top of
>>     negotiate_os_control into its own patch
>>   * Simplified new __osc_check_support function and renamed it to
>>     __osc_have_support
>>   * No longer messes with _OSC general availability test and related
>>     error message (i.e. _OSC failed ... disabling ASPM)
>> 
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>> 
>>  drivers/acpi/pci_root.c | 111 ++++++++++++++++++++++++++++++----------
>>  1 file changed, 83 insertions(+), 28 deletions(-)
>> 
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 707aafc7c2aa..ac74bd42399d 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -53,9 +53,13 @@ static int acpi_pci_root_scan_dependent(struct acpi_device
>> *adev)
>>  }
>>  
>>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
>> -				| OSC_PCI_ASPM_SUPPORT \
>> -				| OSC_PCI_CLOCK_PM_SUPPORT \
>>  				| OSC_PCI_MSI_SUPPORT)
>> +#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
>> +				| OSC_PCI_ASPM_SUPPORT \
>> +				| OSC_PCI_CLOCK_PM_SUPPORT)
>> +#define OSC_CONTROL_BITS_ASPM (OSC_PCI_EXPRESS_CAPABILITY_CONTROL \
>> +				| OSC_PCI_EXPRESS_LTR_CONTROL \
>> +				| OSC_PCI_EXPRESS_PME_CONTROL)
>>  
>>  static const struct acpi_device_id root_device_ids[] = {
>>  	{"PNP0A03", 0},
>> @@ -421,6 +425,67 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle,
>> u32 *mask, u32 req)
>>  }
>>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>>  
>> +static inline bool osc_have_support(u32 support, u32 required)
>> +{
>> +	return ((support & required) == required);
>> +}
>> +
>> +static inline u32 osc_get_aspm_control_bits(struct acpi_pci_root *root,
>> +					    u32 support)
>> +{
>> +	u32 control = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_PCIEASPM) &&
>> +	    osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT)) {
>> +		control = OSC_CONTROL_BITS_ASPM;
>> +	}
>> +
>> +	return control;
> 
> If we end up keeping these wrappers, they would be a little simpler
> as:
> 
>    static inline u32 osc_get_aspm_control_bits(...)
>    {
>      if (IS_ENABLED(CONFIG_PCIEASPM) &&
>	  osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
>	    return OSC_CONTROL_BITS_ASPM;
>      return 0;
>    }
> 
> But really, it seems a little convoluted to have to pass in "support",
> since it doesn't depend on any _OSC results or even on which host
> bridge this is.  It's just a function of config options and sometimes
> global kernel boot parameters.  So I'm not sure whether the overall
> readability is better.

Doesn't pci_ext_cfg_avail() at least depend on the host bridge? I see what
you mean with respect to support flags set based on pci_msi_enable() and
pcie_aspm_support_enabled().

I think you've highlighted that this one can be simplified even more due
to overlap with pcie_aspm_support_enabled():

    static inline u32 osc_get_aspm_control_bits(...)
    {
    	if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
		return OSC_CONTROL_BITS_ASPM;
    	return 0;
    }

To be clear, the key change that allows AER to work without ASPM is altering
the flags set in ACPI_PCIE_REQ_SUPPORT to the least restrictive set needed
to satisfy at least one kernel feature. Without that change, this test
causes us to bail out without requesting any _OSC control:

	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
		decode_osc_support(root, "not requesting OS control; OS requires",
				   ACPI_PCIE_REQ_SUPPORT);
		return;
	}

The inline functions attempt to better show the relationship between support
bits (support needed by kernel features enabled at runtime) and the control
bits (access requests to support those features) for a given feature.

In the case of ASPM, there is a change in behavior related to weakening the
blanket "support" test. The control bits it depends on can now be omitted
from the request set, so we don't request more than the kernel intends to
use.

-Aaron

>> +}
>> +
>> +static inline u32 osc_get_pciehp_control_bits(struct acpi_pci_root *root,
>> +					      u32 support)
>> +{
>> +	u32 control = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
>> +	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
>> +		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>> +			  OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>> +	}
>> +
>> +	return control;
>> +}
>> +
>> +static inline u32 osc_get_shpchp_control_bits(struct acpi_pci_root *root,
>> +					      u32 support)
>> +{
>> +	u32 control = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC) &&
>> +	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
>> +		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>> +			  OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>> +	}
>> +
>> +	return control;
>> +}
>> +
>> +static inline u32 osc_get_aer_control_bits(struct acpi_pci_root *root,
>> +					   u32 support)
>> +{
>> +	if (!pci_aer_available() ||
>> +	    !osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
>> +		return 0;
>> +
>> +	if (aer_acpi_firmware_first()) {
>> +		dev_info(&root->device->dev, "PCIe AER handled by firmware\n");
>> +		return 0;
>> +	}
>> +
>> +	return OSC_PCI_EXPRESS_CAPABILITY_CONTROL | OSC_PCI_EXPRESS_AER_CONTROL;
>> +}
>> +
>>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>  				 bool is_pcie)
>>  {
>> @@ -479,31 +544,24 @@ static void negotiate_os_control(struct acpi_pci_root
>> *root, int *no_aspm,
>>  		return;
>>  	}
>>  
>> -	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
>> -		| OSC_PCI_EXPRESS_PME_CONTROL;
>> -
>> -	if (IS_ENABLED(CONFIG_PCIEASPM))
>> -		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
>> -
>> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>> -		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>> -
>> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
>> -		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>> +	control = osc_get_aspm_control_bits(root, support);
>> +	if (!control)
>> +		*no_aspm = 1;
>>  
>> -	if (pci_aer_available()) {
>> -		if (aer_acpi_firmware_first())
>> -			dev_info(&device->dev,
>> -				 "PCIe AER handled by firmware\n");
>> -		else
>> -			control |= OSC_PCI_EXPRESS_AER_CONTROL;
>> +	control |= osc_get_pciehp_control_bits(root, support);
>> +	control |= osc_get_shpchp_control_bits(root, support);
>> +	control |= osc_get_aer_control_bits(root, support);
>> +	if (!control) {
>> +		dev_info(&device->dev, "_OSC: not requesting OS control\n");
>> +		return;
>>  	}
>>  
>>  	requested = control;
>> -	status = acpi_pci_osc_control_set(handle, &control,
>> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
>> -	if (ACPI_SUCCESS(status)) {
>> -		decode_osc_control(root, "OS now controls", control);
>> +	acpi_pci_osc_control_set(handle, &control, 0);
>> +	decode_osc_control(root, "OS requested", requested);
>> +	decode_osc_control(root, "platform granted", control);
>> +
>> +	if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {
>>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>>  			/*
>>  			 * We have ASPM control, but the FADT indicates that
>> @@ -513,11 +571,8 @@ static void negotiate_os_control(struct acpi_pci_root
>> *root, int *no_aspm,
>>  			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS
>>  			configuration\n");
>>  			*no_aspm = 1;
>>  		}
>> -	} else {
>> -		decode_osc_control(root, "OS requested", requested);
>> -		decode_osc_control(root, "platform willing to grant", control);
>> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
>> -			acpi_format_exception(status));
>> +	} else if (!*no_aspm) {
>> +		dev_info(&device->dev, "_OSC failed; disabling ASPM\n");
>>  
>>  		/*
>>  		 * We want to disable ASPM here, but aspm_disabled
>> --
>> 2.17.1
