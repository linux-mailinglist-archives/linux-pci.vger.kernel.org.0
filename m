Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7ED47E55C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhLWPOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 10:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhLWPOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 10:14:14 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2EC061401
        for <linux-pci@vger.kernel.org>; Thu, 23 Dec 2021 07:14:14 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m18so4665425qtk.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Dec 2021 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/trXJx8RMPAN3LWudnaUQxfD3uy1w2bAsHfBMgTUD4=;
        b=fRFCt19eMNuoU6PtktXS7n1jOThMCMfDUdupLVqGWLLRLo37s/AnQ6Fy5/pHuxQUd6
         zgx1aHowl6rAzUxtffE+zbjOdfcezueIRzTm2vLPGFHg64asQp1rBfZmzfqdnlWiEaK/
         5y/MsoJA7Bm/fL9BtN5O/6oeIAapMuMeEuuLTZQEm+hqPlCu80Td+bYNqjFMC+Dpg7rW
         mZkmTMBMKpTsY61ma0kPQrkKHCrZCjgP9oXwO0yJjxgkriQioWZvyff6+eZw/+yPS8dS
         m1vKZJAGjPm5JdGB88cFB28/Q304zxS5JbN+DFl8dIplqLvoxM9rqMgOddej7TGjdPPN
         b83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/trXJx8RMPAN3LWudnaUQxfD3uy1w2bAsHfBMgTUD4=;
        b=l0OHoYrlWuEcbYTAEofl7CT1IxJ85MzNHvaCSoIAt8pI/+oMmhaDvM8QkP7wlDHzpP
         GZJVl3+v0aR7Msd4Lk5+jBrI8D6P3KJgGIZa4Yk3AQax8BTA2q4IhoaFL7APX0rx5RhG
         UrsemF04Pr8abs6edl8PSuoZBtLRwdnbHbMlq0SfQRFwAA9+0fh2m6vthYkCS9VDxVuy
         MN85GcGNnxnh8C2VjqDcdojW02hO7gPk/0KnGccf62I1Y3VnvqsdIwbh/ZbOMp1ZLNVh
         pzm1zzlhSmzf666KwZUDsUnn/5KCU81rNRXJiqc/CiA+RPqoHYpzWZhGWyNXvCz9c5z1
         a6sw==
X-Gm-Message-State: AOAM533C8q2a7oA7qtW7XVJEykYaBjrOWVpH+5KXVzSwNHYLkJ8idka1
        WWcLwt3TPorQKF3RGlj4n5hAWkp3BUNawJtscepSLg==
X-Google-Smtp-Source: ABdhPJzo5jfo5EIyTNbDJSgwmDIgON2Qh/6AVrAP6YjCcBIc4AmF0ZPAPrBaCJHusO72lnkIuFbgN/2EcyzhZHf4g8k=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr2039424qtr.72.1640272453114;
 Thu, 23 Dec 2021 07:14:13 -0800 (PST)
MIME-Version: 1.0
References: <1640189262-9699-1-git-send-email-quic_c_pmaliset@quicinc.com>
In-Reply-To: <1640189262-9699-1-git-send-email-quic_c_pmaliset@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Dec 2021 18:14:02 +0300
Message-ID: <CAA8EJpoq1xPj3nkZfjjviCQdLq-LcMVThTK6HzrW7AdmfebuhA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: qcom: Add system PM support
To:     Prasad Malisetty <quic_c_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 Dec 2021 at 19:08, Prasad Malisetty
<quic_c_pmaliset@quicinc.com> wrote:
>
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
>
> Add suspend_noirq and resume_noirq callbacks to handle
> System suspend and resume in dwc pcie controller driver.
>
> When system suspends, send PME turnoff message to enter
> link into L2 state. Along with powerdown the PHY, disable
> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
> supported and disable the pcie clocks, regulators.

The GDSC stays on, if I'm not mistaken. Is this an expected behaviour
for the suspend procedure?

Also as a side note, the qcom-pcie driver supports a variety of SoCs
from different generations. Which platforms were really tested?
Judging from your patch I suppose that you did not test this on any
non-recent platform.

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
>  #define PCIE20_PARF_Q2A_FLUSH                  0x1AC
>
> +#define PCIE20_PARF_PM_STTS                     0x24
> +
>  #define PCIE20_MISC_CONTROL_1_REG              0x8BC
>  #define DBI_RO_WR_EN                           1
>
> @@ -1616,6 +1618,107 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
> +{
> +       int ret = 0;
> +       u32 val = 0, poll_val = 0;
> +       uint64_t l23_rdy_poll_timeout = 100000;
> +       struct dw_pcie *pci = pcie->pci;
> +       struct device *dev = pci->dev;
> +
> +       val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +       val |= BIT(4);
> +       writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +       ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +                       (poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);
> +       if (!ret)
> +               dev_dbg(dev, "PCIe: PM_Enter_L23 is received\n");
> +       else
> +               dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",
> +                       readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
> +
> +       return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
> +{
> +       struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +       /*Assert the reset of endpoint */
> +       qcom_ep_reset_assert(pcie);
> +
> +       /* Put PHY into POWER DOWN state */
> +       phy_power_off(pcie->phy);
> +
> +       writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +       /* Disable pipe clock */
> +       pcie->ops->post_deinit(pcie);
> +
> +       /* Change GCC_PCIE_1_PIPE_MUXR register to 0x2 for XO as parent */
> +       if (pcie->pipe_clk_need_muxing)
> +               clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> +
> +       /* Disable PCIe clocks and regulators*/
> +       pcie->ops->deinit(pcie);
> +}
> +
> +static int __maybe_unused qcom_pcie_pm_suspend_noirq(struct device *dev)
> +{
> +       int ret = 0;
> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +       struct dw_pcie *pci = pcie->pci;
> +
> +       if (!dw_pcie_link_up(pci)) {
> +               dev_err(dev, "Power has been turned off already\n");
> +               return ret;
> +       }
> +
> +       /* Send PME turnoff msg */
> +       ret = qcom_pcie_send_pme_turnoff_msg(pcie);
> +       if (ret)
> +               return ret;
> +
> +       /* Power down the PHY, disable clock and regulators */
> +       qcom_pcie_host_disable(pcie);
> +
> +       dev_info(dev, "PM: PCI is suspended\n");
> +       return ret;
> +}
> +
> +/* Resume the PCIe link */
> +static int __maybe_unused qcom_pcie_pm_resume_noirq(struct device *dev)
> +{
> +       int ret = 0;
> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +       struct dw_pcie *pci = pcie->pci;
> +       struct pcie_port *pp = &pci->pp;
> +
> +       dev_info(dev, "PM: Resuming\n");
> +
> +       /* Initialize PCIe host */
> +       ret = qcom_pcie_host_init(pp);
> +       if (ret)
> +               dev_err(dev, "cannot initialize host\n");
> +
> +       dw_pcie_iatu_detect(pci);
> +       dw_pcie_setup_rc(pp);
> +
> +       /* Start the PCIe link */
> +       qcom_pcie_start_link(pci);
> +
> +       ret = dw_pcie_wait_for_link(pci);
> +       if (ret)
> +               dev_err(dev, "Link never came up, Resume failed\n");
> +
> +       return ret;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend_noirq, qcom_pcie_pm_resume_noirq)
> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>         { .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>         { .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
With best wishes
Dmitry
