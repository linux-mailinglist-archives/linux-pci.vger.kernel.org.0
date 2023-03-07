Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255226ADAC3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCGJpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 04:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCGJpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 04:45:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B839CD3;
        Tue,  7 Mar 2023 01:45:42 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3277IqHs017882;
        Tue, 7 Mar 2023 09:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mhno23f9v3er4tDoxC2ORjmssJ3m2pYGBAvzXv7SrWk=;
 b=oMws0QMgsjJuGR3VfFPkzXW4KYTBIZ8MrowdlxNTo/itd0EjkpyMtYRJg+FGS2IFrO4i
 s4VWi0z8Kwc2igTmr8XoA8Iel1CdxvAIQ8boVKDLOtwzjulByN7VGl08ebq5J7fn2cG9
 Y+qB0hTgzLMiUjq23bRLbK+oXLsOLjRoxYIyEkEzhniYVBW9Q/OJRwaAi2N9JWFxCdp6
 YA0laUVW30A81DhOediRmP6sf1KDipgO2gy+ozbx1nkicUZaUHi2moyKclkKIec6T3bx
 I03+Hwnratnz5hdXBzWqS5fmPJ5MR7ztzITQx1IsnBJrWhPpG2Y21iNmcaIZGpDitT48 Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5wee8vu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 09:45:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3279jKjN002603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 09:45:20 GMT
Received: from [10.216.11.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 01:45:11 -0800
Message-ID: <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com>
Date:   Tue, 7 Mar 2023 15:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH 1/7] dt-bindings: PCI: qcom: Add IPQ9574 specific
 compatible
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <svarbanov@mm-sol.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-2-quic_devipriy@quicinc.com>
 <20230224082332.GA5443@thinkpad>
 <bd153038-4427-1f11-1941-5f13fec01cf7@quicinc.com>
 <20230228063358.GA4839@thinkpad>
 <9BD62D8E-4E14-4269-B72D-C83EF4D43040@linaro.org>
 <20230303174036.GB6782@thinkpad>
Content-Language: en-US
In-Reply-To: <20230303174036.GB6782@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: acFhR0WU2dnQYcCltNuR2nn7AUBIs0Ft
X-Proofpoint-ORIG-GUID: acFhR0WU2dnQYcCltNuR2nn7AUBIs0Ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_03,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/3/2023 11:10 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 03, 2023 at 05:16:58PM +0200, Dmitry Baryshkov wrote:
>> 28 февраля 2023 г. 08:33:58 GMT+02:00, Manivannan Sadhasivam <mani@kernel.org> пишет:
>>> On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
>>>>
>>>>
>>>> On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
>>>>> On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
>>>>>> Document the compatible for IPQ9574
>>>>>>
>>>> Hi Mani, Thanks for taking time to review the patch.
>>>>>
>>>>> You didn't mention about the "msi-parent" property that is being added
>>>>> by this patch
>>>> Sure, will update the commit message in the next spin
>>>>>
>>>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>>>> ---
>>>>>>    .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 ++++++++++++++++++-
>>>>>>    1 file changed, 70 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>> index 872817d6d2bd..dabdf2684e2d 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>> @@ -26,6 +26,7 @@ properties:
>>>>>>              - qcom,pcie-ipq8064-v2
>>>>>>              - qcom,pcie-ipq8074
>>>>>>              - qcom,pcie-ipq8074-gen3
>>>>>> +          - qcom,pcie-ipq9574
>>>>>>              - qcom,pcie-msm8996
>>>>>>              - qcom,pcie-qcs404
>>>>>>              - qcom,pcie-sa8540p
>>>>>> @@ -44,11 +45,11 @@ properties:
>>>>>>      reg:
>>>>>>        minItems: 4
>>>>>> -    maxItems: 5
>>>>>> +    maxItems: 6
>>>>>>      reg-names:
>>>>>>        minItems: 4
>>>>>> -    maxItems: 5
>>>>>> +    maxItems: 6
>>>>>>      interrupts:
>>>>>>        minItems: 1
>>>>>> @@ -105,6 +106,8 @@ properties:
>>>>>>        items:
>>>>>>          - const: pciephy
>>>>>> +  msi-parent: true
>>>>>> +
>>>>>>      power-domains:
>>>>>>        maxItems: 1
>>>>>> @@ -173,6 +176,27 @@ allOf:
>>>>>>                - const: parf # Qualcomm specific registers
>>>>>>                - const: config # PCIe configuration space
>>>>>> +  - if:
>>>>>> +      properties:
>>>>>> +        compatible:
>>>>>> +          contains:
>>>>>> +            enum:
>>>>>> +              - qcom,pcie-ipq9574
>>>>>> +    then:
>>>>>> +      properties:
>>>>>> +        reg:
>>>>>> +          minItems: 5
>>>>>> +          maxItems: 6
>>>>>> +        reg-names:
>>>>>> +          minItems: 5
>>>>>> +          items:
>>>>>> +            - const: dbi # DesignWare PCIe registers
>>>>>> +            - const: elbi # External local bus interface registers
>>>>>> +            - const: atu # ATU address space
>>>>>> +            - const: parf # Qualcomm specific registers
>>>>>> +            - const: config # PCIe configuration space
>>>>>> +            - const: aggr_noc #PCIe aggr_noc
>>>>>
>>>>> Why do you need this region unlike other SoCs? Is the driver making use of it?
>>>> We have the aggr_noc region in ipq9574 to achieve higher throughput & to
>>>> handle multiple PCIe instances. The driver uses it to rate adapt 1-lane PCIe
>>>> clocks. My bad, missed it. Will add the driver changes in V2.
>>>
>>> Hmm, this is something new. How can you achieve higher throughput with this
>>> region? Can you explain more on how it is used?
>>
>> Based on the name of the region, it looks like it is an interconnect region.
>>
> 
> Well, we only have BCM based interconnects so far. That's why I was curious
> about this region and its purpose.
For connected PCIe slave devices that are running at frequency lesser
than the ANOC frequency (342MHz), the rate adapter of ANOC needs to be
configured
> 
>> Devi, if this is the case, then you have to handle it through the interconnect driver, rather than poking directly into these registers.
> 
> If that so, it doesn't need to be added in this series itself. I believe that
> without aggr_noc region, the PCIe controller can still function properly with
> reduced performance. But you can add the interconnect support later as a
> separate series.
Sure, okay. The ANOC runs at a fixed frequency of 342MHz and the 
interconnect clocks are not scaled. The aggr_noc register is just a 
magic register for configuring it's rate adapter to ensure no wait 
cycles are inserted.

> 
> Thanks,
> Mani
> 
>>
>>
>>>
>>> Thanks,
>>> Mani
>>>
>>>>>
>>>>> Thanks,
>>>>> Mani
>>>>>
>>>>>> +
>>>>>>      - if:
>>>>>>          properties:
>>>>>>            compatible:
>>>>>> @@ -365,6 +389,39 @@ allOf:
>>>>>>                - const: ahb # AHB Reset
>>>>>>                - const: axi_m_sticky # AXI Master Sticky reset
>>>>>> +  - if:
>>>>>> +      properties:
>>>>>> +        compatible:
>>>>>> +          contains:
>>>>>> +            enum:
>>>>>> +              - qcom,pcie-ipq9574
>>>>>> +    then:
>>>>>> +      properties:
>>>>>> +        clocks:
>>>>>> +          minItems: 6
>>>>>> +          maxItems: 6
>>>>>> +        clock-names:
>>>>>> +          items:
>>>>>> +            - const: ahb  # AHB clock
>>>>>> +            - const: aux  # Auxiliary clock
>>>>>> +            - const: axi_m # AXI Master clock
>>>>>> +            - const: axi_s # AXI Slave clock
>>>>>> +            - const: axi_bridge # AXI bridge clock
>>>>>> +            - const: rchng
>>>>>> +        resets:
>>>>>> +          minItems: 8
>>>>>> +          maxItems: 8
>>>>>> +        reset-names:
>>>>>> +          items:
>>>>>> +            - const: pipe # PIPE reset
>>>>>> +            - const: sticky # Core Sticky reset
>>>>>> +            - const: axi_s_sticky # AXI Slave Sticky reset
>>>>>> +            - const: axi_s # AXI Slave reset
>>>>>> +            - const: axi_m_sticky # AXI Master Sticky reset
>>>>>> +            - const: axi_m # AXI Master reset
>>>>>> +            - const: aux # AUX Reset
>>>>>> +            - const: ahb # AHB Reset
>>>>>> +
>>>>>>      - if:
>>>>>>          properties:
>>>>>>            compatible:
>>>>>> @@ -681,6 +738,16 @@ allOf:
>>>>>>            - interconnects
>>>>>>            - interconnect-names
>>>>>> +  - if:
>>>>>> +      properties:
>>>>>> +        compatible:
>>>>>> +          contains:
>>>>>> +            enum:
>>>>>> +              - qcom,pcie-ipq9574
>>>>>> +    then:
>>>>>> +      required:
>>>>>> +        - msi-parent
>>>>>> +
>>>>>>      - if:
>>>>>>          not:
>>>>>>            properties:
>>>>>> @@ -693,6 +760,7 @@ allOf:
>>>>>>                    - qcom,pcie-ipq8064v2
>>>>>>                    - qcom,pcie-ipq8074
>>>>>>                    - qcom,pcie-ipq8074-gen3
>>>>>> +                - qcom,pcie-ipq9574
>>>>>>                    - qcom,pcie-qcs404
>>>>>>        then:
>>>>>>          required:
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>> Thanks,
>>>> Devi Priya
>>>
>>
> 
Thanks,
Devi Priya
