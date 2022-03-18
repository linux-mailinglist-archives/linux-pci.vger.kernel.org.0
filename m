Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23B14DDBBE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 15:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiCROf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiCROf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 10:35:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D62D4D4A
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 07:34:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so4672863pjm.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=An29DlOhwyywWM/0aNvAUk8ND1vXD1la3RvLhYP8lEQ=;
        b=UVb5VWQS5BSfYyR2Prb8yeaH36dZnLfCYyT+KtIS2wpMhv3oFxfjmRgyzXq2ZaDakG
         PBFk757tKQnvNgN0H1TQEpkxcqP2rmFegKXLB+g0ToEwhv2mFlGIn+EZmE9cD2njB8s7
         s9RF3K+yE+rabFL/pc/IAUggeGEa86oN3m16lh/u/hX4lNlap+h5vIEHsgKlNf+p6GK0
         221PF4Pt/1rOccpYVkCjvjkzbAAop/6zV1KZOGxzeJya/IJhOnWU3NiWpI/RvGC2Vz6q
         GPyF8wz1aaifCohB49+1rPgj04/9ymFt8LhVIkQdAmude92xN3ljzboGAMUxxdlAnAcF
         YU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=An29DlOhwyywWM/0aNvAUk8ND1vXD1la3RvLhYP8lEQ=;
        b=g/YD5tg6GQ6tYyvyYkNedl8N7Aqv9eg7bXy5uejffX8oYl/i9znysLgXeAG1rvD14r
         ai8I4EoPT5x5pBLEuXfk7iqse3MFXNdTNOnvw9uiGhbCrSq9BamrixYXSD9S2sZwXzNc
         roopicD/EdeFHzoZcrjr1y3u+UjGDts4zqIPi3cmhIwCfingGrrjoIVQYWFXzYtW3ylk
         YMwDsXtHF21rVxqDkxohZJMkLYK3ePtyrGl03b9cfL12H5D5kTQnhXZAKWSAUe4YpChe
         KWx4gtSQ71Ne5QSmDa+B8H3QnIJoxy482t/OXU57NpI+XfKNlzuW+Zzx4GeiLcbCf43L
         yIZw==
X-Gm-Message-State: AOAM532fn1NXZWY3okWNkkTp0vkVTwCjymjxPN5tADAMi6kqFIQ7TJwc
        m7PWnAIzV3hKtPLJw+nXsmlw
X-Google-Smtp-Source: ABdhPJzfxVLDqnthtDOksvI+hE2Tf0NlsqP5P+fJ3tV3tm7eSkq/8uDtWyFCI7zL5buvoDRqjA0Ypg==
X-Received: by 2002:a17:90b:4b8d:b0:1bf:1301:2514 with SMTP id lr13-20020a17090b4b8d00b001bf13012514mr11485632pjb.19.1647614077029;
        Fri, 18 Mar 2022 07:34:37 -0700 (PDT)
Received: from thinkpad ([117.217.178.61])
        by smtp.gmail.com with ESMTPSA id a24-20020a637f18000000b003821e17819csm2956095pgd.61.2022.03.18.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 07:34:36 -0700 (PDT)
Date:   Fri, 18 Mar 2022 20:04:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org
Subject: Re: [PATCH v4] PCI: qcom: Add system PM support
Message-ID: <20220318143430.GA4922@thinkpad>
References: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 08, 2022 at 12:25:06AM +0530, Prasad Malisetty wrote:
> Add suspend_noirq and resume_noirq callbacks to handle
> system suspend and resume in dwc PCIe controller driver.
> 
> When system suspends, send PME turnoff message to enter
> link into L2 state. Along with powerdown the PHY, disable
> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
> supported and disable the pcie clocks, regulators.
> 
> When system resumes, PCIe link will be re-established and
> setup rc settings.
> 
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> ---
> Changes since v3:
> 	- Replaced noirq hooks with normal suspend/resume hooks.
> 	- Removed local variable and placed in function itself.
> 
> Changes since v2:
> 	- Removed unnecessary variable initializations and comments.
> 	- Removed platform specific variables declarations.
> 	- Added MACRO names for the BIT shiftings.
> 
> Changes since v1:
> 	- Removed unnecessary logs and modified log level suggested by Manivannan.
> 	- Removed platform specific callbacks as PM support is generic.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..4d29c80 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -48,6 +48,7 @@
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PHY_REFCLK_SSP_EN			BIT(16)
>  #define PHY_REFCLK_USE_PAD			BIT(12)
> +#define PHY_POWER_DOWN				0x1

BIT(0)

>  
>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> @@ -62,6 +63,8 @@
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> +#define PCIE_PME_TURNOFF_MSG			BIT(4)
> +#define PCIE_PM_LINKST_IN_L2			BIT(5)
>  
>  #define PCIE20_AXI_MSTR_RESP_COMP_CTRL0		0x818
>  #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
> @@ -73,6 +76,8 @@
>  
>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>  
> +#define PCIE20_PARF_PM_STTS			0x24
> +
>  #define PCIE20_MISC_CONTROL_1_REG		0x8BC
>  #define DBI_RO_WR_EN				1
>  
> @@ -1645,6 +1650,97 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
> +{
> +	int ret;
> +	u32 val, poll_val;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |= PCIE_PME_TURNOFF_MSG;
> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +			(poll_val & PCIE_PM_LINKST_IN_L2),
> +			10000, 100000);
> +	if (!ret)
> +		dev_dbg(dev, "Device entered L23_Ready state\n");
> +	else
> +		dev_err(dev, "Device failed to enter L23_Ready. PM_STTS 0x%x\n",
> +			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
> +{
> +	qcom_ep_reset_assert(pcie);
> +

In the modem usecase, the endpoint uses the LINK_DOWN event for freeing up the
resources. If PERST# gets asserted before turing off the PHY, the LINK_DOWN
event will be missed in the endpoint. And moreover, modem cannot free up the
resources in PERST# handler as it is a hard IRQ handler and the cleanup action
might sleep. The deferring also doesn't work because, once PERST# event get's
handled, the host will turn off the refclk and the access to DBI region will
not be allowed.

For this reason, I'd prefer to move this PERST# assertion to the end of the
funtion.

> +	/* Put PHY into POWER DOWN state */
> +	phy_power_off(pcie->phy);
> +
> +	writel(PHY_POWER_DOWN, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	if (pcie->cfg->ops->post_deinit)
> +		pcie->cfg->ops->post_deinit(pcie);
> +
> +	/* Disable PCIe clocks and regulators */
> +	pcie->cfg->ops->deinit(pcie);

It is also required to add a 100ms delay here as PERST# reaches quickly before
LINK_DOWN.


	/*
	 * Allow the LINK_DOWN event to reach the endpoint before PERST# assert.
	 * This is required for resource cleanup in the endpoint for modem usecase.
	 */
	usleep_range(50000, 100000);
	qcom_ep_reset_assert(pcie);

> +}
> +
> +static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (!dw_pcie_link_up(pci)) {
> +		dev_dbg(dev, "Power has been turned off already\n");

I think this debug message doesn't add any value, so just skip it.

> +		return 0;
> +	}
> +
> +	ret = qcom_pcie_send_pme_turnoff_msg(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* Power down the PHY, disable clock and regulators */

You are also asserting PERST#.

> +	qcom_pcie_host_disable(pcie);
> +
> +	return 0;
> +}
> +
> +/* Resume the PCIe link */
> +static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
> +{
> +	int ret;
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +
> +	ret = qcom_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "cannot initialize host\n");
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	qcom_pcie_start_link(pci);
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret) {
> +		dev_err(dev, "Link never came up, Resume failed\n");

dw_pcie_wait_for_link() itself prints the error in failure case. So just return
directly.

	return dw_pcie_wait_for_link(pci);

Thanks,
Mani

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> @@ -1679,6 +1775,7 @@ static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
>  	.driver = {
>  		.name = "qcom-pcie",
> +		.pm = &qcom_pcie_pm_ops,
>  		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
>  	},
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
