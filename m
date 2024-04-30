Return-Path: <linux-pci+bounces-6886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A950E8B775A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626812827BC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8533171E62;
	Tue, 30 Apr 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KV0j+Kvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821F85956;
	Tue, 30 Apr 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484439; cv=none; b=UQMUCaV6APhhFazoJYeiFBd3rwotNI9E07EiRPmFAuD1odCheIQ/4PAikrW2284rncOgLLOiBWNDTEgFfJRLRMxe77B6d0dlxNDpjXTrCLP5JzNluqUZqR3UibAcFNSdOdUNJSJkuBhCuPFx8iVkzDbyKCNJYcBnA1PNyy/blVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484439; c=relaxed/simple;
	bh=ZTYH03z4YSkkewuHlkyQiJdNerzGEwiVi62NucA1JRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdtgKB6Cg7+SFiCObHS9sChU3rmYbv5JUNG7tevBZ4YPdc2bgrlyRsNVqEYXNzZe69JVr5Qs9rPKT3F74vDieNfe1jHrJyN96a2ChPjo07ZEuM7hv4toTavF59mPE3XBxHwY4AjpHbTmtEwHPYBqsbr7j0F6tli+a/CHTJplQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KV0j+Kvh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mkRUaVu7YuLLbPG/sEIdKbsrNJjXmv2kqwxQ10HArmo=; b=KV0j+KvhT099ZYRt0grZJXeYui
	+izqQo/8eCvLo1wM/5GXYbkF3pgdoBmjzpQNaBHXGWVoWCj9sRl9uMPuVrL8BmhTZ4jTavfGnnDfr
	SsOB0cwpE3xcfnSRde77OLZStLtE7VPssEhuEm4HMZ4+t29yXXn32HWwsbuajZiqxAok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1niS-00ELH5-3S; Tue, 30 Apr 2024 15:40:16 +0200
Date: Tue, 30 Apr 2024 15:40:16 +0200
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
Message-ID: <4571846d-2001-4bbf-b311-d0b42844143d@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:09AM +0200, Herve Codina wrote:
> Hi,
> 
> This series adds support for the LAN966x chip when used as a PCI
> device.

> This patch series for now adds a Device Tree overlay that describes an
> initial subset of the devices available over PCI in the LAN996x, and
> follow-up patch series will add support for more once this initial
> support has landed.

What host systems have you tested with? Are they all native DT, or
have you tested on an ACPI system? I'm just wondering how well DT
overlay works if i were to plug a LAN966x device into something like
an x86 ComExpress board?

	Andrew

