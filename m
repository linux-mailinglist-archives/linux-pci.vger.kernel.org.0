Return-Path: <linux-pci+bounces-9874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52BB929202
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224081C21431
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00924D8B1;
	Sat,  6 Jul 2024 08:43:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F661C69D;
	Sat,  6 Jul 2024 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255387; cv=none; b=qT3C2T4JUh6lWYftLOvzvpPYQDIZ4n6XK++K2ykFwCzdkeYQXuL+mMJ7AAfBsPbFW5czR4GY7FV9XsClOIHMWh1ify1GuIgsK84PCCpBILTxcxTNVnvsIKvvwDNnYrXu4A9CXv+1O0HiGfn6Veg1NT8mo6cETQx2toMsXoaj1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255387; c=relaxed/simple;
	bh=qtKywlXV9eQoI3XMxuo7EO/3+LdGfDeUhwh6jA9mgRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYra/MLvV0PyH12MWu0p79HYNwkop44T6GlfmXTgt3JGUUOJyz2iKOBrLfL6CfC3vWNfUOiLrSaY10+Ssim+85JqdxOxaM0p6YNV/grcldPifxcadLNQ1ywHeH/Bovj/d9mMz84nBexhTZhm1jWd0mduNFpEwCvryXGBGNhj+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5BD83100DA1D9;
	Sat,  6 Jul 2024 10:43:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EBE8E5505F; Sat,  6 Jul 2024 10:42:59 +0200 (CEST)
Date: Sat, 6 Jul 2024 10:42:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: bus: only call of_platform_populate() if CONFIG_OF
 is defined
Message-ID: <ZokDkyfn2Xt2Ki-i@wunner.de>
References: <20240703091535.3531-1-spasswolf@web.de>
 <CAMRc=Md=PnpHVGGO6Nb_efVZ0a3cMxWbLvYmkka5Wznks70drw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md=PnpHVGGO6Nb_efVZ0a3cMxWbLvYmkka5Wznks70drw@mail.gmail.com>

On Wed, Jul 03, 2024 at 11:32:05AM +0200, Bartosz Golaszewski wrote:
> On Wed, Jul 3, 2024 at 11:15 AM Bert Karwatzki <spasswolf@web.de> wrote:
> > If of_platform_populate() is called when CONFIG_OF is not defined this
> > leads to spurious error messages of the following type:
> >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> >
> > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > ---
> >  drivers/pci/bus.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index e4735428814d..b363010664cd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -350,6 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >
> >         pci_dev_assign_added(dev, true);
> >
> > +#ifdef CONFIG_OF
> >         if (pci_is_bridge(dev)) {

Per section 21 of Documentation/process/coding-style.rst,
IS_ENABLED() is strongly preferred to #ifdef.


> There's a better (less ifdeffery) fix on the list that I'll pick up
> later today[1].
> 
> [1] https://lore.kernel.org/lkml/20240702180839.71491-1-superm1@kernel.org/T/

That other fix doesn't feel very robust as it depends on
of_platform_populate() never returning -ENODEV in the
CONFIG_OF=y case.

Thanks,

Lukas

