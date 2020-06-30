Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232CA20F00E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 10:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgF3IBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 04:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgF3IBe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 04:01:34 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602DC2067D;
        Tue, 30 Jun 2020 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593504093;
        bh=/K95gsIeDFvq/cfNbSHemowJV1GCgFyuiQ9gKwSv3Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyXAxBvS92Smno1SNYEhOgU+4s003HTesBM/Wqpyq2ZMXsxbMLjq6PKv3IHl+bKLg
         yvpRpOc1IBZOBgNBFqef2xTUkXeHKaN2Bo9O041B7uAENgdVe0QtinHAU+wrTwGP21
         Huxdlg6gNi+hL+Q/paKVdRwLAfPx39Vg77dI1sKs=
Date:   Tue, 30 Jun 2020 10:01:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200630080130.GB619174@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-6-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> Add a new (optional) field to denote the physical location of a device
> in the system, and expose it in sysfs. This was discussed here:
> https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> 
> (The primary choice for attribute name i.e. "location" is already
> exposed as an ABI elsewhere, so settled for "site").

Where is "location" exported?  I see one USB port sysfs attribute, is
that what you are worried about here?

> Individual buses
> that want to support this new attribute can opt-in by setting a flag in
> bus_type, and then populating the location of device while enumerating
> it.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: (Initial version)
> 
>  drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++
>  include/linux/device.h     | 42 ++++++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h |  8 ++++++++
>  3 files changed, 85 insertions(+)


No Documentation/ABI/ update for this new attribute?  Why not?

> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c7..14c815526b7fa 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1778,6 +1778,32 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(online);
>  
> +static ssize_t site_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	const char *site;
> +
> +	device_lock(dev);
> +	switch (dev->site) {
> +	case SITE_INTERNAL:
> +		site = "INTERNAL";
> +		break;
> +	case SITE_EXTENDED:
> +		site = "EXTENDED";
> +		break;
> +	case SITE_EXTERNAL:
> +		site = "EXTERNAL";
> +		break;
> +	case SITE_UNKNOWN:
> +	default:
> +		site = "UNKNOWN";
> +		break;
> +	}
> +	device_unlock(dev);

Why are you locking/unlocking a device here?

You have a reference count on the structure, are you worried about
something else changing here on it?  If so, what?  You aren't locking it
when the state is set (which is fine, really, you shouldn't need to.)


> +	return sprintf(buf, "%s\n", site);
> +}
> +static DEVICE_ATTR_RO(site);
> +
>  int device_add_groups(struct device *dev, const struct attribute_group **groups)
>  {
>  	return sysfs_create_groups(&dev->kobj, groups);
> @@ -1949,8 +1975,16 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_groups;
>  	}
>  
> +	if (bus_supports_site(dev->bus)) {
> +		error = device_create_file(dev, &dev_attr_site);
> +		if (error)
> +			goto err_remove_dev_attr_online;
> +	}
> +
>  	return 0;
>  
> + err_remove_dev_attr_online:
> +	device_remove_file(dev, &dev_attr_online);
>   err_remove_dev_groups:
>  	device_remove_groups(dev, dev->groups);
>   err_remove_type_groups:
> @@ -1968,6 +2002,7 @@ static void device_remove_attrs(struct device *dev)
>  	struct class *class = dev->class;
>  	const struct device_type *type = dev->type;
>  
> +	device_remove_file(dev, &dev_attr_site);
>  	device_remove_file(dev, &dev_attr_online);
>  	device_remove_groups(dev, dev->groups);
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024a..a4143735ae712 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -428,6 +428,31 @@ enum dl_dev_state {
>  	DL_DEV_UNBINDING,
>  };
>  
> +/**
> + * enum device_site - Physical location of the device in the system.
> + * The semantics of values depend on subsystem / bus:
> + *
> + * @SITE_UNKNOWN:  Location is Unknown (default)
> + *
> + * @SITE_INTERNAL: Device is internal to the system, and cannot be (easily)
> + *                 removed. E.g. SoC internal devices, onboard soldered
> + *                 devices, internal M.2 cards (that cannot be removed
> + *                 without opening the chassis).
> + * @SITE_EXTENDED: Device sits an extension of the system. E.g. devices
> + *                 on external PCIe trays, docking stations etc. These
> + *                 devices may be removable, but are generally housed
> + *                 internally on an extension board, so they are removed
> + *                 only when that whole extension board is removed.
> + * @SITE_EXTERNAL: Devices truly external to the system (i.e. plugged on
> + *                 an external port) that may be removed or added frequently.
> + */
> +enum device_site {
> +	SITE_UNKNOWN = 0,
> +	SITE_INTERNAL,
> +	SITE_EXTENDED,
> +	SITE_EXTERNAL,
> +};
> +
>  /**
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
> @@ -513,6 +538,7 @@ struct dev_links_info {
>   * 		device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu:	Per device generic IOMMU runtime data
> + * @site:	Physical location of the device w.r.t. the system
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -613,6 +639,8 @@ struct device {
>  	struct iommu_group	*iommu_group;
>  	struct dev_iommu	*iommu;
>  
> +	enum device_site	site;	/* Device physical location */
> +
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> @@ -806,6 +834,20 @@ static inline bool dev_has_sync_state(struct device *dev)
>  	return false;
>  }
>  
> +static inline int dev_set_site(struct device *dev, enum device_site site)
> +{
> +	if (site < SITE_UNKNOWN || site > SITE_EXTERNAL)
> +		return -EINVAL;

It's an enum, why check the range?

thanks,

greg k-h
