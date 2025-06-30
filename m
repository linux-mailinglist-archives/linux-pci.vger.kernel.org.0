Return-Path: <linux-pci+bounces-31096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D8AEE5EA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE0B7AC959
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB128F95F;
	Mon, 30 Jun 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJLQgmbt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08B2701CA;
	Mon, 30 Jun 2025 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304860; cv=none; b=heP5NEKp/HclbIlhM3DwUGgYbx84vBEYcKSFRWfYBX1wEQfiCF8qm9Ur2a9MpVzB0Tv7in3tPuCTu1E2VXyqms0rW42MAkRnHG3SX/2f0OmIsr2wGMXv2tWZNlwtj31wGv38+Mx2O2Gg2o4+MfMt89xA9OauWHebWm7sr80uJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304860; c=relaxed/simple;
	bh=TaK2FH9yiJmwJGSGOTvljnkUt8CYe3d5qFJFNNZcc/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hUiw4j7FOjMn0RLveV5STm5Pk0gkZadt6dkPO8E3X1eescLryXOAeDvukBHYsmfBBi3NhPU+X9nSyiIbF1Lesg9MbfmnBonL6KS/7FQRWLHx4N0Labh+EegsGwq6foVeYfbnvL1j2jUdjW2yqYFhz1P00xuJpXXJ+9jWyehI09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJLQgmbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE78C4CEEF;
	Mon, 30 Jun 2025 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751304857;
	bh=TaK2FH9yiJmwJGSGOTvljnkUt8CYe3d5qFJFNNZcc/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rJLQgmbt/DWmf4OmbJ0sQ8HOx5dQ42qQd0nK3vrJk8SDsdQq9pFGyR0MDLhz/FgQ4
	 8MdSqlyR+6NtxNLev58EJYpKPdaXTvvwRqT1Jjn3yvuX8Ig8MsZ+lUDpKZ5qERn851
	 d8o46yAD1RVx7OqwjKTAtG2cMRSLAG9vtFP7YX4w0/Y9+3++tSww8L9ENtdRmJzYYe
	 2tuL8S1OAKjPuaD733BRP/dvSN3vaxcrZHetDiYKI5ZJa2hPCyz3044QAx1/dSMr0b
	 SM9K525UNRUruJM5XR/Dd0LDH9N57GzTGODhjUSLjluIyi0KTOUws0oLwNN2F/7BHQ
	 F/2Ll3fpXF+TQ==
Date: Mon, 30 Jun 2025 12:34:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: host-generic: Fix driver_data overwriting bugs
Message-ID: <20250630173415.GA1787642@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ikkdb0uj.wl-maz@kernel.org>

On Mon, Jun 30, 2025 at 06:23:00PM +0100, Marc Zyngier wrote:
> On Mon, 30 Jun 2025 18:06:01 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > On Wed, Jun 25, 2025 at 12:18:03PM +0100, Marc Zyngier wrote:
> > > Geert reports that some drivers do rely on the device driver_data
> > > field containing a pointer to the bridge structure at the point of
> > > initialising the root port, while this has been recently changed to
> > > contain some other data for the benefit of the Apple PCIe driver.
> > > 
> > > This small series builds on top of Geert previously posted (and
> > > included as a prefix for reference) fix for the Microchip driver,
> > > which breaks the Apple driver. This is basically swapping a regression
> > > for another, which isn't a massive deal at this stage, as the
> > > follow-up patch fixes things for the Apple driver by adding extra
> > > tracking.
> > 
> > Is there a bisection hole between patches 1 and 2?
> > 
> >   1: PCI: host-generic: Set driver_data before calling gen_pci_init()
> >   2: PCI: apple: Add tracking of probed root ports
> > 
> > If so, would it be practical to avoid the hole by reordering those
> > patches?
> 
> Sure, but you said you already had queued patch #1, and what is in
> -rc1 already breaks Geert's box. So no matter the order, we break
> something at some point.

I did, but when I saw your problem report and subsequent updates, I
put Geert's patch on hold.

> If you want to only break one thing, then yes, swapping these two
> patches is the correct thing to do.

I swapped them and put them back on pci/for-linus for v6.16:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/log/?h=for-linus&id=ba74278c638d

