Return-Path: <linux-pci+bounces-21361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF94A34A4D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAEC1897464
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB26242903;
	Thu, 13 Feb 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ryWOgEXd"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B720409A;
	Thu, 13 Feb 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464025; cv=none; b=Z4Fiu2X2iQqLnxwY+dAFZXc8ET/q12iDNdwkpe5PeWKQZcMuvSMmzDnjvG36cB7fDqIxABzKBuO7d1yRn59/xTZq+l8uYtJgyAqUhIdl9jmXk6pUzYtyBr9FdoE/JBqJlgTfv0FSbUEtKvJuLZ3W7xuwWyQNvm8bQuGpO9PHdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464025; c=relaxed/simple;
	bh=ei82bSWuNyGv8cLA27Aq/GNRp+3+6ug5Q12OFTpXsdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA9J2ZsB8u0247UKQv+SALod/BC3SlV1t39xWzx/HeBwf/eGtW4WtI3dnnKFGxPkW5xAvLHKhdu/mXj0Lnm1yUm/JZlucFFmviPJ0/ij+Lm17nVp6fCl8bmSQIjCFfZNS2zRwmMYO0L1iXlw2D0yNpFuIVHWucqVE9/r1K7PZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ryWOgEXd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hoCv9YGoA5llUMO1DS3w019F1tDGNYulVOCgZz2nIGs=; b=ryWOgEXdsk/TF9OOvLKmzxDMim
	KyP7yPuREuTwPWt7nCQ0+ViCbXjiIY01szVCEiFXo5WxR+XLk1ztWSTxm2MOo/p06JiRwKwhyTcGE
	Gb7R810BCsHOfsAn5CDRTtDX1VkxZlipdL73eoSwwWKm+D+M3pYS5zpG6PZG8kO+IZZc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tic39-00DnAG-62; Thu, 13 Feb 2025 17:26:51 +0100
Date: Thu, 13 Feb 2025 17:26:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Phil Elwell <phil@raspberrypi.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	bhelgaas@google.com, brgl@bgdev.pl,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com,
	devicetree@vger.kernel.org, dragan.cvetic@amd.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org,
	kw@linux.com, Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	lpieralisi@kernel.org, luca.ceresoli@bootlin.com,
	manivannan.sadhasivam@linaro.org, masahiroy@kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, saravanak@google.com,
	Stephen Boyd <sboyd@kernel.org>, thomas.petazzoni@bootlin.com,
	Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213171435.1c2ce376@bootlin.com>

On Thu, Feb 13, 2025 at 05:14:35PM +0100, Herve Codina wrote:
> Hi Phil,
> 
> On Thu, 13 Feb 2025 15:18:45 +0000
> Phil Elwell <phil@raspberrypi.com> wrote:
> 
> > Hi Andrea,
> > 
> > The problem with this approach (loading an overlay from the RP1 PCIe
> > driver), and it's one that I have raised with you offline, is that
> > (unless anyone can prove otherwise) it becomes impossible to create a
> > Pi 5 DTS file which makes use of the RP1's resources. How do you
> > declare something as simple as a button wired to an RP1 GPIO, or fan
> > connected to a PWM output?

Where is this button or fan? On a pluggable board? Isn't that what
overlays are for, and they are stackable. So when you probe the
pluggable board via its eeprom etc, you find the overlay and load it?

Or do you mean a custom board, which has a CPU, RP1 and the button and
fan are directly on this custom board? You then want a board DTS which
includes all these pieces?

	Andrew

