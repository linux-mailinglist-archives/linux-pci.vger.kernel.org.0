Return-Path: <linux-pci+bounces-29780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B273DAD96A8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC497B0F36
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D989023D288;
	Fri, 13 Jun 2025 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyRKM3Bw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15220E002;
	Fri, 13 Jun 2025 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847825; cv=none; b=jQqSVvvONtJyML9O/x4gwadEu7PJy1AjJ0OF6u/dQbJn02h9nxrXK8e9b05m/YRxigjlGv0iCXie6F0v3/Vm4ZGW5w4xnKra9kqhOLj8ScvPTpp+CW7eadvciayplHB0mc9JRvJeB0tJETvOHF+bVGWgF3mCO9DzRVmbY9Axe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847825; c=relaxed/simple;
	bh=rlvKqvqdkEFLQEjr/WDkmwzemWu5/XidctqnjEijYfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lkyNat0gCsnAHgg4LOlvlNadslVDQwI1MQCuZ8dC7xlrVnNrNqciEoYK6dLpTmzYd6bfsRjEZlWR2uSRrjPd+SYqz01OSbnjbjpOBraFinvwTafEb8k4Dc9Im7fuS+BlwzOckMhMG7/6uEXBVhivrB5D3hXxVkwkVkiHWWVwTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyRKM3Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB2CC4CEE3;
	Fri, 13 Jun 2025 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749847825;
	bh=rlvKqvqdkEFLQEjr/WDkmwzemWu5/XidctqnjEijYfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jyRKM3BwZ30ApC0n4zkoy8NvY+mslGvuJUBIM/Es0paRZxNmFP/suFT1ugJPmXlhG
	 b7IXKN/jdezHBpAW0uWMyXd0+q7ok+C948R9jpbSdB+vopmAPJHi62pW/TxJ5Cd27R
	 8L3axnVJsjb00FdpZHbTBeZJNDaq0cqVWzK5Jf5uifF4jA/VcX5ZGG6t3YRq6Kla2b
	 fB7HJywUeFu0MeuCsfP1vZLA79euz53xaJZw0kjcZIidN95dyhoixyYEzDxk6s9fJ1
	 mi0iMJevqEe5wyuwcw67pMCEaMIKA67ZMnMCfpr2zgr+WrlJgbPQbGiJzdQy7b7pfd
	 84wTnMR6MXSpg==
Date: Fri, 13 Jun 2025 15:50:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe
 defines
Message-ID: <20250613205023.GA975137@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEyJhoiPP0Ugm1t6@geday>

On Fri, Jun 13, 2025 at 05:26:46PM -0300, Geraldo Nascimento wrote:
> On Fri, Jun 13, 2025 at 03:14:09PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 13, 2025 at 12:05:31PM -0300, Geraldo Nascimento wrote:
> > > -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> > > +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> > >  	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
> > 
> > It looks funny to write PCI_EXP_LNKCTL with bits from PCI_EXP_LNKSTA.
> > I guess this is because rockchip_pcie_write() does 32-bit writes, but
> > PCI_EXP_LNKCTL and PCI_EXP_LNKSTA are adjacent 16-bit registers.
> > 
> > If the hardware supports it, adding rockchip_pcie_readw() and
> > rockchip_pcie_writew() for 16-bit accesses would make this read
> > better.
> > 
> > Hopefully the hardware *does* support this (it's required per spec at
> > least for config accesses, which would be a different path in the
> > hardware).  Doing the 32-bit write of PCI_EXP_LNKCTL above is
> > problematic because writes PCI_EXP_LNKSTA as well, and PCI_EXP_LNKSTA
> > includes some RW1C bits that may be unintentionally cleared.
> 
> Hi Bjorn and thank you for the review,
> 
> while your rationale is correct per PCIe spec, per RK3399 TRM
> those registers are indeed 32 bits in the Rockchip-IP PCIe, so
> I'm forced to work with that, but without fear that other
> registers get messed-up. (See for example Section 17.6.6.1.30
> of RK3399 TRM, Part 2)

I don't have access to any of these TRMs, so I only know what's in the
driver.

When you say "without fear", are you saying there's a way to do that
32-bit write such that the LNKSTA bits are discarded by the hardware?
Or just that the hardware forces us to accept this potential status
register corruption?

Is this something that could be written using the config access path?
I guess probably not, based on this:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-rockchip-host.c?id=v6.15#n141

Bjorn

