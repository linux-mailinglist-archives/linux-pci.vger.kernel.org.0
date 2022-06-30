Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F18561043
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 06:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiF3Ee1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 00:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiF3Ee0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 00:34:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6873DA76
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 21:34:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c205so16996945pfc.7
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 21:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ve/vXBI5N+hLr5sCxzL7fj/EAUdEfCHLabZmvvVnHmI=;
        b=KOAdovB2Ezy8cAIx4fJetquqz+9T3XczFsn5nK3MTESaEEphQmvF32YhuUw2lTBVHb
         8EB+wkjBehfoXKzO7bCB2Zmdhh2tr6BRFZKsHy1F5RBPEUhIj4AsKyrKIJ0IuUwBqgrw
         qtZShd3TMB/o2g+TaXIG/cXlo4VaKm543PDLaGg5zT2VsLICzRCN6XnLYACYyE9eVsUO
         i7R1wF4khrGJ/9UHV+7+fhJoH4Oz0QdwCKDHUHjf7skkW7U6AkyiL0Dzhptt3XH4Vp7z
         MdESzhA7AyHQ4KmRRMQbfzUj6QO3YlzuegXXdSWluMugTFJ1V38lXZQf+WKAJki/nkUq
         eUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ve/vXBI5N+hLr5sCxzL7fj/EAUdEfCHLabZmvvVnHmI=;
        b=kZMkawY7t9VHLBF68ShZw2PYVDlhCbtbzVjkouun7XzL5w1XO+wEyrsza69sKEBIjG
         N687rYV9s02bJfnhODFvWuXuiKdC0P6EeMxDsG4JE4Cl6vY1wjZcPzUzlpkdSnCiGzwm
         54p6afmzmEhooFG97Qp0YFle+K1dnfLbR7GSkVFPWvQfvaUY8E6d1QZ9rBK+CYkhJEcV
         HroUb0daheHSUg9R1MbfacB1CDVql/aituhiOc+m1xCfN0gV140W5+yoIgHKCmKzpKUW
         KG0360eyOEDBF6lqeqUKhpRrgpLnPR0wCjPtbWB8V47u4Q4IS6ju7wAzjTpcMemzKxdg
         sAgg==
X-Gm-Message-State: AJIora+8SkGHuozXFuCALqxuG6/naTx96zYRRc9mLaPxvzDPs3cRJAAD
        r+BrLp3vQO+u1w9H4AtBblff
X-Google-Smtp-Source: AGRyM1s3sTW3qj/6y0W+Kw9RGDfAOKTyDtk1auDsy0RslDnd8VNf1JtWl1JkuAjacIc+qv0bFPij9w==
X-Received: by 2002:a63:210f:0:b0:40d:dd27:8361 with SMTP id h15-20020a63210f000000b0040ddd278361mr6034809pgh.306.1656563664914;
        Wed, 29 Jun 2022 21:34:24 -0700 (PDT)
Received: from thinkpad ([59.92.102.209])
        by smtp.gmail.com with ESMTPSA id t129-20020a625f87000000b005259578e8fcsm9061064pfb.181.2022.06.29.21.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 21:34:24 -0700 (PDT)
Date:   Thu, 30 Jun 2022 10:04:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add system PM support
Message-ID: <20220630043415.GA5012@thinkpad>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Why only during L1ss and not L2/L3?

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

I think these could vary between platforms. Like some other platform may try to
disable regulators etc... So use names such as suspend and resume.

>  };
>  
>  struct qcom_pcie_cfg {
> @@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
>  	unsigned int has_ddrss_sf_tbu_clk:1;
>  	unsigned int has_aggre0_clk:1;
>  	unsigned int has_aggre1_clk:1;
> +	unsigned int support_pm_ops:1;
>  };
>  
>  struct qcom_pcie {
> @@ -209,6 +215,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_cfg *cfg;
> +	unsigned int is_suspended:1;

Why do you need this flag? Is suspend going to happen multiple times in
an out-of-order manner?

>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1308,6 +1315,23 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->pipe_clk);
>  }
>  

[...]

> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)

Use the new macro: NOIRQ_SYSTEM_SLEEP_PM_OPS

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

There will be warnings when CONFIG_PM_SLEEP is not set. So use below,

		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),

Thanks,
Mani

>  		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
>  	},
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
