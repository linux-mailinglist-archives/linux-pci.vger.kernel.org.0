Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA862E54B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 20:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiKQTac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 14:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbiKQTab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 14:30:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C588F97;
        Thu, 17 Nov 2022 11:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4F5B821C6;
        Thu, 17 Nov 2022 19:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE853C433D6;
        Thu, 17 Nov 2022 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668713428;
        bh=/blrO8LaQYQKnZIOJeb1Gf4UcQ7XbfmTDDnf9fIps2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=If2wmWY8d1Z2gg2PtVwEFk+VkePLgeaEsqU1WLCRulZFPYpYwWZ7rKdpDZdpnkV7K
         o20ID+72smPKFFEffogKmXY7lRJa1a2GQn7c8YmH+Z5YN+6jg+qSNfze3EqHAUcoQo
         lv1QH/sdFeyYe6f18/tm1wBqDDxoRsDC/F8iUrBpDUTQbN2/8xEbVwU1KWlrJ3zpSQ
         BK5RKDxLhku97awQP8VTvcidz3YhyNPeypZ5r+Z9zbidKyF1N22o9wr3Jh82s2o2Dq
         wixdhu5ujeilE3jhGlovOOAmaicl0h4DbAhDYTpwdongZ91NnIutpXUqXqqgK41GxB
         FzFh7Rw6GHXBw==
Date:   Thu, 17 Nov 2022 13:30:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: dwc: pcie-qcom: Add support for SM8550 PCIEs
Message-ID: <20221117193026.GA1203408@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116123505.2760397-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Abel,

Instead of making up your own subject line prefix, please take a look
at the history and make yours match:

  PCI: qcom: Rename host-init error label
  PCI: qcom: Drop unused post_deinit callback
  PCI: qcom: Sort device-id table
  PCI: qcom: Clean up IP configurations
  ...

On Wed, Nov 16, 2022 at 02:35:05PM +0200, Abel Vesa wrote:
> Add compatibles for both PCIe G4 and G3 found on SM8550.
> Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ac28ea8d67d..4a62b2500c1d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -181,7 +181,7 @@ struct qcom_pcie_resources_2_3_3 {
>  
>  /* 6 clocks typically, 7 for sm8250 */
>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[12];
> +	struct clk_bulk_data clks[13];
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> @@ -1206,6 +1206,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[idx++].id = "noc_aggr_4";
>  	res->clks[idx++].id = "noc_aggr_south_sf";
>  	res->clks[idx++].id = "cnoc_qx";
> +	res->clks[idx++].id = "cnoc_pcie_sf_axi";
>  
>  	num_opt_clks = idx - num_clks;
>  	res->num_clks = idx;
> @@ -1752,6 +1753,8 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8550-pcie0", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8550-pcie1", .data = &cfg_1_9_0 },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 
