Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01477A0A79
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbjINQJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjINQJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 12:09:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A401BEF;
        Thu, 14 Sep 2023 09:09:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0DFC433C8;
        Thu, 14 Sep 2023 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707784;
        bh=iG88UtPlCrOIAvGQL1fL5TxzQKU6atcBWhCTHpJ9NdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LAC9eY/p98qqoGW+p+QG0Vx4L3JGPYf/WEo9KjQxn2iY/s+U9sMSt5hLrDShTZo7w
         bfZpgFP+jZGRXW12kBYVr3ntcBqNI/4qI/lfIA+eeRJAOe+qucZOQHe/uD6pTLkP0j
         st7zYWVMc+Y2Gj0HqIBsFZkAkzeDB/zYKTV20QAd8EMBTG40407YQytq3nRlFVQzMX
         +wDnwYv7rPDmTXIY0HXy+U3LUUss63NpSaibpO3UYdEvwaDP903cA0OK3d6js0GI2P
         +NUntL2o+Sw/cgpkgP5DSqfzJpD8wF15vMiEVqJqU3BSb+73mjwStP+aClgZD0S8Ek
         e6bUy4lXt03Ig==
Date:   Thu, 14 Sep 2023 11:09:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 09/19] PCI: dwc: Add EDMA_UNROLL capability flag
Message-ID: <20230914160941.GA32484@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-10-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 06:32:09PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car Gen4 PCIe controllers have an unexpected register value in
> the eDMA CTRL register. So, add a new capability flag "EDMA_UNROLL"
> which would force the unrolled eDMA mapping for the problematic device.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c4998194fe74..4812ce040f1e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -883,8 +883,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> +	 *
> +	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> +	 * have zeros in the eDMA CTRL register even though the HW-manual
> +	 * explicitly states there must FFs if the unrolled mapping is enabled.
> +	 * For such cases the low-level drivers are supposed to manually
> +	 * activate the unrolled mapping to bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A))
> +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b731e38a71fc..c7759a508ca9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -51,8 +51,9 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_IATU_UNROLL		1
> -#define DW_PCIE_CAP_CDM_CHECK		2
> +#define DW_PCIE_CAP_EDMA_UNROLL		1
> +#define DW_PCIE_CAP_IATU_UNROLL		2
> +#define DW_PCIE_CAP_CDM_CHECK		3

Why did you make the new DW_PCIE_CAP_EDMA_UNROLL "1" and shift all the
existing ones down?  If they don't need to be ordered like this,
leaving the existing ones alone and making DW_PCIE_CAP_EDMA_UNROLL "3"
would be a simpler one-line diff.

>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> -- 
> 2.25.1
> 
