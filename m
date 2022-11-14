Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A927B627604
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiKNGm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiKNGm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:42:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22687D7A;
        Sun, 13 Nov 2022 22:42:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3C9CCE0E11;
        Mon, 14 Nov 2022 06:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AA6C433C1;
        Mon, 14 Nov 2022 06:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668408171;
        bh=zra9C2jOIk45M6haaQS0RDkalfo8RYSFqJsRKn2rxcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WV8lP7yWgdYRGpvGjdrBpRnRWZ29AxGIrlZlieZhYeyRmzTVUCLBe8u4hedOJeWvd
         2e1MmLCzr/K1WVsfu695vE+Liyis/MbPM6w9KiqOQ93IpcAa3XtooVObr0fi6lDiWG
         mqeynn1IwDqqEtntLiKaY5GjBOmiMoGglQbz3vFFUuuPWNHy+KQTM1LzroGe+88bDl
         UIrSAMMeiuh0Cb4hawhqcoH7LMezPFqK8/X8HW1GEyX7MVZAKGcOfTYpVeMgIfo60n
         6PEmI5eIXJ5ySzfFug3r1r/gRcBfXZw1+vuxcaGVbcZ1ctSRgK6AGjoYOytVN0maUf
         Jr5y5F/rCLlgg==
Date:   Mon, 14 Nov 2022 12:12:39 +0530
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
Subject: Re: [PATCH v7 16/20] PCI: dwc: Introduce generic controller
 capabilities interface
Message-ID: <20221114064239.GD3869@thinkpad>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221113191301.5526-17-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 10:12:57PM +0300, Serge Semin wrote:
> Since in addition to the already available iATU unrolled mapping we are
> about to add a few more DW PCIe platform-specific capabilities (CDM-check
> and generic clocks/resets resources) let's add a generic interface to set
> and get the flags indicating their availability. The new interface shall
> improve maintainability of the platform-specific code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Note the DW_PCIE_CAP_IATU_UNROLL macro is intentionally set to 1 since
> being added afterwards capability will be more suitable to be identified
> with position 0.
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 11 ++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h | 12 +++++++++++-
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ca830ee794a7..9d78e7ca61e1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -211,7 +211,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
>  static inline void __iomem *dw_pcie_select_atu(struct dw_pcie *pci, u32 dir,
>  					       u32 index)
>  {
> -	if (pci->iatu_unroll_enabled)
> +	if (dw_pcie_cap_is(pci, IATU_UNROLL))
>  		return pci->atu_base + PCIE_ATU_UNROLL_BASE(dir, index);
>  
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | index);
> @@ -591,7 +591,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>  	u32 val, min, dir;
>  	u64 max;
>  
> -	if (pci->iatu_unroll_enabled) {
> +	if (dw_pcie_cap_is(pci, IATU_UNROLL)) {
>  		max_region = min((int)pci->atu_size / 512, 256);
>  	} else {
>  		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
> @@ -641,8 +641,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	struct platform_device *pdev = to_platform_device(pci->dev);
>  
> -	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
> -	if (pci->iatu_unroll_enabled) {
> +	if (dw_pcie_iatu_unroll_enabled(pci)) {
> +		dw_pcie_cap_set(pci, IATU_UNROLL);
> +
>  		if (!pci->atu_base) {
>  			struct resource *res =
>  				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> @@ -664,7 +665,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  
>  	dw_pcie_iatu_detect_regions(pci);
>  
> -	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
> +	dev_info(pci->dev, "iATU unroll: %s\n", dw_pcie_cap_is(pci, IATU_UNROLL) ?
>  		"enabled" : "disabled");
>  
>  	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 37801bbce854..c6dddacee3b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -12,6 +12,7 @@
>  #define _PCIE_DESIGNWARE_H
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
> @@ -43,6 +44,15 @@
>  	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
>  	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
>  
> +/* DWC PCIe controller capabilities */
> +#define DW_PCIE_CAP_IATU_UNROLL		1
> +
> +#define dw_pcie_cap_is(_pci, _cap) \
> +	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> +
> +#define dw_pcie_cap_set(_pci, _cap) \
> +	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> +
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> @@ -317,10 +327,10 @@ struct dw_pcie {
>  	const struct dw_pcie_ops *ops;
>  	u32			version;
>  	u32			type;
> +	unsigned long		caps;
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> -	bool			iatu_unroll_enabled: 1;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> -- 
> 2.38.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
