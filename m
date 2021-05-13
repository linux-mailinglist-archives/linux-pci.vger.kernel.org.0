Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7181337F933
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEMN5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 09:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234230AbhEMN5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 May 2021 09:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E90E613CB;
        Thu, 13 May 2021 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620914147;
        bh=zHWe7foAuGqfLbT8D9QGXLtee90e7xUkgvIi+FgFjJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BwkCPrhVVCpkLiK+SFKHafOL4gI7AtsXWkeEcfoPOzD/pSV0BG2JKsifktSPjwOJZ
         K+Qac6v3kCoUhcBX6O0S7MzWwWK3Rz0QvPuX2a+52N82EVPxWgXKd3N/fbrHcv2kCS
         vxosC2YBXTOgQeM3JWw0hxXZDBqaPa3XptQlxQI0=
Date:   Thu, 13 May 2021 15:55:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, helgaas@kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v3 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <YJ0v4G4UpeAvSEFT@kroah.com>
References: <20210512213457.1310774-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512213457.1310774-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 12, 2021 at 02:34:56PM -0700, Rajat Jain wrote:
> Move the "removable" attribute from USB to core in order to allow it to be
> supported by other subsystem / buses. Individual buses that want to support
> this attribute can opt-in by setting the supports_removable flag, and then
> populating the removable property of the device while enumerating it. The
> UAPI (location, symantics etc) for the attribute remains unchanged.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> v3: - Minor commit log / comments updated.
>     - use sysfs_emit()
>     - Rename local variable name (state -> loc)
>     - change supports_removable flag from bool to bitfield.
> v2: Add documentation
> 
>  Documentation/ABI/testing/sysfs-bus-usb       | 11 -------
>  .../ABI/testing/sysfs-devices-removable       | 17 ++++++++++
>  drivers/base/core.c                           | 28 ++++++++++++++++
>  drivers/usb/core/hub.c                        |  8 ++---
>  drivers/usb/core/sysfs.c                      | 24 --------------
>  drivers/usb/core/usb.c                        |  1 +
>  include/linux/device.h                        | 32 +++++++++++++++++++
>  include/linux/usb.h                           |  7 ----
>  8 files changed, 82 insertions(+), 46 deletions(-)
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
> index 000000000000..9dabcad7cdcd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-removable
> @@ -0,0 +1,17 @@
> +What:		/sys/devices/.../removable

This should be "/sys/bus/devices/.../removable" perhaps?  Or not?  Is
this moving in the existing USB cases?

> +Date:		Apr 2021
> +Contact:	Matthew Garrett <mjg@redhat.com>,

This email address no longer works, so perhaps just use your own?

> +		Rajat Jain <rajatja@google.com>
> +Description:
> +		Information about whether a given device is physically fixed to
> +		the platform. This is determined by the device's subsystem in a
> +		bus / platform-specific way. This attribute is only present for
> +		buses that can support determining such information:
> +
> +		"removable": The device is external / removable from the system.
> +		"fixed":     The device is internal / fixed to the system.
> +		"unknown":   The information is unavailable.
> +
> +		Currently this is only supported by USB (which infers the
> +		information from a combination of hub descriptor bits and
> +		platform-specific data such as ACPI).
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4a8bf8cda52b..9e6bf9e71a7e 100644
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
> +	if (type && type->supports_removable) {
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
> index b2bc4b7c4289..7a3c28b14ca1 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2443,11 +2443,11 @@ static void set_usb_port_removable(struct usb_device *udev)
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
> @@ -2472,9 +2472,9 @@ static void set_usb_port_removable(struct usb_device *udev)
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
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 62368c4ed37a..ce18e84528cf 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -569,6 +569,7 @@ struct device_type usb_device_type = {
>  #ifdef CONFIG_PM
>  	.pm =		&usb_device_pm_ops,
>  #endif
> +	.supports_removable = true,
>  };
>  
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 38a2071cf776..7e87ab048307 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -93,6 +93,8 @@ struct device_type {
>  	void (*release)(struct device *dev);
>  
>  	const struct dev_pm_ops *pm;
> +
> +	bool supports_removable:1; /* subsystem can classify removable/fixed */

Why isn't this a bus type?  Shouldn't it go there and not in the device
type?

>  };
>  
>  /* interface for exporting device attributes */
> @@ -350,6 +352,19 @@ enum dl_dev_state {
>  	DL_DEV_UNBINDING,
>  };
>  
> +/**
> + * enum device_removable - Whether the device is removable. The criteria for a
> + * device to be classified as removable is determined by its subsystem or bus.
> + * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown (default).
> + * @DEVICE_REMOVABLE: Device is removable by the user.
> + * @DEVICE_FIXED: Device is not removable by the user.
> + */
> +enum device_removable {
> +	DEVICE_REMOVABLE_UNKNOWN = 0,
> +	DEVICE_REMOVABLE,
> +	DEVICE_FIXED,
> +};
> +
>  /**
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
> @@ -431,6 +446,9 @@ struct dev_links_info {
>   * 		device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu:	Per device generic IOMMU runtime data
> + * @removable:  Whether the device can be removed from the system. This
> + *              should be set by the subsystem / bus driver that discovered
> + *              the device.
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -544,6 +562,8 @@ struct device {
>  	struct iommu_group	*iommu_group;
>  	struct dev_iommu	*iommu;
>  
> +	enum device_removable	removable;
> +
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> @@ -782,6 +802,18 @@ static inline bool dev_has_sync_state(struct device *dev)
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
> +	return dev && dev->type && dev->type->supports_removable
> +	    && dev->removable == DEVICE_REMOVABLE;

Again, shouldn't this be a bus type, and not a device type?

Where are you going to have devices of different types on a bus that do,
or do not, allow this attribute?

thanks,

greg k-h
