Return-Path: <linux-pci+bounces-32960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D7B12603
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 23:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D23458490F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4925D212;
	Fri, 25 Jul 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apYQtwuZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392625CC69;
	Fri, 25 Jul 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477757; cv=none; b=BReewvSItSS2rr0LeYiyYgIQVzuH6hWCaxG5FaTDRNo1N/IyMAaKzNf59bMgJd7aR+zTEzOYgoPrFNwp1fkWIfPjX6dbor1vdVu+PzfCIJzxbVSRVQfyewKxUPYyQWeUkRjegs6Q4c+0FSWcE2TEXzZ11srfSCa5DlxqAU0HotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477757; c=relaxed/simple;
	bh=OIsCnW+40UMSUhVeIOmMDekEzJwiUoSrnJ4nPIagwfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aQp+ICJQ/2sFAGqlcaEV2ueSmnGT179+DAduUwlFQn8QO8H65YlIYqJtn+CWKkJiYacqMusvYHO9rqXKFhdzeu0UnLI4j8yik2B3VCUgWbbVMkwzAE8lRM9aysgosrsnmlbOHKUvGSHYc44XRRiukQVxLd/67oWSeQZDi3EKo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apYQtwuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18FAC4CEE7;
	Fri, 25 Jul 2025 21:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753477754;
	bh=OIsCnW+40UMSUhVeIOmMDekEzJwiUoSrnJ4nPIagwfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=apYQtwuZIMyedbEqbSYOMeFj2JtJex90IE3y7FNfBPpoue1ZbN6ZtVcU6SdBpcu7O
	 rVPfpnZDuRWy/KlgXRq8WqvjV0pYqzi4IjWRLBGv89OrTDwSeTsfpxjT+C6COz7nfn
	 RbESEUtK9nCTdAuznD+QPCfcIP1pTOMKmrBjuCUFzfXpW1iWUx48TNxiYMkS22hUYg
	 d+xvYr0Xt0q3VTcw2IEVxeB3+SVgbGGF3tWTdKem6oRKUUYju3VoVnyFPD56vbgURg
	 kSVJMBhYssYpCpRu/+U8ZRXjd7di83EQtSiirdHcQsHDh2aGiT3hJJbtIz2Etv+k0K
	 G/j16V1gBUOuQ==
Date: Fri, 25 Jul 2025 16:09:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com, Jonathan.Cameron@huawei.com,
	bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 1/2] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250725210913.GA3130903@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723033108.61587-2-xueshuai@linux.alibaba.com>

On Wed, Jul 23, 2025 at 11:31:07AM +0800, Shuai Xue wrote:
> Hotplug events are critical indicators for analyzing hardware health,
> and surprise link downs can significantly impact system performance and
> reliability.
> 
> Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
> for hotplug event to help health checks. Add enum pci_hotplug_event in
> include/uapi/linux/pci.h so applications like rasdaemon can register
> tracepoint event handlers for it.
> 
> The output is like below:
> 
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>     <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_DOWN
> 
>     <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_NOT_PRESENT

I asked about documentation earlier [1], but didn't see any response.
I think these tracepoints are important and will be widely used, so it
seems like some kind of user guide would be helpful.

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Nit: I assume this came from the patch I had applied to pci/trace, but
you shouldn't include any sign-offs from people to whom you send
patches [2].

Bjorn

[1] https://lore.kernel.org/all/20250717192950.GA2594528@bhelgaas/#t
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.13#n449

