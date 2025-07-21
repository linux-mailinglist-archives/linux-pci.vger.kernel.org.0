Return-Path: <linux-pci+bounces-32634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92458B0C0B5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF1A3AE96E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3B289829;
	Mon, 21 Jul 2025 09:53:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97730F4F1;
	Mon, 21 Jul 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091589; cv=none; b=ZkSgulSO7IDr/gIAh1VdWplVs9o1i1NYvXDL8PjD7Tf59F9416QrSEO5UU2GgQkOSDdkMBEaVLPyORHIDK/mx/c4L6/LFOKOBjW/+IGYTJJ1nkpVjKld1D8al3peenAiGUMJDJb2WoHM2CXZSG2xVPsRUMURGyv4ZdIgSiIp6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091589; c=relaxed/simple;
	bh=FFvlK0A7d9z6/UpnxJza7La1KKU1yiK7fz/LcmFq++4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fw3Y++YW1PVs6/W636BoQa51DSlD/gglu5ZlX8zBv0qgD+SBYhOSx3DPYW3LlF2Nx5lpfUVEAeROQ4W870xSoeoA4nNPodVZnMnPzmp3l+X4oxNguwGtp2snLTN8XqeQcdwihYUraGYzk044alUO5b0NvrVHrfU/n0AuV20VUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blwf54cvTz6M4wD;
	Mon, 21 Jul 2025 17:51:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C929C140279;
	Mon, 21 Jul 2025 17:53:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 11:53:03 +0200
Date: Mon, 21 Jul 2025 10:53:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matthew Wood <thepacketgeek@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello
	<superm1@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	<thomas.weissschuh@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250721105302.0000618d@huawei.com>
In-Reply-To: <20250718193230.300055-2-thepacketgeek@gmail.com>
References: <20250718193230.300055-1-thepacketgeek@gmail.com>
	<20250718193230.300055-2-thepacketgeek@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Jul 2025 12:32:29 -0700
Matthew Wood <thepacketgeek@gmail.com> wrote:

> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>

Nice. The %8phD that Thomas pointed out was new to me. Very useful!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..0a2580cdd58c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,12 @@ Description:
>  
>  		  # ls doe_features
>  		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../serial_number
> +Date:		October 2025
> +Contact:	Matthew Wood <thepacketgeek@gmail.com>
> +Description:
> +		This is visible only for PCIe devices that support the serial
> +		number extended capability. The file is read only and due to
> +		the possible sensitivity of accessible serial numbers, admin
> +		only.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..1d26e4336f1b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -30,6 +30,7 @@
>  #include <linux/msi.h>
>  #include <linux/of.h>
>  #include <linux/aperture.h>
> +#include <linux/unaligned.h>
>  #include "pci.h"
>  
>  #ifndef ARCH_PCI_DEV_GROUPS
> @@ -239,6 +240,22 @@ static ssize_t current_link_width_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(current_link_width);
>  
> +static ssize_t serial_number_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u64 dsn;
> +	u8 bytes[8];
> +
> +	dsn = pci_get_dsn(pci_dev);
> +	if (!dsn)
> +		return -EIO;
> +	put_unaligned_be64(dsn, bytes);
> +
> +	return sysfs_emit(buf, "%8phD\n", bytes);
> +}
> +static DEVICE_ATTR_ADMIN_RO(serial_number);
> +
>  static ssize_t secondary_bus_number_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -660,6 +677,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  	&dev_attr_current_link_width.attr,
>  	&dev_attr_max_link_width.attr,
>  	&dev_attr_max_link_speed.attr,
> +	&dev_attr_serial_number.attr,
>  	NULL,
>  };
>  
> @@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (pci_is_pcie(pdev))
> -		return a->mode;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
>  
> -	return 0;
> +	if (a == &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> +		return 0;
> +
> +	return a->mode;
>  }
>  
>  static const struct attribute_group pci_dev_group = {


