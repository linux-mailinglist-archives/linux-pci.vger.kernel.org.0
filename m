Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8616C2E59
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 11:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCUKAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCUKAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 06:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE54EC44;
        Tue, 21 Mar 2023 03:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD96B61964;
        Tue, 21 Mar 2023 10:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038A9C433D2;
        Tue, 21 Mar 2023 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679392836;
        bh=yROyHcsha6bspdtVDM6ZLrvNqofqU/Rj5v0b1JMOeUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSShlXiSMzX4U2aX/TzdA1Lm2+ceHH7HlhzCz4JSQ9DkxH0nBo7Zlz5uN5F61VhCS
         tBpsBFe/r3N7JYatYYHKEdlWosbTJJTXST6hon91nrQFcguTyVfSwCDGHxfzhU8UPW
         6Mok6u0vSQ6GGJ2qLPpYMDSrpIhOnBTeoJ1t/4WiJ37Wo51/ivt2bBoE1NZL+LyHkf
         3Yw0dROmIg3WxXwGuw4FGJBRXl/zG+QOszlf7WzdYEzD0zgN8JgeiHr0RzE9kFj2I1
         doIi9akvEwVb+tZ9wdXcJJeNgrwof+UlEY1DiKW9H5Qe1/osXZlVtGoPFC8IDBDD+s
         8gZpdCKQEScSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1peYoZ-0002lW-Gx; Tue, 21 Mar 2023 11:01:59 +0100
Date:   Tue, 21 Mar 2023 11:01:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH v2] PCI: qcom: Add async probe support
Message-ID: <ZBmAl3kW8vmbfyXk@hovoldconsulting.com>
References: <20230320064644.5217-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320064644.5217-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 12:16:44PM +0530, Manivannan Sadhasivam wrote:
> Qcom PCIe RC driver waits for the PHY link to be up during the probe. This
> consumes several milliseconds during boot. So add async probe support so
> that other drivers can load in parallel while this driver waits for the
> link to be up.

You're not really "adding support" for async probe as much as you are
enabling it by default. Perhaps you can clarify that in the commit
summary and commit message (e.g. by rephrasing as "prefer async probe").

> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Rebased on top of v6.3-rc1

With an updated commit message:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..4ca357be88e0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1862,6 +1862,7 @@ static struct platform_driver qcom_pcie_driver = {
>  		.name = "qcom-pcie",
>  		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  builtin_platform_driver(qcom_pcie_driver);

Johan
