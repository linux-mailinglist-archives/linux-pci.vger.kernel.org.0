Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EF5E88AF
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiIXGFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 02:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiIXGFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 02:05:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13592167E9;
        Fri, 23 Sep 2022 23:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F5E8CE0A15;
        Sat, 24 Sep 2022 06:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB866C433D6;
        Sat, 24 Sep 2022 06:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663999530;
        bh=z+2uv0GCMfjn23y+jKd2Dac1bjrAV1YxyeF03IjsD74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZjLoLitrZwanLv9L0jIL+nV+9Ya9qEFGWUWy27hKSVJpZa+29vM5DF9rA3FaL3or
         7zsPfJADlf/RUSLQtURU92gpR37+qIP/IkOj67VVu1zq2gYo/cT/9+KdHEoZHtlGlI
         9ZLgTfEBLKvAXxQV05XGjcqqOms7RT1jmlKbQMP3l+P2JKDnusaL/l8+1VVV5r0SmI
         n60Qn/rhAAbHzMJmOVHAgE727F9f7rC9LYk9ZeErOtqkrFRltjFOYV4pDwTl6quCCt
         E0/H180c+sinkSn7wbo8l511+aGr+oGGkBt7aNs+iomeu9QZ5wN8dnfc+qizyqad3q
         KBlPE0/oMjUdA==
Date:   Sat, 24 Sep 2022 11:35:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, svarbanov@mm-sol.com,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v7 2/5] PCI: qcom: Add retry logic for link to be stable
 in either L1.1 or L1.2
Message-ID: <Yy6eJnXUMZk4i2PC@matsya>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
 <1663669347-29308-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663669347-29308-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-09-22, 15:52, Krishna chaitanya chundru wrote:
> When link is in L1ss(L1.1 or L1.2), all the clocks will gate off and there
> will be no activity on the link. At that point clocks and phy
> can be turned off. If clocks got disabled before link enters
> L1ss the PCIe link goes down.
> 
> Few endpoints are taking time more time to settle the link in L1 substates.
> When we check the traffic in protocol analyzer, we see some DLLP packets
> going on still. So Wait for max time of 200ms for the link to be stable in
> L1 substates.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> changes since v6:
> 	- updated comments.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 46 ++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3f5424a..7a6f69e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1809,23 +1809,47 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> +	ktime_t timeout, start;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
>  
> -	/* if the link is not active turn off clocks */
> -	if (!dw_pcie_link_up(pci)) {
> -		dev_dbg(dev, "Link is not active\n");
> -		goto suspend;
> -	}
> +	/*
> +	 * When link is in L1ss, all the clocks will gate off and
> +	 * there will be no activity on the link. At that point clocks
> +	 * and phy can be turned off. If clocks got disabled before
> +	 * link enters L1ss the PCIe link goes down.
> +	 *
> +	 * Few endpoints are taking time more time to settle the link
> +	 * in L1ss. Wait for max of 200ms for the link to be stable in
> +	 * L1ss.
> +	 */
> +	start = ktime_get();
> +	/* Wait max 200 ms */
> +	timeout = ktime_add_ms(start, 200);
> +
> +	while (1) {
> +		/* if the liink is not active turn off clocks */
> +		if (!dw_pcie_link_up(pci)) {
> +			dev_dbg(dev, "Link is not active\n");
> +			break;
> +		}
>  
> -	/* if the link is not in l1ss don't turn off clocks */
> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> -		dev_warn(dev, "Link is not in L1ss\n");
> -		return 0;
> +		/* if the link is not in l1ss don't turn off clocks */
> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> +			dev_dbg(dev, "Link enters L1ss after %lld  ms\n",
> +					ktime_to_ms(ktime_get() - start));
> +			break;
> +		}
> +
> +		if (ktime_after(ktime_get(), timeout)) {
> +			dev_warn(dev, "Link is not in L1ss\n");
> +			return 0;
> +		}
> +

ugh, why not use readl_poll_timeout()?

> +		udelay(1000);
>  	}
>  
> -suspend:
>  	if (pcie->cfg->ops->suspend)
>  		pcie->cfg->ops->suspend(pcie);
>  
> -- 
> 2.7.4

-- 
~Vinod
