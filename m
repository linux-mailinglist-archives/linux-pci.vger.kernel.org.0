Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32A2FF04A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbhAUQ3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732818AbhAUQ3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 11:29:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 081D9206D8;
        Thu, 21 Jan 2021 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611246510;
        bh=Zf8jgI/znTml17RA4NO0vaF+2LzStyZ+d/XnHcMtsV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sCDbhm0B2bnYK9DcRQON1x/sDXtjMRK/xOu2WSEbxuJXPJW2XKfA/9IyjAYsuKVGl
         FzT9WVmzZmacrC3B197YKTnsmYPEejSz0wrjXLiojimZqjHgfI63Mu0Om9EL299wyc
         HfnALXtyvpgdx6YK0BPr4FCH1Aipm90ZJGg2tDz6JEK2pVaxOohL++37va9QE7JaTd
         UCkPi61JY7UqwW/KUNTFUfgxIhJ+R0K5SgUsbheD2kxZyOXf5t4OzzdFXwlJSn19Yo
         J6W3qZuN0230hQLfAJkX1G5OLYbT2QgptntqMlt1rmnzDy8L9vvVx2UAB6IGlGmXfl
         c6g5CqBF22G/Q==
Date:   Thu, 21 Jan 2021 10:28:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: xilinx-nwl: Enable coherenct PCIe traffic using CCI
Message-ID: <20210121162827.GA2658969@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611223156-8787-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

s/coherenct/coherent/ in subject
s/traffic/DMA/ (this applies specifically to DMA, not to MMIO)

On Thu, Jan 21, 2021 at 03:29:16PM +0530, Bharat Kumar Gogada wrote:
> - Add support for routing PCIe traffic coherently when
>  Cache Coherent Interconnect(CCI) is enabled in the system.

s/- Add/Add/
s/Interconnect(CCI)/Interconnect (CCI)/

Can you include a URL to a CCI spec?  I'm not familiar with it.  I
guess this is something upstream from the host bridge, i.e., between
the CPU and the host bridge, so it's outside the PCI domain?

I'd like to mention the DT "dma-coherent" property in the commit log
to help connect this with the knob that controls it.

The "dma-coherent" property is mentioned several places in
Documentation/devicetree/bindings/pci/ (but not anything obviously
related to xilinx-nwl).  Should it be moved to something like
Documentation/devicetree/bindings/pci/pci.txt to make it more generic?

> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 07e3666..08e06057 100644
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
> @@ -675,6 +677,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
>  			  BRCFG_PCIE_RX_MSG_FILTER);
>  
> +	/* This routes the PCIe DMA traffic to go through CCI path */
> +	if (of_dma_is_coherent(dev->of_node)) {
> +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
> +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> +	}
> +
>  	err = nwl_wait_for_link(pcie);
>  	if (err)
>  		return err;
> -- 
> 2.7.4
> 
