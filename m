Return-Path: <linux-pci+bounces-14827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B59A2E13
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 21:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21851C266DF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401017D354;
	Thu, 17 Oct 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M91HsT1l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtK89MPK"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447817D341
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194659; cv=none; b=PQnoZymgy7mrmrJYS6SZxoFBZlIVvFGNJvnri6Wgg6jeang8jvgI7cQ9auOqVG9Gt2NcfHepq7i7aYfsC8l5uZyvqWkFIVKewUOVruTxDNpIoDpBv0rB9ZFvYCJcF4Kl0yycKyB4HNhye9r6m7tS4sf5Vj5bad3S3+SmWWo12+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194659; c=relaxed/simple;
	bh=Fy00Jeq7SN8/UankL72qxX4ScIlgbLya2fZR8OcqUGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lv9jC98kFZK2ixBQLZZYYBdwohPW5Auw1PodqsqcDwsRynUgbAlpI+kOKDBXtfr4yjKMgjJC3tOmIdssYT70ws60GUK5KAfbWMFjPAqlSCPTGJXXNEys092PcdcQfTu2emtBRzmzKmymREINYRaF9S18atOYFdf//zg+pO6zvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M91HsT1l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtK89MPK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729194655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyL74JF6zPNZYfPdM8P+h/1+av0xdwXgyHdI2LGG7B0=;
	b=M91HsT1lFyopVEg7PrEjDAp4wQlAbPtMGIyHsCrdJDVP3mZwH3dk/F1/9kL3VTefxeUYqL
	LhKFu5eU7hOnbOwuso9of0E3oAZgOaZeRGu55Br5MHODhKdeh0HH9Trw+kcLOBOGrMv78B
	JI2Ey6Liut7O2Ofuaqv75BYJTMI9OVkyRVNKPuF6ISnnmHT37l+skZCLpddxkohgF9JOJJ
	TkGJAuGJTZjrSETk//9F+yekNXMp6UPqNacADsNw+MHXgK6NDoiYleT0HS9tiEudfW6MyD
	lwOVSCs/0JFrasbFaTaL1bYb2j2zb7QVUYNygHccw0kHEeYI0TfQtfizX/pV6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729194655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyL74JF6zPNZYfPdM8P+h/1+av0xdwXgyHdI2LGG7B0=;
	b=MtK89MPKp+sb/jAI+kPnU1PLR6EgY0jho13GMehFqDSsyFXnfrnUjc+Haw3CEGbIlbdVK1
	7whnrYmEmFF5ozDA==
To: Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>, Gregory
 Clement <gregory.clement@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Rob Herring
 <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Add pci_remove_irq_domain() helper
In-Reply-To: <20240715114854.4792-2-kabel@kernel.org>
References: <20240715114854.4792-1-kabel@kernel.org>
 <20240715114854.4792-2-kabel@kernel.org>
Date: Thu, 17 Oct 2024 21:50:55 +0200
Message-ID: <871q0ea4ps.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15 2024 at 13:48, Marek Beh=C3=BAn wrote:
> +#ifdef CONFIG_IRQ_DOMAIN
> +/**
> + * pci_remove_irq_domain - dispose all IRQ mappings and remove IRQ domain
> + * @domain: the IRQ domain to be removed
> + *
> + * Disposes all IRQ mappings of a given IRQ domain before removing
> the domain.

Sure, but this lacks information what this is about and where this
should be used.

Thanks,

        tglx

