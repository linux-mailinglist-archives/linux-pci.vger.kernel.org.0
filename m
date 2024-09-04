Return-Path: <linux-pci+bounces-12788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BBC96C856
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA21F259D9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC1148FEC;
	Wed,  4 Sep 2024 20:25:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0261EBFEC
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481502; cv=none; b=sJp5/WmajZhMZkw0MEZ2PsZElV12eYlnL+tOtKloOfq18wpqEcWUHkTx6w93t+MpUaRmrLuZWBk+g2ggTC/udxplxbD1BuXnHpog77VB3kVbRg7F71/IlnzsMBkv/p5aCx7ObmGcfXQMIr0sRz6gfaAYPgRYGIqD49QzgP4QROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481502; c=relaxed/simple;
	bh=iGneDPgEDlQeqkQPamzvDWY3vvyWNku/XjBXEJT2th8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW1IJU8wZzAyjTEnuE7qouVE6DzV9S/xyKDpNY20ZDFZITFN0ut93PkKOJ7J53bc0wbhMIOXAHVBX4Q8c9CkSF0EiYmoGVeGAZBB2FJy2vqSY5HneoYbTWumPAiU3Lfm3UINwmCcPksYQGF24zOTTS+JMIPxhidSm4P/yHkWeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id be5d3e32-6afb-11ef-825d-005056bdfda7;
	Wed, 04 Sep 2024 23:24:53 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 23:24:53 +0300
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
References: <20240725120729.59788-2-pstanner@redhat.com>
 <20240903094431.63551744.alex.williamson@redhat.com>
 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
 <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
 <20240904120721.25626da9.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904120721.25626da9.alex.williamson@redhat.com>

Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
> On Wed, 04 Sep 2024 15:37:25 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
> > On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:

...

> > If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> > thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> > There's only a hand full of users anyways.
> 
> What's the alternative?

From API perspective the pci_alloc_irq_vectors() & Co should be used.

> vfio-pci has a potentially unique requirement
> here, we don't know how to handle the device interrupt, we only forward
> it to the userspace driver.  As a level triggered interrupt, INTx will
> continue to assert until that userspace driver handles the device.
> That's obviously unacceptable from a host perspective, so INTx is
> masked at the device via pci_intx() where available, or at the
> interrupt controller otherwise.  The API with the userspace driver
> requires that driver to unmask the interrupt, again resulting in a call
> to pci_intx() or unmasking the interrupt controller, in order to receive
> further interrupts from the device.  Thanks,

I briefly read the discussion and if I understand it correctly the problem here
is in the flow: when the above mentioned API is being called. Hence it's design
(or architectural) level of issue and changing call from foo() to bar() won't
magically make problem go away. But I might be mistaken.

-- 
With Best Regards,
Andy Shevchenko



