Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C43AD34B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFRUC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 16:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhFRUC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 16:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73E5C61284;
        Fri, 18 Jun 2021 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624046446;
        bh=ukCWv700nw419U/zUESyNHC+5o4jEIFSTw/JYrj1TFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E70arPAPnlwDPp50+ZsC5gCoaTmTqh3qost0EhI7J5QYPFYNy+TAgkkFwDOsiY0uo
         QQpPCOQn6qOWdcKXKYRI2mHYMB0vVeiqTzRrD7zCv/7QJcBCqaHEN6qj717R4+cTCz
         cCOF2TF1+sP50xHa5oBOwoPfCX2qVTIpid5kL7FAkBMfDVwK0SxgI9BNe1uuQMlN3t
         wfUTZKhqySM9w1ng7/ifZ2wTRT8Q4whYQlUQIr/46VCh0Bu3qCaTdeAFFmQnErGYOT
         4S4+EFmgaWFMj0IWdy077aeaEfk+TFaYptEv3EPQFTfMUhrPn4y0CtluHz75s4L7Gn
         1XAjO8s0mNbzQ==
Date:   Fri, 18 Jun 2021 15:00:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210618200045.GA3141153@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608054857.18963-5-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to
> query and set user preferred device reset methods and
> their ordering.

Rewrap to fill 75 columns (also apply to other patches if applicable,
e.g., 3/8 looks like it could use it).

2/8 looks like it's missing a blank line between paragraphs.

> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  16 ++++
>  drivers/pci/pci-sysfs.c                 | 118 ++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2..cf6dbbb3c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,22 @@ Description:
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
> +		of the device supported reset methods and their ordering.
> +		Writing the name or comma separated list of names of any of
> +		the device supported reset methods to this file will set the
> +		reset methods and their ordering to be used when resetting
> +		the device. Writing empty string to this file will disable
> +		ability to reset the device and writing "default" will return
> +		to the original value.

Rewrap to fill or add a blank line if "For devices ..." is supposed to
start a new paragraph.

My guess is you intend reading to show the *currently enabled* reset
methods, not the entire "supported" set?  So if a user has disabled
one of them, it no longer appears when you read the file?

> +
>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
>  Contact:	Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 316f70c3e..52def79aa 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1334,6 +1334,123 @@ static const struct attribute_group pci_dev_rom_attr_group = {
>  	.is_bin_visible = pci_dev_rom_attr_is_visible,
>  };
>  
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len = 0;
> +	int i, prio;
> +
> +	for (prio = PCI_RESET_METHODS_NUM; prio; prio--) {
> +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (prio == pdev->reset_methods[i]) {
> +				len += sysfs_emit_at(buf, len, "%s%s",
> +						     len ? "," : "",
> +						     pci_reset_fn_methods[i].name);
> +				break;
> +			}
> +		}
> +
> +		if (i == PCI_RESET_METHODS_NUM)
> +			break;
> +	}

I'm guessing that if you adopt the alternate reset_methods[] encoding,
this nested loop becomes a single loop and "prio" goes away?

> +	if (len)
> +		len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t reset_method_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	u8 reset_methods[PCI_RESET_METHODS_NUM];
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u8 prio = PCI_RESET_METHODS_NUM;
> +	char *name, *options;
> +	int i;

Reorder decls with to_pci_dev(dev) first, then in order of use.

> +	if (count >= (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	options = kstrndup(buf, count, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Initialize reset_method such that 0xff indicates
> +	 * supported but not currently enabled reset methods
> +	 * as we only use priority values which are within
> +	 * the range of PCI_RESET_FN_METHODS array size
> +	 */
> +	for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> +		reset_methods[i] = pdev->reset_methods[i] ? 0xff : 0;

I'm hoping the 0xff trick goes away with the alternate encoding?

> +	if (sysfs_streq(options, "")) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		goto set_reset_methods;
> +	}

I think you can get this case out of the way early with no kstrndup(),
no goto, etc.

> +	if (sysfs_streq(options, "default")) {
> +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> +		goto set_reset_methods;
> +	}

If you use pci_init_reset_methods() here, you can also get this case
out of the way early.

> +	while ((name = strsep(&options, ",")) != NULL) {
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name = strim(name);
> +
> +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (reset_methods[i] &&
> +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> +				reset_methods[i] = prio--;
> +				break;
> +			}
> +		}
> +
> +		if (i == PCI_RESET_METHODS_NUM) {
> +			kfree(options);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (reset_methods[0] &&
> +	    reset_methods[0] != PCI_RESET_METHODS_NUM)
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");

Is there a specific reason for this warning?  Is it just telling the
user that he might have shot himself in the foot?  Not sure that's
necessary.

> +set_reset_methods:
> +	kfree(options);
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> +	return count;
> +}
> +static DEVICE_ATTR_RW(reset_method);
> +
> +static struct attribute *pci_dev_reset_method_attrs[] = {
> +	&dev_attr_reset_method.attr,
> +	NULL,
> +};
> +
> +static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
> +						    struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	if (!pci_reset_supported(pdev))
> +		return 0;

I think this _is_visible method is executed only once, at
device_add()-time.  That means if a device doesn't support any resets
at that time, "reset_method" will not be visible, and there will be no
way to ever enable a reset method at run-time.  I assume that's OK;
just double-checking.

> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group pci_dev_reset_method_attr_group = {
> +	.attrs = pci_dev_reset_method_attrs,
> +	.is_visible = pci_dev_reset_method_attr_is_visible,
> +};
> +
>  static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> @@ -1491,6 +1608,7 @@ const struct attribute_group *pci_dev_groups[] = {
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> -- 
> 2.31.1
> 
