Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B066355673
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbhDFOU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 10:20:57 -0400
Received: from foss.arm.com ([217.140.110.172]:43980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345100AbhDFOUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 10:20:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C14941FB;
        Tue,  6 Apr 2021 07:20:10 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C303F73D;
        Tue,  6 Apr 2021 07:20:09 -0700 (PDT)
Date:   Tue, 6 Apr 2021 15:20:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        robh@kernel.org, robin.murphy@arm.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Message-ID: <20210406142004.GA25082@lpieralisi>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+ Rob, Robin]

On Mon, Feb 22, 2021 at 02:17:31PM +0530, Bharat Kumar Gogada wrote:
> Add support for routing PCIe DMA traffic coherently when
> Cache Coherent Interconnect (CCI) is enabled in the system.
> The "dma-coherent" property is used to determine if CCI is enabled
> or not.
> Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> for the CCI specification.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 07e36661bbc2..8689311c5ef6 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -26,6 +26,7 @@
>  
>  /* Bridge core config registers */
>  #define BRCFG_PCIE_RX0			0x00000000
> +#define BRCFG_PCIE_RX1			0x00000004
>  #define BRCFG_INTERRUPT			0x00000010
>  #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
>  
> @@ -128,6 +129,7 @@
>  #define NWL_ECAM_VALUE_DEFAULT		12
>  
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> +#define CFG_PCIE_CACHE			GENMASK(7, 0)
>  
>  #define INT_PCI_MSI_NR			(2 * 32)
>  
> @@ -675,6 +677,11 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
>  			  BRCFG_PCIE_RX_MSG_FILTER);
>  
> +	/* This routes the PCIe DMA traffic to go through CCI path */
> +	if (of_dma_is_coherent(dev->of_node))
> +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
> +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> +

This is weird. FW is telling us that the RC is DMA coherent hence
we have to program the RC so that it is indeed DMA coherent.

It does not make much sense. I think this is a set-up that should be
programmed by firmware and reported to the kernel via the standard
"dma-coherent" property. The kernel can read that register to check the
HW configuration complies with the DT property.

I'd like to get RobH/Robin thoughts on this before proceeding - they
have more insights about the DT dma-coherent usage/bindings and
expected behaviour.

Thanks,
Lorenzo

>  	err = nwl_wait_for_link(pcie);
>  	if (err)
>  		return err;
> -- 
> 2.17.1
> 
