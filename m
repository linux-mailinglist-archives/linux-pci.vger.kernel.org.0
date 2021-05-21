Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2B38CF64
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhEUUzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 16:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhEUUzc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 16:55:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD051613EC;
        Fri, 21 May 2021 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621630449;
        bh=yYEFG0AQGvtMt3tyjBHooRH7NU97at2YlWh/fncZQGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kSEt6vEAz8V7Hq388kz8gz63CfFxi1YjSWWT71LOE+R4cPp3+XDmjHO+zf76FY8X0
         /KnvJDcoDZ5uKg2ptqQ/FMRCmuVq1HW+4IdS39GUbsUTEpHQ2JWuuWOEvCAihGLo7W
         4rI2n3R9NDdS162we54MqjuwMLAaWFL04ZoLxexhDe2znbR3rE4Wnu7IZXhQ8NbYnD
         pDJNZTbBSVPUaksjMk+X18usepEHcWRs/I0EyVQ2e8xBU054o//0oY6QIuxDbbLgTA
         hppsidrLmoLopr5ft/+EzlgjV2vKEw6rbR0/JEJmsIJEhD+FZmx0Q8/4rYvPJtvHn3
         AcbCqpzTxehpg==
Date:   Fri, 21 May 2021 15:54:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v4 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <20210521205407.GA270280@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513232701.411773-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 04:27:00PM -0700, Rajat Jain wrote:
> Move the "removable" attribute from USB to core in order to allow it to be
> supported by other subsystem / buses. Individual buses that want to support
> this attribute can populate the removable property of the device while
> enumerating it with the 3 possible values -
>  - "unknown"
>  - "fixed"
>  - "removable"
> Leaving the field unchanged (i.e. "not supported") would mean that the
> attribute would not show up in sysfs for that device. The UAPI (location,
> symantics etc) for the attribute remains unchanged.

Looks nice!

Maybe the mini usage guide here could be a little more explicit, e.g.,

  Move the "removable" attribute from USB to the device core so it can
  be used by other subsystems / buses.

  By default, devices do not have a "removable" attribute in sysfs.

  If a subsystem or bus driver wants to support a "removable"
  attribute, it should call device_set_removable() before calling
  device_register() or device_add(), e.g.,

    device_set_removable(dev, DEVICE_REMOVABLE);
    device_register(dev);

  The possible values and the resulting sysfs attribute contents are:

    DEVICE_REMOVABLE_UNKNOWN  ->  "unknown"
    DEVICE_REMOVABLE          ->  "removable"
    DEVICE_FIXED              ->  "fixed"

  Convert the USB "removable" attribute to use this new device core
  functionality.  There should be no user-visible change in the
  location or semantics of attribute for USB devices.

> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Minor comment below, reviewed-by applies whether or not you do
anything.

> ---
> v4: - instead of devicce_type->supports_removable, add 1 more value in
>       device_removable_enum
>     - documentation update.
>     - Remove "Acked-by" and "Reviewed-by" tags from previous versions.
> v3: - Minor commit log / comments updated.
>     - use sysfs_emit()
>     - Rename local variable name (state -> loc)
>     - change supports_removable flag from bool to bitfield.
> v2: Add documentation
> 
>  Documentation/ABI/testing/sysfs-bus-usb       | 11 ------
>  .../ABI/testing/sysfs-devices-removable       | 17 +++++++++
>  drivers/base/core.c                           | 28 ++++++++++++++
>  drivers/usb/core/hub.c                        | 13 ++++---
>  drivers/usb/core/sysfs.c                      | 24 ------------
>  include/linux/device.h                        | 37 +++++++++++++++++++
>  include/linux/usb.h                           |  7 ----
>  7 files changed, 89 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-removable
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index bf2c1968525f..73eb23bc1f34 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -154,17 +154,6 @@ Description:
>  		files hold a string value (enable or disable) indicating whether
>  		or not USB3 hardware LPM U1 or U2 is enabled for the device.
>  
> -What:		/sys/bus/usb/devices/.../removable
> -Date:		February 2012
> -Contact:	Matthew Garrett <mjg@redhat.com>
> -Description:
> -		Some information about whether a given USB device is
> -		physically fixed to the platform can be inferred from a
> -		combination of hub descriptor bits and platform-specific data
> -		such as ACPI. This file will read either "removable" or
> -		"fixed" if the information is available, and "unknown"
> -		otherwise.
> -
>  What:		/sys/bus/usb/devices/.../ltm_capable
>  Date:		July 2012
>  Contact:	Sarah Sharp <sarah.a.sharp@linux.intel.com>
> diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> new file mode 100644
> index 000000000000..acf7766e800b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-removable
> @@ -0,0 +1,17 @@
> +What:		/sys/devices/.../removable
> +Date:		May 2021
> +Contact:	Rajat Jain <rajatxjain@gmail.com>
> +Description:
> +		Information about whether a given device can be removed from the
> +		platform by the	user. This is determined by its subsystem in a
> +		bus / platform-specific way. This attribute is only present for
> +		devices that can support determining such information:
> +
> +		"removable": device can be removed from the platform by the user
> +		"fixed":     device is fixed to the platform / cannot be removed
> +			     by the user.
> +		"unknown":   The information is unavailable / cannot be deduced.
> +
> +		Currently this is only supported by USB (which infers the
> +		information from a combination of hub descriptor bits and
> +		platform-specific data such as ACPI).
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4a8bf8cda52b..ae3d6a4a79fb 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2404,6 +2404,25 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(online);
>  
> +static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	const char *loc;
> +
> +	switch (dev->removable) {
> +	case DEVICE_REMOVABLE:
> +		loc = "removable";
> +		break;
> +	case DEVICE_FIXED:
> +		loc = "fixed";
> +		break;
> +	default:
> +		loc = "unknown";
> +	}
> +	return sysfs_emit(buf, "%s\n", loc);
> +}
> +static DEVICE_ATTR_RO(removable);
> +
>  int device_add_groups(struct device *dev, const struct attribute_group **groups)
>  {
>  	return sysfs_create_groups(&dev->kobj, groups);
> @@ -2581,8 +2600,16 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_online;
>  	}
>  
> +	if (dev_removable_is_valid(dev)) {
> +		error = device_create_file(dev, &dev_attr_removable);
> +		if (error)
> +			goto err_remove_dev_waiting_for_supplier;
> +	}
> +
>  	return 0;
>  
> + err_remove_dev_waiting_for_supplier:
> +	device_remove_file(dev, &dev_attr_waiting_for_supplier);
>   err_remove_dev_online:
>  	device_remove_file(dev, &dev_attr_online);
>   err_remove_dev_groups:
> @@ -2602,6 +2629,7 @@ static void device_remove_attrs(struct device *dev)
>  	struct class *class = dev->class;
>  	const struct device_type *type = dev->type;
>  
> +	device_remove_file(dev, &dev_attr_removable);
>  	device_remove_file(dev, &dev_attr_waiting_for_supplier);
>  	device_remove_file(dev, &dev_attr_online);
>  	device_remove_groups(dev, dev->groups);
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b2bc4b7c4289..366cb7ef3b72 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2432,6 +2432,8 @@ static void set_usb_port_removable(struct usb_device *udev)
>  	u16 wHubCharacteristics;
>  	bool removable = true;
>  
> +	dev_set_removable(&udev->dev, DEVICE_REMOVABLE_UNKNOWN);
> +
>  	if (!hdev)
>  		return;
>  
> @@ -2443,11 +2445,11 @@ static void set_usb_port_removable(struct usb_device *udev)
>  	 */
>  	switch (hub->ports[udev->portnum - 1]->connect_type) {
>  	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
> -		udev->removable = USB_DEVICE_REMOVABLE;
> +		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
>  		return;
>  	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
>  	case USB_PORT_NOT_USED:
> -		udev->removable = USB_DEVICE_FIXED;
> +		dev_set_removable(&udev->dev, DEVICE_FIXED);
>  		return;
>  	default:
>  		break;
> @@ -2472,9 +2474,9 @@ static void set_usb_port_removable(struct usb_device *udev)
>  	}
>  
>  	if (removable)
> -		udev->removable = USB_DEVICE_REMOVABLE;
> +		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
>  	else
> -		udev->removable = USB_DEVICE_FIXED;
> +		dev_set_removable(&udev->dev, DEVICE_FIXED);
>  
>  }
>  
> @@ -2546,8 +2548,7 @@ int usb_new_device(struct usb_device *udev)
>  	device_enable_async_suspend(&udev->dev);
>  
>  	/* check whether the hub or firmware marks this port as non-removable */
> -	if (udev->parent)
> -		set_usb_port_removable(udev);
> +	set_usb_port_removable(udev);
>  
>  	/* Register the device.  The device driver is responsible
>  	 * for configuring the device and invoking the add-device
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index 5a168ba9fc51..fa2e49d432ff 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -301,29 +301,6 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(urbnum);
>  
> -static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
> -			      char *buf)
> -{
> -	struct usb_device *udev;
> -	char *state;
> -
> -	udev = to_usb_device(dev);
> -
> -	switch (udev->removable) {
> -	case USB_DEVICE_REMOVABLE:
> -		state = "removable";
> -		break;
> -	case USB_DEVICE_FIXED:
> -		state = "fixed";
> -		break;
> -	default:
> -		state = "unknown";
> -	}
> -
> -	return sprintf(buf, "%s\n", state);
> -}
> -static DEVICE_ATTR_RO(removable);
> -
>  static ssize_t ltm_capable_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -828,7 +805,6 @@ static struct attribute *dev_attrs[] = {
>  	&dev_attr_avoid_reset_quirk.attr,
>  	&dev_attr_authorized.attr,
>  	&dev_attr_remove.attr,
> -	&dev_attr_removable.attr,
>  	&dev_attr_ltm_capable.attr,
>  #ifdef CONFIG_OF
>  	&dev_attr_devspec.attr,
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 38a2071cf776..e3a4749694b7 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -350,6 +350,22 @@ enum dl_dev_state {
>  	DL_DEV_UNBINDING,
>  };
>  
> +/**
> + * enum device_removable - Whether the device is removable. The criteria for a
> + * device to be classified as removable is determined by its subsystem or bus.
> + * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
> + *				    device (default).
> + * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
> + * @DEVICE_FIXED: Device is not removable by the user.
> + * @DEVICE_REMOVABLE: Device is removable by the user.
> + */
> +enum device_removable {
> +	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
> +	DEVICE_REMOVABLE_UNKNOWN,
> +	DEVICE_FIXED,
> +	DEVICE_REMOVABLE,
> +};
> +
>  /**
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
> @@ -431,6 +447,9 @@ struct dev_links_info {
>   * 		device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu:	Per device generic IOMMU runtime data
> + * @removable:  Whether the device can be removed from the system. This
> + *              should be set by the subsystem / bus driver that discovered
> + *              the device.
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -544,6 +563,8 @@ struct device {
>  	struct iommu_group	*iommu_group;
>  	struct dev_iommu	*iommu;
>  
> +	enum device_removable	removable;
> +
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> @@ -782,6 +803,22 @@ static inline bool dev_has_sync_state(struct device *dev)
>  	return false;
>  }
>  
> +static inline void dev_set_removable(struct device *dev,
> +				     enum device_removable removable)
> +{
> +	dev->removable = removable;
> +}
> +
> +static inline bool dev_is_removable(struct device *dev)
> +{
> +	return dev && dev->removable == DEVICE_REMOVABLE;
> +}
> +
> +static inline bool dev_removable_is_valid(struct device *dev)
> +{
> +	return dev && dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;

I probably wouldn't check for "dev" being non-NULL in these two
functions unless you have a use case that requires it.

> +}
> +
>  /*
>   * High level routines for use by the bus drivers
>   */
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index eaae24217e8a..b9bd664f44a1 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -473,12 +473,6 @@ struct usb_dev_state;
>  
>  struct usb_tt;
>  
> -enum usb_device_removable {
> -	USB_DEVICE_REMOVABLE_UNKNOWN = 0,
> -	USB_DEVICE_REMOVABLE,
> -	USB_DEVICE_FIXED,
> -};
> -
>  enum usb_port_connect_type {
>  	USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
>  	USB_PORT_CONNECT_TYPE_HOT_PLUG,
> @@ -703,7 +697,6 @@ struct usb_device {
>  #endif
>  	struct wusb_dev *wusb_dev;
>  	int slot_id;
> -	enum usb_device_removable removable;
>  	struct usb2_lpm_parameters l1_params;
>  	struct usb3_lpm_parameters u1_params;
>  	struct usb3_lpm_parameters u2_params;
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
