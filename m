Return-Path: <linux-pci+bounces-22464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D11CA46DEA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9683A7A72B2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77325B665;
	Wed, 26 Feb 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRISoGuc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAB25A65F;
	Wed, 26 Feb 2025 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606603; cv=none; b=FfXIF6U/Jx+XxV0369NfzwXy9oCBTw1RkXmyKZLQigqmerWDqK1ZpueG0PpDLlFRqqsnpPzCNeG6JOPf4dUeVRVgBTYRyipv8a67fV7gvdJ50PS9xi0fARDeTx1Df+lX/UYBPFAj/lFKwA6utscRpr0ilibNP8mxzbjC46ju5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606603; c=relaxed/simple;
	bh=2v+4HEo1wDQYhwWDZwWTJqdhCqXIpOhgQQKRbDadRzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pe5FhrIYIjZGwKMuweLQo7z9pGWa/azmslGFfRWkRcZHYpYH98iqm0QBvDbbsZ45g2nogjYNQZXZyQ4w2Q6rDSRgBsVpE90/lg+tdWp6ZdtQTKHO0LkQkAqHx3/Nho+i1nw7HS5mwCWJh94DdMGXKcnzkgynu+uaiTbUG1Z+YZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRISoGuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B683CC4CED6;
	Wed, 26 Feb 2025 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606602;
	bh=2v+4HEo1wDQYhwWDZwWTJqdhCqXIpOhgQQKRbDadRzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hRISoGucKnzij+fgY2fdstngUAK5lo/Dn1tbKeQ96JtzWb+7bpe7zGI2dsNuaJzWy
	 9+iqQM3ObJzbcqGfCuvJvu2aB1DqPkXCHdUK60FUls4eOt1MCUhCpXqZW+gUT3cswg
	 Ffgxq6F+vXd4wwRfKp3XWo3dfgiKbRl5Exi81Wk8lcuDvi4zUiTybX+RLBmpYPBRN4
	 xcPBBWBQNVM+HRLu0kX/3ffWLLCnsuxm2OzgcFp/F7aczSApDA63VjCAAepmVc/V1w
	 49imEtdzm0LDGYNj+/ZI/ulB+pFdNkvnN/CyVaB2y94UgVzUEXlJWNvMMNJ4qKAy9p
	 IsMNRHz1QdZaQ==
Date: Wed, 26 Feb 2025 15:50:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <20250226215001.GA556020@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874k0bf7f7.wl-maz@kernel.org>

On Thu, Jun 23, 2022 at 09:31:40PM +0100, Marc Zyngier wrote:
> On Thu, 23 Jun 2022 17:49:42 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jun 23, 2022 at 06:32:40PM +0200, Pali Rohár wrote:
> > > On Thursday 23 June 2022 11:27:47 Bjorn Helgaas wrote:
> > > > On Tue, May 24, 2022 at 02:28:17PM +0200, Pali Rohár wrote:
> > > > > Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark:
> > > > > Rewrite IRQ code to chained IRQ handler"") for pci-aardvark
> > > > > driver, use devm_request_irq() instead of chained IRQ
> > > > > handler in pci-mvebu.c driver.
> > > > >
> > > > > This change fixes affinity support and allows to pin
> > > > > interrupts from different PCIe controllers to different CPU
> > > > > cores.
> > > > 
> > > > Several other drivers use irq_set_chained_handler_and_data().
> > > > Do any of them need similar changes?
> > > 
> > > I do not know. This needs testing on HW which use those other
> > > drivers.
> > > 
> > > > The commit log suggests that using chained IRQ handlers breaks
> > > > affinity support.  But perhaps that's not the case and the
> > > > real culprit is some other difference between mvebu and the
> > > > other drivers.
> > > 
> > > It is possible. But similar patch (revert; linked below) was
> > > required for aardvark. I tested same approach on mvebu and it
> > > fixed affinity support.
> > 
> > This feels like something we should understand better.  If
> > irq_set_chained_handler_and_data() is a problem for affinity, we
> > should fix it across the board in all the drivers at once.
> > 
> > If the real problem is something different, we should figure that
> > out and document it in the commit log.
> > 
> > I cc'd Marc in case he has time to educate us.
> 
> Thanks for roping me in.
> 
> The problem of changing affinities for chained (or multiplexing)
> interrupts is, to make it short, that it breaks the existing
> userspace ABI that a change in affinity affects only the interrupt
> userspace acts upon, and no other. Which is why we don't expose any
> affinity setting for such an interrupt, as by definition changing
> its affinity affects all the interrupts that are muxed onto it.
> 
> By turning a chained interrupt into a normal handler, people work
> around the above rule and break the contract the kernel has with
> userspace.
> 
> Do I think this is acceptable? No. Can something be done about this?
> Maybe.
> 
> Marek asked this exact question last month[1], and I gave a detailed
> explanation of what could be done to improve matters, allowing this
> to happen as long as userspace is made aware of the effects, which
> means creating a new userspace ABI.
> 
> I would rather see people work on a proper solution than add bad
> hacks that only work in environments where the userspace ABI can be
> safely ignored, such as on an closed, embedded device.
> 
> [1] https://lore.kernel.org/all/20220502102137.764606ee@thinkpad/

OK, this patch [2] has languished forever, and I don't know how to
move forward.

The patch basically changes mvebu_pcie_irq_handler() from a chained
IRQ handler to a handler registered with devm_request_irq() so it can
be pinned to a CPU.

How are we supposed to decide whether this is safe?  What should we
look at in the patch?

IIUC on mvebu, there's a single IRQ (port->intx_irq, described by a DT
"intx" in interrupt-names) that invokes mvebu_pcie_irq_handler(),
which loops through and handles INTA, INTB, INTC, and INTD.

I think if port->intx_irq is pinned to CPU X, that means INTA, INTB,
INTC, and INTD are all pinned to that same CPU.

I assume changing to devm_request_irq() means port->intx_irq will
appear in /proc/interrupts and can be pinned to a CPU.  Is it a
problem if INTA, INTB, INTC, and INTD for that controller all
effectively share intx_irq and are pinned to the same CPU?

AFAICT we currently have three PCI host controllers with INTx handlers
that are registered with devm_request_irq(), which is what [2]
proposes to do:

  advk_pcie_irq_handler()
  xilinx_pl_dma_pcie_intx_flow()
  xilinx_pcie_intr_handler()

Do we assume that these are mistakes that shouldn't be emulated?

[2] https://lore.kernel.org/r/20220524122817.7199-1-pali@kernel.org

