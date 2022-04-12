Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434474FCF42
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiDLGEL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiDLGEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 02:04:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182A35258
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 23:01:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so15880203plh.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/YOCAjhAHv2lvKAFeDt5NfU8iXiO8qQfDVTqrQ/gFE=;
        b=fpNZ0mzd5Uz1/wOHqP2tQm7gWP3oiIsCPMhulHS+QY5Z43J0L+DcaHSKYjQxr37Gvn
         A82+YiHdXs3xHJvcJyF4wYhsJnphMF09OU4oNfzZ5+58w5hoKbAikxYEKMczd6uavRHo
         RNczV5OZWOd8T3WAr1iGZ/MLyPNiVvC8mfYKK5mVmqrABiHRO33A5HhrePicpYDRifn9
         JBXFqzz/Ce6daN9C3+ldfXf6KxslhWOSG+fRKhnUVw1UzslnELaOJ5hzv9dwhxgDFJGV
         g9ioaSTa00Ta3jVphR/2A6ZY4OpFIlaUMhSSLHA+B0mh/4aBjmCYnIxrFp3ICzDExyCz
         AnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/YOCAjhAHv2lvKAFeDt5NfU8iXiO8qQfDVTqrQ/gFE=;
        b=B4R8DU4x7wuTbn5W/eN6aSzHH1jeNo6zT4u6QNvA+bsZ3FeB8PhKOEIY3uMOvyj1JQ
         HlVa81z94la5IrD3vZSPGFfZMTrd7F90DyOh5wDTkBU7hspWgiCB1PK7WzW7cugMfwkO
         WehjSlyN2a0VFtSnpbu6sci0uemwomzxjHepXk4c52RYiZAnykKGyeWufj4wjL0Fb/jf
         PPDs1JfvDUV77qAMbR4djCBE5UcYTAenm3DKmpl3E57+D6W4Fl7shceWY+lJRRKpIHbG
         i6ljg3tmOjDoxRpmiz3x1zbO/SKSdmfvJ8Uf7gAgWbLXbZNE5U9CZTOM8aCbo6oyMLFW
         xPaQ==
X-Gm-Message-State: AOAM530uPAuaTqsgn0sq3KE0VvQeWdpBRXJhxwjLFrbLpVF8KwMI/lM9
        CTHNaj/hCwbE0eR7hqc1xQpg
X-Google-Smtp-Source: ABdhPJxlOfzESPT/WhDfYou19tlQBGdl1MTtSeYV9NOhETewxv5XFvPG3lwPaxmJv2M2O7RRu10mvg==
X-Received: by 2002:a17:90a:a090:b0:1cb:a443:f19c with SMTP id r16-20020a17090aa09000b001cba443f19cmr3189402pjp.135.1649743312855;
        Mon, 11 Apr 2022 23:01:52 -0700 (PDT)
Received: from thinkpad ([117.217.182.140])
        by smtp.gmail.com with ESMTPSA id b184-20020a62cfc1000000b0050600ab6e26sm648096pfg.187.2022.04.11.23.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:01:52 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:31:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4] PCI: qcom: Add system PM support
Message-ID: <20220412060144.GA41348@thinkpad>
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

+Kalle, linux-wireless

On Tue, Mar 08, 2022 at 12:25:06AM +0530, Prasad Malisetty wrote:
> Add suspend_noirq and resume_noirq callbacks to handle
> system suspend and resume in dwc PCIe controller driver.
> 
> When system suspends, send PME turnoff message to enter
> link into L2 state. Along with powerdown the PHY, disable
> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
> supported and disable the pcie clocks, regulators.
> 

Kalle, is this behaviour appropriate for WLAN devices as well? The devices
will be put into poweroff state (assuming no Vaux provided in D3cold) during
system suspend.

Thanks,
Mani

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
> +		return 0;
> +	}
> +
> +	ret = qcom_pcie_send_pme_turnoff_msg(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* Power down the PHY, disable clock and regulators */
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
