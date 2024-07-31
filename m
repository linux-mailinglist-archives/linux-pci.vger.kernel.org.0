Return-Path: <linux-pci+bounces-11063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60A9433AD
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB02E1F27E98
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB391B581A;
	Wed, 31 Jul 2024 15:53:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947D1A3BD5
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441180; cv=none; b=gwiPMiwg0xi6VXYxesIVEV4sN6qWaLjL1y+VYZkah3j0u4Pi/8HeNk57Pwqvk4/anLtBIZh0n8sIK3AQ6R8XfsazmiknBcuMB9Rz0O+i2zEtJXYybV0ZCTNkprwc/1Iehona2IxZNGKUfIN6LYhA0tnf3rq00mlOs0E3UnnnRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441180; c=relaxed/simple;
	bh=/FBVO6rkJZuYxhP5B6tW2Tzly2lpj1Sv7DFllfgKHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR+jecxo2ux9Q+0eev1WaCFgCm9pnqIyB+XDIAIdbpwVTw98I1mF6LtqY7aLlksNfXalkQGhCdQokFDDzDEa6MzRfC3dLNE2BX6t/QBLOeqAiHRn5TA9W14Zq4U1Y9Jpb3VAzWxCBOb1plu9ROsnddJ+VXD5AJN+Jh0PWEsiccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4ED01100DA1D3;
	Wed, 31 Jul 2024 17:52:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 20BF55D66B; Wed, 31 Jul 2024 17:52:49 +0200 (CEST)
Date: Wed, 31 Jul 2024 17:52:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zqpd0ZgkyQtbrkfd@wunner.de>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
 <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
 <p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
 <20240731135117.00004ddf@linux.intel.com>
 <2pkbi2lc46hlpwaemujtxf4rm3hokmynp6rf3vnd6vb6biatp3@qhqmeuv3lbgi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2pkbi2lc46hlpwaemujtxf4rm3hokmynp6rf3vnd6vb6biatp3@qhqmeuv3lbgi>

On Wed, Jul 31, 2024 at 05:17:01PM +0200, Marek Behún wrote:
> On Wed, Jul 31, 2024 at 01:51:17PM +0200, Mariusz Tkaczyk wrote:
> > On Fri, 26 Jul 2024 09:29:36 +0200
> > Marek Behún <kabel@kernel.org> wrote:
> > 
> > > On Thu, Jul 11, 2024 at 10:30:08AM +0200, Mariusz Tkaczyk wrote:
> > > > Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> > > > managing LED in storage enclosures. NPEM is indication oriented
> > > > and it does not give direct access to LED. Although each of
> > > > the indications *could* represent an individual LED, multiple
> > > > indications could also be represented as a single,
> > > > multi-color LED or a single LED blinking in a specific interval.
> > > > The specification leaves that open.  
> > > 
> > > The specification leaves it open, but isn't there a way to determine
> > > how it is implemented? In ACPI, maybe?
> > 
> > What would be a point of that? There are blinking patterns standards for 2-LED
> > systems and 3-LED systems but NPEM is projected to not be limited to
> > the led system you have. I mean that we shouldn't try to determine what hardware
> > does - it belongs to hardware. Kernel task is just to read what NPEM registers
> > are presenting and trust it.
> 
> My point is about what a LED class device in kernel means, and what the brightness
> attribute means (in terms of intended behavior).
> One LED class device should represent one hardware LED (possibly multicolor), and
> nothing else.
> Setting the brightness attribute to the value of max_brightness should light the LED
> on, and setting it to 0 should light it off.
> So if on some device doing
>   echo 1 >brightness
> makes the LED for example blink, it is wrong.
> 
> That's why I am asking whether it is possible to determine what the hardware is
> doing from some description, like ACPI or device-tree.

The PCIe Base Specification and the PCI Firmware Specification do not
provide a way to query what the effect of a set bit will be.

We've had lengthy mailing list discussions how to represent NPEM bits
in the kernel.  Representing each bit as a distinct led_classdev seemed
like the most reasonable way and I thought we had reached consensus
on that.  Objecting against the chosen representation at this point,
not to mention without suggesting a better alternative, is unreasonable
from my point of view.

I think it is reasonable to assume that usually each bit is a distinct
LED.  The spec doesn't rule out other form factors, such as multiple
bits being represented by distinct colors of a multi-color LED.
However I think such form factors will remain esoteric and theoretical
for the most part.  We need to be pragmatic here.


> If setting brightness to 1 makes some LED blink (without a LED trigger), than
> the device does not behave according to the LED class expectations.
[...]
> Look for example at the netdev trigger. Originally it was software only, and you
> could set it up so that it would for example blink on rx/tx activity of a network
> interface.

I think you're confusing two different things:

"Blinking" in the rx/tx activity context means that the LED is turned on
when traffic is flowing and off when it is not flowing.  Because traffic
is usually not flowing constantly, the LED is "blinking".

In the NPEM context, my understanding is "blinking" means the LED turns
on or off *in a regular interval* to indicate that the corresponding
NPEM bit has been set.

Thanks,

Lukas

