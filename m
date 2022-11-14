Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355D6627616
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiKNGtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiKNGtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:49:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0FA46C;
        Sun, 13 Nov 2022 22:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F4160EA2;
        Mon, 14 Nov 2022 06:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F39C433C1;
        Mon, 14 Nov 2022 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668408583;
        bh=sM1CxadADS6VF7yySpWl8PAHvpBPliXhQmp/gxcPTR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMgTDJ2iQ7vqzm7LUCNeNUBq8NjgjDxhLTzCYu2v1r4S8/pTv6IuL8785ifLqMXOp
         puwYu1ILfyT9wqXYuFXsBYOIWg7PnReCif5zBX6OM2El1boNp+eLJLlJ3GIdfiM1PO
         YnQURXYesyL6u/JcC0AbEaiO8RUtlnIymL4t5dBhSf1xdJaJjsi8tBTqe+EGqDoS7l
         qb7WSYeEx4CKNsrCr1MP2/Bm7CsM/Cdf/xM06W24sijiVdO8RCUdRoCweVfBonxtfm
         EtsFfqAf4zvKfA4D1BMxr4zSte+nPzicK9DFdVqehowvfmCwxzZaiVy4TsTZzpO9Hb
         61RKkDQM1dp8A==
Date:   Mon, 14 Nov 2022 12:19:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 18/20] PCI: dwc: Combine iATU detection procedures
Message-ID: <20221114064931.GF3869@thinkpad>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-19-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221113191301.5526-19-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 10:12:59PM +0300, Serge Semin wrote:
> Since the iATU CSR region is now retrieved in the DW PCIe resources getter
> there is no much benefits in the iATU detection procedures splitting up.
> Therefore let's join the iATU unroll/viewport detection procedure with the
> rest of the iATU parameters detection code. The resultant method will be
> as coherent as before, while the redundant functions will be eliminated
> thus producing more readable code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 39 +++++---------------
>  1 file changed, 10 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index a8436027434d..d31f9d41d5cb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -628,26 +628,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  }
>  
> -static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> -{
> -	u32 val;
> -
> -	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> -	if (val == 0xffffffff)
> -		return true;
> -
> -	return false;
> -}
> -
> -static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
> +void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
>  	u32 val, min, dir;
>  	u64 max;
>  
> -	if (dw_pcie_cap_is(pci, IATU_UNROLL)) {
> +	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> +	if (val == 0xFFFFFFFF) {
> +		dw_pcie_cap_set(pci, IATU_UNROLL);
> +
>  		max_region = min((int)pci->atu_size / 512, 256);
>  	} else {
> +		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
> +		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
> +
>  		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
>  		max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
>  	}
> @@ -689,23 +684,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>  	pci->num_ib_windows = ib;
>  	pci->region_align = 1 << fls(min);
>  	pci->region_limit = (max << 32) | (SZ_4G - 1);
> -}
> -
> -void dw_pcie_iatu_detect(struct dw_pcie *pci)
> -{
> -	if (dw_pcie_iatu_unroll_enabled(pci)) {
> -		dw_pcie_cap_set(pci, IATU_UNROLL);
> -	} else {
> -		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
> -		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
> -	}
> -
> -	dw_pcie_iatu_detect_regions(pci);
> -
> -	dev_info(pci->dev, "iATU unroll: %s\n", dw_pcie_cap_is(pci, IATU_UNROLL) ?
> -		"enabled" : "disabled");
>  
> -	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
> +	dev_info(pci->dev, "iATU: unroll %s, %u ob, %u ib, align %uK, limit %lluG\n",
> +		 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
>  		 pci->num_ob_windows, pci->num_ib_windows,
>  		 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
>  }
> -- 
> 2.38.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
