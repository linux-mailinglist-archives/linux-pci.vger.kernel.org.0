Return-Path: <linux-pci+bounces-44443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF257D0FFEB
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 22:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9081F304F174
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jan 2026 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88BA1D63D1;
	Sun, 11 Jan 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jELmB6At"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5270347DD;
	Sun, 11 Jan 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768168336; cv=none; b=mlUHK8huKF4gWdSnem18M0CiRN59CWN4fQDdOlgFJumLktRlu70ZUKlI52cLqlrvFKo4aRJe+woPe7RsiButdPyTVSaFbBsbIg2Cg52kRrewoQwoOCnFLSxqiLrTcdWSOYe1x1m9hMWzCvXrpma9DNsiiG/0JQGV6eS6XHzXw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768168336; c=relaxed/simple;
	bh=gBJl0jhJQTOjs2kWtiwlGj2NK+MzVVpaCnR9lzcialw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j4gjU3x096kkKHtyUilnuos4gv+Yv2nYfDS0YTUW4Qwjo2e60Q90feUoS7cEGd+MCKSIp8grwtBLIJ+CvukKCOiHc5T1hbQx7hvKyY08Oml9QJHu8Xv2J9dvux/X60rgtbZuIC2/U+ceFlvjpJHRuRiSR6cUDaOLHvvc8kg8tMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jELmB6At; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A408C4CEF7;
	Sun, 11 Jan 2026 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768168336;
	bh=gBJl0jhJQTOjs2kWtiwlGj2NK+MzVVpaCnR9lzcialw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jELmB6AtfPWLe4I0Wri47bMLigG2GC2kGVH3KZiAYvDhcWRHtHDGQHZDQmODLPrjP
	 p4ckNBuwPvjEX5CcJ6C0EI9yAsnpCOyDvYXPoJcxMhjEbLsiN1A8CFp2HxNMz6zGja
	 nyCs82ftoyoS/jPY8LoLkXMgn6hnNwxQQ4wbvcVkjWnqKQrTiOmnpT0X0PTeNHkZXC
	 0UDivXDgw9UspxY+wyMmDz6NfdDNyzwncNoJ/1KqpEQ8wd4xFb/YSl1WNIr8VNKnqn
	 TjIt5oXh0yPVhqGBHrVcLZljwPE42LMq8qQSvGYotOpfeGdQ1nQIdhUdfkykPQ2aEG
	 FP1dsnueeDEkQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Daniel Tsai
 <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
 Krishna
 Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>, Eric
 Chanudet <echanude@redhat.com>, Alessandro Carminati
 <acarmina@redhat.com>, Jared Kangas <jkangas@redhat.com>, Jon Hunter
 <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] fixup! genirq: Add interrupt redirection infrastructure
In-Reply-To: <20260109175227.1136782-1-rrendec@redhat.com>
References: <20260109175227.1136782-1-rrendec@redhat.com>
Date: Sun, 11 Jan 2026 22:52:12 +0100
Message-ID: <87fr8bg6lv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Radu!

Thanks for taking care of this, but this is not really the way how it
works.

$subject: fixup!.... is neither a valid nor a useful subject line.

$subject is documented to be a concise summary of the change at hand, so
in this case this should be something like:

   [PATCH] genirq: Update effective affinity for redirected interrupts

See?

On Fri, Jan 09 2026 at 12:52, Radu Rendec wrote:
> The previous version of this patch has two related bugs:

The previous version of which patch? The patch at hand does not have a
previous version, right?

> - irq_chip_redirect_set_affinity() doesn't update the effective affinity
>   mask, which triggers the warning in irq_validate_effective_affinity().
>   This bug was reported at [1].
> - As a result, the cpumask_test_cpu(smp_processor_id(), m) condition in
>   demux_redirect_remote() is always false, and the interrupt is always
>   redirected, even if it's already running on the target CPU.

How are those two bugs? It's only one because the missing update causes
the malfunction in demux_redirect_remote(), no?

> The solution is not ideal because it may lie about the effective

Which solution? Care to read this change log again and figure out what
"the solution" means? You fail to describe the solution before you
describe it being non ideal...

> affinity of the demultiplexed ("child") interrupt. If the requested
> affinity mask includes multiple CPUs, the effective affinity, in
> reality, is the intersection between the requested mask and the
> demultiplexing ("parent") interrupt's effective affinity mask, plus
> the first CPU in the requested mask.
>
> Accurately describing the effective affinity of the demultiplexed
> interrupt is not trivial because it requires keeping track of the
> demultiplexing interrupt's effective affinity. That is tricky in the
> context of CPU hot(un)plugging, where interrupt migration ordering is
> not guaranteed. The solution in the original version of the patch,
> which stored the first CPU of the demultiplexing interrupt's effective
> affinity in the `target_cpu` field, has its own drawbacks and
> limitations.
>
> [1] https://lore.kernel.org/all/44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com/

This wants to be a Closes: https://... tag which makes that [1]
reference superflouous when you describe the problem coherently.

It also lacks a 'Fixes:' tag as the code is already merged, no?

> Signed-off-by: Radu Rendec <rrendec@redhat.com>

Read 'git log kernel/irq/' output and search for 'Closes:' tags in the
commit messages and you get the idea.

Thanks,

        tglx

