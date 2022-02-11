Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A134B2140
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 10:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbiBKJOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 04:14:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiBKJOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 04:14:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34651029
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 01:14:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso8223436pjh.5
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 01:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AnYtNhdLAufx/Wabg2w3ZU5XlCq9QWc6T4pL9mdKHRk=;
        b=PNPe2khfRgmo+HiRLlAoG8nVNb0scB964DKEKSYoD7jVClmPhbuGxl65L227FrqsEV
         4iVXQk8yjkMgI4Zhwnus0nHOI5kzk+FjeqIZLwu8gcgvdb5Ux6L6guI4TmJf1iJ2CCYb
         NJPvElMNC+IdNHNEp8OCZhHSaZaJzH245SUwRA0tIVkUbZmm9jrIIdqcnhSioTl6xg74
         kXPojEOuzOH6ySvsn4F29C2yeDxpHL02dfhn80v0ic8b7gnNaSLrqooTu0WH3UqgNRNs
         /jpQ651JLr3m4/kZa5eZRasvXTwPv6nOg7gd2feWYA67K7391vlqj86x/yjM0XjqTeoe
         8fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AnYtNhdLAufx/Wabg2w3ZU5XlCq9QWc6T4pL9mdKHRk=;
        b=CB0/GghiEcZWtoWYHh3lOinpiqw+JvvPxH9HSpcUq7WHZCz1LiY7q7BjddJuTq8SPg
         w7tA1zRI2BskDiIQJguVwT5AXZdAjt/gJ9jTDacKUzOj/JeNRRrL1IV4rMz+3GmADVKT
         3xLThIdOZ7w13ksUEyHFsnaiRIQ4xqh1Evk+20961tr4HY5VdH7bH81A6OmOpok5QwsO
         peVCiEQx62HhRKNjJrzRTR8cRDlX5wSQJndeJCRw3ERS5wBE/y8ZfgPtjebjUFjuK1uS
         hJpoMw2ZIr87JQZC88JsiWHjZoY/hOhnIJDiPuHehWOdfT7T247RggIVChUcY2le5xO0
         wDEw==
X-Gm-Message-State: AOAM5316McTca6MF2cDEs0B/fnOe19+wD90IAZnRDkDAXKLRO+acGuc6
        ba6gNcRnb0Emqw8DoAi7WeBv
X-Google-Smtp-Source: ABdhPJwHRpEeOjwi5F77yVboQHbjWdwulWc/2KiRTMLMCZ9HfBIOxiShsb9dQk3Gt66vTmxNGYNhAA==
X-Received: by 2002:a17:90b:3b8f:: with SMTP id pc15mr1606035pjb.165.1644570855042;
        Fri, 11 Feb 2022 01:14:15 -0800 (PST)
Received: from thinkpad ([27.111.75.38])
        by smtp.gmail.com with ESMTPSA id h4sm26078995pfv.166.2022.02.11.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:14:14 -0800 (PST)
Date:   Fri, 11 Feb 2022 14:44:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org
Subject: Re: [PATCH v2] PCI: qcom: Add system PM support
Message-ID: <20220211091409.GB3223@thinkpad>
References: <1643738876-18572-1-git-send-email-quic_pmaliset@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643738876-18572-1-git-send-email-quic_pmaliset@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On top of Bjorn's review:

On Tue, Feb 01, 2022 at 11:37:56PM +0530, Prasad Malisetty wrote:
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
> Reported-by: kernel test robot <lkp@intel.com>
> 
> ---
> Changes since v1:
> 	- Removed unnecessary logs and modified log level suggested by Manivannan.
> 	- Removed platform specific callbacks as PM support is generic.

This is not still generic... Please see below.

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
> +
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
> +	u32 val = 0, poll_val = 0;
> +	u64 l23_rdy_poll_timeout = 100000;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |= BIT(4);

Define BIT(4)

> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
> +			(poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);

Define BIT(5)

> +	if (!ret)
> +		dev_info(dev, "PM_Enter_L23 is received\n");

Maybe print, "Device entered L23_Ready state"? Also this should be dev_dbg().

> +	else
> +		dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",

Maybe print, "Device failed to enter L23_Ready state"?

> +			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +

As Bjorn said this would only work for platforms supporting v2.7.0 ops. Please
make it generic.

> +	/* Assert the reset of endpoint */
> +	qcom_ep_reset_assert(pcie);
> +
> +	/* Put PHY into POWER DOWN state */
> +	phy_power_off(pcie->phy);
> +
> +	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);

Define "1".

Thanks,
Mani
