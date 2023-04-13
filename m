Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2B6E1063
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDMOwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMOwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 10:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D0D99;
        Thu, 13 Apr 2023 07:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B847263F45;
        Thu, 13 Apr 2023 14:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6790DC4339B;
        Thu, 13 Apr 2023 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397537;
        bh=QG9Ja6Qfdja3+F6aw1CtqZqw6k9MQzX8MhhvMSkoqxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZURpi2bwBdV5kPciUgesKGZsSWm09HGKZW2sB6s/37Hig0Fg4lC6lNwxgFSWisgE
         GP20+mS3rkZioj3dVnG+tpGUZLEMA1XZiBQ6el5iF3REiqkQYmmPdJUzkFr7k4hHcD
         MhbAnLnxBJyeKIqpLEKg9ebIKMlR2PJ6McrEqfoTB7yTfzhzglf/Dy82wUF7C1qW9l
         7IyCU5EdCKX476SshiOCjLyarFivvPnjBZXOseNMtjjQItfglcM7llqnIIP9q+dPdM
         WzpTxLuNMf8SJJqK94R7iK3EiMoNzAFuu547JnrLBoIcEkq0ngKGmOBX88IUbWHbTr
         WvlJ7QW67jVaA==
Date:   Thu, 13 Apr 2023 16:52:08 +0200
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
Subject: Re: [Patch v6 8/9] PCI: tegra194: Add interconnect support in
 Tegra234
Message-ID: <ZDgXGCJQAHpLTw9S@lpieralisi>
References: <20230411110002.19824-1-sumitg@nvidia.com>
 <20230411110002.19824-9-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411110002.19824-9-sumitg@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 04:30:01PM +0530, Sumit Gupta wrote:
> Add support to request DRAM bandwidth with Memory Interconnect
> in Tegra234 SoC. The DRAM BW required for different modes depends
> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
> Currently, no latency is observed in data transfer with PCI as the
> DRAM Freq is always set to max. But that results in high power
> consumption. Now for Tegra234, we are enabling the dynamic scaling
> of the DRAM Freq based on requests from Clients instead of running
> at the max Freq always. This change does that for PCI MC client.

I am sorry but this is still unclear to me. The sentence above makes
me think that you are *adding* latency to the data transfer trading
it with lower power consumption; probably that's a wrong parsing of
what you are saying - so please explain what you want to say
with "no latency is observed" and whether this patch changes that
(which is not allowed because that would count as a regression).

Thanks,
Lorenzo

> 
> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 51 +++++++++++++++-------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index e6eec85480ca..4fdadc7b045f 100644
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
> @@ -288,6 +289,7 @@ struct tegra_pcie_dw {
>  	unsigned int pex_rst_irq;
>  	int ep_state;
>  	long link_status;
> +	struct icc_path *icc_path;
>  };
>  
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -310,6 +312,27 @@ struct tegra_pcie_soc {
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
> @@ -453,18 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
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
> -
> -	if (speed >= ARRAY_SIZE(pcie_gen_freq))
> -		speed = 0;
> -
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
> +	tegra_pcie_icc_set(pcie);
>  
>  	if (pcie->of_data->has_ltr_req_fix)
>  		return IRQ_HANDLED;
> @@ -950,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
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
> @@ -1023,13 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  		goto retry_link;
>  	}
>  
> -	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> -		PCI_EXP_LNKSTA_CLS;
> -
> -	if (speed >= ARRAY_SIZE(pcie_gen_freq))
> -		speed = 0;
> -
> -	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
> +	tegra_pcie_icc_set(pcie);
>  
>  	tegra_pcie_enable_interrupts(pp);
>  
> @@ -2233,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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
