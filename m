Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A86EAB4E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjDUNNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjDUNND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 09:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A909ECF;
        Fri, 21 Apr 2023 06:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8AB463E7D;
        Fri, 21 Apr 2023 13:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF73C433D2;
        Fri, 21 Apr 2023 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682082781;
        bh=LTVF3UalAmWiwiNCKiCSSsd5kOFARhJPHx3eV2qtZfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnFjT+cLXDWGzZ2ck7tAXbOS238fadx5OvphD1h6WpDW1zxp9KWxta5nCszqE9qla
         fYPHZjk9NQowBxU3/tAjfuR3PXl2la+L7blgf4Uik7rocsNEiItVlmtKF3f9Bz7YCV
         ZavqiwSgBqkoUYe9VZtdMrZ7GWCN2KrIACfuWa+t35WCl0wPeUMqmulVuXWKIB1LEP
         Vedfm7zHiUttnBzzwPoI2slNA45yN2Ge2eyBtuaYld0fIUWLG8P5ypIqq3DFyALVLM
         2bbufYNlOCmRPfLLio26ExAslQCDv7uABZm3Ux+jlLvoqFQXxydbpMRe3FqKvWVpid
         zqsO7350CAuEQ==
Date:   Fri, 21 Apr 2023 15:12:53 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v6 7/9] PCI: tegra194: Fix possible array out of bounds
 access
Message-ID: <ZEKL1XzYzOwcEkHK@lpieralisi>
References: <20230411110002.19824-1-sumitg@nvidia.com>
 <20230411110002.19824-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411110002.19824-8-sumitg@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 04:30:00PM +0530, Sumit Gupta wrote:
> Add check to fix the possible array out of bounds violation by
> making speed equal to GEN1_CORE_CLK_FREQ when its value is more
> than the size of "pcie_gen_freq" array. This array has size of
> four but possible speed (CLS) values are from "0 to 0xF". So,
> "speed - 1" values are "-1 to 0xE". This change was suggested by
> "Bjorn Helgaas" in the below link.

There is a Suggested-by tag and a Link: tag remove the last
sentence, that's duplicate information.

> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Link: https://lore.kernel.org/lkml/72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com/
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09825b4a075e..e6eec85480ca 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -223,6 +223,7 @@
>  #define EP_STATE_ENABLED	1
>  
>  static const unsigned int pcie_gen_freq[] = {
> +	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
>  	GEN1_CORE_CLK_FREQ,
>  	GEN2_CORE_CLK_FREQ,
>  	GEN3_CORE_CLK_FREQ,
> @@ -459,7 +460,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  
>  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>  		PCI_EXP_LNKSTA_CLS;
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +
> +	if (speed >= ARRAY_SIZE(pcie_gen_freq))
> +		speed = 0;
> +
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>  
>  	if (pcie->of_data->has_ltr_req_fix)
>  		return IRQ_HANDLED;
> @@ -1020,7 +1025,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  
>  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>  		PCI_EXP_LNKSTA_CLS;
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +
> +	if (speed >= ARRAY_SIZE(pcie_gen_freq))
> +		speed = 0;
> +
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>  
>  	tegra_pcie_enable_interrupts(pp);
>  
> -- 
> 2.17.1
> 
