Return-Path: <linux-pci+bounces-25874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6CA88C76
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 21:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C1171F38
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2B1C84A6;
	Mon, 14 Apr 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnZAkYO+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EB80Jnyx"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80A1C6FF1;
	Mon, 14 Apr 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660344; cv=none; b=fGB4qsC4/8zqo5W87ugdxkyKK0s7Ksex7w2gshzSPqbX/OmLttVFHcZJvWbwuFLT2oNVfXBKQ1k9vCBHM2fSQASIutEP9xa0/bYcaJgBQM6KwjOfmq/P+h8QQ0dT4nKiS60wgn1kEdo9HcylWd+LZrlEXJh6hEuYzLdmDn4/dCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660344; c=relaxed/simple;
	bh=a1Md35S00tYUBQsziGv04GZEB0/AY+9lgXYxwmTfct8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phtN+aOI46Wv9FKNlLXwSf+6qtV+yHD1bHrSLAjmqBvyGiXVhKd801romRhf9nck0GRR4dLVf/FGBHPnAUrPqK/SBu84+FHiInCPz6SD4XgSVDGiyxGDhsPF1z83wDm0581uPDSslmp4O2OTeBGH05wsPRvuGXO6PJk/9rsIqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnZAkYO+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EB80Jnyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744660340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0S740qleCmgkrbdEvjx/nqcxMkbyNTdRzm7JKTXmZEU=;
	b=WnZAkYO+N+Rzc1/b/xvI2mnLtXgx9IU4tjGitFtN4NQVuvsBcCIuYZ/bDZ3FEHyxvh8I2b
	fny+j6obuxOH3599VllMl1n1PdaXOX2rex2q9dk63HSUiiB71QrvD0b3n9iFPgxdDPnS3Z
	J8L1JtUeSg7w+Ie2Bxo980N4cjl3FqXZjJvmqrc3Wo3kbC5yvwoZoIgjJstCMTuYHMonXJ
	JUZCr9//T4yc4R4WKXMknppEcv6in4eY5RI8XLf/8msgAf9TP0cvMpp0o5Qt7HpWTfGQyg
	OqXeFIWqi983qlXgtOHT4HIiwnFjVT3TSNyXxPLHlLayPrMkUquWuQuR/2lTlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744660340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0S740qleCmgkrbdEvjx/nqcxMkbyNTdRzm7JKTXmZEU=;
	b=EB80Jnyx9nTJoDZwnL1xI3XuRXR5KqoUfc6XlG5jKcIPNmqnUIvk7S4vfY+F1uprJVyg38
	RtAuTLq3rCG5CCBQ==
To: Dullfire <dullfire@yahoo.com>, Paolo Abeni <pabeni@redhat.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Mostafa Saleh <smostafa@google.com>, Marc Zyngier <maz@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
In-Reply-To: <3aa3b1aa-84c1-4bdd-ac79-918bcd80f98b@yahoo.com>
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
 <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
 <5a580609-aa5e-4153-b8dd-a6751af72685@yahoo.com>
 <3aa3b1aa-84c1-4bdd-ac79-918bcd80f98b@yahoo.com>
Date: Mon, 14 Apr 2025 21:52:20 +0200
Message-ID: <87friaseq3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 14 2025 at 11:22, dullfire@yahoo.com wrote:
> On 1/20/25 6:38 AM, Dullfire wrote:
>> On 11/21/24 04:28, Paolo Abeni wrote:
> [...]
>>> The niu driver is not exactly under very active development, I guess the
>>> whole series could go via the IRQ subsystem, if Thomas agrees.
>>>
>>> Cheers,
>>>
>>> Paolo
>>>
>> 
>> Thomas, does this work for you, or is there something else you would to see in this series?
>
> Since it's been a few months, just wanted to give this a bump, and see if the series is lacking anything.
> Thanks,

Sorry for letting this fall through the cracks. I put it back on my todo
list...

Thanks,

        tglx

