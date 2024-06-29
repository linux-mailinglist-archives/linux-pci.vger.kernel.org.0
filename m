Return-Path: <linux-pci+bounces-9439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FCB91CC29
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44841F22B9D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9F4502B;
	Sat, 29 Jun 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nw4MLVWO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcBbTenA"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954F2033E;
	Sat, 29 Jun 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719657885; cv=none; b=OQXj57xutgahHRIUZVFHj6OEx6XFkB00ZbjUrEHC2agO4+fAkSgHv664q91GpsFOPQB5Mh8DC2dR110KadKn2wP9U8JjGX1+Dz4w8+1+AtBIrpm42yL9lGQr6QGBK9J98TC2p8AuJ+Y/VyIWfQ8lkn0sBBSNjfrQrnRZboJuCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719657885; c=relaxed/simple;
	bh=6VXJiGOnoyju9ruRHYHFhUu95mEhUl6t/2oo8RmMCOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFPlLsrGNCGk5Nnl4wYdh/7HJPYERBkPKC3555q2ecHmYZ+PwwLWxck28Q7NuEVWdKwEXUTlUc/KESvErfnnxiQ3b0slzusbGEBZLKKjNvepkUakCjMD9MALi8E/R9M9H2IFkWvKYy2vYG7Xkm0BYMWiuClVsp2bmulhbUTWCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nw4MLVWO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OcBbTenA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719657882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBr0wMQUI9nfHEgcW87Tn7+jfpVx+jXLrJH0EYZ954o=;
	b=nw4MLVWOk00BwhzggrZaMrhcXL2Kh+j64AG8H/iGBr9RQvByomDldI84G3tc8QkuT0uJKc
	JuKWG0UAs9db/0QVzkXV/K6n3ggUWczQo/SwMVpMRb0aK3hGZs1mGDAKunMoKLtpIaqVN5
	K92YNbJAFDA/YNlmLdRnfejd/MZwf+4yDiZy+J/NhqWa3IdRYC9dWAZvMjSf0K0uiOPklv
	L+SWhkCQB5mrSIoujAC6h3KlrFM5D+BAH1M84bE4xK/YmAUNdloOEkY9++dE4vuYHLeeik
	jPBo2KMuo9ts18/M9C9eWSt9KT0jZ2wRVNTzp8/m3cRm01s4QycJd3tkmAxufA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719657882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBr0wMQUI9nfHEgcW87Tn7+jfpVx+jXLrJH0EYZ954o=;
	b=OcBbTenA5kOfmm/vsUhr/wkot+gSaZ5It7tkFtx+SJNb4IWB2rNQq89G4tWsxqSaCti1RQ
	pcjv31+K/6gJhyAw==
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 05/21] irqchip/gic-v3-its: Provide MSI parent for
 PCI/MSI[-X]
In-Reply-To: <86bk3khxdt.wl-maz@kernel.org>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.024567623@linutronix.de> <Zn84OIS0zLWASKr2@arm.com>
 <87h6dcxhy0.ffs@tglx> <86ed8ghypg.wl-maz@kernel.org>
 <86cyo0hyc6.wl-maz@kernel.org> <86bk3khxdt.wl-maz@kernel.org>
Date: Sat, 29 Jun 2024 12:44:41 +0200
Message-ID: <87ed8gxc2u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc!

On Sat, Jun 29 2024 at 11:11, Marc Zyngier wrote:
>> I have the ugly feeling that the flag is applied at the wrong level,
>> or not propagated.

Indeed.

> Here's a possible fix. Making the masking at the ITS level optional is
> not an option (haha). It is the PCI masking that is totally
> superfluous and that could completely be elided.

It's the right fix because ITS requires this bit to be set.

Vs. PCI masking, you are right from a pure ITS point of view, but not
from the PCI side. PCI can't be unmsaked until there is a valid message
and we need to mask it on shutdown.

It's not a run time issue at all because PCI/MSI is edge triggered so
the mask/unmask dance only matters during startup, shutdown and message
update.

> With this hack, I can boot a GICv3+ITS guest as usual.

It's not a hack. It's the proper solution. Let me fold that back and
look at the other PCI conversions which probably have the same issue.

Thanks for digging into this. This help is truly welcome right now.

Thanks,

        tglx

