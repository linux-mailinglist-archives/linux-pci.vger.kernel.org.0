Return-Path: <linux-pci+bounces-11433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7994A89B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420361F20EDE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731561E7A51;
	Wed,  7 Aug 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QKrFc1+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E61BDAB0;
	Wed,  7 Aug 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037384; cv=none; b=eTFm6R2COhlBG3CEkfji2ZwNvXfMkMU2ELnrTWEe2qx8rncNlpTcYDvZuyZGCwgvw9ggWrQ4aJWx3/fjiLr5wVwLzrTOrhzaINw/R1Kltfpf76JzeQidYfS7e11EzntVNRX8E8AUxwwD3fig1IpUF3jzwtl6xpvNmLxPQHG8B/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037384; c=relaxed/simple;
	bh=qM9AJoWa5VmLYkAsAiKwksrHXv6FKgyEFWqPkI2GMqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU9roS21g7mC+2Zb6R9AWTp4usfu79HF2wCJBEec129f4pusLr+LnUI5glG4J+PYvzV4sVTHFO/LKAa/tkaZ6JmnPbF9KhB2T3bDRgZ2UJkGeXOelrHD4/QBeUDugWr4V8+nrB7uJhhDAMGIj86ibHkOSct+xGkWKX9OL0xSwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QKrFc1+1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BF49FF803;
	Wed,  7 Aug 2024 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723037373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVTsGVO8WsmaD67opd83BfGFsRJNsmaLrq0szd22Jso=;
	b=QKrFc1+1fIuGLesvgymIYwFwPnJVb+rjl/ZP2BoUrhJkQHOAu3stwDe1XaFP5f1eyJMV7Z
	wFUrzvoCkJYAueAKr2mIol3f3K3XFnHB3lxhNmt73ny2WI/AA+vHckq86dKEJbVn8ZVTVP
	fopVlsEIQ58rnvRhdDkm7fmuAUlvS2UPUxpGQt4oct1orI9nBrxSWPSwmG9Ie8+QR78NQ+
	VQLK1LZZBKe5OaArKNDpzmXOn7Q0AyHGbd1bW8c7tpMilCRP7IHd69jdY9f1enEjVKs75E
	WeC790m5b+uinjI8a4yCuVB45CSGfeUpl4gkjgfMvqsnv0jz1uiwlbo14cMdBg==
Date: Wed, 7 Aug 2024 15:29:27 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman
 <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
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
Subject: Re: [PATCH v4 3/8] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240807152927.22e40284@bootlin.com>
In-Reply-To: <CAHp75VfKXEyHF25xRq8EDp5SeBdyPHLgzw=4s1xkjer=sNu7aw@mail.gmail.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	<20240805101725.93947-4-herve.codina@bootlin.com>
	<CAHp75VfKXEyHF25xRq8EDp5SeBdyPHLgzw=4s1xkjer=sNu7aw@mail.gmail.com>
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

Hi Andy,

On Mon, 5 Aug 2024 22:20:56 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 5, 2024 at 12:19 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > From: Clément Léger <clement.leger@bootlin.com>
> >
> > Syscon releasing is not supported.
> > Without release function, unbinding a driver that uses syscon whether
> > explicitly or due to a module removal left the used syscon in a in-use
> > state.
> >
> > For instance a syscon_node_to_regmap() call from a consumer retrieve a  
> 
> retrieves?

Indeed, will be fixed.

> 
> > syscon regmap instance. Internally, syscon_node_to_regmap() can create
> > syscon instance and add it to the existing syscon list. No API is
> > available to release this syscon instance, remove it from the list and
> > free it when it is not used anymore.
> >
> > Introduce reference counting in syscon in order to keep track of syscon
> > usage using syscon_{get,put}() and add a device managed version of
> > syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> > instance on the consumer removal.  
> 
> ...
> 
> > -       if (!syscon)
> > +       if (!syscon) {
> >                 syscon = of_syscon_register(np, check_res);
> > +               if (IS_ERR(syscon))
> > +                       return ERR_CAST(syscon);
> > +       } else {
> > +               syscon_get(syscon);
> > +       }  
> 
>   if (syscon)
>     return syscon_get();
> 
> ?
> 
> > +       return syscon;  

Yes and further more, I will remove also the unneeded IS_ERR() and ERR_CAST().
This will lead to just:

	if (syscon)
		return syscon_get(syscon);

	return of_syscon_register(np, check_res);

> 
> ...
> 
> > +static struct regmap *__devm_syscon_get(struct device *dev,
> > +                                       struct syscon *syscon)
> > +{
> > +       struct syscon **ptr;
> > +
> > +       if (IS_ERR(syscon))
> > +               return ERR_CAST(syscon);
> > +
> > +       ptr = devres_alloc(devm_syscon_release, sizeof(struct syscon *), GFP_KERNEL);
> > +       if (!ptr) {
> > +               syscon_put(syscon);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       *ptr = syscon;
> > +       devres_add(dev, ptr);
> > +
> > +       return syscon->regmap;  
> 
> Can't the devm_add_action_or_reset() be used in this case? If so,
> perhaps a comment to explain why?

There is no reason to avoid the use of devm_add_action_or_reset() here.
So, I will use it in the next iteration.

Thanks for your review.

Best regards,
Hervé

