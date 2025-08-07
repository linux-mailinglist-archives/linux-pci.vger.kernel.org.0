Return-Path: <linux-pci+bounces-33508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8FB1D158
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A207AA6B0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475401D9663;
	Thu,  7 Aug 2025 03:52:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BCAD5A;
	Thu,  7 Aug 2025 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538724; cv=none; b=Ziwgt6eGec/CiUb0iadb4hIyE1PsbkQK1m/N6KFHsh6FUacMcvnoT7CXaUS5zcD7toOWQhN8OCaa71/EeuA1YWC+HZ93zT/YTzQ95FrM6MA0oEj0hKcqt8fgGHhIEVOG+kqzSzUml4NU4IDDCwHNhoQLInC/EXE9L0nO5bGSLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538724; c=relaxed/simple;
	bh=KQrLUVYVJdKagNhjPBpxQxIvGDBeMiv3wKq7MLJAGBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axO9qH1d/oRnNKCNSgBKVodHHYthpUssVIXS0KvotmQpKnJyEk4zNckxVXDcn3dltT5v2MtBEX2jmkLdGgTKy9s4ieA69ms+Jc5MvYN51lvPuGOgUTO65/lUoBL8/MqeyD5tNzaxGKVe7VQvyIFDH3Zc8sOPjxf/9ZtUrxWgg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0305B2C000BF;
	Thu,  7 Aug 2025 05:51:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BC2B9375CB1; Thu,  7 Aug 2025 05:51:57 +0200 (CEST)
Date: Thu, 7 Aug 2025 05:51:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <aJQi3RN6WX6ZiQ5i@wunner.de>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>

On Thu, Aug 07, 2025 at 10:34:08AM +0700, Ammar Faizi wrote:
> On Fri, 01 Aug 2025 21:37:28 +0000, pr-tracker-bot@kernel.org, wrote:
> >
> > The pull request you sent on Fri, 1 Aug 2025 09:22:54 -0500:
> >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-changes
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/0bd0a41a5120f78685a132834865b0a631b9026a
> 
> Yesterday, I synced with Linus' tree, but couldn't boot. Crashed with
> this call trace:
> 
>   https://gist.githubusercontent.com/ammarfaizi2/3ba41f13517be4bae70cde869347d259/raw/0ac09b3e1d90d51c3fed14ca9f837f45d7730f0a/crash.jpg
> 
> This morning, I synced with Linus' tree again, still the same result.
> 
> I suspect it's related to pci. I'm still bisecting. I've successfully
> narrowed it down to this pci pull.
> 
>   0bd0a41a5120 (refs/bisect/bad) Merge tag 'pci-v6.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
>   db5f0c3e3e60 ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)
>   12d518961586 tracing: Use __free(kfree) in trace.c to remove gotos
>   debe57fbe12c tracing: Add guard() around locks and mutexes in trace.c
>   788fa4b47cdc tracing: Add guard(ring_buffer_nest)
>   c89504a703fb tracing: Remove unneeded goto out logic
>   877d94c74e4c (refs/bisect/good-877d94c74e4c6665d2af55c0154363b43b947e60) Merge tag 'linux-watchdog-6.17-rc1' of git://www.linux-watchdog.org/linux-watchd
> 
> Now, I am testing:
> 
>   769ce531faa6 (HEAD) Merge branch 'pci/controller/msi-parent'
> 
> I'll be back to it later. git bisect says:
> 
>   Bisecting: 65 revisions left to test after this (roughly 6 steps)

Kenneth reports early-stage reboots caused by d7d8ab87e3e
("PCI: vmd: Switch to msi_create_parent_irq_domain()"):

https://lore.kernel.org/all/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/

Perhaps you're witnessing the same issue?

Thanks,

Lukas

