Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B828673B92
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjASOWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjASOWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:22:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926572133;
        Thu, 19 Jan 2023 06:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2898161958;
        Thu, 19 Jan 2023 14:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D8C433D2;
        Thu, 19 Jan 2023 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674138131;
        bh=bY47sj+taCgjVg3ciOHgQdSFSSTtzqbCSq1j2aPO4Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMgflNK94RMu0HDmaLdm3GnHGNVnW5J/RoxECwBu4K3DIg3722+vjDkVux1dVwXXD
         0MCc1HnLi5ILp6pWp1gx+fP9RIOvhu1heAQywr44/50zTqb5mwoxWe7nO1zksWB3Mw
         RV0Hl6Nc7+LxhAFwNFznpY3r4hqbLI2XM0FuFDEj2PBNo8DlgauEkiw4yrEp0XgP9N
         f3vor7PXuQ1t2lvEfs6uHiZIa0GNV7c4Llji1U7jzYbTMEDWZVN8uhJxroCUKCJLR3
         LHfKhTy2Lm5xrjB9jRVgqfm0i+RmZO6w6rgBHnyxOmyPdq4gOkbczG2jHD00tO/dJk
         FcIzO9TzgZMog==
Date:   Thu, 19 Jan 2023 19:51:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <20230119142155.GA101896@thinkpad>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-11-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119140453.3942340-11-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 04:04:51PM +0200, Abel Vesa wrote:
> Add compatible for both PCIe found on SM8550.
> Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> 
> The v3 of this patchset is:
> https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/
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
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 77e5dc7b88ad..30f74bc51dbf 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
>  
>  /* 6 clocks typically, 7 for sm8250 */

Now this comment is outdated ;)

Thanks,
Mani

>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[12];
> +	struct clk_bulk_data clks[13];
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> @@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[idx++].id = "noc_aggr_4";
>  	res->clks[idx++].id = "noc_aggr_south_sf";
>  	res->clks[idx++].id = "cnoc_qx";
> +	res->clks[idx++].id = "cnoc_sf_axi";
>  
>  	num_opt_clks = idx - num_clks;
>  	res->num_clks = idx;
> @@ -1828,6 +1829,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
