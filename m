Return-Path: <linux-pci+bounces-20419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F2A1DBE6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873E91883394
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240518A6D5;
	Mon, 27 Jan 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfTBVeNH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9d+a+D1o"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F918D649;
	Mon, 27 Jan 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001435; cv=none; b=nXkcCazteH/0SlEXf0NSKUUB4fdaMSUvJg9r+flgF1SIraHsqMFBU+lEGYnigZYixBrUlA4zBhkiPBZs/Jr1NflJGmHz2taJ7+M4MebvJQW489JoekwiqdxOSfeyTRlRL7dEcS5NHDPN8cV/vvhiBxIu/oEjszrX2MNRS0Vhyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001435; c=relaxed/simple;
	bh=sW6A4mZSE5UQOYvsd/QaeHsnmQsGmlxZb+kaj70zryg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qzuXjoBtjnLwwIDr3WcFrThBmSykgomutkcC/HN/5bwAO1uRavZyaXD4/FgACda5mp4fGus9GcHe2yJv/c2gLasiy3YjxxXZX7Acor9MqGFOL7bdZmmqSwEoHEYfpRaXWF/ohVWoKnynWETAPovVd5R9LCeeOVuJuMlMn+FEdXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfTBVeNH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9d+a+D1o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738001431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pirFz880PHbl7Wsu56VW30PJh1UmmzZuboMbJFV0f10=;
	b=AfTBVeNH/KTFCBWBIDIdyxrcqzkaCjvXFQD717inHpxdKq7RWRRkd/0Q/TOWz7tXL1L+3c
	DTfIewtewEJNl57fRNWLpn1RljU+Q17YGytKeSw/2Ww5SvRHkQNgrbUE1NK8JzcWnaLPM+
	bSYHEC4AEUKKfCQ4flblBbrONfwH0xFHD2wFgoB7jQNegBJr4PdeYsBAgtLyiyZORa7rz/
	aubZCmQAmyYKXX/Y82j+kQafqoeWzD1KjbWi9FCz0QZ4pQuKz5NQaTe/Vr0iTp9c7pHgRH
	PtwGtS98oYJSeBf9WFYg8456k0OclH18bGAKXs4TCIeyzbhLDuIp8oa3LH/z+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738001431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pirFz880PHbl7Wsu56VW30PJh1UmmzZuboMbJFV0f10=;
	b=9d+a+D1oiQsTecowN1fpws3+HVT50yXPpNcciisFoaJvwhgEVDXVSwc7zfvsbfA2d18HAz
	4MT/ITjMeLI9jhAg==
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 kw@linux.com, Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta
 <andrea.porta@suse.com>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH v5 -next 03/11] irqchip: Add Broadcom bcm2712 MSI-X
 interrupt controller
In-Reply-To: <20250120130119.671119-4-svarbanov@suse.de>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-4-svarbanov@suse.de>
Date: Mon, 27 Jan 2025 19:10:31 +0100
Message-ID: <87bjvs86w8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 20 2025 at 15:01, Stanimir Varbanov wrote:

> Add an interrupt controller driver for MSI-X Interrupt Peripheral (MIP)
> hardware block found in bcm2712. The interrupt controller is used to
> handle MSI-X interrupts from peripherials behind PCIe endpoints like
> RP1 south bridge found in RPi5.
>
> There are two MIPs on bcm2712, the first has 64 consecutive SPIs
> assigned to 64 output vectors, and the second has 17 SPIs, but only
> 8 of them are consecutive starting at the 8th output vector.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

As this is a new controller and required for the actual PCI muck, I
think the best way is to take it through the PCI tree, unless someone
wants me to pick the whole lot up.

Thanks,

        tglx

