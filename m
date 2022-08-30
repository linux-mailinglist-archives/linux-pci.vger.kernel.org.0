Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29DB5A5CBB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiH3HSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiH3HSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5D9C652F;
        Tue, 30 Aug 2022 00:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39F6261495;
        Tue, 30 Aug 2022 07:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB27C433C1;
        Tue, 30 Aug 2022 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661843880;
        bh=8YpYFHpRZlcXniKh+3stt8dUFwztey2Ae9xNZ/I5eLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEkvZandQOHZD9JTmh7WCNlH8uImDGJLbBBj/3+Vymv4FviUJtP0Lm/V66nUZaTTm
         N+/ZtmJdwXsGyJEusxLDoF+Xqat/BaNe/RI3ji5U4bVStwvBfKKYKeEY/OyIp9irXO
         PJLzu8GQ19Q/RY+Vo6FEiPBZpwGdk2IsVcNhraOZtK6BrdE2smqFN9ZiFD1wPghcEy
         M8vZP+RMlcFurwLQL/P6Rm9s0U6ImRa2ptWYrY+h8aJsAyq+kpU7hGE+6dgje9ytVa
         qUjXxtUXVJTHuoGgcxVuS25c1W+roYGmV34snPGdvu5LrLB6VwPr6wctiybGNmPPmS
         qrTdzNGsXRJtw==
Date:   Tue, 30 Aug 2022 12:47:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 5/6] PCI: qcom-ep: Setup PHY to work in EP mode
Message-ID: <Yw25pB6j5w6so8tx@matsya>
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
 <20220825105044.636209-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825105044.636209-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25-08-22, 13:50, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the EP mode.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index ec99116ad05c..d17b255a909d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -240,6 +240,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  	if (ret)
>  		goto err_disable_clk;
>  
> +	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, 1);

please define 1 or 0, rather than magic values

> +	if (ret)
> +		goto err_phy_exit;
> +
>  	ret = phy_power_on(pcie_ep->phy);
>  	if (ret)
>  		goto err_phy_exit;
> -- 
> 2.35.1

-- 
~Vinod
