Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34A519196
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiECWrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 18:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiECWrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 18:47:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631A427FB;
        Tue,  3 May 2022 15:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43153B82225;
        Tue,  3 May 2022 22:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD586C385A9;
        Tue,  3 May 2022 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651617826;
        bh=Z6S2y7SUOakVPhPiGmuDOM2Gy1kVlAWgAuhNi3LGULs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EuRM+xKHtw/nFA9UEqMY8i0S22dY3/CFsn8xt3cAPhCzU7Cb70s7Tjb/tsbOrkfOB
         hmwglyPYxM+Qy7tc1L1Kxs5nHLEwc3tjFDaiSc1vgK2Hu/R6o1NorSbgtht9PIBh3A
         mXoJm8vNgHYoTY6Rj3E5SBK94H3nfJnYJpkd0/DcaZNeW+gERmyBV3BMuXzKtdIkK8
         Ri8g1gkBSP2Cr3AgisBjXoDnEo5iK4/+poNBWnGliVY5boQyktMQfT7ov7jObnJcAh
         DlpCgLsVEaOPLX6mB5fUTqwiAvGEylHMjupQGJBfPeeQJjpNgYZgBXuvSQcE2YbAmG
         IAnGw0zNxZBng==
Date:   Tue, 3 May 2022 17:43:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Remove ddrss_sf_tbu clock from sc8180x
Message-ID: <20220503224343.GA415146@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331013415.592748-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 06:34:15PM -0700, Bjorn Andersson wrote:
> The Qualcomm SC8180X platform was piggy backing on the SM8250
> qcom_pcie_cfg, but the platform doesn't have the ddrss_sf_tbu clock, so
> it now fails to probe due to the missing clock.
> 
> Give SC8180X its own qcom_pcie_cfg, without the ddrss_sf_tbu flag set.
> 
> Fixes: 0614f98bbb9f ("PCI: qcom: Add ddrss_sf_tbu flag")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Since this fixes a regression that we added in v5.18-rc1, I applied
this to for-linus for v5.18.  Thanks!

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab90891801d..816028c0f6ed 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1550,6 +1550,11 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.pipe_clk_need_muxing = true,
>  };
>  
> +static const struct qcom_pcie_cfg sc8180x_cfg = {
> +	.ops = &ops_1_9_0,
> +	.has_tbu_clk = true,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1656,7 +1661,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>  	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
> -	{ .compatible = "qcom,pcie-sc8180x", .data = &sm8250_cfg },
> +	{ .compatible = "qcom,pcie-sc8180x", .data = &sc8180x_cfg },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &sm8450_pcie0_cfg },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &sm8450_pcie1_cfg },
>  	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
> -- 
> 2.35.1
> 
