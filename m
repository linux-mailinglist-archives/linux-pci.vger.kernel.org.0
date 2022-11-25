Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAC6389CC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKYMbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 07:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKYMbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 07:31:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3722529D;
        Fri, 25 Nov 2022 04:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6918C623C4;
        Fri, 25 Nov 2022 12:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693BDC433C1;
        Fri, 25 Nov 2022 12:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669379477;
        bh=OaKU45W8QrLKhHbu9Oxkvgt4uPosAwQSsVZwp8dqIt8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XhY0vJlYEac/H484fM0aU3vBaJIItaF69xIuOAAln63lKPc/WelGEx0hz0VXOzYVp
         8+ZPXfBNSdzsWF+CrOvh91Nno4keWAJa3eyXmBRPCOtfm3d1VBXiO4g+ioduQRLOyz
         5eLu9FEaxZNG2kUgOwG5cGRi3DrfX5QZ0rsQvCTL2B7mwnOdTlYJhIA4MJJtp6WC21
         q4ukhvy43tIkOoyvb6kC/54MbSkd1zt2OXIL+9PYVcd2SbHAmGkXb4KShmQyOW2v6P
         D2RdFzjeSLmrLw2t/PCG36KBRYr/wuW8vKYGG5Dx56KjOKI72zaqH74kmTH4S2shaG
         XgofdlZA2XujA==
Message-ID: <23ecae8e-e4bf-60d9-1fa5-18894834d585@kernel.org>
Date:   Fri, 25 Nov 2022 14:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 3/5] PCI: j721e: Add PCIe 4x lane selection support
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, vigneshr@ti.com,
        tjoseph@cadence.com, sergio.paracuellos@gmail.com,
        pthombar@cadence.com, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124081221.1206167-1-mranostay@ti.com>
 <20221124081221.1206167-4-mranostay@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221124081221.1206167-4-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 24/11/2022 10:12, Matt Ranostay wrote:
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

u32 mask = BIT(8);

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

Reviewed-by: Roger Quadros <rogerq@kernel.org>

cheers,
-roger
