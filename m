Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D3526238
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354797AbiEMMoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiEMMnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 08:43:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA6F3B28C;
        Fri, 13 May 2022 05:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 918EAB82F7A;
        Fri, 13 May 2022 12:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACE8C34100;
        Fri, 13 May 2022 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652445776;
        bh=rq4IrFs2KMxDNqB8qpulFwyamBFal8cYbZelR7jrIZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnZ7SMwtjEvLMhQzoq4HfOFsB2S4otPa/pC7IRjkwZN3J0ZnakykwvdPNnn/CTNue
         cuCimYalbGsKDQpmPRBSCrKMuubOFR/9YBPYW+04qgkIjdaaHe0TKjs7F13rUWSv7D
         aFIww71apsYLVXxp3XJzaeSa+lnOIijhdwxI5XidFGAppkmfrIf/4cKcDO7wCoxJ4e
         OcdMGE4yTJVxutkrnfPDPuG7TvlX50Vm7xsFvDUJbonTJUOeIAD6pDggt/w4IXYhgq
         zr4byr9WJ3uyWxbS40TyRF3lHWZcJhOXZLIwxjPKcx+JxTWFpQmBYzH9s1Bxe6Bh7G
         L+1wtoUf/q7sQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npUdA-0002dQ-I5; Fri, 13 May 2022 14:42:53 +0200
Date:   Fri, 13 May 2022 14:42:52 +0200
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
Subject: Re: [PATCH v8 07/10] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <Yn5STCN4smibLubA@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <20220512104545.2204523-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104545.2204523-8-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 01:45:42PM +0300, Dmitry Baryshkov wrote:
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

> @@ -1592,6 +1599,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->cfg = pcie_cfg;
>  
> +	if (pcie->cfg->has_split_msi_irq) {
> +		pp->num_vectors = MAX_MSI_IRQS;
> +		pp->has_split_msi_irq = true;
> +	}

If all qcom platform that can support more than 32 MSI require multiple
IRQs, how about adding num_vectors to the config instead and set
pp->has_split_msi_irq when cfg->num_vectors is set (or unconditionally
if you remove the corresponding warning you just added to the dwc host
code)?

At least some sc8280xp seem to only support 128 MSI (using 4 IRQs).

> +
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
>  		ret = PTR_ERR(pcie->reset);

Johan
