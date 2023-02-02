Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A809F6883C4
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjBBQJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 11:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBBQJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 11:09:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94556B036;
        Thu,  2 Feb 2023 08:09:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71AF661BF4;
        Thu,  2 Feb 2023 16:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABEC433EF;
        Thu,  2 Feb 2023 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675354177;
        bh=xjNBvclZKFnIHn9hRQhrxBHvSbPwMKJe/L5bKZulUDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKwX9vpOm7OPqRcBWD60/Kcla5InDbtRaafHfflIRtWCcFuEscArPK7Z1O2px2hiz
         PoR6bR4dy7UePHOGngn1BGINwwcmRhCjt9xulXO+gV8O909OctHENGX9EkKynHVP2p
         2plz2lqZrjOnkQYxDzcW1yxDPGTYLhyE+nX28LtVHKf3D+DxFZc718+NZ+KtscHv8S
         6O9DQoTp1gtB7frsriKqaBoNdirBk5ktfBq1FKK3FayD7GZR5M0EKUqE5vUkotW2YM
         m0/DTMLvSCDVVDKpOiBpxhTXOO8rhXuitPP2kImZ+oZTk5LzApRg94WusgYUrXP2n9
         aw3zRwi7sStQg==
Date:   Thu, 2 Feb 2023 17:09:31 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>, robh@kernel.org
Cc:     rogerq@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, vigneshr@ti.com,
        tjoseph@cadence.com, sergio.paracuellos@gmail.com,
        pthombar@cadence.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] PCI: j721e: Add PCIe 4x lane selection support
Message-ID: <Y9vgO51IRfx1by3P@lpieralisi>
References: <20221124081221.1206167-1-mranostay@ti.com>
 <20221124081221.1206167-4-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124081221.1206167-4-mranostay@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

I think your comment:

https://lore.kernel.org/linux-pci/CAL_JsqJ5cOLXhD-73esmhVwMEWGT+w3SJC14Z0jY4tQJQRA7iw@mail.gmail.com

was related to the commit log wording and not necessarily
the actual diff. Please let me know if you are happy with
this change and I shall merge the series.

Thanks,
Lorenzo

On Thu, Nov 24, 2022 at 12:12:19AM -0800, Matt Ranostay wrote:
> Add support for setting of two-bit field that allows selection of 4x lane
> PCIe which was previously limited to only 2x lanes.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 8990f58d64d5..dab3db9be6d8 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -42,7 +42,6 @@ enum link_status {
>  };
>  
>  #define J721E_MODE_RC			BIT(7)
> -#define LANE_COUNT_MASK			BIT(8)
>  #define LANE_COUNT(n)			((n) << 8)
>  
>  #define GENERATION_SEL_MASK		GENMASK(1, 0)
> @@ -52,6 +51,7 @@ struct j721e_pcie {
>  	struct clk		*refclk;
>  	u32			mode;
>  	u32			num_lanes;
> +	u32			max_lanes;
>  	void __iomem		*user_cfg_base;
>  	void __iomem		*intd_cfg_base;
>  	u32			linkdown_irq_regfield;
> @@ -205,11 +205,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>  {
>  	struct device *dev = pcie->cdns_pcie->dev;
>  	u32 lanes = pcie->num_lanes;
> +	u32 mask = GENMASK(8, 8);
>  	u32 val = 0;
>  	int ret;
>  
> +	if (pcie->max_lanes == 4)
> +		mask = GENMASK(9, 8);
> +
>  	val = LANE_COUNT(lanes - 1);
> -	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
> +	ret = regmap_update_bits(syscon, offset, mask, val);
>  	if (ret)
>  		dev_err(dev, "failed to set link count\n");
>  
> @@ -439,6 +443,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
>  	if (ret || num_lanes > data->max_lanes)
>  		num_lanes = 1;
> +
> +	pcie->max_lanes = data->max_lanes;
>  	pcie->num_lanes = num_lanes;
>  
>  	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
> -- 
> 2.38.GIT
> 
