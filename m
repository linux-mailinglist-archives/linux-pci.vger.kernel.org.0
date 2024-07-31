Return-Path: <linux-pci+bounces-11062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC8943326
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF36B25A8A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ADD1BBBF3;
	Wed, 31 Jul 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXuntqUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C212B73
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439031; cv=none; b=jlMaUoCnhfFfHYO8BHICX1D6X89i7b9aOAWKpAxi5lZikE6GWOGWqDB7vc6ro10WlmcNDV39ytenvwtGAF4OBLuUnDNOfTSLS+nyDOXe59rpzfmNnD1Qt8DuB7QdGzDG3lm3YgLGVri0kWZBgzhNd2r73QfShEznErGoGpEKRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439031; c=relaxed/simple;
	bh=ef6UymW2WdC/zvRwvYxf6wOFNRUSoK0602TpzhMKCfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi9EnVvLfEh2STqmgzQk4h86zgzrYmGMJKLLHairN7TXoYL3glad6J+2sInvrVrRYfpI9PSHFbU4vYC0kaOURYyVm+cOtE9zll/18zrrkwaIgmfRtz+Avp9vNxi6/Qf2UEo2OxHrMWxcZdLZH6+SUKBqG2CsjqM7smExVKwAiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXuntqUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F2C116B1;
	Wed, 31 Jul 2024 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722439031;
	bh=ef6UymW2WdC/zvRwvYxf6wOFNRUSoK0602TpzhMKCfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXuntqUd2Xl7JDF2Og+AijiH7363SZGAvPrEBIalGcGLSF68nHCQ5fWuHOQAFzj7t
	 kDHsmQ4sfC/yo2OLa+oYBcZ3uhvWPQJ+U0qEe5iH+7EXmlEfa6Njay9k3jCs/xCCdL
	 48FhExJnHhlbF25jfqQkT903emdUinLCJjg5ltNsTVq5Xhl0RO8wZstS9vNe/d52Du
	 AMooP1YeYC+gPtiFqKtOHshRdNeexZiXsuH5ADS1jsG/KR9YhsPtiVmiGhaNXKwcLA
	 X+P6kgyA0wzOwaxqQKLiY+xirbkWxIIYrQktZD8zk+0mHUsQJXEWdMOhXiA1yzv1h9
	 Mj5Hyr78sgHDA==
Date: Wed, 31 Jul 2024 17:17:01 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Keith Busch <kbusch@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <2pkbi2lc46hlpwaemujtxf4rm3hokmynp6rf3vnd6vb6biatp3@qhqmeuv3lbgi>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
 <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
 <p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
 <20240731135117.00004ddf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731135117.00004ddf@linux.intel.com>

On Wed, Jul 31, 2024 at 01:51:17PM +0200, Mariusz Tkaczyk wrote:
> On Fri, 26 Jul 2024 09:29:36 +0200
> Marek Behún <kabel@kernel.org> wrote:
> 
> > On Thu, Jul 11, 2024 at 10:30:08AM +0200, Mariusz Tkaczyk wrote:
> > > Native PCIe Enclosure Management (NPEM, PCIe r6.1 sec 6.28) allows
> > > managing LED in storage enclosures. NPEM is indication oriented
> > > and it does not give direct access to LED. Although each of
> > > the indications *could* represent an individual LED, multiple
> > > indications could also be represented as a single,
> > > multi-color LED or a single LED blinking in a specific interval.
> > > The specification leaves that open.  
> > 
> > The specification leaves it open, but isn't there a way to determine
> > how it is implemented? In ACPI, maybe?
> 
> 
> What would be a point of that? There are blinking patterns standards for 2-LED
> systems and 3-LED systems but NPEM is projected to not be limited to
> the led system you have. I mean that we shouldn't try to determine what hardware
> does - it belongs to hardware. Kernel task is just to read what NPEM registers
> are presenting and trust it.

Hi.

My point is about what a LED class device in kernel means, and what the brightness
attribute means (in terms of intended behavior).
One LED class device should represent one hardware LED (possibly multicolor), and
nothing else.
Setting the brightness attribute to the value of max_brightness should light the LED
on, and setting it to 0 should light it off.
So if on some device doing
  echo 1 >brightness
makes the LED for example blink, it is wrong.

That's why I am asking whether it is possible to determine what the hardware is
doing from some description, like ACPI or device-tree.

If setting brightness to 1 makes some LED blink (without a LED trigger), than
the device does not behave according to the LED class expectations.

> I can realize NPEM with separate LED for each indication. Who knows, maybe in
> the future it would become real.
> 
> > 
> > > Each enabled indication (capability register bit on) is represented as a
> > > ledclass_dev which can be controlled through sysfs. For every ledclass
> > > device only 2 brightness states are allowed: LED_ON (1) or LED_OFF (0).
> > > It is corresponding to NPEM control register (Indication bit on/off).
> > > 
> > > Ledclass devices appear in sysfs as child devices (subdirectory) of PCI
> > > device which has an NPEM Extended Capability and indication is enabled
> > > in NPEM capability register. For example, these are leds created for
> > > pcieport "10000:02:05.0" on my setup:
> > > 
> > > leds/
> > > ├── 10000:02:05.0:enclosure:fail
> > > ├── 10000:02:05.0:enclosure:locate
> > > ├── 10000:02:05.0:enclosure:ok
> > > └── 10000:02:05.0:enclosure:rebuild
> > > 
> > > They can be also found in "/sys/class/leds" directory. Parent PCIe device
> > > bdf is used to guarantee uniqueness across leds subsystem.
> > > 
> > > To enable/disable fail indication "brightness" file can be edited:
> > > echo 1 > ./leds/10000:02:05.0:enclosure:fail/brightness
> > > echo 0 > ./leds/10000:02:05.0:enclosure:fail/brightness  
> > 
> > Have you considered implemtening this via a led trigger?
> > 
> > Something like:
> >   echo pcie-enclosure > /sys/class/leds/<LED>/trigger
> >   echo 1 >/sys/class/leds/<LED>/fail
> > but properly thought up.
> > 
> 
> No I didn't. I understand the triggers as an actions that may involve led
> change we can configure. I thought, it should be cross driver reference (for
> example, change LED if keyboard capslock is pressed) and triggers are optional.
> 
> For that reasons I did not consider it. Please explain this concept in details.
> 
> I think that forcing one and only trigger you can use may we even worse because
> it seems to be definitely design incompatible (triggers are optional) but I'm
> not an expert.

Look for example at the netdev trigger. Originally it was software only, and you
could set it up so that it would for example blink on rx/tx activity of a network
interface.

But recently it gained support to offload this blinking to hardware: some LEDs
are wired from ethenret PHYs, and on those PHYs you can set it in hardware that
the LED will blink on rx/tx activity (or something else).

So now if the netdev trigger determines that the LED is connected to the PHY of
a network interface, and that network interface is set to be triggering the LED,
it will offload the blinking to hardware.

Marek

