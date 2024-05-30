Return-Path: <linux-pci+bounces-8066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004E8D4234
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CAFB21CD5
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 00:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA836B;
	Thu, 30 May 2024 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdQEXfv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BD7F;
	Thu, 30 May 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717027713; cv=none; b=AEIJuWqpItH/TWkq1Yp9hfTKnmDfCj4ro9Alru0YZGB5Bxuz3eA6u0b5KQHy6DKQOz6OXs2rwa0NMgFH4uyI+pvbroiikEYvYyXbCOzZ3YndrCDUg/BrIAAOEO6g7whc8SlJNbUsfBOY0BJCtahOpguvL/CC/sg07+o9h5se1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717027713; c=relaxed/simple;
	bh=tRVcRLe/NAe2iqLzNI6Vxhtmb2QMttz2Foz7NM1jQwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pozOENvOqZQHeqgZk3IdSvS5vUDi4Cr/TzIyS0QrdPB62T9Ag3FRyljKzcWUqJioAbWOoWydqLlfY5shQlFfMscVRIpP0jBKLbcseY85aFI3L9+Nu2NyzZi34QNb5+zdPRMkTX2iTLNi6WC9AbiS9HBXK7OrmL5ugB9UHUvOUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdQEXfv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA809C32781;
	Thu, 30 May 2024 00:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717027712;
	bh=tRVcRLe/NAe2iqLzNI6Vxhtmb2QMttz2Foz7NM1jQwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdQEXfv3MfkDcz0mLh9FfPe7IlgWRYUqAHSoCNN3Y9IOxEJEEz1dKO6ArQVH4+OZ1
	 e+JH4rJHQfnMGsLp/efaugIehrF3Qn8C3bXU9hIM+aY+7jd9c1dNfxus2rLVq4J7L7
	 a3RQQQHuSgyQrUBUJIftQy4vGbhPsJtJyVpyBCFGt0hZJFJE2JeLCbppk3Nx2q4NVq
	 RCMpm1+136EN5/oJP4oCUIQbsyoELXaHKBY5ALd642xs+W9Y/h8h0oi1Bxhzey2/GE
	 hEi7zXSxaywhMsEUbRlP7CQKfHlH98BBopVHbF/zD9oCHWAXHVPkOOBUPrEfzKKM+9
	 7eyBXshmzlyuw==
Date: Wed, 29 May 2024 17:08:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/19] Add support for the LAN966x PCI device using a
 DT overlay
Message-ID: <20240529170829.01c3c433@kernel.org>
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 18:14:27 +0200 Herve Codina wrote:
>  - Patches 6 and 7 to be taken by network driver maintainers

Could you repost these two separately and address the nit from
Krzysztof? Easier for us to apply that way.

