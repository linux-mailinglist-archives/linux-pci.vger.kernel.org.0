Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2E6FC1F7
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjEIItt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjEIIts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 04:49:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F542D79;
        Tue,  9 May 2023 01:49:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3497nu4O029362;
        Tue, 9 May 2023 08:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QCZXwawIslsED4/bUEvhU6+xKaK/cv0flb+GAJbEkU8=;
 b=LAF521o/QZT3S3Z7C6LNyJP/VvkhHyXTJ7L6GEcvNqYMNDCruzYjA5YLR7KJ1REhaFwT
 K+loZ+pxUuHil5B97mfB36GdCBzRMA+RliKFjvh0GIKSj1tXM753GHJ16AqnWDxgpBt4
 xUQsb6yuRUuG0JtYId76SRaRosCkxKt0TTUy9yWorBGEKxMBXjWsnl0CVYTfvh+pr+f7
 XqGUZMpeQ59X+xZAz69pgYr5VJ6yjlVKEvztokGWyscx/mcIz5qNYji4BaVQs54Qof1k
 PuuwDaMaIXXy0wHE4mAQwHeACC0iBgNduEJ2V1H04JRVU6CytxSGkahUCQTXu2N+xW8r mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf78517vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 08:49:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3498nYVX006825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 08:49:34 GMT
Received: from [10.242.243.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 01:49:27 -0700
Message-ID: <db9af421-ca06-9eea-bac8-e014e86f3d46@quicinc.com>
Date:   Tue, 9 May 2023 14:19:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 6/6] PCI: qcom: Add support for IPQ9574
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-7-quic_devipriy@quicinc.com>
 <20230508122109.GC4190@thinkpad>
 <CAA8EJppKUwfatdNoQPD4QbEPXyv1cEz3cDLfND+70Veq5Bcf8Q@mail.gmail.com>
 <20230508153706.GA14969@thinkpad>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230508153706.GA14969@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tudU81w-H5_j0Ro2mqG6Vni8wPy1erip
X-Proofpoint-GUID: tudU81w-H5_j0Ro2mqG6Vni8wPy1erip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_05,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090067
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/8/2023 9:07 PM, Manivannan Sadhasivam wrote:
> On Mon, May 08, 2023 at 03:46:53PM +0300, Dmitry Baryshkov wrote:
>> On Mon, 8 May 2023 at 15:21, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>
>>> On Fri, Apr 21, 2023 at 06:19:38PM +0530, Devi Priya wrote:
>>>> The IPQ9574 platform has 4 Gen3 PCIe controllers: two single-lane
>>>> and two dual-lane based on SNPS core 5.70a
>>>> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
>>>> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
>>>> which reuses all the members of 'ops_2_9_0' except for the post_init
>>>> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
>>>> and 1_27_0.
>>>> Also, modified get_resources of 'ops 2_9_0' to get the clocks
>>>> from the device tree and modelled the post init sequence as
>>>> a common function to avoid code redundancy.
>>>>
>>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>
>>> One comment below. With that fixed,
>>>
>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>
>>> - Mani
>>>
>>>> ---
>>>>   Changes in V3:
>>>>        - Rebased on top of linux-next/master
>>>>
>>>>   drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++--------
>>>>   1 file changed, 43 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 4ab30892f6ef..3682ecdead1f 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -107,6 +107,7 @@
>>>>
>>>>   /* PARF_SLV_ADDR_SPACE_SIZE register value */
>>>>   #define SLV_ADDR_SPACE_SZ                    0x10000000
>>>> +#define SLV_ADDR_SPACE_SZ_1_27_0             0x08000000
>>>>
>>>>   /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>>>>   #define AHB_CLK_EN                           BIT(0)
>>>> @@ -202,10 +203,10 @@ struct qcom_pcie_resources_2_7_0 {
>>>>        struct reset_control *rst;
>>>>   };
>>>>
>>>> -#define QCOM_PCIE_2_9_0_MAX_CLOCKS           5
>>>>   struct qcom_pcie_resources_2_9_0 {
>>>> -     struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
>>>> +     struct clk_bulk_data *clks;
>>>>        struct reset_control *rst;
>>>> +     int num_clks;
>>>>   };
>>>>
>>>>   union qcom_pcie_resources {
>>>> @@ -1050,17 +1051,10 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>>>>        struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>>>>        struct dw_pcie *pci = pcie->pci;
>>>>        struct device *dev = pci->dev;
>>>> -     int ret;
>>>>
>>>> -     res->clks[0].id = "iface";
>>>> -     res->clks[1].id = "axi_m";
>>>> -     res->clks[2].id = "axi_s";
>>>> -     res->clks[3].id = "axi_bridge";
>>>> -     res->clks[4].id = "rchng";
>>>> -
>>>> -     ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
>>>> -     if (ret < 0)
>>>> -             return ret;
>>>> +     res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
>>>> +     if (res->clks < 0)
>>>> +             return res->num_clks;
>>>
>>> Why not return proper error no?
>>
>> Instead the question should be, why not the proper condition: it tells
>> `if (res->clks < 0)', while it should be `if (res->num_clks < 0)'.
>>
> 
> Heh. I completely overlooked that part. Yes, the if condition itself should be
> fixed.
> 
> - Mani

Sure, will fix it up!

Regards,
Devi Priya
> 
>>>
>>>>
>>>>        res->rst = devm_reset_control_array_get_exclusive(dev);
>>>>        if (IS_ERR(res->rst))
>>>> @@ -1073,7 +1067,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
>>>>   {
>>>>        struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>>>>
>>>> -     clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
>>>> +     clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>>>   }
>>>>
>>>>   static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>>>> @@ -1102,19 +1096,16 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>>>>
>>>>        usleep_range(2000, 2500);
>>>>
>>>> -     return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
>>>> +     return clk_bulk_prepare_enable(res->num_clks, res->clks);
>>>>   }
>>>>
>>>> -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>>>> +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>>>>   {
>>>>        struct dw_pcie *pci = pcie->pci;
>>>>        u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>>>        u32 val;
>>>>        int i;
>>>>
>>>> -     writel(SLV_ADDR_SPACE_SZ,
>>>> -             pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>>>> -
>>>>        val = readl(pcie->parf + PARF_PHY_CTRL);
>>>>        val &= ~PHY_TEST_PWR_DOWN;
>>>>        writel(val, pcie->parf + PARF_PHY_CTRL);
>>>> @@ -1151,6 +1142,26 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>>>>        return 0;
>>>>   }
>>>>
>>>> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
>>>> +{
>>>> +     writel(SLV_ADDR_SPACE_SZ_1_27_0,
>>>> +            pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>>>> +
>>>> +     qcom_pcie_post_init(pcie);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>>>> +{
>>>> +     writel(SLV_ADDR_SPACE_SZ,
>>>> +            pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
>>>> +
>>>> +     qcom_pcie_post_init(pcie);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>>   static int qcom_pcie_link_up(struct dw_pcie *pci)
>>>>   {
>>>>        u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>>> @@ -1291,6 +1302,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>>>>        .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>>>   };
>>>>
>>>> +/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
>>>> +static const struct qcom_pcie_ops ops_1_27_0 = {
>>>> +     .get_resources = qcom_pcie_get_resources_2_9_0,
>>>> +     .init = qcom_pcie_init_2_9_0,
>>>> +     .post_init = qcom_pcie_post_init_1_27_0,
>>>> +     .deinit = qcom_pcie_deinit_2_9_0,
>>>> +     .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>>>> +};
>>>> +
>>>>   static const struct qcom_pcie_cfg cfg_1_0_0 = {
>>>>        .ops = &ops_1_0_0,
>>>>   };
>>>> @@ -1323,6 +1343,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>>>>        .ops = &ops_2_9_0,
>>>>   };
>>>>
>>>> +static const struct qcom_pcie_cfg cfg_1_27_0 = {
>>>> +     .ops = &ops_1_27_0,
>>>> +};
>>>> +
>>>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>>>        .link_up = qcom_pcie_link_up,
>>>>        .start_link = qcom_pcie_start_link,
>>>> @@ -1607,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>>>        { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>>>>        { .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>>>>        { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>>>> +     { .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
>>>>        { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>>>>        { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>>>>        { .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
>>>> --
>>>> 2.17.1
>>>>
>>>
>>> --
>>> மணிவண்ணன் சதாசிவம்
>>
>>
>>
>> -- 
>> With best wishes
>> Dmitry
> 
