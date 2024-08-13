Return-Path: <linux-pci+bounces-11636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2109508AD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E021C22C8C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ED71A00EC;
	Tue, 13 Aug 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQXAq/li"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3619CCFC
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562102; cv=none; b=pkS8HAI/lSTBYL+dqO2J/15hz+O+K6Lx9pIkq/MVbUV876uO7tF9NAYVy9ZxYcNTXs0KYLeU72CCRIfTTlp9EzMoAOxVoBhl+f4AbU1HjyAc/GBOqwO3XxwS4Z90WI/WOn6cBQvLx2l+Sd/RSyjGoed2q1zZm13vSM5EonIZyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562102; c=relaxed/simple;
	bh=edHZhui1z2VnROZaR/4nNC76sxFhqB/2Ryd0H8odAtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDp7rCwEFt2J2njbZGS3HVY5EaLSl2tlcDWAjyrKthw0HXWhz9ZrpfAPGAsGRz5b9SJut6B38iX3ua0SbPJ/tXhL29EQf+vV7EnkMHIrVdOQhoHpxsLMNEhlpZWvFAz9VcpNOBXkneTFZewU/W3cv1LsABRo4KgF6bbALduHYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UQXAq/li; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kzrYMAPUMUtBtCJDnv2pIvPT9oN/X90OpwjmYqDyF0M=; b=UQXAq/lizNEpRAezg2U9wOkoll
	LkmRecENlL63tFc+nvybN6Ew/RqSEWBTDgIsKH58xsbA+YMXTHu+CZSNZj8edPpSMEHtoteIBIRbV
	H5BODh+/dAkDx3faOXl9psz0Y05M7nTMWdxvOK/BSrDPPePdoBCY/gh1+gzT3LNqKtDubWwjmgxKW
	lZDlo/gFhaU+CUfXY77UhPo3RLtunooMS0nH3RGJY1oB+1f8dDrRBKfudNpFrFPwY1jwMRG2QIhvp
	PpXj3UsjLzAHczT0mCb4EKjGOR8VwGNHX8W//2f1upJZXXCg9U05CHEViQyZbpE1cuchIlW1f8+NK
	YZc2tKlw==;
Received: from [50.53.9.16] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdtEf-00000004AdV-3aS4;
	Tue, 13 Aug 2024 15:14:57 +0000
Message-ID: <1cf40b1e-ad95-4b83-9f4f-5f14d589a69b@infradead.org>
Date: Tue, 13 Aug 2024 08:14:56 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
 Pavel Machek <pavel@ucw.cz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com>
 <20240813113024.17938-4-mariusz.tkaczyk@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240813113024.17938-4-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/24 4:30 AM, Mariusz Tkaczyk wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 93d22b779d20..62154e549414 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -563,3 +563,12 @@ Description:
>  		indication is usually presented as one or two LEDs blinking at
>  		4 Hz frequency:
>  		https://en.wikipedia.org/wiki/International_Blinking_Pattern_Interpretation
> +
> +		PCI Firmware Specification r3.3 sec 4.7 defines a DSM interface
> +		to facilitate shared access by operating system and platform
> +		firmware to a device's NPEM registers.  The kernel will use
> +		this DSM interface where available, instead of accessing NPEM
> +		registers directly.  The DSM interface does not support the
> +		enclosure-specific indications "specific0" to "specific7",
> +		hence the corresponding led class devices are unavailable if

s/led/LED/ please.

> +		the DSM interface is used.

-- 
~Randy

