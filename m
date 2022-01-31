Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE84A4DA1
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiAaR53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 12:57:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4579 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiAaR53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 12:57:29 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnbJ40z1Mz67NTZ;
        Tue,  1 Feb 2022 01:52:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 18:57:27 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 17:57:26 +0000
Date:   Mon, 31 Jan 2022 17:57:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 23/40] cxl/core: Emit modalias for CXL devices
Message-ID: <20220131175720.00002ba2@Huawei.com>
In-Reply-To: <164298424120.3018233.15611905873808708542.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298424120.3018233.15611905873808708542.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sun, 23 Jan 2022 16:30:41 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In order to enable libkmod lookups for CXL device objects to their
> corresponding module, add 'modalias' to the base attribute of CXL
> devices.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
>  drivers/cxl/core/port.c                 |   26 +++++++++++++++++---------
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 0b6a2e6e8fbb..6d8cbf3355b5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -34,6 +34,15 @@ Description:
>  		the same value communicated in the DEVTYPE environment variable
>  		for uevents for devices on the "cxl" bus.
>  
> +What:		/sys/bus/cxl/devices/*/modalias
> +Date:		December, 2021
> +KernelVersion:	v5.18
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		CXL device objects export the modalias attribute which mirrors
> +		the same value communicated in the MODALIAS environment variable
> +		for uevents for devices on the "cxl" bus.
> +
>  What:		/sys/bus/cxl/devices/portX/uport
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 72633865b386..eede0bbe687a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,8 +34,25 @@ static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(devtype);
>  
> +static int cxl_device_id(struct device *dev)
> +{
> +	if (dev->type == &cxl_nvdimm_bridge_type)
> +		return CXL_DEVICE_NVDIMM_BRIDGE;
> +	if (dev->type == &cxl_nvdimm_type)
> +		return CXL_DEVICE_NVDIMM;
> +	return 0;
> +}
> +
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	return sysfs_emit(buf, CXL_MODALIAS_FMT "\n", cxl_device_id(dev));
> +}
> +static DEVICE_ATTR_RO(modalias);
> +
>  static struct attribute *cxl_base_attributes[] = {
>  	&dev_attr_devtype.attr,
> +	&dev_attr_modalias.attr,
>  	NULL,
>  };
>  
> @@ -845,15 +862,6 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_driver_unregister, CXL);
>  
> -static int cxl_device_id(struct device *dev)
> -{
> -	if (dev->type == &cxl_nvdimm_bridge_type)
> -		return CXL_DEVICE_NVDIMM_BRIDGE;
> -	if (dev->type == &cxl_nvdimm_type)
> -		return CXL_DEVICE_NVDIMM;
> -	return 0;
> -}
> -
>  static int cxl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	return add_uevent_var(env, "MODALIAS=" CXL_MODALIAS_FMT,
> 

