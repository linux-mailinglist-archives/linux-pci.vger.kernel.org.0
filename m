Return-Path: <linux-pci+bounces-36361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF0B80CBC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61563484817
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB812F83DC;
	Wed, 17 Sep 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drdwd+W5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBD2F8BC0;
	Wed, 17 Sep 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124483; cv=none; b=X6lWBW9/9BNjOFKcqAXq7kXG9pTnIEx6g6+K3icHokLXHazkBoyk4dFYlPzrXGbUlz3pig5PNdjBnRJBuuJ0ncs7gxgWWVHzuae0/nQRVYC1q19nUOdQIsMbyFwDE4WfszLOe+82eQg5LnwjKJUhJgguOocOvlC8ITnJ7sMhIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124483; c=relaxed/simple;
	bh=UDKHns4guwmE2200coxrhQggpkGcWHj4hwrRJ5rsEI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bw5ekKdV4h4MAPonLvNBooIPUFoE/bD0gN/d4A3AVgaThdpNo81ITmztLAuAGiEarsjC6/cp45wRqbRyqnZadZe8sGioWnKD+E/jDbqgcK4rxeYf0OV0PWR+Nbk3zVAoup7zXR5F7PZaX6MdZwWSeBxZGPpRpZ04f+o4H/sU6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drdwd+W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F273C4CEE7;
	Wed, 17 Sep 2025 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124483;
	bh=UDKHns4guwmE2200coxrhQggpkGcWHj4hwrRJ5rsEI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Drdwd+W5gzmqxl1xkWNspWAoU2IvCPW7oQ94QP8fDtRmZvVrvKwQHLyoudTbeSGCs
	 ULvi7B753zcvTm8D8iBixG7Xzk82j2A5aGlKpjeKqHGIkOhWUe+Z1+/tsiC28UlDo8
	 Qgdq+z8u5tipp3Rov4aaTGW9SYw4b5DWB5ZWbKxMm+T+zO70AjnObiQYqhhptMB0dJ
	 05RgulLyqpejtYib26GdwDN1iCV2gx3rpBMvHVUzM5CdtQTmMqWr8Oi/c6qElIhgV2
	 GVS5TIg+N4rcGUFlBQJwD3QTBpIy45iLW2gFocfd7Hxl8XAoJkIE2sjXLTjuV/6XMq
	 l6S/yiBOB6n5Q==
Date: Wed, 17 Sep 2025 10:54:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Keith Busch <kbusch@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 1/1] PCI/sysfs: Expose PCI device serial number
Message-ID: <20250917155441.GA1854687@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917125815.722952-2-thepacketgeek@gmail.com>

On Wed, Sep 17, 2025 at 05:58:14AM -0700, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCI device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Applied to pci/misc for v6.18, thanks, and sorry for the inexcusable
delay.

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..92debe879ffb 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,12 @@ Description:
>  
>  		  # ls doe_features
>  		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../serial_number
> +Date:		December 2025
> +Contact:	Matthew Wood <thepacketgeek@gmail.com>
> +Description:
> +		This is visible only for PCI devices that support the serial
> +		number extended capability. The file is read only and due to
> +		the possible sensitivity of accessible serial numbers, admin
> +		only.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..b7b7412c9f00 100644
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
> @@ -694,6 +695,22 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(boot_vga);
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
>  static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>  			       const struct bin_attribute *bin_attr, char *buf,
>  			       loff_t off, size_t count)
> @@ -1698,6 +1715,7 @@ late_initcall(pci_sysfs_init);
>  
>  static struct attribute *pci_dev_dev_attrs[] = {
>  	&dev_attr_boot_vga.attr,
> +	&dev_attr_serial_number.attr,
>  	NULL,
>  };
>  
> @@ -1710,6 +1728,9 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>  	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>  		return a->mode;
>  
> +	if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
> +		return a->mode;
> +
>  	return 0;
>  }
>  
> -- 
> 2.50.1
> 

