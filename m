Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21F5513497
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 15:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiD1NNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344796AbiD1NNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 09:13:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC859B0D03
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 06:09:51 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r8so5267126oib.5
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yQhVPEwocqKZE/TgP32Dswwk0+c7D7Jj1pNtxxIXVbo=;
        b=xbECkeKwHS85QEYeJrd90iT+3TVdNgg2pn7Xu1lVEwMaFzNkQZzmFf5v6rMsEP6jQ8
         /Z/Betg7Yp+PvW8EQAts2v7NnvkO4u+f50FGNur2e84EX/Rbn7r1fS99ENreroAkqqh8
         0RYnZ8clcHy7E+gh6tuOlV5tRug7xnNmnqpzZXbmui2cIsu0OSml4erNLcpDxZJzEEQ1
         reyiP3IJETy+kpP1Kv8LUmRm4XQMxV3K/9UCV1uJ/TJ4d+4ZOccngKXh+fu1zYvL+1qP
         ydkRtP9FKZnnIiE4hcr9Elbg3WYfMx563POrROpxyLf11LVs+tkywB73dcoX9tulms3u
         CsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQhVPEwocqKZE/TgP32Dswwk0+c7D7Jj1pNtxxIXVbo=;
        b=l8SoKnt5h1XoVckPB7lFwNE16jsS5PF8MJkNOUvjzihCjESjj+CTKnE2Q2IWrcS0WE
         HeIbuenirN7HApZQmfT9gpxBZW+rrBBV0OdwWKcmusF+cDelgNdAESbK/wLSI9V+TZ5m
         rLfAO4hPnMOD2MzM0ogJrLQ9oCVNqdeNV17DT48/D+JDqQ0Y3k7T2N7cQoB32kAm8X4b
         AMC84d6Xc+fJqy31XmkjRVE+io+No3eHoThJUhRvo5ZNi0jD5c/hm+Xq2G8iVunI9rmY
         ZUPHKlmqBBBvCyxB/Tl6AHFchGwJWhmUelyunzRbjMdKxUqMCiRDFKs3vPH3JZfssz3h
         jwtA==
X-Gm-Message-State: AOAM5312RML28qeBC7iTtNykkw6L93AteeNYISrQGJ+w4vRwDNBvZdMb
        oXjofyVjiLHH9DAGXzNLiB0zHQ==
X-Google-Smtp-Source: ABdhPJyNNu/9YjwEVSqzGB56IIlBp+Ne+BZ4LK5tD0ZCnv3vt9HiHm4vdI6A/vCz3mURFgR20L7wqQ==
X-Received: by 2002:a05:6808:144a:b0:325:642:f58f with SMTP id x10-20020a056808144a00b003250642f58fmr12209158oiv.221.1651151390975;
        Thu, 28 Apr 2022 06:09:50 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u7-20020a4a85c7000000b0035c12c8be73sm7963763ooh.29.2022.04.28.06.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:09:50 -0700 (PDT)
Date:   Thu, 28 Apr 2022 06:11:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 1/5] phy: qcom-qmp: add support for pipe clock muxing
Message-ID: <YmqSkP++4xzisJHp@ripper>
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421102041.17345-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 21 Apr 03:20 PDT 2022, Johan Hovold wrote:

> Some QMP PHYs need to remux to their pipe clock input to the pipe clock
> output generated by the PHY before powering on the PHY and restore the
> default source during power down.
> 
> Add support for an optional pipe clock mux which will be reparented to
> the generated pipe clock before powering on the PHY and restored to the
> default reference source on power off.
> 

After considering this for a while, I have two objections to doing this
explicitly:

1) The QMP block is fed &gcc_pcie_N_pipe_clk (and on sc8280xp)
gcc_pcie_N_pipediv2_clk. But neither of these clocks are the mux, so
what this patch (and the existing muxing logic in the controller) does
is to poke into gcc "internals".

2) The actual reason for the mux dance is that toggling the associated
GDSC without a valid parent of this clock would cause the clock to lock
up and GDSC transition to time out. This property is shared with a wide
range of other clocks (so far we have 84 users of clk_rcg2_shared_ops on
sc8280xp).



It would be nice if clk_summary would represent the real state of these
clocks, but unfortunately I don't think the state matches reality with
this approach either.

E.g. we prepare/enable the pipe clock before setting
QPHY_POWER_DOWN_CONTROL, during this time there's shouldn't be any pipe
clock coming out of the PHY...

Regards,
Bjorn

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 71 ++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 7d2d1ab061f7..bc6db9670291 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3292,6 +3292,8 @@ struct qmp_phy_combo_cfg {
>   * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
>   * @pcs_misc: iomapped memory space for lane's pcs_misc
>   * @pipe_clk: pipe clock
> + * @pipemux_clk: pipe clock source mux
> + * @piperef_clk: pipe clock default reference source
>   * @index: lane index
>   * @qmp: QMP phy to which this lane belongs
>   * @lane_rst: lane's reset controller
> @@ -3311,6 +3313,8 @@ struct qmp_phy {
>  	void __iomem *rx2;
>  	void __iomem *pcs_misc;
>  	struct clk *pipe_clk;
> +	struct clk *pipemux_clk;
> +	struct clk *piperef_clk;
>  	unsigned int index;
>  	struct qcom_qmp *qmp;
>  	struct reset_control *lane_rst;
> @@ -3346,6 +3350,7 @@ struct qcom_qmp {
>  	void __iomem *dp_com;
>  
>  	struct clk_bulk_data *clks;
> +	struct clk *pipe_clksrc;
>  	struct reset_control **resets;
>  	struct regulator_bulk_data *vregs;
>  
> @@ -5355,6 +5360,42 @@ static int qcom_qmp_phy_init(struct phy *phy)
>  	return 0;
>  }
>  
> +static int qcom_qmp_phy_pipe_clk_enable(struct qmp_phy *qphy)
> +{
> +	struct qcom_qmp *qmp = qphy->qmp;
> +	int ret;
> +
> +	ret = clk_set_parent(qphy->pipemux_clk, qmp->pipe_clksrc);
> +	if (ret)
> +		dev_err(qmp->dev, "failed to reparent pipe clock: %d\n", ret);
> +
> +
> +	ret = clk_prepare_enable(qphy->pipe_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "failed to enable pipe clock: %d\n", ret);
> +		goto err_restore_parent;
> +	}
> +
> +	return 0;
> +
> +err_restore_parent:
> +	clk_set_parent(qphy->pipemux_clk, qphy->piperef_clk);
> +
> +	return ret;
> +}
> +
> +static void qcom_qmp_phy_pipe_clk_disable(struct qmp_phy *qphy)
> +{
> +	struct qcom_qmp *qmp = qphy->qmp;
> +	int ret;
> +
> +	clk_disable_unprepare(qphy->pipe_clk);
> +
> +	ret = clk_set_parent(qphy->pipemux_clk, qphy->piperef_clk);
> +	if (ret)
> +		dev_err(qmp->dev, "failed to reparent pipe clock: %d\n", ret);
> +}
> +
>  static int qcom_qmp_phy_power_on(struct phy *phy)
>  {
>  	struct qmp_phy *qphy = phy_get_drvdata(phy);
> @@ -5379,11 +5420,9 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
>  		}
>  	}
>  
> -	ret = clk_prepare_enable(qphy->pipe_clk);
> -	if (ret) {
> -		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +	ret = qcom_qmp_phy_pipe_clk_enable(qphy);
> +	if (ret)
>  		goto err_reset_lane;
> -	}
>  
>  	/* Tx, Rx, and PCS configurations */
>  	qcom_qmp_phy_configure_lane(tx, cfg->regs,
> @@ -5478,7 +5517,7 @@ static int qcom_qmp_phy_power_on(struct phy *phy)
>  	return 0;
>  
>  err_disable_pipe_clk:
> -	clk_disable_unprepare(qphy->pipe_clk);
> +	qcom_qmp_phy_pipe_clk_disable(qphy);
>  err_reset_lane:
>  	if (cfg->has_lane_rst)
>  		reset_control_assert(qphy->lane_rst);
> @@ -5491,7 +5530,7 @@ static int qcom_qmp_phy_power_off(struct phy *phy)
>  	struct qmp_phy *qphy = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qphy->cfg;
>  
> -	clk_disable_unprepare(qphy->pipe_clk);
> +	qcom_qmp_phy_pipe_clk_disable(qphy);
>  
>  	if (cfg->type == PHY_TYPE_DP) {
>  		/* Assert DP PHY power down */
> @@ -5777,6 +5816,8 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  	if (ret)
>  		return ret;
>  
> +	qmp->pipe_clksrc = fixed->hw.clk;
> +
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
>  	if (ret)
>  		return ret;
> @@ -6091,6 +6132,24 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
>  		qphy->pipe_clk = NULL;
>  	}
>  
> +	/* Get optional pipe clock mux and default reference source clock. */
> +	qphy->pipemux_clk = of_clk_get_by_name(np, "mux");
> +	if (IS_ERR(qphy->pipemux_clk)) {
> +		ret = PTR_ERR(qphy->pipemux_clk);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		qphy->pipemux_clk = NULL;
> +	} else {
> +		qphy->piperef_clk = of_clk_get_by_name(np, "ref");
> +		if (IS_ERR(qphy->piperef_clk)) {
> +			ret = PTR_ERR(qphy->piperef_clk);
> +			return dev_err_probe(dev, ret,
> +					     "failed to get lane%d piperef_clk\n",
> +					     id);
> +		}
> +	}
> +
>  	/* Get lane reset, if any */
>  	if (cfg->has_lane_rst) {
>  		snprintf(prop_name, sizeof(prop_name), "lane%d", id);
> -- 
> 2.35.1
> 
