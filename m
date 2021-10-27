Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A113F43CBBE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbhJ0OPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 10:15:18 -0400
Received: from foss.arm.com ([217.140.110.172]:43800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242439AbhJ0OPS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 10:15:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A662ED1;
        Wed, 27 Oct 2021 07:12:52 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9E1F3F73D;
        Wed, 27 Oct 2021 07:12:51 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:12:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211027141246.GA27543@lpieralisi>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-11-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012164145.14126-11-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 06:41:41PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> According to PCI 3.0 specification, sending both MSI and MSI-X interrupts
> is done by DWORD memory write operation to doorbell message address. The
> write operation for MSI has zero upper 16 bits and the MSI interrupt number
> in the lower 16 bits, while the write operation for MSI-X contains a 32-bit
> value from MSI-X table.
> 
> Since the driver only uses interrupt numbers from range 0..31, the upper
> 16 bits of the DWORD memory write operation to doorbell message address
> are zero even for MSI-X interrupts. Thus we can enable MSI-X interrupts.

It is the controller driver that defines the MSI-X data field yes, what
I don't get is why we have to add this comment in the commit log.

Basically Aardvark can support MSI-X up to 32 MSI-X vectors and you
are enabling them with this patch.

Is there anything *else* I am missing wrt 16-bit/32-bit data fields
that we need to know ?

> Testing proves that kernel can correctly receive MSI-X interrupts from
> PCIe cards which supports both MSI and MSI-X interrupts.

I don't understand what you want to convey with this commit log.

To me, the whole comment does not add anything (if I understood it),
please let me know what you want to express with it.

To me this patch enables MSI-X support because the HW can support them,
that's it.

Lorenzo

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index b703b271c6b1..337b61508799 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1274,7 +1274,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
>  
>  	msi_di = &pcie->msi_domain_info;
>  	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		MSI_FLAG_MULTI_PCI_MSI;
> +			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
>  	msi_di->chip = msi_ic;
>  
>  	pcie->msi_inner_domain =
> -- 
> 2.32.0
> 
