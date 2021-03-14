Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C786A33A8F5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 00:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCNX4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Mar 2021 19:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhCNXzt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Mar 2021 19:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514B664E4B;
        Sun, 14 Mar 2021 23:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615766148;
        bh=ZUbb71zvCmCMdUhP2EHAnGgOZWOho/+CsC6w/rQarDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu5CRmMjd0QN3oPkgGK7hLPpwhFGnxRsh2ycJpHqiVxTDBFDP78jiEym+KwBTCBih
         CMFpr40S+ChiKjZRAkvn0airsU2rVO/s/rdCClWob3NKkagrjf+1uHZqH3IfwIpwtb
         Ur0loaXZ10bIUGe0wuUNmGrwNE6/j2ByFJL1OxSwaZArS0OOP7pA/utWXP/GA8FBwo
         aSTZsw8J4UMg9TbAlflmx8Y2FPyaM7NuPUOL5e4jLTZ9eH5nDTwDMkNymXd+oCDFQM
         oFcovdbiFTCNAKFrcYR+IZDql3XhLdwsa+SzxHmadazrI393iJ/7yizsgPbJUP8szq
         J2d2JnVt2pmzQ==
Received: by pali.im (Postfix)
        id B723689B; Mon, 15 Mar 2021 00:55:45 +0100 (CET)
Date:   Mon, 15 Mar 2021 00:55:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     ameynarkhede03@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210314235545.girtrazsdxtrqo2q@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312173452.3855-5-ameynarkhede03@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 March 2021 23:04:52 ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
> 
> Add reset_methods_enabled bitmap to struct pci_dev to
> keep track of user preferred device reset mechanisms.
> Add reset_method sysfs attribute to query and set
> user preferred device reset mechanisms.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> 
>  Documentation/ABI/testing/sysfs-bus-pci | 15 ++++++
>  drivers/pci/pci-sysfs.c                 | 66 +++++++++++++++++++++++--
>  drivers/pci/pci.c                       |  3 +-
>  include/linux/pci.h                     |  2 +
>  4 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 25c9c3977..ae53ecd2e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,21 @@ Description:
>  		child buses, and re-discover devices removed earlier
>  		from this part of the device tree.
> 
> +What:		/sys/bus/pci/devices/.../reset_method
> +Date:		March 2021
> +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> +Description:
> +		Some devices allow an individual function to be reset
> +		without affecting other functions in the same slot.
> +		For devices that have this support, a file named reset_method
> +		will be present in sysfs. Reading this file will give names
> +		of the device supported reset methods. Currently used methods
> +		are enclosed in brackets. Writing the name of any of the device
> +		supported reset method to this file will set the reset method to
> +		be used when resetting the device. Writing "none" to this file
> +		will disable ability to reset the device and writing "default"
> +		will return to the original value.
> +

Hello Amey!

I think that this API does not work for PCIe Hot Reset (=PCI secondary
bus reset) and PCIe Warm Reset.

First reset method is bound to the bus, not device and therefore kernel
does not have to see any registered device. So there would be no
"reset_method" sysfs file, and also no "reset" sysfs file. But PCIe Hot
Reset is in most cases needed when buggy card is not registered on bus,
to trigger this reset. And with this API this is not possible.

PCIe Warm Reset is done by PERST# signal. When signal is asserted then
device is in reset state and therefore is not registered. So again
kernel does not have to see registered device.

Moreover for mPCIe form factor cards, boards can share one PERST# signal
with more PCIe cards and control this signal via GPIO. So asserting
PERST# GPIO can trigger Warm reset for more PCIe cards, not just one. It
depends on board or topology.

So... I do not think that current approach with "reset_method" sysfs
entry bound to the PCI device does not work for PCI secondary bus reset
and also cannot be used for implementing PCIe Warm Reset.

I would rather suggest to re-design and prepare a new API which would
work also with PCIe Hot Reset and PCIe Warm Reset.

This "reset" sysfs file can work only with PCI Function Level Reset or
some PM or device specific reset. But not with reset types which are
more like slot or bus orientated.

>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
>  Contact:	Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 78d2c130c..3cd06d1c0 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1304,6 +1304,59 @@ static const struct bin_attribute pcie_config_attr = {
>  	.write = pci_write_config,
>  };
> 
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	const struct pci_reset_fn_method *reset;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
> +		if (pdev->reset_methods_enabled & (1 << i))
> +			len += sysfs_emit_at(buf, len, "[%s] ", reset->name);
> +		else if (pdev->reset_methods & (1 << i))
> +			len += sysfs_emit_at(buf, len, "%s ", reset->name);
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t reset_method_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	const struct pci_reset_fn_method *reset = pci_reset_fn_methods;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u8 reset_mechanism;
> +	int i = 0;
> +
> +	/* Writing none disables reset */
> +	if (sysfs_streq(buf, "none")) {
> +		reset_mechanism = 0;
> +	} else if (sysfs_streq(buf, "default")) {
> +		/* Writing default returns to initial value */
> +		reset_mechanism = pdev->reset_methods;
> +	} else {
> +		reset_mechanism = 0;
> +		for (; reset->reset_fn; i++, reset++) {
> +			if (sysfs_streq(buf, reset->name)) {
> +				reset_mechanism = 1 << i;
> +				break;
> +			}
> +		}
> +		if (!reset_mechanism || !(pdev->reset_methods & reset_mechanism))
> +			return -EINVAL;
> +	}
> +
> +	pdev->reset_methods_enabled = reset_mechanism;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(reset_method);
> +
>  static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> @@ -1337,11 +1390,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
>  	if (dev->reset_methods) {
>  		retval = device_create_file(&dev->dev, &dev_attr_reset);
>  		if (retval)
> -			goto error;
> +			goto err_reset;
> +		retval = device_create_file(&dev->dev, &dev_attr_reset_method);
> +		if (retval)
> +			goto err_method;
>  	}
>  	return 0;
> 
> -error:
> +err_method:
> +	device_remove_file(&dev->dev, &dev_attr_reset);
> +err_reset:
>  	pcie_vpd_remove_sysfs_dev_files(dev);
>  	return retval;
>  }
> @@ -1417,8 +1475,10 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
>  {
>  	pcie_vpd_remove_sysfs_dev_files(dev);
> -	if (dev->reset_methods)
> +	if (dev->reset_methods) {
>  		device_remove_file(&dev->dev, &dev_attr_reset);
> +		device_remove_file(&dev->dev, &dev_attr_reset_method);
> +	}
>  }
> 
>  /**
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b7f6c6588..81cebea56 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5106,7 +5106,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	might_sleep();
> 
>  	for (i = 0, reset = pci_reset_fn_methods; reset->reset_fn; i++, reset++) {
> -		if (!(dev->reset_methods & (1 << i)))
> +		if (!(dev->reset_methods_enabled & (1 << i)))
>  			continue;
> 
>  		/*
> @@ -5153,6 +5153,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
>  		else if (rc != -ENOTTY)
>  			break;
>  	}
> +	dev->reset_methods_enabled = dev->reset_methods;
>  }
> 
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a2f003f4e..400f614e0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -335,6 +335,8 @@ struct pci_dev {
>  	 * See pci_reset_fn_methods array in pci.c
>  	 */
>  	u8 __bitwise reset_methods;		/* bitmap for device supported reset capabilities */
> +	/* bitmap for user enabled and device supported reset capabilities */
> +	u8 __bitwise reset_methods_enabled;
>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> --
> 2.30.2
