Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95466F3D15
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 07:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjEBFjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 01:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEBFjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 01:39:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269AE52;
        Mon,  1 May 2023 22:39:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3425GU1H031986;
        Tue, 2 May 2023 05:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PrAFe7ea7BirIRPVaDBoFpQItMlnOPom8nGljtcwk9Y=;
 b=FqKeMCvI3uJXUuU0UL20EgdHCgG/UUKE+x3ZWZIIvg7ugm5ceZ59U5jPsJ8nmds5n8fC
 /zUaYt9fZeVuU6UWbA+L39Rdo4oQDEH+u6XkVkv0Oj3gdY5j83doBObdqotzQMyB5GEX
 KuUdF8rnTK+h9trR3sFIurrZD+n+hrzz8L0Q32ag4R/9XluL9kKv6pwEZKpt5erJ6XuV
 5hJB09GMedTci0y4b7rfiURg7tKAurer5kAqm9tlWeRX5k8BiXC+FF9RMrUokAJuDhdE
 J8lV96P+PPknawqZ++B1ZQAfLpuZUfkKH3+2m+xVmntnYV593WETLPb8VHWJhtavnrb+ kw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8ufc5dpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 05:39:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3425cwn5010848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 05:38:58 GMT
Received: from [10.242.243.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 1 May 2023
 22:38:50 -0700
Message-ID: <fa1f011a-9f18-5799-dbf3-ad5b1893f57b@quicinc.com>
Date:   Tue, 2 May 2023 11:08:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 3/6] dt-bindings: PCI: qcom: Add IPQ9574
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-4-quic_devipriy@quicinc.com>
 <20230425173330.GA1985131-robh@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230425173330.GA1985131-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rrfp5iF_YPZ1tvVUs0Qeb6soHz_aEy6n
X-Proofpoint-GUID: Rrfp5iF_YPZ1tvVUs0Qeb6soHz_aEy6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020049
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/25/2023 11:03 PM, Rob Herring wrote:
> On Fri, Apr 21, 2023 at 06:19:35PM +0530, Devi Priya wrote:
>> Add bindings for PCIe hosts on IPQ9574 platform and allow
>> msi-parent property.
> 
> Go see the long discussion about why msi-parent with msi-map is wrong.
> If something changed, explain that here.
Sure, okay

Thanks,
Devi Priya
> 
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V3:
>> 	- Rebased on linux-next/master
>>
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 40 +++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 81971be4e554..a92cecc5fe6f 100644
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
>> @@ -138,6 +141,8 @@ anyOf:
>>     - required:
>>         - msi-map
>>         - msi-map-mask
>> +  - required:
>> +      - msi-parent
>>   
>>   allOf:
>>     - $ref: /schemas/pci/pci-bus.yaml#
>> @@ -171,6 +176,7 @@ allOf:
>>               enum:
>>                 - qcom,pcie-ipq6018
>>                 - qcom,pcie-ipq8074-gen3
>> +              - qcom,pcie-ipq9574
>>       then:
>>         properties:
>>           reg:
>> @@ -382,6 +388,39 @@ allOf:
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
>> @@ -767,6 +806,7 @@ allOf:
>>                   - qcom,pcie-ipq8064v2
>>                   - qcom,pcie-ipq8074
>>                   - qcom,pcie-ipq8074-gen3
>> +                - qcom,pcie-ipq9574
>>                   - qcom,pcie-qcs404
>>       then:
>>         required:
>> -- 
>> 2.17.1
>>
