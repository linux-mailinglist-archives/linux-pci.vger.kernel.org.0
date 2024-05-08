Return-Path: <linux-pci+bounces-7210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BA8BF44A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 03:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63DA283A4C
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 01:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C842564;
	Wed,  8 May 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZEWofxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125F947A;
	Wed,  8 May 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133560; cv=none; b=DMdW9Oe7MllOqeIyn/pIvxGhtBKJ+1Bnp6f+Nn7pZkHWQ3CmBDl+3kLFzcPjqiUlTLLrQFCUMJb2KIcs1Ypr55LqhUKyl5kspsthGSed1tTVMKEYXRIPMLRVjNPeMdxJrgkizvtYEbSi3yCAGDoupoikjDAyhmbutJ/Wm6YoVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133560; c=relaxed/simple;
	bh=OT5JakQt19xF8U1yLXWAVT404ZDx+aEIBvSlyMks/00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aJOMjSb2oRjj0Y8ylqOZab5KiZlkTlSiH26jBItDpkJ1Lt8R7zKwALVKY9+B6rvWG3ItNNmCnCtzNioY/KzQTJpdRwRnNhBqi98vRArXdjSB+iUZBxIDuZJ/6pnuhsOhBBuxSo6WDu/+WsGHllPeiwZ2EJz+n7hXVMtvBmm4wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZEWofxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D316C2BBFC;
	Wed,  8 May 2024 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715133559;
	bh=OT5JakQt19xF8U1yLXWAVT404ZDx+aEIBvSlyMks/00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BZEWofxm4dginQL+bIA1eqQEoyel0G+G/WB9CeXJex8G5YJVB+pMLPACIAUo/SlNL
	 aJdcwlaaX6GYYfbEnNUrTXYE2kVEKhSbfJMpMJJX9HRQdNhSuVw25mTE4ib2vFPmIy
	 y7NPpBh9H9bsPEnpR/tW82mSJbc2Vfyw5aGIEspgSBKkOIG9N6NuCsONhUSRRDxnlk
	 +mT+aHE+mWgSvcUlt05qqCb5Wrql5gVyujSmVdgodBbdwT/3D7CZE8egOviz+8Fbq6
	 vyRVb1REvqoXHwq1ukgaq2Jm7Gg6eeOFVUrgdCt9gkEspbDsx+GAZf2yLDaNuF8FZn
	 Nsr5LZY56dJhw==
Date: Tue, 7 May 2024 20:59:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: [PATCH v2 2/7] PCI: xilinx-nwl: Fix off-by-one
Message-ID: <20240508015917.GA1746057@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506161510.2841755-3-sean.anderson@linux.dev>

Maybe the subject could include something about why this is important,
e.g., it's IRQ-related, we mask/unmask the wrong thing, etc?

On Mon, May 06, 2024 at 12:15:05PM -0400, Sean Anderson wrote:
> IRQs start at 0, so we don't need to subtract 1.

What does "IRQ" refer to here?  Something to do with INTx, I guess,
but apparently not PCI_INTERRUPT_PIN, since 0 in that register means
the device doesn't use INTx, and 1=INTA, 2=INTB, etc.

I assume this fixes a bug, e.g., we mask/unmask the wrong INTx?  What
does this look like for a user?  Unexpected IRQs?

9a181e1093af is from seven years ago.  Should we be surprised that we
haven't tripped over this before?

> Fixes: 9a181e1093af ("PCI: xilinx-nwl: Modify IRQ chip for legacy interrupts")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> (no changes since v1)
> 
>  drivers/pci/controller/pcie-xilinx-nwl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 0408f4d612b5..437927e3bcca 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -371,7 +371,7 @@ static void nwl_mask_intx_irq(struct irq_data *data)
>  	u32 mask;
>  	u32 val;
>  
> -	mask = 1 << (data->hwirq - 1);
> +	mask = 1 << data->hwirq;
>  	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
>  	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
>  	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
> @@ -385,7 +385,7 @@ static void nwl_unmask_intx_irq(struct irq_data *data)
>  	u32 mask;
>  	u32 val;
>  
> -	mask = 1 << (data->hwirq - 1);
> +	mask = 1 << data->hwirq;
>  	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
>  	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
>  	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

