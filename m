Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001DC58F3F2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiHJVu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 17:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiHJVu0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 17:50:26 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1F19A;
        Wed, 10 Aug 2022 14:50:25 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id b12so9019017ils.9;
        Wed, 10 Aug 2022 14:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YlXbQLFj+/8ay/e+jraYSXiq6JhC2XVfS5mz++DOn9I=;
        b=wrlrXp8MMQKULa+x9cDkkTptfhG7NWNuUjxdtp9T0Cwy6iI1fSkfJeaS/FTnj+yJua
         LHAc01HbxlD0WGnlN5W6LnZczzEN3Izv1a8G3BC1XnXXhj8HCfAVHyC4HO609zs2HO5w
         7F4dBFITc2flRIOe/FQ3/MeODh8X+qgdYx+pa9bRGZKz1XTyCRHwIfY1J2LlenI/7bzj
         b1igB81Rcrwk/7j25wdhet5/L4YD3m1tusnDtmLOIIGsSdnwICUtACq9vE44/ywGu7aS
         XEBHhbyL/sAKHDrhVKxRlOFS85Mo3aWLFVDhdzmIuQHa1GU1kdI0iEHht1VL6lU6tqnY
         YjVw==
X-Gm-Message-State: ACgBeo1pXJl5Eh96itdI6fG4CPEC9ZSL0mPtYPFFvY+UXv0fmy/t1Bl/
        En8l4SXYPvRLQfspKH+6Hg==
X-Google-Smtp-Source: AA6agR4YeS96INuXB5vmy5Y3luOaEN3uj/j8gxzXosZ79Gr+Jck9mZC10CKUZbK3+1YXfdoDZdIa8A==
X-Received: by 2002:a05:6e02:b4c:b0:2de:de3e:6c5a with SMTP id f12-20020a056e020b4c00b002dede3e6c5amr14209694ilu.6.1660168224473;
        Wed, 10 Aug 2022 14:50:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w25-20020a02b0d9000000b00342786a9b4asm8036224jah.18.2022.08.10.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 14:50:24 -0700 (PDT)
Received: (nullmailer pid 616834 invoked by uid 1000);
        Wed, 10 Aug 2022 21:50:22 -0000
Date:   Wed, 10 Aug 2022 15:50:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/3] PCI: qcom: Add system PM support
Message-ID: <20220810215022.GC557589-robh@kernel.org>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659526134-22978-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 03, 2022 at 04:58:52PM +0530, Krishna chaitanya chundru wrote:
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
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes since v4:
> 	- Rebasing the code and removed the supports_system_suspend flag
> 	- in the resume path as is_suspended will serve its purpose.
> Changes since v3:
> 	- Powering down the phy in suspend and powering it on resume to
> 	  acheive maximum power savings.
> Changes since v2:
> 	- Replaced the enable, disable clks ops with suspend and resume
> 	- Renamed support_pm_opsi flag  with supports_system_suspend.
> Changes since v1:
> 	- Fixed compilation errors.
> ---
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 76 ++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ccf6953..9dd50fc0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -44,6 +44,9 @@
>  #define PCIE20_PARF_PM_CTRL			0x20
>  #define REQ_NOT_ENTR_L1				BIT(5)
>  
> +#define PCIE20_PARF_PM_STTS			0x24
> +#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB	BIT(8)
> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -211,6 +214,8 @@ struct qcom_pcie_ops {
>  	void (*post_deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> +	int (*suspend)(struct qcom_pcie *pcie);
> +	int (*resume)(struct qcom_pcie *pcie);

This is really the wrong direction. We don't need the DWC driver 
defining per platform ops and then a platform defining sub-platform ops. 
IOW, qcom_pcie_ops should go away.

But for now, you don't even need the ops as only 1 version is 
implemented. Do you really expect other versions to do something 
different than turn off clocks and phys?

>  };
>  
>  struct qcom_pcie_cfg {
> @@ -219,6 +224,7 @@ struct qcom_pcie_cfg {
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
>  	unsigned int has_aggre1_clk:1;
> +	unsigned int supports_system_suspend:1;
>  };
>  
>  struct qcom_pcie {
> @@ -229,6 +235,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_cfg *cfg;
> +	unsigned int is_suspended:1;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1297,6 +1304,29 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
> +static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	int ret;
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
> +	return 0;
> +}
> +
>  static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> @@ -1590,6 +1620,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.config_sid = qcom_pcie_config_sid_sm8250,
> +	.suspend = qcom_pcie_suspend_2_7_0,
> +	.resume = qcom_pcie_resume_2_7_0,
>  };
>  
>  /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
> @@ -1655,6 +1687,7 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>  static const struct qcom_pcie_cfg sc7280_cfg = {
>  	.ops = &ops_1_9_0,
>  	.has_tbu_clk = true,
> +	.supports_system_suspend = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc8180x_cfg = {
> @@ -1760,6 +1793,48 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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

If anything, this looks like the version specific code.

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
> +	if (!pcie->is_suspended)
> +		return 0;

Pretty sure the driver core should take care of not calling resume if 
not suspended.

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
> @@ -1796,6 +1871,7 @@ static struct platform_driver qcom_pcie_driver = {
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
