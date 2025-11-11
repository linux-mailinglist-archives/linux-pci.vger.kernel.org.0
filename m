Return-Path: <linux-pci+bounces-40917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24935C4EA18
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81A83BCCA9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32A2DECCC;
	Tue, 11 Nov 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HpvA2JeL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UY84aFD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A7339B39;
	Tue, 11 Nov 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871975; cv=none; b=LmMhOrVAO2AxHnJlX2KbIEmSu4xEOaMa/PDWmkPdp6j0UD8g71K+aAQtSsVLFNEagS0ZeXvrFGYChWi4z/VbHIyHklBGBv4VKG7iQCSokO8DKLpuyIkFzX8UaHeQHsOBqxqKrcoTz+oYjkpJ2lqOCxLtfXn8cLsGm4ghbLjv8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871975; c=relaxed/simple;
	bh=T4YjsZoRwdzDgjx08Bih7n7FVxeKaoqwpPv8CdLIAvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5S2+Fdmd+n+c0okrlf1Yn36UjJiBm1W2cXzHTV6CK7+bMToUTOpOXoKci6HWxqebjt537NXyGZZPcVqGhktj9NJO2JoAxpkBptxuzlY9g9D/pr5SKkeAsth6nklnNM1GYYgH0H1TXyCk6wrT8D3Zip1Y8AZTn8yITp9mDkHlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HpvA2JeL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UY84aFD5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 15:39:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762871972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4YjsZoRwdzDgjx08Bih7n7FVxeKaoqwpPv8CdLIAvg=;
	b=HpvA2JeLK7wlX9zTW+73KNR1eVaI+ruGvWla9BmgOadRWKRhYFKgCqLzhrWJVKn5qANS2g
	K533tGM81GbVBMpfssMw3oqdefgVuwYAhg3fN1QC1S4GtTcTZw9H5FTjZvMhgcWG2oaeX2
	lGbD/k47DjaTPN5DF/n442zx8WWnUIby0xYSD3gZgY+m9X3QVB00icpA7XI0VOBtboRb/i
	zBA6Dwv2s98sJoXMSGtbPVwdJE+pVUvoWJ+tBnQFbYO4uM2iWS9oyokfKRkkcrbsplHUb5
	TnxRZuZa8+yBso7oe0poTH3qUd4MPAbLyndmXonWbk3iNnD0z9qfUpnRPoGbqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762871972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4YjsZoRwdzDgjx08Bih7n7FVxeKaoqwpPv8CdLIAvg=;
	b=UY84aFD56kpelnYGfC1+L4F2qwxqNYNilDKCck2mXX58jbG9auEABUYiSbsP7lBcL/eNW1
	/Q8SVQS4kup4WZBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to
 raw_spinlock_t
Message-ID: <20251111143931.k7QsQ8Tb@linutronix.de>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
 <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
 <20251103192709.GV1386988@noisy.programming.kicks-ass.net>
 <aQydxtOtgPTPxL_9@2a2a0ba7cec8>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aQydxtOtgPTPxL_9@2a2a0ba7cec8>

On 2025-11-06 13:08:22 [+0000], Guangbo Cui wrote:
>=20
> LGTM, If there are no objections, I=E2=80=99ll include these two patches =
in the
> next version of the patchset and add your Signed-off-by tag.

I would suggest a Suggested-by or a Co-developed-by. Unless you take his
work, make him the author and simply provide a patch description among
his "patch".

> Best regards,
> Guangbo

Sebastian

