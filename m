Return-Path: <linux-pci+bounces-2145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE982D69D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 11:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9A4284DA0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6AF9CE;
	Mon, 15 Jan 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9AB7rvA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S3Guhbe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80092BAE5;
	Mon, 15 Jan 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705312875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vWTc/rSFrzy3/1ggxjf061xaIHiQjwGl/dNAu/MBe0=;
	b=V9AB7rvAvU5jeVp2ZvQSW2veFTbKb1r/5ksnjWT4pQtkgIWS718ocgud4l/BoNKpLdscKu
	HGfOAcgTea2rMp5PvoX5UCsRKj0ajYQxGigZSLlJr5cU532V7TPHA35JZB6ioOKQ3dCa2Z
	+vj6iy1k9slxbdqN8QTjmcRy/o13wVPgYF+Ixn6Yia9Y86PSwAxohIq73jQoWOZ0KApqKK
	fJERj6csfYUbM2mJ3n9gHSco9zrCkQxbldecj0/bI35D5Xc01S31hVHX+DpG2tqG2FbdNx
	Q21wuVrZipVX0UVOv0HfcfEA964EOqCM8YF4/qhAynqSqq3CKexCmqMQdNMCIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705312875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vWTc/rSFrzy3/1ggxjf061xaIHiQjwGl/dNAu/MBe0=;
	b=S3Guhbe6wuhdaC/74RW11fsc3I1Ea+q+qR9gSrKQCw+5w1ZHCT51pbbcjcykM4w3Zx2fPg
	lqSQ1qqOUKgKt3Ag==
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 jiang.liu@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI/MSI: Fix MSI hwirq truncation
In-Reply-To: <b9a7b855-af2b-4858-b9d8-3340a0421cfe@nvidia.com>
References: <20240108120522.1368240-1-vidyas@nvidia.com>
 <20240111052814.713016-1-vidyas@nvidia.com> <87bk9qim4p.ffs@tglx>
 <b9a7b855-af2b-4858-b9d8-3340a0421cfe@nvidia.com>
Date: Mon, 15 Jan 2024 11:01:15 +0100
Message-ID: <877ckahq50.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 12 2024 at 23:03, Vidya Sagar wrote:
> On 1/12/2024 9:23 PM, Thomas Gleixner wrote:
>> On Thu, Jan 11 2024 at 10:58, Vidya Sagar wrote:
>>> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
>>> it to calculate hwirq number.
>> 
>> This still does not explain that this fixes it only on 64-bit platforms
>> and why we don't care for 32-bit systems.
> Agree that this fixes the issue only on 64-bit platforms. It doesn't
> change the behavior on 32-bit platforms. My understanding is that the
> issue surfaces only if there are too many PCIe controllers in the system
> which usually is the case in modern server systems and it is arguable if
> the server systems really run 32-bit kernels.

Arguably people who do that can keep the pieces.

> One way to fix it for both 32-bit and 64-bit systems is by changing the
> type of 'hwirq' to u64. This may cause two memory reads in 32-bit
> systems whenever 'hwirq' is accessed and that may intern cause some perf
> impact?? Is this the way you think I should be handling it?

No. Leave it as is. What I'm asking for is that it's properly documented
in the changelog.

Thanks,

        tglx


