Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02969CCD8
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 14:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjBTNn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 08:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBTNn5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 08:43:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B991CF6C;
        Mon, 20 Feb 2023 05:43:55 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K7TDcm019094;
        Mon, 20 Feb 2023 13:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f5VUsOSf3KVSNPG4/Zu+k0CL0pyJH9jedB/7l9p/SCQ=;
 b=E6/C+Xrj5HgYOqXojyuLd/sh3ktnl5h65EHTmFbpay/c/ll3NLTGet8GXpYwdZiVQgKA
 IRJNnoOEKNGZfmgGlX9btT7PtQJp8uK0wmzsqhrvv6vytfxRQ8CvQ/A1gUC3Li4o1Bz4
 ohGKEshhRM/nsEs/zRgck771eEdEQ4yw+uC63sl+QdRaU4C7rUI5SdxQSa+StkTlXcH1
 vPXs12vAkcAmKzRL8fcIWs3xkHPZvAfVfGmvaTchZfqlXKiCES5CQSNs1GoxQbVbhFL+
 5+SegNGU3dX5VVZLAaNBJpZj6pCTYDOBWeCn4uG0+nfUsvOLc1jj1sTAm0HbO7Z5PuDN vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntnpgd9q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:43:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31KDhdac023233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:43:39 GMT
Received: from [10.216.11.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 05:43:30 -0800
Message-ID: <424878d3-7937-ae90-9d79-fef4a5c9c419@quicinc.com>
Date:   Mon, 20 Feb 2023 19:13:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/7] clk: qcom: gcc-ipq9574: Add PCIe related clocks
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-7-quic_devipriy@quicinc.com>
 <53f42026-26af-9f5f-e6a0-6e08d2f272f6@quicinc.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <53f42026-26af-9f5f-e6a0-6e08d2f272f6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hgyPxtIntYlIFzDFNAwYShBXPaHik6d4
X-Proofpoint-GUID: hgyPxtIntYlIFzDFNAwYShBXPaHik6d4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_11,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=906 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/17/2023 2:11 PM, Sricharan Ramabadhran wrote:
> Hi Devi,
> 
> On 2/14/2023 10:11 PM, Devi Priya wrote:
>> Add the clocks needed for enabling PCIe in IPQ9574
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c 
>> b/drivers/clk/qcom/gcc-ipq9574.c
>> index b2a2d618a5ec..1bf33d582dc2 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -1538,6 +1538,24 @@ static struct clk_regmap_phy_mux 
>> pcie0_pipe_clk_src = {
>>       },
>>   };
>> +static struct clk_branch gcc_pcie0_pipe_clk = {
>> +    .halt_reg = 0x28044,
>> +    .halt_check = BRANCH_HALT_DELAY,
>> +    .clkr = {
>> +        .enable_reg = 0x28044,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_pcie0_pipe_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &pcie0_pipe_clk_src.clkr.hw
>> +            },
>> +            .num_parents = 1,
>> +            .flags = CLK_SET_RATE_PARENT,
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>>   static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
>>       .reg = 0x29064,
>>       .clkr = {
>> @@ -1552,6 +1570,24 @@ static struct clk_regmap_phy_mux 
>> pcie1_pipe_clk_src = {
>>       },
>>   };
>> +static struct clk_branch gcc_pcie1_pipe_clk = {
>> +    .halt_reg = 0x29044,
>> +    .halt_check = BRANCH_HALT_DELAY,
>> +    .clkr = {
>> +        .enable_reg = 0x29044,
>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "gcc_pcie1_pipe_clk",
>> +            .parent_hws = (const struct clk_hw *[]) {
>> +                &pcie1_pipe_clk_src.clkr.hw
>> +            },
>> +        .num_parents = 1,
>> +        .flags = CLK_SET_RATE_PARENT,
>> +        .ops = &clk_branch2_ops,
>> +        },
> 
>   Looks like indentation issue for the above hunk.
Sure, will update this in V2

Best Regards,
Devi Priya
> 
> Regards,
>   Sricharan
