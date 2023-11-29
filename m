Return-Path: <linux-pci+bounces-238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D207FD55A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 12:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ED21C20D62
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8751C2B2;
	Wed, 29 Nov 2023 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ABD2101
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 03:17:42 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C2324100D9414;
	Wed, 29 Nov 2023 12:17:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8859AE45B; Wed, 29 Nov 2023 12:17:39 +0100 (CET)
Date: Wed, 29 Nov 2023 12:17:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Wolfram Sang <wsa@kernel.org>,
	Jean Delvare <jdelvare@suse.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [bug report] lockdep WARN at PCI device rescan
Message-ID: <20231129111739.GA14152@wunner.de>
References: <6xb24fjmptxxn5js2fjrrddjae6twex5bjaftwqsuawuqqqydx@7cl3uik5ef6j>
 <ZVNJCxh5vgj22SfQ@shikoro>
 <ea31480f-2887-41fe-a560-f4bb1103479e@gmail.com>
 <ZVNiUuyHaez8rwL-@smile.fi.intel.com>
 <20231114155701.GA27547@wunner.de>
 <ZVOcPOlkkBk3Xfm5@smile.fi.intel.com>
 <ZVO1M2289uvElgOi@smile.fi.intel.com>
 <eaawoi5jqrwnzq3scgltqxj47faywztn4lbpkz4haugxvgu5df@koy3qciquklu>
 <ZWC_0eG2UBMKAD3C@smile.fi.intel.com>
 <2vzf5sj76j3p747dfbhnusu5daxzog25io4s7d5uvzvtghvo24@567tghzifylu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vzf5sj76j3p747dfbhnusu5daxzog25io4s7d5uvzvtghvo24@567tghzifylu>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 28, 2023 at 07:45:06AM +0000, Shinichiro Kawasaki wrote:
> On Nov 24, 2023 / 17:22, Andy Shevchenko wrote:
> > Another possible solution I was thinking about is to have a local cache,
> > so, make p2sb.c to be called just after PCI enumeration at boot time
> > to cache the P2SB device's bar, and then cache the bar based on the device
> > in question at the first call. Yet it may not remove all theoretical /
> > possible scenarios with dead lock (taking into account hotpluggable
> > devices), but won't fail the i801 driver in the above use case IIUC.
> 
> Thanks for the idea. I created an experimental patch below (it does not guard
> list nor free the list elements, so it is incomplete). I confirmed that this
> patch avoids the deadlock. So your idea looks working. I still observe the
> deadlock WARN, but it looks better than the hang by the deadlock.

Your patch uses a list to store a multitude of struct resource.
Is that actually necessary?  I thought there can only be a single
P2SB device in the system?

> Having said that, Heiner says in another mail that "A solution has to support
> pci drivers using p2sb_bar() in probe()". This idea does not fulfill it. Hmm.

Basically what you need to do is create two initcalls:

Add one arch_initcall to unhide the P2SB device.

The P2SB subsequently gets enumerated by the PCI core in a subsys_initcall.

Then add an fs_initcall which extracts and stashes the struct resource,
hides the P2SB device and destroys the corresponding pci_dev.

Then you don't need to acquire any locks at runtime, just retrieve the
stashed struct resource.

This approach will result in the P2SB device briefly being enumerated
and a driver could in theory bind to it.  Andy, is this a problem?
I'm not seeing any drivers in the tree which bind to 8086/c5c5.

Thanks,

Lukas

