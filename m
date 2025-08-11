Return-Path: <linux-pci+bounces-33733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F0B20989
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30A4421459
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8B19C560;
	Mon, 11 Aug 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XZO+njxB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nrv9aKmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC93B29E
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917405; cv=none; b=YsE5tWCjiSteJPg0Pl0id7rJYfa4g6fXeQ+xFwtOVZV25X/qrKaC7rEbeEccwosHW5PRQahLWrOsM36jnS719+p0viCiy2a044crUVqpcvgqe8LfhpLZ3PPD4JZB+PZa+hTG4hvIcrOmVsMg+rhLizc68s+rjygdD1IDJTEABU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917405; c=relaxed/simple;
	bh=un+P00qFkEuDAS+YdBbbQFUvom5OnKIHpp4vkbh6BLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkX4VwR2UfderudxVpnwW6vLeS2Ya2x+nXvf1nX69c7qX2I4TaLA08Q5NOsXuacq2wPY/ncfO9t0BXpFuMaTL6/6AT9d4KDOFYCVZClimq6IT8w7bAMyl8JoRwA6pBV2ERjzezKq1Ji8LTKlM3Yyuvc6fZ7lIPTxDtiFi4canY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XZO+njxB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nrv9aKmS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754917402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uak9uMoSf1hFQNv+gxLqBrTo+PAvamtwLxZZOi8jwac=;
	b=XZO+njxBaetbKcIwqfljGMkgIa5Zeyna5UbnXeGA5/ZWOVWdem0bMc0gbPhwaqJibZppBN
	lhJB/aTzKYeLDzgliK6Pmwk0o3YVcSSCM9qULRAau3dr2ec1RDUit/lDnNIk2zOGBJNGFw
	L54UYuQurl26uH529YlO0OAyKS9yv+65PiGv5iFCQIArxV2KXkuEMNtY7JoORNOPfzrPc5
	FfVXlXLOl4h1N0E1fMhvvMc0eYR9EWNfLS2OsyObj1aqQEV9l2T1kg6qfX99uNyuyF2r7X
	oaLmX99jDar4TuvZgTOSVZ3P59HJjmfc+KZ87NpyvccPxvG8tZdv9w7fr7rHAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754917402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uak9uMoSf1hFQNv+gxLqBrTo+PAvamtwLxZZOi8jwac=;
	b=Nrv9aKmSaQqacXYMrZ9mwNow7CXAggaX2DJMyZkYm+KYRyt21towuYSwZZ+FNdT5BQS8+c
	jubCXSbpCj8csPAQ==
To: Coiby Xu <coxu@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kexec@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [Regression] kdump fails to get DHCP address unless booting
 with pci=nomsi or without nr_cpus=1
In-Reply-To: <87bjom8106.ffs@tglx>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
Date: Mon, 11 Aug 2025 15:03:21 +0200
Message-ID: <878qjq80yu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 15:02, Thomas Gleixner wrote:

CC+ Marc

> On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> Recently I met an issue that on certain virtual machines, the kdump
>> kernel fails to get DHCP IP address most of times starting from
>> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>>
>>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>>      # Provide MSI parent infrastructure
>>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>>      # Prepare for PCI MSI/MSIX
>>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>
> There were follow up fixes on this, so isolating this one is not really
> conclusive.
>
> Is the problem still there on v6.16 and v6.17-rc1?
>
> Thanks,
>
>         tglx

