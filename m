Return-Path: <linux-pci+bounces-6890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBB8B77B4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36DA1F22B90
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D36172BA6;
	Tue, 30 Apr 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MBJ35qX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA84171E67;
	Tue, 30 Apr 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485485; cv=none; b=pQJ4Mkls1vxUi0pRkViJMc4DDGESfHBPJLK7U2snRWv31luRpDjtU5BkjnmmD6PYS8VDam3FVo47oWqFXHMMMRaAyIFBly6xSrav3wDqwI/XFJJ0jBPEXmqWmJBaRMNFNKxidzU6o0+WUHdW9mgjX3Zfc1d2lQaCw5+aL4aLH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485485; c=relaxed/simple;
	bh=d2R3ApKMV1f3gJuuo4H/Rasd8gq2uUW5q7jd8t2+E/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go1IvlQxJcCdq3qxaU6ebksnMfI2V0GskASUwzYB0w+3LOah4DN1lVlFAA3oZo0j1+ummSxcaRncO87ngNgiZBMd2aI1fn3GMq6SrHw9kGH4qZYJGxmIA6JGb2jIeZ9OC8tB0auyr1+99YjsIXHyOopJCUgZa2W0gyTdvTsxe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MBJ35qX8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qqMfdpZFIxjLfpY7KpDI8toRWsQL6mV7POHZY9A/Icc=; b=MBJ35qX8Rc1+swgu0QzomYXrkZ
	zBlqwucwM3GEGxiDhQQiOYN60QuMF4Q1g8jRJ3k075imLqh0udEKduQj79hyuZQM3rF86WZ4HuOUk
	xTsyI/J07fim8i63Q7b6a6T1I+m4uam8GWiJGKgy30nuAvzQ549H1U7u1AWn8qcn80Ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1nzS-00ELQq-Ne; Tue, 30 Apr 2024 15:57:50 +0200
Date: Tue, 30 Apr 2024 15:57:50 +0200
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 08/17] net: lan966x: remove debugfs directory in probe()
 error path
Message-ID: <11737915-40d1-4a3c-9a49-12cb1889668e@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-9-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-9-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:17AM +0200, Herve Codina wrote:
> A debugfs directory entry is create early during probe(). This entry is
> not removed on error path leading to some "already present" issues in
> case of EPROBE_DEFER.
> 
> Create this entry later in the probe() code to avoid the need to change
> many 'return' in 'goto' and add the removal in the already present error
> path.
> 
> Fixes: 942814840127 ("net: lan966x: Add VCAP debugFS support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

I know you plan to split this patchset up and submit via different
subsystems. When you do, please post this for net, not net-next, since
it is a fix.

   Andrew

