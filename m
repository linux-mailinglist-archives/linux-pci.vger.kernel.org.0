Return-Path: <linux-pci+bounces-10827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8793CED9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F911F22241
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 07:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B94C99;
	Fri, 26 Jul 2024 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqSPxa9n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4123A8
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978983; cv=none; b=N9uwep5WOzvzUE3qWfSRBGupxctoHAkAXuT9nZ7o/ub+Dti556gtGEiaFcrrZxekH4qR+PFJnV5RJk2+qqKGd8YZ2sBUmx6bnIqEI68SWsSZ8C63KIi6i7qMifjRD9HurpBRz8ToVMJ11FGkHIDykVijFEOJEAksmvYNvUBej/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978983; c=relaxed/simple;
	bh=f5FeLPPm3vxnFYOPpHoA02a7EUWT0fW0IbHAF0B51uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvj9BHO9q053mIfiVRuIS1vpyqJG+SXCqJ8dKpFTM9VNvPS7mFKHXdjCeYdnDagoEH9ffSMoYzjjmhqXhaKsRrHMuC0cIyje0f0NPryv5ThGybB7fcS4L8wgWWWrvsQquxzqFUOtxeFrJ7JFIFmkyiUmm6wfsT25PhaucHHFLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqSPxa9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769B4C32782;
	Fri, 26 Jul 2024 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721978982;
	bh=f5FeLPPm3vxnFYOPpHoA02a7EUWT0fW0IbHAF0B51uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqSPxa9nhc1nGjQgNOPuwksVNcAfTANootFiXK7YBDqglYBgTBRouVt2m+ngv/v8z
	 D3aVpx6O32mnvt3GsnJO9kEcdvk9Y2qr1QZ0l1/rDa+yFZt0Y7U+iiMDVk8bYme43U
	 aRq1lafcoXN43JAea5EORXsasQDfInduVcTQfIr1fd7AGwftJ9NgtoIAAuo71YDv9p
	 KSbdYNsLPOxKZS7l5yAax/PGIOCFrKcBGHPmHxL4lwy/8aaAC6udpapPGiE/5+L1yQ
	 yufQfFCFtGIcaw47+v5FEOqZjL3j8BYQpqyIyDZsOX+1+y5Ej5ZB87FpXlxSO39n+I
	 N/jTfOZUlqPJA==
Date: Fri, 26 Jul 2024 09:29:36 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Christoph Hellwig <hch@lst.de>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, 
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
 <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>

On Thu, Jul 11, 2024 at 10:30:08AM +0200, Mariusz Tkaczyk wrote:
> Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> managing LED in storage enclosures. NPEM is indication oriented
> and it does not give direct access to LED. Although each of
> the indications *could* represent an individual LED, multiple
> indications could also be represented as a single,
> multi-color LED or a single LED blinking in a specific interval.
> The specification leaves that open.

The specification leaves it open, but isn't there a way to determine
how it is implemented? In ACPI, maybe?

> Each enabled indication (capability register bit on) is represented as a
> ledclass_dev which can be controlled through sysfs. For every ledclass
> device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> It is corresponding to NPEM control register (Indication bit on/off).
> 
> Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> device which has an NPEM Extended Capability and indication is enabled
> in NPEM capability register. For example, these are leds created for
> pcieport "10000:02:05.0" on my setup:
> 
> leds/
> ├── 10000:02:05.0:enclosure:fail
> ├── 10000:02:05.0:enclosure:locate
> ├── 10000:02:05.0:enclosure:ok
> └── 10000:02:05.0:enclosure:rebuild
> 
> They can be also found in "/sys/class/leds" directory. Parent PCIe device
> bdf is used to guarantee uniqueness across leds subsystem.
> 
> To enable/disable fail indication "brightness" file can be edited:
> echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness

Have you considered implemtening this via a led trigger?

Something like:
  echo pcie-enclosure > /sys/class/leds/<LED>/trigger
  echo 1 >/sys/class/leds/<LED>/fail
but properly thought up.

Marek

