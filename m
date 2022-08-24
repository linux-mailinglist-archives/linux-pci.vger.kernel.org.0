Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1926759F26B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 06:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiHXEL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 00:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiHXEL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 00:11:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB57F26A;
        Tue, 23 Aug 2022 21:11:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O2CANj026822;
        Wed, 24 Aug 2022 04:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=44BWH+hct8TPh5ccWX+6MR59QqDnj6cn0koyYDZmd+U=;
 b=mFXEZIwRYIOyJ0bjlATwbDAMb7/liqQR9gw+w2XfGDJjg1YHln4EOQlYFCP3Rv3mTuWd
 dpPGJybLdsYwnu+0msbuGSxrkoa83kgfKa/NehbF/3Ajnm6rIoHgUENit6saRSJcmnrE
 PqX48bj0VziMoTzwein50X3LsL/g7d6qNwl3xDKZJl3M7pOI1Pgxn472EHV1GDXDmtCG
 INQfl2clOoomNq9rI9UwWpX2WAyxSMQbw+Mov29wNr5o71qZd81NKxkA5JHJp9EPE9XB
 w/fjLXvHf8sdGXQ+meb6CUU6qvu0flIkktvmMXTtTvIiRWl597R3124Y47ieohvkzTUN iw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pq9vnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 04:11:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27O4Bf4v012422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 04:11:41 GMT
Received: from [10.216.7.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 21:11:33 -0700
Message-ID: <14238cf7-894c-44e2-1404-c05e55940771@quicinc.com>
Date:   Wed, 24 Aug 2022 09:41:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/3] PCI: qcom: Add system PM support
Content-Language: en-US
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        <dmitry.baryshkov@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-2-git-send-email-quic_krichai@quicinc.com>
 <20220810215022.GC557589-robh@kernel.org>
 <be3ff287-56bc-1d71-3ae9-da6a9658479d@quicinc.com>
In-Reply-To: <be3ff287-56bc-1d71-3ae9-da6a9658479d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Frs4-vWEjadWx-zgYBUJvCeGCzQnG8pI
X-Proofpoint-GUID: Frs4-vWEjadWx-zgYBUJvCeGCzQnG8pI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_02,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/24/2022 8:58 AM, Krishna Chaitanya Chundru wrote:
>
> On 8/11/2022 3:20 AM, Rob Herring wrote:
>> On Wed, Aug 03, 2022 at 04:58:52PM +0530, Krishna chaitanya chundru 
>> wrote:
>>> Add suspend and resume pm callbacks.
>>>
>>> When system suspends, and if the link is in L1ss, disable the clocks
>>> and power down the phy so that system enters into low power state to
>>> save the maximum power. And when the system resumes, enable the clocks
>>> back and power on phy if they are disabled in the suspend path.
>>>
>>> we are doing this only when link is in l1ss but not in L2/L3 as
>>> no where we are forcing link to L2/L3 by sending PME turn off.
>>>
>>> is_suspended flag indicates if the clocks are disabled in the suspend
>>> path or not. And this flag is being used to restrict the access to
>>> config space, dbi etc when clock are turned-off.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>> Changes since v4:
>>>     - Rebasing the code and removed the supports_system_suspend flag
>>>     - in the resume path as is_suspended will serve its purpose.
>>> Changes since v3:
>>>     - Powering down the phy in suspend and powering it on resume to
>>>       acheive maximum power savings.
>>> Changes since v2:
>>>     - Replaced the enable, disable clks ops with suspend and resume
>>>     - Renamed support_pm_opsi flag  with supports_system_suspend.
>>> Changes since v1:
>>>     - Fixed compilation errors.
>>> ---
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 76 
>>> ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 76 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>>> b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index ccf6953..9dd50fc0 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -44,6 +44,9 @@
>>>   #define PCIE20_PARF_PM_CTRL            0x20
>>>   #define REQ_NOT_ENTR_L1                BIT(5)
>>>   +#define PCIE20_PARF_PM_STTS            0x24
>>> +#define PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB    BIT(8)
>>> +
>>>   #define PCIE20_PARF_PHY_CTRL            0x40
>>>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK    GENMASK(20, 16)
>>>   #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)        ((x) << 16)
>>> @@ -211,6 +214,8 @@ struct qcom_pcie_ops {
>>>       void (*post_deinit)(struct qcom_pcie *pcie);
>>>       void (*ltssm_enable)(struct qcom_pcie *pcie);
>>>       int (*config_sid)(struct qcom_pcie *pcie);
>>> +    int (*suspend)(struct qcom_pcie *pcie);
>>> +    int (*resume)(struct qcom_pcie *pcie);
>> This is really the wrong direction. We don't need the DWC driver
>> defining per platform ops and then a platform defining sub-platform ops.
>> IOW, qcom_pcie_ops should go away.
>>
>> But for now, you don't even need the ops as only 1 version is
>> implemented. Do you really expect other versions to do something
>> different than turn off clocks and phys?
> We will remove this in next patch.

Rob, each version is having a clk structure for example we are using 
"struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;"

This we can't keep these in the common function. so for that reason I 
added these suspend and resume ops.

>>
>>>   };
>>>     struct qcom_pcie_cfg {
>>> @@ -219,6 +224,7 @@ struct qcom_pcie_cfg {
>>>       unsigned int has_ddrss_sf_tbu_clk:1;
>>>       unsigned int has_aggre0_clk:1;
>>>       unsigned int has_aggre1_clk:1;
>>> +    unsigned int supports_system_suspend:1;
>>>   };
>>>     struct qcom_pcie {
>>> @@ -229,6 +235,7 @@ struct qcom_pcie {
>>>       struct phy *phy;
>>>       struct gpio_desc *reset;
>>>       const struct qcom_pcie_cfg *cfg;
>>> +    unsigned int is_suspended:1;
>>>   };
>>>     #define to_qcom_pcie(x) dev_get_drvdata((x)->dev)
>>> @@ -1297,6 +1304,29 @@ static void qcom_pcie_deinit_2_7_0(struct 
>>> qcom_pcie *pcie)
>>>       regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>>>   }
>>>   +static int qcom_pcie_resume_2_7_0(struct qcom_pcie *pcie)
>>> +{
>>> +    struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>>> +    int ret;
>>> +
>>> +    ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>>> +
>>> +    phy_power_on(pcie->phy);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
>>> +{
>>> +    struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>>> +
>>> +    phy_power_off(pcie->phy);
>>> +
>>> +    clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>>>   {
>>>       struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>>> @@ -1590,6 +1620,8 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>>>       .deinit = qcom_pcie_deinit_2_7_0,
>>>       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>>       .config_sid = qcom_pcie_config_sid_sm8250,
>>> +    .suspend = qcom_pcie_suspend_2_7_0,
>>> +    .resume = qcom_pcie_resume_2_7_0,
>>>   };
>>>     /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
>>> @@ -1655,6 +1687,7 @@ static const struct qcom_pcie_cfg 
>>> sm8450_pcie1_cfg = {
>>>   static const struct qcom_pcie_cfg sc7280_cfg = {
>>>       .ops = &ops_1_9_0,
>>>       .has_tbu_clk = true,
>>> +    .supports_system_suspend = true,
>>>   };
>>>     static const struct qcom_pcie_cfg sc8180x_cfg = {
>>> @@ -1760,6 +1793,48 @@ static int qcom_pcie_probe(struct 
>>> platform_device *pdev)
>>>       return ret;
>>>   }
>>>   +static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
>>> +{
>>> +    struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +    u32 val;
>>> +
>>> +    if (!pcie->cfg->supports_system_suspend)
>>> +        return 0;
>>> +
>>> +    /* if the link is not in l1ss don't turn off clocks */
>>> +    val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>>> +    if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>>> +        dev_warn(dev, "Link is not in L1ss\n");
>>> +        return 0;
>>> +    }
>> If anything, this looks like the version specific code.
>
> This is common for all qcom specific code. Here we are checking for 
> link is in l1ss or not
>
> If the link is present in l1ss only we go ahead turn off clocks and phy.
>
>>
>>> +
>>> +    if (pcie->cfg->ops->suspend)
>>> +        pcie->cfg->ops->suspend(pcie);
>>> +
>>> +    pcie->is_suspended = true;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int __maybe_unused qcom_pcie_pm_resume(struct device *dev)
>>> +{
>>> +    struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +
>>> +    if (!pcie->is_suspended)
>>> +        return 0;
>> Pretty sure the driver core should take care of not calling resume if
>> not suspended.
>
> We are returning success in suspend call even if we didn't turn off 
> clocks/phy. so I am using
>
> this flag to know the clocks are off/not.
>
>>
>>> +
>>> +    if (pcie->cfg->ops->resume)
>>> +        pcie->cfg->ops->resume(pcie);
>>> +
>>> +    pcie->is_suspended = false;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
>>> +    NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend, 
>>> qcom_pcie_pm_resume)
>>> +};
>>> +
>>>   static const struct of_device_id qcom_pcie_match[] = {
>>>       { .compatible = "qcom,pcie-apq8084", .data = &apq8084_cfg },
>>>       { .compatible = "qcom,pcie-ipq8064", .data = &ipq8064_cfg },
>>> @@ -1796,6 +1871,7 @@ static struct platform_driver qcom_pcie_driver 
>>> = {
>>>       .probe = qcom_pcie_probe,
>>>       .driver = {
>>>           .name = "qcom-pcie",
>>> +        .pm = pm_sleep_ptr(&qcom_pcie_pm_ops),
>>>           .suppress_bind_attrs = true,
>>>           .of_match_table = qcom_pcie_match,
>>>       },
>>> -- 
>>> 2.7.4
>>>
