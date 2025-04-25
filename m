Return-Path: <linux-pci+bounces-26756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32255A9CA08
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6971F1BC42F4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE278F2D;
	Fri, 25 Apr 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i1aRFLeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB835695;
	Fri, 25 Apr 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587203; cv=none; b=q0Kdl01Se7wHYCfIuhd2Pu/xmvFZ64z1WdMB5LK+38lpkMS7gOyeWsFTCSlzQW3FSDkMqfGPPHVqd3R4NFhnIFeCApk/bMaYFI+2oDZ4IPeultFtgs47uYmsqANQBCrP5dyVe96XEPFU0N6qBTSnvXuDkjvO8Mv5ExkPVPpZ6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587203; c=relaxed/simple;
	bh=Mb1PcuxuqGZBuRSePtPlbyzRcP49+xM4Om4ipDtwN20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlX606AVy5mLi4xbhdYIRUUDgFtQ9DVeCLjIoghPeK1tTDHz9Ayt9J/igZTY9xhkbIZmTDq4HvZH/YMDuOWvRV9CS1BZIvWruOM/dyNzJXXLwAtu0MvxsV4/3HAyOQM6qcQNy0qqNs8ojx/IWeZ8B1ZJgpRBZbu9odk1W6fwW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i1aRFLeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452C3C4CEE4;
	Fri, 25 Apr 2025 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745587202;
	bh=Mb1PcuxuqGZBuRSePtPlbyzRcP49+xM4Om4ipDtwN20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1aRFLeYLDF4zMUJDOaNISIavzGnIsPK/X2Trk7AjYOsXODOBT5fM6VcZMTr5m51w
	 PGZ7Z1wXOW5n7ew+GToxDyQdb8ih1xZBxl0b7ca/Mb4Af0TLV/f6RJOZn4v4+Isllh
	 AiMuzIYINZJrnUkSjKnS7LPuDVrTyxf20k7sgycQ=
Date: Fri, 25 Apr 2025 15:20:00 +0200
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
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v9 -next 07/12] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <2025042551-agency-boozy-dc3b@gregkh>
References: <cover.1745347417.git.andrea.porta@suse.com>
 <e971e31f6a14af608bba2f09b8c749f619381ac0.1745347417.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e971e31f6a14af608bba2f09b8c749f619381ac0.1745347417.git.andrea.porta@suse.com>

On Tue, Apr 22, 2025 at 08:53:16PM +0200, Andrea della Porta wrote:
> The RaspberryPi RP1 is a PCI multi function device containing
> peripherals ranging from Ethernet to USB controller, I2C, SPI
> and others.
> 
> Implement a bare minimum driver to operate the RP1, leveraging
> actual OF based driver implementations for the on-board peripherals
> by loading a devicetree overlay during driver probe if the RP1
> node is not already present in the DT.
> 
> The peripherals are accessed by mapping MMIO registers starting
> from PCI BAR1 region.
> 
> With the overlay approach we can achieve more generic and agnostic
> approach to managing this chipset, being that it is a PCI endpoint
> and could possibly be reused in other hw implementations. The
> presented approach is also used by Bootlin's Microchip LAN966x
> patchset (see link) as well, for a similar chipset.
> In this case, the inclusion tree for the DT overlay is as follow
> (the arrow points to the includer):
> 
>  rp1-pci.dtso <---- rp1-common.dtsi
> 
> On the other hand, to ensure compatibility with downstream, this
> driver can also work with a DT already comprising the RP1 node, so
> the dynamically loaded overlay will not be used if the DT is already
> fully defined.
> 
> The reason why this driver is contained in drivers/misc has
> been paved by Bootlin's LAN966X driver, which first used the
> overlay approach to implement non discoverable peripherals behind a
> PCI bus. For RP1, the same arguments apply: it's not used as an SoC
> since the driver code is not running on-chip and is not like an MFD
> since it does not really need all the MFD infrastructure (shared regs,
> etc.). So, for this particular use, misc has been proposed and deemed
> as a good choice. For further details about that please check the links.
> 
> This driver is heavily based on downstream code from RaspberryPi
> Foundation, and the original author is Phil Elwell.
> 
> Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> Link: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
> Link: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
> Link: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/
> Link: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # quirks.c, pci_ids.h
> ---
>  MAINTAINERS                   |   1 +
>  drivers/misc/Kconfig          |   1 +
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/rp1/Kconfig      |  20 ++
>  drivers/misc/rp1/Makefile     |   3 +
>  drivers/misc/rp1/rp1-pci.dtso |  25 +++
>  drivers/misc/rp1/rp1_pci.c    | 333 ++++++++++++++++++++++++++++++++++
>  drivers/pci/quirks.c          |   1 +
>  include/linux/pci_ids.h       |   3 +
>  9 files changed, 388 insertions(+)
>  create mode 100644 drivers/misc/rp1/Kconfig
>  create mode 100644 drivers/misc/rp1/Makefile
>  create mode 100644 drivers/misc/rp1/rp1-pci.dtso
>  create mode 100644 drivers/misc/rp1/rp1_pci.c


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

