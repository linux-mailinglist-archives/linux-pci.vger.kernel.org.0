Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0425B3DFB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIIRb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIIRbZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 13:31:25 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1EFB8D7
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 10:31:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r7so1154002ile.11
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/eGKaEiCZjmPKanslXnnh3bHkTJzXk05/PwLm46dbac=;
        b=J3BYQ2voGu2035nikaOERZPk2oYzwR5jLu0PzFbfb4H81EJGqng5ycF/gUXLR74lrG
         o8UjQXNj8LpP+pXhAAMtn4wqdO5DfCoAu0rzgDku4TKkuRqsbXCr/jdGEK97AmBJs5un
         s29OAS3EuCsKKcV1KJZsCYUiyZfOVHttJ+51s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/eGKaEiCZjmPKanslXnnh3bHkTJzXk05/PwLm46dbac=;
        b=Y90V1dTQU72Gp4se3ZHeAXgI3kgFtYOCreybBsvvj+NKxrbAjhaL3rr8eiEJHhCzvo
         NX21/RFqsWTrsBMTCdQgFenS3lZyAdq1sw4xIc1gXoEk2+91JUWR0cjXz6kWjUx9Qpbt
         UQc6OLCteoDO1Er1smp7De6yn300mx4LcuXUh1UVYYZC6+G9fo0xM1IUvo3+/cLf3GMz
         rPsvcDuZD36eYeDjjWRAO769Wbt1f3iHgujdpdBdGxOaTeBUtZE1vKclvb1noxXn9vC6
         vcKlgzR68sTNLH5Fgl8gK2O+np81f6K7Av4UUESIfbzYTtk8pOEOgl8jCWIHd9QCAU29
         ZbEQ==
X-Gm-Message-State: ACgBeo2DXk/icx/RR4FeW0Mn/KcTumNXPeILWMKr7zGAvNI8UZgc8SF8
        hxekGy0nTFebNWX2D7sn6T+kEQ==
X-Google-Smtp-Source: AA6agR7U3yApdA2FaHgvc2+dRTl09DrAsaQPpPZDvzDtWiHx9T7uWd5chKfHz5dV2sZIHl3nxOPX3w==
X-Received: by 2002:a92:d5cf:0:b0:2e9:4cb4:57e4 with SMTP id d15-20020a92d5cf000000b002e94cb457e4mr4652825ilq.224.1662744682356;
        Fri, 09 Sep 2022 10:31:22 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id f14-20020a926a0e000000b002eae2ef6924sm372166ilc.7.2022.09.09.10.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:31:20 -0700 (PDT)
Date:   Fri, 9 Sep 2022 17:31:18 +0000
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
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 1/5] PCI: qcom: Add system suspend and resume support
Message-ID: <Yxt4Zv2ocKW1/Bf+@google.com>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
 <1662713084-8106-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1662713084-8106-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 02:14:40PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume syscore ops.
> 
> When system suspends and if the link is in L1ss, disable the clocks
> and power down the phy so that system enters into low power state to
> save the maximum power. And when the system resumes, enable the clocks
> back and power on phy if they are disabled in the suspend path.
> 
> we are doing this only when link is in l1ss but not in L2/L3 as
> nowhere we are forcing link to L2/L3 by sending PME turn off.
> 
> is_suspended flag indicates if the clocks are disabled in the suspend
> path or not.
> 
> There is access to Ep PCIe space to mask MSI/MSIX after pm suspend ops
> (getting hit by affinity changes while making CPUs offline during suspend,
> this will happen after devices are suspended (all phases of suspend ops)).
> When registered with pm ops there is a crash due to un-clocked access,
> as in the pm suspend op clocks are disabled. So, registering with syscore
> ops which will called after making CPUs offline.

My knowledge of PCI is limited, but given the issues you are seeing which
don't seem to impact other DWC drivers I wonder if keeping the link in
l1ss is the right thing to do. The intel, tegra and imx6 drivers all turn
the PME off, which IIUC results in the link to transition ot L2 or L3.
Shouldn't the QC driver do the same?

Some more comments inline, for if the current approach moves forward.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> changes since v5:
> 	- Rebasing the code and replaced pm ops with syscore ops as
> 	  we are getting acciess to pci region after pm ops. syscore ops
> 	  will called after disabling non boot cpus and there is no pci
> 	  access after that.
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
>  drivers/pci/controller/dwc/pcie-qcom.c | 140 ++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 39ca06f..6e04d0d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -27,6 +27,7 @@
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/syscore_ops.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> @@ -44,6 +45,9 @@
>  #define PCIE20_PARF_PM_CTRL			0x20
>  #define REQ_NOT_ENTR_L1				BIT(5)
>  
> +#define PCIE20_PARF_PM_STTS			0x24
> +#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB	BIT(8)
> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>  #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
> @@ -122,6 +126,8 @@
>  
>  #define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
>  
> +static LIST_HEAD(qcom_pcie_list);
> +
>  struct qcom_pcie_resources_2_1_0 {
>  	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
>  	struct reset_control *pci_reset;
> @@ -211,13 +217,21 @@ struct qcom_pcie_ops {
>  	void (*post_deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> +	int (*suspend)(struct qcom_pcie *pcie);
> +	int (*resume)(struct qcom_pcie *pcie);
>  };
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	/*
> +	 * Flag ensures which devices will turn off clks, phy
> +	 * in system suspend.
> +	 */
> +	unsigned int supports_system_suspend:1;
>  };
>  
>  struct qcom_pcie {
> +	struct list_head list;	/* list to probed instances */
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
>  	void __iomem *elbi;			/* DT elbi */
> @@ -225,10 +239,14 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_cfg *cfg;
> +	unsigned int is_suspended:1;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static int __maybe_unused qcom_pcie_syscore_op_suspend(void);
> +static void __maybe_unused qcom_pcie_syscore_op_resume(void);
> +
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value_cansleep(pcie->reset, 1);
> @@ -1301,6 +1319,28 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
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
> +	return 0;
> +}
> +
>  static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> @@ -1594,6 +1634,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.config_sid = qcom_pcie_config_sid_sm8250,
> +	.suspend = qcom_pcie_suspend_2_7_0,
> +	.resume = qcom_pcie_resume_2_7_0,
>  };
>  
>  /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
> @@ -1613,6 +1655,11 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
>  	.ops = &ops_1_9_0,
>  };
>  
> +static const struct qcom_pcie_cfg sc7280_cfg = {
> +	.ops = &ops_1_9_0,
> +	.supports_system_suspend = true,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_2_1_0 = {
>  	.ops = &ops_2_1_0,
>  };
> @@ -1642,6 +1689,23 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = qcom_pcie_start_link,
>  };
>  
> +/*
> + * There is access to Ep PCIe space to mask MSI/MSIX after pm suspend
> + * ops.(getting hit by affinity changes while making CPUs offline during
> + * suspend, this will happen after devices are suspended
> + * (all phases of suspend ops)).
> + *
> + * When registered with pm ops there is a crash due to un-clocked access,
> + * as in the pm suspend op clocks are disabled.
> + *
> + * So, registering with syscore ops which will called after making
> + * CPU's offline.
> + */
> +static struct syscore_ops qcom_pcie_syscore_ops = {
> +	.suspend = qcom_pcie_syscore_op_suspend,
> +	.resume = qcom_pcie_syscore_op_resume,
> +};
> +
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1720,6 +1784,17 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> +	/* Register for syscore ops only when first instance probed */
> +	if (list_empty(&qcom_pcie_list))
> +		register_syscore_ops(&qcom_pcie_syscore_ops);
> +
> +	/*
> +	 * Add the qcom_pcie list of each PCIe instance probed to
> +	 * the global list so that we use it iterate through each PCIe
> +	 * instance in the syscore ops.
> +	 */
> +	list_add_tail(&pcie->list, &qcom_pcie_list);
> +
>  	return 0;
>  
>  err_phy_exit:
> @@ -1731,6 +1806,69 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	if (!pcie->cfg->supports_system_suspend)
> +		return 0;

This check could be done in qcom_pcie_syscore_op_suspend()

> +
> +	/* if the link is not active turn off clocks */
> +	if (!dw_pcie_link_up(pci)) {
> +		dev_info(dev, "Link is not active\n");

level info seems to verbose, it's not particularly interesting that the
link is not active, except for debugging.

> +		goto suspend;
> +	}
> +
> +	/* if the link is not in l1ss don't turn off clocks */
> +	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> +	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> +		dev_warn(dev, "Link is not in L1ss\n");
> +		return 0;
> +	}

I think the following would be clearer:

  	if (dw_pcie_link_up(pci)) {
		/* if the link is not in l1ss don't turn off clocks */
		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
		if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
			dev_warn(dev, "Link is not in L1ss\n");
			return 0;
		}
	} else {
		dev_dbg(dev, "Link is not active\n");
	}

> +
> +suspend:
> +	if (pcie->cfg->ops->suspend)
> +		pcie->cfg->ops->suspend(pcie);
> +
> +	pcie->is_suspended = true;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_pcie_pm_resume(struct qcom_pcie *pcie)
> +{
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
> +static int __maybe_unused qcom_pcie_syscore_op_suspend(void)
> +{
> +	struct qcom_pcie *qcom_pcie;
> +
> +	list_for_each_entry(qcom_pcie, &qcom_pcie_list, list) {
> +		qcom_pcie_pm_suspend(qcom_pcie);
> +	}
> +	return 0;
> +}
> +
> +static void __maybe_unused qcom_pcie_syscore_op_resume(void)
> +{
> +	struct qcom_pcie *qcom_pcie;
> +
> +	list_for_each_entry(qcom_pcie, &qcom_pcie_list, list) {
> +		qcom_pcie_pm_resume(qcom_pcie);
> +	}
> +}
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> @@ -1742,7 +1880,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
> -- 
> 2.7.4
> 
