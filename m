Return-Path: <linux-pci+bounces-11638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2643A9508D0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D044D286020
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98D1A071F;
	Tue, 13 Aug 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3sslFFv"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D41A08A3
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562358; cv=none; b=ldvYkqpGtahugGaa59jqsZrhVXf0cFEk+bzQRw2DzcWXSPuBgMyxfoJlCfifRub98YeAr5uz1PSShlmzEAXIYp6xOz2c/UMtjMnM5uaj+8Teg5gkuivGseXV/2Zq8Zgfl40uN5+LMUU7uefoBZlG9AAoDYYCVeLzq8pO4byPDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562358; c=relaxed/simple;
	bh=XSZaT8P1O0P6iYWIgVMqJAOz2AfHZ9SpJTVkXmMdD80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVrRNo3OMQF88QxJMqOxxmpfy5qSThq+vpfAUFwhx49/hdFh9y5B0pw2jnnYhhd/jK3RXz4MMW0Kp7PL4cMCLP6vvoaPVeAZxU5vZVlCiFj9GkIQFzb9xv4Ak5jPjFPV4zUZiS39lgYxlIEsbAdcJu5tCxDEvjgUhyVqJV0xJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3sslFFv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vaGvT5vpsUqzufWQAZb14OM6dD1Y6lr/QtYBD4KP0Zg=; b=N3sslFFvjUx5SrSyyxbxdee5Cy
	FgS5DbFTnps0rj9j8PATzVciwgqUqgoWhj6tBns20G/6LaCJ1bakuSdBC8S2sTUVLVtO+59Izhbfj
	maEMTnz6GFtD4Jidv+0Moae8wUOuZfcsmMSoNa78y4JGw2qayq6nnVOZ+6CxFu4bwCXnz6dwyLNFe
	/w0A8yMz53IGtr8Y4nHLuBDy+o9z75lVrkJaxqGJMvmRpPv29VbfnyStzkoaaMd4RbOfnuWt0SKSF
	p+g+ZColRsChzvr1L2zmFQ6O9DX6b/ikKKKFeaZlvKZFcvps0p61yckPo04shm8XtJPd7djLFDyqQ
	1I0NGv1w==;
Received: from [50.53.9.16] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdtIq-00000004Biw-1r1E;
	Tue, 13 Aug 2024 15:19:16 +0000
Message-ID: <9fe87c47-5362-46d5-b50a-2c180b627ab0@infradead.org>
Date: Tue, 13 Aug 2024 08:19:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
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
 <20240813113024.17938-3-mariusz.tkaczyk@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240813113024.17938-3-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..93d22b779d20 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,66 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../leds/*:enclosure:*/brightness
> +What:		/sys/class/leds/*:enclosure:*/brightness
> +Date:		August 2024
> +KernelVersion:	6.12
> +Description:
> +		LED indications on PCIe storage enclosures which are controlled
> +		through the NPEM interface (Native PCIe Enclosure Management,
> +		PCIe r6.1 sec 6.28) are accessible as led class devices, both

s/led/LED/ preferably.

> +		below /sys/class/leds and below NPEM-capable PCI devices.
> +
> +		Although these led class devices could be manipulated manually,

ditto

> +		in practice they are typically manipulated automatically by an
> +		application such as ledmon(8).
> +
> +		The name of a led class device is as follows:

		            an LED

> +		<bdf>:enclosure:<indication>
> +		where:
> +
> +		- <bdf> is the domain, bus, device and function number
> +		  (e.g. 10000:02:05.0)
> +		- <indication> is a short description of the LED indication
> +
> +		Valid indications per PCIe r6.1 table 6-27 are:
> +
> +		- ok (drive is functioning normally)
> +		- locate (drive is being identified by an admin)
> +		- fail (drive is not functioning properly)
> +		- rebuild (drive is part of an array that is rebuilding)
> +		- pfa (drive is predicted to fail soon)
> +		- hotspare (drive is marked to be used as a replacement)
> +		- ica (drive is part of an array that is degraded)
> +		- ifa (drive is part of an array that is failed)
> +		- idt (drive is not the right type for the connector)
> +		- disabled (drive is disabled, removal is safe)
> +		- specific0 to specific7 (enclosure-specific indications)
> +
> +		Broadly, the indications fall into one of these categories:
> +
> +		- to signify drive state (ok, locate, fail, idt, disabled)
> +		- to signify drive role or state in a software RAID array
> +		  (rebuild, pfa, hotspare, ica, ifa)
> +		- to signify any other role or state (specific0 to specific7)
> +
> +		Mandatory indications per PCIe r6.1 sec 7.9.19.2 comprise:
> +		ok, locate, fail, rebuild. All others are optional.
> +		A led class device is only visible if the corresponding

		An LED

> +		indication is supported by the device.
> +
> +		To manipulate the indications, write 0 (LED_OFF) or 1 (LED_ON)
> +		to the "brightness" file.  Note that manipulating an indication
> +		may implicitly manipulate other indications at the vendor's
> +		discretion. E.g. when the user lights up the "ok" indication,
> +		the vendor may choose to automatically turn off the "fail"
> +		indication. The current state of an indication can be
> +		retrieved by reading its "brightness" file.
> +
> +		The PCIe Base Specification allows vendors leeway to choose
> +		different colors or blinking patterns for the indications,
> +		but they typically follow the IBPI standard.  E.g. the "locate"
> +		indication is usually presented as one or two LEDs blinking at
> +		4 Hz frequency:
> +		https://en.wikipedia.org/wiki/International_Blinking_Pattern_Interpretation


-- 
~Randy

