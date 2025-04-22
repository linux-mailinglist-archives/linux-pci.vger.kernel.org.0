Return-Path: <linux-pci+bounces-26440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE157A9782C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF2E1893879
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B668E2BEC2E;
	Tue, 22 Apr 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcMbH3tm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97F2561AC;
	Tue, 22 Apr 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356027; cv=none; b=gB2ra4qi179iowzYfqvIHWZc0Y9ZIK4cf4zpRVIQASqEzl6iFIjrODJF/7BaiBPEYpI9qaM0CUqIWVsLjT+P1vC4ZaSW1GDqbHYsDJq6tOXbOwndVDO4vuFMK/tWCb7owMbWwCSDF9PRtu8T0Zo5oEjrl4suwIhQj/DjiuOuMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356027; c=relaxed/simple;
	bh=uqukdnY8PqmQkUxEKFuIv/luw1k925DyIN7ppE2OqgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oNwGNw2Rj9WRpuqG0dXmIoz5oGeoiw0Xbc5Oxo9wieXmVVOpYmuFcGipmv0wXufV+phtBPO4vV8x2g73Bdqs7JRWca7JjifvZkigMBdYDEMbDSMf/upOHuM602ZRZE7o8r4lCJw5L1Y8kLkiBuMcZyI7URE/L2+GIGO91+tnWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcMbH3tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2AC4CEE9;
	Tue, 22 Apr 2025 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745356027;
	bh=uqukdnY8PqmQkUxEKFuIv/luw1k925DyIN7ppE2OqgE=;
	h=Date:From:To:Cc:Subject:From;
	b=AcMbH3tm3L4XU3n7hfmwHlCdPBVgbUuKIvM/MWa2wtQK/YnbyTP4o2zttihlhu959
	 5yqBEAK3rOsAaG124RDJmZ42GNoXomL3tO27dio6pikcYmId1lsNy3jkBuUMnM4hgy
	 ZrB8qrAHgEbYhH1w2oUsJU7dPeXChvPAUoOze8A3v/fsTcvBxRNgCK8Aov7Lkj2TMd
	 5sa0Z8pMv9mHx0UOK9rwn3VDcCDY7I665DSmxbdyeH9SEQ/r5vWFIXOAK3nUVA3Q8j
	 LIayJV2F2C5kzxN+FrhFhrInDpPBT/pyXjldiWBWCbtl4Tpontkvc/2v7/Alc71ZuY
	 rQqGJoXYGKaJg==
Date: Tue, 22 Apr 2025 16:07:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: IRQ domain logging?
Message-ID: <20250422210705.GA382841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

IRQ domains and IRQs are critical infrastructure, but we don't really
log anything when we discover controllers or set them up.  Do you
think there would be any value in exposing some of this structure in
dmesg to help people (like me!) understand how these are connected to
devices and drivers?

For example, in a simple qemu system:

  IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
  ACPI: Using IOAPIC for interrupt routing
  ACPI: PCI: Interrupt link LNKA configured for IRQ 10
  ACPI: PCI: Interrupt link GSIA configured for IRQ 16
  hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
  ACPI: \_SB_.GSIA: Enabled at IRQ 16
  pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
  00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
  ata1: SATA max UDMA/133 abar m4096@0xfeadb000 port 0xfeadb100 irq 28 lpm-pol 0

I think these are all wired interrupts, and maybe IRQ==GSI (?), and I
think the ACPI link devices are configurable connections between an
INTx and the IOAPIC, but it's kind of hard to connect them all
together.

This from an arm64 system is even more obscure to me:

  NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
  GICv3: 256 SPIs implemented
  Root IRQ handler: gic_handle_irq
  GICv3: GICv3 features: 16 PPIs
  kvm [1]: vgic interrupt IRQ18
  xhci-hcd xhci-hcd.0.auto: irq 67, io mem 0xfe800000

I have no clue where irq 67 goes.

Maybe there's no useful way to log anything here, I dunno; it just
occurred to me when looking at Jiri's series to reduce the number of
irqdomain interfaces.  PCI controller drivers do a lot of interrupt
domain setup, and if that were more visible/concrete in dmesg, I think
I might understand it better.

Bjorn

