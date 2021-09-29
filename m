Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF141C8C0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbhI2Pxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 11:53:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10361 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343513AbhI2Pxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 11:53:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632930721; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bgfs1WiHa8R4UyE5krDVvDskM/Fq6lG5GU3yWkPsvJg=;
 b=WbGLQTiKWhNKwPG6deJbsHc+pUZNr3259IjQv3gRBUsPCnXMSMfFdBoSXq4YNJAIE0CbA2QR
 p3GWxpOXdRcTtmogZxRncNUXqkSgA163oKi3EQADi9bBOu8Yt/kndTJoTIRxK1PwP3TGZSxs
 +9WPKgtjc2QN72+KbpzryIS/7N0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61548b93713d5d6f962d4e5d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Sep 2021 15:51:47
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0B51C4360D; Wed, 29 Sep 2021 15:51:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F32DC4360C;
        Wed, 29 Sep 2021 15:51:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Sep 2021 21:21:45 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
In-Reply-To: <20210928162148.GA701581@bhelgaas>
References: <20210928162148.GA701581@bhelgaas>
Message-ID: <b4e57cf0694f1a07ccf835d81d556bcc@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-09-28 21:51, Bjorn Helgaas wrote:
> [+cc linux-pci; please cc drivers/pci changes there]

Sure Bjorn, I missed to add the lists. I will cc from next release.
> 
> On Tue, Sep 28, 2021 at 07:25:50PM +0530, Prasad Malisetty wrote:
>> On the SC7280, the clock source for gcc_pcie_1_pipe_clk_src
>> must be the TCXO while gdsc is enabled. After PHY init successful
>> clock source should switch to pipe clock for gcc_pcie_1_pipe_clk_src.
> 
> This looks good.  Ideally the commit log would say what the patch
> *does*.  I know it's in the subject, but it's nice to have it both
> places so the body is complete in itself.
> 
> Again in an ideal world, I would split this into two patches:
> 
>   1) Do the boilerplate conversions to struct qcom_pcie_cfg and
>   updates of qcom_pcie_match[].  This patch would have no functional
>   change.
> 
>   2) Add the code to deal with pcie_1_pipe_clk_src, which should be a
>   much smaller patch.
> 
> This makes it easier to see the important part of dealing with
> pcie_1_pipe_clk_src and makes any future bisect much more specific.
> 

Hi Bjorn,

Thanks for the suggestion.

I will split [Patch v9 4/4] patch into two separate changes and update 
in next version series.

Thanks
-Prasad


>> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 94 
>> ++++++++++++++++++++++++++++++----
>>  1 file changed, 83 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 8a7a300..7896a86 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -166,6 +166,9 @@ struct qcom_pcie_resources_2_7_0 {
>>  	struct regulator_bulk_data supplies[2];
>>  	struct reset_control *pci_reset;
>>  	struct clk *pipe_clk;
>> +	struct clk *pipe_clk_src;
>> +	struct clk *phy_pipe_clk;
>> +	struct clk *ref_clk_src;
>>  };
>> 
>>  union qcom_pcie_resources {
>> @@ -189,6 +192,11 @@ struct qcom_pcie_ops {
>>  	int (*config_sid)(struct qcom_pcie *pcie);
>>  };
>> 
>> +struct qcom_pcie_cfg {
>> +	const struct qcom_pcie_ops *ops;
>> +	unsigned int pipe_clk_need_muxing:1;
>> +};
>> +
>>  struct qcom_pcie {
>>  	struct dw_pcie *pci;
>>  	void __iomem *parf;			/* DT parf */
>> @@ -197,6 +205,7 @@ struct qcom_pcie {
>>  	struct phy *phy;
>>  	struct gpio_desc *reset;
>>  	const struct qcom_pcie_ops *ops;
>> +	unsigned int pipe_clk_need_muxing:1;
>>  };
>> 
>>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>> @@ -1167,6 +1176,20 @@ static int qcom_pcie_get_resources_2_7_0(struct 
>> qcom_pcie *pcie)
>>  	if (ret < 0)
>>  		return ret;
>> 
>> +	if (pcie->pipe_clk_need_muxing) {
>> +		res->pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>> +		if (IS_ERR(res->pipe_clk_src))
>> +			return PTR_ERR(res->pipe_clk_src);
>> +
>> +		res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
>> +		if (IS_ERR(res->phy_pipe_clk))
>> +			return PTR_ERR(res->phy_pipe_clk);
>> +
>> +		res->ref_clk_src = devm_clk_get(dev, "ref");
>> +		if (IS_ERR(res->ref_clk_src))
>> +			return PTR_ERR(res->ref_clk_src);
>> +	}
>> +
>>  	res->pipe_clk = devm_clk_get(dev, "pipe");
>>  	return PTR_ERR_OR_ZERO(res->pipe_clk);
>>  }
>> @@ -1185,6 +1208,10 @@ static int qcom_pcie_init_2_7_0(struct 
>> qcom_pcie *pcie)
>>  		return ret;
>>  	}
>> 
>> +	/* Set TCXO as clock source for pcie_pipe_clk_src */
>> +	if (pcie->pipe_clk_need_muxing)
>> +		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
>> +
>>  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>>  	if (ret < 0)
>>  		goto err_disable_regulators;
>> @@ -1256,6 +1283,10 @@ static int qcom_pcie_post_init_2_7_0(struct 
>> qcom_pcie *pcie)
>>  {
>>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>> 
>> +	/* Set pipe clock as clock source for pcie_pipe_clk_src */
>> +	if (pcie->pipe_clk_need_muxing)
>> +		clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
>> +
>>  	return clk_prepare_enable(res->pipe_clk);
>>  }
>> 
>> @@ -1456,6 +1487,39 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>>  	.config_sid = qcom_pcie_config_sid_sm8250,
>>  };
>> 
>> +static const struct qcom_pcie_cfg apq8084_cfg = {
>> +	.ops = &ops_1_0_0,
>> +};
>> +
>> +static const struct qcom_pcie_cfg ipq8064_cfg = {
>> +	.ops = &ops_2_1_0,
>> +};
>> +
>> +static const struct qcom_pcie_cfg msm8996_cfg = {
>> +	.ops = &ops_2_3_2,
>> +};
>> +
>> +static const struct qcom_pcie_cfg ipq8074_cfg = {
>> +	.ops = &ops_2_3_3,
>> +};
>> +
>> +static const struct qcom_pcie_cfg ipq4019_cfg = {
>> +	.ops = &ops_2_4_0,
>> +};
>> +
>> +static const struct qcom_pcie_cfg sdm845_cfg = {
>> +	.ops = &ops_2_7_0,
>> +};
>> +
>> +static const struct qcom_pcie_cfg sm8250_cfg = {
>> +	.ops = &ops_1_9_0,
>> +};
>> +
>> +static const struct qcom_pcie_cfg sc7280_cfg = {
>> +	.ops = &ops_1_9_0,
>> +	.pipe_clk_need_muxing = true,
>> +};
>> +
>>  static const struct dw_pcie_ops dw_pcie_ops = {
>>  	.link_up = qcom_pcie_link_up,
>>  	.start_link = qcom_pcie_start_link,
>> @@ -1467,6 +1531,7 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>>  	struct pcie_port *pp;
>>  	struct dw_pcie *pci;
>>  	struct qcom_pcie *pcie;
>> +	const struct qcom_pcie_cfg *pcie_cfg;
>>  	int ret;
>> 
>>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> @@ -1488,7 +1553,13 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>> 
>>  	pcie->pci = pci;
>> 
>> -	pcie->ops = of_device_get_match_data(dev);
>> +	pcie_cfg = of_device_get_match_data(dev);
>> +	pcie->ops = pcie_cfg->ops;
>> +	if (!pcie->ops) {
>> +		dev_err(dev, "Invalid platform data\n");
>> +		return -EINVAL;
>> +	}
>> +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>> 
>>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>>  	if (IS_ERR(pcie->reset)) {
>> @@ -1545,16 +1616,17 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>>  }
>> 
>>  static const struct of_device_id qcom_pcie_match[] = {
>> -	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
>> -	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
>> -	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ops_2_1_0 },
>> -	{ .compatible = "qcom,pcie-apq8064", .data = &ops_2_1_0 },
>> -	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
>> -	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
>> -	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
>> -	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>> -	{ .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
>> -	{ .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
>> +	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>> +	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
>> +	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &ipq8064_cfg },
>> +	{ .compatible = "qcom,pcie-apq8064", .data = &ipq8064_cfg },
>> +	{ .compatible = "qcom,pcie-msm8996", .data = &msm8996_cfg },
>> +	{ .compatible = "qcom,pcie-ipq8074", .data = &ipq8074_cfg },
>> +	{ .compatible = "qcom,pcie-ipq4019", .data = &ipq4019_cfg },
>> +	{ .compatible = "qcom,pcie-qcs404", .data = &ipq4019_cfg },
>> +	{ .compatible = "qcom,pcie-sdm845", .data = &sdm845_cfg },
>> +	{ .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>> +	{ .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>>  	{ }
>>  };
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
