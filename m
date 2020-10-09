Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0228890A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgJIMnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 08:43:10 -0400
Received: from foss.arm.com ([217.140.110.172]:50276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJIMnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 08:43:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD7F1063;
        Fri,  9 Oct 2020 05:43:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417DE3F70D;
        Fri,  9 Oct 2020 05:43:08 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:43:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] PCI: iproc: Fix using plain integer as NULL pointer in
 iproc_pcie_pltfm_probe
Message-ID: <20201009124302.GA18707@e121166-lin.cambridge.arm.com>
References: <20200922194932.465925-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922194932.465925-1-kw@linux.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 07:49:32PM +0000, Krzysztof Wilczyński wrote:
> Fix sparse build warning:
> 
>   drivers/pci/controller/pcie-iproc-platform.c:102:33: warning: Using plain integer as NULL pointer
> 
> The map_irq member of the struct iproc_pcie takes a function pointer
> serving as a callback to map interrupts, therefore we should pass a NULL
> pointer to it rather than a integer in the iproc_pcie_pltfm_probe()
> function.
> 
> Related:
>   commit b64aa11eb2dd ("PCI: Set bridge map_irq and swizzle_irq to
>   default functions")
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/iproc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index a956b0c18bd1..b93e7bda101b 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -99,7 +99,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	switch (pcie->type) {
>  	case IPROC_PCIE_PAXC:
>  	case IPROC_PCIE_PAXC_V2:
> -		pcie->map_irq = 0;
> +		pcie->map_irq = NULL;
>  		break;
>  	default:
>  		break;
> -- 
> 2.28.0
> 
