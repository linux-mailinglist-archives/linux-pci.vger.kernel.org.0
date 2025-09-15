Return-Path: <linux-pci+bounces-36199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC48B5856B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DD31B22563
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE0280335;
	Mon, 15 Sep 2025 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqLUXKqq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6627E066;
	Mon, 15 Sep 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965146; cv=none; b=d5h8jCfIIc0BWA76v2ZD/zBpp34xzzRui49JovjyVQOW0vUAAMQBiKNLTSd1G6RQ3Iq/BVVrhhsECfEr3J5Z9O1xNwxxcXUgLp86rZtjafqtF3PTq4FjwtLSQzr8YLUox15N8rmXcRAlVgr5wW1uHWw7m6LIuYdSe/hD/wB0m1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965146; c=relaxed/simple;
	bh=veOCWn8AHbAgpZeNGt7sgqCJXZEPk4NeYew/a7ak3EU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p8EL148R88JGwsylBPGLD6DHvytTVzzF6GE9wMk9W0FK/5hg0icgmsjB48PEF+6H2LWR4sLU+r7XS0Je6QLRuO67rdkRIf/N1Ze8hLEHmOkTQmC8SUTK56vJsP8dnyDLkfu78+G1HstGJGl+NktXOM73wGnELqzZAicR4/kddQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqLUXKqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E633C4CEF7;
	Mon, 15 Sep 2025 19:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757965145;
	bh=veOCWn8AHbAgpZeNGt7sgqCJXZEPk4NeYew/a7ak3EU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BqLUXKqqUVU/mW0lRlskT+Jfpq4jjmyHkgmQaXRTdzRbzXx2wDPiEevNdQF5X2/jA
	 Pw8mYEUHxKOqVsvYu+V5c8l1+hfMh3o7iA85BV29r/QofMw87YV2kweV0/A+604pH4
	 9SN7FglmR0UXaqp10fSHT06NddUeePw8utcIIh3C+qye43Lh3+dBQQaiP1K1btsYX2
	 mPHyhPY5IZtLa9EUUQTn/OJt/gvabTwwDOpi151rf7rXgfG0U6UhvIj7SSgyjARJ5x
	 defBnpt8wQYMpOrcaPrG+/95AgH0LJAbo9ykVpYNNzT6hm1BpvDv/gEN7wcSbK6ZOh
	 Khu7ATQDKUypA==
Date: Mon, 15 Sep 2025 14:39:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250915193904.GA1756590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821232239.599523-2-thepacketgeek@gmail.com>

On Thu, Aug 21, 2025 at 04:22:38PM -0700, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Sorry for the delay, I have no excuse.

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..d5251f4f3659 100644
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

I can see that the PCI r3.0 (conventional PCI) spec doesn't include
the Device Serial Number Capability and the PCIe spec does include it,
but this seems like it would fit better in the pci_dev_dev_attrs[],
and the visibility check would be parallel to the
dev_attr_boot_vga.attr check there.

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
> -- 
> 2.50.1
> 

