Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C3574AEF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiGNKl3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 06:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiGNKl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 06:41:27 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9AA4AD62;
        Thu, 14 Jul 2022 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657795286; x=1689331286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4m0nVoik1JDg6vMtfsVmoRpjewhXoiEOBS1XwgEx6VI=;
  b=TtJs3E0JtNNEuWmbhFS1TiDxCknP0UEaRcCytg5M95eP2hfZat6elnUW
   irSFUQcs9Zt7ve/YrWVVJdAYeqDf6Fm1RgDMmJYv2sbXwNB/InjdYF8+4
   07VsbJlVCucyjFVkq0pDoaR0Ezh3VCKVoh+cERzW6sLCRtq60l8CzC6cR
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jul 2022 03:41:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 03:41:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 03:41:25 -0700
Received: from [10.216.15.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 03:41:17 -0700
Message-ID: <fda73692-8733-50b0-938b-56b3ff4855a7@quicinc.com>
Date:   Thu, 14 Jul 2022 16:11:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/2] PCI: qcom: Add system PM support
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-2-git-send-email-quic_krichai@quicinc.com>
 <Ysyb24TidwWFH0Dm@google.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <Ysyb24TidwWFH0Dm@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/12/2022 3:23 AM, Matthias Kaehlcke wrote:
> On Wed, Jul 06, 2022 at 08:10:24PM +0530, Krishna chaitanya chundru wrote:
>> Add suspend and resume pm callbacks.
>>
>> When system suspends, and if the link is in L1ss, disable the clocks
>> and power down the phy so that system enters into low power state to
>> save the maximum power. And when the system resumes, enable the clocks
>> back and power on phy if they are disabled in the suspend path.
>>
>> we are doing this only when link is in l1ss but not in L2/L3 as
>> no where we are forcing link to L2/L3 by sending PME turn off.
>>
>> is_suspended flag indicates if the clocks are disabled in the suspend
>> path or not. And this flag is being used to restrict the access to
>> config space, dbi etc when clock are turned-off.
>>
>> Changes since v3:
>> 	- Powering down the phy in suspend and powering it on resume to
>> 	  acheive maximum power savings.
>> Changes since v2:
>> 	- Replaced the enable, disable clks ops with suspend and resume
>> 	- Renamed support_pm_opsi flag  with supports_system_suspend.
>> Changes since v1:
>> 	- Fixed compilation errors.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 6ab9089..0a9d1ee 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -41,6 +41,9 @@
>>   #define L23_CLK_RMV_DIS				BIT(2)
>>   #define L1_CLK_RMV_DIS				BIT(1)
>>   
>> +#define PCIE20_PARF_PM_STTS                     0x24
>> +#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB    BIT(8)
>> +
>>   #define PCIE20_PARF_PHY_CTRL			0x40
>>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
>>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
>> @@ -190,6 +193,8 @@ struct qcom_pcie_ops {
>>   	void (*post_deinit)(struct qcom_pcie *pcie);
>>   	void (*ltssm_enable)(struct qcom_pcie *pcie);
>>   	int (*config_sid)(struct qcom_pcie *pcie);
>> +	int (*suspend)(struct qcom_pcie *pcie);
>> +	int (*resume)(struct qcom_pcie *pcie);
>>   };
>>   
>>   struct qcom_pcie_cfg {
>> @@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
>>   	unsigned int has_ddrss_sf_tbu_clk:1;
>>   	unsigned int has_aggre0_clk:1;
>>   	unsigned int has_aggre1_clk:1;
>> +	unsigned int supports_system_suspend:1;
>>   };
>>   
>>   struct qcom_pcie {
>> @@ -209,6 +215,7 @@ struct qcom_pcie {
>>   	struct phy *phy;
>>   	struct gpio_desc *reset;
>>   	const struct qcom_pcie_cfg *cfg;
>> +	unsigned int is_suspended:1;
>>   };
>>   
>>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>> @@ -1308,6 +1315,33 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>>   	clk_disable_unprepare(res->pipe_clk);
>>   }
>>   
>> +static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>> +	int ret;
>> +
>> +	clk_prepare_enable(res->pipe_clk);
>> +
>> +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>> +
>> +	phy_power_on(pcie->phy);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>> +
>> +	phy_power_off(pcie->phy);
>> +
>> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>> +
>> +	clk_disable_unprepare(res->pipe_clk);
>> +
>> +	return 0;
>> +}
>> +
>>   static int qcom_pcie_link_up(struct dw_pcie *pci)
>>   {
>>   	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> @@ -1496,6 +1530,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>>   	.post_init = qcom_pcie_post_init_2_7_0,
>>   	.post_deinit = qcom_pcie_post_deinit_2_7_0,
>>   	.config_sid = qcom_pcie_config_sid_sm8250,
>> +	.suspend = qcom_pcie_suspend_2_7_0,
>> +	.resume = qcom_pcie_resume_2_7_0,
>>   };
>>   
>>   static const struct qcom_pcie_cfg apq8084_cfg = {
>> @@ -1548,6 +1584,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>>   	.ops = &ops_1_9_0,
>>   	.has_tbu_clk = true,
>>   	.pipe_clk_need_muxing = true,
>> +	.supports_system_suspend = true,
>>   };
>>   
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>> @@ -1591,6 +1628,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   	pcie->cfg = pcie_cfg;
>>   
>> +	pcie->is_suspended = false;
>> +
>>   	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(pcie->reset)) {
>>   		ret = PTR_ERR(pcie->reset);
>> @@ -1645,6 +1684,51 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> +static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
>> +{
>> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>> +	u32 val;
>> +
>> +	if (!pcie->cfg->supports_system_suspend)
>> +		return 0;
>> +
>> +	/* if the link is not in l1ss don't turn off clocks */
>> +	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> +	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> +		dev_warn(dev, "Link is not in L1ss\n");
>> +		return 0;
>> +	}
>> +
>> +	if (pcie->cfg->ops->suspend)
>> +		pcie->cfg->ops->suspend(pcie);
>> +
>> +	pcie->is_suspended = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
>> +{
>> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>> +
>> +	if (!pcie->cfg->supports_system_suspend)
>> +		return 0;
> The above check can be omitted, it is implied by the next one.
> 'is_suspended' can only be true when system suspend is supported.
Sure will remove in the next patch.
>
>> +
>> +	if (!pcie->is_suspended)
>> +		return 0;
>> +
>> +	if (pcie->cfg->ops->resume)
>> +		pcie->cfg->ops->resume(pcie);
>> +
>> +	pcie->is_suspended = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
>> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
>> +};
>> +
>>   static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>>   	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
>> @@ -1679,6 +1763,7 @@ static struct platform_driver qcom_pcie_driver = {
>>   	.probe = qcom_pcie_probe,
>>   	.driver = {
>>   		.name = "qcom-pcie",
>> +		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
>>   		.suppress_bind_attrs = true,
>>   		.of_match_table = qcom_pcie_match,
>>   	},
>> -- 
>> 2.7.4
>>
