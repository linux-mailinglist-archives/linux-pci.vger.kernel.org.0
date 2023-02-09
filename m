Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBE690D30
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBIPlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjBIPlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:41:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA425A91F;
        Thu,  9 Feb 2023 07:41:03 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLdf5Mccz6J9gH;
        Thu,  9 Feb 2023 23:39:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:41:00 +0000
Date:   Thu, 9 Feb 2023 15:41:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 18/18] cxl: Export sysfs attributes for device QTG IDs
Message-ID: <20230209154100.0000059d@Huawei.com>
In-Reply-To: <167571672370.587790.13206197631776290440.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571672370.587790.13206197631776290440.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Feb 2023 13:52:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Export qtg_id sysfs attributes for the respective ram and pmem DPA range of
> a CXL device. The QTG ID should show up as
> /sys/bus/cxl/devices/memX/pmem/qtg_id for pmem or as
> /sys/bus/cxl/devices/memX/ram/qtg_id for ram.

This doesn't extend to devices with say multiple DSMAS regions
for RAM with different access characteristics.  Think of a device
with HBM and DDR for example, or a mix of DDR4 and DDR5.

Once we are dealing with memory pools of significant size there
are very likely to be DPA regions with different characteristics.

So minimum I'd suggest is leave space for an ABI that might look like.

mem/range0_qtg_id
mem/range1_qtg_id
mem/range0_base
mem/range0_length
mem/range1_base
mem/range1_length
etc but with the flexibility to not present the rangeX_base/length stuff if there
is only one presented.  For now just present the range0_qtg_id

I'm fine if you want to implement multiple ranges from the start though.

As with previous ABI patch, I'd like to see a little description in the patch
header of what this stuff is for as well.  Obvious to some of us perhaps, but
better to call it out for anyone who is wondering why userspace needs to know.

I'm guessing you have a nice QEMU patch adding the DSM etc?

Thanks,

Jonathan


> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
>  drivers/cxl/core/memdev.c               |   26 ++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 0932c2f6fbf4..8133a13e118d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -27,6 +27,14 @@ Description:
>  		identically named field in the Identify Memory Device Output
>  		Payload in the CXL-2.0 specification.
>  
> +What:		/sys/bus/cxl/devices/memX/ram/qtg_id
> +Date:		January, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows calculated QoS Throttling Group ID for the
> +		"Volatile Only Capacity" DPA range.
> +
>  
>  What:		/sys/bus/cxl/devices/memX/pmem/size
>  Date:		December, 2020
> @@ -37,6 +45,13 @@ Description:
>  		identically named field in the Identify Memory Device Output
>  		Payload in the CXL-2.0 specification.
>  
> +What:		/sys/bus/cxl/devices/memX/pmem/qtg_id
> +Date:		January, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows calculated QoS Throttling Group ID for the
> +		"Persistent Only Capacity" DPA range.
>  
>  What:		/sys/bus/cxl/devices/memX/serial
>  Date:		January, 2022
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..06f9ac929ef4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -76,6 +76,18 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_ram_size =
>  	__ATTR(size, 0444, ram_size_show, NULL);
>  
> +static ssize_t ram_qtg_id_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return sysfs_emit(buf, "%d\n", cxlds->ram_qtg_id);
> +}
> +
> +static struct device_attribute dev_attr_ram_qtg_id =
> +	__ATTR(qtg_id, 0444, ram_qtg_id_show, NULL);
> +
>  static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> @@ -89,6 +101,18 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t pmem_qtg_id_show(struct device *dev, struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return sysfs_emit(buf, "%d\n", cxlds->pmem_qtg_id);
> +}
> +
> +static struct device_attribute dev_attr_pmem_qtg_id =
> +	__ATTR(qtg_id, 0444, pmem_qtg_id_show, NULL);
> +
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -117,11 +141,13 @@ static struct attribute *cxl_memdev_attributes[] = {
>  
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	&dev_attr_pmem_size.attr,
> +	&dev_attr_pmem_qtg_id.attr,
>  	NULL,
>  };
>  
>  static struct attribute *cxl_memdev_ram_attributes[] = {
>  	&dev_attr_ram_size.attr,
> +	&dev_attr_ram_qtg_id.attr,
>  	NULL,
>  };
>  
> 
> 

