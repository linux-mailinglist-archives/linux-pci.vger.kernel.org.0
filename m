Return-Path: <linux-pci+bounces-32413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1BCB091E2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78531C44C2E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D02FCE07;
	Thu, 17 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB/yJJZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2412FBFE9;
	Thu, 17 Jul 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769745; cv=none; b=vBzkwW1+k6SfIiPhyv434Dob5wQ9ac0HjELSFCzDBUxHw1vJzNAeVK1FDJ0/Z8Q7cBuPnIx4OuifksZ3D0c8RFNHhnzSCcyLURW4fn76Z+BxOpU61b9NE/egTiaHq0rdEtP+mm2ErhqGJqfx4cChemm03Mcbk+4attnKr84zCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769745; c=relaxed/simple;
	bh=aZF1ATdJMr1PS2dVQ/dXpHcgfoJwBOuwhpzYqVEDeUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umUSQdHOGofJHYtWYblQeFp1fPEzwMCV0nPIrmQ8yEm2zWnsjGfhxLgsTy3uQKJHG5nSeCPSyu/SXUMIft0gfMVnf8DazPBAC+oC0//ItS0CXlgaduF0hjTCgGH+rcrNVMydQ4pgTG6lR9FWeCPY97yUObQa4vde1LlwBbALXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB/yJJZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1AFC4CEE3;
	Thu, 17 Jul 2025 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769744;
	bh=aZF1ATdJMr1PS2dVQ/dXpHcgfoJwBOuwhpzYqVEDeUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EB/yJJZwqhIqCgtStaaxbPgeBRQD37uzZp7GLCrsDl8s7ls7XmitVZEHCqgaoEkXy
	 saLqu4WZbTv9px/HdgbpWCbuL/F6+i6I7WRaPkL/rIK549r7Eik2+8GGHQrj2AjE2F
	 Y+x/hWjMVRZGdcL9USOZoI1CpIK9jYYmImGgvbdeNKQERYSKa98VRyHZXHvMn5ZMKV
	 5XLOklLRHV5tj0ze3eMxw66KX9E9Fk0O1nwG2qhzfWw93LglxoQXOTRcJxB9F+z/zb
	 YtYIwbk5SiAWoi7bi4KjkIZPd7OR+3WH2nXCXD/c9SlEQzLX9iRmwOk4rBRZliM+v7
	 B8MtHr3gpusrw==
Message-ID: <8a4d8f82-dd9b-41bb-b883-231a78cdc1e1@kernel.org>
Date: Thu, 17 Jul 2025 11:29:03 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] PCI/sysfs: Expose PCIe device serial number
To: Matthew Wood <thepacketgeek@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250717162240.512045-1-thepacketgeek@gmail.com>
 <20250717162240.512045-2-thepacketgeek@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250717162240.512045-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 11:22 AM, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the device_serial_number sysfs attribute will not be visible.

You didn't update the commit message here for 'serial_number'.

> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

With the commit and below comment fixed you can add this to your next spin.

Reviewed-by: Mario Limonciello <superm1@kernel.org>

> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>   drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..4da41471cc6b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,12 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../serial_number
> +Date:		July 2025
IIRC this should be the date that this is first introduced into the 
kernel.  So if this is 6.17 material it should be October 2025 and if 
it's 6.18 material it should be December 2025.

It's getting close to the merge window so I'm not sure right now which 
Bjorn would prefer.

I would say make it October 2025 and if it slips it just gets updated 
for the next spin.

> +Contact:	Matthew Wood <thepacketgeek@gmail.com>
> +Description:
> +		This is visible only for PCIe devices that support the serial
> +		number extended capability. The file is read only and due to
> +		the possible sensitivity of accessible serial numbers, admin
> +		only.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..bc0e0add15d1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(current_link_width);
>   
> +static ssize_t serial_number_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u64 dsn;
> +
> +	dsn = pci_get_dsn(pci_dev);
> +	if (!dsn)
> +		return -EIO;
> +
> +	return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx\n",
> +		dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >> 32) & 0xff,
> +		(dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff, dsn & 0xff);
> +}
> +static DEVICE_ATTR_ADMIN_RO(serial_number);
> +
>   static ssize_t secondary_bus_number_show(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
> @@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] = {
>   	&dev_attr_current_link_width.attr,
>   	&dev_attr_max_link_width.attr,
>   	&dev_attr_max_link_speed.attr,
> +	&dev_attr_serial_number.attr,
>   	NULL,
>   };
>   
> @@ -1749,10 +1766,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct pci_dev *pdev = to_pci_dev(dev);
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
>   }
>   
>   static const struct attribute_group pci_dev_group = {


