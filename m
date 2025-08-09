Return-Path: <linux-pci+bounces-33672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4DAB1F56F
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48CA189C6AB
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE592BE7B0;
	Sat,  9 Aug 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJ8yVLVn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nNgYSaqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3D2E36EE;
	Sat,  9 Aug 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754756892; cv=none; b=pQXJq3SMGc4RonXT4dnVJkKdsweLtA5yS+WK+VmC9ikrhXJSmQX9l+3Y9AknyRSY3vsvcGzjjCPytk3PdMxx4HLqxWBrB/HjdZssQOAHr4kDmKQnl93VrxAtEE/YDT9rcPGHPhOU52oL5rIRo7JjA+nCtnVMgsw7B6qKsJdXZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754756892; c=relaxed/simple;
	bh=aPLm6QL6vU52pLZ7PYQvh4xZM/UHPGJFDYeKhJ/u40Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTvf9QTTqt3xvS4WWWlF/nqjliDCforSz+NyJ0Pe8jaylyY1A3TZdTeWKHHopOkWEXGlQAJDx80pZsXA9qOBnmhyRtR4eLgivEe/hCY9qlyTmN27LOoWQRRL9DLsbIZe1mF0ThW55HcvsXhpQN3CcmzUL4GW9/2hxqheUskPJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJ8yVLVn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nNgYSaqF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754756888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PS8l+qmFFn8A9kMqskYImlOYBznIbxngq+KJri3fzOU=;
	b=MJ8yVLVnY1FgjOe1jbGV1gmPUtThCHydpX7PK97BsLQcsbexU791MYy7JjPqx1kRj0q0Ku
	9NyjDG/tXBD0qnVD622xTlC6GOf37zVugcSgTEGM/3jDkvNiTeC7Goz7O4XhwkRqhfJbqa
	48li9fFDMPc4EatsdvpkGAVazzKI/sKcVSeS3HS/3CEDisy5cwXp6As24EK2crsPsxvcO1
	Jgt2kH7bssTGC14taPJcpsdmE1RUAcjlwisGJGAmep/GKO3ZTbpNarvtYXowIyHbE73jp7
	SfMTS0jqT3IB6fsC0eGITYo9+S99mf1vF4EBycc5FhMZCMAr6AFma1IpARqeBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754756888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PS8l+qmFFn8A9kMqskYImlOYBznIbxngq+KJri3fzOU=;
	b=nNgYSaqFQ4yFdo8FEYAO9wlgpDnYAfEa1LYrNMB6MiFS1ikPFkTLqg9ytDoNk+4GFlnslc
	r0Kcbm6rNyBrStBg==
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux PCI Mailing List
 <linux-pci@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Armando
 Budianto <sprite@gnuweeb.org>, Alviro Iskandar Setiawan
 <alviro.iskandar@gnuweeb.org>, gwml@vger.gnuweeb.org, namcaov@gmail.com
Subject: Re: [GIT PULL v2] PCI changes for v6.17
In-Reply-To: <aJdxVy1i3wGTvU3b@linux.gnuweeb.org>
References: <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org> <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
 <20250809043409.wLu40x1p@linutronix.de>
 <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>
 <20250809144927.eUbR3MXg@linutronix.de>
 <aJdmGwFU6b9zh1BO@linux.gnuweeb.org> <87wm7ch5of.fsf@yellow.woof>
 <aJdxVy1i3wGTvU3b@linux.gnuweeb.org>
Date: Sat, 09 Aug 2025 18:28:07 +0200
Message-ID: <87tt2gh33c.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ammar Faizi <ammarfaizi2@gnuweeb.org> writes:

> On Sat, Aug 09, 2025 at 05:32:16PM +0200, Nam Cao wrote:
>> So unlike what VMD doc says, it actually can have non-MSI-X children devices!
>
> If that's the conclusion, then Intel VMD doc also needs fixing :/

Other possibilities are problem with your BIOS (likely), or problem with
Linux's PCI enumeration (unlikely).

But without hardware, I cannot investigate this further. Now that we
know my commit didn't make the driver any worse, I am done here.

>> Please discard the reverts and the diff I sent you, and try the diff
>> below. I believe your machine will work now.
>
> Yes, I can confirm it's now clean. Just to verify both sides, here is
> the last result:
>
>   https://gist.github.com/ammarfaizi2/72578d2b4cc385fbdb5faee69013d530
>
> If that one fix is final, then:
>
> Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>
> Thanks for the debugging work.

Thanks for running tests, it would be impossible to figure out otherwise.

> It's probably too late to get the fix in mainline before rc1. But if it
> can go upstream sooner, that would be great.

I don't think PCI maintainers are available at the moment, so I will
send the patch next Monday. Time to enjoy my weekends..

Nam

