Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2932EC3AE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAFTIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 14:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhAFTIE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 14:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69DBD23124;
        Wed,  6 Jan 2021 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960043;
        bh=BsN8s/16kWkFD8YBx8OwhZSebR3UbS4QlfACeBPH2H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jZKdCjGyE4RMGVRtWRkpRmaEmTMXq81y934ves6MgGNnu4uk77/fL/zW0Z/x56PRW
         XUWsLlkNRlH/l6nQV1tw3GjUtOcKHrDR9wSjp/P9gWPXlxGidwbHmAWAVZs75mUY7B
         T9gOD1kM11Bar3geBAEgFphUQErkN7e1Z+aatl80CzTRZU2EMMYFVtgSvXmXMt9BG/
         39OskIyG4givxvX54ukUJJ2AVJ4v1MTU2+rudeqQRd2fi1vY33au7gOg5EFlm67NhJ
         s2PTy59k1riQjeedINJSB2bKGEz7Ka/LEETU93R5cCs/WKOSNANWTGkNf4sjR7Cmfd
         140l04DjOordw==
Date:   Wed, 6 Jan 2021 13:07:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        robh@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pci/controller/dwc: convert comma to semicolon
Message-ID: <20210106190722.GA1327553@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216131944.14990-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 16, 2020 at 09:19:44PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.

Looks like a good fix, but read this about the changelog title:

https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 84206f265e54..917ba8d254fc 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -178,7 +178,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
> -	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
> +	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
>  
>  	pcie->pci = pci;
>  	pcie->ls_epc = ls_epc;
> -- 
> 2.22.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
