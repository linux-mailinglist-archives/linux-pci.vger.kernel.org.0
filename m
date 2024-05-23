Return-Path: <linux-pci+bounces-7777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4048CD12D
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 13:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF113B20A6C
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA51474AD;
	Thu, 23 May 2024 11:24:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2592746F;
	Thu, 23 May 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463496; cv=none; b=dHm0IK6hDdHKs82LGXaPgM7iycq+cQ3Pu3xU+NuLcxPq07InSqGi6ukGEy7Vu0H/+dDANgIQPadowWXSz3vBqKylEH2cMdMEOSPUf+/I6lGuD4nBSqQXANCJjnem4UHOzSYyxAE3KBm7slvMOULv9+NFGkCuuTO2lA4+s5Bw78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463496; c=relaxed/simple;
	bh=9oCPnoEK0F8amf19mXgQv1N9aGSecQA0Fcp9B4vLagg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPELTQpRZgFp3ZVtErJdsuWFR08wQUFiRHoqyEK3c2dSI73Rdq75fzP8q6cCNyM+ekd6c4oqfbOVOqxgbvm1xFValsQd8VQ02vY+z5dcFASk6YGJlBGppU3wnmhofQJlV5vZY6FSOUTH0yWKolpoGNED1IzZ0JrV7qMM9BhW6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlQmG4JD6z6K9Qj;
	Thu, 23 May 2024 19:23:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DE21B1408F9;
	Thu, 23 May 2024 19:24:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 12:24:49 +0100
Date: Thu, 23 May 2024 12:24:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v10 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240523122448.0000799f@Huawei.com>
In-Reply-To: <20240522101142.559733-3-alistair.francis@wdc.com>
References: <20240522101142.559733-1-alistair.francis@wdc.com>
	<20240522101142.559733-3-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 22 May 2024 20:11:41 +1000
Alistair Francis <alistair23@gmail.com> wrote:

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

What happens if multiple DOE which support the same protocol?
(IIRC that's allowed).  You probably need to paper over repeat
sysfs attributes and make sure they don't get double freed etc.

Otherwise some minor things inline.

Jonathan


> ---
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
>  Documentation/ABI/testing/sysfs-bus-pci |  28 ++++
>  drivers/pci/doe.c                       | 175 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |  13 ++
>  drivers/pci/pci.h                       |  10 ++
>  4 files changed, 226 insertions(+)
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
> index defc4be81bd4..7a20a257df5a 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -47,6 +47,7 @@
>   * @wq: Wait queue for work item
>   * @work_queue: Queue of pci_doe_work items
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
> + * @sysfs_attrs: Array of sysfs device attributes
>   */
>  struct pci_doe_mb {
>  	struct pci_dev *pdev;
> @@ -56,6 +57,10 @@ struct pci_doe_mb {
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
> @@ -92,6 +97,176 @@ struct pci_doe_task {
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
> +	NULL,

No comma needed on the null terminator as we'll never add anything after
it.

> +};
> +
> +static umode_t pci_doe_sysfs_attr_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	unsigned long vid, type;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry) {
> +			vid = xa_to_value(entry) >> 8;
> +			type = xa_to_value(entry) & 0xFF;
> +
> +			if (vid == 0x01 && type == 0x00) {
> +				/* This is the DOE discovery protocol
local comment syntax is the 
				/*
				 * This is the 
form so stick to that.


Shouldn't this also return a->mode for any case where the particular attribute
matches?  I guess is_visible() isn't called for late registered sysfs attributes
though I think it probably should be!

> +				 * Every DOE instance must support this, so we
> +				 * give it a useful name.
> +				 */
> +				return a->mode;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static bool pci_doe_sysfs_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry)
Is this simpler as
		if (!xa_empty(&doe_mb->feats))
			return true;

> +			return true;
> +	}
> +
> +	return false;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(pci_doe_sysfs)
> +
> +const struct attribute_group pci_doe_sysfs_group = {
> +	.name	    = "doe_features",
> +	.attrs	    = pci_doe_sysfs_feature_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_doe_sysfs),
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

I'm not particularly keen on using an index over the xa
just to get the number of elements for the loop limit.
Maybe just store that when you allocate attrs?

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
> +		if (vid == 0x01 && type == 0x00) {
> +			// DOE Discovery, manually displayed by `dev_attr_doe_discovery`

/* */ syntax.

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
> +			goto fail;

Repeated DOE 'features' on different DOE instances may cause this to fail.


> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +	return ret;
> +}

>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
>  {
>  	if (wait_event_timeout(doe_mb->wq,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa716392f..b5db191cb29f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/stat.h>
>  #include <linux/export.h>
>  #include <linux/topology.h>
> @@ -1143,6 +1144,9 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  {
>  	int i;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE))
> +		pci_doe_sysfs_teardown(pdev);
> +
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		struct bin_attribute *res_attr;
>  
> @@ -1227,6 +1231,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		retval = pci_doe_sysfs_init(pdev);
> +		if (retval)
> +			return retval;
> +	}
> +
>  	/* Expose the PCI resources from this device as files */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  
> @@ -1661,6 +1671,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +	&pci_doe_sysfs_group,
>  #endif
>  	NULL,
>  };



