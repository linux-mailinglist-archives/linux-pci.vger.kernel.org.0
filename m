Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8876EB979
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDVN5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVN5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 09:57:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463071FE3;
        Sat, 22 Apr 2023 06:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D260F60C99;
        Sat, 22 Apr 2023 13:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1846C433EF;
        Sat, 22 Apr 2023 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682171827;
        bh=1ZAfgUPZzd549qSqWwWvU1XHZnA1AL3DXJx/+EYVic8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBDueLM2l3Sph6FzFqt2mrSkeItxDGF+1V5rGyUPfXMfC5+myDGUSOjSmaBrge5K+
         7UtpQGh+vEGMHDHSsBLMKwrt11TODmEabH89zt+CuEO+0sbHh38jy4eyyOM8n4t4Bg
         C7kj0FEXaj5/yXlnkccxHqiSZysBHi/a4bzw1XCPqRkK1OLdw4MfnzROMKg93+EEhL
         xCrcDxokwf8b4gD26OlGnrMIKOar/uDYBJr/l5owaCweyjr4CXU3yf944Sh7qqLMSO
         gEqwbqWdqKp1Q+GG1CvNmRyGm9+a0EYSN5tYg3VA7US22vos8TBXt7Od6kW8NAEy7j
         0kZ7ptDfMpykw==
Date:   Sat, 22 Apr 2023 19:26:58 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 13/22] PCI: dwc: Add EDMA_UNROLL capability flag
Message-ID: <20230422135658.GJ4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-14-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-14-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:54PM +0900, Yoshihiro Shimoda wrote:
> One of PCIe controllers have an unexpected register value on

Which PCI controller?

> the dbi+0x97b register. So, add a new capability flag "EDMA_UNROLL"
> which would force the unrolled eDMA mapping for the problematic
> device, as suggested by Serge Semin.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Should this patch have a Suggested-by tag?

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2413cd39310c..feb6ab9d4944 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -920,8 +920,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> +	 *
> +	 * Note some devices for unknown reason may have zeros in the eDMA CTRL

Again, it is good to mention what controllers are exhibiting this behavior.

- Mani

> +	 * register even though the HW-manual explicitly states there must FFs
> +	 * if the unrolled mapping is enabled. For such cases the low-level
> +	 * drivers are supposed to manually activate the unrolled mapping to
> +	 * bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A))
> +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 8c08159ea08e..c4bdfed7b2e2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -54,8 +54,9 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_IATU_UNROLL		1
> -#define DW_PCIE_CAP_CDM_CHECK		2
> +#define DW_PCIE_CAP_EDMA_UNROLL		1
> +#define DW_PCIE_CAP_IATU_UNROLL		2
> +#define DW_PCIE_CAP_CDM_CHECK		3
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
