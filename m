Return-Path: <linux-pci+bounces-11106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81B944783
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6018E1C203B7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60416C6B4;
	Thu,  1 Aug 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAIg+bR3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B184481DD
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503377; cv=none; b=uvqCSpZUdzVH7jvgPdEmcO5LR0aiI1eH3P01Yv2kCXPn/M/MO+zioD5CJs0y6oMR7DgwcexFLjQA8rzyizD+Dk2uvHsERJnva3mSc1K3BXMNngpBCrXb1iZc0QGLmHtSK4QOemJ84ZBmmZ4erCSh3segQJnBH2+R9rk3hSvxG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503377; c=relaxed/simple;
	bh=5EKAajy2VRBJWDYehlw6iIO8Ii+lpw6ck6cKs2Xuqh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcIR4BEh0yGncQYV1fo7c2iFfAEHtGb2TQLHsR3quzgXbLe3Vo2NLdZc059/C1ah4HdnGRxpZOzfK3fHgVIP2pptZmz99SS2X1J6sqWVShjnizv4mfYanVID7Da3qsAoWuoGDoxoz4tSmSoeuiRAIfdwQFHQonO9fGRmvjCeglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAIg+bR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272D4C32786;
	Thu,  1 Aug 2024 09:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722503377;
	bh=5EKAajy2VRBJWDYehlw6iIO8Ii+lpw6ck6cKs2Xuqh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAIg+bR3thwY/uhoQOIkCGlYcx94q0NPoXLFph9mNZ2Tes5zpfHT7dZ7fUmOSv7cX
	 Xxg+aidR08wwjJu+/J6PBxZWumGlOfwDKfZhxFRaJjb0A7ixGyn63KALv7odknjKfP
	 x3o3OeHAn0BOzj+OlPfNpMONTqjgLkw/sGlhSvFXumUtFVcRj4sNP2GojG5jn0KPd7
	 Tz50q1q2EX6Xb58PT23HUZnXywvE0jHpksufHKw+xPYshMmtxwD3M3S/5uNhCq7nO2
	 jbZl5YNK6Xu1rpmro9gKV+FU7dCVCi26HGuq7vYhW25zDokC54FwWpaGNp66V3MlPw
	 XDjQvdwgc1X+Q==
Date: Thu, 1 Aug 2024 11:09:31 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Christoph Hellwig <hch@lst.de>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <hjqdj5oiaigr5qn3vm3ypg62vmfkiw2i2nukt5zyfmaksyxdj7@wmk7blz3yv4b>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
 <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>

> +static enum led_brightness brightness_get(struct led_classdev *led)
> +{
> +	struct npem_led *nled = container_of(led, struct npem_led, led);
> +	struct npem *npem = nled->npem;
> +	int ret, val = LED_OFF;

Don't use LED_OFF and LED_ON. Instead use 0 and 1. Set max_brightness to 1.

Enum led_brightness is obsolete:
  /* This is obsolete/useless. We now support variable maximum brightness. */

Marek

