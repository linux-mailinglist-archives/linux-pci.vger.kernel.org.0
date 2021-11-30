Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44306463C57
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 17:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbhK3Q7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 11:59:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43856 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbhK3Q7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 11:59:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3785CE1A7B;
        Tue, 30 Nov 2021 16:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1878C53FC7;
        Tue, 30 Nov 2021 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638291347;
        bh=YkEoSmWzjqSns21oDlublZ8L9PXWXYHB2QcWBlMNzQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D3J/uf1ROWLew2Ud89oM4CnMx3YUAJbaYk1e2af14OAxWNMsUiXO18jNO2D8FAJPr
         3Ig2IaOMFVFvHUDb5WJ9ALqLYM3dl2hqdZBW+0rWwF5vmOY/rt9rUKm3rD8Pze1wSA
         Luv4T7VRAeu9ouO5mCsffod5Cpr32G6aNWicZ+1zVCV+4DjZHkwBS/IWe0UhAwL8c3
         FaMje8n9qHLad9UyMXY1uzarTRfhvWVT4iMoUWTLWEqW/XrTiUemyCjcg+kmH61bzx
         HBKhwZX3K19/0rd69hi2CW97Pk/7rXTosbINVuGjW4X7P5C7imSS1R9XzmTNTTPNUF
         TDCdis1BZZ+Nw==
Date:   Tue, 30 Nov 2021 10:55:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Simplify code and fix a memory leak
Message-ID: <20211130165545.GA2743072@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 07, 2021 at 11:04:43AM +0100, Christophe JAILLET wrote:
> Allocate space for 'bitmap' in 'struct nwl_msi' at build time instead of
> dynamically allocating the memory at runtime.

Definitely a good change.  To be pedantic, I don't think this converts
the alloc to *build* time.  It converts it to probe-time, when
nwl_pcie_probe() calls devm_pci_alloc_host_bridge().

> This simplifies code (especially error handling paths) and avoid some
> open-coded arithmetic in allocator arguments
> 
> This also fixes a potential memory leak. The bitmap was never freed. It is
> now part of a managed resource.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 30 ++++++------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index a72b4f9a2b00..40d070e54ad2 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -146,7 +146,7 @@
>  
>  struct nwl_msi {			/* MSI information */
>  	struct irq_domain *msi_domain;
> -	unsigned long *bitmap;
> +	DECLARE_BITMAP(bitmap, INT_PCI_MSI_NR);
>  	struct irq_domain *dev_domain;
>  	struct mutex lock;		/* protect bitmap variable */
>  	int irq_msi0;
> @@ -335,12 +335,10 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
>  
>  static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
>  {
> -	struct nwl_msi *msi;
> +	struct nwl_msi *msi = &pcie->msi;
>  	unsigned long status;
>  	u32 bit;
>  
> -	msi = &pcie->msi;
> -
>  	while ((status = nwl_bridge_readl(pcie, status_reg)) != 0) {
>  		for_each_set_bit(bit, &status, 32) {
>  			nwl_bridge_writel(pcie, 1 << bit, status_reg);
> @@ -560,30 +558,21 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	struct nwl_msi *msi = &pcie->msi;
>  	unsigned long base;
>  	int ret;
> -	int size = BITS_TO_LONGS(INT_PCI_MSI_NR) * sizeof(long);
>  
>  	mutex_init(&msi->lock);
>  
> -	msi->bitmap = kzalloc(size, GFP_KERNEL);
> -	if (!msi->bitmap)
> -		return -ENOMEM;
> -
>  	/* Get msi_1 IRQ number */
>  	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
> -	if (msi->irq_msi1 < 0) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
> +	if (msi->irq_msi1 < 0)
> +		return -EINVAL;
>  
>  	irq_set_chained_handler_and_data(msi->irq_msi1,
>  					 nwl_pcie_msi_handler_high, pcie);
>  
>  	/* Get msi_0 IRQ number */
>  	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
> -	if (msi->irq_msi0 < 0) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
> +	if (msi->irq_msi0 < 0)
> +		return -EINVAL;
>  
>  	irq_set_chained_handler_and_data(msi->irq_msi0,
>  					 nwl_pcie_msi_handler_low, pcie);
> @@ -592,8 +581,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
>  	if (!ret) {
>  		dev_err(dev, "MSI not present\n");
> -		ret = -EIO;
> -		goto err;
> +		return -EIO;
>  	}
>  
>  	/* Enable MSII */
> @@ -632,10 +620,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>  	nwl_bridge_writel(pcie, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
>  
>  	return 0;
> -err:
> -	kfree(msi->bitmap);
> -	msi->bitmap = NULL;
> -	return ret;
>  }
>  
>  static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> -- 
> 2.30.2
> 
