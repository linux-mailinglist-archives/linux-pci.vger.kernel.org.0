Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609914A641B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiBASjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiBASjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 13:39:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790BCC061714;
        Tue,  1 Feb 2022 10:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83991B82F43;
        Tue,  1 Feb 2022 18:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C70EC340EB;
        Tue,  1 Feb 2022 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643740754;
        bh=8z51N/DJx2T9IZBKLAJUpdHtDXlaBB892mPnUtwsAQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k5lepYiVq+QONvRWemSETVG+HaTcv8zcqOu7zP5adFD7H6vA2aVadGowfyQeEhfx0
         SRjRJbHNYNe+8o489Y06zASvNxRFqPhIgIdQWoYchx5mWSR91M95IczqCFnJAoaEYI
         G8xsTItS9KoI/7Y2n6aqkyg5QUJpBStOuScBWWkv7xkw4XxUFG+BIVroweBA4yKd+A
         A7ISV1AX8h3W+ngjwuhGB6F1bhRz1CxiYxb6Pm607tmxyNN6CYfhavPRtbnw6QkY94
         4/VVaiLIQPN97CSiWmnj9CAVnJ2oP6tDjnehkmaDJXWUGPY5bMKd1uArLiFz7poCU6
         x12BqMM36mbyg==
Date:   Tue, 1 Feb 2022 12:39:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org
Subject: Re: [PATCH v2] PCI: qcom: Add system PM support
Message-ID: <20220201183912.GA583363@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643738876-18572-1-git-send-email-quic_pmaliset@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 11:37:56PM +0530, Prasad Malisetty wrote:
> Add suspend_noirq and resume_noirq callbacks to handle
> System suspend and resume in dwc pcie controller driver.

s/System/system/
s/pcie/PCIe/ as you did below.

> When system suspends, send PME turnoff message to enter
> link into L2 state. Along with powerdown the PHY, disable
> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
> supported and disable the pcie clocks, regulators.
> 
> When system resumes, PCIe link will be re-established and
> setup rc settings.
> 
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot reported the lack of system power management?
I'm impressed ;)  I doubt this "Reported-by" is useful.  If it *is*,
please include a link to the report.

> ---
> Changes since v1:
> 	- Removed unnecessary logs and modified log level suggested by Manivannan.
> 	- Removed platform specific callbacks as PM support is generic.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c19cd506..d1dd6c7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -73,6 +73,8 @@
>  
>  #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>  
> +#define PCIE20_PARF_PM_STTS                     0x24

Indent with tabs (not spaces) as the surrounding code does.

>  #define PCIE20_MISC_CONTROL_1_REG		0x8BC
>  #define DBI_RO_WR_EN				1
>  
> @@ -1616,6 +1618,100 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
> +{
> +	int ret = 0;

Drop unnecessary init.

> +	u32 val = 0, poll_val = 0;

Drop unnecessary "val" init.

> +	u64 l23_rdy_poll_timeout = 100000;

Add "microseconds" comment.

> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |= BIT(4);
> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +			(poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);
> +	if (!ret)
> +		dev_info(dev, "PM_Enter_L23 is received\n");
> +	else
> +		dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",
> +			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;

qcom_pcie_host_disable() is called from qcom_pcie_pm_suspend_noirq(),
which is used for all qcom devices.  But it looks like not all qcom
devices have 2_7_0 resources.  Is this supposed to be used only on
certain revisions?

> +
> +	/* Assert the reset of endpoint */

Superfluous comment, since the function name says the same thing.

> +	qcom_ep_reset_assert(pcie);
> +
> +	/* Put PHY into POWER DOWN state */
> +	phy_power_off(pcie->phy);
> +
> +	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	pcie->ops->post_deinit(pcie);
> +
> +	/* Disable PCIe clocks and regulators */
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
> +		dev_dbg(dev, "Power has been turned off already\n");
> +		return ret;

"return 0" here and drop the init above.

> +	}
> +
> +	/* Send PME turnoff msg */

Superfluous comment.

> +	ret = qcom_pcie_send_pme_turnoff_msg(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* Power down the PHY, disable clock and regulators */
> +	qcom_pcie_host_disable(pcie);
> +
> +	return ret;

"return 0" here.

> +}
> +
> +/* Resume the PCIe link */
> +static int __maybe_unused qcom_pcie_pm_resume_noirq(struct device *dev)
> +{
> +	int ret = 0;

Drop unnecessary init.

> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +
> +	/* Initialize PCIe host */

Superfluous comment.

> +	ret = qcom_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "cannot initialize host\n");
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	/* Start the PCIe link */

Superfluous comment.

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
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend_noirq, qcom_pcie_pm_resume_noirq)

qcom_pcie_pm_suspend_noirq() and qcom_pcie_pm_resume_noirq() look
nothing like their counterparts in dra7xx, exynos, imx6, intel-gw.
Any chance you could make them more similar?

> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> @@ -1648,6 +1744,7 @@ static struct platform_driver qcom_pcie_driver = {
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
