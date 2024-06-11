Return-Path: <linux-pci+bounces-8608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741BE9045A0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FE9282661
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7815218C;
	Tue, 11 Jun 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="APCG1fyL"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7CC14AD3F;
	Tue, 11 Jun 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136784; cv=none; b=DFR6tehXGeK5DO3OPF75Fq5/kYO7UOyDgJYTCEcWecOcIXWOEC+miiWwAsvRpBuTND/oE7lK6n5h6GhC9PYk5IDTK+uEGMj5cbum3kCtj09IrS8H86EBRNTXoAAHwuM6740VYq7xmVodE0TPJL3utfyNL7PDJbKvAwrzTbTl2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136784; c=relaxed/simple;
	bh=N3W/a4Lfz3f8B3FxigKAG79YiP/qLpQxtg00dXAXt08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQRuN3LiftcwDhYCtGm8Yuceb1I+Anw4oBMpy0g5bXLoIno3k6BrZnrsA+Mm2SX7FGYOHo9cF0jZGev4kkBm3iduB4xOkL+iRxUYYBzpaFZcUsV+YAhpAO0KXkrdYN9C3Z7X5E1rvyYQSEOtDaW7UwZs14KljskfQ5/Qx4BjOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=APCG1fyL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kHAoa/OJkPqP/DFn6fqwfpyDNzhM8R9ekFcSQK7Rigg=; b=APCG1fyLIzuIMJ28F/4ZogT/Ru
	kOr3vmBpRa6ef0QB73z87iuA6sx5qCC8ZWSfhHYIsu8JkfIB9d4MfJzcOwmxNabgH7S6wAHSqlTNS
	K0ti0luqp568pq8jnF+i4ZHuu0eYNrUw6XTAirNwFYV6fHECzxtKZk4Rs11j9H9fcICs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sH7rI-00HQBb-VF; Tue, 11 Jun 2024 22:12:44 +0200
Date: Tue, 11 Jun 2024 22:12:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>, clement.leger@bootlin.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: Raspberry Pi5 - RP1 driver - RFC
Message-ID: <73e05c77-6d53-4aae-95ac-415456ff0ae4@lunn.ch>
References: <ZmhvqwnOIdpi7EhA@apocalypse>
 <ba8cdf39-3ba3-4abc-98f5-d394d6867f95@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8cdf39-3ba3-4abc-98f5-d394d6867f95@gmx.net>

On Tue, Jun 11, 2024 at 09:05:24PM +0200, Stefan Wahren wrote:
> Hi Andrea,
> 
> i added Jeremy, because AFAIK he was deeply involved in ACPI
> implementation of the RPi 4.
> 
> Am 11.06.24 um 17:39 schrieb Andrea della Porta:
> > Hi,
> > I'm on the verge of reworking the RP1 driver from downstream in order for it to be
> > in good shape for upstream inclusion.
> > RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting a pletora
> > of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, etc.) whose registers
> > are all reachable starting from an offset from the BAR address.
> > The main point here is that while the RP1 as an endpoint itself is discoverable via
> > usual PCI enumeraiton, the devices it contains are not discoverable and must be
> > declared e.g. via the devicetree. This is an RFC about the correct approach to use
> > in integrating the driver and registering the subdevices.
> > 
> I cannot provide much input into the technical discussion, but i would
> prefer an approach which works good with DT and ACPI.

There is a small and slowly growing interest in using DT overlays on
ACPI systems. It makes a lot of sense when you have an already working
set of drivers based on DT, and then need to make them work on ACPI
systems.

The Microchip LAN996x is an ARM SoC with lots of peripherals and an
Ethernet switch. There is a full DT description of it and
drivers. However, it also has a PCIe interface which allows access to
all the peripherals and the Ethernet switch. Bootlin are adding
patches to allow any host with a PCIe bus use all the existing drivers
and a DT overlay to glue it all together.

https://patchwork.kernel.org/project/linux-pci/cover/20240527161450.326615-1-herve.codina@bootlin.com/

ACPI and DT should not be considered mutually exclusive.

     Andrew

