Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8817075C570
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGULIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGULHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 07:07:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7E46AD;
        Fri, 21 Jul 2023 04:04:10 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LB19tq012404;
        Fri, 21 Jul 2023 11:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uDtElLv/5bFBcI1FU53B4erF6OinAr+ovFJRi+ia4Ws=;
 b=JSs52lgf4+vF0pK4o/TmVEIbM3x53mg86feQ7Zf/NHb020QEfUyWjlAlu3/q8hX6PLvX
 vMZxWL9EQgHWgCewub5Mm51/uCeI9fVsde+qZqOCthvrZYKZZORnIPDklhwmbcMH/JX6
 8dPgmsdu6Fmadd+OwUKtqwcIP5q6me00Zc1eLMARbciYW77jIijr8jX9NZC0kxDLFcE1
 cUtqAzaMK2sNzh3dib5nPjD0Z4bYn9wmIuLZyxaU23Rh7GLEc0qYwfIzC5YMxRQvu6AU
 qEFusH8/m0bFgcezqLtCLiYdwWZEVkrMRl7EChMhKttAIoTn7VtomjlVUcjob/styD/M 1w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryrsb0057-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 11:03:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36LB3UHU005977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 11:03:30 GMT
Received: from [10.217.219.237] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 04:03:23 -0700
Message-ID: <ca51b1dc-5805-5b01-01e0-a7dff535cb6c@quicinc.com>
Date:   Fri, 21 Jul 2023 16:33:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe
 PHY
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>
CC:     <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
 <1689311319-22054-3-git-send-email-quic_msarkar@quicinc.com>
 <132e9514-7eb9-8915-6130-5bf656c1aaac@linaro.org>
Content-Language: en-US
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <132e9514-7eb9-8915-6130-5bf656c1aaac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KHLXyv7UinIewFxIhznIV_eqegdw9kAX
X-Proofpoint-ORIG-GUID: KHLXyv7UinIewFxIhznIV_eqegdw9kAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/17/2023 12:55 PM, Krzysztof Kozlowski wrote:
> On 14/07/2023 07:08, Mrinmay Sarkar wrote:
>> Add devicetree YAML binding for Qualcomm QMP PCIe PHY
>> for SA8775p platform.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> index a0407fc..ca55ed9 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>> @@ -16,6 +16,8 @@ description:
>>   properties:
>>     compatible:
>>       enum:
>> +      - qcom,sa8775p-qmp-gen4x2-pcie-phy
>> +      - qcom,sa8775p-qmp-gen4x4-pcie-phy
>>         - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>>         - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>>         - qcom,sc8280xp-qmp-gen3x4-pcie-phy
>> @@ -30,7 +32,7 @@ properties:
>>   
>>     clocks:
>>       minItems: 5
>> -    maxItems: 6
>> +    maxItems: 7
>>   
>>     clock-names:
>>       minItems: 5
>> @@ -41,6 +43,7 @@ properties:
>>         - const: rchng
>>         - const: pipe
>>         - const: pipediv2
>> +      - const: phy_aux
>>   
>>     power-domains:
>>       maxItems: 1
>> @@ -141,6 +144,20 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
>> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 7
>> +        clock-names:
>> +          minItems: 7
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
> This probably works but is not obvious and easy to read. You have here
> if:then:else: block, so else applies to your variant. Change all these
> if clauses for clocks into separate clauses per matching variant
> (if:then: ... if:then:... if:then:...)
>
> Best regards,
> Krzysztof

My Bad here, This patch already applied we will take care this in next 
patch set.

Thanks,
Mrinmay

>
