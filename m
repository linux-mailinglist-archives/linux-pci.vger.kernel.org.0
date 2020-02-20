Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4FF16648E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 18:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgBTRZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 12:25:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35017 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgBTRZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 12:25:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so2953348wmb.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2020 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6yo/wEFYTgODGKnbWEUDj+nf8O3PSpjHxesG5sknQ/A=;
        b=KYzgbjNX1K0CzUdOqySZxyADNE1VkZOd+lFmYKJzXNKvDdxhmo4+L5Z+A9zUWAZm6Y
         MXOaTeHGZYDQeZuL9/XRuAHG6o5QpfwBWIuhIi5k5Fh112a1u4Fy+65475Ko8TjrjHTu
         FgBtGghky4L0w6i64qMwjwuWxgYOPPL2kH1i7YYoOQOnEglhbyux1AeBVzsvu79Qb9yH
         cVXsZLya4qevlYaCviYxBRU7Rp93DncQYLGRYjBwiKZSlR8z36kiIve9ZIjVmQdw3uaF
         Q0wZ0sFjblB5LjlFdl3ZxALrBPX/05fn/MH2oRzRc5ZYx3PmJCjJ7Q8CsgXrKtlI95ne
         kXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yo/wEFYTgODGKnbWEUDj+nf8O3PSpjHxesG5sknQ/A=;
        b=VEjSWmrFRtVZHZ8Xgvm+UJE72CsQ0cvKJsvZ2uBFEz6R9pBeSieHyhIysN8AGeTR3C
         yGQTHtip+5Y3PpVyByUcPDiKhFygctW6S4A4LYdKAvYaUTbHtbW5t3ejbk37UVG/RwUa
         7ml0zSr1buyp6bOzkvTMQmVjIEbR4hiRw+pCKiyxgveBbV8KPMbCszntvoal/cRv8u9G
         AY2ZRsuHByTNkF0f3tejyI7nBOGVQHR1bjRnUPd+Y/OnRxfX1rNFSpHOvqZIZmQ5htH0
         5Sl7jlqdIb0L+8V3GMlwcaJ15WT4RoFRciG+T3E32XvuQnCwHKyn/ySdP4Y0dDZuvp7O
         md7A==
X-Gm-Message-State: APjAAAVn23x7VS497u3I4pfHZwxDYebaMNJomcDaCsZyfLVit4lKNWJW
        C1Z0o107uIA0MJ5RTNs0qUgMLA==
X-Google-Smtp-Source: APXvYqxFOHbigA4u8XgOj9oDgXx9MToMJN0LilNw8H81qX/4WzYdOGoBOHPXL6cb43VJZ9gbrJzAmQ==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr5442945wml.44.1582219528295;
        Thu, 20 Feb 2020 09:25:28 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:98d8:49e6:cdcc:25df])
        by smtp.gmail.com with ESMTPSA id r1sm267897wrx.11.2020.02.20.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:25:27 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:25:25 +0000
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
Subject: Re: [PATCHv10 05/13] PCI: mobiveil: Add callback function for
 interrupt initialization
Message-ID: <20200220172525.GG19388@big-machine>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-6-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-6-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:36PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The Mobiveil GPEX internal MSI/INTx controller may not be used
> by other platforms in which the Mobiveil GPEX is integrated.
> This patch is to allow these platforms to implement their
> specific interrupt initialization.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

> ---
> V10:
>  - Introduced a helper function mobiveil_pcie_integrated_interrupt_init().
> 
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 12 +++++++++++-
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h      |  7 +++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index ea90d2f8692e..53ab8412a1de 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -499,7 +499,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> -static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
> +static int mobiveil_pcie_integrated_interrupt_init(struct mobiveil_pcie *pcie)
>  {
>  	struct platform_device *pdev = pcie->pdev;
>  	struct device *dev = &pdev->dev;
> @@ -539,6 +539,16 @@ static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> +static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
> +{
> +	struct mobiveil_root_port *rp = &pcie->rp;
> +
> +	if (rp->ops->interrupt_init)
> +		return rp->ops->interrupt_init(pcie);
> +
> +	return mobiveil_pcie_integrated_interrupt_init(pcie);
> +}
> +
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  {
>  	struct mobiveil_root_port *rp = &pcie->rp;
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 81ffbbd48c08..0e6b5468c026 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -130,10 +130,17 @@ struct mobiveil_msi {			/* MSI information */
>  	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
>  };
>  
> +struct mobiveil_pcie;
> +
> +struct mobiveil_rp_ops {
> +	int (*interrupt_init)(struct mobiveil_pcie *pcie);
> +};
> +
>  struct mobiveil_root_port {
>  	char root_bus_nr;
>  	void __iomem *config_axi_slave_base;	/* endpoint config base */
>  	struct resource *ob_io_res;
> +	struct mobiveil_rp_ops *ops;
>  	int irq;
>  	raw_spinlock_t intx_mask_lock;
>  	struct irq_domain *intx_domain;
> -- 
> 2.17.1
> 
