Return-Path: <linux-pci+bounces-41472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A4C66B8C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 01:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E360E4E84C5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398623016F9;
	Tue, 18 Nov 2025 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SISIeqMG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F55303A19;
	Tue, 18 Nov 2025 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427060; cv=none; b=ObOFO5DlWiIGo5+1df3hUaFXNN9qM9A5u1eGFabqvs8mz6VjnMqqVSeRrxjcXdV/3tnmp2s7qFzXeknw6zMDqNf7VrLqzcbrdJx/opmpKmqtpF3NsK5Obw6H8zGlK1VbpHx1arxEjsfqYkVjl/sZnMMl8BoGZjTtZvaaHu9b+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427060; c=relaxed/simple;
	bh=hkavOkX+AJ0Q/nljcqEN9XW/rOLVZVY4+XD1wjrUAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gpjF1EJjvqkV2Otl+5vQyBn7zqTWTkSQNkxtyBMw4JJtNInp6JpvtIrR3Mx+wYBwNfu0CcigSsdxPwNDijq4f2N54x8lLZ+Ys1bANJt66ZvyEKelbpxQlQGNlTC+ZjY5puuStN2Fy8Yh7ZONMhM30wlJi5Z8Se9tKHySmHKntDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SISIeqMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F2EC4AF09;
	Tue, 18 Nov 2025 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763427059;
	bh=hkavOkX+AJ0Q/nljcqEN9XW/rOLVZVY4+XD1wjrUAHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SISIeqMGdKRt1D7TYgO/eXm8MsAcG522nQilC9TlS40eSzuNY3D/o7tdfLH6/MCS5
	 VVGtVN0PSaGwixakZ4/33MD6P7kfLlnW1Q820zZVhcZ4gxulaxBsHPxdsRg/PZyQ1T
	 P9v4bTVRmprL4ngKYy2ezYvvs3g3jI5/eLHOrK1uSRUg3MOgxuTpwKMgGagwkY7w6A
	 8oeAoMTAnZOWMheBVX2pyw6c0OfHjbdA4PJlQPejA9c7VegSqnc6biQzefjQdYJFYD
	 pJ+kRJksm1RPhiuDG903U7rDOB0BCcpBKxIjdji6MPBz6gQOzp9doog8N6BbH/CV4i
	 gsUL4OzvwcWEQ==
Date: Mon, 17 Nov 2025 18:50:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 2/5] PCI: rockchip: Fix Device Control register offset
 for Max payload size
Message-ID: <20251118005056.GA2541796@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117181023.482138-3-linux.amoon@gmail.com>

On Mon, Nov 17, 2025 at 11:40:10PM +0530, Anand Moon wrote:
> As per 17.6.6.1.29 PCI Express Device Capabilities Register
> (PCIE_RC_CONFIG_DC) reside at offset 0xc8 within the Root Complex (RC)
> configuration space, not at the offset of the PCI Express Capability
> List (0xc0). Following changes corrects the register offset to use
> PCIE_RC_CONFIG_DC (0xc8) to configure Max Payload Size.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
>  drivers/pci/controller/pcie-rockchip.h      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f0de5b2590c4..d51780f4a254 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -382,10 +382,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
>  	}
>  
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
>  	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
>  	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
>  
>  	return 0;
>  err_power_off_phy:
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 5d8a3ae38599..c0ec6c32ea16 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -157,6 +157,7 @@
>  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
>  #define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
> +#define PCIE_RC_CONFIG_DC		(PCIE_RC_CONFIG_BASE + 0xc8)

Per the RK3399 TRM:

  DEVCAP              0xc4
  DEVCTL and DEVSTA   0xc8
  LNKCAP              0xcc
  LNKCTL and LNKSTA   0xd0
  SLTCAP              0xd4
  SLTCTL and SLTSTA   0xd8

That all makes good sense and matches the relative offsets in the PCIe
Capability.

I have no idea how we got from that to the mind-bendingly obtuse
#defines here:

  PCIE_RC_CONFIG_CR == PCIE_RC_CONFIG_BASE + 0xc0
                    == 0xa00000 + 0xc0
                    == 0xa000c0

  PCIE_RC_CONFIG_DC == PCIE_RC_CONFIG_BASE + 0xc8
                    == 0xa00000 + 0xc8
                    == 0xa000c8

  PCIE_RC_CONFIG_LC == PCIE_RC_CONFIG_BASE + 0xd0
                    == 0xa00000 + 0xd0
                    == 0xa000d0

  PCIE_RC_CONFIG_SR == PCIE_RC_CONFIG_BASE + 0xd4
                    == 0xa00000 + 0xd4
                    == 0xa000d4

And they're used like this:

  PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP == 0xa000c0 + 0x0c
                                     == 0xa000cc

  PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL == 0xa000c0 + 0x10
                                     == 0xa000d0

  PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL == 0xa000c8 + 0x08
                                     == 0xa000d0     <-- same as LNKCTL? 

  PCIE_RC_CONFIG_SR + PCI_EXP_DEVCAP == 0xa000d4 + 0x04
                                     == 0xa000d8     <--

  PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL == 0xa000d0 + 0x10
                                     == 0xa000e0     <-- but LNKCTL was at 0xa000d0 above?

And the mappings don't make any sense to me:

  CR -> LNKCAP & LNKCTL
  DC -> DEVCTL (ok, this one makes a *little* sense)
  SR -> DEVCAP
  LC -> LNKCTL (would make some sense except that we have CR above)

This is all just really hard to read.  It looks like if we defined a
single base address for the PCIe Capability, we shouldn't need all the
_CR, _DC, _LC, _SR, etc #defines.  E.g., we could have

  #define ROCKCHIP_RP_PCIE_CAP ...

  rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCAP)
  rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCTL)
  ...

with maybe some minor adjustment for 16-bit registers since Rockchip
only seems to support 32-bit accesses (?)

None of these registers are *Root Complex* registers; they're all part
of a PCIe Capability, which applies to a Root *Port*.

>  #define PCIE_RC_CONFIG_LC		(PCIE_RC_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
> -- 
> 2.50.1
> 

