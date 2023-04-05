Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0086D7A32
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjDEKrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjDEKrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 06:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011249F9;
        Wed,  5 Apr 2023 03:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD08D63C57;
        Wed,  5 Apr 2023 10:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55A2C433EF;
        Wed,  5 Apr 2023 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680691623;
        bh=q4mbSRyaECqXZBaI2chRUC8g7fKSua/OlQr5LOzU8Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYk7GArMLcHuZT6LglhcwfKswPjiUhvpykd6UfUcigFlmjTxk81cdWTM8meuG87OK
         auDr+rMup6Gh3bPqxaK+PCnitUXnEcraBkw66jONfxwMxKRcJ0aR9cXwA0je2NqU2a
         SuaAOx/GkY80DSvwBckR1cf/XsDftwTEfg7AN0H7peYfBa1gba7rbOJrs6tgMXDXKm
         XQ8oLmDqeHfK/qTHu9W+FGatJMx9o8YWlmPrCEP5+hb9JJQI1gRSJ+nqGxZxfBVt+4
         TebyxdRgWJ3of8pZKvTeVOoEeLzzAf8umVcViGN092/imnB2nDAMnXOUUYGrgP7fXR
         olLMJGuWAKHZg==
Date:   Wed, 5 Apr 2023 12:46:54 +0200
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
Subject: Re: [Patch v5 7/8] PCI: tegra194: add interconnect support in
 Tegra234
Message-ID: <ZC1Rnrb0MObR5S42@lpieralisi>
References: <20230330133354.714-1-sumitg@nvidia.com>
 <20230330133354.714-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330133354.714-8-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

You should still capitalize the subject.

"PCI: tegra194: Add interconnect.."

On Thu, Mar 30, 2023 at 07:03:53PM +0530, Sumit Gupta wrote:
> Add support to request DRAM bandwidth with Memory Interconnect
> in Tegra234 SoC. The DRAM BW required for different modes depends
> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
> 
> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

You should add a Link to the relevant lore archive, I am
pretty sure Bjorn chimed in too.

This patch does too many things at once; more importantly it
does *not* explain why we request memory bandwidth and why it
is required and *safe* given that the current code works so far.

So:

patch 1: fix the array overflow issues with the current code
patch 2: add memory bandwidth interconnect support

Thanks,
Lorenzo

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 44 ++++++++++++++++++----
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09825b4a075e..89d829a946ee 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> @@ -223,6 +224,7 @@
>  #define EP_STATE_ENABLED	1
>  
>  static const unsigned int pcie_gen_freq[] = {
> +	GEN1_CORE_CLK_FREQ,   /* PCI_EXP_LNKSTA_CLS == 0; undefined */
>  	GEN1_CORE_CLK_FREQ,
>  	GEN2_CORE_CLK_FREQ,
>  	GEN3_CORE_CLK_FREQ,
> @@ -287,6 +289,7 @@ struct tegra_pcie_dw {
>  	unsigned int pex_rst_irq;
>  	int ep_state;
>  	long link_status;
> +	struct icc_path *icc_path;
>  };
>  
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -309,6 +312,27 @@ struct tegra_pcie_soc {
>  	enum dw_pcie_device_mode mode;
>  };
>  
> +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	u32 val, speed, width;
> +
> +	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
> +
> +	val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
> +
> +	if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
> +		dev_err(pcie->dev, "can't set bw[%u]\n", val);
> +
> +	if (speed >= ARRAY_SIZE(pcie_gen_freq))
> +		speed = 0;
> +
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
> +}
> +
>  static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -452,14 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  	struct tegra_pcie_dw *pcie = arg;
>  	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	struct dw_pcie *pci = &pcie->pci;
> -	u32 val, speed;
> +	u32 val;
>  
>  	if (test_and_clear_bit(0, &pcie->link_status))
>  		dw_pcie_ep_linkup(ep);
>  
> -	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> -		PCI_EXP_LNKSTA_CLS;
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +	tegra_pcie_icc_set(pcie);
>  
>  	if (pcie->of_data->has_ltr_req_fix)
>  		return IRQ_HANDLED;
> @@ -945,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  
>  static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  {
> -	u32 val, offset, speed, tmp;
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  	struct dw_pcie_rp *pp = &pci->pp;
> +	u32 val, offset, tmp;
>  	bool retry = true;
>  
>  	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> @@ -1018,9 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  		goto retry_link;
>  	}
>  
> -	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> -		PCI_EXP_LNKSTA_CLS;
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +	tegra_pcie_icc_set(pcie);
>  
>  	tegra_pcie_enable_interrupts(pp);
>  
> @@ -2224,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
> +	ret = PTR_ERR_OR_ZERO(pcie->icc_path);
> +	if (ret) {
> +		tegra_bpmp_put(pcie->bpmp);
> +		dev_err_probe(&pdev->dev, ret, "failed to get write interconnect\n");
> +		return ret;
> +	}
> +
>  	switch (pcie->of_data->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
> -- 
> 2.17.1
> 
