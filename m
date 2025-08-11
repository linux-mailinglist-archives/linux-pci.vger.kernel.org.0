Return-Path: <linux-pci+bounces-33795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD4B21860
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F2E1901C09
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119B2E2DFC;
	Mon, 11 Aug 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckap1J4Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A51C1AB4;
	Mon, 11 Aug 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951380; cv=none; b=tGleluOAzHW4hr8FTa6gJTowDhgU+h9ndbQrNFIySTSVDZWAaZ38+RlgM2uhefmaclLk5saOJgvythIJk3eFDGxZL/01pJnLeAVcoUGQi2MMdJeVHWkkOEgOBf3wVChlMbqIFRQX4dXepGmPPjSfi1hCCGrFvBGKGjBYp5IS5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951380; c=relaxed/simple;
	bh=9QOYu+vrn1OXsKmRJdnSIusXEkLswl7SbWENU3CK9xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OKpaFLjCd531AEt8Z4qdCQUn0x7WCoA/sFXYHUO8/plRpNwAysJWpLxrabH7lqTPWDNpRPxcnaGCbddbw3RpzvkhOJmu0D/AEtN+erPdxhjpvW437LyjdPeuWPjR4WsQLe8LYAA6+4CkwokNqY+sfaO/Qv34/MAGpH6DFWbnK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ckap1J4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84261C4CEED;
	Mon, 11 Aug 2025 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754951379;
	bh=9QOYu+vrn1OXsKmRJdnSIusXEkLswl7SbWENU3CK9xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ckap1J4Q+omZepYwIU/J2wV/7RdJ7AFY1PFUKM24xsfyq07oeJdjnApgKS85eKvmd
	 JjUdT01b4YfEUHcZ8nDqeHVSWM+K0ePvHZ13DXxP2cR9mpgQ4zvWsjtdTpQXN1LnY0
	 aAvdhKdV9WinOLg8vJN5QdvWS4on+ZGN64zPeYuCl7pFR2ONpz+svT//ADPnKfVOv2
	 mTT24UKWQuCFJ3vG6hp2wVbaEtVBSvxITYGm6U7q7KMECKOcJM13qIwrhuSu6spOkx
	 TON7xU9Ll0qPZTLH1YVnoelu7hjNOgTpbHZvN8Fx4zXuueuplKmoeuXbMSXBuKw4s4
	 WrBpvqKfVqUmw==
Date: Mon, 11 Aug 2025 17:29:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx: Fix NULL pointer dereference
Message-ID: <20250811222937.GA167215@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811054144.4049448-1-namcao@linutronix.de>

On Mon, Aug 11, 2025 at 07:41:44AM +0200, Nam Cao wrote:
> Commit f29861aa301c5 ("PCI: xilinx: Switch to
> msi_create_parent_irq_domain()") changed xilinx_pcie::msi_domain from child
> devices' interrupt domain into Xilinx AXI bridge's interrupt domain.
> 
> However, xilinx_pcie_intr_handler() wasn't changed and still reads Xilinx
> AXI bridge's interrupt domain from xilinx_pcie::msi_domain->parent. This
> pointer is NULL now.
> 
> Update xilinx_pcie_intr_handler() to read the correct interrupt domain
> pointer.
> 
> Fixes: f29861aa301c5 ("PCI: xilinx: Switch to msi_create_parent_irq_domain()")

Since this appeared in v6.17-rc1, I suppose this should be merged for
v6.17, right?  I provisionally put this on pci/for-linus for now.

What does this look like to a user?  I assume a NULL pointer
dereference in xilinx_pcie_intr_handler()?  Do you have a dmesg
snippet from hitting it?  It would be nice to include a couple lines
of that in the commit log to help users find this fix.

> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/pci/controller/pcie-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index f121836c3cf4..937ea6ae1ac4 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -400,7 +400,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
>  			val = pcie_read(pcie, XILINX_PCIE_REG_RPIFR2) &
>  				XILINX_PCIE_RPIFR2_MSG_DATA;
> -			domain = pcie->msi_domain->parent;
> +			domain = pcie->msi_domain;
>  		} else {
>  			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>  				XILINX_PCIE_RPIFR1_INTR_SHIFT;
> -- 
> 2.39.5
> 

