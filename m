Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE63B4A4EA7
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 19:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbiAaSlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 13:41:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4587 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344176AbiAaSlf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 13:41:35 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JncMf0qsRz67Z4k;
        Tue,  1 Feb 2022 02:41:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 19:41:32 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 18:41:32 +0000
Date:   Mon, 31 Jan 2022 18:41:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
Message-ID: <20220131184126.00002a47@Huawei.com>
In-Reply-To: <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:31:24 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> While CXL memory targets will have their own memory target node,
> individual memory devices may be affinitized like other PCI devices.
> Emit that attribute for memdevs.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hmm. Is this just duplicating what we can get from
the PCI device?  It feels a bit like overkill to have it here
as well.

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

