Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB93A3AD59C
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 01:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhFRXGp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 19:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhFRXGk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 19:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F367361002;
        Fri, 18 Jun 2021 23:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624057470;
        bh=rSCg9VyEvfjgmo4LrigQBWCtskNEVihqGqojgsJ4k+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=o6jJniQ9V6/Fw6rYl/kdPvDqhyfGc+CsPFhTLJt3bwz1ZzJHtzMYhjO481//NJW9J
         1BJUFfyLAA6aDFlKK3Fe8HjWc75MJh8LiOq+30AZR1jDjpojuHRWGKI8aQwCiWyDlm
         qCXMQlDNyoOCaT4+P558D81JSBr+uVBB3kjgb3rM/JnjvK6CFX3FcvOYoKuE8slpWS
         PVMFe7tgGDLvvnoHuY+aEe33HDbkXEFEn4SbIJdee8Ter9me6xFBPe1VDSBX5q0scn
         3n/yVa/mIXGEHtjqQ5aHUcr7MWXPkXXERkNFVzCLXiK8wgV2ezU6jRxp3E7fvFCXxs
         jMpBGv6PbtbkQ==
Date:   Fri, 18 Jun 2021 18:04:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix shiftTooManyBitsSigned warning for
 Tegra194
Message-ID: <20210618230428.GA3231877@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618160219.303092-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 05:02:19PM +0100, Jon Hunter wrote:
> The cppcheck tool issues the following warning for the Tegra194 PCIe
> driver ...
> 
>  $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
>  Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability:
> 	Shifting signed 32-bit value by 31 bits is
> 	implementation-defined behaviour. See condition at line 1826.
> 	[shiftTooManyBitsSigned]
> 
>   appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>                       ^
> The above warning occurs because the '1' is treated as a signed type
> and so fix this by using the 'BIT' macro to ensure that this is defined
> as a unsigned type.

The subject and commit log should describe the problem we're fixing.
The *warning* is not the problem; the problem is the undefined
behavior.

I'll fix this up, no need to repost for this.

> Fixes: c57247f940e8 PCI: tegra: Add support for PCIe endpoint mode in Tegra194
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 8fc08336f76e..3c1feeab104f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  	if (unlikely(irq > 31))
>  		return -EINVAL;
>  
> -	appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> +	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
