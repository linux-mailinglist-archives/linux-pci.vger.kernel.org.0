Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBFC2B2912
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKMXSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 18:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKMXSP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 18:18:15 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E7922256;
        Fri, 13 Nov 2020 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605309495;
        bh=nZwE0MA4uC9+7jsRv6Imtj6VcPIHbfUydG8RQp2+zeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pf0C9XkwNMegtWnRSee6E3Y9VufVTgevlkWK5rh7ldzV6bmff/ulnmQQsH1IRqVGO
         pIZ9vlGZ1MlrgZ7FkM0zVK1DKnZH6R1MMLR9OASWSI+v7RiBP6WIEauVTAoWMCzU9S
         cnwbwfUE1EEZbUWSS6ukYw9r8IkzIGsJrlAe9ke4=
Date:   Sat, 14 Nov 2020 00:19:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
Message-ID: <X68Ub0rSmUlrRXkm@kroah.com>
References: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
 <20201113213842.GA1135242@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113213842.GA1135242@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 13, 2020 at 03:38:42PM -0600, Bjorn Helgaas wrote:
> [+cc Christoph, Dan, Greg (for "one value per file" question below)]
> 
> On Tue, Nov 10, 2020 at 09:37:35AM -0600, Stuart Hayes wrote:
> > This patch will expose the PCIe SSD Status LED Management interface in
> > sysfs for devices that have the relevant _DSM method, per the "_DSM
> > additions for PCIe SSD Status LED Management" ECN to the PCI Firmware
> > Specification revision 3.2.
> > 
> > The interface is exposed in two sysfs files, ssdleds_supported_states (RO)
> > and ssdleds_current_state (RW).
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > ---
> > 
> > v2: made PCI_SSDLEDS dependent on PCI and ACPI
> >     remove unused variable
> >     warn if call to sysfs_create_group fails
> >     include header file with function prototypes
> >     change logical OR to bitwise
> > 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  14 ++
> >  drivers/pci/Kconfig                     |   7 +
> >  drivers/pci/Makefile                    |   1 +
> >  drivers/pci/pci-ssdleds.c               | 194 ++++++++++++++++++++++++
> >  drivers/pci/pci-sysfs.c                 |   1 +
> >  drivers/pci/pci.h                       |  11 ++
> >  6 files changed, 228 insertions(+)
> >  create mode 100644 drivers/pci/pci-ssdleds.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 77ad9ec3c801..18ca73b764ac 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -366,3 +366,17 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
> >  Description:	If ASPM is supported for an endpoint, these files can be
> >  		used to disable or enable the individual power management
> >  		states. Write y/1/on to enable, n/0/off to disable.
> > +
> > +What:		/sys/bus/pci/devices/.../ssdleds_supported_states
> > +Date:		October 2020
> > +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> > +Description:	If the device supports the ACPI _DSM method to control the
> > +		PCIe SSD LED states, ssdleds_supported_states (read only)
> > +		will show the LED states that are supported by the _DSM.
> > +
> > +What:		/sys/bus/pci/devices/.../ssdleds_current_state
> > +Date:		October 2020
> > +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> > +Description:	If the device supports the ACPI _DSM method to control the
> > +		PCIe SSD LED states, ssdleds_current_state will show or set
> > +		the current LED states that are active.
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 0c473d75e625..48049866145f 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -182,6 +182,13 @@ config PCI_LABEL
> >  	def_bool y if (DMI || ACPI)
> >  	select NLS
> >  
> > +config PCI_SSDLEDS
> > +	def_bool y if (ACPI && PCI)

That only should be set if the machine can not boot without it.

For a blinky light, that's not the case.

And why isn't this code using the existing LED subsystem?  Don't create
random new driver-specific sysfs files that do things the existing class
drivers do please.


> > +static int ssdleds_dsm_get(struct device *dev, char *buf, u64 dsm_func)
> > +{
> > +	acpi_handle handle;
> > +	union acpi_object *out_obj;
> > +	struct pci_ssdleds_dsm_output *dsm_output;
> > +
> > +	handle = ACPI_HANDLE(dev);
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_ssdleds_dsm_guid, 0x1,
> > +				      dsm_func, NULL, ACPI_TYPE_BUFFER);
> > +	if (!out_obj)
> > +		return -EIO;
> > +
> > +	if (out_obj->buffer.length < 8) {
> > +		ACPI_FREE(out_obj);
> > +		return -EIO;
> > +	}
> > +
> > +	dsm_output = (struct pci_ssdleds_dsm_output *)out_obj->buffer.pointer;
> > +	if (dsm_output->status != 0) {
> > +		ACPI_FREE(out_obj);
> > +		return -EIO;
> > +	}
> > +
> > +	scnprintf(buf, PAGE_SIZE, "%#x\n", dsm_output->state);
> 
> Similarly, I would consider returning dsm_output->state and moving the
> scnprintf() so the sysfs-specific stuff is in the caller.
> 
> It looks like you just expose the hex value that encodes things like:
> 
>   OK
>   Locate
>   Fail
>   Rebuild
>   ...
> 
> The hex value is sort of a pain to interpret, especially since the PCI
> specs are not public.  Maybe consider decoding it?  If you did decode
> it, that might be a way to reduce this to a single file instead of
> having both "supported_states" and "current_state" -- the single file
> could list all the supported states, with the current states
> highlighted somehow.
> 
> Not sure if that would run afoul of the sysfs "one value per file"
> rule.  CC'd Greg in case he wants to chime in.

That's a valid way of displaying options for a sysfs file that can
be specific unique values.


> > +static struct device_attribute ssdleds_attr_current = {
> > +	.attr = {.name = "ssdleds_current_state", .mode = 0644},
> > +	.show = ssdleds_current_show,
> > +	.store = ssdleds_current_store,
> > +};
> 
> Can these use DEVICE_ATTR_RW() and friends?

They should, never open-code something like this.

> 
> > +static struct device_attribute ssdleds_attr_supported = {
> > +	.attr = {.name = "ssdleds_supported_states", .mode = 0444},
> > +	.show = ssdleds_supported_show,
> > +};

DEVICE_ATTR_RO();

> > +
> > +static struct attribute *ssdleds_attributes[] = {
> > +	&ssdleds_attr_current.attr,
> > +	&ssdleds_attr_supported.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group ssdleds_attr_group = {
> > +	.attrs = ssdleds_attributes,
> > +	.is_visible = ssdleds_attr_visible,
> > +};

ATTRIBUTE_GROUPS()?

> > +void pci_create_ssdleds_files(struct pci_dev *pdev)
> > +{
> > +	if (sysfs_create_group(&pdev->dev.kobj, &ssdleds_attr_group))
> > +		pci_warn(pdev, "Unable to create ssdleds attributes\n");

You just raced userspace and lost.  Just add this to the default groups
for the device and the core will handle it all for you automatically.

Hint, when you find yourself calling a sysfs_*() call from driver code,
that's a huge flag that you are doing something wrong.

> > +void pci_remove_ssdleds_files(struct pci_dev *pdev)
> > +{
> > +	sysfs_remove_group(&pdev->dev.kobj, &ssdleds_attr_group);
> > +}
> 
> I'm not a real sysfs expert, but I *think* that if you follow the
> pattern in pci_dev_attr_groups[] in pci-sysfs.c, you won't need these
> create/remove functions.

Yes, that is true.

thanks,

greg k-h
