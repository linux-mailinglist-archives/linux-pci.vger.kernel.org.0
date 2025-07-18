Return-Path: <linux-pci+bounces-32522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF6B0A0C8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4B01AA2857
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5C29E0F5;
	Fri, 18 Jul 2025 10:36:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0596198A2F;
	Fri, 18 Jul 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834979; cv=none; b=L5E8Hk1lQTn81JrJgUnhSBilwuDXxPRIL18d1BVHCM97oSR/Af0tmfKmueux76tzDyIkHCUBen00CTPcfV3y6ckVsCJuNrOg9b7vAMIOOijtTlGms98NGfIENkbtAQvVZWfPfr9nQ8UhhjxuWDjMxQHoi6XAPEid+BZ/0f29em8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834979; c=relaxed/simple;
	bh=8WseZdDOLLbiYDN9zmEkdhrVUNLNZR7pbmi8bTKNZDA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvZ5a2RyiMI3qoxp2141FAdWIKHjFtFVckZ8JhjDDIgHRcA+C3kC8CATbjBz50T+mKblsyBZnM9r3vWYE8+DJIdWPI3pXL2zodHGxtL3n/ARPkwXaYgDkO53Ge2j3+Iznxlwht8WKuJ317UL851v2M95lZqcIlTa1Ir+U0Wwmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bk5lL47Xsz6M4jq;
	Fri, 18 Jul 2025 18:34:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D322714027A;
	Fri, 18 Jul 2025 18:36:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Jul
 2025 12:36:12 +0200
Date: Fri, 18 Jul 2025 11:36:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matthew Wood <thepacketgeek@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello
	<superm1@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	<thomas.weissschuh@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250718113611.00003c78@huawei.com>
In-Reply-To: <20250717165056.562728-2-thepacketgeek@gmail.com>
References: <20250717165056.562728-1-thepacketgeek@gmail.com>
	<20250717165056.562728-2-thepacketgeek@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 09:50:54 -0700
Matthew Wood <thepacketgeek@gmail.com> wrote:

> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>
Hi Matthew,

A suggestion inline.  I'm also fine with the current version if that's
what people feel more comfortable with.

If we stick to what you have here
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
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
> index 268c69daa4d5..bc0e0add15d1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(current_link_width);
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

I wonder if doing the following i too esoteric. Eyeballing those shifts is painful.

	u8 bytewise[8]; /* naming hard... */

	put_unaligned_u64(dsn, bytewise);

	return sysfs_emit(buf, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n",
		bytewise[0], bytewise[1], bytewise[2], bytewise[3],
		bytewise[4], bytewise[5], bytewise[6], bytewise[7]);


> +}
> +static DEVICE_ATTR_ADMIN_RO(serial_number);



