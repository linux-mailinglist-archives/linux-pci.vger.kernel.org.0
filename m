Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2143D941A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhG1RJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG1RJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 13:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D303260F5E;
        Wed, 28 Jul 2021 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627492194;
        bh=FYMA5pdExb7xuWJXpOX+CgZlXsECAXDPtU96Sufzvu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=urr/MSpTxcS4Otpvzwo1qA3HLbLkjw4OqoCcEFhVyQ371vUtfEHFY2bAc4odKsTKE
         v4RC5Lm2w7veA1KD6hkE642eBmdO633tgztoaFNmJkiSyBu93kXlI9qT9Q7JuIsfor
         wtXhJmzhnyhYFHLs6Yn/eSgr0ciWwVqLnY0CL2ULQMQGP115VQkv4XJR05F9BbSOzb
         JMKikbC/GE6TSs+EmuatRxV7LsYRWldZnl/gsh9tXPEAPwAJh9d5Vsf4BfTGvK+nkt
         /51Q620CNabEN3m3NGhV6dPC0c6DrpLkUaqfGhj+O8tuyRD7VJJj394pCzKpS5Y1Jr
         c0leims9Sj6SA==
Date:   Wed, 28 Jul 2021 12:09:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210728170952.GA829614@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709123813.8700-5-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Serge, linux-security-module: should we check CAP_SYS_ADMIN or
similar for changing PCI reset mechanisms for a device?]

On Fri, Jul 09, 2021 at 06:08:09PM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
> 
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
>  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2..43f4e33c7 100644
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
> +		Writing the name or comma separated list of names of any of
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
> index 316f70c3e..8a740e211 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1334,6 +1334,108 @@ static const struct attribute_group pci_dev_rom_attr_group = {
>  	.is_bin_visible = pci_dev_rom_attr_is_visible,
>  };
>  
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len = 0;
> +	int i, idx;
> +
> +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		idx = pdev->reset_methods[i];
> +		if (!idx)
> +			break;
> +
> +		len += sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
> +				     pci_reset_fn_methods[idx].name);
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
> +	int n = 0;
> +	char *name, *options = NULL;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };

Should this check "capable(CAP_SYS_ADMIN)" or similar?  The sysfs file
is mode 0644, so writable only by root.

I do note that Documentation/process/adding-syscalls.rst suggests
"avoid adding new uses of the already overly-general CAP_SYS_ADMIN
capability."  But CAP_SYS_ADMIN is used for all the other checks in
pci-sysfs.c.

> +	if (count >= (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "")) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		goto set_reset_methods;
> +	}
> +
> +	if (sysfs_streq(buf, "default")) {
> +		pci_init_reset_methods(pdev);
> +		return count;
> +	}
> +
> +	options = kstrndup(buf, count, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	while ((name = strsep(&options, ",")) != NULL) {
> +		int i;
> +
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name = strim(name);
> +
> +		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
> +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> +				reset_methods[n++] = i;
> +				break;
> +			}
> +		}
> +
> +		if (i == PCI_NUM_RESET_METHODS) {
> +			kfree(options);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> +
> +set_reset_methods:
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> +	kfree(options);
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
> +static const struct attribute_group pci_dev_reset_method_attr_group = {
> +	.attrs = pci_dev_reset_method_attrs,
> +	.is_visible = pci_dev_reset_method_attr_is_visible,
> +};
> +
>  static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> @@ -1491,6 +1593,7 @@ const struct attribute_group *pci_dev_groups[] = {
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> -- 
> 2.32.0
> 
