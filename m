Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7027C553BA7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiFUUcS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFUUcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 16:32:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D22DABC;
        Tue, 21 Jun 2022 13:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7DDAB81B1F;
        Tue, 21 Jun 2022 20:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D308AC3411C;
        Tue, 21 Jun 2022 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655843534;
        bh=g5SNeS4l+ayTjxdeGsrdnNwd0WX2yrP6Nd6mSzSF3/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iEPHhBKcdHb/hO4YF5gKGtbZJiXJUPfyfPEW+erRYV9ygEF0J2hxndGvA/FgcEFtb
         40pSVOUURZkcN3OaNDoR1tmB/3rZfT4EVwgnCfK8HMnTKBqulcKwr3KKoy7mfr2oDT
         fdXLLK6BYq4Yt5RKIxMqcq1czTMMivUXiU0xUSSBMevnpUSdqCSD0pFh+Xo+O12Ne7
         qmCambauwhYdicYzeGvQ0QFcyVjfNZSyxslbVUKM0ybYKyK66SWyB9Po9uulsWXtpI
         qyNy0JiH4PpL2jXb7nvGsi/jkD4PmTzc3Eq2y/xhKszjofabn/WymKaxqSc0x2nggm
         rSPsaKBJkNjJQ==
Date:   Tue, 21 Jun 2022 15:32:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Message-ID: <20220621203211.GA1330530@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621112330.448754-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> cause the system to hang as its using DBI registers in the .init
> and those are only accesible after phy_power_on().

Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
this patch?  I don't see the connection.

I see that qcom_pcie_host_init() does:

  qcom_pcie_host_init
    pcie->cfg->ops->init(pcie)
    phy_power_on(pcie->phy)
    pcie->cfg->ops->post_init(pcie)

and that you're moving DBI register accesses from
qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().

But I also see DBI register accesses in other .init() functions:

  qcom_pcie_init_2_1_0
  qcom_pcie_init_1_0_0      (oddly out of order)
  qcom_pcie_init_2_3_2
  qcom_pcie_init_2_4_0

Why do these accesses not need to be moved?  I assume it's because
pcie->phy is an optional PHY and phy_power_on() does nothing on those
controllers?

Whatever the reason, I think the DBI accesses should be done
consistently in .post_init().  I see that Dmitry's previous patches
removed all those .post_init() functions, but I think the consistency
is worth having.

Perhaps we could reorder the patches so this patch comes first, moves
the DBI accesses into .post_init(), then Dmitry's patches could be
rebased on top to drop the clock handling?

> So solve this by splitting the DBI read/writes to .post_init.
> 
> Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Rebase onto next-20220621
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 51fed83484af..da6d79d61397 100644
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
> @@ -1598,6 +1605,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
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
