Return-Path: <linux-pci+bounces-11417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B094A267
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E321C210B7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189591B86C9;
	Wed,  7 Aug 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpkntykU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB12868D;
	Wed,  7 Aug 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018209; cv=none; b=n/rY4Wb7AUq6p4p1wEFEX2y79Y2tD06TIqRpsFDJDieqBj5JmzH3W6dtA2rHSIJ54qNm68OMfrEAU0GifyzcnM9aJWAWaP7nIWOK2TnB5XwFGBafH43eqSKJf+M/Z4iJCR+uuSl376ogIT1YSUfwXQfx7TGKWkdKoRAQz3bBYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018209; c=relaxed/simple;
	bh=ymqHAsY7L7uq7XkEXwcb1EIBPp1h1Nl5RXvVECKxScw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tVJM4jaImK9PPvIhwGe7K6BuEbrH9FcmxTZLpUVzgVWjwzBf7s9pTISfNag8Y7Iz3Q6SQH1UxxLUV2Xyfc8LAo3XzmPJA+xNE98qplx8jsBHl3kmVJqIGcQraxcGm+hIo03ZtIsiHM1RLyypJD9OsmADyrCMP3YqPFuiXJvXP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpkntykU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723018208; x=1754554208;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ymqHAsY7L7uq7XkEXwcb1EIBPp1h1Nl5RXvVECKxScw=;
  b=lpkntykUqgcNC1KNufTtKIFPMKoM3iTV/iBSudAtAhc7b5ngBbE2Q9Qa
   zdgEVJEizKrWH69AjpBRB1uVqnPTTBhg3f1peE3ecLEo35yMwhgsR3xcU
   SRCnROMhhRy1XWZMaiD2vlnO0xPq5ofRnnWKMFcm8gJpMiZajMatA6keM
   +Z4WBIS4fPD7ShOtzIcJgKqP2q+xlnSOVduhgO5ozL+bHHa5/xxOanuH2
   AUnT/OIiOUSEch3s45JwSiD+jAL/GONIu10i7sjENuBjRcErB6RvOO+dt
   ZOWzorYSVedk3/XnpwE7S97wNrDzD2BJ+lIugKihzYF8v6vLPycuWnE91
   A==;
X-CSE-ConnectionGUID: YIeb8gEvQbyvPqRK7ALjaQ==
X-CSE-MsgGUID: Ht6304iwR0KAbSuBYlnGlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21217102"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21217102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 01:10:07 -0700
X-CSE-ConnectionGUID: vIul3v5xSo2qDo0qfCfnzA==
X-CSE-MsgGUID: jy1CT7RpQ++pbYqYhSXsVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61596318"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 01:10:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Aug 2024 11:09:57 +0300 (EEST)
To: Alistair Francis <alistair23@gmail.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    Jonathan.Cameron@huawei.com, Lukas Wunner <lukas@wunner.de>, 
    alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, logang@deltatee.com, 
    LKML <linux-kernel@vger.kernel.org>, chaitanyak@nvidia.com, 
    rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v15 3/4] PCI/DOE: Expose the DOE features via sysfs
In-Reply-To: <20240806230118.1332763-3-alistair.francis@wdc.com>
Message-ID: <f6e5dcda-76a0-10f5-a370-2d27b0ed76b6@linux.intel.com>
References: <20240806230118.1332763-1-alistair.francis@wdc.com> <20240806230118.1332763-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Aug 2024, Alistair Francis wrote:

> The PCIe 6 specification added support for the Data Object
> Exchange (DOE).
> When DOE is supported the DOE Discovery Feature must be implemented per
> PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> information about the other DOE features supported by the device.
> 
> The kernel is already querying the DOE features supported and cacheing
> the values. Expose the values in sysfs to allow user space to
> determine which DOE features are supported by the PCIe device.
> 
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported features we can
> allow userspace to parse the list, which might include
> vendor specific features as well as yet to be supported features.
> 
> As the DOE Discovery feature must always be supported we treat it as a
> special named attribute case. This allows the usual PCI attribute_group
> handling to correctly create the doe_features directory when registering
> pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
> will seg fault).
> 
> After this patch is supported you can see something like this when
> attaching a DOE device
> 
> $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> 0001:01        0001:02        doe_discovery
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Using dev->groups and device_add() path as discussed earlier [1]
> doesn't work nicley as the pci_doe_sysfs_group is global.
> 
> We end up needing to create a per device instance of dev->groups
> that is dynamically modified at init and appended to pci_dev_attr_groups.
> 
> Something similar to:
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-core.c#L2029
> except in this case groups is already assigned.
> 
> It's complex and doesn't provide any advantages compared to the approach
> in this patch, where we can just use sysfs_add_file_to_group() to add
> the sysfs attributes. This aligns with other PCIe DOE related sysfs
> patches, such as [2]
> 
> 1: https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
> 2: https://lore.kernel.org/all/77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de/
> 
> v15:
>  - Move init/teardown from pci_{create,remove}_resource_files()
>  - Remove `if (IS_ENABLED(CONFIG_PCI_DOE))` checks
> v14:
>  - Revert back to v12 with extra pci_remove_resource_files() call
> v13:
>  - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
>      - As discussed in https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
>        we can just modify pci_doe_sysfs_group at the DOE init and let
>        device_add() handle the sysfs attributes.
> v12:
>  - Drop pci_doe_features_sysfs_attr_visible()
> v11:
>  - Gracefully handle multiple entried of same feature
>  - Minor fixes and code cleanups
> v10:
>  - Rebase to use DEFINE_SYSFS_GROUP_VISIBLE and remove
>    special setup function
> v9:
>  - Add a teardown function
>  - Rename functions to be clearer
>  - Tidy up the commit message
>  - Remove #ifdef from header
> v8:
>  - Inlucde an example in the docs
>  - Fixup removing a file that wasn't added
>  - Remove a blank line
> v7:
>  - Fixup the #ifdefs to keep the test robot happy
> v6:
>  - Use "feature" instead of protocol
>  - Don't use any devm_* functions
>  - Add two more patches to the series
> v5:
>  - Return the file name as the file contents
>  - Code cleanups and simplifications
> v4:
>  - Fixup typos in the documentation
>  - Make it clear that the file names contain the information
>  - Small code cleanups
>  - Remove most #ifdefs
>  - Remove extra NULL assignment
> v3:
>  - Expose each DOE feature as a separate file
> v2:
>  - Add documentation
>  - Code cleanups
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  28 +++++
>  drivers/pci/doe.c                       | 144 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |   3 +
>  drivers/pci/pci.h                       |   9 ++
>  drivers/pci/probe.c                     |   3 +
>  drivers/pci/remove.c                    |   2 +
>  6 files changed, 189 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..65a3238ab701 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,31 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_features
> +Date:		May 2024
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This directory contains a list of the supported
> +		Data Object Exchange (DOE) features. The features are
> +		the file name. The contents of each file is the raw vendor id and
> +		data object feature values.
> +
> +		The value comes from the device and specifies the vendor and
> +		data object type supported. The lower (RHS of the colon) is
> +		the data object type in hex. The upper (LHS of the colon)
> +		is the vendor ID.
> +
> +		As all DOE devices must support the DOE discovery protocol, if
> +		DOE is supported you will at least see the doe_discovery file, with
> +		this contents
> +
> +		# cat doe_features/doe_discovery
> +		0001:00
> +
> +		If the device supports other protocols you will see other files
> +		as well. For example is CMA/SPDM and secure CMA/SPDM are supported
> +		the doe_features directory will look like this
> +
> +		# ls doe_features
> +		0001:01        0001:02        doe_discovery
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index defc4be81bd4..c0e1ed3bddfb 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -14,6 +14,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>

+ #include <linux/sysfs.h>

-- 
 i.

> @@ -47,6 +48,7 @@
>   * @wq: Wait queue for work item
>   * @work_queue: Queue of pci_doe_work items
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
> + * @sysfs_attrs: Array of sysfs device attributes
>   */
>  struct pci_doe_mb {
>  	struct pci_dev *pdev;
> @@ -56,6 +58,10 @@ struct pci_doe_mb {
>  	wait_queue_head_t wq;
>  	struct workqueue_struct *work_queue;
>  	unsigned long flags;
> +
> +#ifdef CONFIG_SYSFS
> +	struct device_attribute *sysfs_attrs;
> +#endif
>  };
>  
>  struct pci_doe_feature {
> @@ -92,6 +98,144 @@ struct pci_doe_task {
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> +#ifdef CONFIG_SYSFS
> +static ssize_t doe_discovery_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	return sysfs_emit(buf, "0001:00\n");
> +}
> +DEVICE_ATTR_RO(doe_discovery);
> +
> +static struct attribute *pci_doe_sysfs_feature_attrs[] = {
> +	&dev_attr_doe_discovery.attr,
> +	NULL
> +};
> +
> +static bool pci_doe_features_sysfs_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return !xa_empty(&pdev->doe_mbs);
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
> +
> +const struct attribute_group pci_doe_sysfs_group = {
> +	.name	    = "doe_features",
> +	.attrs	    = pci_doe_sysfs_feature_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs),
> +};
> +
> +static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", attr->attr.name);
> +}
> +
> +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> +					 struct pci_doe_mb *doe_mb)
> +{
> +	struct device_attribute *attrs = doe_mb->sysfs_attrs;
> +	struct device *dev = &pdev->dev;
> +	unsigned long i;
> +	void *entry;
> +
> +	if (!attrs)
> +		return;
> +
> +	doe_mb->sysfs_attrs = NULL;
> +	xa_for_each(&doe_mb->feats, i, entry) {
> +		if (attrs[i].show)
> +			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
> +						     pci_doe_sysfs_group.name);
> +		kfree(attrs[i].attr.name);
> +	}
> +	kfree(attrs);
> +}
> +
> +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> +					  struct pci_doe_mb *doe_mb)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_attribute *attrs;
> +	unsigned long num_features = 0;
> +	unsigned long vid, type;
> +	unsigned long i;
> +	void *entry;
> +	int ret;
> +
> +	xa_for_each(&doe_mb->feats, i, entry)
> +		num_features++;
> +
> +	attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	doe_mb->sysfs_attrs = attrs;
> +	xa_for_each(&doe_mb->feats, i, entry) {
> +		sysfs_attr_init(&attrs[i].attr);
> +		vid = xa_to_value(entry) >> 8;
> +		type = xa_to_value(entry) & 0xFF;
> +
> +		if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_FEATURE_DISCOVERY) {
> +			/* DOE Discovery, manually displayed by `dev_attr_doe_discovery` */
> +			continue;
> +		}
> +
> +		attrs[i].attr.name = kasprintf(GFP_KERNEL,
> +					       "%04lx:%02lx", vid, type);
> +		if (!attrs[i].attr.name) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		attrs[i].attr.mode = 0444;
> +		attrs[i].show = pci_doe_sysfs_feature_show;
> +
> +		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
> +					      pci_doe_sysfs_group.name);
> +		if (ret) {
> +			attrs[i].show = NULL;
> +			if (ret != -EEXIST)
> +				goto fail;
> +			else
> +				kfree(attrs[i].attr.name);
> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +	return ret;
> +}
> +
> +void pci_doe_sysfs_teardown(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +}
> +
> +int pci_doe_sysfs_init(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +	int ret;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		ret = pci_doe_sysfs_feature_populate(pdev, doe_mb);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
>  {
>  	if (wait_event_timeout(doe_mb->wq,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa716392f..eeda0c650537 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1661,6 +1661,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +	&pci_doe_sysfs_group,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 79c8398f3938..abac97efc8fc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -232,6 +232,7 @@ extern const struct attribute_group *pci_dev_groups[];
>  extern const struct attribute_group *pci_dev_attr_groups[];
>  extern const struct attribute_group *pcibus_groups[];
>  extern const struct attribute_group *pci_bus_groups[];
> +extern const struct attribute_group pci_doe_sysfs_group;
>  #else
>  static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
>  static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> @@ -398,6 +399,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
> +int pci_doe_sysfs_init(struct pci_dev *pci_dev);
> +void pci_doe_sysfs_teardown(struct pci_dev *pdev);
> +#else
> +static inline int pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
> +static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
> +#endif
> +
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..2bdb4fe37dbc 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2593,6 +2593,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->match_driver = false;
>  	ret = device_add(&dev->dev);
>  	WARN_ON(ret < 0);
> +
> +	ret = pci_doe_sysfs_init(dev);
> +	WARN_ON(ret < 0);
>  }
>  
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 910387e5bdbf..d1e0bed53acb 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -34,6 +34,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	if (!dev->dev.kobj.parent)
>  		return;
>  
> +	pci_doe_sysfs_teardown(dev);
> +
>  	device_del(&dev->dev);
>  
>  	down_write(&pci_bus_sem);
> 

