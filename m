Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6540B4C3986
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 00:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiBXXIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 18:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiBXXIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 18:08:20 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CB167F9C
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 15:07:45 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso4018624ooc.12
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 15:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Pdeuz0/x/UcCtYy9gpg2IQ952VwG4ymNYye+kPVrhEE=;
        b=MXLd3ZBdlTAX8agVsf5V28nQzQKnvYmBdeWKkk4KtN/pYmKhumnwNbQKw9+cabjXba
         MaFCVsrXZmsjSPu8usBX4MX+ijiaHhNMJwhQWS/i7sQEGQhS6DHlxIgLLVTYXmR4gJ6B
         AHqT9bQBCkjyLZWgU0zDNym6micA8Z5G9oSGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Pdeuz0/x/UcCtYy9gpg2IQ952VwG4ymNYye+kPVrhEE=;
        b=gpv0SkMyrlIevGdMNawZyW5M0lCsnZmm3I5ybbF71a+IRhFz6SXMIogCGkG/M4A3D4
         MzijbJyrrTDxLEPJ4yCY1HduAi6yqA+nE8A6/lU42liiqSKE/VDAxitRwgHJLe2tfvnS
         2w+xnQhp7g6c5BMqPmMTERwEw4ftL6VCnVDImbU9uMmrepPEnCJN87Zci593uhO4SWho
         p0IyFpFJXybDEbbf94g6Ec4b3y9Y0munJTZKcpgLr7R5uWZT24t12kQNZ2apEkSmcv0x
         DIk/7gUp80tMU8B88AOgPhZKot3ky6CfmJdbl5IoXxtf4b5g4DuPwRCwGdFKnWiCqb55
         PBiw==
X-Gm-Message-State: AOAM531d6sRI24eI3+VgvoDGgRZy6N2sFVVicVlnFIOXq7rMrdIn5Lah
        4xWVebvK6211YZ1aCw3pdZDthVGhIwNKd2dvCe8XzQ==
X-Google-Smtp-Source: ABdhPJwi6oQyJF5w8BHt7yH3mUbw2csLqO5u0sEOxg0VRQOmL+MfVdN2LSc5EljloA4RnFakZW/IGmhVAukd4UTMxjA=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr206276oap.54.1645744064750; Thu, 24 Feb
 2022 15:07:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Feb 2022 15:07:44 -0800
MIME-Version: 1.0
In-Reply-To: <1645695814-21102-1-git-send-email-quic_pmaliset@quicinc.com>
References: <1645695814-21102-1-git-send-email-quic_pmaliset@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 24 Feb 2022 15:07:44 -0800
Message-ID: <CAE-0n51ky1pmqDJAEOUqW2ycZU6c1PFLE17OPUyZZaRZSx4GQA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: qcom: Add system PM support
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Prasad Malisetty (2022-02-24 01:43:34)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c19cd506..f4a5e3c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1616,6 +1621,96 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
> +{
> +       int ret;
> +       u32 val, poll_val;
> +       u64 l23_rdy_poll_timeout = 100000; /* microseconds */

unsigned long instead of u64? But why is it a local variable at all?
Just inline it in the one place it is used?

> +       struct dw_pcie *pci = pcie->pci;
> +       struct device *dev = pci->dev;
> +
> +       val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +       val |= PCIE_PME_TURNOFF_MSG;
> +       writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +       ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +                       (poll_val & PCIE_PM_LINKST_IN_L2),
> +                       10000, l23_rdy_poll_timeout);
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
> +       if (pcie->ops->post_deinit)
> +               pcie->ops->post_deinit(pcie);
> +
> +       /* Disable PCIe clocks and regulators */
> +       pcie->ops->deinit(pcie);
> +}
> +
> +static int __maybe_unused qcom_pcie_pm_suspend_noirq(struct device *dev)
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
> +static int __maybe_unused qcom_pcie_pm_resume_noirq(struct device *dev)
> +{
> +       int ret;
> +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +       struct dw_pcie *pci = pcie->pci;
> +       struct pcie_port *pp = &pci->pp;
> +
> +       ret = qcom_pcie_host_init(pp);
> +       if (ret) {
> +               dev_err(dev, "cannot initialize host\n");
> +               return ret;
> +       }
> +
> +       dw_pcie_setup_rc(pp);
> +
> +       qcom_pcie_start_link(pci);
> +
> +       ret = dw_pcie_wait_for_link(pci);
> +       if (ret)
> +               dev_err(dev, "Link never came up, Resume failed\n");

But we ignore and don't return ret? Please add a comment about why
that's done, or return ret below.

> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend_noirq, qcom_pcie_pm_resume_noirq)

Why is noirq used? Please add a comment. And better yet don't use noirq
hooks and use the normal suspend/resume hooks.

> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>         { .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>         { .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
