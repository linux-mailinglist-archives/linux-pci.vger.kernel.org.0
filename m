Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1C5616FD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiF3J7r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiF3J7q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 05:59:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BAC43ED3;
        Thu, 30 Jun 2022 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656583186; x=1688119186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PbCJIkwbMIohcJTtEctIOPXTf8+WgT696gxof40+8pQ=;
  b=kf4ME2AnebV1EFNKEizBRseF5rLAoTEIt669hZPluwpAVOyTmOMzCegp
   d4KQy0RUstIKRkguvPdj5hkDubY2g3vc+P4MQLMUS5O0Ed0l7k1lai61s
   XtJc9H/03yEtt84P1D91A1hpQiR1vSzfSBc4RCwe3f9MY7H1QOn4L0lrE
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Jun 2022 02:59:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:59:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 30 Jun 2022 02:59:44 -0700
Received: from [10.216.56.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 30 Jun
 2022 02:59:37 -0700
Message-ID: <4b1631f9-220f-c378-164c-f7eea9db22ef@quicinc.com>
Date:   Thu, 30 Jun 2022 15:29:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add system PM support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <swboyd@chromium.org>,
        <dmitry.baryshkov@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-2-git-send-email-quic_krichai@quicinc.com>
 <20220630043415.GA5012@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220630043415.GA5012@thinkpad>
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


On 6/30/2022 10:04 AM, Manivannan Sadhasivam wrote:
> On Wed, Jun 29, 2022 at 03:03:33PM +0530, Krishna chaitanya chundru wrote:
>> Add suspend and resume pm callbacks.
>>
>> When system suspends, and if the link is in L1ss, disable the clocks
>> so that system enters into low power state to save the maximum power.
>> And when the system resumes, enable the clocks back if they are
>> disabled in the suspend path.
>>
> Why only during L1ss and not L2/L3?

with aspm the link will automatically go to L1ss. for L2/L3 entry we 
need to explicitly send

PME turn off which we are not doing now. So we are checking only for L1ss.

>
>> Changes since v1:
>> 	- Fixed compilation errors.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 6ab9089..8e9ef37 100644
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
>> +	int (*enable_clks)(struct qcom_pcie *pcie);
>> +	int (*disable_clks)(struct qcom_pcie *pcie);
> I think these could vary between platforms. Like some other platform may try to
> disable regulators etc... So use names such as suspend and resume.
Sure will change in the next patch.
>>   };
>>   
>>   struct qcom_pcie_cfg {
>> @@ -199,6 +204,7 @@ struct qcom_pcie_cfg {
>>   	unsigned int has_ddrss_sf_tbu_clk:1;
>>   	unsigned int has_aggre0_clk:1;
>>   	unsigned int has_aggre1_clk:1;
>> +	unsigned int support_pm_ops:1;
>>   };
>>   
>>   struct qcom_pcie {
>> @@ -209,6 +215,7 @@ struct qcom_pcie {
>>   	struct phy *phy;
>>   	struct gpio_desc *reset;
>>   	const struct qcom_pcie_cfg *cfg;
>> +	unsigned int is_suspended:1;
> Why do you need this flag? Is suspend going to happen multiple times in
> an out-of-order manner?

We are using this flag in the resume function to check whether we 
suspended and disabled

the clocks in the suspend path. And we want to use this flag to control 
the access to dbi etc

after suspend.

>>   };
>>   
>>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>> @@ -1308,6 +1315,23 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>>   	clk_disable_unprepare(res->pipe_clk);
>>   }
>>   
> [...]
>
>> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, qcom_pcie_pm_resume)
> Use the new macro: NOIRQ_SYSTEM_SLEEP_PM_OPS
Will update in the next patch.
>> +};
>> +
>>   static const struct of_device_id qcom_pcie_match[] = {
>>   	{ .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>>   	{ .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
>> @@ -1679,6 +1759,7 @@ static struct platform_driver qcom_pcie_driver = {
>>   	.probe = qcom_pcie_probe,
>>   	.driver = {
>>   		.name = "qcom-pcie",
>> +		.pm = &qcom_pcie_pm_ops,
> There will be warnings when CONFIG_PM_SLEEP is not set. So use below,
will update in the next patch.
>
> 		.pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
>
> Thanks,
> Mani
>
>>   		.suppress_bind_attrs = true,
>>   		.of_match_table = qcom_pcie_match,
>>   	},
>> -- 
>> 2.7.4
>>
