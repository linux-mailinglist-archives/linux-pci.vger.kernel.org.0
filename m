Return-Path: <linux-pci+bounces-9897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A792995B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 20:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49DC1C20615
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5F3D57E;
	Sun,  7 Jul 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDntQ3FT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JtoKb1ia"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28A1429B;
	Sun,  7 Jul 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720378063; cv=none; b=XofPW/LIKbbjWncmMqKCUDOaPqN/g6RpIGulw+IzVfLjOpfdYwNlLzT8pbtL4yem0qtOPb5qxk/iOuzugHBFMW6Z25vHfb7R5wFdC1BpcVKmei5K4yMm+JjZoYK7s+0VA1nLLMxBoEjyi/MeeysFIH+UbR5r1vWYGjCPejeu0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720378063; c=relaxed/simple;
	bh=v4h9od8K6fTONBvJosxZ6rQ5SiZd8ic36+1lPp+yduY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=azcXFxQZZLXdE7fsUVp6VelAfh/mekOE8o/LJMFzNV0FEtzsJXMASE8nEYZjGDo3MCKMiF2zq8CTLFTr64dKdxm1kpmPL1LssEZLhrA0q9F5kAUHAogyfCxJOGbw+gZknHFYzGqbs8udzNNV8e5oUy1mc5FnUzP1A7P5DJhsDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDntQ3FT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JtoKb1ia; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720378060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SGabcz1S+/3HqptjW5xYki+/7SJtSmlNFb9FyOSKDUs=;
	b=sDntQ3FTjBt3eqSfX9DOeKBLbWiEr+G0N8R9bFsC7b3yyC9uBFA0P29rjHuOAOGIb3mYJh
	qTzhMlrTglYzexCJN6YwleyNY/QZAKlpwNEb2z9Sr7BJqcEOuOQYGGSzYe3fb7ZQ7IqBwo
	FpxawuqQoLg/Sp+wV86NdU9LUonvNM/Qze0SUeHGSbJ94vzd69EVaJ+F3Bxtm0bcnC6h2y
	pJJ/WZktD0ulVwFUkQo4T7pPY2Lg7zlv+uaBmCAe9QHjsHks9E9o44nFhiNgRbOKYLBGx1
	crPZLMQOsVxUdbdZpxUTAV4bhNFcQmv2qP47sx7dYAi1lmgE5o6PBFNxEB/EAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720378060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SGabcz1S+/3HqptjW5xYki+/7SJtSmlNFb9FyOSKDUs=;
	b=JtoKb1ia/90BOJcqkbEkYho7f3FcH2fphFta2N3Ws6G9dtZSOuVEBx8ripsCgGZDQKnp7R
	SHRu789wnTetbFBA==
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Krzysztof =?utf-8?Q?Wil?=
 =?utf-8?Q?czy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Jisheng Zhang
 <Jisheng.Zhang@synaptics.com>, Jon Hunter <jonathanh@nvidia.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob
 Herring <robh@kernel.org>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] [RFC] genirq/cpuhotplug, PCI/rcar-host: Silence set
 affinity failed warning
In-Reply-To: <20240706132758.53298-1-marek.vasut+renesas@mailbox.org>
References: <20240706132758.53298-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 07 Jul 2024 20:47:39 +0200
Message-ID: <87h6d1vy2c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek!

On Sat, Jul 06 2024 at 15:27, Marek Vasut wrote:

> This is an RFC patch, I am looking for input on the approach taken here.
> If the approach is sound, this patch would be split into proper patchset.
>
> Various PCIe controllers that mux MSIs onto single IRQ line produce these
> "IRQ%d: set affinity failed" warnings when entering suspend. This has been
> discussed before [1] [2] and an example test case is included at the end
> of this commit message.
>
> Attempt to silence the warning by returning specific error code -EOPNOTSUPP
> from the irqchip .irq_set_affinity callback, which skips printing the warning
> in cpuhotplug.c . The -EOPNOTSUPP was chosen because it indicates exactly what
> the problem is, it is not possible to set affinity of each MSI IRQ line to a
> specific CPU due to hardware limitation.

Why does the irq_chip in question have an irq_set_affinity() callback in
the first place?

Thanks,

        tglx

