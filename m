Return-Path: <linux-pci+bounces-17797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620C9E5DF6
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E554C28660B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529D227B89;
	Thu,  5 Dec 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nzpIl9YB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+4Rsy8fT"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A9226ED3;
	Thu,  5 Dec 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421917; cv=none; b=jggguzC/RWtGoFObZQ8CWjTtV7wlIe2Gl33WWAnzaKTKOeAMu10XQaIJn/aoULhNeL4HnIYsyeNgeD4eI1rTHHYWv2VO9J2wWDOioLGmY8LZT4qIf8gy7t2h4R57J/ZRSI8L1n35qA6XK0Obffgk06qfbm2OvLfjR3kEKL399Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421917; c=relaxed/simple;
	bh=f3oC/5XyI3YEdeEGvrWYb1QL6QS05ON7ASm8AOP/poY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kt7GwmBd+994HqmMMPWr9wmmIEzWi51Jd8EoGwE/IgDtxl8dYqapls1jg2iRW9mssuBJNibpwPkgnbJwWScOWM8AIrZC/PRD9tc+BwPtmDVYXc3NJVY9Y55MgEXy6t1KGPj4r6JdGoBuHmUM/If9Ajf4hQPsq+OcdGYNEykNiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nzpIl9YB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+4Rsy8fT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733421913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BglboHQ7tVu4BxDK/EuzRuAGpk+spIRm/9NWQyWzxwk=;
	b=nzpIl9YBICnzKJI2Pjvf7pkScFiSL9S5X4wczpmO39asv6i5Z5SF3UYOzOO2mqZVUE41dd
	2zHRSj2qsel3OpEJ2kfDqI56RWlxU2MY40FwlxpwWSyXJ3ajQEFqK76st0cebIzRndq9pA
	2K7XMPdBI6WOD0qjt5Y5K/ajyDIWjWtfx2/48zBYcsP8jwZBtIzK1dN2E82xpHAFca52/K
	W7+oLVtuMAXCAUa7hz/zKRr885/ye+gH8lK5Zi/qu6MMMqRgoSP6YT7UQO6KJ2wrrqqE5T
	CUxPyDxk6gq/DiLPQEUej3k429WBRKnuYABK/KMSPr9Nag6vvKCtUvuF6SSXpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733421913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BglboHQ7tVu4BxDK/EuzRuAGpk+spIRm/9NWQyWzxwk=;
	b=+4Rsy8fTbbnjB6wPATM5TxkjCHnu+iZXm4JyQV8eFr1jCKHhPGsKvDTyDr8BPvspeOadXi
	R164aOSReCT8w6Dg==
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Anup Patel <apatel@ventanamicro.com>, Marc Zyngier
 <maz@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
In-Reply-To: <Z1G/CwFvO/aBLBe8@lizhi-Precision-Tower-5810>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
 <20241204-ep-msi-v10-3-87c378dbcd6d@nxp.com> <87ttbiqnq8.ffs@tglx>
 <Z1G/CwFvO/aBLBe8@lizhi-Precision-Tower-5810>
Date: Thu, 05 Dec 2024 19:05:13 +0100
Message-ID: <87ldwuqa3q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 05 2024 at 09:56, Frank Li wrote:
> On Thu, Dec 05, 2024 at 02:10:55PM +0100, Thomas Gleixner wrote:
>> You want a MSI_FLAG_MSG_IMMUTABLE and set that on the domains which
>> provide it. That way you ensure that someone looked at the domain to
>> validate it.
>
> Okay, at beginning I think most MSI controller is immutable. So I use
> MSI_FLAG_MSG_MUTABLE.

If you want to do that then _you_ have to go through every single
interrupt controllers, validate and opt-out in case it does change the
message. Otherwise that flag is completely pointless.

Instead of adding the IMMUTABLE flag for one controller you know and
then let others who want to utilize this amend their controllers.

Opt-in is less work and more safe than opt-out. See?

Thanks,

        tglx

