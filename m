Return-Path: <linux-pci+bounces-9268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169AF91793B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2801F224B2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737BD154454;
	Wed, 26 Jun 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kkRAU5Ye"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9D175AA;
	Wed, 26 Jun 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384766; cv=none; b=Zwslq3bTl+x0gD56qkTkkyF6FRkwxPkAdvP4F+jcu2nQqdIOPOB8j7r+ua7Avld6KfTZf8IPB6aCoJSmOc6efPKGDuki70WYCkdpdHpO8TzMvI33Kz+dbGIOi61/xUzo09NYazR2IO7zwCL07lCUXPEnkJD+v08CFjMpJAnlclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384766; c=relaxed/simple;
	bh=fRE5P6PE82Xq4+23ZFjntwgar6QxyjYP8r3Y+M4Da1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuqGsSX7iGeUlObV0wbMbkrKnreGxjLwCD4wFWukrINEtm9fZ1vgyHVc5i2m94/BJ9RI+wLGISdmYEyuhZWkoZzVvYW5DpsEXQhRgBGf9j1JDk+ntfjGWL/idcEgVqTXB5xItauj+VulxOFAUYOpgnIAxS2JV/yEnWA4Fua+x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kkRAU5Ye; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0524D24000B;
	Wed, 26 Jun 2024 06:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719384761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X82V2P8TKJ6I8usLvjtNSyZFMJxGfnoq2XWLZLGMyXM=;
	b=kkRAU5YeXHUASh1bGiT5FERp3Mx6h6xd8Tc4Mx4MSS7GL7twUqycQ10OUYsbXOI5iLVt2A
	oUsne71Ia20lVvneuq9SgEBi3IBQvU7IWePE6zj9CMk4dCBtiQK4Wi38sSqQjRipBddKzG
	JqFr/hWpMgWo+wxNU8LPTdvd1dro/7ifG2q2RuHbmAj6D1GvdAfqX0lSWd1RxR//WUmB6z
	AZw0F1y+N3yYzZ79Sss3rr1Bnv4vrLQ9ygC9J9f6CAxWDIwuyuUtTWVKlBOVPkgBPNSBgO
	XsarOwoOA/v6b6o0GHf/SOJx8GhrAVHHHhpvJU5glbWkJsLYhW0sqRnd3B5Bng==
Date: Wed, 26 Jun 2024 08:52:36 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Steen Hegelund <steen.hegelund@microchip.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Sai Krishna
 Gajula <saikrishnag@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@google.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Allan
 Nielsen" <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <20240626085236.62e61723@bootlin.com>
In-Reply-To: <e85511af9db9de024b5065eeee77108be474f71e.camel@microchip.com>
References: <20240621184923.GA1398370@bhelgaas>
	<e85511af9db9de024b5065eeee77108be474f71e.camel@microchip.com>
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

Hi Steen, Bjorn, Andy,

On Mon, 24 Jun 2024 13:46:32 +0200
Steen Hegelund <steen.hegelund@microchip.com> wrote:

> Hi Bjorn,
> 
> I am not sure what went wrong here.
> 
> I have seen that lspci lists 'Microchip / SMSC' for the 0x1055 Vendor
> ID value and as mentioned previously there has been a number of
> aquicisions over the years, so that the ID has been absorbed but not
> necessarily re-registered.
> 
> Anyway I have started an investigation, so we can determine what
> up/down in this.
> 
> I agree that for now this will have to be PCI_VENDOR_ID_EFAR, and I
> will return with an update as soon as I know more.
> 

Right, PCI_VENDOR_ID_EFAR will be directly used in the next iteration.

Best regards,
Hervé

