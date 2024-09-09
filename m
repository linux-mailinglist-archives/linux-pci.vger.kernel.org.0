Return-Path: <linux-pci+bounces-12964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB19723A6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 22:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC67281C87
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F86189903;
	Mon,  9 Sep 2024 20:28:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD416EB55;
	Mon,  9 Sep 2024 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913702; cv=none; b=GNrsCqFyVRNxRaOblAs2P5VeY3p0foawmG/t2yXJh1Yav3Ym9a0+eDm/CfmvHzIbQpIJadD03Lsy06xA1OarQ0tzbeDwIgkVq6wpS7lLHBTcf1tgliKqhPZ9dyK2XLWRlAoghQyxtvcxRu9sT37U36RZ28ywCxGnrVLf75hXKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913702; c=relaxed/simple;
	bh=KWoOpEbiz0TPTJslvAFnv9TWPCEsPiKD/hVA5wSfcxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd8txNTJvqn2Q26Tpfp88yhFefn48ARR/dJKxm/dH2d2Yk1+7lJ/aGWs2Z5MIps8ADsP9Dw1lvDXiXwsWG5UwkXlLzVFtmL+anXUsmLvnHl9DK2EZBT/26t66f2gIkRM8GtEdeRJPQKHsjmuohzYG1UJayaan3+GRCy/nDgsnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9A0D7100E4197;
	Mon,  9 Sep 2024 22:21:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 608EF30C9F5; Mon,  9 Sep 2024 22:21:16 +0200 (CEST)
Date: Mon, 9 Sep 2024 22:21:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Lee Jones <lee@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 1/3] leds: Init leds class earlier
Message-ID: <Zt9YvMf2jVyaQfRo@wunner.de>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
 <20240904104848.23480-2-mariusz.tkaczyk@linux.intel.com>
 <20240909090340.GA6556@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909090340.GA6556@google.com>

On Mon, Sep 09, 2024 at 10:03:40AM +0100, Lee Jones wrote:
> On Wed, 04 Sep 2024, Mariusz Tkaczyk wrote:
> > NPEM driver will require leds class, there is an init-order conflict.
> > Make sure that LEDs initialization happens first and add comment.
[...]
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -17,6 +17,9 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
> >  obj-$(CONFIG_GPIOLIB)		+= gpio/
> >  obj-y				+= pwm/
> >  
> > +# LEDs must come before PCI, it is needed by NPEM driver
> > +obj-y				+= leds/
> > +
> >  obj-y				+= pci/
> >  
> >  obj-$(CONFIG_PARISC)		+= parisc/
> > @@ -130,7 +133,6 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
> >  obj-y				+= mmc/
> >  obj-y				+= ufs/
> >  obj-$(CONFIG_MEMSTICK)		+= memstick/
> > -obj-y				+= leds/
> >  obj-$(CONFIG_INFINIBAND)	+= infiniband/
> >  obj-y				+= firmware/
> >  obj-$(CONFIG_CRYPTO)		+= crypto/
> 
> This seems very fragile.
> 
> Isn't there a better way to describe the dependency in Kconfig etc?

In v2 of this series, the correct init order was ensured by
running leds_init() at "arch" initcall level, instead of "subsys":

https://lore.kernel.org/linux-pci/20240528131940.16924-2-mariusz.tkaczyk@linux.intel.com/

If you prefer this alternative approach, then Bjorn or Krzysztof
can probably replace the commit on the pci.git/npem branch.

AFAIK, all topic branches in pci.git are to be considered drafts
that can be amended until the pull request is sent.

Thanks,

Lukas

