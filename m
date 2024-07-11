Return-Path: <linux-pci+bounces-10167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1C392ECA4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDA91C21535
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D916CD2E;
	Thu, 11 Jul 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KfSv23b9"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED8288B5;
	Thu, 11 Jul 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715142; cv=none; b=k2MTd0WtIfgrmIqNXBqHxDOim5to++rsMZ9o7fEdnMqvrK+gLzSXb1k1UE8ooNDDxae7vpSHkNSZal/QNDUK6sMFaLgjHmqBVDvoowdkH1CrWRqh/+1/bNXtMQcZqubeubGyQsT3lPsxTIFFFxYayrrLNzg+obuY6r5fbQfFfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715142; c=relaxed/simple;
	bh=DbIpqEXvqa8/n/NFFJXNlVHLg5JOmXnb9rdsgAolEOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPT926ekbvnmlnxZcf+Y+bHZpP1r4+xspJQlohE15rirN1q6DT/hWdzY+HCaFfEg1PfTMxUzglNPevgkYqCbVobKha/k43i5/graRjkJVGLFvoYrk3FI1NmxNNgJ/PHC5Rf9GoVTc+WIUXMX9N0GbVgAdUFfu+Z3IB7TpI3103A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KfSv23b9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03D3D1C0007;
	Thu, 11 Jul 2024 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720715131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7OhN1orgjkUFZ9VtsQ2SG+/QVH1zaBAK8LCusREEJk=;
	b=KfSv23b92wWAldauO0bENPiqrIxUSuP8Cn/5wJbThj6nK1iCvhovNQa6BRbLVwqiJuY3KM
	uNzOqFvuiKA/8qc7Gul0dD7PuUBcV/NZSiBGYwMyiUZzK3XcjcTowkFvpGn4IPr8wo8mkx
	X6wDgUFvM5J5m5G/XCMmEuuxKeoP0gao1U9NrfO8b9lC8p3pGV43y1OqkATBJ8jpBZXkn1
	hnj1gkSYDoNyCS+LOYdM9rOMAYYFo/AV2FDR7LiQqP7KBrPJM5Y4Zm6ZoIVO+xsU1k57kv
	MsYWQQMTMAdQPXJB9AW0MMOZ2fx1qNITfXY5RNjawbM3m9YKoZS16E8/mh9W+Q==
Date: Thu, 11 Jul 2024 18:25:28 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>, Lee Jones <lee@kernel.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, Daniel Machon
 <daniel.machon@microchip.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars Povlsen <lars.povlsen@microchip.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>, Simon Horman <horms@kernel.org>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, LKML <linux-kernel@vger.kernel.org>, Allan
 Nielsen <allan.nielsen@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Jakub Kicinski
 <kuba@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Paolo Abeni
 <pabeni@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/7] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240711182528.1402892d@bootlin.com>
In-Reply-To: <91cfc410-744f-49f8-8331-733c41a43121@web.de>
References: <20240627091137.370572-2-herve.codina@bootlin.com>
	<91cfc410-744f-49f8-8331-733c41a43121@web.de>
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

Hi Markus,

On Thu, 11 Jul 2024 18:09:26 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> …
> > +++ b/drivers/mfd/syscon.c  
> …
> > +static struct syscon *syscon_from_regmap(struct regmap *regmap)  
> +{
> > +	struct syscon *entry, *syscon = NULL;
> > +
> > +	spin_lock(&syscon_list_slock);
> > +
> > +	list_for_each_entry(entry, &syscon_list, list)  
> …
> > +	spin_unlock(&syscon_list_slock);
> > +
> > +	return syscon;
> > +}  
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(spinlock)(&syscon_list_slock);”?
> https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/spinlock.h#L561
> 

I used the spin_{lock,unlock}() pattern call already present in syscon.c.
Of course, I can add a new patch in this series converting syscon.c to
the guard() family and use guard() in my introduced lock/unlock.

Lee, any opinion ?

Best regards,
Hervé

