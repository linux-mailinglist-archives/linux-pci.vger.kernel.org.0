Return-Path: <linux-pci+bounces-32186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2403CB06644
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A0A7A1DC4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B912594BD;
	Tue, 15 Jul 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld1ILtKp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E47261D;
	Tue, 15 Jul 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605360; cv=none; b=onchLps7FLsXoAsmoFp5FdLLbiq0E9TqhNHSbQbaDz101H3O+4XEtg/f4EeLMK6A9DSKTgVyLMxtraIY/WF26kVat/qDA2cPV6G4VCBJHerZsBjtobeOPuSB6Jmio11AF2uzd9dmmHPeTcsDcZa9d0zgSmLRhwtGZ2KlEHFXT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605360; c=relaxed/simple;
	bh=5qC0d2RWg95oBRSvuyT4j6VJbPn4auNM8++47EimCeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jz77MgZQQB8AxteJw7jI8yX/ZrHZvvw5UXnoWUE/0yycR0OEIb6UBxaYvXfFLCAk8PDSdtdj7ZD1IbmWnb8AhxqfTkVQRW7386C1o9mm+aomOcO5NJ4TmWs4l8m7SDMRUVb+HCw2sbsMmQ6WgUsoUBo7Ox8qILF2vnXSzbmhQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld1ILtKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD65C4CEE3;
	Tue, 15 Jul 2025 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605359;
	bh=5qC0d2RWg95oBRSvuyT4j6VJbPn4auNM8++47EimCeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ld1ILtKpyOXaHXoiIBv5crWF/lQDLq8pWxSdm4rdh91Jo1uVJ9ILiJ2jWt8NEp/r6
	 NF2aj4VxtP3h7VGc0WzZ5gI7/kDddBR4sJFfIwnpoSizZIbIjxJRCeHaCg7BFy+2KX
	 Hnv+J+6Hmp9hSR9J6hr67QfYNmHiMEu09wa9lD7XQ0bhPPQCXqskTGdebLt72P88xw
	 0rCri0jRJbul3f+qgpMmh2xsxP+y36ixTCPhsgtbFU6dGWu2C/Gb0G19lYEVg+HjMN
	 DDqkSGPZlc4+QFhbPL2uIuXy9ngc/2jWBZTMyJKw+HttDycgwPOCb5uXOKZvXbwwY7
	 B9fWKwYqqFSqA==
Date: Tue, 15 Jul 2025 13:49:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] pci/controller: Use dev_fwnode()
Message-ID: <20250715184917.GA2479996@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611104348.192092-16-jirislaby@kernel.org>

[+cc Nam]

On Wed, Jun 11, 2025 at 12:43:44PM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 5 ++---
>  drivers/pci/controller/pcie-mediatek-gen3.c          | 3 +--

I think the pcie-mediatek-gen3.c part of this is no longer relevant
after Nam's series [1].  This pcie-mediatek-gen3.c was the only thing
on the pci/controller/mediatek-gen3 branch, so I'm going to drop that
for now.

The pcie-mobiveil-host.c part is still queued on
pci/controller/mobiveil for v6.17.

[1] https://patch.msgid.link/bfbd2e375269071b69e1aa85e629ee4b7c99518f.1750858083.git.namcao@linutronix.de

>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index a600f46ee3c3..cd44ddb698ea 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -464,9 +464,8 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  	struct mobiveil_root_port *rp = &pcie->rp;
>  
>  	/* setup INTx */
> -	rp->intx_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), PCI_NUM_INTX,
> -						   &intx_domain_ops, pcie);
> -
> +	rp->intx_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX, &intx_domain_ops,
> +						   pcie);
>  	if (!rp->intx_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>  		return -ENOMEM;
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index b55f5973414c..5464b4ae5c20 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -756,8 +756,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
>  	/* Setup MSI */
>  	mutex_init(&pcie->lock);
>  
> -	pcie->msi_bottom_domain = irq_domain_create_linear(of_fwnode_handle(node),
> -							   PCIE_MSI_IRQS_NUM,
> +	pcie->msi_bottom_domain = irq_domain_create_linear(dev_fwnode(dev), PCIE_MSI_IRQS_NUM,
>  							   &mtk_msi_bottom_domain_ops, pcie);
>  	if (!pcie->msi_bottom_domain) {
>  		dev_err(dev, "failed to create MSI bottom domain\n");
> -- 
> 2.49.0
> 

