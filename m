Return-Path: <linux-pci+bounces-3460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF88550A5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403131C291FB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD186644;
	Wed, 14 Feb 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb1EDdKY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75368662D;
	Wed, 14 Feb 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932712; cv=none; b=E8mhtW0qzFrbbOEmgCeKapPM7XMTPr3T8mUUQAFxWL2VqSKfKjwYV6SGGKP9stuUkNo7aHJ15e+sZ6IuBGnOjw5M4PNWXZYC9HvIRMrpbLnTIkB2cJ6j7CkBid9OjizbkqJuYjzY4yt9YS45A2sMtGKJLJxO5u59v3QjYbCz3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932712; c=relaxed/simple;
	bh=GI7e3PZ2Daqbe7I8Nx27KGVbWG9+U3qVqFXfkb45idk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OSlE5yXoMqkSQQlXB+4TQmFA7QRZB+wg97sGlOqUQR6xCjvb6BgVoxqVFBvF6Mbl5YQ36b2klMDbWyXOvmaDN71XunYHq/129xQlLU2b+xaOjyQSYr6t3UzvfYfSOliLQOG7C0RBKWN8Gew1RHfsJf79lYdlWb4uUHNNiRCaBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb1EDdKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BB0C433F1;
	Wed, 14 Feb 2024 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707932712;
	bh=GI7e3PZ2Daqbe7I8Nx27KGVbWG9+U3qVqFXfkb45idk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bb1EDdKYsmmNC5zcJojHDaQRsKoZMSqSQ6Qy4CB4/3H3MsY+8WNhYHCp8NzMKK5kv
	 jhT2BshH+V/HrHkwmMBx3NULfhreDicvIPHo4FNMfghlouqh9GwxIulx1ssD75X57s
	 UMVE3kY5C4i/CbGLTkiVw+JLRzazVQCdxnvMXntPh/0J83wP/vpTovUgpEYiPILDt+
	 bctWfsEGiQICRdI8MvA5zzpLQNv8Y7svAhleK1lXAUJ/i0LODcY6OJ8zDGacrh3634
	 YFzKmh1EhrOHStVTG5ZfDqKlkT74Ga2f+TWB+piGo8riKAfjMMZNQivNpktEmdkXyc
	 1dEUnGwQQ9Qzg==
Date: Wed, 14 Feb 2024 11:45:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Add vendor-specific registers' setting
 for MSI-X
Message-ID: <20240214174509.GA1259458@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214052122.1966506-1-yoshihiro.shimoda.uh@renesas.com>

On Wed, Feb 14, 2024 at 02:21:22PM +0900, Yoshihiro Shimoda wrote:
> This controller with GICv3 ITS can handle MSI-X, but it needs
> to set vendor-specific registers by using the MSI address value.
> To get the address, add .post_init() for it.

You mention both MSI-X and MSI.  Do you mean MSI-X in both cases?

Wrap to fill 75 columns.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 27 +++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index e9166619b1f9..2ed62ffbde38 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -42,6 +42,13 @@
>  #define APP_HOLD_PHY_RST	BIT(16)
>  #define APP_LTSSM_ENABLE	BIT(0)
>  
> +/* INTC address */
> +#define AXIINTCADDR		0x0a00
> +
> +/* INTC control & mask */
> +#define AXIINTCCONT		0x0a04
> +#define AXIINTCCONT_VAL		(BIT(31) | GENMASK(11, 2))
> +
>  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
>  #define RCAR_MAX_LINK_SPEED		4
>  
> @@ -297,6 +304,25 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void rcar_gen4_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	struct irq_data *data;
> +	struct pci_dev *dev;
> +	struct msi_msg msg;
> +
> +	if (pp->has_msi_ctrl)
> +		return;
> +
> +	list_for_each_entry(dev, &pp->bridge->bus->devices, bus_list) {
> +		data = irq_get_irq_data(dev->irq);
> +		__pci_read_msi_msg(irq_data_get_msi_desc(data), &msg);
> +		writel(msg.address_lo, rcar->base + AXIINTCADDR);
> +		writel(AXIINTCCONT_VAL, rcar->base + AXIINTCCONT);
> +	}

I first thought this looked suspect because hot-add might add devices
to the bus->devices list, but I guess this register programming is
only required for devices on the root bus, and I suppose hot-add is
not possible on the root bus.  Right?

But I'm still a little confused about what this is doing.  dev->irq is
initially set by pci_read_irq() and pci_assign_irq() based on
PCI_INTERRUPT_PIN, which is for INTx signaling.

But dev->irq can be updated later by msi_capability_init() when a
driver enables MSI, and this code runs before drivers claim these
devices.

I'm just generally confused.

> +}
> +
>  static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> @@ -308,6 +334,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
>  	.init = rcar_gen4_pcie_host_init,
> +	.post_init = rcar_gen4_pcie_host_post_init,
>  	.deinit = rcar_gen4_pcie_host_deinit,
>  };
>  
> -- 
> 2.25.1
> 

