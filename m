Return-Path: <linux-pci+bounces-9892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D7192981E
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34966B21822
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46518029;
	Sun,  7 Jul 2024 13:32:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966E12E75;
	Sun,  7 Jul 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720359132; cv=none; b=XduSonQ+b3HF7ykHf1P/lLEm+0B+z403H/QuzbEt9MRvpAKeloYSX5Uq1HUrVz6OdhS5e2M9exlxIVqKOpbKUhwKvvuHjRJyvtsLUTvyGjfTStoJ0VYdcdpPRhIPPXwTIyU48J5ekQ4R6irsnLvep8ZzJ6LCAOdvF3uglEsrMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720359132; c=relaxed/simple;
	bh=ynGU++zhioewJL2BkkX4ZIJhoDGCLiy4COlay3jKV6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYgmtMTRW16oxikmRdsLe3aGovzUvXxb4A6X/Ytng3o0/TSE9mO79WAPJpGgYXflOvbCVbjZB8mfAiIrKRHdvDcBsQ/I+y0+kq37KLmxNidtd7bAsiyw0uBtcrAQZQsDbAqqSTfTWAQX8o6fL7PUf4x+UOJPWG1jKHTHAWU1+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A55EF100D943E;
	Sun,  7 Jul 2024 15:31:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6C2A255998; Sun,  7 Jul 2024 15:31:59 +0200 (CEST)
Date: Sun, 7 Jul 2024 15:31:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: bus: only call of_platform_populate() if CONFIG_OF
 is defined
Message-ID: <ZoqYz-MWD06GmKPJ@wunner.de>
References: <20240703091535.3531-1-spasswolf@web.de>
 <CAMRc=Md=PnpHVGGO6Nb_efVZ0a3cMxWbLvYmkka5Wznks70drw@mail.gmail.com>
 <ZokDkyfn2Xt2Ki-i@wunner.de>
 <CAMRc=McBpqP=qSbxDGcreTcktq_0vQH_PrtQS0V=Mw3w-_Zmwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McBpqP=qSbxDGcreTcktq_0vQH_PrtQS0V=Mw3w-_Zmwg@mail.gmail.com>

On Sat, Jul 06, 2024 at 07:12:48PM +0200, Bartosz Golaszewski wrote:
> On Sat, Jul 6, 2024 at 10:43???AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Jul 03, 2024 at 11:32:05AM +0200, Bartosz Golaszewski wrote:
> > > On Wed, Jul 3, 2024 at 11:15 AM Bert Karwatzki <spasswolf@web.de> wrote:
> > > > If of_platform_populate() is called when CONFIG_OF is not defined this
> > > > leads to spurious error messages of the following type:
> > > >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> > > >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
[...]
> > > > --- a/drivers/pci/bus.c
> > > > +++ b/drivers/pci/bus.c
> > > > @@ -350,6 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> > > >
> > > >         pci_dev_assign_added(dev, true);
> > > >
> > > > +#ifdef CONFIG_OF
> > > >         if (pci_is_bridge(dev)) {
> > > 
> > > There's a better (less ifdeffery) fix on the list that I'll pick up
> > > later today[1].
> > >
> > > [1] https://lore.kernel.org/lkml/20240702180839.71491-1-superm1@kernel.org/T/
> >
> > That other fix doesn't feel very robust as it depends on
> > of_platform_populate() never returning -ENODEV in the
> > CONFIG_OF=y case.
> 
> If we even have to play these ifdef games then the stubs for
> of_platform_populate() are broken and should probably return 0 with
> !OF as otherwise the stubs themselves are useless.

The stub was introduced by commit 964dba283439 ("devicetree: Add empty
of_platform_populate() for !CONFIG_OF_ADDRESS (sparc)") some twelve
years ago.

From a brief look I'm under the impression that the commit used -ENODEV
on purpose (instead of 0).

There are 100 files in the kernel source tree referencing
of_platform_populate().  The majority is probably not compiled
in the CONFIG_OF=n case, nevertheless changing the stub risks
regressing some of those 100 callers unless great care is
observed.

Just making this conditional on IS_ENABLED(CONFIG_OF) is the
least risky option.

Thanks,

Lukas

