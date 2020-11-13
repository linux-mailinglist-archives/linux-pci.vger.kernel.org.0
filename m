Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF62B2112
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKMQys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 11:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgKMQyr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 11:54:47 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41E4217A0;
        Fri, 13 Nov 2020 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605286487;
        bh=NCAyniXfdRxfHRzI4qNes22DvttbWADXUgli0Y2BOQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2XUS0ErlviKqJet0jE8A21ad/Fwp8G6oIzxaNwgh6lkrhR2SNV4ubKJt/1Sz+8onw
         p/CnUKVV9rf2fN7vBmHo08sAuH5OySCnCoGQfzTwCmeRbtTyFNjP7WkXHLaCy9XGy4
         nTUdh1GAvSVjXAKVpDVYir/HmJqCen28+4fBMZTs=
Date:   Fri, 13 Nov 2020 10:54:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: altera-msi: remove chained IRQ handler and
 data in one go
Message-ID: <20201113165445.GA1117268@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112221010.9473-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please capitalize your subject lines consistently.  [3/3] is fine, but
you didn't capitalize [1/3] and [2/3] to match.

The fact that this is a *chained* IRQ isn't really relevant to the
patch, so this would be more succinct:

  PCI: altera-msi: Remove IRQ handler and data in one go

Lorenzo can likely touch these up when he applies these so you don't
have to repost just for this.

On Thu, Nov 12, 2020 at 11:10:08PM +0100, Martin Kaiser wrote:
> Call irq_set_chained_handler_and_data() to clear the chained handler
> and the handler's data under irq_desc->lock.
> 
> See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
> IRQ handler").
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v3:
>  - rewrite the commit message again. this is no race condition if we
>    remove the interrupt handler. sorry for the noise.
> v2:
>  - rewrite the commit message to clarify that this is a bugfix
> 
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
