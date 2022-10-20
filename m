Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD0605E76
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 13:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJTLI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJTLI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 07:08:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179319DD9D;
        Thu, 20 Oct 2022 04:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD3FDB82704;
        Thu, 20 Oct 2022 11:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FDFC433D6;
        Thu, 20 Oct 2022 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666264133;
        bh=u/LxgNBR5x9KIgosTs6iI0MM/JXQrrQX8bLHrmhodM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeSo9dHN3UsoVe9fKmsCnXBrm44a3HATkzIUf8LPP5C6PknfR5TDmIq4K5KCiBZQg
         WIiVhema9wUOtnfTTxv5UhxSgZBVTxJBx2m7RaM3W5W2/7atWbK/ilNu05WWmiYYi2
         y9lv9bQyL0w+G6CeGBza1fjnugujjVwETQH9Pq3ysX32kexZSxoyjt06Ul0mohTvaN
         Mn54J3AM9JCCqnE6TcwmexdAncFZTbxXK1boFhYDaNP0Mvpzu83J6/nXQvUtTHkMub
         R5cJc1p/U0vWmFoQZYQycDZeU35hlo98kuJoBXxbJz94I7Lhi7c1cicaWziVJeHDtK
         9oU8T1/cG4KzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olTPk-0002OZ-40; Thu, 20 Oct 2022 13:08:40 +0200
Date:   Thu, 20 Oct 2022 13:08:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: qcom: Use clk_bulk_ API for 1.0.0 clocks
 handling
Message-ID: <Y1EsOGhEqNe9Cxo6@hovoldconsulting.com>
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
 <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 01:31:18PM +0300, Dmitry Baryshkov wrote:
> Change hand-coded implementation of bulk clocks to use the existing

Let's hope everything is "hand-coded" at least for a few years still
(job security). ;)

Perhaps rephrase using "open-coded"?

> clk_bulk_* API.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 67 ++++++--------------------
>  1 file changed, 16 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 939f19241356..74588438db07 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -133,10 +133,7 @@ struct qcom_pcie_resources_2_1_0 {
>  };
>  
>  struct qcom_pcie_resources_1_0_0 {
> -	struct clk *iface;
> -	struct clk *aux;
> -	struct clk *master_bus;
> -	struct clk *slave_bus;
> +	struct clk_bulk_data clks[4];
>  	struct reset_control *core;
>  	struct regulator *vdda;
>  };
> @@ -472,26 +469,20 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	int ret;
>  
>  	res->vdda = devm_regulator_get(dev, "vdda");
>  	if (IS_ERR(res->vdda))
>  		return PTR_ERR(res->vdda);
>  
> -	res->iface = devm_clk_get(dev, "iface");
> -	if (IS_ERR(res->iface))
> -		return PTR_ERR(res->iface);
> -
> -	res->aux = devm_clk_get(dev, "aux");
> -	if (IS_ERR(res->aux))
> -		return PTR_ERR(res->aux);
> -
> -	res->master_bus = devm_clk_get(dev, "master_bus");
> -	if (IS_ERR(res->master_bus))
> -		return PTR_ERR(res->master_bus);
> +	res->clks[0].id = "aux";
> +	res->clks[1].id = "iface";
> +	res->clks[2].id = "master_bus";
> +	res->clks[3].id = "slave_bus";
>  
> -	res->slave_bus = devm_clk_get(dev, "slave_bus");
> -	if (IS_ERR(res->slave_bus))
> -		return PTR_ERR(res->slave_bus);
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		return ret;

Are you sure there are no dependencies between these clocks and that
they can be enabled and disabled in any order?

Are you also convinced that they will always be enabled and disabled
together (e.g. not controlled individually during suspend)?

> -	ret = clk_prepare_enable(res->aux);
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
>  	if (ret) {
> -		dev_err(dev, "cannot prepare/enable aux clock\n");
> +		dev_err(dev, "cannot prepare/enable clocks\n");

The bulk API already logs an error so you can drop the dev_err().

These comments apply also to the other patches.

Johan
