Return-Path: <linux-pci+bounces-33748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44FB20C03
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE34A1886133
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002902D948C;
	Mon, 11 Aug 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WrhWuN8D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5sy7fxft"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0992D4B40;
	Mon, 11 Aug 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922791; cv=none; b=fMcml4lDJBAdbGX6mAgN7vd7LesFFrzz/U0jnhUyQgyNHYDfXQOlD9eQ39QpOULjagIvVGUVW395BsWJqFvGdTDK7ClC02G+93evKHPsXsTofV9GQ7WFKIDGJafJ2st6j2xCAjTPePkbexGYYpyigbZjT0Hl07xh13ASFtaH95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922791; c=relaxed/simple;
	bh=lHoZaqa6aYBuxwHHZ5RdOT9/ZRklgZLQ4rChKP4P9ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F/MWI+bqhuERmpcQeXQ3LeKJppsHt+cm/XQ9iVamce2Kt4znBbZA6DyepoymDCw/QAQ3i8s2bWosW3kQPh3bgG1Z1UtL8JsI0q5x0aL/58mRiU893+QTLYAOPLYuK8C3COelsH4sWddgNjtOENLyVilXGNm3CJqXg9oVrYzcSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WrhWuN8D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5sy7fxft; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754922788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHoZaqa6aYBuxwHHZ5RdOT9/ZRklgZLQ4rChKP4P9ko=;
	b=WrhWuN8DqhjexWzW+0+4TF0LtG5QuoMuPKsvNgRZnQcliyX7aHV/nCiuoSUGcWkXJiioBb
	AGO3sh8/MfgeT0uycBKfACz0S8B7UHmZ5xZPIlIuMNczSnn/WVGEHSWH/aV4kavhF0fhH7
	Arch/VI82skuZ0Oq9rrYd43tbU/+28Hja2giMMkDAAs7Mi6uxB5RUsHhRuWGg9pS37ZzH3
	nhn4KvFYMCPujWlDXFDNJmWxcbDXL8LG9iHHeecOE/B1Vf3Hd9suCIXgup9luLDh+Yfnyy
	W8L4DKy896a5Pz9UDYXUQXKS21E2e8hVgAriTgcpgzyXCQlm5l5Nz6nYJFw+2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754922788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHoZaqa6aYBuxwHHZ5RdOT9/ZRklgZLQ4rChKP4P9ko=;
	b=5sy7fxftqdp8WT4JvNj5ZktVoTddxo8OyaxX1ZlwpigpGiDO+7oqbxy6RIZGTFc4q3j7JV
	6U7OXvVFDlJBReBQ==
To: Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, Saurabh
 Sengar <ssengar@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Nicolin Chen <nicolinc@nvidia.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 4/4] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI
 flags for SG2044
In-Reply-To: <20250807112326.748740-5-inochiama@gmail.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-5-inochiama@gmail.com>
Date: Mon, 11 Aug 2025 16:33:06 +0200
Message-ID: <87349y7wt9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 07 2025 at 19:23, Inochi Amaoto wrote:

> The MSI controller on SG2044 has the ability to allocate
> multiple PCI MSI interrupt if the controller supports it.

interrupts ...

Which controller?

if the PCI device supports multi MSI.

> Add the missing flag so the controller can make full use
> of it.

Again, the controller does not make use of it. The controller supports
it and the device driver can use it if both the PCI device and the
underlying MSI controller support it.



