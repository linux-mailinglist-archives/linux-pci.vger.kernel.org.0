Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058ED5E64F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCORU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 10:17:20 -0400
Received: from foss.arm.com ([217.140.110.172]:49192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCORU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 10:17:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2DD2B;
        Wed,  3 Jul 2019 07:17:20 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 363A63F718;
        Wed,  3 Jul 2019 07:17:18 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:17:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 03/20] PCI: mobiveil: Correct the returned error number
Message-ID: <20190703141715.GB26804@e121166-lin.cambridge.arm.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412083635.33626-4-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:35:30AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch corrects the returned error number by convention,
> and removes an unnecessary error check.

Two distinct changes, two patches, please split and repost.

Lorenzo

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V5:
>  - Corrected and retouched the subject and changelog.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index b87471f08a40..563210e731d3 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
>  
>  	if (!pcie->intx_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return -ENODEV;
> +		return -ENOMEM;
>  	}
>  
>  	raw_spin_lock_init(&pcie->intx_mask_lock);
> @@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  	/* allocate the PCIe port */
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>  	if (!bridge)
> -		return -ENODEV;
> +		return -ENOMEM;
>  
>  	pcie = pci_host_bridge_priv(bridge);
> -	if (!pcie)
> -		return -ENOMEM;
>  
>  	pcie->pdev = pdev;
>  
> @@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  						    &pcie->resources, &iobase);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
> -		return -ENOMEM;
> +		return ret;
>  	}
>  
>  	/*
> -- 
> 2.17.1
> 
