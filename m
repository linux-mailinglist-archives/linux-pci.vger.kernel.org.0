Return-Path: <linux-pci+bounces-31091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBCAEE53F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780467A7516
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D82EAE3;
	Mon, 30 Jun 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV9AGgVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B48CA4E;
	Mon, 30 Jun 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303163; cv=none; b=ToJpx9qtQFCEQ50xDmB647JozNATpjq2WPsJ6NCcraILDQU7tjMGruqX3e5k4ncjAm18VZJrCXvLTvztRIYhOahKayyCQRUfN4PbOycoB4Ry8BYI9mNrU94GIBwHbXTgng1kUq+kM2SBRk2tXXC5tgcjCXnBBkuXlEKyAodoXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303163; c=relaxed/simple;
	bh=YS1h67nHopU5jEDVPXIholPcSs4LOSkc7OQ/xawugyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n6YRhX2uJ7iPYt9siBz3FkAIvunESXWTpR8DOTGSCnf6nETS19AtmHuKbqiOfttDMuyWoleyksuB+IDkTBp2jy0+rnzhIEuPO6bvrB6U4/uM9YYj7sYfViZbT++c5eJdNmjnFgWNDSG7JI/E5fAdhzfb+2bsCxF1Svfy7DAc+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV9AGgVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809A9C4CEE3;
	Mon, 30 Jun 2025 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751303162;
	bh=YS1h67nHopU5jEDVPXIholPcSs4LOSkc7OQ/xawugyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hV9AGgVdssVMQd1wnnDfmJ0GOhvJ+r/NtVR9vxunWsbWGlijCdQnQw1Z3LMXp3Ord
	 tOMaOM6uC0Gp1V9N5x+SfFkqYP0PTcshgQ4gsFokjlEqTQi43h7iXhvIHaQsEmkIkE
	 nhxr1yMj7FMimmZvTFk+Z31JuUN8RHKfUwqoY/uR1Zo+o4N0QqpoWQnLe59E82OoeY
	 SBnNXOrBdaE5MO+3csoUYVUZKSvbEm4THrxRTvgLL9lqSGkvFT/LR53/hPoh6s0Cd5
	 e50UN0lWjypg109AU0g1KPpzav8hadhQ4dnbZG7l69POuCPcie6p71hvo/AVEtRkJ6
	 SRPj4laswAyfQ==
Date: Mon, 30 Jun 2025 12:06:01 -0500
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
Message-ID: <20250630170601.GA1785925@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625111806.4153773-1-maz@kernel.org>

On Wed, Jun 25, 2025 at 12:18:03PM +0100, Marc Zyngier wrote:
> Geert reports that some drivers do rely on the device driver_data
> field containing a pointer to the bridge structure at the point of
> initialising the root port, while this has been recently changed to
> contain some other data for the benefit of the Apple PCIe driver.
> 
> This small series builds on top of Geert previously posted (and
> included as a prefix for reference) fix for the Microchip driver,
> which breaks the Apple driver. This is basically swapping a regression
> for another, which isn't a massive deal at this stage, as the
> follow-up patch fixes things for the Apple driver by adding extra
> tracking.

Is there a bisection hole between patches 1 and 2?

  1: PCI: host-generic: Set driver_data before calling gen_pci_init()
  2: PCI: apple: Add tracking of probed root ports

If so, would it be practical to avoid the hole by reordering those
patches?

> Finally, we can revert a one-liner that glued the whole thing
> together, and that isn't needed anymore.
> 
> All of this is candidate for 6.16, as we have regressed the Microchip
> driver in -rc1, and that fixing it breaks the Apple driver.
> 
> Geert Uytterhoeven (1):
>   PCI: host-generic: Set driver_data before calling gen_pci_init()
> 
> Marc Zyngier (2):
>   PCI: apple: Add tracking of probed root ports
>   Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the root
>     port device"
> 
>  drivers/pci/controller/pci-host-common.c |  4 +-
>  drivers/pci/controller/pcie-apple.c      | 53 ++++++++++++++++++++++--
>  drivers/pci/ecam.c                       |  2 -
>  3 files changed, 51 insertions(+), 8 deletions(-)
> 
> -- 
> 2.39.2
> 

