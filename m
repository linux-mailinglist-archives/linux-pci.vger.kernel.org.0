Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219228118D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 13:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBLuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 07:50:55 -0400
Received: from foss.arm.com ([217.140.110.172]:33558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 07:50:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78CB1063;
        Fri,  2 Oct 2020 04:50:54 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C893F70D;
        Fri,  2 Oct 2020 04:50:53 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:50:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: iproc: use module_bcma_driver to simplify the
 code
Message-ID: <20201002115051.GB23640@e121166-lin.cambridge.arm.com>
References: <20200918030829.3946025-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918030829.3946025-1-liushixin2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 11:08:29AM +0800, Liu Shixin wrote:
> module_bcma_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Applied to pci/mobiveil, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> index aa55b064f64d..56b8ee7bf330 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -94,18 +94,7 @@ static struct bcma_driver iproc_pcie_bcma_driver = {
>  	.probe		= iproc_pcie_bcma_probe,
>  	.remove		= iproc_pcie_bcma_remove,
>  };
> -
> -static int __init iproc_pcie_bcma_init(void)
> -{
> -	return bcma_driver_register(&iproc_pcie_bcma_driver);
> -}
> -module_init(iproc_pcie_bcma_init);
> -
> -static void __exit iproc_pcie_bcma_exit(void)
> -{
> -	bcma_driver_unregister(&iproc_pcie_bcma_driver);
> -}
> -module_exit(iproc_pcie_bcma_exit);
> +module_bcma_driver(iproc_pcie_bcma_driver);
>  
>  MODULE_AUTHOR("Hauke Mehrtens");
>  MODULE_DESCRIPTION("Broadcom iProc PCIe BCMA driver");
> -- 
> 2.25.1
> 
