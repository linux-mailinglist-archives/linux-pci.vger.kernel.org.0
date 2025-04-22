Return-Path: <linux-pci+bounces-26417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B585A973CD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8B67A3C37
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27361DB13A;
	Tue, 22 Apr 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEy8WRQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2B1D63C2;
	Tue, 22 Apr 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343718; cv=none; b=tjs3L17Pn0zH1sym8resLXGKS0i82XqW7e+F6KzwJbM7gzdeBdTVzubJ2Hox3j6Jb4OclZkgO8buaMaHjQ/iPmv/+yRkIlcJ9nfgEyH4gMdiWo/91vGn5grqN2eDty/Z0UK/t4IGl3Zsucv1csLzvOqBWWbbwI+i+C8CVoOsp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343718; c=relaxed/simple;
	bh=uq0jfSz7h0BjZ8ZpTqc6CuX5FFVkIxfTxureh4fqZro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=anol45xnf7odKxS2Z3oSDX2t9UrYyEHYjNdfDD0Cuy4WWot4U3bCILLF+6OQpYyY589pEXEPR6w4a7wxKYAFGxvJHlrFgcXeYgOZCSQKd1ZGUvZb98TltgQ5blaFOr6TtSjl3oXLbjqP8/jky7lq8Z4KUnaHB/2jhN9kXWUTGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEy8WRQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E667CC4CEEB;
	Tue, 22 Apr 2025 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745343718;
	bh=uq0jfSz7h0BjZ8ZpTqc6CuX5FFVkIxfTxureh4fqZro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EEy8WRQF134ZRnLUMOw1REGAnSr4h7t7LjozRR5uQeOga6pLqJEu1PNtpK8GPajFl
	 9Ms6+eK1MG0lhpVUfrsu6XvmlV0spw7EkWxSWHzFeS/9AROv/bwK9hWOAQbh9TMkPF
	 wLLNeRjdwbYllVfX2HhxzMFR4xjJtIOkcRWFSkwiet3LrnUydheQeTT4x2cBvz9stP
	 7nTq13b2DziCDxdrS24IX4ym45xns+8p3Qc0zSTiQBMYZyN0qtEZRuMYzDasCWgPyA
	 nKw7Mm9mm9Fx5JJsfl69eBCH5LZwjPAJL9Drv3ToeU2X5r350VTnL6Aha7Q0ZxBCMF
	 JljBFb4XcfggA==
Date: Tue, 22 Apr 2025 12:41:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 07/13] PCI: apple: Move away from INTMSK{SET,CLR} for
 INTx and private interrupts
Message-ID: <20250422174156.GA344533@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401091713.2765724-8-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:07AM +0100, Marc Zyngier wrote:
> T602x seems to have dropped the rather useful SET/CLR accessors
> to the masking register.
> 
> Instead, let's use the mask register directly, and wrap it with
> a brand new spinlock. No, this isn't moving in the right direction.

> @@ -261,14 +262,16 @@ static void apple_port_irq_mask(struct irq_data *data)
>  {
>  	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
>  
> -	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKSET);
> +	guard(raw_spinlock_irqsave)(&port->lock);
> +	rmw_set(BIT(data->hwirq), port->base + PORT_INTMSK);

sparse v0.6.4-39-gce1a6720 complains about this (and similar usage
elsewhere):

  $ make C=2 drivers/pci/
  drivers/pci/controller/pcie-apple.c:311:13: warning: context imbalance in 'apple_port_irq_mask' - wrong count at exit
  drivers/pci/controller/pcie-apple.c:319:13: warning: context imbalance in 'apple_port_irq_unmask' - wrong count at exit

But I guess we just have to live with this for now until somebody
makes sparse smarter:

https://lore.kernel.org/linux-sparse/CAHk-=wiVDZejo_1BhOaR33qb=pny7sWnYtP4JUbRTXkXCkW6jA@mail.gmail.com/

Nothing to do, just "huh".

Bjorn

