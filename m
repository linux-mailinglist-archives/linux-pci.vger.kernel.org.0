Return-Path: <linux-pci+bounces-7010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260658B9B98
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 15:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573E61C21652
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FED84A56;
	Thu,  2 May 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XVNmndqb"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67C56443;
	Thu,  2 May 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656407; cv=none; b=JMixkO4ntRiGg1R0anxpTfbwR6XDL48cNBzsL7vGhZBlh9bj+3u3dm4cUNeqpvzikaNfFkXI7bbChdGu8NcxxXYwBnffsnmjoWuNjbXUtXQa+W/JF2zYfh4XQCicneLI3bxV3f5t7ij7dKNJJqbXhvPnmy3+2nqe+N2lm98pUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656407; c=relaxed/simple;
	bh=c6EM1tMgmBGcGpom67ECrDo8FCaPc9M8RA3swMVce/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVdIUq9VXSAT2MbBkVOAFJbfgF8Dzsmv9hQr8KunDzai16RMRWsUuBvuf9MISOfmScqMWR+qJugHkBQ960wguc6l5EP4U3L7DrpGitUuhgRUGqk9jOqa72JljeGdnaKkkiLpLA3PYRqgPwMP13aZPSgaiaBnv6A/Z+LRKq5UTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XVNmndqb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A68C560002;
	Thu,  2 May 2024 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714656397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Suweh1wFgszqifVDaAEkxYOgy+dULTJAN3r6qeEYhaA=;
	b=XVNmndqbx0Ms5LAbzP/pgCn3MNdyu+87Ayr5Dpvlk4LNbRc8MvDjARSfsg/zVOVOi8QKVf
	/MYcEgzLyFvl8cA5bpB8mr0VyD5nyQoDEIZpPsIFwLRXILqU1y3xztL3EMmLcctR8Nchh/
	ktPL2p1xyRd69ptkd+PcFDucW62HuP/mETcUIg3XWp4hxAtU3AoPzGc2IlWUhyUOM/o11K
	2poIowEp6vSTyyuUqWHp2Pex8y7q78pNYewdUnx+Qzi3COzdoKhtoTreRxOW006wu+tnlG
	y1BswqSLi4Eq2ICWMj3wMDJ5uRPauBLbKP07ryS975wgBU3teix+aBctWg7mFg==
Date: Thu, 2 May 2024 15:26:34 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Allan Nielsen
 <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch reset
Message-ID: <20240502152634.546f66d3@bootlin.com>
In-Reply-To: <BY3PR18MB4707BE42247B0A418EFEE35EA01A2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-8-herve.codina@bootlin.com>
	<BY3PR18MB4707BE42247B0A418EFEE35EA01A2@BY3PR18MB4707.namprd18.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Sai,

On Tue, 30 Apr 2024 09:21:57 +0000
Sai Krishna Gajula <saikrishnag@marvell.com> wrote:

...
> > @@ -270,11 +271,18 @@ static int mscc_miim_probe(struct platform_device
> > *pdev)  {
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct regmap *mii_regmap, *phy_regmap;
> > +	struct reset_control *reset;  
> 
> Please follow reverse x-mass tree order
> 

Sure, this will be fixed in the next iteration.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

