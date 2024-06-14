Return-Path: <linux-pci+bounces-8838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0F908D41
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F728C193
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711EF5228;
	Fri, 14 Jun 2024 14:18:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0217BCC
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374727; cv=none; b=jA46JS+gIPB7My+1CnTtk9fl88xywLc5hkglY4GukTGyd3jqLlGhkAiPAE+fD82dP5B6CHenh1BYQFVsVpVYs+goIc55oyBmpsWZ/WrYM7nxu62R3RaHZYW6UhO2UMgJpaye2972uNnbUwlFEae3Pg+ovXxeZ9gH3jEBLi+xUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374727; c=relaxed/simple;
	bh=0sIe+d5OKv1Ex2f/mkKTT5R9ZTBlTdYEfop9XiOxdGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyCG41fghvCSEvRC9nPJpVvpXCFT+QMVHeXOt4gXO+1U1e5uo02Sr7QcJYKIeC1jeasdUayJle87opLQdKKzLSScBK8kkrrxXN7H1moKwluNIBX2ubqRB/F2GMh1UdHhcEZTfiNJq38u/uGGn19Z54zXkMIa7GVsdUcXBeEdn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 63EEA2800B1CD;
	Fri, 14 Jun 2024 16:08:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2F2EB4A96C; Fri, 14 Jun 2024 16:08:48 +0200 (CEST)
Date: Fri, 14 Jun 2024 16:08:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 1/3] leds: Init leds class earlier
Message-ID: <ZmxO8AaISgnw9ehP@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-2-mariusz.tkaczyk@linux.intel.com>
 <6656ad7ed677d_16687294bb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6656ad7ed677d_16687294bb@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, May 28, 2024 at 09:22:22PM -0700, Dan Williams wrote:
> Mariusz Tkaczyk wrote:
> > PCI subsystem is registered on subsys_initcall() same as leds class.
> > NPEM driver will require leds class, there is race possibility.
> > Register led class on arch_initcall() to avoid it.
> 
> Another way to solve this without changing initcall levels is to just
> make sure that the leds subsys initcall happens first, i.e.:
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fe9ceb0d2288..d47b4186108a 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_GENERIC_PHY)     += phy/
>  obj-$(CONFIG_PINCTRL)          += pinctrl/
>  obj-$(CONFIG_GPIOLIB)          += gpio/
>  obj-y                          += pwm/
> +obj-y                          += leds/
>  
>  obj-y                          += pci/
>  
> @@ -130,7 +131,6 @@ obj-$(CONFIG_CPU_IDLE)              += cpuidle/
>  obj-y                          += mmc/
>  obj-y                          += ufs/
>  obj-$(CONFIG_MEMSTICK)         += memstick/
> -obj-y                          += leds/
>  obj-$(CONFIG_INFINIBAND)       += infiniband/
>  obj-y                          += firmware/
>  obj-$(CONFIG_CRYPTO)           += crypto/

To me, this seems more fragile than changing the initcall level.

The risk I see is that someone comes along and rearranges the Makefile in,
say, alphabetic order because "why not?" and unwittingly breaks NPEM.

Changing initcall levels at least explicitly sets the order in stone.

However, perhaps a code comment is helpful to tell the casual
code reader why this particular initcall level is needed.

Something like...

/* LEDs may already be registered in subsys initcall level */

... may already be sufficient.

Thanks,

Lukas

