Return-Path: <linux-pci+bounces-33644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52653B1EE37
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 20:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30637265EA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE012264D5;
	Fri,  8 Aug 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRXvtoyc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npoNZDpP"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAA1E5B91;
	Fri,  8 Aug 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676442; cv=none; b=TEIvz3zkUs4RAHB85gOZQe3BxmbFT+lB+HLQ8V2aUqc60SbCRCSyRAqThRDHbc/z4sZsBbwA+KECPT3rhVhiL5G36MdyfEZvLNMY1kWNbvP790arhvMUYpYxerQMWR2olWaGLF6QqRTZpmrdSIizneoeufuZpRAuKmdlDBnkWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676442; c=relaxed/simple;
	bh=pJNpY57CxmQSy7mER2R+sQ2f65dA43zkAlzIyqe1vDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqRtCBeGiGSAM1fPaGkjfRVA18seWwMwd9bBE+PL6hqfeAJensHwGc2neikvubte1kWL7HoS0ANcVYIOcEqKZVK2ILTEoiciZdcoi4aQF8WcsT4jmJJGY9Eu5K/Z/69Bysxo9iWlmweCdlajF5rKsypR+ZTlZQP/0KpF9BFs/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRXvtoyc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npoNZDpP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754676437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMpiCUu9QWJjxbanF6WINDbl6JeFbSnL/EgMfADBlvQ=;
	b=DRXvtoycLLAt04LPrdSLMQTB7RLzkboVsPIPy4S0qcKh4HopcNKkvKOknsOR0wsvtURYhI
	uXTm3DM/mlk+0KsWf1X6bO+EBlhQ31JgGV732i+MZLap7m49v+83Op0XwzYcVdRGI27yAL
	vNPN+BXW/289qGJMrTcGI51XknQaP6CN8WHEYzeYj7rhDtKfkLOtaaL/U5XvzecXQiBWA7
	X0Qtz0F9EQmE42CYzaf5hI28LWYZR8ytC1jCHEQUKMiE/1ZbC3TUs67kdfMdJnwPONiOiN
	IAviPodvrBUsMNFVK7PFQX6PtTU4Vk7qy8fBtWteWxUNBd7GNYOGA9Xve+OOHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754676437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMpiCUu9QWJjxbanF6WINDbl6JeFbSnL/EgMfADBlvQ=;
	b=npoNZDpP6CXTist/ezHh5DGLxmNvYi5W4u7OZL1g7hiyliODMZIa+9n7iv1DzmfBmm/baY
	bFUd6uoi7qEFrECg==
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Linux PCI Mailing List
 <linux-pci@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Armando
 Budianto <sprite@gnuweeb.org>, Alviro Iskandar Setiawan
 <alviro.iskandar@gnuweeb.org>, gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
In-Reply-To: <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de> <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org> <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
Date: Fri, 08 Aug 2025 20:07:03 +0200
Message-ID: <87ectlr8l4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ammar Faizi <ammarfaizi2@gnuweeb.org> writes:

> On Fri, Aug 08, 2025 at 05:59:23PM +0700, Ammar Faizi wrote:
>> On Thu, Aug 07, 2025 at 12:13:37PM +0700, Ammar Faizi wrote:
>> > On Thu, Aug 07, 2025 at 07:03:50AM +0200, Nam Cao wrote:
>> > > Does the diff below help?
>> > 
>> > Yes, it works.
>> 
>> So today, I synced with Linus' master branch again:
>> 
>>   37816488247d ("Merge tag 'net-6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>> 
>> and applied your fix on top of it.
>> 
>> I can boot, but I get this splat. Looking at the call trace, it seems
>> it's still related to pci, but different issue. The call trace is also
>> different from the previous one.
>
> It'll be a bit tricky to bisect this one. Because if I step back to
> a bad commit post:
>
>    d7d8ab87e3e ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
>
> I won't be able to boot to reach this new splat :/
>
> I guess I need to apply the fix dirty for each bisection step. But I'll
> also need to make sure the current step has the d7d8ab87e3e commit
> anchestor before applying.

There is no point in bisecting before that commit, because the WARN_ON()
is added by that commit, so you wouldn't see anything before that.

The WARN_ONCE() tells us that some devices down the PCI tree are
allocating MSI, but VMD supports MSI-X only.

From the backtrace:
   msi_create_device_irq_domain+0x1eb/0x290
   __pci_enable_msi_range+0x106/0x300
   pci_alloc_irq_vectors_affinity+0xc5/0x110
   pcie_portdrv_probe+0x24e/0x610

It seems MSI-X are allocated first, but fail for some reason. Then
fallback to MSI, which triggers the WARN_ON().

So we need to figure out why MSI-X allocation fail.

I may need to ask you to insert a bunch of printk() to help me pinpoint
the problem. But let me stare at it first..

Nam

