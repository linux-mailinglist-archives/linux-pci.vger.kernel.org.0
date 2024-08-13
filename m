Return-Path: <linux-pci+bounces-11637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EA39508BE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37BDB26276
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DD1A2C34;
	Tue, 13 Aug 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0xJqEImc"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB01A072A
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562166; cv=none; b=i+h1qp2QGC+EFvqjNt8WpBfkA8N1qu5YAjkU+K+Z00dUBOhw0ABR2XVI1EBHrqS2Sy0aAK2VGr9XXkDZOA8Lch+tL3D4rrhb65rmaHe4EeFBg134M5w3hOkyD6vNk50ltLNMup/ioXi+rXkvjdt7mG8rQ7wGJk/ZkSLddjja7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562166; c=relaxed/simple;
	bh=ak+1GO/dpqZA3ryZRyDzSvdsSEdaYYhmGScp6N4Ft/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVLUPy/cWiwrfmtLQdcOih/yWwVCNz/OF47BZOqYnP0ejKEAM3QTqRjr5J2g2LbshlfPMtRvEldeapZ1DLqiDoUMCGPzJ5iIcOYwvWR4NKv311vp5dV/X3m+6mYmbZnpIGj7C56bc1ZKL5BuPmncOfuJYcj27NKteBJjy8qeS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0xJqEImc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=R6Gi8cKoKUSXw8GSMwsMX7yH0NWGfvDzu4ox58ykpfg=; b=0xJqEImcSAo+JFKvZXtgHiGjiI
	8EbDgvKARkcvh85qlYMB+Q76Q8aqU4vUK38dXTQVQM2pxn3rv5Nh1VQaYwwNwfZ+yh7ctBjHVpCpP
	EttVukDWMfVDzycUQTVMik/NP0jrLC+/fvD8UcWknj5fKmreqo8Eg/QfITWD/U8PDGnGt58bFVjT2
	vsAE9QSJR17LU+eHbUGvk4amC6o0JXlukeAs51Dp9gB04SyeFkTPoUNJXfhD69BC/zi0lBkBg06zQ
	uAHrOU8rU5ZICUirD6HBzy+tr8968FfSGQQV3HrOaBc00iofxk43FwZHof5vBSW1weOw7gKro2vOv
	/rcfWlEg==;
Received: from [50.53.9.16] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdtFl-00000004Ax3-0mwc;
	Tue, 13 Aug 2024 15:16:05 +0000
Message-ID: <1632aa0a-b5c3-4273-a93c-c3bbeac392ec@infradead.org>
Date: Tue, 13 Aug 2024 08:16:04 -0700
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



On 8/13/24 4:30 AM, Mariusz Tkaczyk wrote:
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index aa4d1833f442..0d94e4a967d8 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -143,6 +143,15 @@ config PCI_IOV
>  
>  	  If unsure, say N.
>  
> +config PCI_NPEM
> +	bool "Native PCIe Enclosure Management"
> +	depends on LEDS_CLASS=y
> +	help
> +	  Support for Native PCIe Enclosure Management. It allows managing LED
> +	  indications in storage enclosures. Enclosure must support following
> +	  indications: OK, Locate, Fail, Rebuild, other indications are

	                                 Rebuild. Other

> +	  optional.

-- 
~Randy

