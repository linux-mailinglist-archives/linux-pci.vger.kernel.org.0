Return-Path: <linux-pci+bounces-25931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C27A8A3D8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 18:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E853BD177
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4B1FDA9B;
	Tue, 15 Apr 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pztQCA3m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38802DFA41;
	Tue, 15 Apr 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733699; cv=none; b=W424lMifkqOYvkzCi0CTCpZ7IPwuwuyvrbRaWb4OuAJrFnrZHhK9ZjcFPmrmIf5OSmul+DfWBLZUXKrQYku/kWhLaxxAym6WyqqSf/Hohp7wwyaQ8BWWrOaQyQemofWZAcJimqm8H6u0y2hNZieeB02eRt+6JobzZXiBZUDwO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733699; c=relaxed/simple;
	bh=U/rKNYDUD8j6QMOYLJ34Ll3gyPFM6SLKNxk//x2JQP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm7ucF6UbYQxmjmbeXLawz2Aq4/7Rjl+b8UfzgZmkqQ7XtK1B22Vrg8DNOhnABlONGtvxqHz3GG8FsE60locFTTKJL4+7Mm2LBCdsuEODIpxuaGlC1OagcwzoMJUVmxNTqtMsiF+XFKzaj5FSj3uR3NtlmFILd19gW/YtIvj1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pztQCA3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E4C4CEEB;
	Tue, 15 Apr 2025 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744733698;
	bh=U/rKNYDUD8j6QMOYLJ34Ll3gyPFM6SLKNxk//x2JQP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pztQCA3m4GCim/1wSoY8Mu8F8hiIGUr0WM7lChdgo6fkoAulk7Da+VoWMtvINe60v
	 o0eezdUCv+z2WE8DZF6zM1Ra2I8U+5eiZLlBGNASYIpAQD0Z16N9YYS0vmCWJ1gINx
	 ehq9XyP/8CEQDI9/XyTxr1znYNaP1Pjy2m31UCRc=
Date: Tue, 15 Apr 2025 18:14:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 08/13] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <2025041530-random-cheek-125d@gregkh>
References: <cover.1742418429.git.andrea.porta@suse.com>
 <3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>
 <2025041557-masculine-abrasive-c372@gregkh>
 <20250415165505.0c05bc61@bootlin.com>
 <2025041531-dubiously-duchess-276a@gregkh>
 <Z_5-Jjbu6XoHGmxN@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_5-Jjbu6XoHGmxN@apocalypse>

On Tue, Apr 15, 2025 at 05:41:26PM +0200, Andrea della Porta wrote:
> Hi Greg,
> 
> On 17:14 Tue 15 Apr     , Greg Kroah-Hartman wrote:
> > On Tue, Apr 15, 2025 at 04:55:05PM +0200, Herve Codina wrote:
> > > Hi Greg,
> > > 
> > > On Tue, 15 Apr 2025 16:06:43 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Wed, Mar 19, 2025 at 10:52:29PM +0100, Andrea della Porta wrote:
> > > > > The RaspberryPi RP1 is a PCI multi function device containing
> > > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > > and others.  
> > > > 
> > > > So shouldn't this be using the auxbus code?  That's designed to "split
> > > > up" PCI devices such that you can share them this way.
> > > > 
> > > > Or did that get rejected somewhere previously?
> > > > 
> > > 
> > > It doesn't use auxbus probably for the exact same reason that the
> > > one given for the LAN966x PCI device driver [0] and [1].
> > > 
> > > Avoid all boiler plate needed with auxbus whereas drivers already exist
> > > as platform drivers. Internal devices are handled by those platform drivers.
> > > Those devi just need to be described as platform devices and device-tree is
> > > fully relevant for that description.
> > > 
> > > [0] https://lore.kernel.org/all/CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com/
> > > [1] https://lore.kernel.org/all/Y9kuxrL3XaCG+blk@kroah.com/
> > 
> > I really hate creating platform devices below a PCI device, so I'll keep
> > complaining about this every time people try to do it.
> 
> I agree with you, but as Herve has already pointed out this would mean incurring
> in significant work to adapt drivers for all the peripherals (there are quite a
> few), while with this approach they would be left untouched.

We have no problem with reworking existing drivers, especially if they
will be doing the correct thing.  Don't let that be an excuse, it
doesn't work with me, sorry :)

greg k-h

