Return-Path: <linux-pci+bounces-8559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99211902AB0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 23:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424401F22AE1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 21:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49A143886;
	Mon, 10 Jun 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK7GeKlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5A6F31F;
	Mon, 10 Jun 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055456; cv=none; b=j/jCdumX0gK+sxw8ooFh51hNEVyAJkKl0PBjfNw+RrFAPV1Qakfcq3pil6ueKiWY4iAHrmBYWuIEwn9A1u3uil6x9VqvK+i7GVQXNxppkzXYED5quxMDYC/ZInTJovZ3QuyAiM8vZqDPC9hvsBNLLjCMZQpFpcgSt412ZeEdAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055456; c=relaxed/simple;
	bh=Hu+ZYAxQIeqrj2N96pQMniXoSv97DArchied9P7Vm1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr05P9TvSCXDQz4pjuvaTpTdudzWVN6Qi0qG7kQ/wq+b1x4J+7HeD9ekV8PslpCJ2hHkOD2qH3myDrKHTsTjx+BIOZm4iaOEfo2uX2UdWSwWuIYw451FvMB1Yt6KOLclyhk0OEfPrgvkFKpqA+BV688AN9rorM9+15v0wgsS7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK7GeKlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DF7C4AF50;
	Mon, 10 Jun 2024 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055456;
	bh=Hu+ZYAxQIeqrj2N96pQMniXoSv97DArchied9P7Vm1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK7GeKlSJb8Ckg8qzh4cf2ZYk8nis9CGFj3j4T3Q4QfgbeOCCm0FV/6SFblR3J7si
	 pxfoNeGyWC4xbIiuoMVSdGD+JZvpzwxpW7z/gnBc9Z0pgeMWs1fVZ7MIjrS/WEXRCv
	 h61wr6uzmBp9FtmoJiwoVXPupCCZew8yrOKV5e895AMnBVJQM/eejzhmspRrRRnie6
	 jTv4Q78kVKB+O64bYc6jWMI/KQ5kUBVgzKZoTZT6ugNUUEmpVElHOVLtKIJfalEVXQ
	 raIKCmtKVsjBCrb0AVnlpkB3kj6MGqvWDfiYNQorQelmaTYWDxymZSm44Hmo5gxcEW
	 JEZh2WqqKsCLQ==
Date: Mon, 10 Jun 2024 15:37:35 -0600
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH v2 17/19] PCI: of_property: Add interrupt-controller
 property in PCI device nodes
Message-ID: <20240610213735.GA3112053-robh@kernel.org>
References: <20240527161450.326615-18-herve.codina@bootlin.com>
 <20240606192612.GA814032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606192612.GA814032@bhelgaas>

On Thu, Jun 06, 2024 at 02:26:12PM -0500, Bjorn Helgaas wrote:
> On Mon, May 27, 2024 at 06:14:44PM +0200, Herve Codina wrote:
> > PCI devices and bridges DT nodes created during the PCI scan are created
> > with the interrupt-map property set to handle interrupts.
> > 
> > In order to set this interrupt-map property at a specific level, a
> > phandle to the parent interrupt controller is needed. On systems that
> > are not fully described by a device-tree, the parent interrupt
> > controller may be unavailable (i.e. not described by the device-tree).
> > 
> > As mentioned in the [1], avoiding the use of the interrupt-map property
> > and considering a PCI device as an interrupt controller itself avoid the
> > use of a parent interrupt phandle.
> > 
> > In that case, the PCI device itself as an interrupt controller is
> > responsible for routing the interrupts described in the device-tree
> > world (DT overlay) to the PCI interrupts.
> > 
> > Add the 'interrupt-controller' property in the PCI device DT node.
> > 
> > [1]: https://lore.kernel.org/lkml/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> 
> No objection from me, but I'd like an ack/review from Rob.

Given it is more DT patches in the series, how about I take them and 
this one with your ack instead?

Rob

