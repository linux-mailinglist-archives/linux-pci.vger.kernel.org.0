Return-Path: <linux-pci+bounces-6891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CB08B7815
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DE91C225DE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFC17F361;
	Tue, 30 Apr 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FftPWpOh"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445217BB1B;
	Tue, 30 Apr 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485694; cv=none; b=XenbudA+T5/yMFYFszynqMzXmQLh6eF1zy/l4vc8nDt593VWx2WvGb5LeMhXekt7lmPol1cMQzWBfWmGN2nWan9gW3nj/mn95Qpz5OGNCa/svBdJcmA6DdtMvKJwyupI1xPZzFSIrq/4xvrPueZmmgNEYcUOVIcilBYQN//qOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485694; c=relaxed/simple;
	bh=fOkQvKx3TkjoVLbIXCLjIhXaPdmdNknggbtEf/cT3yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc8UjCh1WexD2aqfOsNFiD2Da2hn9xC3gqwkoTqNJsHDpi8G7RIv1UQ9lsR+lYJecTCzIE22sUlo8snkrX6n0x88iogN7Es8RmOoJPnduf5GbWAvJhojJUgQsfjtJmG3yQ5zLLLiz3xWHBls189jzw8k3sifGaxnxlatk6sMrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FftPWpOh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cAKC+FytbCMqRhx/bKnkjsTVy7JI3n8TWD+vJCpv8t4=; b=FftPWpOhN2IU3ZbF5sbRbfzVgt
	nMLGfJs77c0MbKf6spQZjQHA6ABKs/zK4WZHPpg73aq5Vbaj65Qz6ZYA16QahFl+DhqRb/Or1PzWj
	ezxloudXaRZU+n6QiZr8F2ie8a8YkYi0M8F1eQOtD34hsUGSYWZioTPm+djth2ucU8r4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1o2j-00ELSx-DV; Tue, 30 Apr 2024 16:01:13 +0200
Date: Tue, 30 Apr 2024 16:01:13 +0200
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
Message-ID: <c48e18d1-c54b-417d-9f24-3ccfeb15e974@lunn.ch>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

