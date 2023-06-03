Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A3E720E90
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jun 2023 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjFCHot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jun 2023 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFCHot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jun 2023 03:44:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011221B4;
        Sat,  3 Jun 2023 00:44:47 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3537hDWj013214;
        Sat, 3 Jun 2023 07:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nTaklHgzvpTd6uAPk3GvsJsBWro+3RpxJdi5w+6YHDo=;
 b=BSm+ZxTl6Yy5pcjdje940z1B8eUnc6mD/Wm+Sw400xRm+d5zoLG+GFyrDqUaD+GW3PbT
 al1WFvK0v4PP1UcujH077QCLRjoy7rBESTp+L9azNEyR8ND7KZ0uuj6dJ7uTaJS43ETF
 RRbq7k5wUzmwmbYBloZeFfI4XFh/LKDRoqNoIyCfya1q9UcbKru4So9dQOdCeEEEkI7H
 SCOcB8iDqObCb0ov7Em8wl7v5YdLvsikRdwlur6zhPFwSMdiCyo0W6S1B+wElJrWyUej
 egX+rcIu5dSTN7P99Ka5YMxrXpu1clXMEWvaBpFrs8KdM6s/4vVGcxxmEGT3bnrg9PjS Sg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyvfxga60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Jun 2023 07:44:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3537iZGV000795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Jun 2023 07:44:35 GMT
Received: from [10.216.19.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 3 Jun 2023
 00:44:28 -0700
Message-ID: <d47d3077-31e1-329b-5e19-c8d2ec3b5f30@quicinc.com>
Date:   Sat, 3 Jun 2023 13:14:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 3/6] dt-bindings: PCI: qcom: Add IPQ9574
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
References: <20230519090219.15925-1-quic_devipriy@quicinc.com>
 <20230519090219.15925-4-quic_devipriy@quicinc.com>
 <20230528141713.GB2814@thinkpad>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230528141713.GB2814@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uoBSBZLx_iwDSIdU7scd4k1Hup1vYm3I
X-Proofpoint-ORIG-GUID: uoBSBZLx_iwDSIdU7scd4k1Hup1vYm3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_04,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306030071
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/28/2023 7:47 PM, Manivannan Sadhasivam wrote:
> On Fri, May 19, 2023 at 02:32:16PM +0530, Devi Priya wrote:
>> Add bindings for PCIe hosts on IPQ9574 platform and allow
>> msi-parent property.
>>
> 
> Why can't you use existing "msi-map" property instead of "msi-parent"?
> 
> - Mani
Sure, will update.

Thanks,
Devi Priya
> 
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V4:
>> 	- Dropped msi-parent from anyOf: as msi-parent and msi-map
>> 	  cannot coexist and added it specific to ipq9574
>>
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 81971be4e554..af5c7a390df1 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - qcom,pcie-ipq8064-v2
>>             - qcom,pcie-ipq8074
>>             - qcom,pcie-ipq8074-gen3
>> +          - qcom,pcie-ipq9574
>>             - qcom,pcie-msm8996
>>             - qcom,pcie-qcs404
>>             - qcom,pcie-sa8540p
>> @@ -113,6 +114,8 @@ properties:
>>     power-domains:
>>       maxItems: 1
>>   
>> +  msi-parent: true
>> +
>>     perst-gpios:
>>       description: GPIO controlled connection to PERST# signal
>>       maxItems: 1
>> @@ -171,6 +174,7 @@ allOf:
>>               enum:
>>                 - qcom,pcie-ipq6018
>>                 - qcom,pcie-ipq8074-gen3
>> +              - qcom,pcie-ipq9574
>>       then:
>>         properties:
>>           reg:
>> @@ -382,6 +386,39 @@ allOf:
>>               - const: ahb # AHB Reset
>>               - const: axi_m_sticky # AXI Master Sticky reset
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq9574
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 6
>> +          maxItems: 6
>> +        clock-names:
>> +          items:
>> +            - const: ahb  # AHB clock
>> +            - const: aux  # Auxiliary clock
>> +            - const: axi_m # AXI Master clock
>> +            - const: axi_s # AXI Slave clock
>> +            - const: axi_bridge # AXI bridge clock
>> +            - const: rchng
>> +        resets:
>> +          minItems: 8
>> +          maxItems: 8
>> +        reset-names:
>> +          items:
>> +            - const: pipe # PIPE reset
>> +            - const: sticky # Core Sticky reset
>> +            - const: axi_s_sticky # AXI Slave Sticky reset
>> +            - const: axi_s # AXI Slave reset
>> +            - const: axi_m_sticky # AXI Master Sticky reset
>> +            - const: axi_m # AXI Master reset
>> +            - const: aux # AUX Reset
>> +            - const: ahb # AHB Reset
>> +
>>     - if:
>>         properties:
>>           compatible:
>> @@ -767,6 +804,7 @@ allOf:
>>                   - qcom,pcie-ipq8064v2
>>                   - qcom,pcie-ipq8074
>>                   - qcom,pcie-ipq8074-gen3
>> +                - qcom,pcie-ipq9574
>>                   - qcom,pcie-qcs404
>>       then:
>>         required:
>> @@ -862,6 +900,16 @@ allOf:
>>             items:
>>               - const: msi
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq9574
>> +    then:
>> +      required:
>> +        - msi-parent
>> +
>>   unevaluatedProperties: false
>>   
>>   examples:
>> -- 
>> 2.17.1
>>
> 
