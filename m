Return-Path: <linux-pci+bounces-7424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B298C4383
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D731F222CE
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B94689;
	Mon, 13 May 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiGMMNwS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4601C01;
	Mon, 13 May 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612039; cv=none; b=N21o0euDsU2eomTAe7NJa9cNFJKsVoEMjgCyRdHchBsbouwJuRYS/LMODax6PxK2xZ2D63zyIpsY5kkdp6zHkaauQQzDgd0Wa3mO51Mxkwje0A3Jf4dDZnvJQ9iSdKg3QKhEABlovrXgyzFutoOV3vxvagwIF2QsSIQI7uTTDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612039; c=relaxed/simple;
	bh=dLfguYFlEZM8pXj+gnfRKXow5bLqSaYtXraAJ28Xh+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3AWRf9pwM3PZQdGvjqs4/WUcYV/MfCb6+Vlv70DsxNXsZ8r26PBe7AdtfVKzBeSxgA7XYS57x3G2IjTlA8GIyG3Vyxll77ZdDDhdFoo1nK7+cSPRci4M6ZL4JQGnJgegRwU28HxWw4+5rp4YdZryeXkzce4g6QYgaq2fD4oidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiGMMNwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0372DC113CC;
	Mon, 13 May 2024 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715612039;
	bh=dLfguYFlEZM8pXj+gnfRKXow5bLqSaYtXraAJ28Xh+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiGMMNwS0pqUaXc/XjsL9E0Ll3T4d4WZIAw1c8zOCWDCHCbkesjjdnlLtfqWR1f0N
	 2NxNyqSTtyGAfD7QyxJlJ17wJF9rBsn4aWaUxr2CxUyfIx1OScZG6/okfkOnwUdbFN
	 ZbryLIj8PRNzMSpzBTr4DqhdFnBgg9eEC35YCON7w403zoetxm21pUe1Yz+4NAY+Kr
	 nzLZZAefzR9nluD7nQ+sUDQa/ubpKr17a+7pRv/G3XGdNoTFpFeTcd1nhLJLo4oOCg
	 mkiZyqKU4dQZO1yagMaCcqgq+YnAI+iNOk9Ck7xs7NofaMpNhJ60h6JjM/t4oJO98H
	 7bcI9oMtxAKYQ==
Date: Mon, 13 May 2024 09:53:58 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH 09/17] dt-bindings: interrupt-controller: Add support for
 Microchip LAN966x OIC
Message-ID: <20240513145358.GA2574205-robh@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-10-herve.codina@bootlin.com>
 <20240507152806.GA505222-robh@kernel.org>
 <20240513143720.1174306a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513143720.1174306a@bootlin.com>

On Mon, May 13, 2024 at 02:37:20PM +0200, Herve Codina wrote:
> Hi Rob,
> 
> On Tue, 7 May 2024 10:28:06 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> ...
> > > +examples:
> > > +  - |
> > > +    interrupt-controller@e00c0120 {
> > > +        compatible = "microchip,lan966x-oic";
> > > +        reg = <0xe00c0120 0x190>;  
> > 
> > Looks like this is part of some larger block?
> > 
> 
> According to the registers information document:
>   https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,intr
> 
> The interrupt controller is mapped at offset 0x48 (offset in number of
> 32bit words).
> -> Address offset: 0x48 * 4 = 0x120
> -> size: (0x63 + 1) *  4 = 0x190
> 
> IMHO, the reg property value looks correct.

What I mean is h/w blocks don't just start at some address with small 
alignment. That wouldn't work from a physical design standpoint. The 
larger block here is "CPU System Regs". The block as a whole should be 
documented, but maybe that ship already sailed.

Also, here you call it the OIC, but the link above calls it the VCore 
interrupt controller.

Rob

