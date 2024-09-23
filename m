Return-Path: <linux-pci+bounces-13353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7BB97E736
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D063B20BD1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10C4AEEA;
	Mon, 23 Sep 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WQrAzPj4"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDD2C9D;
	Mon, 23 Sep 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078876; cv=none; b=m3oNkbCpxtDm/TuzE9wtLWkXgx4lFchKd58ADDFxaYdJk1ok7uI8WqTlOwlgwfdxydTJh8iGY+GWijS02k6mvM5cpg8rrGWWngLlq9KRY9a8BWOVLUtmORZAVngmI0b6GzBx9qL1+uGf2CrBgBA8xYoeOkyVZgPM2/yXOKbNwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078876; c=relaxed/simple;
	bh=+xNIs7NL1cMhJrrc3GEC3hYmwQtCfinotKNOG960J80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuFsF/+bZejewxn1lyAT819wdNWrD2sB5fUvGpN31d0UqQZhLpGbXf+Ku8bMfkiXc5e3uI7CFPuSkcorf8TZUjMfDTDXYVNJEN+lc6a40hLeSEcedH5WzmYGf/34bdr528Bn+lgkjtm+sSAZzdInINpcLza5tcJyQ0Iw5YNyUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WQrAzPj4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0FCD60008;
	Mon, 23 Sep 2024 08:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727078864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+vix4e0GRedVNRVnn4wq8Rqo0AYrHWnXPkwqpJzbo=;
	b=WQrAzPj4rX6JXOJLKL4blGIs6606JDbweq3NLEDWNM7fS+H98K/tMldauoHFUggVIylRoI
	dQbMTmobwYjaSrRRt3b2fq/pwlujj9iLx3Rekoh1kLdLgmAd+335MEIR3LrnXl5hJJWpbA
	Z0fUrzMuPWw4mY18V1+xci5BT+9RLwyqFUnGs/dc4JOJRcsN20M4ud64KROIqlijgoAiWO
	hK3Kee0I/NLRF+FFIK0ZK6Ts/KYH9KLpO6ntlZ0j19ilXoGL8Fd8lTxgbmfdV/ne7TPDvO
	VSBXZDWlEtADLI2sxPH/y9NJGWqDI2ZiMX819xMtcMmqcoGQ9krFmk88Oq36YQ==
Date: Mon, 23 Sep 2024 10:07:41 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Steen
 Hegelund <Steen.Hegelund@microchip.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen
 <lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
 UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>
Subject: Re: [PATCH v5 3/8] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240923100741.11277439@bootlin.com>
In-Reply-To: <20240912143740.GD24460@google.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
	<20240808154658.247873-4-herve.codina@bootlin.com>
	<20240903153839.GB6858@google.com>
	<20240903180116.717a499b@bootlin.com>
	<20240909095203.3d6effdb@bootlin.com>
	<20240912143740.GD24460@google.com>
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

Hi,

On Thu, 12 Sep 2024 15:37:40 +0100
Lee Jones <lee@kernel.org> wrote:

> On Mon, 09 Sep 2024, Herve Codina wrote:
> 
> > Hi Lee, Arnd,
> > 
> > On Tue, 3 Sep 2024 18:01:16 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> >   
> > > Hi Lee,
> > > 
> > > On Tue, 3 Sep 2024 16:38:39 +0100
> > > Lee Jones <lee@kernel.org> wrote:
> > >   
> > > > On Thu, 08 Aug 2024, Herve Codina wrote:
> > > >     
> > > > > From: Clément Léger <clement.leger@bootlin.com>
> > > > > 
> > > > > Syscon releasing is not supported.
> > > > > Without release function, unbinding a driver that uses syscon whether
> > > > > explicitly or due to a module removal left the used syscon in a in-use
> > > > > state.
> > > > > 
> > > > > For instance a syscon_node_to_regmap() call from a consumer retrieves a
> > > > > syscon regmap instance. Internally, syscon_node_to_regmap() can create
> > > > > syscon instance and add it to the existing syscon list. No API is
> > > > > available to release this syscon instance, remove it from the list and
> > > > > free it when it is not used anymore.
> > > > > 
> > > > > Introduce reference counting in syscon in order to keep track of syscon
> > > > > usage using syscon_{get,put}() and add a device managed version of
> > > > > syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> > > > > instance on the consumer removal.
> > > > > 
> > > > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > ---
> > > > >  drivers/mfd/syscon.c       | 138 ++++++++++++++++++++++++++++++++++---
> > > > >  include/linux/mfd/syscon.h |  16 +++++
> > > > >  2 files changed, 144 insertions(+), 10 deletions(-)      
> > > > 
> > > > This doesn't look very popular.
> > > > 
> > > > What are the potential ramifications for existing users?
> > > >     
> > > 
> > > Existing user don't use devm_syscon_regmap_lookup_by_phandle() nor
> > > syscon_put_regmap().
> > > 
> > > So refcount is incremented but never decremented. syscon is never
> > > released. Exactly the same as current implementation.
> > > Nothing change for existing users.
> > > 
> > > Best regards,
> > > Hervé  
> > 
> > I hope I answered to Lee's question related to possible impacts on
> > existing drivers.
> > 
> > Is there anything else that blocks this patch from being applied ?  
> 
> Arnd usually takes care of Syscon reviews.
> 
> Perhaps he's out on vacation.
> 
> Let's wait a little longer, since it's too late for this cycle anyway.
> 

Discussed the topic with Arnd Bergmann at Linux Plumbers Conference.
Adding ref-counting and support for removal in syscon is rejected by Arnd.

For my LAN966x use case (syscon is used only by the reset controller), the
solution is to remove the syscon device and handle directly the reset protect
register in the reset controller itself.

I will propose modifications in that way in the next iteration.

Regards,
Hervé

