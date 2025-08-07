Return-Path: <linux-pci+bounces-33510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB883B1D1B0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 06:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE35158369B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 04:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADE1F4198;
	Thu,  7 Aug 2025 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/asic9y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/UOISatG"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA301F239B;
	Thu,  7 Aug 2025 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541884; cv=none; b=kcn36zqK2P57CBclbNkfjEd4Jr9qcJuNYCK86BP3EHX39w/LPFFXN3Nc34lUZDKw6blFSYBI0aYg2K9nQqeHHteROOWwUncS87zthrfPefOC/6d+ztpowpTYhKJnCtDievznV/ywUYhkDMKbh4K4PytpPNsxR+tolOwiaCnR3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541884; c=relaxed/simple;
	bh=cFxSt5XGCz9igYehnP6ZlKa3IQLd9KL5n7sdoqkopCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IE5ibn8ked8GuR147LmV+egT1zclp7JPH0fNZb42glRR2T8r8UVkToel1J2ayrpSkb2VWp/BkVGFuzS6CAhY3LkuEkyhsROziKGP7srjNxCvH9PeCCnlcq9leb7rlfd7zW6Zit4Nodqd46+uW+copWjAk20+W7q+0USX/jtT02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/asic9y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/UOISatG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754541879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k0aIP6ypWzHT44UgOkBVcPGZN3HFudjWTg/qcOTfKY=;
	b=I/asic9yMpQUvuowiDDokB36lGvVIOyqKgxFeYqNfXwKjVyDxooBj8k3pctGcTaXIAl+x1
	b1H5dcR49Xq3/e54XPivZP6dKr/pX8i9e96j4RsrFURJhIpGoe24ovFZZTqUm3JjpFvkrw
	dfpWzD9Ph9X4rOmwd+CKm/z9b91xn3RZFcnQ1hZTv05XGDVqHBbaHw4WwuaoReAY4lhlYY
	zwMiSvPVQbpTw4BzxV3ETNAbuGGWcMQFzuIio/bGwA7zV/8RB/RrHPqeg/GCbpH1PCwKoW
	wxl58kG9PxeNXapnyadFx6Y/VZN/jCfUXFFcYvHjUdf5kYATcunl2wnEZSb65Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754541879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k0aIP6ypWzHT44UgOkBVcPGZN3HFudjWTg/qcOTfKY=;
	b=/UOISatGlrMVsEsTLbm3XYwyu8t5IcwBT50pdtVufLyqynw/vZVizgMs5gisd7f7PPnBH3
	90keY1phI5zTBwAw==
To: Lukas Wunner <lukas@wunner.de>, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux PCI Mailing List
 <linux-pci@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Armando
 Budianto <sprite@gnuweeb.org>, Alviro Iskandar Setiawan
 <alviro.iskandar@gnuweeb.org>, gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
In-Reply-To: <aJQi3RN6WX6ZiQ5i@wunner.de>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
Date: Thu, 07 Aug 2025 06:44:38 +0200
Message-ID: <87sei3n3k9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Wunner <lukas@wunner.de> writes:

> On Thu, Aug 07, 2025 at 10:34:08AM +0700, Ammar Faizi wrote:
>> On Fri, 01 Aug 2025 21:37:28 +0000, pr-tracker-bot@kernel.org, wrote:
>> >
>> > The pull request you sent on Fri, 1 Aug 2025 09:22:54 -0500:
>> >
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-changes
>> >
>> > has been merged into torvalds/linux.git:
>> > https://git.kernel.org/torvalds/c/0bd0a41a5120f78685a132834865b0a631b9026a
>> 
>> Yesterday, I synced with Linus' tree, but couldn't boot. Crashed with
>> this call trace:
>> 
>>   https://gist.githubusercontent.com/ammarfaizi2/3ba41f13517be4bae70cde869347d259/raw/0ac09b3e1d90d51c3fed14ca9f837f45d7730f0a/crash.jpg
>> 
>> This morning, I synced with Linus' tree again, still the same result.
>> 
>> I suspect it's related to pci. I'm still bisecting. I've successfully
>> narrowed it down to this pci pull.
>> 
>>   0bd0a41a5120 (refs/bisect/bad) Merge tag 'pci-v6.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
>>   db5f0c3e3e60 ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)
>>   12d518961586 tracing: Use __free(kfree) in trace.c to remove gotos
>>   debe57fbe12c tracing: Add guard() around locks and mutexes in trace.c
>>   788fa4b47cdc tracing: Add guard(ring_buffer_nest)
>>   c89504a703fb tracing: Remove unneeded goto out logic
>>   877d94c74e4c (refs/bisect/good-877d94c74e4c6665d2af55c0154363b43b947e60) Merge tag 'linux-watchdog-6.17-rc1' of git://www.linux-watchdog.org/linux-watchd
>> 
>> Now, I am testing:
>> 
>>   769ce531faa6 (HEAD) Merge branch 'pci/controller/msi-parent'
>> 
>> I'll be back to it later. git bisect says:
>> 
>>   Bisecting: 65 revisions left to test after this (roughly 6 steps)
>
> Kenneth reports early-stage reboots caused by d7d8ab87e3e
> ("PCI: vmd: Switch to msi_create_parent_irq_domain()"):
>
> https://lore.kernel.org/all/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/
>
> Perhaps you're witnessing the same issue?

Thanks for the Cc. The backtrace does look like something that the
commit would cause.

Let me stare at it.

Nam

