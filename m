Return-Path: <linux-pci+bounces-23147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D1A57275
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFD41899EB7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB91A4F3C;
	Fri,  7 Mar 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06TrbF8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ak+vZRz"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23253DDA9;
	Fri,  7 Mar 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376983; cv=none; b=coAWPumdzUmTsdlOnbm7u0bOB5w+lDZkV24yzM55YMsXEj8yDOnqvv8Y7/1D3VqXNvu70TDtWXdJ24zvtI9dyt+gMKoAfpT/Qe1cDX8591r+07K2Ojp5yZITQZVTEjSbVwMmQ+t1lxAoPg5xuFXr0cH5DTi7vq/3Gc+giPA6G6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376983; c=relaxed/simple;
	bh=XHTHCPKvEi03/hWk1CH1ZPSFXqifak4Vq8xVcKAGqBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYktgz1wTlkpFzxJogdU1N8DSloZOhsv/KDAxZYtZ28C6FVbPdAEIy9gtvGskH7JpNC+KMxuBFa0JnNPqcKxZIPtz+rUdGwxK2mjNTC4ogLm3d6fPH/JWKbyvpBGP93iMl+B1z8aRoZJSts4sA3Z/Vf9bGmVwdpu+KWhYJblxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06TrbF8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ak+vZRz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741376979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sULuRMWtdxzN85HXmKWfAgG3HUOWtKyQSj4jX7okY34=;
	b=06TrbF8/2othdnL+RlBA0H5GxTkeo0128tSJh0sWi8UW1p/oXCPLGJ9OefiWibvI/fpx1C
	UJyfH/aO5KcUWYgZIYpCNBM+K7C+4jIDhC7wCiP6KCNyZ68f+ZOxzANnwr7awUS62RA9sH
	F2gHLFohXrxqQ5CiZ3WuO5xP/o+qelGBy/iVRDVvaSWFybASDRaU6MrRFLCxUKtZdS9LWt
	GOh+Tx5ny2RWp7IQZzaUI+8GSDamffvtK25tPbRLlj8Z38S+j456851CpaNze4RUfhcr7S
	pk4Z2Yew50ePPbGU3r2s6Zi1T9epKRk+qCtCmk7Al6KSjRiBljQr0su9xTOkMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741376979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sULuRMWtdxzN85HXmKWfAgG3HUOWtKyQSj4jX7okY34=;
	b=6Ak+vZRzOKvj4t9cA7ALqhkIFvEcCCrW7D0F+pIZA4NdbZJAko+KN7q/BsI5fTS5S6s3LH
	fMTnIrplw5mdC+BA==
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
In-Reply-To: <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx>
 <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx>
 <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx>
 <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
Date: Fri, 07 Mar 2025 20:49:38 +0100
Message-ID: <878qpg4o4t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 07 2025 at 19:10, Tsai Sung-Fu wrote:
> Thanks for your detailed explanation and feedback, I am a bit confused about the
> #4 you mentioned here ->
>
>>     4) Affinity of the demultiplex interrupt
>
> Are you saying there is a chance to queue this demultiplexing IRQ event
> to the current running CPU ?

The demultiplexing interrupt (currently a chained handler, which is
hidden from /proc/irq/) stays at the affinity which the kernel decided
to assign to it at startup. That means it can't be steered to a
particual CPU and nobody knows to which CPU it is affine. You can only
guess it from /proc/interrupts by observing where the associated
demultiplex interrupts are affine to.

So ideally you want to be able to affine the demultiplexing interrupt
too. That requires to switch it to a regular interrupt for
simplicity. We could expose those hidden chained handlers affinity too,
but that needs some surgery vs. locking etc.

> And that's really an approach worth to try, I will work on it.

I've played with this on top of variant of Marc's changes to use MSI
parent interrupts for such controllers too:

  https://lore.kernel.org/all/20241204124549.607054-1-maz@kernel.org/

A completely untested and largely uncompiled preview is here:

     https://tglx.de/~tglx/patches.tar

The MSI parent parts are in flux. Marc will look at them in the next
weeks, but I picked them up because it simplifies the whole business a
lot. If you find bugs in that series, you can keep them :)

Thanks,

        tglx

