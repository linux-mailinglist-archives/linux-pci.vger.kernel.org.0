Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43C570D06
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGKVxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 17:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGKVxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 17:53:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FCDF10
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 14:53:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a15so5848383pfv.13
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cYT0iastnCoWsD+kD3snbd3pWJtTmtlehUBK4uUB0hw=;
        b=O9aedkiENZGJ3LxWvfudGprmWOSynsq5GcTjOG4o1rvGjdKIMYC6i5Mm7QXvXEhsVR
         ZdxxmmGo8degIK8ln7hm1i3tI6S8wPxegGqfD7qTasJkTnzo9rnDugkLJksdyorWjQkt
         LPKA72973EcEEpDQVHI/r2U234dNq57y+4xTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cYT0iastnCoWsD+kD3snbd3pWJtTmtlehUBK4uUB0hw=;
        b=Z5XOyxdvv5k8kwygLW0jIDsqPjOoOz6KR2AmdIiTsll0QVXommg+uarz9tqQB6AFqI
         eQICh/pgJyhtC6/dbnJxPhMZVD6O1prI82Bn4713MLh9q4hjJmaVINPzMY9zuRfYIUmA
         KEurQ+d72ZFrm1XNUwzvb6NeUO6WBtLK7srkV3gZsZZmoOTK/n6yDvW7Dfd8vwgm9/Ag
         ol9pSwD186hy760dziubCTUjpaKXpZUDjV5KwByrZOG7+ZZMCtUV01N4C8MXnq4SJHY3
         e59KpfzyczttSYDSAbZYpk9YjAzVp/JvVv+sYusYHbDkRiHGi32K45BpGD/nIL6dmIP8
         XrTg==
X-Gm-Message-State: AJIora/v4sIr06ZDfVH9akOH6F4W3qYGU8zpHjLqNkZZWtTjSZhYlwkb
        8FCAwqlQG1OPMqqBmBO0fZifiw==
X-Google-Smtp-Source: AGRyM1t7EENjW737+iBr5F1uFxKkI9aYOroW4ZNtffHXNu2VtayfNsSBhFywzVKUO5Oh5g8TgAEiyg==
X-Received: by 2002:a05:6a00:b8c:b0:525:6391:1139 with SMTP id g12-20020a056a000b8c00b0052563911139mr20297882pfj.80.1657576413764;
        Mon, 11 Jul 2022 14:53:33 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:7b75:79f4:3be2:2c65])
        by smtp.gmail.com with UTF8SMTPSA id t8-20020a17090a2f8800b001e31fea8c85sm7116710pjd.14.2022.07.11.14.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 14:53:33 -0700 (PDT)
Date:   Mon, 11 Jul 2022 14:53:31 -0700
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
Subject: Re: [PATCH v4 1/2] PCI: qcom: Add system PM support
Message-ID: <Ysyb24TidwWFH0Dm@google.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1657118425-10304-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 08:10:24PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume pm callbacks.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> and power down the phy so that system enters into low power state to
> save the maximum power. And when the system resumes, enable the clocks
> back and power on phy if they are disabled in the suspend path.
> 
> we are doing this only when link is in l1ss but not in L2/L3 as
> no where we are forcing link to L2/L3 by sending PME turn off.
> 
> is_suspended flag indicates if the clocks are disabled in the suspend
> path or not. And this flag is being used to restrict the access to
> config space, dbi etc when clock are turned-off.
> 
> Changes since v3:
> 	- Powering down the phy in suspend and powering it on resume to
> 	  acheive maximum power savings.
> Changes since v2:
> 	- Replaced the enable, disable clks ops with suspend and resume
> 	- Renamed support_pm_opsi flag  with supports_system_suspend.
> Changes since v1:
> 	- Fixed compilation errors.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6ab9089..0a9d1ee 100644
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
> +	int (*suspend)(struct qcom_pcie *pcie);
> +	int (*resume)(struct qcom_pcie *pcie);
>  };
>  
>  struct qcom_pcie_cfg {
> @@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
>  	unsigned int has_aggre1_clk:1;
> +	unsigned int supports_system_suspend:1;
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
> @@ -1308,6 +1315,33 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->pipe_clk);
>  }
>  
> +static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	int ret;
> +
> +	clk_prepare_enable(res->pipe_clk);
> +
> +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> +
> +	phy_power_on(pcie->phy);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +
> +	phy_power_off(pcie->phy);
> +
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
> +
> +	clk_disable_unprepare(res->pipe_clk);
> +
> +	return 0;
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1496,6 +1530,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.post_init = qcom_pcie_post_init_2_7_0,
>  	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>  	.config_sid = qcom_pcie_config_sid_sm8250,
> +	.suspend = qcom_pcie_suspend_2_7_0,
> +	.resume = qcom_pcie_resume_2_7_0,
>  };
>  
>  static const struct qcom_pcie_cfg apq8084_cfg = {
> @@ -1548,6 +1584,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
>  	.pipe_clk_need_muxing = true,
> +	.supports_system_suspend = true,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1591,6 +1628,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->cfg = pcie_cfg;
>  
> +	pcie->is_suspended = false;
> +
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>  	if (IS_ERR(pcie->reset)) {
>  		ret = PTR_ERR(pcie->reset);
> @@ -1645,6 +1684,51 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!pcie->cfg->supports_system_suspend)
> +		return 0;
> +
> +	/* if the link is not in l1ss don't turn off clocks */
> +	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> +	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> +		dev_warn(dev, "Link is not in L1ss\n");
> +		return 0;
> +	}
> +
> +	if (pcie->cfg->ops->suspend)
> +		pcie->cfg->ops->suspend(pcie);
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
> +	if (!pcie->cfg->supports_system_suspend)
> +		return 0;

The above check can be omitted, it is implied by the next one.
'is_suspended' can only be true when system suspend is supported.

> +
> +	if (!pcie->is_suspended)
> +		return 0;
> +
> +	if (pcie->cfg->ops->resume)
> +		pcie->cfg->ops->resume(pcie);
> +
> +	pcie->is_suspended = false;
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
> +};
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
> @@ -1679,6 +1763,7 @@ static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
>  	.driver = {
>  		.name = "qcom-pcie",
> +		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
>  		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
>  	},
> -- 
> 2.7.4
> 
