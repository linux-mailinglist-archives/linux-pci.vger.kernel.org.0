Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782B560A55
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiF2Tds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 15:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiF2Tdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 15:33:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F122B12
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 12:33:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c205so16012495pfc.7
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcgTsOBcCCmAqgvSJCfdJb1ZnAUw5E+RtC3/ZrG2YmM=;
        b=dewAmd6FSCssJU85qaYMQHjIvQ3595Yw8tktnMiLA7skETiJin56JxXLOcjXQhV9+O
         huWHrgZjWf4ZBG6Tlgbd1NSx1gPellEqVpAY+o/VayuadaJ3resgCVx4qo5xthqVubar
         OamLhT55tubW+XIjdFtAHXF8dr9UXoUEqAvaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcgTsOBcCCmAqgvSJCfdJb1ZnAUw5E+RtC3/ZrG2YmM=;
        b=t0Fi3w5iRjd6pmVUH96RT9CDAMASQ7WsLWWKv7fKkjNUbEqeA3ABnLW/RxJ88lkQtE
         LwNFvQEH76j10Bx7vjcIzJgltA9/BhQbEd93x0ootNj29P2qvIYSI6wGw7E6iUZHVX6m
         zzaQOiefmb4buJl4M4sPEluMkq2ouecZcnU9uvdStwAYrKiZ2HEixgtp1Vx+0hLeZb1s
         ko32h1HK6PbB2PLCl+uNYEIzReKZlHeuv8t2SlpSSmoV6vAw2tzlEpjqeXjtt3uZ4bkA
         HOcAu7HQ4Pf8MDFnewlSUU0DrQ4cAqLmQyVz47+TRzXvzWuVVa9r6uKxqp4M7LUdoMpD
         sMuw==
X-Gm-Message-State: AJIora8oRx4geqOW2SkhcA38jiqLLyu2KcrMVI8QaExQpcSYIX3416vH
        pisg6gDz/MjkL4mWvc1vSuEuGw==
X-Google-Smtp-Source: AGRyM1speEdW8XN3x69iZSrs/2mCaVZS2QWLEAWucKQqhfpHrSD6oQg5wvUiEEaSHJCjZKTGNRKkXg==
X-Received: by 2002:a63:9042:0:b0:40d:bb3:79e0 with SMTP id a63-20020a639042000000b0040d0bb379e0mr4268168pge.70.1656531223280;
        Wed, 29 Jun 2022 12:33:43 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d97e:acfb:9af9:ab11])
        by smtp.gmail.com with UTF8SMTPSA id gb5-20020a17090b060500b001e31c7aad6fsm2645670pjb.20.2022.06.29.12.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:33:42 -0700 (PDT)
Date:   Wed, 29 Jun 2022 12:33:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add system PM support
Message-ID: <YrypE5KlICZgmEi0@google.com>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 03:03:33PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume pm callbacks.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> so that system enters into low power state to save the maximum power.
> And when the system resumes, enable the clocks back if they are
> disabled in the suspend path.
> 
> Changes since v1:
> 	- Fixed compilation errors.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..8e9ef37 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -41,6 +41,9 @@
>  #define L23_CLK_RMV_DIS				BIT(2)
>  #define L1_CLK_RMV_DIS				BIT(1)
>  
> +#define PCIE20_PARF_PM_STTS                     0x24
> +#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB    BIT(8)
> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -190,6 +193,8 @@ struct qcom_pcie_ops {
>  	void (*post_deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> +	int (*enable_clks)(struct qcom_pcie *pcie);
> +	int (*disable_clks)(struct qcom_pcie *pcie);
>  };
>  
>  struct qcom_pcie_cfg {
> @@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
>  	unsigned int has_aggre1_clk:1;
> +	unsigned int support_pm_ops:1;

nit: s/support_pm_ops/supports_system_suspend/ ?

It's not really the ops that are supported, but system suspend. 'supports'
(with an 's' at the end) to specify a characteristic of the
driver/controller (similar to the 'has_<something>'s above), rather than
an imperative of what the driver should do.

In any case, it's just a nit :)

>  };
>  
>  struct qcom_pcie {
> @@ -209,6 +215,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_cfg *cfg;
> +	unsigned int is_suspended:1;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1308,6 +1315,23 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->pipe_clk);
>  }
>  
> +static int qcom_pcie_enable_clks_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +	return clk_bulk_prepare_enable(res->num_clks, res->clks);
> +}
> +
> +static int qcom_pcie_disable_clks_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +
> +	return 0;
> +}
> +
> +

nit: delete one empty line

>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1485,6 +1509,8 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.post_init = qcom_pcie_post_init_2_7_0,
>  	.post_deinit = qcom_pcie_post_deinit_2_7_0,
> +	.enable_clks = qcom_pcie_enable_clks_2_7_0,
> +	.disable_clks = qcom_pcie_disable_clks_2_7_0,
>  };
>  
>  /* Qcom IP rev.: 1.9.0 */
> @@ -1548,6 +1574,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
> +	.support_pm_ops = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1591,6 +1618,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->cfg = pcie_cfg;
>  
> +	pcie->is_suspended = false;

not strictly necessary because of kzalloc, but does no harm either.

> +
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
>  		ret = PTR_ERR(pcie->reset);
> @@ -1645,6 +1674,57 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!pcie->cfg->support_pm_ops)
> +		return 0;
> +
> +	/* if the link is not in l1ss don't turn off clocks */
> +	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> +	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> +		dev_err(dev, "Link is not in L1ss\n");

If this is an error, should the function return an error? Otherwise maybe it
should be a warning.

> +		return 0;
> +	}
> +
> +	if (pcie->cfg->ops->disable_clks)
> +		pcie->cfg->ops->disable_clks(pcie);
> +
> +	if (pcie->cfg->ops->post_deinit)
> +		pcie->cfg->ops->post_deinit(pcie);
> +
> +	pcie->is_suspended = true;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie->cfg->support_pm_ops)
> +		return 0;
> +
> +	if (!pcie->is_suspended)
> +		return 0;
> +
> +	if (pcie->cfg->ops->enable_clks)
> +		pcie->cfg->ops->enable_clks(pcie);
> +
> +	if (pcie->cfg->ops->post_init)
> +		pcie->cfg->ops->post_init(pcie);
> +
> +	pcie->is_suspended = false;
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> @@ -1679,6 +1759,7 @@ static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
>  	.driver = {
>  		.name = "qcom-pcie",
> +		.pm = &qcom_pcie_pm_ops,
>  		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
>  	},
> -- 
> 2.7.4
> 
