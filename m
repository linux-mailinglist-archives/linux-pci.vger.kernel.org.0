Return-Path: <linux-pci+bounces-10075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06D92D2B9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04EA1F23710
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC60F190670;
	Wed, 10 Jul 2024 13:29:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780281DDC5;
	Wed, 10 Jul 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618148; cv=none; b=n69A/zIrL2kSl2ZWfCiOpnd5G+ryGKyTJaOdCOO521MeH0ur7iAxa6gCABsqNqlv/Oilp0JD3kq+20oWe6x2IbmaebAsPfjBOWBYv6V6X1I4zRaYfomtVAlhxgJTo7IwVuJgVASMzVyz4XFYLzbk+q3PvDyiWvAoyU3QTnpO3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618148; c=relaxed/simple;
	bh=kkkadeWsONCZ1GBao8ohHpL1p+uHMOC6ZOIwKVbElr8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu9zJ4RLlSYkxD6M5p5saaeUuY8t1dMbBl9L8w+4+uQ8MOM8kg80LS/nSlKQz+s4oLG6N3n3kZ8uF1uhzrpfP96SbNh69tvBwj5ozLpRY6S6lCE4KN95UInpfmXFAE53l9Rx/O6x435+ZaBVIFGXH9xtWgeKB+t/myI1lVCFcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WJzD35Ympz6K9J1;
	Wed, 10 Jul 2024 21:26:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A43901404F5;
	Wed, 10 Jul 2024 21:29:03 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Jul
 2024 14:29:03 +0100
Date: Wed, 10 Jul 2024 14:29:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v14 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240710142902.00002e1f@Huawei.com>
In-Reply-To: <20240710023310.480713-3-alistair.francis@wdc.com>
References: <20240710023310.480713-1-alistair.francis@wdc.com>
	<20240710023310.480713-3-alistair.francis@wdc.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jul 2024 12:33:09 +1000
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v14:
>  - Revert back to v12 with extra pci_remove_resource_files() call
You should probably document why here given there isn't a cover letter
to do so in.

J

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
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  28 +++++
>  drivers/pci/doe.c                       | 151 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |  15 +++
>  drivers/pci/pci.h                       |  10 ++
>  4 files changed, 204 insertions(+)
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
> index defc4be81bd4..580370dc71ee 100644
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
> @@ -92,6 +98,151 @@ struct pci_doe_task {
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
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		if (!xa_empty(&doe_mb->feats))
> +			return true;
> +	}
> +
> +	return false;
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
> +		if (vid == 0x01 && type == 0x00) {
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
> index 40cfa716392f..db795bfe3c56 100644
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
> @@ -1227,6 +1231,14 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		retval = pci_doe_sysfs_init(pdev);
> +		if (retval) {
> +			pci_remove_resource_files(pdev);
> +			return retval;
> +		}
> +	}
> +
>  	/* Expose the PCI resources from this device as files */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  
> @@ -1661,6 +1673,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
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
> index fd44565c4756..3aee231dcb0c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -189,6 +189,7 @@ extern const struct attribute_group *pci_dev_groups[];
>  extern const struct attribute_group *pci_dev_attr_groups[];
>  extern const struct attribute_group *pcibus_groups[];
>  extern const struct attribute_group *pci_bus_groups[];
> +extern const struct attribute_group pci_doe_sysfs_group;
>  #else
>  static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { return 0; }
>  static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> @@ -196,6 +197,7 @@ static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
>  #define pci_dev_attr_groups NULL
>  #define pcibus_groups NULL
>  #define pci_bus_groups NULL
> +#define pci_doe_sysfs_group NULL
>  #endif
>  
>  extern unsigned long pci_hotplug_io_size;
> @@ -333,6 +335,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
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


