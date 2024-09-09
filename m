Return-Path: <linux-pci+bounces-12942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1795497104E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 09:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C240D28309A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4C1B012A;
	Mon,  9 Sep 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zq6JXZ//"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DA1AF4D9;
	Mon,  9 Sep 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868337; cv=none; b=J86bvj4H6zq+UeUvbcoIsugXo7gJt3+CZeOwPkeML8ki+7PiE+SKBliKU4YrPfIMHEXeTO5KquJSbI2tYBBI52GCkCFX8b8DxAYgiDyKDzW+bl3idQMSwoB/DUfxsoUsYQUrPNTdz2PcTrR8GYUlJrk3J3UFx2b41mZDStzDF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868337; c=relaxed/simple;
	bh=tYpdgaZCN0lmhTqQidVM517rCDCWKPWudibqWnwydI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh1/prBYLk43uoaz2bmqoCV5Th/nDoO9kzinaCVpvh5usdH/kuBY8phJ1yignsZOpQktN4NL2exAVU3nUoBIXKA5PnWcgBPupZpFVa7opfUGpFuB8kDJYYNIPMoytyAqO3Mn0VpzEQbPSqDwAQ1kAvxbHYMhPwRK9uWp7Y/KLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zq6JXZ//; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26DFA40005;
	Mon,  9 Sep 2024 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725868327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryHecAjCKFHY5a39/P+GIvh5tYnxD8Fg8PfucobQxhs=;
	b=Zq6JXZ//+adouwtwkw6boEPhyiUb2gfFl1RlA0RtXhCzJdYB5HfGK1TUuiPkVXECfEwRwo
	5FksXPPXTfRR/GOVEhY+/BBte1UQQL25WwxYjwMs8hI6zh80c0qZ8lho8BBY9p/4i7aqGx
	HVeByxhdV3V98xdhXabPHXeeVJJ+ojd/5b5xx4NhZ2xsZZaBgPbGmDkM7S5gBdiuQFAVn4
	WF17yA5QBKYBiKqL8Q7+2YUgOIzQQwVr5fl42DKQM21/Muj8AIaUrastdmO0NdIpt/nGT+
	dfkAHGEQdaTjvIEcerwNh6l4fmtvPPZrqc3P4P4ns6/jQPS79ay20fahDCDf3g==
Date: Mon, 9 Sep 2024 09:52:03 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>
Subject: Re: [PATCH v5 3/8] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240909095203.3d6effdb@bootlin.com>
In-Reply-To: <20240903180116.717a499b@bootlin.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
	<20240808154658.247873-4-herve.codina@bootlin.com>
	<20240903153839.GB6858@google.com>
	<20240903180116.717a499b@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Lee, Arnd,

On Tue, 3 Sep 2024 18:01:16 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Lee,
> 
> On Tue, 3 Sep 2024 16:38:39 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Thu, 08 Aug 2024, Herve Codina wrote:
> >   
> > > From: Clément Léger <clement.leger@bootlin.com>
> > > 
> > > Syscon releasing is not supported.
> > > Without release function, unbinding a driver that uses syscon whether
> > > explicitly or due to a module removal left the used syscon in a in-use
> > > state.
> > > 
> > > For instance a syscon_node_to_regmap() call from a consumer retrieves a
> > > syscon regmap instance. Internally, syscon_node_to_regmap() can create
> > > syscon instance and add it to the existing syscon list. No API is
> > > available to release this syscon instance, remove it from the list and
> > > free it when it is not used anymore.
> > > 
> > > Introduce reference counting in syscon in order to keep track of syscon
> > > usage using syscon_{get,put}() and add a device managed version of
> > > syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> > > instance on the consumer removal.
> > > 
> > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > >  drivers/mfd/syscon.c       | 138 ++++++++++++++++++++++++++++++++++---
> > >  include/linux/mfd/syscon.h |  16 +++++
> > >  2 files changed, 144 insertions(+), 10 deletions(-)    
> > 
> > This doesn't look very popular.
> > 
> > What are the potential ramifications for existing users?
> >   
> 
> Existing user don't use devm_syscon_regmap_lookup_by_phandle() nor
> syscon_put_regmap().
> 
> So refcount is incremented but never decremented. syscon is never
> released. Exactly the same as current implementation.
> Nothing change for existing users.
> 
> Best regards,
> Hervé

I hope I answered to Lee's question related to possible impacts on
existing drivers.

Is there anything else that blocks this patch from being applied ?

Best regards,
Hervé

