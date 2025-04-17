Return-Path: <linux-pci+bounces-26058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2965A91457
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D11416FAD4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49792153CC;
	Thu, 17 Apr 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0vzRiic"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C321518B;
	Thu, 17 Apr 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872844; cv=none; b=Q1VBdTdeQdlD1feTWrGQGLAfMG8TNCuBiNwzrT6fkq4qcSaAYFhH/wVXhOJ0I/CgMy1AlFMaR3G4paPiq7+xJlI8Wlo3uh6hfoznJQXLyADNL4RaEBSXVW64/kGmE1xeZVGodTSQ8I5v+R272sjctZVzAAQka7gUzTt31RjjEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872844; c=relaxed/simple;
	bh=zGx86VkJkAakclDafCUd0oRxkLBcph7gdNZjHRMEECk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUs86CgNhui84MnpbhSPfPNOzf74YB4dDn0gkmMZnRcApLPfqDfj/yVJgzpAp3uowaj76VZC9oNBFlq1D0ooNoKwE+85baMfnSNLsC0Ps8YcgUNOIou2qYpSHaPsuwQGcYornB7UT3VhZrt1AR48NWwuFgWrXkLtTqZyJn+RSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0vzRiic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F3EC4CEE4;
	Thu, 17 Apr 2025 06:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744872844;
	bh=zGx86VkJkAakclDafCUd0oRxkLBcph7gdNZjHRMEECk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0vzRiicC8CgwUdGtXlwnPeRM3Fy1/8/xHDj4ghRoMEXHFXlaYkcTczfT8Y2qVpOc
	 2Y+1fAHYD4qrAMc2Fy2tQxPS0pRupS41t4ZneW8LtuLQLCk8C3zd4rsbcUSCtYkoKG
	 bc7BUp5qxGJVXz4X/kgqEyl+Vep9c5AP0Csv+DEHTI68ICAIZ8dtqL717ufU2sQNh2
	 VkkUkSuTgqDX7OcylvDtkSykf+MrTPXHdA5r2bz8YrmXYQItiJfZ5D+ihEJWh3GIOc
	 uh1dZmxudlOO0bdzxP22b2IOOEgmjq74k30KBrh46I5PuJKzprqLRNA2V/mO7HHmAD
	 JlrieEajUPb7g==
Date: Thu, 17 Apr 2025 08:53:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <aAClhmwO3caYMonN@ryzen>
References: <20250416204051.GA78956@bhelgaas>
 <bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com>
 <aACZP48pWk5Y62dK@ryzen>
 <a8cc995e-c6d5-4079-b6d9-765f76a7ec7a@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8cc995e-c6d5-4079-b6d9-765f76a7ec7a@163.com>

On Thu, Apr 17, 2025 at 02:47:23PM +0800, Hans Zhang wrote:
> On 2025/4/17 14:01, Niklas Cassel wrote:
> > On Thu, Apr 17, 2025 at 10:19:10AM +0800, Hans Zhang wrote:
> > > On 2025/4/17 04:40, Bjorn Helgaas wrote:
> > > > On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
> > > > > The RK3588's PCIe controller defaults to a 128-byte max payload size,
> > > > > but its hardware capability actually supports 256 bytes. This results
> > > > > in suboptimal performance with devices that support larger payloads.
> > > > > 
> > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 18 ++++++++++++++++++
> > > > >    1 file changed, 18 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > index c624b7ebd118..5bbb536a2576 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > > > @@ -477,6 +477,22 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > > > >    	return IRQ_HANDLED;
> > > > >    }
> > > > > +static void rockchip_pcie_set_max_payload(struct rockchip_pcie *rockchip)
> > > > > +{
> > > > > +	struct dw_pcie *pci = &rockchip->pci;
> > > > > +	u32 dev_cap, dev_ctrl;
> > > > > +	u16 offset;
> > > > > +
> > > > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > +	dev_cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCAP);
> > > > > +	dev_cap &= PCI_EXP_DEVCAP_PAYLOAD;
> > > > > +
> > > > > +	dev_ctrl = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > > > > +	dev_ctrl &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > > > +	dev_ctrl |= dev_cap << 5;
> > > > > +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, dev_ctrl);
> > > > > +}
> > > > 
> > > > I can't really complain too much about this since meson does basically
> > > > the same thing, but there are some things I don't like about this:
> > > > 
> > > >     - I don't think it's safe to set MPS higher in all cases.  If we set
> > > >       the Root Port MPS=256, and an Endpoint only supports MPS=128, the
> > > >       Endpoint may do a 256-byte DMA read (assuming its MRRS>=256).  In
> > > >       that case the RP may respond with a 256-byte payload the Endpoint
> > > >       can't handle.  The generic code in pci_configure_mps() might be
> > > >       smart enough to avoid that situation, but I'm not confident about
> > > >       it.  Maybe I could be convinced.
> > > > 
> > > 
> > > Dear Bjorn,
> > > 
> > > Thank you very much for your reply. If we set the Root Port MPS=256, and an
> > > Endpoint only supports MPS=128. Finally, Root Port is also set to MPS=128 in
> > > pci_configure_mps.
> > 
> > In you example below, the Endpoint has:
> >   DevCap: MaxPayload 512 bytes
> > 
> > So at least your example can't be used to prove this specific point.
> > But perhaps you just wanted to show that your Max Payload Size increase
> > actually works?
> > 
> 
> Dear Niklas,
> 
> Do you have an Endpoint with MPS=128? If so, you can also help verify the
> logic of the pci_configure_mps function. I don't have an Endpoint with
> MPS=128 here.

I imagine that it would be trivial to test with a PCIe controller running
in endpoint mode with the PCI endpoint subsystem in the kernel.
(As you should be able to set CAP.MPS before starting link training.)


> The processing logic of the pci_configure_mps function has been verified on
> our own SOC platform. Please refer to the following log.
> Our Root Port will set MPS=512.

(snip)

Ok, since it works to downgrade 512B to 256B, I would imagine that it also
would downgrade to 128B properly.


Kind regards,
Niklas

