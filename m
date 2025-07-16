Return-Path: <linux-pci+bounces-32222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59671B06D24
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FC27A7AD0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BE23CEF8;
	Wed, 16 Jul 2025 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQ7J8GsO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NpQOPaeh"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBEF86348;
	Wed, 16 Jul 2025 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643326; cv=none; b=QTo7ccBy3SSmLX4ojsBz2jn66VaDiMQNnDcba/ZyJpMTEWtelPbn2SV11RNXllrjHsVkxjMwYQrKCgJOkCMKutA55vCV3Sbu07od6EzXddUdJiJWVOPcY7TQDDNxhm4zn+tNZ2gVWs23Hcj7CZbrWWDSnggg0Mbmsr9hRZ1ac48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643326; c=relaxed/simple;
	bh=80fX+2gJUg3sVb3cwSeiDFCJSI0vRWZBzqVV+Z9QDGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii1ONze1FyZ2wPUrgRwKo08qvtmvvDI9OkO9fRNkpUHVpiGF55zOJ5xjnIt9sxWXojAExjvcaW1z2E/fbYTCRiky+/5bqV1npmUjjwupysSCYgJbZQ4ei+fyuFg8if9WjN9SharF2yGv1w2PIRo0nAG6iidgL73rxU7mBIfjvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xQ7J8GsO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NpQOPaeh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 07:22:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752643322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fy7sKnvvB0KBmla1/2OFjJaDVvyUk0O3ZtxVvNDnqCk=;
	b=xQ7J8GsOMmCoSH5LSDGug2T6VMkcvNPbkUChYYv7kE9W9F+n9ft1unWcjK8sTZHXNkDpSp
	lB//syvofrW636Wf2NzRa3ZquNyad3nCf+V34HdyQikk6bjDSBkKuCSDH/mo9DG2yoewYz
	MTXFpy5+hfq8DIB3CNSrPKv7CbDhAR9n0BZ+mEKOWoKUhb11TtcVerbLuo1IFERpNpVTEH
	LIqKXr7mwesLh4ETvvqkBpaOy37c5udy4y890D00C+YT2rNp+gYvAnfJHCW3u34oXNBGgy
	QoY/cqYLaLGJim6t8Fj5m3aavJaWXJt5ddb+ayM6b+G1QPyk9mH1CjonbTst2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752643322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fy7sKnvvB0KBmla1/2OFjJaDVvyUk0O3ZtxVvNDnqCk=;
	b=NpQOPaehKpuyFMVDwJrAcPAvlyvRHQzbChaBR+mcYdgi2dEq3PHwCHwVN0zfE599tJdVym
	iUrUzkXKLqnhQMDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci-next v2 1/1] PCI/sysfs: Expose PCIe device serial
 number
Message-ID: <20250716071618-b6d697c0-76e0-42f9-9937-7ba89e1792cc@linutronix.de>
References: <20250716045323.456863-1-thepacketgeek@gmail.com>
 <20250716045323.456863-2-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716045323.456863-2-thepacketgeek@gmail.com>

On Tue, Jul 15, 2025 at 09:53:22PM -0700, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the device_serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..d59756bc91c9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(current_link_width);
>  
> +static ssize_t device_serial_number_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u64 dsn;
> +
> +	dsn = pci_get_dsn(pci_dev);
> +	if (!dsn)
> +		return -EINVAL;

-EIO

> +
> +	return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%02llx\n",
> +		dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >> 32) & 0xff,
> +		(dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff, dsn & 0xff);
> +}
> +static DEVICE_ATTR_RO(device_serial_number);
> +
>  static ssize_t secondary_bus_number_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] = {
>  	&dev_attr_current_link_width.attr,
>  	&dev_attr_max_link_width.attr,
>  	&dev_attr_max_link_speed.attr,
> +	&dev_attr_device_serial_number.attr,
>  	NULL,
>  };
>  
> @@ -1749,8 +1766,12 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (pci_is_pcie(pdev))
> +	if (pci_is_pcie(pdev)) {
> +		if (strncmp(a->name, "device_serial_number", 20) == 0 &&

Compare to the real 'struct attribute *' instead of the name.
You could restructure this a bit to be easier to read.

if (!pci_is_pcie(pdev))
	return 0;

if (a == &dev_addr_device_serial_number.attr && !pci_get_dns(pdev))
	return 0;

return a->mode;

> +			!pci_get_dsn(pdev))
> +			return 0;
>  		return a->mode;
> +	}

Also should have some docs in Documentation/ABI/testing/sysfs-bus-pci.

>  
>  	return 0;
>  }
> -- 
> 2.50.0
> 

