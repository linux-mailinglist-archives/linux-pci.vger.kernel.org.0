Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE235FC6F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 22:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhDNUST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 16:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhDNUSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 16:18:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5156B608FC;
        Wed, 14 Apr 2021 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618431476;
        bh=yFk2cx4HrXNqOm2e36DgIZtP17/Q9M1Lfp4gu+Ir38U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XRF4vv6yLAaH6SxWfUzh4NaKkN7a9JAum1Tfn1vJ8UegP7s4GPMCgm1u2VreSfiBT
         Npzm0PSKq3Aq8z6UAfv86m46XNiQ6N6En2aZC6Cqia/3aMoclI4x1FS8bNMB9ZlG6I
         Q40prXp18K7YDqWUlUDTFwvh99YpFA1qRyUEqPq9CUr6cPrU9D69Eehj25apsoBZst
         uOMQN2Wawhm4q8eqwWUvwD7LLHwNfud5+9+ErFUAfT1BAealvjWkQHzB0KkSlm1KIv
         kBlO6tkPex7HbtgvQA54S5P8QPxKqyCESkftYx6TaCci+jJOTMld7ir6zZp7QX+BTl
         XKfluHrlirYEg==
Date:   Wed, 14 Apr 2021 15:17:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Narendra K <narendra_k@dell.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/pci: expose a PCI device's UID as its index
Message-ID: <20210414201755.GA2532433@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412135905.1434249-2-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 03:59:05PM +0200, Niklas Schnelle wrote:
> On s390 each PCI device has a user-defined ID (UID) exposed under
> /sys/bus/pci/devices/<dev>/uid. This ID was designed to serve as the PCI
> device's primary index and to match the device within Linux to the
> device configured in the hypervisor. To serve as a primary identifier
> the UID must be unique within the Linux instance, this is guaranteed by
> the platform if and only if the UID Uniqueness Checking flag is set
> within the CLP List PCI Functions response.
> 
> In this sense the UID serves an analogous function as the SMBIOS
> instance number or ACPI index exposed as the "index" respectively
> "acpi_index" device attributes and used by e.g. systemd to set interface
> names. As s390 does not use and will likely never use ACPI nor SMBIOS
> there is no conflict and we can just expose the UID under the "index"
> attribute whenever UID Uniqueness Checking is active and get systemd's
> interface naming support for free.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>

This seems like a nice solution to me.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 11 +++++---
>  arch/s390/pci/pci_sysfs.c               | 35 +++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 25c9c39770c6..1241b6d11a52 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -195,10 +195,13 @@ What:		/sys/bus/pci/devices/.../index
>  Date:		July 2010
>  Contact:	Narendra K <narendra_k@dell.com>, linux-bugs@dell.com
>  Description:
> -		Reading this attribute will provide the firmware
> -		given instance (SMBIOS type 41 device type instance) of the
> -		PCI device. The attribute will be created only if the firmware
> -		has given an instance number to the PCI device.
> +		Reading this attribute will provide the firmware given instance
> +		number of the PCI device.  Depending on the platform this can
> +		be for example the SMBIOS type 41 device type instance or the
> +		user-defined ID (UID) on s390. The attribute will be created
> +		only if the firmware has given an instance number to the PCI
> +		device and that number is guaranteed to uniquely identify the
> +		device in the system.
>  Users:
>  		Userspace applications interested in knowing the
>  		firmware assigned device type instance of the PCI
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index e14d346dafd6..20dbb2058d51 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -138,6 +138,38 @@ static ssize_t uid_is_unique_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(uid_is_unique);
>  
> +#ifndef CONFIG_DMI
> +/* analogous to smbios index */

I think this is smbios_attr_instance, right?  Maybe mention that
specifically to make it easier to match these up.

Looks like smbios_attr_instance and the similar ACPI stuff could use
some updating to use the current attribute group infrastructure.

> +static ssize_t index_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
> +	u32 index = ~0;
> +
> +	if (zpci_unique_uid)
> +		index = zdev->uid;
> +
> +	return sysfs_emit(buf, "%u\n", index);
> +}
> +static DEVICE_ATTR_RO(index);
> +
> +static umode_t zpci_unique_uids(struct kobject *kobj,
> +				struct attribute *attr, int n)
> +{
> +	return zpci_unique_uid ? attr->mode : 0;
> +}
> +
> +static struct attribute *zpci_ident_attrs[] = {
> +	&dev_attr_index.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group zpci_ident_attr_group = {
> +	.attrs = zpci_ident_attrs,
> +	.is_visible = zpci_unique_uids,

It's conventional to name these functions *_is_visible() (another
convention that smbios_attr_instance and acpi_attr_index probably
predate).

> +};
> +#endif
> +
>  static struct bin_attribute *zpci_bin_attrs[] = {
>  	&bin_attr_util_string,
>  	&bin_attr_report_error,
> @@ -179,5 +211,8 @@ static struct attribute_group pfip_attr_group = {
>  const struct attribute_group *zpci_attr_groups[] = {
>  	&zpci_attr_group,
>  	&pfip_attr_group,
> +#ifndef CONFIG_DMI
> +	&zpci_ident_attr_group,
> +#endif
>  	NULL,
>  };
> -- 
> 2.25.1
> 
