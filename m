Return-Path: <linux-pci+bounces-33647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700A4B1F121
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 00:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E41B188776A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A053227465A;
	Fri,  8 Aug 2025 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="NoumSNcX"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1C1DE3A7;
	Fri,  8 Aug 2025 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693559; cv=none; b=nkOk6VfTq4s7BXe0zHjuNgI2vl8kfN/rnQHIMk8vAMGtV1tbU02hvNBY+vjx5JnbcOJTehuMqZMkDxBOsTwaILawQa3Xg+Cd8DoKPIaaRWBLP1ileITpp+3tUvA1y0o8+gILKX4VdKOwdsRMsg2lrr550kKoHxOCUcJ9nMtZ+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693559; c=relaxed/simple;
	bh=MSOWrqDWF2D2s0K6tC64bc+DGY3dYv6ArPql468xyVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE5yikVVdjI40yAq0c18V4SjcieZF/MdjSfbxDprbKsXb0F4alI1ZaC1Gjiw6+vBBo1IG34mHpAp2T+LUUs+uKRyDKi5chUU+8O5T/zlmTQnLZVzyIeq935StzCG1Ggp8qNbMf44h+/05a7rnM1Q8xQqNiO5gbN4V7PXkHyEj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=NoumSNcX; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754693555;
	bh=MSOWrqDWF2D2s0K6tC64bc+DGY3dYv6ArPql468xyVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=NoumSNcXKgNrLf5DWqvvE+R9ZRBNMAN+FgVJKo3RUdI9wk4l2Mlth2AW7V2LUMw9J
	 SheTXmN4H+Q8gxPth7JJ825FeZeiTiBATwHJrZ5ZokOiiKkngfdgNP6b60Nbar3z0k
	 5UyJt71ae0uL0brg64teV1a6LL2zs4Px45LfJM216Ee/G6GRACJyK5I6EoWwteqFbo
	 K4c0gjkZ0CtP4RdwKfyHs3Tyy6RYaeghxyb87CMEblGaxHZ2ixvqs8pGIuWbcsS+PG
	 taos0H9iyX4OXQnRuYgVPUiRBjC2bvmr+yBtZQC+zbopIv9JSmPUnPwnm1cdnLiXTu
	 D22/RqV/1dHxw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.185])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 855DB3127E05;
	Fri,  8 Aug 2025 22:52:32 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Sat, 9 Aug 2025 07:52:30 +0900
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
References: <20250801142254.GA3496192@bhelgaas>
 <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
 <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
 <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ectlr8l4.fsf@yellow.woof>

+ Adding tglx as he's involved in reviewing that commit.

Context: https://lore.kernel.org/linux-pci/aJXYhfc%2F6DfcqfqF@linux.gnuweeb.org/

On Fri, Aug 08, 2025 at 08:07:03PM +0200, Nam Cao wrote:
> There is no point in bisecting before that commit, because the WARN_ON()
> is added by that commit, so you wouldn't see anything before that.

I didn't notice that. Good you pointed that out earlier.

> The WARN_ONCE() tells us that some devices down the PCI tree are
> allocating MSI, but VMD supports MSI-X only.
> 
> From the backtrace:
>    msi_create_device_irq_domain+0x1eb/0x290
>    __pci_enable_msi_range+0x106/0x300
>    pci_alloc_irq_vectors_affinity+0xc5/0x110
>    pcie_portdrv_probe+0x24e/0x610
> 
> It seems MSI-X are allocated first, but fail for some reason. Then
> fallback to MSI, which triggers the WARN_ON().
> 
> So we need to figure out why MSI-X allocation fail.
> 
> I may need to ask you to insert a bunch of printk() to help me pinpoint
> the problem. But let me stare at it first..

I can do that. Send me a git diff. I'll test it and back with the dmesg
output.

-- 
Ammar Faizi


