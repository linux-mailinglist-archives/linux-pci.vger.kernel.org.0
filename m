Return-Path: <linux-pci+bounces-10086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E240092D5FD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825C91F2761F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A7189F54;
	Wed, 10 Jul 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="laeZXf7o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V5rnpN4Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A197A7D;
	Wed, 10 Jul 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627900; cv=none; b=DaY3eOXEXrJUsajzA6nz2nBawG/AIkrDLhZREnfuJp31oUKNN/dQE6Vpv1F7vfAjdFoaa/J852CwsJctSb0Xqa9/dIJW4qqxFo8ybmQ9pKw174JNMJdVH4AdljujNhAw3wgkFtxEQ4jgB5dwRrU165YdDPpJn4Gzdl64ZRwzXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627900; c=relaxed/simple;
	bh=WT7zB1ecqsxtlBLT7e/8VBOglFs2+wWrSmq1asY/k6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HdwZ09ad51IkDIxglpo2y5duLq6euHaNOz3MpzZDqQEJs44658JNQssS2xmTcbR9XRKCm0CaRYeLdAKwfHMKPYmiws4lOXWYfoDZnovdve9M10eVwzMbFFldBFN72GUXy9tqQQNvBI+sNW1BGT6EoJ0iR+hs3qJhqwBx3UnnpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=laeZXf7o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V5rnpN4Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720627896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2CmXroVPL2PAPIltmM39/LvEiwdgc25HymKxV7AEHU=;
	b=laeZXf7o16elK9QAu4yukTcKw9ahJvCtYCSw8szmofuWTWXM5LD3f0/JjIVjuF0Aji5JON
	yYr/fAh4JS4WEXtMamz+I4UHqRpz3Rm/egxkgZCPSzGrPnJmeSCf240EdAzoKRPwdJXOGA
	SQp4qepcnKlcTmJyFX/KRi8LpBH4s+qQ4Jt8IVAvZHjisu5S1vH0+Xs/SXu3C4VtBjGJku
	IzKQ/+ECgo6M8MVuSlzw17z8+euiZsCU84eM5KcgLM7vL4bt0+fzZx/dwTn+avsobpnTk8
	jJulPXeZ2e3TUmV7/PAkJioNjOCW8dggNcNhwej+kH/6Nqb0G4a+qW02p32lzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720627896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2CmXroVPL2PAPIltmM39/LvEiwdgc25HymKxV7AEHU=;
	b=V5rnpN4Z4FIJr91PAhu5jFSTUUOYjCXWkt2VuydEX8PUsYs1H349oErj4ZRFs1DXDZPB3L
	vT9VTGTJ9sxY1CDA==
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Jon
 Hunter <jonathanh@nvidia.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set
 affinity failed warning
In-Reply-To: <875xtewkji.ffs@tglx>
References: <20240706132758.53298-1-marek.vasut+renesas@mailbox.org>
 <87h6d1vy2c.ffs@tglx> <43e4c568-083f-4b14-9f08-563ba6a71220@mailbox.org>
 <875xtewkji.ffs@tglx>
Date: Wed, 10 Jul 2024 18:11:35 +0200
Message-ID: <8734ohw7k8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 09 2024 at 19:18, Thomas Gleixner wrote:

> On Mon, Jul 08 2024 at 13:55, Marek Vasut wrote:
>> On 7/7/24 8:47 PM, Thomas Gleixner wrote:
>>> Why does the irq_chip in question have an irq_set_affinity() callback in
>>> the first place?
>> I believe originally (at least that's what's being discussed in the 
>> linked threads) it was because the irqchip code didn't check whether 
>> .irq_set_affinity was not NULL at all, so if it was missing, there would 
>> be NULL pointer dereference.
>>
>> Now this is checked and irq_do_set_affinity() returns -EINVAL, which 
>> triggers the warning that is being silenced by this patch.
>>
>> If you think this is better, I can:
>> - Tweak the cpuhotplug.c code to do some
>>    if (chip && !chip->irq_set_affinity) return false;
>
> It does already:
>
> migrate_one_irq()
>   if (chip && !chip->irq_set_affinity)
>     return false;
>
> Right at the top.

  if (!chip || !chip->irq_set_affinity) {

Obviously :)


