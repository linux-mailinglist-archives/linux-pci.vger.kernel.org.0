Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B644A689452
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBCJtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjBCJtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:49:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469E26580;
        Fri,  3 Feb 2023 01:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7626F61E47;
        Fri,  3 Feb 2023 09:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF38C433D2;
        Fri,  3 Feb 2023 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675417738;
        bh=rXy7btraUJBuP9FasxHRz8/BmmVLJJUUb3KO9iJARDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLa5WYJXS1btpT4AHaZ9QKYVurBIWHg5qFF3nYsOFpyX9cbTxHRsNM8c9z7ujFdl/
         ZNozG6sKcYFGHkM65ky1nlGHTRN5xobGYrnq8zN3dx/G/ZhMWX92hqtyiKz9MhntTO
         lPQrB63fG12M+NIhkTWwKiVJmPtuZhBWtWBSNhJ9g6b1K7JP5HmDBzmB8ajf9FcC7w
         zle/k/b0C2z0Jqg8Y2sG5xo7yX7do57WAhULOUgXVzwvY/pp3CnwqqUUjFsegfJO1r
         vfLloica/zuWgd9JOjoZ9uObM7JjQv88tgabR8SFKHixyqFTQrprDUrh0js85aDY7p
         T/0rRtLI/zJAg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNshA-0000u7-FA; Fri, 03 Feb 2023 10:49:25 +0100
Date:   Fri, 3 Feb 2023 10:49:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-11-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203081807.2248625-11-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 10:18:05AM +0200, Abel Vesa wrote:
> Add compatible for both PCIe found on SM8550.
> Also add the cnoc_pcie_sf_axi clock needed by the SM8550.

nit: You're now also adding 'noc_aggr'

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> 
> The v6 of this patchset is:
> https://lore.kernel.org/all/20230202123902.3831491-11-abel.vesa@linaro.org/
> 
> Changes since v6:
>  * none
> 
> Changes since v5:
>  * none
> 
> Changes since v4:
>  * added Mani's R-b tag
> 
> Changes since v3:
>  * renamed cnoc_pcie_sf_axi to cnoc_sf_axi
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * changed the subject line prefix for the patch to match the history,
>    like Bjorn Helgaas suggested.
>  * added Konrad's R-b tag
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..6a70c9c6f98d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
>  
>  /* 6 clocks typically, 7 for sm8250 */
>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[12];
> +	struct clk_bulk_data clks[14];
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
> -	struct reset_control *pci_reset;
> +	struct reset_control *rst;

Please name this one 'reset' or 'resets' (e.g. to avoid hard to parse
things like res->rst below).

>  };
>  
>  struct qcom_pcie_resources_2_9_0 {
> @@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	unsigned int idx;
>  	int ret;
>  
> -	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> -	if (IS_ERR(res->pci_reset))
> -		return PTR_ERR(res->pci_reset);
> +	res->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(res->rst))
> +		return PTR_ERR(res->rst);

So the reset array implementation apparently both asserts and deasserts
the resets in the order specified in DT (i.e. does not deassert in
reverse order).

Is that ok also for the new "pci" and "link_down" resets?

>  	res->supplies[0].supply = "vdda";
>  	res->supplies[1].supply = "vddpe-3v3";
> @@ -1205,9 +1205,11 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[idx++].id = "ddrss_sf_tbu";
>  	res->clks[idx++].id = "aggre0";
>  	res->clks[idx++].id = "aggre1";
> +	res->clks[idx++].id = "noc_aggr";
>  	res->clks[idx++].id = "noc_aggr_4";
>  	res->clks[idx++].id = "noc_aggr_south_sf";
>  	res->clks[idx++].id = "cnoc_qx";
> +	res->clks[idx++].id = "cnoc_sf_axi";
>  
>  	num_opt_clks = idx - num_clks;
>  	res->num_clks = idx;
> @@ -1237,17 +1239,17 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		goto err_disable_regulators;
>  
> -	ret = reset_control_assert(res->pci_reset);
> -	if (ret < 0) {
> -		dev_err(dev, "cannot assert pci reset\n");
> +	ret = reset_control_assert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset assert failed (%d)\n", ret);
>  		goto err_disable_clocks;
>  	}
>  
>  	usleep_range(1000, 1500);
>  
> -	ret = reset_control_deassert(res->pci_reset);
> -	if (ret < 0) {
> -		dev_err(dev, "cannot deassert pci reset\n");
> +	ret = reset_control_deassert(res->rst);
> +	if (ret) {
> +		dev_err(dev, "reset deassert failed (%d)\n", ret);
>  		goto err_disable_clocks;
>  	}

Johan
