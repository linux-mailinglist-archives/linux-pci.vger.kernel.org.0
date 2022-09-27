Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8F5EBCFC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiI0IRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiI0IQw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 04:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72183641F;
        Tue, 27 Sep 2022 01:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7487DB80AD9;
        Tue, 27 Sep 2022 08:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10349C433D6;
        Tue, 27 Sep 2022 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664266545;
        bh=FZg9AeA4UkTjA9OnzBdxptxRWgoL9SJpqAjfj4pKr3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejt/WDlhvbW7IshGeu75MCmsOm40K41R3CDOoQghaHktP17AgJSasPWj16YGGw6SF
         K5adwvapO82uaItX2QKgd88GvG4W0T1btP+QHGLKpu5E21+o9Eg0Rtds0oWtIcVmwA
         mkr6oWcagEdGA7fHMeni8kMXZkXM//1Fqe8aw3UWPHtAtZ1BuQpH6CcCxLQcHEh+1J
         Rf3HRAAol/epRnUjX57UkCuvu1A9E52ybhstYKvHe6VjzDXd3CWoPyc9Q96srtLsZi
         VizEwd2uxvMxUzP5LvvJ1voVArDj9orKbORSTpu0xq2FPN2lBoXAZKhLqTt0MsTdsF
         vzf6si6ftNSzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1od5kt-0005Vu-1E; Tue, 27 Sep 2022 10:15:51 +0200
Date:   Tue, 27 Sep 2022 10:15:51 +0200
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
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 4/5] PCI: qcom: Setup PHY to work in RC mode
Message-ID: <YzKxN/tyt/yY3RoZ@hovoldconsulting.com>
References: <20220926173435.881688-1-dmitry.baryshkov@linaro.org>
 <20220926173435.881688-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926173435.881688-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 08:34:34PM +0300, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the RC mode.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

I believe you forgot to add Jingoo Han's tag:

	https://lore.kernel.org/all/CAPOBaE548e669mbg5vM+ZoAgOz+g4eKRRODcRXRX-r+cdMf1yQ@mail.gmail.com/

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
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

Johan
