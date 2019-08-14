Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB858CD39
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 09:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHNHwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 03:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHNHwY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Aug 2019 03:52:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5679D2054F;
        Wed, 14 Aug 2019 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565769142;
        bh=VEIUnUsaQjNlfr6AKllGq3O2H3xQBx57LCb9iAtalOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOehqR9ZU7HxqCy4p8GxhasAJU4UHJr0zEo6FsOpZ2XhzXRNV/A+JNOqM2JMnpsiO
         TVIgpCEmvja89xakF1cbjEn+mQBTbjkb03Qne2d0urUvyF39q8RohRUPDbU+qikJdR
         s0IODItWkEdDvUO6XsuxQ515lrXTrAiBcluqWFpU=
Date:   Wed, 14 Aug 2019 09:52:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2 1/3] PCI: sysfs: Define device
 attributes with DEVICE_ATTR*()
Message-ID: <20190814075220.GA4067@kroah.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-2-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813204513.4790-2-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 02:45:11PM -0600, Kelsey Skunberg wrote:
> Defining device attributes should be done through the helper
> DEVICE_ATTR*(_name, _mode, _show, _store). Change all instances using
> __ATTR*() to now use DEVICE_ATTR*().
> 
> Example of old:
> 
> struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show,
> 						  _store)
> 
> Example of new:
> 
> static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo)

Why not DEVICE_ATTR_RO() and DEVICE_ATTR_RW() and friends?  "Raw"
DEVICE_ATTR() should almost never be used unless the files have a very
strange mode setting.  And if that is true, they should be audited to
find out why their permissions are so strange from the rest of the
kernel defaults.

> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 965c72104150..8af7944fdccb 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
>  	}
>  	return count;
>  }
> -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> -							(S_IWUSR|S_IWGRP),
> -							NULL, dev_rescan_store);
> +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);

DEVICE_ATTR_WO()?

>  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t count)
> @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>  	return count;
>  }
> -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> -							(S_IWUSR|S_IWGRP),
> -							NULL, remove_store);
> +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> +				  remove_store);

DEVICE_ATTR_WO()?

Ugh, no lockdep?  ick, ok, leave this as-is, crazy "remove" files...

>  
>  static ssize_t dev_bus_rescan_store(struct device *dev,
>  				    struct device_attribute *attr,
> @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
>  	}
>  	return count;
>  }
> -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);

DEVICE_ATTR_WO()?

>  
>  #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
>  static ssize_t d3cold_allowed_store(struct device *dev,
> @@ -687,16 +684,14 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
>  	return count;
>  }
>  
> -static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> -static struct device_attribute sriov_numvfs_attr =
> -		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
> -		       sriov_numvfs_show, sriov_numvfs_store);
> -static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> -static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> -static struct device_attribute sriov_vf_device_attr = __ATTR_RO(sriov_vf_device);
> -static struct device_attribute sriov_drivers_autoprobe_attr =
> -		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
> -		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> +static DEVICE_ATTR_RO(sriov_totalvfs);
> +static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> +				  sriov_numvfs_show, sriov_numvfs_store);

DEVICE_ATTR_RW()?

> +static DEVICE_ATTR_RO(sriov_offset);
> +static DEVICE_ATTR_RO(sriov_stride);
> +static DEVICE_ATTR_RO(sriov_vf_device);
> +static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> +		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);

DEVICE_ATTR_RW()?

>  #endif /* CONFIG_PCI_IOV */
>  
>  static ssize_t driver_override_store(struct device *dev,
> @@ -792,7 +787,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  };
>  
>  static struct attribute *pcibus_attrs[] = {
> -	&dev_attr_rescan.attr,
> +	&dev_attr_bus_rescan.attr,
>  	&dev_attr_cpuaffinity.attr,
>  	&dev_attr_cpulistaffinity.attr,
>  	NULL,
> @@ -820,7 +815,7 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
>  		!!(pdev->resource[PCI_ROM_RESOURCE].flags &
>  		   IORESOURCE_ROM_SHADOW));
>  }
> -static struct device_attribute vga_attr = __ATTR_RO(boot_vga);
> +static DEVICE_ATTR_RO(boot_vga);
>  
>  static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *bin_attr, char *buf,
> @@ -1458,7 +1453,7 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> -static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_store);
> +static DEVICE_ATTR(reset, 0200, NULL, reset_store);

DEVICE_ATTR_WO()?  Hm, root only, maybe not :(

>  
>  static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  {
> @@ -1468,7 +1463,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	pcie_aspm_create_sysfs_dev_files(dev);
>  
>  	if (dev->reset_fn) {
> -		retval = device_create_file(&dev->dev, &reset_attr);
> +		retval = device_create_file(&dev->dev, &dev_attr_reset);

odds are this needs to be fixed up later to use attribute groups
properly.  But that's better left for another patch.

>  		if (retval)
>  			goto error;
>  	}
> @@ -1553,7 +1548,7 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  	pcie_vpd_remove_sysfs_dev_files(dev);
>  	pcie_aspm_remove_sysfs_dev_files(dev);
>  	if (dev->reset_fn) {
> -		device_remove_file(&dev->dev, &reset_attr);
> +		device_remove_file(&dev->dev, &dev_attr_reset);

Same here, attribute groups will handle this.

thanks,

greg k-h
