Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C013DE2C2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhHBW4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231920AbhHBW4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:56:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C48ED60EE8;
        Mon,  2 Aug 2021 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627944961;
        bh=c9nH0VoS4XSqz71VDqTxwB417lLMKbQsxFUEFp/TEUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SyH5TyJTxARJoxPRItch2OjAKegOQdZwgPIyPJmxzAcw2nax4lRioo7bRLQ1dyoBo
         5YEg8epkg4a8gD7V7CwWj2edkN65IFbj4WOXjSu8Eh3FxEXKHdTenrwSC/4n9OJW0S
         2vQScKOR/S7JHgJUsH8KEzwqqfAUyyUxwchW5qLS1m2w3SSLslaA2tCY5Beh+RE3DO
         yMlUAgbCeTRWmst81DluPOuCKh2tuE2YV2V7VcBRGcx+OtsUUogFY0wbAHKaFB+tyA
         N3AE3MWMpu0CgfqQiscIEPKGfZJxw9/ssYKBHUF5BckdDi9i1elFABEuVpLA8MH5ES
         mEI15YeuV6jFg==
Date:   Mon, 2 Aug 2021 17:55:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v13 5/9] PCI: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210802225559.GA1472320@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801142518.1224-6-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 01, 2021 at 07:55:14PM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
> 
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
>  drivers/pci/pci-sysfs.c                 |   1 +
>  drivers/pci/pci.c                       | 105 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |   2 +
>  4 files changed, 127 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2efb..ef66b62bf025 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,25 @@ Description:
>  		child buses, and re-discover devices removed earlier
>  		from this part of the device tree.
>  
> +What:		/sys/bus/pci/devices/.../reset_method
> +Date:		March 2021
> +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> +Description:
> +		Some devices allow an individual function to be reset
> +		without affecting other functions in the same slot.
> +
> +		For devices that have this support, a file named
> +		reset_method will be present in sysfs. Initially reading
> +		this file will give names of the device supported reset
> +		methods and their ordering. After write, this file will
> +		give names and ordering of currently enabled reset methods.
> +		Writing the name or space separated list of names of any of
> +		the device supported reset methods to this file will set
> +		the reset methods and their ordering to be used when
> +		resetting the device. Writing empty string to this file
> +		will disable ability to reset the device and writing
> +		"default" will return to the original value.
> +
>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
>  Contact:	Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 316f70c3e3b4..54ee7193b463 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1491,6 +1491,7 @@ const struct attribute_group *pci_dev_groups[] = {
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 932dd21e759b..c496cd164aca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5132,6 +5132,111 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_reset_bus_function, .name = "bus" },
>  };
>  
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)

Looks like "buf" would fit on the previous line.

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len = 0;
> +	int i, m;
> +
> +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		m = pdev->reset_methods[i];
> +		if (!m)
> +			break;
> +
> +		len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
> +				     pci_reset_fn_methods[m].name);
> +	}
> +
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
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int i = 0;
> +	char *name, *options = NULL;
> +
> +	if (count >= (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "")) {
> +		pdev->reset_methods[0] = 0;
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		return count;
> +	}

I think it's possible for the user to disable all reset methods by
supplying only junk.  Maybe this check could be moved to the end of
the function to catch both the "empty input" and the "input contains
only junk" cases?

> +	if (sysfs_streq(buf, "default")) {
> +		pci_init_reset_methods(pdev);
> +		return count;
> +	}
> +
> +	options = kstrndup(buf, count, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +

  i = 0;

here so it's nearer the loop it controls.

> +	while ((name = strsep(&options, " ")) != NULL) {
> +		int m;
> +
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name = strim(name);
> +
> +		for (m = 1; m < PCI_NUM_RESET_METHODS && i < PCI_NUM_RESET_METHODS; m++) {
> +			if (sysfs_streq(name, pci_reset_fn_methods[m].name) &&
> +			    !pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
> +				pdev->reset_methods[i++] = m;
> +				break;
> +			}
> +		}
> +
> +		if (m == PCI_NUM_RESET_METHODS) {
> +			kfree(options);
> +			return -EINVAL;

In this case, I think we have actually updated pdev->reset_methods[],
but we still return -EINVAL, right?  If we decide to silently ignore
unrecognized methods, we probably should return success here.

> +
> +		}
> +	}
> +
> +	if (i < PCI_NUM_RESET_METHODS)
> +		pdev->reset_methods[i] = 0;
> +
> +	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && pdev->reset_methods[0] != 1)

Looks longer than 80 columns?  "Fixed" by rewrapping in patch 9/9, but
would be better to fix here.

> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> +
> +	kfree(options);
> +
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
> +
> +	return a->mode;
> +}
> +
> +const struct attribute_group pci_dev_reset_method_attr_group = {
> +	.attrs = pci_dev_reset_method_attrs,
> +	.is_visible = pci_dev_reset_method_attr_is_visible,
> +};
> +
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holding
>   * the @dev mutex lock.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 7438953745e0..31458d48eda7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -714,4 +714,6 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
>  extern const struct attribute_group aspm_ctrl_attr_group;
>  #endif
>  
> +extern const struct attribute_group pci_dev_reset_method_attr_group;
> +
>  #endif /* DRIVERS_PCI_H */
> -- 
> 2.32.0
> 
