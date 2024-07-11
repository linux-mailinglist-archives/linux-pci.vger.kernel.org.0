Return-Path: <linux-pci+bounces-10178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2E92EF54
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C18F2837F3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ADA16E894;
	Thu, 11 Jul 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XihkwQLB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989B288B5;
	Thu, 11 Jul 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724934; cv=none; b=rYZlwtKnsSVXyjutyr/T5fmNF/tJtDjw+2EAjVLBG8JqiOS/s+hCEZlEzA7iukttqduPaVVj+oB6SwteIbfMSHMsyt6xa5nnJzzfvTjHgfMvz+RZMiIC2k6Rc6T8iSRnE0k3beUayhNZ0JfGKvvgRRV3Qj+o6t3uYyOCozuATF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724934; c=relaxed/simple;
	bh=PkPQTbw7deeaqSIA2QxrV/rg07ycTK/FjG1yjB7MJ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6T6XHaTaAmN8dCnEBXO3T6pJwL2gKE9BufpShEagyvdSLL8yr0ms4J3eRP+Q+YCVMKTndotpL0m//QMiNdK6/3QF55N2/WS7AvXAnUReGMaTWDmuHk4v9k3yoGjKuu81i9YoIZVqZgPqTglgLezFFxRKXKLQVh+NXUWPFuvUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XihkwQLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484EBC116B1;
	Thu, 11 Jul 2024 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720724933;
	bh=PkPQTbw7deeaqSIA2QxrV/rg07ycTK/FjG1yjB7MJ2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XihkwQLBuUN2nyJf4R0G/cEvacuTpXd+vUa2F/roD3Dxy54MUdghDUrbpTAs0Hxot
	 28l0OAiwgRxbtCcyAL0H/FetkhAJEJNM8ViyiyhqwFF0/TNwUUpVqb+scSxRml2WqU
	 ZyuctrXpC7kQZZ65ZVnaDs5hezpPhS3HqJxIEHFE=
Date: Thu, 11 Jul 2024 21:08:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	UNGLinuxDriver@microchip.com,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
Message-ID: <2024071113-motocross-escalator-e034@gregkh>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
 <20240627091137.370572-7-herve.codina@bootlin.com>
 <20240711152952.GL501857@google.com>
 <20240711184438.65446cc3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711184438.65446cc3@bootlin.com>

On Thu, Jul 11, 2024 at 06:44:38PM +0200, Herve Codina wrote:
> Hi Lee,
> 
> On Thu, 11 Jul 2024 16:29:52 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Thu, 27 Jun 2024, Herve Codina wrote:
> > 
> > > Add a PCI driver that handles the LAN966x PCI device using a device-tree
> > > overlay. This overlay is applied to the PCI device DT node and allows to
> > > describe components that are present in the device.
> > > 
> > > The memory from the device-tree is remapped to the BAR memory thanks to
> > > "ranges" properties computed at runtime by the PCI core during the PCI
> > > enumeration.
> > > 
> > > The PCI device itself acts as an interrupt controller and is used as the
> > > parent of the internal LAN966x interrupt controller to route the
> > > interrupts to the assigned PCI INTx interrupt.  
> > 
> > Not entirely sure why this is in MFD.
> 
> This PCI driver purpose is to instanciate many other drivers using a DT
> overlay. I think MFD is the right subsystem.

Please use the aux bus for that, that is what is was specifically
designed for, and what it is being used for today.

thanks,

greg k-h

