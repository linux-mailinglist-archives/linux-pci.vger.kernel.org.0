Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5952B761
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiERJxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiERJxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 05:53:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674155235;
        Wed, 18 May 2022 02:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37D85B81E9F;
        Wed, 18 May 2022 09:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E835DC385A5;
        Wed, 18 May 2022 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652867577;
        bh=Et2W7y8NJvxpwiLd4zH+9CgPsuoRcz9snyrXRRHp7bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlmmF04YeJ1HO0mj0AtLRH2ln5V/AX/Ys7yMtbWIvMA2ES66u7yrH8lwnE0mX1Yhm
         poKjsn1NqPsiUbChrhjy390RqCWXme4IsL6xBnoBDzOvssfWZ3pt5NERxy4HcAEoXE
         to4GhaBXNR2R+9Yj1Zcxj4r/tGLOw/ClNd3iMJ25AiEXUxkuti/2byVeZ+r8Fcwf2p
         oXGfctOhCNE/t7j2VDsRF0kDocdgly7nz9O0496arjawq7usvZvkYMHd3DnjFjd/MS
         eMzejn/QwTYbRwUDS4QkHtN22WuA7UqXPEvSVtVUEuBVczabd+J6QzFOCM/8F4Zbdc
         XU2qM4Ex0g1Wg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrGMT-0003Y7-3z; Wed, 18 May 2022 11:52:57 +0200
Date:   Wed, 18 May 2022 11:52:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 08/10] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <YoTB+Rr726BjxdHx@hovoldconsulting.com>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513172622.2968887-9-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:26:20PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Thus, to receive higher MSI vectors properly,
> declare that the host should use split MSI IRQ handling on these
> platforms.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2e5464edc36e..f79752d1d680 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -194,6 +194,7 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	unsigned int has_split_msi_irq:1;
>  	unsigned int pipe_clk_need_muxing:1;
>  	unsigned int has_tbu_clk:1;
>  	unsigned int has_ddrss_sf_tbu_clk:1;
> @@ -1502,6 +1503,7 @@ static const struct qcom_pcie_cfg ipq8064_cfg = {
>  
>  static const struct qcom_pcie_cfg msm8996_cfg = {
>  	.ops = &ops_2_3_2,
> +	.has_split_msi_irq = true,
>  };

> @@ -1592,6 +1599,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->cfg = pcie_cfg;
>  
> +	if (pcie->cfg->has_split_msi_irq) {
> +		pp->num_vectors = MAX_MSI_IRQS;
> +		pp->has_split_msi_irq = true;
> +	}
> +
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
>  		ret = PTR_ERR(pcie->reset);

So if you fix dwc core to always infer num_vectors when passed in as 0
as I just suggested, then this patch isn't needed.

It also avoids having to pass in MAX_MSI_IRQS (or complicate the qcom
driver) for sc8280xp which only uses four "msi" GIC interrupts and hence
only MAX_MSI_IRQS/2 vectors.

Johan
