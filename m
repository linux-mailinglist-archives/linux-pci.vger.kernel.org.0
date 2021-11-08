Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF74476F8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 01:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhKHAeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 19:34:36 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51080 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKHAeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 19:34:36 -0500
Received: by mail-wm1-f53.google.com with SMTP id 133so11737079wme.0;
        Sun, 07 Nov 2021 16:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0xr2aH1oyqMnCG5sZbRwnK/ZucosCRevU1YYGZplaUA=;
        b=ax1kkJQ50jkcnRXjP+i+DY2o/J9aL77QupPV/AOO6IVlvPzG2F4/D0CEsq1pb/6gbQ
         cDSR2aLjHdB62o+Hv/eWLIhESMNoD5zD4Gu1kS7nOpT9hYguoWknNE2e1Be1j492KX0a
         AFr2//6JWfa8NG7AUrN4yzLvdn4VvvxrEczgbz6zD8Vjai/v3AabKjbX/h76G6j5eeE7
         49s0X1AIng54doYWceSy4iuIor1GoxdKyAwG/WD2AOwj0siqc3UP89YLEXxL1VXU02nM
         a38Ef14dFCZZJV+PtexREVStdah+X56AhgNOPn4Crrup+dTUAHYbRk/rTqpj1npx7CJk
         QlUw==
X-Gm-Message-State: AOAM533dBtSipW0UYQ7ZXNcrf9o7QjPR4plKtf3tG751w26ivIPMnK1E
        RMaRyzhVHgZNZ2pbEJy0I+E=
X-Google-Smtp-Source: ABdhPJwWlZ8ZKf5IC3xlezyz2ic+m3IUOWrRwx5OhBtfu5ldkWaJQvnO75DYyvSRmlfLz10n/DBBOg==
X-Received: by 2002:a05:600c:4f02:: with SMTP id l2mr30578157wmq.26.1636331511978;
        Sun, 07 Nov 2021 16:31:51 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j8sm14361672wrh.16.2021.11.07.16.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:31:51 -0800 (PST)
Date:   Mon, 8 Nov 2021 01:31:50 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Simplify code and fix a memory leak
Message-ID: <YYhv9vZCw5r+PKzj@rocinante>
References: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe,

> Allocate space for 'bitmap' in 'struct nwl_msi' at build time instead of
> dynamically allocating the memory at runtime.
> 
> This simplifies code (especially error handling paths) and avoid some
> open-coded arithmetic in allocator arguments
> 
> This also fixes a potential memory leak. The bitmap was never freed. It is
> now part of a managed resource.

Just to confirm - you mean potentially leaking when the driver would be
unloaded?  Not the error handling path, correct?

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

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
