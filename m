Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0CB7AEA54
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjIZK2W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjIZK2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 06:28:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638D10E;
        Tue, 26 Sep 2023 03:28:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvwqz6cQhz6D9CL;
        Tue, 26 Sep 2023 18:25:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 26 Sep
 2023 11:28:10 +0100
Date:   Tue, 26 Sep 2023 11:28:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alistair Francis <alistair23@gmail.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <lukas@wunner.de>, <alex.williamson@redhat.com>,
        <christian.koenig@amd.com>, <kch@nvidia.com>,
        <gregkh@linuxfoundation.org>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
        <rdunlap@infradead.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v8 2/3] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20230926112809.00000424@Huawei.com>
In-Reply-To: <20230921055531.2028834-2-alistair.francis@wdc.com>
References: <20230921055531.2028834-1-alistair.francis@wdc.com>
        <20230921055531.2028834-2-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Sep 2023 15:55:30 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the Discovery Data Object Protocol must be
> implemented. The protocol allows a requester to obtain information about
> the other DOE features supported by the device.
> 
> The kernel is already querying the DOE features supported and cacheing
> the values. This patch exposes the values via sysfs. This will allow
> userspace to determine which DOE features are supported by the PCIe
> device.
> 
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported features we can
> allow userspace to parse and support the list, which might include

Not sure what is meant by 'support' the list

> vendor specific features as well as yet to be supported features.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

A comment on the ABI docs, with that tidied up.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v8:
>  - Inlucde an example in the docs

Include

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
> This patch will create a doe_features directory for all
> PCIe devies. This should be fixed by a pending sysfs fixup
> patch.
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  23 +++++
>  drivers/pci/doe.c                       | 112 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |  10 +++
>  drivers/pci/pci.h                       |   3 +
>  include/linux/pci-doe.h                 |   1 +
>  5 files changed, 149 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..b52bb82a771e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,26 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_features
> +Date:		August 2023
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This directory contains a list of the supported
> +		Data Object Exchange (DOE) features. The feature values are in
> +		the file name. The contents of each file are the same as the
> +		name.
> +
> +		The value comes from the device and specifies the vendor and
> +		data object type supported. The lower byte is the data object
> +		type and the next two bytes are the vendor ID.

Lower byte doesn't obviously map to the format so I think this needs an update
to match the new format (which I think is good btw).

> +
> +		As all DOE devices must support the DOE discovery protocol, if
> +		DOE is supported you will at least see this file, with this
> +		contents
> +
> +		# cat doe_features/0x0001:00
> +		0x0001:00
> +
> +		If the device supports other protocols you will see other files
> +		as well.

Pretty odd to have one that just supports discovery, but I guess the spec
doesn't exclude that! :)

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 78ce79e031cd..30826462d167 100644
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
> @@ -92,6 +97,113 @@ struct pci_doe_task {
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> +#ifdef CONFIG_SYSFS
> +static umode_t pci_doe_sysfs_attr_is_visible(struct kobject *kobj,
> +					     struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry)
> +			return a->mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct attribute *pci_dev_doe_feature_attrs[] = {
> +	NULL,
> +};
> +
> +const struct attribute_group pci_dev_doe_feature_group = {
> +	.name	= "doe_features",
> +	.attrs	= pci_dev_doe_feature_attrs,
> +	.is_visible = pci_doe_sysfs_attr_is_visible,
> +};
> +
> +static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", attr->attr.name);
> +}
> +
> +static int pci_doe_sysfs_feature_supports(struct pci_dev *pdev,
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
> +		attrs[i].attr.name = kasprintf(GFP_KERNEL,
> +					       "0x%04lX:%02lX", vid, type);
> +		if (!attrs[i].attr.name) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		attrs[i].attr.mode = 0444;
> +		attrs[i].show = pci_doe_sysfs_feature_show;
> +
> +		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
> +					      pci_dev_doe_feature_group.name);
> +		if (ret) {
> +			attrs[i].show = NULL;
> +			goto fail;
> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	doe_mb->sysfs_attrs = NULL;
> +	xa_for_each(&doe_mb->feats, i, entry) {
> +		if (attrs[i].show)
> +			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr,
> +						     pci_dev_doe_feature_group.name);
> +		kfree(attrs[i].attr.name);
> +	}
> +
> +	kfree(attrs);
> +
> +	return ret;
> +}
> +
> +int doe_sysfs_init(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +	int ret;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		ret = pci_doe_sysfs_feature_supports(pdev, doe_mb);
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
> index d9eede2dbc0e..01bbd1f1cb9b 100644
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
> @@ -1230,6 +1231,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		retval = doe_sysfs_init(pdev);
> +		if (retval)
> +			return retval;
> +	}
> +
>  	/* Expose the PCI resources from this device as files */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  
> @@ -1655,6 +1662,9 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +	&pci_dev_doe_feature_group,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 39a8932dc340..b85dd83ddfcb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -186,6 +186,9 @@ extern const struct attribute_group *pci_dev_groups[];
>  extern const struct attribute_group *pcibus_groups[];
>  extern const struct device_type pci_dev_type;
>  extern const struct attribute_group *pci_bus_groups[];
> +#ifdef CONFIG_SYSFS
> +extern const struct attribute_group pci_dev_doe_feature_group;
> +#endif
>  
>  extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mmio_size;
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1f14aed4354b..4cc13d9ccb50 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -22,4 +22,5 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	    const void *request, size_t request_sz,
>  	    void *response, size_t response_sz);
>  
> +int doe_sysfs_init(struct pci_dev *pci_dev);
>  #endif

