Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155FA7784BB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 03:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHKBED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 21:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKBED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 21:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0E12724;
        Thu, 10 Aug 2023 18:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE8F64937;
        Fri, 11 Aug 2023 01:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B85BC433C7;
        Fri, 11 Aug 2023 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691715841;
        bh=/Epzvw0JtUO8GOOQbFQtIu5UKvQ2tn7Fi6fQXEErzUI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FdeikvB+xSNjiKTZk4OPBUUMThtZElJUhYA/AlJJRDjrGe0I/26lNfir95VgLs45L
         4Zs5aiVndYX5Mr7Zj89+EKu8kPHwEGjOZO+DDaBN4qju0CrBhLkWcvqOA2xkiIM6z7
         lYfSn1K0XQ/vix/HGv0aQEWbJ5pBTwIRGYV6O/461Ld4Bq/plNIGxij8imJKdpRi3S
         BphIYG6HRfuRryafAe4lW8gbGHys9aZ8LJVqRl2lixN2BX6DYG0sfgCw01jCTOFSVv
         vjejUXF2SSB318Efe7aqz2XEWeCu6ffqjq8Agn2fsvPuBaFuTgO+m4roDqdLfB5kHn
         dBCTbdiMQaU+w==
Message-ID: <b3d437f5-fe33-4677-e336-a67ac9b8d477@kernel.org>
Date:   Fri, 11 Aug 2023 10:03:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI/DOE: Expose the DOE protocols via sysfs
Content-Language: en-US
To:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
References: <20230810163342.1059509-1-alistair.francis@wdc.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230810163342.1059509-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/11/23 01:33, Alistair Francis wrote:
> The PCIe 6 specification added support for the Data Object Exchange (DOE).
> When DOE is supported the Discovery Data Object Protocol must be
> implemented. The protocol allows a requester to obtain information about
> the other DOE protocols supported by the device.
> 
> The kernel is already querying the DOE protocols supported and cacheing
> the values. This patch exposes the values via sysfs. This will allow
> userspace to determine which DOE protocols are supported by the PCIe
> device.
> 
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported protocols we can
> allow userspace to parse and support the list, which might include
> vendor specific protocols as well as yet to be supported protocols.
> 
> Each DOE feature is exposed as a single file. The files are empty and
> the information is contained in the file name.

s/feature/protocol ?

Personally, I would still have each file content repeat the same information as
the file name specifies. That is, file value == file name. That will avoid
people getting confused as empty sysfs files are rather uncommon.

> 
> This uses pci_sysfs_init() instead of the ->is_visible() function as
> is_visible only applies to the attributes under the group. Which
> means that every PCIe device will see a `doe_protos` directory, no
> matter if DOE is supported at all on the device.
> 
> On top of that ->is_visible() is only called
> (fs/sysfs/group.c:create_files()) if there are sub attrs, which we
> don't necessary have. There are no static attrs, instead they are
> all generated dynamically.

You said that the kernel caches the protocols supported. So it should not be
hard to allocate one attribute for each of the supported protocols when these
are discovered, no ?

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
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
> We did talk about exposing DOE types under DOE vendor IDs, but I couldn't
> figure out a simple way to do that
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  10 +++
>  drivers/pci/doe.c                       | 104 ++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c                 |   7 ++
>  include/linux/pci-doe.h                 |   1 +
>  4 files changed, 122 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..e09c51449284 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,13 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../doe_protos
> +Date:		August 2023
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		This directory contains a list of the supported Data Object Exchange (DOE)
> +		features. The feature values are in the file name; the files have no contents.
> +		The value comes from the device and specifies the vendor and
> +		data object type supported. The lower byte is the data object type and the next
> +		two bytes are the vendor ID.
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 1b97a5ab71a9..918872152fb6 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -56,6 +56,8 @@ struct pci_doe_mb {
>  	wait_queue_head_t wq;
>  	struct workqueue_struct *work_queue;
>  	unsigned long flags;
> +
> +	struct device_attribute *sysfs_attrs;
>  };
>  
>  struct pci_doe_protocol {
> @@ -92,6 +94,108 @@ struct pci_doe_task {
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> +#ifdef CONFIG_SYSFS
> +static struct attribute *pci_dev_doe_proto_attrs[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group pci_dev_doe_proto_group = {
> +	.name	= "doe_protos",

Why is this a static variable instead of being a member of the pci doe_mb struct
?d Devices without DOE support would always have that as NULL and only the
devices that support it would get the group and array of attributes that you
allocate in pci_doe_sysfs_proto_supports(). That would also remove the need for
the attrs array being a static variable as well.

An let's spell things out to be clear and avoid confusions: s/protos/protocols

> +	.attrs	= pci_dev_doe_proto_attrs,
> +};
> +
> +static void pci_doe_sysfs_remove_desc(struct pci_doe_mb *doe_mb)
> +{
> +	struct device_attribute *attrs = doe_mb->sysfs_attrs;
> +	unsigned long i;
> +	void *entry;
> +
> +	if (!doe_mb->sysfs_attrs)
> +		return;
> +
> +	doe_mb->sysfs_attrs = NULL;
> +	xa_for_each(&doe_mb->prots, i, entry)
> +		kfree(attrs[i].attr.name);
> +
> +	kfree(attrs);
> +}
> +
> +static int pci_doe_sysfs_proto_supports(struct pci_dev *pdev, struct pci_doe_mb *doe_mb)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_attribute *attrs;
> +	unsigned long num_protos = 0;
> +	unsigned long vid, type;
> +	unsigned long i;
> +	void *entry;
> +	int ret;
> +
> +	xa_for_each(&doe_mb->prots, i, entry)
> +		num_protos++;
> +
> +	attrs = kcalloc(num_protos, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	doe_mb->sysfs_attrs = attrs;
> +	xa_for_each(&doe_mb->prots, i, entry) {
> +		sysfs_attr_init(&attrs[i].attr);
> +		vid = xa_to_value(entry) >> 8;
> +		type = xa_to_value(entry) & 0xFF;
> +		attrs[i].attr.name = kasprintf(GFP_KERNEL, "0x%04lX:%02lX", vid, type);
> +		if (!attrs[i].attr.name) {
> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		attrs[i].attr.mode = 0444;
> +
> +		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr,
> +					      pci_dev_doe_proto_group.name);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	pci_doe_sysfs_remove_desc(doe_mb);
> +	return ret;
> +}
> +
> +int doe_sysfs_init(struct pci_dev *pdev)
> +{
> +	unsigned long total_protos = 0;
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	void *entry;
> +	int ret;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->prots, j, entry)
> +			total_protos++;
> +	}
> +
> +	if (total_protos == 0)
> +		return 0;
> +
> +	ret = devm_device_add_group(&pdev->dev, &pci_dev_doe_proto_group);
> +	if (ret) {
> +		pci_err(pdev, "can't create DOE goup: %d\n", ret);
> +		return ret;
> +	}
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		ret = pci_doe_sysfs_proto_supports(pdev, doe_mb);
> +

Remove this blank line.

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
> index ab32a91f287b..ad621850a3e2 100644
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
> @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
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

-- 
Damien Le Moal
Western Digital Research

