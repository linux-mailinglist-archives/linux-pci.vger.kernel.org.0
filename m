Return-Path: <linux-pci+bounces-33732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F88B20986
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 15:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FA87A9C47
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE45619C560;
	Mon, 11 Aug 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3erkPJ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4Y+tgr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85F139D
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917358; cv=none; b=F4DZDCfS+z8kdidwUNO0V8WOY7ousn0LUy6Wv9/dQEj1zgKGwNV2sUOV6ontQuqQFKEbidwQv0MGimdBKg8mnsdjLu7BfKEDdG67goiuH/CYPhyqF06GC0rJwL1RnA/hRjJRu9FBG7Y3s+Mr8B3MOj+2EYsQ68gEfDnULiO9mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917358; c=relaxed/simple;
	bh=J1ONyC0Swp2SCABYDiISNQ1Ba/ANGqCCk54sdg3rV4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H0FLrEDPpjpUXjelvUMqs20K8oMp1OjE3CQPal3OcfjEUlSzOxvNNWsWm1GsuuFwbcqphidWN6AGaElqS3z/RT07uQlIJWtUn1i7OYwHsWQaqY2FyO/agP8sdWLXOZwgvEcj/XSBm4d8SO6hx/LkU/qsvGGHQEMHhv+89Pdzq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h3erkPJ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4Y+tgr8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754917355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDsjR207hfpsaWUHS9KSTpKCqXr2Odiy8s+8w4yXsg8=;
	b=h3erkPJ4NkDW+BeSWj3jOZn/ZGUa4FEE9JuMubh7GmQO/xSdORO43i1f2TGCAx7LclvCel
	9dlSMuUFY1QEn6HT3DcCzjXgedPje7ukbnrfz61ShpqJVfIv45A6MRiZdGhCro8cLvyp6D
	Nns5bSv3fC6yDw2+7GfgiiDOnD4QOkCWkSCWfXmFs9kOynD/sBGXLh64QuaDLRatM/IFCs
	xtH/6BUwyJD/fGxHkR50P0Qm0rMTLo9DrbReKCHoMP+DJPKdd3e4OuA1G3zYSVGyhxCeO2
	o9KXEo2+RT/leeWR8ggjPvrIawD5MGG+Y9ALD+MuiZEIFFqWOQwgp9jisrAToQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754917355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDsjR207hfpsaWUHS9KSTpKCqXr2Odiy8s+8w4yXsg8=;
	b=y4Y+tgr88v/UurMktQIBqQoWuoT9Dxmn7FMhhA7sXmj2EIPKrfjmO3mlZzeAu9UuKEfCF7
	lPXqfFmyhCf4qkCw==
To: Coiby Xu <coxu@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting
 with pci=nomsi or without nr_cpus=1
In-Reply-To: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
Date: Mon, 11 Aug 2025 15:02:33 +0200
Message-ID: <87bjom8106.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
> Recently I met an issue that on certain virtual machines, the kdump
> kernel fails to get DHCP IP address most of times starting from
> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>
>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>      # Provide MSI parent infrastructure
>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>      # Prepare for PCI MSI/MSIX
>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]

There were follow up fixes on this, so isolating this one is not really
conclusive.

Is the problem still there on v6.16 and v6.17-rc1?

Thanks,

        tglx

