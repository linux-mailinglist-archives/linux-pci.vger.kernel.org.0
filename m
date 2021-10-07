Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B36425967
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbhJGR22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 13:28:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29701 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbhJGR2G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 13:28:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633627572; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VkS6NmPattbLWc8+MxzPrbJcF68lr+JijAPN1npuoe0=;
 b=gQpYWQNjUwOcr2H/u1PtKNtDL8oL5TpPAaRa9s14XpjjfaUwHUJ1mQRP3tWntPIQY0rej+ma
 7EkaQf/zYLB7Y8/CH9G2lhLCcqYaiJCXqCBp3yt8KFoaoAQuksMb5h28NRM85xBiXwjXyDBh
 NptZ/11WZ7nNO38globqwdtgaNA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 615f2da7de4c4ed385a0394b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Oct 2021 17:25:59
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61317C4360D; Thu,  7 Oct 2021 17:25:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CC90C4338F;
        Thu,  7 Oct 2021 17:25:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Oct 2021 22:55:57 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 4/5] PCI: qcom: Add a flag in match data along with
 ops
In-Reply-To: <20211005192131.GA1111392@bhelgaas>
References: <20211005192131.GA1111392@bhelgaas>
Message-ID: <f06496757db7a5ba41c94ff14e9c2ef9@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-10-06 00:51, Bjorn Helgaas wrote:
> On Wed, Oct 06, 2021 at 12:12:38AM +0530, Prasad Malisetty wrote:
>> Add pipe_clk_need_muxing flag in match data and configure
>> If the platform needs to switch pipe_clk_src.
>> 
>> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 70 
>> ++++++++++++++++++++++++++++------
>>  1 file changed, 59 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 8a7a300..1d7a9cb 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -189,6 +189,11 @@ struct qcom_pcie_ops {
>>  	int (*config_sid)(struct qcom_pcie *pcie);
>>  };
>> 
>> +struct qcom_pcie_cfg {
>> +	const struct qcom_pcie_ops *ops;
>> +	unsigned int pipe_clk_need_muxing:1;
>> +};
> 
> Thanks for splitting this up; it's 90% of the way there.
> 
> It would be better if this patch added only the definition and use of
> qcom_pcie_cfg:
> 
>   +struct qcom_pcie_cfg {
>   +     const struct qcom_pcie_ops *ops;
>   +};
> 
> and then the subsequent patch added the clock muxing stuff:
> 
>    struct qcom_pcie_cfg {
>   +	unsigned int pipe_clk_need_muxing:1;
> 
>    struct qcom_pcie {
>   +	unsigned int pipe_clk_need_muxing:1;
> 
>    static const struct qcom_pcie_cfg sc7280_cfg = {
>   +	.pipe_clk_need_muxing = true,
> 
>   static int qcom_pcie_probe(struct platform_device *pdev)
>   +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
> 
> That way everything related to pipe_clk_need_muxing would be in a
> single patch.
> 
>>  struct qcom_pcie {
>>  	struct dw_pcie *pci;
>>  	void __iomem *parf;			/* DT parf */
>> @@ -197,6 +202,7 @@ struct qcom_pcie {
>>  	struct phy *phy;
>>  	struct gpio_desc *reset;
>>  	const struct qcom_pcie_ops *ops;
>> +	unsigned int pipe_clk_need_muxing:1;
>>  };
>> 
>>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>> @@ -1456,6 +1462,39 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>>  	.config_sid = qcom_pcie_config_sid_sm8250,
>>  };
>> 
Thanks Bjorn, Agree on it. I will incorporate the changes in next patch 
version.

-Prasad

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
>> @@ -1467,6 +1506,7 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>>  	struct pcie_port *pp;
>>  	struct dw_pcie *pci;
>>  	struct qcom_pcie *pcie;
>> +	const struct qcom_pcie_cfg *pcie_cfg;
>>  	int ret;
>> 
>>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> @@ -1488,7 +1528,14 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>> 
>>  	pcie->pci = pci;
>> 
>> -	pcie->ops = of_device_get_match_data(dev);
>> +	pcie_cfg = of_device_get_match_data(dev);
>> +	if (!pcie_cfg || !pcie_cfg->ops) {
>> +		dev_err(dev, "Invalid platform data\n");
>> +		return NULL;
>> +	}
>> +
>> +	pcie->ops = pcie_cfg->ops;
>> +	pcie->pipe_clk_need_muxing = pcie_cfg->pipe_clk_need_muxing;
>> 
>>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>>  	if (IS_ERR(pcie->reset)) {
>> @@ -1545,16 +1592,17 @@ static int qcom_pcie_probe(struct 
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
