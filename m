Return-Path: <linux-pci+bounces-8383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5588FDF5F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 09:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5C41C23CD0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BE913B2BC;
	Thu,  6 Jun 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aHR3T4hD"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE53EA72;
	Thu,  6 Jun 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658102; cv=none; b=DlI9qTFRxkquPdE3VZA5dsntuefnxh2frPYiQbv1Vso1cGaZ8ufJIIcYKdrA2YadE9LNcZG16MYEe1m77s7wlQfvRj78EbH2nCumNORN1OFQQnFAkHXcR5wBHjveTxKPB8wOLNAglbZN7U87Gi6UebhNFHtpPhDuk5uwD9RKzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658102; c=relaxed/simple;
	bh=yuEfa2UV+chthnn3Iq3uD3lcYGjVSmjvN5Ua5bJVleA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BICVDte3bpQhcnP0MDvg/F2XzcLTqECGjZ2VyMVV2W+BLJ8yOuhDgsXzaTj+GHhHA6VAa5wgaj6khfJ1N2+SRaeX4HB1LgCOi81+t1LarQVnr8OmVJDIHpWqDDrEGtkk2f1HYXS5F+ktV1iaOSlo0rxo0+2HNxKlQT03B8NTAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aHR3T4hD; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B94524000C;
	Thu,  6 Jun 2024 07:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717658092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wtbh9Y5BhilOkF/Ov75N0g0FuZgE8BmOll+aw1LPV5g=;
	b=aHR3T4hDEP8oxcmxkYTox0dObRLwyZcs+fahBn8rXTbY59oM2XLPUW9uoDNleMjbfCg4j+
	mu3oByJSRS1EenKMN7sKE4FDFl5ZANKacfMfWI/lTkfdpcCoga3r1X9kHWSHM5QQF3gebv
	rhxwFpSSwrRjHyOORqfbHy9vzgJoXDPzUaX5/MBeYu5n5sOnxdVWM2JJwPSN0vklHbjv+b
	O1CTPUiludohFB/9OBNhSt3z55OaWP7uTYIXOIA//9AvjHLhMJ8gNs4I+VYQfyEKgXWuAK
	7Y3pWc5NHsT8gyj2B5OE9g2j97vk8ZTIk3AUCFLs7NQYzxh+pkv6JspSHB6WTQ==
Date: Thu, 6 Jun 2024 09:14:46 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula
 <saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Saravana
 Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 09/19] irqdomain: Add missing parameter descriptions
 in docs
Message-ID: <20240606091446.03f262fa@bootlin.com>
In-Reply-To: <ZmDEVoC9NUh7Gg7k@surfacebook.localdomain>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
	<20240527161450.326615-10-herve.codina@bootlin.com>
	<ZmDEVoC9NUh7Gg7k@surfacebook.localdomain>
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

On Wed, 5 Jun 2024 23:02:30 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Mon, May 27, 2024 at 06:14:36PM +0200, Herve Codina kirjoitti:
> > During compilation, several warning of the following form were raised:
> >   Function parameter or struct member 'x' not described in 'yyy'
> > 
> > Add the missing function parameter descriptions.  
> 
> ...
> 
> >  /**
> >   * irq_domain_translate_onecell() - Generic translate for direct one cell
> >   * bindings
> > + * @d:		Interrupt domain involved in the translation
> > + * @fwspec:	The firmware interrupt specifier to translate
> > + * @out_hwirq:	Pointer to storage for the hardware interrupt number
> > + * @out_type:	Pointer to storage for the interrupt type  
> 
> (kernel-doc perhaps will complain on something missing here)
> 
> >   */
> >  int irq_domain_translate_onecell(struct irq_domain *d,  
> 
> You can go further and run
> 
> 	scripts/kernel-doc -v -none -Wall ...
> 
> against this file and fix more issues, like I believe in the above excerpt.
> 

Yes indeed, I missed the return values.
Will be updated in the next iteration.

Best regards,
Hervé


