Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333C72AE189
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 22:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJVVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 16:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgKJVVg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:36 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FD5206D8;
        Tue, 10 Nov 2020 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605043295;
        bh=BBnBem4yEoVhVWgQvcHEK3n6sHNolxhO8KtFVJLE8Fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ScIjIdGHHOprnexeu9XoINeOTRL30NPZRZ4mCAT1opkm9zPq8r2/AamqRteC7MQAF
         rtIFi8mUKx2ZFQubMgKbrU1idgv9vwK5y3YX01EEFtriAWCMtmE4TQp+6KneJjkMzU
         UTukjjGtAGjm1TazJm1TL4pETEBYg1vATrozPfgI=
Date:   Tue, 10 Nov 2020 15:21:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>
Subject: Re: [PATCH] PCI: altera-msi: Remove irq handler and data in one go
Message-ID: <20201110212134.GA692694@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108191140.23227-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Nicolas, Jingoo, Gustavo, Toan]

On Sun, Nov 08, 2020 at 08:11:40PM +0100, Martin Kaiser wrote:
> Replace the two separate calls for removing the irq handler and data with a
> single irq_set_chained_handler_and_data() call.

This is similar to these:

  36f024ed8fc9 ("PCI/MSI: pci-xgene-msi: Consolidate chained IRQ handler install/remove")
  5168a73ce32d ("PCI/keystone: Consolidate chained IRQ handler install/remove")
  2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ handler")

and it seems potentially important that this removes the IRQ handler
and data *atomically*, i.e., both are done while holding
irq_get_desc_buslock().  

So I would use this:

  PCI: altera-msi: Fix race in installing chained IRQ handler

  Fix a race where a pending interrupt could be received and the handler
  called before the handler's data has been setup by converting to
  irq_set_chained_handler_and_data().

  See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
  IRQ handler").

to make it clear that this is actually a bug fix, not just a cleanup.

Looks like this should also be done in dw_pcie_free_msi() and
xgene_msi_hwirq_alloc() at the same time?

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/pci/controller/pcie-altera-msi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index e1636f7714ca..42691dd8ebef 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -204,8 +204,7 @@ static int altera_msi_remove(struct platform_device *pdev)
>  	struct altera_msi *msi = platform_get_drvdata(pdev);
>  
>  	msi_writel(msi, 0, MSI_INTMASK);
> -	irq_set_chained_handler(msi->irq, NULL);
> -	irq_set_handler_data(msi->irq, NULL);
> +	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
>  
>  	altera_free_domains(msi);
>  
> -- 
> 2.20.1
> 
