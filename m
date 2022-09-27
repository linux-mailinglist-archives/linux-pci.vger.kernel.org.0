Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BE5EBECB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiI0JiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0JiK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:38:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33189803;
        Tue, 27 Sep 2022 02:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DF57B81AD4;
        Tue, 27 Sep 2022 09:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD41C433D7;
        Tue, 27 Sep 2022 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664271486;
        bh=P6/8gFanwrG3PUCh0iIOJR005WUSOgSKjkfz999zwME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkUWrgNrJ27uPvtqEDRYbbSnzxLrmXMjY7b/NAMfNMw4eUGiT0qHzYnKWXkJZ9EhX
         ECZbRNHQmU5SHiHFqdKKcoCnWRlAWyuuerRP/DTgLqCPYZuUJGvACCfinK62/ro73h
         WHkmnKMKEhbQd+pFSg0CV/eNNoAs5IhkUQkS8ouKapOpiqdWk3lUJb8nm1rS1db7F4
         ORokuMD+tXogogmaR8WdPJKYPaaXnXf3ToA+IvKeldzDmmiJ5P/cfhSesmPFyZ4my7
         pXGqnkoqPaGQr0YuGMW3ao3u2zgViOnqgNBnjUxyS+38YnxyfZMIoHKJ+g1rOeAsJV
         dF0w5SaZODScw==
Date:   Tue, 27 Sep 2022 11:37:59 +0200
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
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 4/5] PCI: qcom: Setup PHY to work in RC mode
Message-ID: <YzLEd16NDm+XXyDG@lpieralisi>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
 <20220927092207.161501-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927092207.161501-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 12:22:05PM +0300, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the RC mode.
> 
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 66886dc6e777..1027281bd6ff 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -1494,6 +1495,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +	if (ret)
> +		goto err_deinit;
> +
>  	ret = phy_power_on(pcie->phy);
>  	if (ret)
>  		goto err_deinit;
> -- 
> 2.35.1
> 
