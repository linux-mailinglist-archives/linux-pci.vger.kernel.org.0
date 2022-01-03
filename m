Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BC3482E9E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 08:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiACHEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 02:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiACHEV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 02:04:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE0FC061784
        for <linux-pci@vger.kernel.org>; Sun,  2 Jan 2022 23:04:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c3so11081907pls.5
        for <linux-pci@vger.kernel.org>; Sun, 02 Jan 2022 23:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/DcmRLt7Z7G5djRntAe/G4dE78B3/xaF0U4jWKYBNfU=;
        b=S03Z1TYbHIQK2DDj4RC9zWScJNEovt8TyEK6zbMLiOB2qW5cI4OG96W0UAkSq63cN6
         yNyLNV9J7XJQ/1PPXj330SIdUPKbHddPJZG1BSK/pncC6VNsFoSrmcpJKOqgQPTcLG5/
         OAU9Y4UkUX9y3cbHBOEnO6foHfq/j/uWCKIttgmx7McyfeW1L5S806sQgzkKXel1EBX+
         uUYUVz1pzMCI0mhobreeIxic6v92QURpSqLGNkNC66Hx7YU9s7hGmVcspE7Ui7Z2Ova+
         0TMyTOAzbbL+f8wtusgn0IDnZwUUeFWLGt1rkPSorkKOIuk1rSRskYvI9iWewPLEIfk7
         UbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/DcmRLt7Z7G5djRntAe/G4dE78B3/xaF0U4jWKYBNfU=;
        b=R6I780YrR/9ItuJeWQuGs/hFtTl7JULC+nKT3Ec40pkIbTmH/dPduM1q8WordfYka6
         QNKL/T0iv+8pumklp7O1oo/zj0tokIJf3K0otb6XlHUEgjmk2vQ3cYDewsEfQEWYSjS+
         XtdlDVdYRTG2ecyyyJzEzd0195+f+1xcxbVkYkpqkX3UgvA7BWVgEtEo0+Ckfm3Q3kuH
         9Tqh2HRaRcD15xzuE78E1CRRBaCe0rNfRraa8PzWMK02CYQt/g/uIiHd5IzHiOKVOO3O
         XIPbzrdT0f2KnV00DgQ2sl/aJcnWih4VyKWWZnI16O52xbQUl5w9/2oRFYmzPAHHTTqe
         o5Pw==
X-Gm-Message-State: AOAM531dFo+iIrd0L9+J5JS1cOCPH5IAEj26ZFbHqwaRO1+CdxN7tTJz
        TUZXvgZHnrK2NuZXyPhfPLDi
X-Google-Smtp-Source: ABdhPJzsL1FaARo2g5iaQ1zxVxsPpbe1VVSBq3BWkRXwfkNqWPlDdY76phzVncC7tdxM5zRJRMw6PQ==
X-Received: by 2002:a17:902:bd95:b0:149:7cf7:a175 with SMTP id q21-20020a170902bd9500b001497cf7a175mr32538967pls.32.1641193460666;
        Sun, 02 Jan 2022 23:04:20 -0800 (PST)
Received: from thinkpad ([117.202.186.71])
        by smtp.gmail.com with ESMTPSA id x33sm39113586pfh.212.2022.01.02.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 23:04:20 -0800 (PST)
Date:   Mon, 3 Jan 2022 12:34:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Prasad Malisetty <quic_c_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v1] PCI: qcom: Add system PM support
Message-ID: <20220103070412.GD3581@thinkpad>
References: <1640189262-9699-1-git-send-email-quic_c_pmaliset@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640189262-9699-1-git-send-email-quic_c_pmaliset@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 22, 2021 at 09:37:42PM +0530, Prasad Malisetty wrote:
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> Add suspend_noirq and resume_noirq callbacks to handle
> System suspend and resume in dwc pcie controller driver.
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
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 103 +++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c19cd506..24dcf5a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -73,6 +73,8 @@
>  
>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>  
> +#define PCIE20_PARF_PM_STTS                     0x24
> +
>  #define PCIE20_MISC_CONTROL_1_REG		0x8BC
>  #define DBI_RO_WR_EN				1
>  
> @@ -1616,6 +1618,107 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
> +{
> +	int ret = 0;
> +	u32 val = 0, poll_val = 0;
> +	uint64_t l23_rdy_poll_timeout = 100000;

u64?

> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |= BIT(4);

Please define BIT(4)

> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +			(poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);

define BIT(5)

> +	if (!ret)
> +		dev_dbg(dev, "PCIe: PM_Enter_L23 is received\n");

This is not a helpful debug message for an user. And there is no need of "PCIe"
prefix also. Use something like,

dev_dbg(dev, "Device entered L23 link state\n");

> +	else
> +		dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",
> +			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));

dev_dbg(dev, "Device failed to enter L23 link state. PARF_PM_STTS: 0x%x\n",
	readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));

> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +

Why only 2.7.0? This should be generic.

> +	/*Assert the reset of endpoint */

Space after /*

> +	qcom_ep_reset_assert(pcie);
> +
> +	/* Put PHY into POWER DOWN state */
> +	phy_power_off(pcie->phy);
> +
> +	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);

define 1

> +
> +	/* Disable pipe clock */

No need of this comment. As of now only pipe clock is disabled in post_deinit
but it may change in future, so this comment will be outdated.

> +	pcie->ops->post_deinit(pcie);
> +
> +	/* Change GCC_PCIE_1_PIPE_MUXR register to 0x2 for XO as parent */

/* Set pipe clock parent to XO clock if needed */

> +	if (pcie->pipe_clk_need_muxing)
> +		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> +
> +	/* Disable PCIe clocks and regulators*/

Space before */

> +	pcie->ops->deinit(pcie);
> +}
> +
> +static int __maybe_unused qcom_pcie_pm_suspend_noirq(struct device *dev)
> +{
> +	int ret = 0;
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (!dw_pcie_link_up(pci)) {
> +		dev_err(dev, "Power has been turned off already\n");

This should be dev_dbg()

> +		return ret;
> +	}
> +
> +	/* Send PME turnoff msg */
> +	ret = qcom_pcie_send_pme_turnoff_msg(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* Power down the PHY, disable clock and regulators */
> +	qcom_pcie_host_disable(pcie);
> +
> +	dev_info(dev, "PM: PCI is suspended\n");

This is not needed.

> +	return ret;
> +}
> +
> +/* Resume the PCIe link */
> +static int __maybe_unused qcom_pcie_pm_resume_noirq(struct device *dev)
> +{
> +	int ret = 0;
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +
> +	dev_info(dev, "PM: Resuming\n");

Again, no need of this.

> +
> +	/* Initialize PCIe host */
> +	ret = qcom_pcie_host_init(pp);
> +	if (ret)
> +		dev_err(dev, "cannot initialize host\n");

Can the below functions succeed if host_init fails?

> +
> +	dw_pcie_iatu_detect(pci);

Why this is needed? This is a static info of the PCI controller and not supposed
to change.

> +	dw_pcie_setup_rc(pp);
> +
> +	/* Start the PCIe link */
> +	qcom_pcie_start_link(pci);
> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		dev_err(dev, "Link never came up, Resume failed\n");
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {

Why is this struct not used?

Thanks,
Mani

> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend_noirq, qcom_pcie_pm_resume_noirq)
> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
