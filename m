Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1D4EEB21
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbiDAKTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbiDAKTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 06:19:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4D26E020;
        Fri,  1 Apr 2022 03:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3F8B8236C;
        Fri,  1 Apr 2022 10:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08401C340F2;
        Fri,  1 Apr 2022 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648808241;
        bh=GW8BDi6tbXlVrKtuB3fhHINCWtB01NTu50/7fvNfu2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TV7jtu2az6XikrXdSq6m2AbpIhjqORl3CC/pWS2ocXqw9YinIxOXQtl1T9uhHgxpP
         0V+XKETEvJbmPDpuPwQbXuKEd3/ccfAjd/bi8OJ1/6mlnvQNsE19QVxFB7c/w7VV/1
         oXaAKCSDbjbklbNWln65vsbq1tnqHyDiAk57miKXUyij9/qeHw+zjTueeyu1kgihYV
         ahdRAxOefP5qeYlQNrlsI59lZL5Vjh3Gvm9N+3/G4yrZrc3FQPNAt1+ubf//YeWhOv
         dAq4v+hGpxadARjUSTNbhX2o8Vm0ZhN8Aq3c1uRiEkrGxeihiGKrC8JCunStMFNGMK
         9UFugeoJ4mpmg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1naELI-0004Sv-JP; Fri, 01 Apr 2022 12:17:20 +0200
Date:   Fri, 1 Apr 2022 12:17:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 4/5] PCI: qcom: Remove unnecessary pipe_clk handling
Message-ID: <YkbRMPBblbccWeTw@hovoldconsulting.com>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
 <20220323085010.1753493-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323085010.1753493-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 11:50:09AM +0300, Dmitry Baryshkov wrote:
> QMP PHY driver already does clk_prepare_enable()/_disable() pipe_clk.
> Remove extra calls to enable/disable this clock from the PCIe driver, so
> that the PHY driver can manage the clock on its own.
> 
> Fixes: aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
> Cc: Prasad Malisetty <quic_pmaliset@quicinc.com>

Looks like you're blaming the wrong author and commit, but a Fixes tag
probably isn't warranted at all here.

The first commit to introduce pipe clock handling to this driver was

	d0491fc39bdd ("PCI: qcom: Add support for MSM8996 PCIe controller")

back in 2016.

This was followed up in 2019 with

	ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")

which also introduced a clock imbalance by enabling the pipe clock both
in init() and post_init() but only disabling in post_deinit().

Note that this commit also started enabling the pipe clock before
powering up the PHY (i.e. the call in init()) which looks like another
bug.

This bit should be fixed separately and you can just drop the Fixes tag
from this patch. I've sent a fix here:

	https://lore.kernel.org/r/20220401101325.16983-1-johan+linaro@kernel.org

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 50 ++------------------------
>  1 file changed, 3 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c

>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> @@ -1238,12 +1211,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  		goto err_disable_clocks;
>  	}
>  
> -	ret = clk_prepare_enable(res->pipe_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable pipe clock\n");
> -		goto err_disable_clocks;
> -	}
> -

Here's the imbalance.

>  	/* Wait for reset to complete, required on SM8450 */
>  	usleep_range(1000, 1500);
>  
> @@ -1298,14 +1265,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	if (pcie->cfg->pipe_clk_need_muxing)
>  		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>  
> -	return clk_prepare_enable(res->pipe_clk);
> -}
> -
> -static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> -
> -	clk_disable_unprepare(res->pipe_clk);
> +	return 0;
>  }

Johan
