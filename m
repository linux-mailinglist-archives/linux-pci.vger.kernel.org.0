Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537A3B96CB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGAT6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 15:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhGAT6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 15:58:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8EE760233;
        Thu,  1 Jul 2021 19:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625169376;
        bh=0tk6pCGhB7CEmcEYHhS2WfVG7YC4MgQfOLE4SRmhUxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aaisAVeDZ6J4hH2KcuS49aHwdVW2RqeAP+OFeqDtu6yuYcP07X7rIJuoEm5HWqAYp
         Xs/P/8oTfOy3rHpmgyFvMPnfUEpo6Fr5lkkdI09/0gKOC4rGWcG0qhafPfQM7Q4jN1
         ih+++7j4e9RgSxsUkRp/1Vq08X4Yg/JB4OpFjgXob8wj80jhg/KBV7tAJgpSC0PsQ1
         h4/u54wTJ5IhItcaZmQhFDGqr5lLIa64H9zUHTxqme9BYEPZGo+uvTtJnzgNFOmvzd
         z1rzNuBN/OHxw5alFEjZNqKBcnGnKIU+lNhlm083HBzblaMhACAxMiDlQJMKjHocoE
         K1W6cJ40qbWXQ==
Date:   Thu, 1 Jul 2021 14:56:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: artpec6: Remove surplus break statement after return
Message-ID: <20210701195614.GA84355@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701191640.1493543-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 07:16:40PM +0000, Krzysztof Wilczyński wrote:
> As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
> dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
> code") the function artpec6_add_pcie_ep() has been removed and the call
> to the dw_pcie_ep_init() has been moved into artpec6_pcie_probe().
> 
> This change left a break statement behind that is not needed any more as
> as the function artpec6_pcie_probe() return immediately after making
> a call to dw_pcie_ep_init().
> 
> Thus remove this surplus break statement that became a dead code.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

According to

  $ git grep -n -A1 "return.*;" drivers/pci

there's at least one more instance in
drivers/pci/controller/dwc/pcie-designware-plat.c.

> ---
>  drivers/pci/controller/dwc/pcie-artpec6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 597c282f586c..739871bece75 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -445,7 +445,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  		pci->ep.ops = &pcie_ep_ops;
>  
>  		return dw_pcie_ep_init(&pci->ep);
> -		break;
>  	}

Not related to your patch, but I'm not really a fan of the block here
(needed because of the local "u32 val" declaration) because we end up
with two close braces at the same indent level.  I'd rather declare
the variable at the top with the other local variables and dispense
with the braces.

>  	default:
>  		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
> -- 
> 2.32.0
> 
