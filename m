Return-Path: <linux-pci+bounces-11105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D094476D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25131F2163E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70127157493;
	Thu,  1 Aug 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz8Mv62z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4D481DD
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503192; cv=none; b=K/1su9Y0t1s2VyiVrHA05nHrBS3iWwp9ywhPjXOnUrdlE7sojHZ+KHO1hs3ucSWEDcBhD7AfOJi4najIkkfk+aK4Jt/xm/1saXCNXcfqLU+gbBsvp+2bqqI4vAak1gQckq9m610/RVzo6ckqvbjEH82PRSKtwyWZ31/Zd4QeWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503192; c=relaxed/simple;
	bh=6aMWoNQ1AHxN3Qg6oRvD95lqeA+pnqJgADeT2Gdyd94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm/JE2dmg2WGL6GllHPlZDSQf0j4D0ZZio5cHtIxBqgTUuef/qEXMC6BW5SrN00DVx26xtvUHXnboq5zCAOyjORbS7z8BVRyQ11YJHlvJ8Zc8yhH7HasesHdjC9NLmo/xqhUTA9I9XTxZszTlcnZtEH+FDifDeCqq6+zjuRAFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz8Mv62z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B77C32786;
	Thu,  1 Aug 2024 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722503191;
	bh=6aMWoNQ1AHxN3Qg6oRvD95lqeA+pnqJgADeT2Gdyd94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz8Mv62zizeFJKQcoB8+ONCMVbghBFd54atqU6y0/97bIY3QdzURdBlr/lKLcDsWq
	 el/nvnVs84QhA00HKIceQc+LZTDGywm+wcIU2p+i5VQ4VdUuZDfXO3KEdpud/t5O08
	 /TA/nh9ZGLQ7HhQUyi4nOrjkfqu62lhbNTscdeolB1/KpIZmogIudYUBL1SjG5sNeB
	 5cTmvl2M0iY04cBdotf2FA7FUDz1rAcbXyoxXGYnwJiTwPVSkGKHMu0cyV53vOVddg
	 sE4D4ym8+yaBu9ZBVUXp9zLAR+0eAXhPIA4YgwHoRKBz/RZ/Nb8Jn3VC20kCeUFoOw
	 uyhFDzD18/iLg==
Date: Thu, 1 Aug 2024 11:06:26 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <xarpkxhakscp4zgynu2xy67de7dlb6zk7myzmuh3htja7evose@nrtr46gkyni3>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
 <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
 <p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
 <20240731135117.00004ddf@linux.intel.com>
 <2pkbi2lc46hlpwaemujtxf4rm3hokmynp6rf3vnd6vb6biatp3@qhqmeuv3lbgi>
 <Zqpd0ZgkyQtbrkfd@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqpd0ZgkyQtbrkfd@wunner.de>

On Wed, Jul 31, 2024 at 05:52:49PM +0200, Lukas Wunner wrote:
> On Wed, Jul 31, 2024 at 05:17:01PM +0200, Marek Behún wrote:
> > On Wed, Jul 31, 2024 at 01:51:17PM +0200, Mariusz Tkaczyk wrote:
> > > On Fri, 26 Jul 2024 09:29:36 +0200
> > > Marek Behún <kabel@kernel.org> wrote:
> > > 
> > > > On Thu, Jul 11, 2024 at 10:30:08AM +0200, Mariusz Tkaczyk wrote:
> > > > > Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> > > > > managing LED in storage enclosures. NPEM is indication oriented
> > > > > and it does not give direct access to LED. Although each of
> > > > > the indications *could* represent an individual LED, multiple
> > > > > indications could also be represented as a single,
> > > > > multi-color LED or a single LED blinking in a specific interval.
> > > > > The specification leaves that open.  
> > > > 
> > > > The specification leaves it open, but isn't there a way to determine
> > > > how it is implemented? In ACPI, maybe?
> > > 
> > > What would be a point of that? There are blinking patterns standards for 2-LED
> > > systems and 3-LED systems but NPEM is projected to not be limited to
> > > the led system you have. I mean that we shouldn't try to determine what hardware
> > > does - it belongs to hardware. Kernel task is just to read what NPEM registers
> > > are presenting and trust it.
> > 
> > My point is about what a LED class device in kernel means, and what the brightness
> > attribute means (in terms of intended behavior).
> > One LED class device should represent one hardware LED (possibly multicolor), and
> > nothing else.
> > Setting the brightness attribute to the value of max_brightness should light the LED
> > on, and setting it to 0 should light it off.
> > So if on some device doing
> >   echo 1 >brightness
> > makes the LED for example blink, it is wrong.
> > 
> > That's why I am asking whether it is possible to determine what the hardware is
> > doing from some description, like ACPI or device-tree.
> 
> The PCIe Base Specification and the PCI Firmware Specification do not
> provide a way to query what the effect of a set bit will be.
> 
> We've had lengthy mailing list discussions how to represent NPEM bits
> in the kernel.  Representing each bit as a distinct led_classdev seemed
> like the most reasonable way and I thought we had reached consensus
> on that.  Objecting against the chosen representation at this point,
> not to mention without suggesting a better alternative, is unreasonable
> from my point of view.

There are lenghty mailing list discussions all the time, e.g. the
multi-color LED framework took several years to work out. But yes, it
was a pain...

It is not my intention to be unreasonable, I am just asking questions.
I am sorry for getting into this discussion this late.

> I think it is reasonable to assume that usually each bit is a distinct
> LED.  The spec doesn't rule out other form factors, such as multiple
> bits being represented by distinct colors of a multi-color LED.
> However I think such form factors will remain esoteric and theoretical
> for the most part.  We need to be pragmatic here.
> 
> 
> > If setting brightness to 1 makes some LED blink (without a LED trigger), than
> > the device does not behave according to the LED class expectations.
> [...]
> > Look for example at the netdev trigger. Originally it was software only, and you
> > could set it up so that it would for example blink on rx/tx activity of a network
> > interface.
> 
> I think you're confusing two different things:
> 
> "Blinking" in the rx/tx activity context means that the LED is turned on
> when traffic is flowing and off when it is not flowing.  Because traffic
> is usually not flowing constantly, the LED is "blinking".
> 
> In the NPEM context, my understanding is "blinking" means the LED turns
> on or off *in a regular interval* to indicate that the corresponding
> NPEM bit has been set.

Ah! So the LEDs states is not supposed to be managed by hardware,
but by software? From the userspace?

Marek

