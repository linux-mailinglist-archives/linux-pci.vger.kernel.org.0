Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377CB16647B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgBTRXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 12:23:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34705 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgBTRXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 12:23:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so3284341wme.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2020 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DP+WeV+eCsLNcM+0j7VvT82QxXGphPuPG6yUJrTyu2U=;
        b=R78Qigu18fQdSDHxyFt+gW5wubpXXtRHLj65ytZxFXLLy3m/Co+0ptUws9rqJFpJTg
         5+KMf7B15USerdDLnaoM9irKTCXrd4+J95sO5zPCYQiTRs1Gx8H+H+x3G2CiCAvuyJu5
         /U/9vm5hgp+xuWqrMkrMZg0yyxMQOx5fXOOBCnAmpu0LyPxTUnE7Woy2rl4jTb9Ms9hr
         BzKxrwajcq3cp0lXRn35Sj3uf/H+DPPJh2HtZNdDHWmp+kfRaedRNapGWL/oRqlgLd9B
         vgTlVOzYwGfyHr6qIwYaKx8aSkCjt4Qex3WgH9VjUUnUTQGJ47QI/fkm1+Agh9LLL/qK
         l0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DP+WeV+eCsLNcM+0j7VvT82QxXGphPuPG6yUJrTyu2U=;
        b=Y6Zi71/UZQhICXzMotJmlQTQOoThiqMvVNp/aYdlK6/mPaIyyLDkPVaJ3pJVqQgTv1
         v0+4yZEiowCdzZq9NM+3rxYg7z7jWTpcxjcE3RUw06A4fh6JE7iwMVlcFWhGgixbXIcA
         jhKs5iaUM3jHLkGl1W7Tu4YsNDXDDBMGXCavKplwX8uS+6bGLSUBGf1WAjzMfa5lKQwF
         B2mR/XbEoD/uyJEIZIHHSLBDJGPwTCT7+acwoDAoylCX6EhLt+nJKiFSjRcjnrTnBzlS
         5c6bPNV7z6ZpphVo13wBkXo3W/otN44bIlCLuV1siHYsXWC9bgcHGHwZUsTiY+P8Jer2
         EVUg==
X-Gm-Message-State: APjAAAXNLsFugJ+SlwPP5iJQjVhV++KIcfxoVe7rj8S3qEMFt28+99Id
        aGMlLWk1G182EgYFgegcP/tG9A==
X-Google-Smtp-Source: APXvYqwoOtD3d5ksvVjxWcwZ0/DxwY7u+cyjGgOanzGPTjCQXXfMerwF375wbaNtGgrElDDsrXncyg==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr5560317wmf.148.1582219430876;
        Thu, 20 Feb 2020 09:23:50 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:98d8:49e6:cdcc:25df])
        by smtp.gmail.com with ESMTPSA id c77sm5261153wmd.12.2020.02.20.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:23:50 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:23:48 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 03/13] PCI: mobiveil: Collect the interrupt related
 operations into a function
Message-ID: <20200220172348.GF19388@big-machine>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-4-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:34PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Collect the interrupt initialization related operations into
> a new function such that it is more readable.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

> ---
> V10:
>  - Refined the subject and change log.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 65 +++++++++++++++++---------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 01df04ea5b48..9449528bb14f 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -454,12 +454,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  		return PTR_ERR(pcie->csr_axi_slave_base);
>  	pcie->pcie_reg_base = res->start;
>  
> -	/* map MSI config resource */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> -	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pcie->apb_csr_base))
> -		return PTR_ERR(pcie->apb_csr_base);
> -
>  	/* read the number of windows requested */
>  	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
>  		pcie->apio_wins = MAX_PIO_WINDOWS;
> @@ -467,12 +461,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
>  		pcie->ppio_wins = MAX_PIO_WINDOWS;
>  
> -	rp->irq = platform_get_irq(pdev, 0);
> -	if (rp->irq <= 0) {
> -		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
> -		return -ENODEV;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -618,9 +606,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
>  	mobiveil_csr_writel(pcie, pab_ctrl, PAB_CTRL);
>  
> -	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> -			    PAB_INTP_AMBA_MISC_ENB);
> -
>  	/*
>  	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
>  	 * PAB_AXI_PIO_CTRL Register
> @@ -670,9 +655,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  	value |= (PCI_CLASS_BRIDGE_PCI << 16);
>  	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
>  
> -	/* setup MSI hardware registers */
> -	mobiveil_pcie_enable_msi(pcie);
> -
>  	return 0;
>  }
>  
> @@ -873,6 +855,46 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> +static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
> +{
> +	struct platform_device *pdev = pcie->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct mobiveil_root_port *rp = &pcie->rp;
> +	struct resource *res;
> +	int ret;
> +
> +	/* map MSI config resource */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> +	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(pcie->apb_csr_base))
> +		return PTR_ERR(pcie->apb_csr_base);
> +
> +	/* setup MSI hardware registers */
> +	mobiveil_pcie_enable_msi(pcie);
> +
> +	rp->irq = platform_get_irq(pdev, 0);
> +	if (rp->irq <= 0) {
> +		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
> +		return -ENODEV;
> +	}
> +
> +	/* initialize the IRQ domains */
> +	ret = mobiveil_pcie_init_irq_domain(pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed creating IRQ Domain\n");
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
> +
> +	/* Enable interrupts */
> +	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> +			    PAB_INTP_AMBA_MISC_ENB);
> +
> +
> +	return 0;
> +}
> +
>  static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
>  	struct mobiveil_root_port *rp = &pcie->rp;
> @@ -906,15 +928,12 @@ static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  		return ret;
>  	}
>  
> -	/* initialize the IRQ domains */
> -	ret = mobiveil_pcie_init_irq_domain(pcie);
> +	ret = mobiveil_pcie_interrupt_init(pcie);
>  	if (ret) {
> -		dev_err(dev, "Failed creating IRQ Domain\n");
> +		dev_err(dev, "Interrupt init failed\n");
>  		return ret;
>  	}
>  
> -	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
> -
>  	/* Initialize bridge */
>  	bridge->dev.parent = dev;
>  	bridge->sysdata = pcie;
> -- 
> 2.17.1
> 
