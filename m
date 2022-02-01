Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E84A602E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 16:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiBAPb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 10:31:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:60430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbiBAPb4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 10:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729516; x=1675265516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2YQX+1pMX3xBqiCCvoSHrWYs7DOA65rdAvLn4EkaPAA=;
  b=QF4y6VswXT2TeM0ewmXMjvvE05/q84d8bhXIQyxj2YNzGpv36zGN9gUU
   yROwl6hd1/LJCIuMcMQ2v92nn14r4FDQ3lDERq0MSlx1f686XEnb327Ke
   6EMtQnITWP/rbFj0t0949JYUxrTZ+bWg69omDnJtxJhQOD/tygbPtB+g5
   gi0AgToZ5zFyr+2McZO8zCxre9/dWRUpal4+UdXPzIMY0efOUCEv1Iqja
   tC7eOzjlByVENWmifq1MLwnP2ZFyVCum8wT4ZMAGCD5JFwgJQ4p7ch7Dk
   cISEW2zLEpFGnhd1Kn+6PDjbaGtm8lk84/9ObR2WnRkxYz8UDkb2DpwAq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235108638"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="235108638"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:31:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="676113907"
Received: from rashmigh-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.8])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:31:55 -0800
Date:   Tue, 1 Feb 2022 07:31:54 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
Message-ID: <20220201153154.jpyxayuulbhdran4@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:31:24, Dan Williams wrote:
> While CXL memory targets will have their own memory target node,
> individual memory devices may be affinitized like other PCI devices.
> Emit that attribute for memdevs.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This brings up an interesting question. Are all devices in a region affinitized
to the same NUMA node? I think they must be - at which point, should this
attribute be a part of a region, rather than a device?

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
>  drivers/cxl/core/memdev.c               |   17 +++++++++++++++++
>  tools/testing/cxl/test/cxl.c            |    1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 87c0e5e65322..0b51cfec0c66 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -34,6 +34,15 @@ Description:
>  		capability. Mandatory for CXL devices, see CXL 2.0 8.1.12.2
>  		Memory Device PCIe Capabilities and Extended Capabilities.
>  
> +What:		/sys/bus/cxl/devices/memX/numa_node
> +Date:		January, 2022
> +KernelVersion:	v5.18
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) If NUMA is enabled and the platform has affinitized the
> +		host PCI device for this memory device, emit the CPU node
> +		affinity for this device.
> +

I think you'd want to say something about the device actively decoding. Perhaps
I'm mistaken though, can you affinitize without setting up HDM decoders for the
device?

>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 1e574b052583..b2773664e407 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -99,11 +99,19 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(serial);
>  
> +static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return sprintf(buf, "%d\n", dev_to_node(dev));
> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
> +	&dev_attr_numa_node.attr,
>  	NULL,
>  };
>  
> @@ -117,8 +125,17 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>  	NULL,
>  };
>  
> +static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> +				  int n)
> +{
> +	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> +		return 0;
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_attribute_group = {
>  	.attrs = cxl_memdev_attributes,
> +	.is_visible = cxl_memdev_visible,
>  };
>  
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 40ed567952e6..cd2f20f2707f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -583,6 +583,7 @@ static __init int cxl_test_init(void)
>  		if (!pdev)
>  			goto err_mem;
>  		pdev->dev.parent = &port->dev;
> +		set_dev_node(&pdev->dev, i % 2);
>  
>  		rc = platform_device_add(pdev);
>  		if (rc) {
> 
