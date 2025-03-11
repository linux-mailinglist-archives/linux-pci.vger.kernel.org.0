Return-Path: <linux-pci+bounces-23429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDCA5C335
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA2B3A3451
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE28254857;
	Tue, 11 Mar 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1QjvbTl9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDjpensC"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D4156C62;
	Tue, 11 Mar 2025 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701924; cv=none; b=c+gSCnQt0akW8IJR4jT0ORqjMqnBZlaIP4cIGmpNnQrS8wUFf8Hr7mqxSPcvsWTQ36Ab2dANB+ElbN1F8yzswX52Je6tii+CLeOp2pEm7xeh72MmgIlq3CDtPXDrAdmX7+mOcna3qlif1UWGdXZqEy0d0LAL/4nWueu3hLEDcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701924; c=relaxed/simple;
	bh=7TIUhH6YvCGnqZKtUNrL8O3a77QVGxzBJt4gDmHpNhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ht8vPcY+cXXh5Y2udtQtszVaP042KQAWOJdYshx+oEYjmFQOtQjjTwFtoztsRG4Wb8IB59FUqht4ex8B+oV2tPa73YlZrB1XkWc1PFza3bW0dHawVFMot+8nHFs7GWGh23YTlkeRtpRYueYh3R1MexLc/tCbmDJ04rfI8qFhS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1QjvbTl9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDjpensC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741701918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFuGzd839JjnXJnzQCNenTt8lLgnnByiRc80jF+qXsw=;
	b=1QjvbTl9/qg3XdLtrSh1NBF9ecD218AyolXh74KUuMJRgXfArp6ur83sGi6l7oceGsr/MS
	uV+eKjCu9ukEMUo9IY7BxrI54nLgX+ygH81TAKr1HyNlnKKDc7VyvN/O5Y9oaXbU70X7nr
	dlXUBurO3zNTcaTPfNzrRQYMqshyBPk2ECPelB0br8U5rVvryq9N7CMRve1twMdgxa82aX
	pobVPEMT94RcyX3jrFFsUwcfSwY4N64dSShrbbeVMg1BJlfRlyOPFBvt6s+Q5oK6fnHsAZ
	oE0eTvaXovVOBuFXimr0cup6LS2nVBAZqSUMnvCxHiH7O4VuFzT3C79VWQ91dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741701918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFuGzd839JjnXJnzQCNenTt8lLgnnByiRc80jF+qXsw=;
	b=UDjpensClIuIbIu62W+Sz+m0Qwh8XPFDhb0RE/GtjkHZYOwH+oiOZsuS+FD3XgaABcFg3Z
	18tOCJu5V713yXCw==
To: Tsai Sung-Fu <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant
 <achant@google.com>, Brian Norris <briannorris@google.com>, Sajid Dalvi
 <sdalvi@google.com>, Mark Cheng <markcheng@google.com>, Ben Cheng
 <bccheng@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to
 the parent
In-Reply-To: <CAK7fddBSJk61h2t73Ly9gxNX22cGAF46kAP+A2T5BU8VKENceQ@mail.gmail.com>
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx>
 <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx>
 <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx>
 <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
 <878qpg4o4t.ffs@tglx>
 <CAK7fddBSJk61h2t73Ly9gxNX22cGAF46kAP+A2T5BU8VKENceQ@mail.gmail.com>
Date: Tue, 11 Mar 2025 15:05:17 +0100
Message-ID: <874izz1x42.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 11 2025 at 17:52, Tsai Sung-Fu wrote:

Please do not top-post and trim your replies.

> Running some basic tests with this patch (
> https://tglx.de/~tglx/patches.tar ) applied on my device, at first
> glance, the affinity feature is working.
>
> I didn't run stress test to test the stability, and the Kernel version
> we used is a bit old, so I only applied change in this 2 patches

I don't care about old kernels and what you can apply or not. Kernel
development happens against upstream and not against randomly chosen
private kernel versions.

> And adding if check on irq_chip_redirect_set_affinity() and
> irq_set_redirect_target() to avoid cpumask_first() return nr_cpu_ids

I assume you know how diff works.

> May I ask, would this patch be officially added to the 6.14 kernel ?

You may ask. But you should know the answer already, no?

The merge window for 6.14 closed on February 2nd with the release of
6.14-rc1. Anything which goes into Linus tree between rc1 and the final
release is fixes only.

This is new infrastructure, which has neither been posted nor reviewed
nor properly tested. There are also no numbers about the overhead and
no analysis whether that overhead causes regressions on existing setups.

These changes want to be:

   1) Put into a series with proper change logs

   2) Posted on the relevant mailing list

   3) Tested and proper numbers provided

So they are not even close to be ready for the 6.15 merge window, simply
because the irq tree is going to freeze at 6.14-rc7, i.e. by the end of
this week.

I'm not planning to work on them. Feel free to take the PoC patches,
polish them up and post them according to the documented process.

Thanks,

        tglx

