Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D088557F3E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiFWQDc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiFWQDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 12:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03244752;
        Thu, 23 Jun 2022 09:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E7A61F0D;
        Thu, 23 Jun 2022 16:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC71BC3411B;
        Thu, 23 Jun 2022 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656000209;
        bh=qhtJCtoqOE5Qq88IlsTEYSJao1PWW33USuJLVon8M8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XCgmN//HLckKkS5j5UJDEyYe7VzmhNDOG6/YCmG3l2mv5nZcmTQkpLjvqBt5vBl7M
         iUylHVC+X8aXhwYHebFgzm48pGxbt/4NBjQxl+vDVnPRnMwcxL9YpPEu9/7pPoSxFJ
         K1vkY9lrPmnz4yOcFRZ/uw2mfn/pLEPLd7hWgEUL4SW9d/XCYaoXaobm14MCOOE97O
         jTZgiZ8WTO5BSliTB0l735WH35uIS9JLT7o0qpMPByrrwLoVm+l+PXSLCyNjboyXI2
         faB0BN79iPckpZhWwfPU1eypHsDOj9q92TSeLYdEdvEpp1knPol0zfne76u01v3KJV
         78jOFYXqknTUw==
Date:   Thu, 23 Jun 2022 11:03:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 1/2] PCI: qcom: fix IPQ8074 Gen2 support
Message-ID: <20220623160328.GA1453945@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623155004.688090-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 05:50:03PM +0200, Robert Marko wrote:
> Currently the Gen2 port in IPQ8074 will cause the system to hang as its
> using DBI registers in the .init and those are only accesible after
> phy_power_on().
> 
> So solve this by splitting the DBI read/writes to .post_init.
> 
> Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")

Does v5.11 or some v5.11-based stable kernel contain IPQ8074 support?
If so, I'll mark this for backporting to stable.

> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v3:
> * Make sure it applies onto 5.19-rc3
> * Update the commit description to make it clear this only affects the
> Gen2 port
> 
> Changes in v2:
> * Rebase onto next-20220621
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a1f1aca2fb59..24708d5d817d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	int i, ret;
> -	u32 val;
>  
>  	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
>  		ret = reset_control_assert(res->rst[i]);
> @@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  		goto err_clk_aux;
>  	}
>  
> +	return 0;
> +
> +err_clk_aux:
> +	clk_disable_unprepare(res->ahb_clk);
> +err_clk_ahb:
> +	clk_disable_unprepare(res->axi_s_clk);
> +err_clk_axi_s:
> +	clk_disable_unprepare(res->axi_m_clk);
> +err_clk_axi_m:
> +	clk_disable_unprepare(res->iface);
> +err_clk_iface:
> +	/*
> +	 * Not checking for failure, will anyway return
> +	 * the original failure in 'ret'.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> +		reset_control_assert(res->rst[i]);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +
>  	writel(SLV_ADDR_SPACE_SZ,
>  		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
>  
> @@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  		PCI_EXP_DEVCTL2);
>  
>  	return 0;
> -
> -err_clk_aux:
> -	clk_disable_unprepare(res->ahb_clk);
> -err_clk_ahb:
> -	clk_disable_unprepare(res->axi_s_clk);
> -err_clk_axi_s:
> -	clk_disable_unprepare(res->axi_m_clk);
> -err_clk_axi_m:
> -	clk_disable_unprepare(res->iface);
> -err_clk_iface:
> -	/*
> -	 * Not checking for failure, will anyway return
> -	 * the original failure in 'ret'.
> -	 */
> -	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> -		reset_control_assert(res->rst[i]);
> -
> -	return ret;
>  }
>  
>  static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> @@ -1596,6 +1603,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
>  static const struct qcom_pcie_ops ops_2_3_3 = {
>  	.get_resources = qcom_pcie_get_resources_2_3_3,
>  	.init = qcom_pcie_init_2_3_3,
> +	.post_init = qcom_pcie_post_init_2_3_3,
>  	.deinit = qcom_pcie_deinit_2_3_3,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
> -- 
> 2.36.1
> 
