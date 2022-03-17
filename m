Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9D4DD081
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiCQWJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 18:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCQWJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 18:09:10 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFE1C9B52
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 15:07:50 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so7066101oig.10
        for <linux-pci@vger.kernel.org>; Thu, 17 Mar 2022 15:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=7a705il38wQNIgcW74B99Zg1pH09khmZyWTP/+DOfM8=;
        b=h98yCe7fgQnBGQkCGLi0Th0UZFhv6CJewtkHxfhJIcJJR+xNQ4UXReJDQWkxfXP1T6
         1CdqqeRoZi2c8hKnTWD6RKwM8tV0cnhlOGJu+E3pKLugZctBxNAdUzs6QkKImXJr1zQR
         EJeq/FgutrCMZxSG0GtafUys5JAOdPHWuOrY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=7a705il38wQNIgcW74B99Zg1pH09khmZyWTP/+DOfM8=;
        b=r07uZ4PaBIEMC/lW201mXpeXL8Nx+bawzol135HExG60vr/+OvxtHTGg2D7MUm/DpB
         iU7QXg8faeY95G1DKIdcozQB3SZT0T/XOt094WdGWvc0ZBc7YD/vJ6J9Xw5lqfMi9jWj
         aK4TblhW28e9SFSCNub4zdoUwkRQxZjeILnFMxH9jRCzeYIsPRFEtD+P9KDgnjIicN6P
         9/hVlUoW/4K4+DKCMwmAtmEZbJPw67TE7MY/deVQPo3ZjW7sFff7T7QdiQiA1Jg/NNFe
         SvDth2aKn7bjqp/frk+EasjUi7IRzj/AA1yZSki0+QGipPggX8V0pe7PFAYv1kn1XKIr
         I2Ew==
X-Gm-Message-State: AOAM5334nR2SRh6EsL2KYL1gzj5gt225X3kyVOv2IE0mPQm82RYpruJx
        BK81DrWGClcHDQCWddh3L1ZUronTyuRLlgo4hAqUuA==
X-Google-Smtp-Source: ABdhPJxlC9t8V6GWGBtqrmmClx1K/3NEFoCCbtSDgVtIUee7kJy+HObJw/OmhCKEfZkzWuP4slkYsLLcOKcGIdk9EYk=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr3089735oif.63.1647554870183; Thu, 17
 Mar 2022 15:07:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 18:07:49 -0400
MIME-Version: 1.0
In-Reply-To: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
References: <1646679306-4768-1-git-send-email-quic_pmaliset@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 18:07:49 -0400
Message-ID: <CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: qcom: Add system PM support
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rajatja@google.com, refactormyself@gmail.com, robh@kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Prasad Malisetty (2022-03-07 10:55:06)
> Add suspend_noirq and resume_noirq callbacks to handle

Nitpick: They're no longer noirq so this should say "Add suspend and
resume callbacks"

> system suspend and resume in dwc PCIe controller driver.
>
> When system suspends, send PME turnoff message to enter
> link into L2 state. Along with powerdown the PHY, disable
> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
> supported and disable the pcie clocks, regulators.

I think Bjorn A. and Dmitry are trying to avoid this whole parking thing
in another series? Can you take a look at that?

>
> When system resumes, PCIe link will be re-established and
> setup rc settings.
>
> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
>
> ---
> Changes since v3:
>         - Replaced noirq hooks with normal suspend/resume hooks.
>         - Removed local variable and placed in function itself.
>
> Changes since v2:
>         - Removed unnecessary variable initializations and comments.
>         - Removed platform specific variables declarations.
>         - Added MACRO names for the BIT shiftings.
>
> Changes since v1:
>         - Removed unnecessary logs and modified log level suggested by Manivannan.
>         - Removed platform specific callbacks as PM support is generic.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..4d29c80 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -48,6 +48,7 @@
>  #define PCIE20_PARF_PHY_REFCLK                 0x4C
>  #define PHY_REFCLK_SSP_EN                      BIT(16)
>  #define PHY_REFCLK_USE_PAD                     BIT(12)
> +#define PHY_POWER_DOWN                         0x1
>
>  #define PCIE20_PARF_DBI_BASE_ADDR              0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE                0x16C
> @@ -62,6 +63,8 @@
>
>  #define PCIE20_ELBI_SYS_CTRL                   0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE         BIT(0)
> +#define PCIE_PME_TURNOFF_MSG                   BIT(4)
> +#define PCIE_PM_LINKST_IN_L2                   BIT(5)
>
>  #define PCIE20_AXI_MSTR_RESP_COMP_CTRL0                0x818
>  #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K       0x4
> @@ -73,6 +76,8 @@
>
>  #define PCIE20_PARF_Q2A_FLUSH                  0x1AC
>
> +#define PCIE20_PARF_PM_STTS                    0x24
> +
>  #define PCIE20_MISC_CONTROL_1_REG              0x8BC
>  #define DBI_RO_WR_EN                           1
>
> @@ -1645,6 +1650,97 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
> +{
> +       int ret;
> +       u32 val, poll_val;
> +       struct dw_pcie *pci = pcie->pci;
> +       struct device *dev = pci->dev;
> +
> +       val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +       val |= PCIE_PME_TURNOFF_MSG;
> +       writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +       ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +                       (poll_val & PCIE_PM_LINKST_IN_L2),
> +                       10000, 100000);
> +       if (!ret)
> +               dev_dbg(dev, "Device entered L23_Ready state\n");
> +       else
> +               dev_err(dev, "Device failed to enter L23_Ready. PM_STTS 0x%x\n",
> +                       readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
> +
> +       return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
> +{
> +       qcom_ep_reset_assert(pcie);
> +
> +       /* Put PHY into POWER DOWN state */
> +       phy_power_off(pcie->phy);
> +
> +       writel(PHY_POWER_DOWN, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +       if (pcie->cfg->ops->post_deinit)
> +               pcie->cfg->ops->post_deinit(pcie);
> +
> +       /* Disable PCIe clocks and regulators */
> +       pcie->cfg->ops->deinit(pcie);
> +}
> +
> +static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
> +{
> +       int ret;
> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +       struct dw_pcie *pci = pcie->pci;
> +
> +       if (!dw_pcie_link_up(pci)) {
> +               dev_dbg(dev, "Power has been turned off already\n");
> +               return 0;
> +       }
> +
> +       ret = qcom_pcie_send_pme_turnoff_msg(pcie);
> +       if (ret)
> +               return ret;
> +
> +       /* Power down the PHY, disable clock and regulators */
> +       qcom_pcie_host_disable(pcie);
> +
> +       return 0;
> +}
> +
> +/* Resume the PCIe link */
> +static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
> +{
> +       int ret;
> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +       struct dw_pcie *pci = pcie->pci;
> +       struct pcie_port *pp = &pci->pp;
> +
> +       ret = qcom_pcie_host_init(pp);
> +       if (ret) {
> +               dev_err(dev, "cannot initialize host\n");

Capitalize cannot?

> +               return ret;
> +       }
> +
> +       dw_pcie_setup_rc(pp);
> +
> +       qcom_pcie_start_link(pci);
> +
> +       ret = dw_pcie_wait_for_link(pci);
> +       if (ret) {
> +               dev_err(dev, "Link never came up, Resume failed\n");
> +               return ret;

Drop return and braces.

> +       }
> +
> +       return 0;

return ret;

> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
> +};
> +
