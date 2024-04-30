Return-Path: <linux-pci+bounces-6901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB68B7F89
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5BE1F23B04
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E5181B9D;
	Tue, 30 Apr 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OVcErK7x"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF95179650;
	Tue, 30 Apr 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500918; cv=none; b=DmhQMOCBpJyRzvyg8dozXdkPCRKQWjuYT3uS3On2LBacUMMNzD2WNsZmae707r/+SNVRiBvBuHFN1WKjGj2DUR1lvYL28rky8YTXKfpYoY/S9lvElsr0SLzc3XR2e4wCD9zzswjWQHxhK+FG3C1TuCRZUcY8Imvjefn9ZUl5Jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500918; c=relaxed/simple;
	bh=X8HAYBAZH/nxmniE/1cqLRfga2wy39yx06ebZq3l3/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnB4i8G6E52Tkt4AxJmdTz4+zs1IY0hc9pG9yg8GxICNL+e3oKWdZo6xdsDpl6CZ9fWg/eltVxMBOkD7n1SSGC5XNr9lUV7USqAbJDVZx8QWoJTr64sCGlvPbxpuAoWnQYWEayZ7kcO7F+ndqxF4qSToqIeSMIhn64dU3cYXU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OVcErK7x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nAD2Nur76Zf3BvEl9/PM5+Xuqr6DOFdCXMuTEX+Eofc=; b=OVcErK7xVvv+7h/GyB1FfYeATt
	GuyC1O656IqIK7sSzG67XDlzH87FmguF+ApCOreR3W3jt3z1XSVmEdEDo18q/wtuOcAUwH8c31/Ik
	Y9LDrlvKgM8r1xPAFiCvuPo5jjnwWhyBQgYr+VG10ksQe7DNIZO64/XEVxD1JlW1Dp6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1s0O-00ENI1-GV; Tue, 30 Apr 2024 20:15:04 +0200
Date: Tue, 30 Apr 2024 20:15:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 00/17] Add support for the LAN966x PCI device using a DT
 overlay
Message-ID: <dbbf505b-c3ed-4d2d-b518-f322636269a2@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <4571846d-2001-4bbf-b311-d0b42844143d@lunn.ch>
 <20240430183301.46568e35@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430183301.46568e35@bootlin.com>

> Also I tested on a x86 system (basically a simple PC).
> Not all components are available upstream to have it working on a x86 (ACPI)
> system. The missing component is not related to the LAN966x PCI driver itself
> but in the way DT node are created up to the PCI device.

Good to hear it nearly "just works". There does not seem to be any
interest in describing complex network devices like this using ACPI,
which is many years behind what we have in DT in terms of building
blocks for networking devices. Like many PCIe devices, the LAN966x is
pretty much self contained, so fits DT overlays nicely.

There is also a slowly growing trend to have PCIe network devices
which Linux controls, rather than offloading to firmware. The wangxun
drivers are another example. So it is great to see the remaining
pieces being put in place to support this.

Thanks
	Andrew

