Return-Path: <linux-pci+bounces-10014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F492C238
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 19:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10C21C20B2A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248D1B86EB;
	Tue,  9 Jul 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PnOVroRK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPcdei8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6D79EA;
	Tue,  9 Jul 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545547; cv=none; b=URXvL20uY5uIwUA5sAEdFJsHdsRNTRlKjZBakbU3T4WUQFWkGrLXCaNZ63XgL6J3jzbQE0dHvE0bHmBIKEkiTAKsZ7OVqusAKaTPM49dcE/VtvGqZsJ5bZXbdZD29bwrpjct112OSZQVYX9B8fymQvmNi0LVT+S6Mh0dVJGIqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545547; c=relaxed/simple;
	bh=LlPiCSoSA7uRdyDT/x8+7RpEOMTj3SUxN/O3lN+evHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzyksStTt/9pUdOTsrzadNOSfXi5rLwceXTChxxumi/ISbxFWO8LKcOa+1/K11eny2CrZ832YXpPc6Z9v5kHyiiBI/1P2Nm3kjsCyfJzRa6CvxdY8NDp/gWP1mbQWInRrZHGwCPhqEX22JemUNHSIBdNi9mXH++/vmgUh47nFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PnOVroRK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zPcdei8D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720545538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXRtPpmIr/zw1VxZFsrUYY1TxMhVL7bZNIcSYI84kW8=;
	b=PnOVroRKqR2qbZWMXqbKarnlYlUwZgz7LosWN7IMdwMc5ENufM6Q/QKcWK0Gvl0jgYYmJx
	e4ggy9EXk8VLq9c0UJY0rrycGmvMo2qbMM3OPQ1B6lNga6dVWAm8r87rC5eCrkeyplAVI+
	M1z+3LCjJyqNwd6n9n75euE0pAbOHY+3wacaX+pjfdrYBN+nPa1PYGQPJ3zEPAknYBmtsP
	MKNhvUPxusR1XXbSEw3yhcCDhpOWsxQMUSuLOJYL44DZST7b+V1lXwhTkP/+gfYk0akIqS
	8Mn7op+uulq2FE5lljlv66QBAy5NB02Jt90jt5q0J/0Juoh3NHE1/jGqDtLJFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720545538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXRtPpmIr/zw1VxZFsrUYY1TxMhVL7bZNIcSYI84kW8=;
	b=zPcdei8DMuFfkYYzd8DODeB87OYLTJ4pR2v6KgrL0E7OGzxoNT7natX7rpIMQ0Rb0yzoWb
	nk0rVPNu1nu0ZyBg==
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
In-Reply-To: <43e4c568-083f-4b14-9f08-563ba6a71220@mailbox.org>
References: <20240706132758.53298-1-marek.vasut+renesas@mailbox.org>
 <87h6d1vy2c.ffs@tglx> <43e4c568-083f-4b14-9f08-563ba6a71220@mailbox.org>
Date: Tue, 09 Jul 2024 19:18:57 +0200
Message-ID: <875xtewkji.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 08 2024 at 13:55, Marek Vasut wrote:
> On 7/7/24 8:47 PM, Thomas Gleixner wrote:
>> Why does the irq_chip in question have an irq_set_affinity() callback in
>> the first place?
> I believe originally (at least that's what's being discussed in the 
> linked threads) it was because the irqchip code didn't check whether 
> .irq_set_affinity was not NULL at all, so if it was missing, there would 
> be NULL pointer dereference.
>
> Now this is checked and irq_do_set_affinity() returns -EINVAL, which 
> triggers the warning that is being silenced by this patch.
>
> If you think this is better, I can:
> - Tweak the cpuhotplug.c code to do some
>    if (chip && !chip->irq_set_affinity) return false;

It does already:

migrate_one_irq()
  if (chip && !chip->irq_set_affinity)
    return false;

Right at the top.

> - Remove all the .irq_set_affinity implementations from PCI drivers
>    which only return -EINVAL
>
> Would that be better ?

I think so.

Thanks,

        tglx

