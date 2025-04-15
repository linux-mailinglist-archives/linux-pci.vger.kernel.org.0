Return-Path: <linux-pci+bounces-25925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B1A8A0A1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B1F16B78D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8C19F424;
	Tue, 15 Apr 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qC3uhRPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0619F11E;
	Tue, 15 Apr 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726007; cv=none; b=sUWD0RH6TmIa0D2BMbYuhcEEadQ+1x/Al66HmTzScQxdmKPfLkzK5GZZ9JOyjZO81DI6GvRdDPKaSZA9pcxfzgtjXe5RSc/JzTkQSClAGHYQH9TzXULy1N7i6DjR+NR57y3GOJA6q8C3IwdBXnhN1bwIYvIucnXRhY0Hh8nllkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726007; c=relaxed/simple;
	bh=5R+P+61yjWCLyWO0f2cqLH+Fy16+sPPkuyyk/+Zka7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY2VeCNKJAi03zj9HPGaOEfC0etEQVYQI8l6ht3aML4dxlR1fvqyNO0ekfxa2hG5eI1Ul5f1vuOCAbagggNuVRqcgWDxcbmEaYwSNZ6MOBb/he004yW9CQkfxCn6/nVrxC2f9OnhdrNvQmg6gQSV47oZ3xGHwQ/2b32vc8KzX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qC3uhRPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41828C4CEDD;
	Tue, 15 Apr 2025 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744726006;
	bh=5R+P+61yjWCLyWO0f2cqLH+Fy16+sPPkuyyk/+Zka7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qC3uhRPIbslUm77+PFbJfUe1oz9Yirkx+P3gHQs8yggrozy3dyq0lwIapRGl+Pkuk
	 E6Z/mvUUOsCrcQVMxJHzankie4kUbzO0H4mckhNAxcLeyxQsk0nzKxfourC0cKKTel
	 bHO4hTQ6obreVqxYyF80bqtCbyQPgEXDno/n9Mk0=
Date: Tue, 15 Apr 2025 16:06:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 08/13] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <2025041557-masculine-abrasive-c372@gregkh>
References: <cover.1742418429.git.andrea.porta@suse.com>
 <3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>

On Wed, Mar 19, 2025 at 10:52:29PM +0100, Andrea della Porta wrote:
> The RaspberryPi RP1 is a PCI multi function device containing
> peripherals ranging from Ethernet to USB controller, I2C, SPI
> and others.

So shouldn't this be using the auxbus code?  That's designed to "split
up" PCI devices such that you can share them this way.

Or did that get rejected somewhere previously?

thanks,

greg k-h

