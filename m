Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F45B402A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIITuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIITuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 15:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF81175;
        Fri,  9 Sep 2022 12:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B951620BB;
        Fri,  9 Sep 2022 19:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B50C433D6;
        Fri,  9 Sep 2022 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662753002;
        bh=F7kLYAOyID8b4W20ikdeJig6vjP4JJ/Pm2hNCRIAW9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XCZQUTN/G9k5cyKWKTeZc1qiKg8q6ZdeqADwF49rEHr06p8J6XSMZ3Xx3xJVdlQFF
         D/Nmv79P0uCzFWZiE+VldeSXVzp9hfPRsOzOm7bWotFcMOSOgwpcvuigRqowleBcxf
         fhU8u02/zil7JZzs/YAod7aDK23m8vHlYlexJuXDZUQ4BDHFECo6a/wz2a/KOCb83W
         2sT75SJt55NB7KuBmaKX/tRidAMQbc/DsuHq5BCbaqgUUaATjcG5W0lgL/JJBzXM3/
         oz7mXmXKuvrHr74HDvaFmfu5gOhaQbLetD/4KUJ61UvBicx7Tf5BTdQqxvu8KYGZdv
         TRp/eOiT9ojYQ==
Date:   Fri, 9 Sep 2022 14:50:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 2/5] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Message-ID: <20220909195000.GA310621@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662713084-8106-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 02:14:41PM +0530, Krishna chaitanya chundru wrote:
> Some specific devices are taking time to settle the link in L1ss.
> So added a retry logic before returning from the suspend op.

"L1ss" is not a state.  If you mean "L1.1" or "L1.2", say that.  Also
in code comments below.

s/So added a/Add/

What are these specific devices?  Is this a qcom controller defect?
An endpoint defect that should be addressed via some kind of generic
quirk?

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6e04d0d..15c2067 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> +	ktime_t timeout, start;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
>  
>  	if (!pcie->cfg->supports_system_suspend)
>  		return 0;
>  
> -	/* if the link is not active turn off clocks */
> -	if (!dw_pcie_link_up(pci)) {
> -		dev_info(dev, "Link is not active\n");
> -		goto suspend;
> -	}
> +	start = ktime_get();
> +	/* Wait max 200 ms */
> +	timeout = ktime_add_ms(start, 200);
>  
> -	/* if the link is not in l1ss don't turn off clocks */
> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> -		dev_warn(dev, "Link is not in L1ss\n");
> -		return 0;
> +	while (1) {
> +
> +		if (!dw_pcie_link_up(pci)) {
> +			dev_warn(dev, "Link is not active\n");
> +			break;
> +		}
> +
> +		/* if the link is not in l1ss don't turn off clocks */
> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> +			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
> +					ktime_to_ms(ktime_get() - start));
> +			break;
> +		}
> +
> +		if (ktime_after(ktime_get(), timeout)) {
> +			dev_warn(dev, "Link is not in L1ss\n");
> +			return 0;
> +		}
> +
> +		udelay(1000);
>  	}
>  
> -suspend:
>  	if (pcie->cfg->ops->suspend)
>  		pcie->cfg->ops->suspend(pcie);
>  
> -- 
> 2.7.4
> 
