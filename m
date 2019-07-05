Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6460BCE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfGETfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 15:35:32 -0400
Received: from xes-mad.com ([162.248.234.2]:40891 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfGETfc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 15:35:32 -0400
Received: from zimbra.xes-mad.com (zimbra.xes-mad.com [10.52.0.127])
        by mail.xes-mad.com (Postfix) with ESMTP id 4C779203B0;
        Fri,  5 Jul 2019 14:35:28 -0500 (CDT)
Date:   Fri, 5 Jul 2019 14:35:27 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Message-ID: <1300636862.240137.1562355327012.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20190702201318.GC128603@google.com>
References: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com> <20190701204515.23374-1-asierra@xes-inc.com> <20190701204515.23374-3-asierra@xes-inc.com> <20190702201318.GC128603@google.com>
Subject: Re: [PATCH v4 2/3] PCI/ACPI: Allow _OSC request without ASPM
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.0.127]
X-Mailer: Zimbra 8.7.5_GA_1764 (ZimbraWebClient - GC72 (Linux)/8.7.5_GA_1764)
Thread-Topic: PCI/ACPI: Allow _OSC request without ASPM support
Thread-Index: PtSi79gbAJ5r5mxHlhwuk0wlIzXVfA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> Sent: Tuesday, July 2, 2019 3:13:18 PM

> On Mon, Jul 01, 2019 at 03:45:14PM -0500, Aaron Sierra wrote:
>> Some use cases favor resiliency over efficiency. In my company's case,
>> the power savings offered by Active State Power Management (ASPM) are
>> entirely secondary to ensuring robust operation. For that same reason we
>> want to stay aware of events reportable via Advanced Error Reporting
>> (AER). We found, on x86 platforms, that AER has an erroneous implicit
>> dependency on ASPM within negotiate_os_control().
>> 
>> This patch updates negotiate_os_control() to be less ASPM-centric in
>> order to allow other features (notably AER) to work without enabling
>> ASPM (either at compile time or at run time).
>> 
>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> ---
>>  drivers/acpi/pci_root.c | 49 +++++++++++++++++++++++++++--------------
>>  1 file changed, 33 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 21aa56f9ca54..9b8a44391ea0 100644
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

Bjorn,

Thanks for another review.

> This change so we can use AER even if the OS has no ASPM support makes
> sense to me.
> 
> But Rafael added ACPI_PCIE_REQ_SUPPORT with 415e12b23792 ("PCI/ACPI:
> Request _OSC control once for each root bridge (v3)") [1], apparently
> related to a bug [2].  I assume there was some reason for requiring
> all those things together, so I'd really like his comments.
> 
> [1] https://git.kernel.org/linus/415e12b23792
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=20232

I would really appreciate Rafael's comments, too.

>> +#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
>> +				| OSC_PCI_ASPM_SUPPORT \
>> +				| OSC_PCI_CLOCK_PM_SUPPORT)
>> +#define OSC_CONTROL_BITS_ASPM (OSC_PCI_EXPRESS_CAPABILITY_CONTROL \
>> +				| OSC_PCI_EXPRESS_LTR_CONTROL \
>> +				| OSC_PCI_EXPRESS_PME_CONTROL)
>>  
>>  static const struct acpi_device_id root_device_ids[] = {
>>  	{"PNP0A03", 0},
>> @@ -422,6 +426,11 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle,
>> u32 *mask, u32 req)
>>  }
>>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>>  
>> +static inline bool osc_have_support(u32 support, u32 required)
>> +{
>> +	return ((support & required) == required);
>> +}
> 
> This is used to test both "support" bitmasks and "control" bitmasks,
> so the name is a little confusing.  Maybe the function could have a
> more generic name, and the "osc" and "support/control" hints could
> come from the arguments passed to it?  It actually does nothing
> _OSC-specific, so we probably don't even need a hint for that.

I agree that a more generic name for this bitmask test function would be better.
I'm leaning towards has_required_bits(u32 bits, u32 required) at the moment.
 
> Maybe it would be overkill, but this could be added with a separate
> preliminary patch so the "allow AER with ASPM" patch becomes even
> simpler.

I was hoping that including these changes together would help to highlight
where "AER without ASPM" had previously been broken. Otherwise, the full impact
of changing ACPI_PCIE_REQ_SUPPORT isn't as obvious.

>>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>  				 bool is_pcie)
>>  {
>> @@ -475,38 +484,47 @@ static void negotiate_os_control(struct acpi_pci_root
>> *root, int *no_aspm,
>>  		return;
>>  	}
>>  
>> -	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
>> +	/*
>> +	 * Require the least restrictive set needed to satisfy at least one
>> +	 * kernel feature.
>> +	 */
>> +	if (!osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
>>  		decode_osc_support(root, "not requesting OS control; OS requires",
>>  				   ACPI_PCIE_REQ_SUPPORT);
>>  		return;
>>  	}
> 
> It seems like the changes below could be a separate patch?  Or do they
> actually depend on the ACPI_PCIE_REQ_SUPPORT change?  Changing
> ACPI_PCIE_REQ_SUPPORT is fairly significant, so I'd like to isolate it
> as much as possible.

The utility of the changes below depends on ACPI_PCIE_REQ_SUPPORT being
modified before or at the same time as them. Otherwise, they would seem
more like change for the sake of change.

> I think it's fine to pull out the OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> dependency into each feature that requires it, but theoretically that
> would be cosmetic with no real functional change, so it could be in
> its own separate patch.
> 
>> -	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
>> -		| OSC_PCI_EXPRESS_PME_CONTROL;
>> +	control = 0;
>> +
>> +	if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
>> +		control |= OSC_CONTROL_BITS_ASPM;
> 
> I think this would actually be easier to read without the
> OSC_CONTROL_BITS_ASPM #define because then it would be directly
> parallel with the other cases below, e.g., as
> 
>  if (osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
>    control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>               OSC_PCI_EXPRESS_LTR_CONTROL |
>               OSC_PCI_EXPRESS_PME_CONTROL;

I would agree with you, except for the later test to make sure that ASPM
got the control bits that it needs:

   if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {

Would you prefer that I introduce an aspm_control variable to replace the
define? That should make its definition more visible and still be reusable:

  if (has_required_bits(support, ACPI_PCIE_ASPM_SUPPORT)) {
      aspm_control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
                     OSC_PCI_EXPRESS_LTR_CONTROL |
                     OSC_PCI_EXPRESS_PME_CONTROL;
      control |= aspm_control;
  }
  ...

  if (has_required_bits(control, aspm_control)) {

> Also, since OSC_CONTROL_BITS_ASPM includes both
> OSC_PCI_EXPRESS_LTR_CONTROL and OSC_PCI_EXPRESS_PME_CONTROL, this
> change seems to connect PME to ASPM, and I'm not sure why.  Those are
> two different features, and it seems like we should be able to request
> PME control even if the OS doesn't have ASPM support.
> 
> It seems like maybe the OSC_PCI_EXPRESS_PME_CONTROL part should depend
> on CONFIG_PCIE_PME, the same way OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
> depends on CONFIG_HOTPLUG_PCI_PCIE.  That would be a potential
> behavior change and should be its own separate patch.
> 
> Rafael is the PME expert, so maybe he has an opinion on this, too.

I agree that I should not have combined PME into ASPM required support.
Without encouragement from Rafael, I would prefer to not submit a new
test based on CONFIG_PCIE_PME change myself. I'll just refactor things
to preserve the original default control bits.

I hope that won't make my change to include
OSC_PCI_EXPRESS_CAPABILITY_CONTROL in each test look too redundant. In
the case of ASPM, it will be a functional change so that we can confirm
that the control it needs was granted. For the others, it is mostly
a documentation change.

Aaron

>> -	if (IS_ENABLED(CONFIG_PCIEASPM))
>> -		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
>> +	if (!control)
>> +		*no_aspm = 1;
>>  
>>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>> -		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>> +		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>> +			   OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>>  
>>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
>> -		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>> +		control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>> +			   OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>>  
>>  	if (pci_aer_available()) {
>>  		if (aer_acpi_firmware_first())
>>  			dev_info(&device->dev,
>>  				 "PCIe AER handled by firmware\n");
>>  		else
>> -			control |= OSC_PCI_EXPRESS_AER_CONTROL;
>> +			control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
>> +				   OSC_PCI_EXPRESS_AER_CONTROL;
>>  	}
>>  
>>  	requested = control;
>> -	status = acpi_pci_osc_control_set(handle, &control,
>> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
>> +	acpi_pci_osc_control_set(handle, &control, 0);
>>  	decode_osc_control(root, "OS requested", requested);
>>  	decode_osc_control(root, "platform granted", control);
>> -	if (ACPI_SUCCESS(status)) {
>> +
>> +	if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {
>>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>>  			/*
>>  			 * We have ASPM control, but the FADT indicates that
>> @@ -516,9 +534,8 @@ static void negotiate_os_control(struct acpi_pci_root *root,
>> int *no_aspm,
>>  			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS
>>  			configuration\n");
>>  			*no_aspm = 1;
>>  		}
>> -	} else {
>> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
>> -			acpi_format_exception(status));
>> +	} else if (!*no_aspm) {
>> +		dev_info(&device->dev, "_OSC failed; disabling ASPM\n");
>>  
>>  		/*
>>  		 * We want to disable ASPM here, but aspm_disabled
>> --
>> 2.17.1
