Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824775EBEC8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiI0Jhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0Jhi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC6989803;
        Tue, 27 Sep 2022 02:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF4156177E;
        Tue, 27 Sep 2022 09:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB39C433B5;
        Tue, 27 Sep 2022 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664271456;
        bh=p2vBPOpbBwRX23lt8ghHeq7yQEMpQ7ksH9q0XvT2WhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNEnoyA+g0pLKai+7ZujdIJf3xVouN3Mp1bHE+uNmWiU9sJKvkqVcvh7N4PpAEdba
         rkeVDQKVeD4PHjdwuZu1UDvR0Z6IIb4AHHmLsjltBRINtxEaDwYy5flXiZoQLgRSKf
         0xD3K9SL9abiuV2dMD1nDMiU+IGez8TaLgfgV/PopIfyFB3kwDIxUZPky5BgUeET/W
         +mIFMSFkkA4SSo+x5N3p6ikCMz2wCKwz9pAIm+AdTrPCzJ8V64vFLtIzBSWq2zxgoK
         CKPijR1hsQu2KTyz7oY9gmhsSqLGbtrEc3MGOSzY9CS0OEh+CoXtcqJP6fd+02ZP3M
         fwP0CtGIi5nKw==
Date:   Tue, 27 Sep 2022 11:37:28 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
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
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 5/5] PCI: qcom-ep: Setup PHY to work in EP mode
Message-ID: <YzLEWOFV9Iy3KSVL@lpieralisi>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
 <20220927092207.161501-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927092207.161501-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 12:22:06PM +0300, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the EP mode.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index ec99116ad05c..8dcfeed24424 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -240,6 +241,10 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  	if (ret)
>  		goto err_disable_clk;
>  
> +	ret = phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);
> +	if (ret)
> +		goto err_phy_exit;
> +
>  	ret = phy_power_on(pcie_ep->phy);
>  	if (ret)
>  		goto err_phy_exit;
> -- 
> 2.35.1
> 
