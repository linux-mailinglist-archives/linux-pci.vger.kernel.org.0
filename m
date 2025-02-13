Return-Path: <linux-pci+bounces-21370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B37A34C5D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC6169F07
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB282222C1;
	Thu, 13 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3lUL0Egm"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5928A2D6;
	Thu, 13 Feb 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469067; cv=none; b=l3tdVYih1H9w+IcFkaTDLoUhDiPyYe7ZospWBAY8uFGCErbJ65/BU0VciVZQkpv/KUciS9sU1Ii11hQA0Lqs73oi/5tPliofBVXrsq93ekTeVTpmic8kC+EQV1Wmex7xYppz7uVv/TIBDauWU2A2K6A7NjlhkHRRLMuURkWEF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469067; c=relaxed/simple;
	bh=pmHJGGnsgYsxAll7fDYauvZrEGwv6ShLnDby7IECvu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cstzeLc0w1oSoVi+f0NAdv2uV8XAqfG2F5LcqNlh6rx767+uLAfMHJQCNd6k7aaKFsIjTW1Gc0UsKzriAKHzRP5fgJ7+gjpAUo07WG7OuW8Vzg2n1r1AELLm2KHoNo17Ae1nT04e1zpJrm12/JAsyHh7OR28j91KqJScmN7VTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3lUL0Egm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bs/dGVyRCitGyRnKeO7eQH7D6LwuR+L9Z8qdseSmZMw=; b=3lUL0EgmfyZf/wkO37FxVODerw
	A2+xMSFgX1tWtMGJYwAlzAHNhZpGGZPAR6GN7ZJC1m2g4L97tv8vqHRsiLwwkP7jKEgJnuXJwnlRV
	VFLwQmFuWJx26AmBrSTraGl3EBd6LfK3WU4cIPs6sToJfeYxLFGvQ1+OkBNgL96w/V5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tidMY-00DoWf-A2; Thu, 13 Feb 2025 18:50:58 +0100
Date: Thu, 13 Feb 2025 18:50:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Phil Elwell <phil@raspberrypi.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <07b973c1-4e35-440c-9009-85302a455912@lunn.ch>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com>
 <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
 <CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
 <20250213180733.11999e07@bootlin.com>
 <CAMEGJJ2FB-wwyOtjjCmPJ-vUDpZaV-8MMXxV13qXnKxYSzt9pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ2FB-wwyOtjjCmPJ-vUDpZaV-8MMXxV13qXnKxYSzt9pw@mail.gmail.com>

> etc. The same problem would exist for U-boot. Even though RP1 has a
> standard XHCI controller

Although it is a standard XHCI controller, i assume it is not a PCIe
XHCI controller which can just be enumerated as a PCIe device?

	Andrew

