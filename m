Return-Path: <linux-pci+bounces-8837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD194908D0C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04861C20F38
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F916FB1;
	Fri, 14 Jun 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1xHxBI8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8019D896
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374416; cv=none; b=RowTEef2nBKInUUBfPrkZfzzH4I5Md8/tW8fIdbZ0+eAFnqp9awYappXV+0M6M6AuI9k+fkeoLQK7PJPv3fqYb7/Q8y80iwaa+ANd5nMZqtb++6Ns8cg06HKUnBC2fgmc1OZtdDCJ129WPWIp+sw8FcXIrhg9pUh/fhhJwf6FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374416; c=relaxed/simple;
	bh=N3nM3MWzkTu9eoy3cM1MTNcLlASRRoQPREP36J/HGew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqwctEFkCJnuuM9arGgOYp26QjGWC9ULM8gGNdKJ+mWBnLRcLINwO68VmArQTXK+e9Wdnyy5+B6nd/VN7GfVYQ6iqvH7ardL2S0VgSDJKbM8RfmqhQfNRG+XpeeJiTbea9RlB0BoL97QlsRmHyMgv7hjGeRonuW2TNpuTUiWbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A1xHxBI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28342C2BD10;
	Fri, 14 Jun 2024 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718374415;
	bh=N3nM3MWzkTu9eoy3cM1MTNcLlASRRoQPREP36J/HGew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1xHxBI8eAxy1sksbVgBp8xKruSkqsgJqIKTiIaM2oKAaLIgrSWAqJTHz2g6FLiHa
	 DJwpbhfyl56z7RAIq1v2pylJQcByoXYWc0X6iudSHZt5pPNkDjbJqBbtgzycOp49AA
	 qqHJvhrZUO+2/wkeZ0v0wA5ZZ11qfi2WrxFdYVgk=
Date: Fri, 14 Jun 2024 16:13:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 1/3] leds: Init leds class earlier
Message-ID: <2024061429-handiness-waggle-d87a@gregkh>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-2-mariusz.tkaczyk@linux.intel.com>
 <6656ad7ed677d_16687294bb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZmxO8AaISgnw9ehP@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmxO8AaISgnw9ehP@wunner.de>

On Fri, Jun 14, 2024 at 04:08:48PM +0200, Lukas Wunner wrote:
> On Tue, May 28, 2024 at 09:22:22PM -0700, Dan Williams wrote:
> > Mariusz Tkaczyk wrote:
> > > PCI subsystem is registered on subsys_initcall() same as leds class.
> > > NPEM driver will require leds class, there is race possibility.
> > > Register led class on arch_initcall() to avoid it.
> > 
> > Another way to solve this without changing initcall levels is to just
> > make sure that the leds subsys initcall happens first, i.e.:
> > 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index fe9ceb0d2288..d47b4186108a 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_GENERIC_PHY)     += phy/
> >  obj-$(CONFIG_PINCTRL)          += pinctrl/
> >  obj-$(CONFIG_GPIOLIB)          += gpio/
> >  obj-y                          += pwm/
> > +obj-y                          += leds/
> >  
> >  obj-y                          += pci/
> >  
> > @@ -130,7 +131,6 @@ obj-$(CONFIG_CPU_IDLE)              += cpuidle/
> >  obj-y                          += mmc/
> >  obj-y                          += ufs/
> >  obj-$(CONFIG_MEMSTICK)         += memstick/
> > -obj-y                          += leds/
> >  obj-$(CONFIG_INFINIBAND)       += infiniband/
> >  obj-y                          += firmware/
> >  obj-$(CONFIG_CRYPTO)           += crypto/
> 
> To me, this seems more fragile than changing the initcall level.
> 
> The risk I see is that someone comes along and rearranges the Makefile in,
> say, alphabetic order because "why not?" and unwittingly breaks NPEM.

If they do that, then we have worse problems as many of us "know" that
the order here matters a LOT.

> Changing initcall levels at least explicitly sets the order in stone.

For a while, until they change :)

> However, perhaps a code comment is helpful to tell the casual
> code reader why this particular initcall level is needed.
> 
> Something like...
> 
> /* LEDs may already be registered in subsys initcall level */

That would be good to have.

thanks,

greg k-h

