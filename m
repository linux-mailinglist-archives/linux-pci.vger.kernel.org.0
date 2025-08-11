Return-Path: <linux-pci+bounces-33746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1CB20BF3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89419167A46
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3932376E6;
	Mon, 11 Aug 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucZkR93v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JGf3xsbA"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77702472A1;
	Mon, 11 Aug 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922552; cv=none; b=qN20ZVNteiAa/cwE2S0003TnbzwG9B4LwdZK+Wk+VuC2mBOqGY/gyR/mUTFvF60wsH4W4+PTkkXoxqRCJQM+QmVif/Pskd6JixWoYUCTEH588VDC9hMbBUBVOJOlcsb/hmz28iPT4QBbP3LxceZqZhHcIWj3HfBRmTFXDFRAKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922552; c=relaxed/simple;
	bh=iXryWmopHOY8a81zJTGCBH44Vb9oGQCjTD7fCJfuOPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sS9wFaJUrNAhQG3VklEiXWbBjQRovndNffsrFy7mNpG6haoXX73BszkkizPb5WwB4nzmKKS7KfIlBXcmrrfWrQjEVztnqCD9Tcs2XUGyCXm3sDP+QZ3cVd0AKiixcJuC5rS4qCxuMsdFHb4LZ/nNaUKWvX6HtoKz1n/YbpzBUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucZkR93v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JGf3xsbA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754922547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0b9uhZ99G6HP2vSkLsosrnCJj6fZmIJ+wrncebmzMs=;
	b=ucZkR93vj5oOaB38QFCD06QFTz4dXaaArDco4WhpOc9NEz+X1HwlKsJGm/nJSsERSenUfm
	mQzsc6UGyKqZ6v0CLwC7T9gsl4lnDZQmgmh1BPAa+UAw/dLpbqoxiOgJnwCTZZDsZjTkcO
	fiOUDVhQnD83/LSZiJgIiW3tXSclQSObUxP3fsZijhLb2E4rpyHHP1EtXu+IeCWBwDgfT6
	52SyTAKw/u6o8VyWuWhscQwUecfxdzJ4mKMxWaAjkHmUecjp7pSvfqkHitwiqi54KYK/yA
	s1eSpj8wi4Wa/U8ZHmR47Y0x2pyc0yTC3pAd/xGrfUSPtD0EeidiDLQQ1vlGww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754922547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0b9uhZ99G6HP2vSkLsosrnCJj6fZmIJ+wrncebmzMs=;
	b=JGf3xsbAvfHxCievvUdqMC6cOTOC61sTBMYGTUOyYowchdMA51Uvoo39DjthWmH3xz/Jp9
	iQOECUnM3Q5a/4DA==
To: Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Nicolin Chen <nicolinc@nvidia.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/4] PCI/MSI: Add startup/shutdown support for per
 device MSI[X] domains
In-Reply-To: <hjummqbdurgohpv2kvrnr23abirami642vrpvs4j272yhw5hna@k3rqwvzax5no>
References: <20250807112326.748740-3-inochiama@gmail.com>
 <20250807162521.GA50955@bhelgaas>
 <hjummqbdurgohpv2kvrnr23abirami642vrpvs4j272yhw5hna@k3rqwvzax5no>
Date: Mon, 11 Aug 2025 16:29:06 +0200
Message-ID: <875xeu7wzx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 08 2025 at 07:18, Inochi Amaoto wrote:
> On Thu, Aug 07, 2025 at 11:25:21AM -0500, Bjorn Helgaas wrote:
>> >  
>> > +static __always_inline void cond_shutdown_parent(struct irq_data *data)
>> 
>> Is there a functional reason why we need __always_inline?
>>
> I am not sure for this. As I found other cond_[mask/unmask]_parent()
> also have this attribute, I added this as well.
>
>> If not, it seems like this annotation is just clutter, and the compiler
>> will probably inline it all by itself.

Most of the time, but yes in this case it's irrelevant.

