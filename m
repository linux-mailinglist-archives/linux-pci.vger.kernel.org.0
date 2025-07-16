Return-Path: <linux-pci+bounces-32304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9C8B07BB4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545CE16E4DD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A661236A73;
	Wed, 16 Jul 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0hz4ujV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7442049;
	Wed, 16 Jul 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685361; cv=none; b=pQVX3a1+LVvpl17R3J7kEaR9LSztXWaFWBGyOgWrIcrEL35PbiknZUDy1xEoABPyEJQPzSJbI6kOuFKCpRzxlNJmYuSjP4gWtaVrxS+qZvL+Y68EeCdF9yDUKi9dL7B2HDTqJHEro/rrHvO6xgxitsgSc62S/o2MMeij84npuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685361; c=relaxed/simple;
	bh=Nk8r5lNpqHLsdZRzSm9gX+C1MJ9SZPhZTOf9SPBThE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUvnlUsfwuNW1+pN9BtQK8+nXCGIE/sK7yy+W2DNfH/sRfwSmY94UFuS1ZXyephPInQBPuAr8etxngXbF5o/OntJ3JCnLUpS7I0OWWaYXcYIRf2fAFQihVEghVh1RQE8SsNSsI57Xh48Tk9Vex61L470veMaGlu5oFuszkLAPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0hz4ujV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A556C4CEF0;
	Wed, 16 Jul 2025 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752685361;
	bh=Nk8r5lNpqHLsdZRzSm9gX+C1MJ9SZPhZTOf9SPBThE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M0hz4ujVXE1KJoc71fTUWld9G+IpQLR6Um2ibxRYH181fHJtv3kl3CvVGDnxFjEU+
	 COQtMsW5XUGiBEpgtDGcH/KRbS3ta3foPVTJQmkCydCAjI0rWzL9QC+CPqjrquN5o+
	 cqmKO8A3SnLINk1fWj5O2/N6SVREhJSUB6W42pGm45hR8BK3r7IpQqzN+Pz7QWgHuo
	 nZjGAwbdivlc0ezxyIrwAsKi0jcxnXD4Z+vz5aUxUf3mULtp13c7qOo2yg0DUFPOou
	 okSvVfhHr/5Uka08xAvJe9nmx5pkw4DrgcrW7Aq71Py+Gh2ZFauHa3x78n4zWEc0Ud
	 2Xd952f1lQbMg==
Message-ID: <7cae9919-4ccd-41ed-a899-0e97ee2c0250@kernel.org>
Date: Wed, 16 Jul 2025 12:02:39 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] PCI/sysfs: Expose PCIe device serial number
To: Matthew Wood <thepacketgeek@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250716163213.469226-1-thepacketgeek@gmail.com>
 <20250716163213.469226-2-thepacketgeek@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250716163213.469226-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 11:32 AM, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the device_serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  7 +++++++
>   drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
>   2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..f7e84b3a4204 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,10 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../device_serial_number
> +Date:		July 2025
> +Contact:	Matthew Wood <thepacketgeek@gmail.com>
> +Description:
> +		This is visible only for PCIe devices that support the serial
> +		number extended capability. The file is read only.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..b7b52dea6e31 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(current_link_width);
>   
> +static ssize_t device_serial_number_show(struct device *dev,
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
> +static DEVICE_ATTR_RO(device_serial_number);

The serial number /could/ be considered sensitive information.  I think 
it's better to use DEVICE_ATTR_ADMIN_RO.

Also, as this is a "device" attribute is it really necessary to encode 
the extra word and "number"?

> +
>   static ssize_t secondary_bus_number_show(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
> @@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] = {
>   	&dev_attr_current_link_width.attr,
>   	&dev_attr_max_link_width.attr,
>   	&dev_attr_max_link_speed.attr,
> +	&dev_attr_device_serial_number.attr,
>   	NULL,
>   };
>   
> @@ -1749,10 +1766,14 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   
> -	if (pci_is_pcie(pdev))
> -		return a->mode;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
> +
> +	if (a == &dev_attr_device_serial_number.attr && !pci_get_dsn(pdev))
> +		return 0;
> +
> +	return a->mode;
>   
> -	return 0;
>   }
>   
>   static const struct attribute_group pci_dev_group = {


