Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E714D6B020D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCHIuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCHIup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:50:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C3B0B90;
        Wed,  8 Mar 2023 00:50:32 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3285ZZbf020714;
        Wed, 8 Mar 2023 08:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+QZf7jsqZCz/mjUR8sKf9eOaujlmzzUJO/yJGxi9XBY=;
 b=ojN6dUALKEyWJx+ed10wpYxRNad8rpfxY21M0xIjaoAxMaQm7KpHeDHBnCABrBxdfHs0
 S0MtyqcmDnOw2SBdst+MLXIqh9BTj+uNJWydsJ9lZiS219q092FQtYMuUKvGg05oKLI2
 scWt09XLInYdfwc8AWcg8C718BA3JRUiuTwx6l6dX3B8MRq1HZPZm4KEcLS61ThemiTp
 v7wKNAKMD4CJ/ywxUHNJ7Otd+nGEqwDSDqN3nB5T3TKXut+i4xnT0bPP20zDdwEVN8ap
 iyf5FgDleQemxiFxdVmwVuYYXIKSvmmBC8WNJLYba97OgG7vaajEfxEiNsBMAObPiGgQ tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fets179-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 08:50:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3288oGdY014924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 08:50:16 GMT
Received: from [10.216.47.125] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 00:50:07 -0800
Message-ID: <dd48782f-e5ff-2bbe-93d0-cfdd491d5292@quicinc.com>
Date:   Wed, 8 Mar 2023 14:19:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] dt-bindings: PCI: qcom: Add IPQ9574 specific
 compatible
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
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
 <30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com>
 <20230307125655.GC5599@thinkpad>
 <2afe8c7e-7e54-460f-7206-64a290beccfb@quicinc.com>
 <CAA8EJpo-_PXhBnKWD-TWEqY8+uAEjbRsrhJ7XO1PTcYV-MHV9Q@mail.gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAA8EJpo-_PXhBnKWD-TWEqY8+uAEjbRsrhJ7XO1PTcYV-MHV9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3FS99f6BK8LW-UQxleOQcX1kBEicXoD_
X-Proofpoint-ORIG-GUID: 3FS99f6BK8LW-UQxleOQcX1kBEicXoD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/7/2023 8:26 PM, Dmitry Baryshkov wrote:
> On Tue, 7 Mar 2023 at 16:40, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>>
>>
>> On 3/7/2023 6:26 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Mar 07, 2023 at 03:15:08PM +0530, Devi Priya wrote:
>>>>
>>>>
>>>> On 3/3/2023 11:10 PM, Manivannan Sadhasivam wrote:
>>>>> On Fri, Mar 03, 2023 at 05:16:58PM +0200, Dmitry Baryshkov wrote:
>>>>>> 28 февраля 2023 г. 08:33:58 GMT+02:00, Manivannan Sadhasivam <mani@kernel.org> пишет:
>>>>>>> On Tue, Feb 28, 2023 at 10:56:53AM +0530, Devi Priya wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/24/2023 1:53 PM, Manivannan Sadhasivam wrote:
>>>>>>>>> On Tue, Feb 14, 2023 at 10:11:29PM +0530, Devi Priya wrote:
>>>>>>>>>> Document the compatible for IPQ9574
>>>>>>>>>>
>>>>>>>> Hi Mani, Thanks for taking time to review the patch.
>>>>>>>>>
>>>>>>>>> You didn't mention about the "msi-parent" property that is being added
>>>>>>>>> by this patch
>>>>>>>> Sure, will update the commit message in the next spin
>>>>>>>>>
>>>>>>>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>>>>>>>> ---
>>>>>>>>>>      .../devicetree/bindings/pci/qcom,pcie.yaml    | 72 ++++++++++++++++++-
>>>>>>>>>>      1 file changed, 70 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>>>>>> index 872817d6d2bd..dabdf2684e2d 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>>>>>>> @@ -26,6 +26,7 @@ properties:
>>>>>>>>>>                - qcom,pcie-ipq8064-v2
>>>>>>>>>>                - qcom,pcie-ipq8074
>>>>>>>>>>                - qcom,pcie-ipq8074-gen3
>>>>>>>>>> +          - qcom,pcie-ipq9574
>>>>>>>>>>                - qcom,pcie-msm8996
>>>>>>>>>>                - qcom,pcie-qcs404
>>>>>>>>>>                - qcom,pcie-sa8540p
>>>>>>>>>> @@ -44,11 +45,11 @@ properties:
>>>>>>>>>>        reg:
>>>>>>>>>>          minItems: 4
>>>>>>>>>> -    maxItems: 5
>>>>>>>>>> +    maxItems: 6
>>>>>>>>>>        reg-names:
>>>>>>>>>>          minItems: 4
>>>>>>>>>> -    maxItems: 5
>>>>>>>>>> +    maxItems: 6
>>>>>>>>>>        interrupts:
>>>>>>>>>>          minItems: 1
>>>>>>>>>> @@ -105,6 +106,8 @@ properties:
>>>>>>>>>>          items:
>>>>>>>>>>            - const: pciephy
>>>>>>>>>> +  msi-parent: true
>>>>>>>>>> +
>>>>>>>>>>        power-domains:
>>>>>>>>>>          maxItems: 1
>>>>>>>>>> @@ -173,6 +176,27 @@ allOf:
>>>>>>>>>>                  - const: parf # Qualcomm specific registers
>>>>>>>>>>                  - const: config # PCIe configuration space
>>>>>>>>>> +  - if:
>>>>>>>>>> +      properties:
>>>>>>>>>> +        compatible:
>>>>>>>>>> +          contains:
>>>>>>>>>> +            enum:
>>>>>>>>>> +              - qcom,pcie-ipq9574
>>>>>>>>>> +    then:
>>>>>>>>>> +      properties:
>>>>>>>>>> +        reg:
>>>>>>>>>> +          minItems: 5
>>>>>>>>>> +          maxItems: 6
>>>>>>>>>> +        reg-names:
>>>>>>>>>> +          minItems: 5
>>>>>>>>>> +          items:
>>>>>>>>>> +            - const: dbi # DesignWare PCIe registers
>>>>>>>>>> +            - const: elbi # External local bus interface registers
>>>>>>>>>> +            - const: atu # ATU address space
>>>>>>>>>> +            - const: parf # Qualcomm specific registers
>>>>>>>>>> +            - const: config # PCIe configuration space
>>>>>>>>>> +            - const: aggr_noc #PCIe aggr_noc
>>>>>>>>>
>>>>>>>>> Why do you need this region unlike other SoCs? Is the driver making use of it?
>>>>>>>> We have the aggr_noc region in ipq9574 to achieve higher throughput & to
>>>>>>>> handle multiple PCIe instances. The driver uses it to rate adapt 1-lane PCIe
>>>>>>>> clocks. My bad, missed it. Will add the driver changes in V2.
>>>>>>>
>>>>>>> Hmm, this is something new. How can you achieve higher throughput with this
>>>>>>> region? Can you explain more on how it is used?
>>>>>>
>>>>>> Based on the name of the region, it looks like it is an interconnect region.
>>>>>>
>>>>>
>>>>> Well, we only have BCM based interconnects so far. That's why I was curious
>>>>> about this region and its purpose.
>>>> For connected PCIe slave devices that are running at frequency lesser
>>>> than the ANOC frequency (342MHz), the rate adapter of ANOC needs to be
>>>> configured
>>>>>
>>>>>> Devi, if this is the case, then you have to handle it through the interconnect driver, rather than poking directly into these registers.
>>>>>
>>>>> If that so, it doesn't need to be added in this series itself. I believe that
>>>>> without aggr_noc region, the PCIe controller can still function properly with
>>>>> reduced performance. But you can add the interconnect support later as a
>>>>> separate series.
>>>> Sure, okay. The ANOC runs at a fixed frequency of 342MHz and the
>>>> interconnect clocks are not scaled. The aggr_noc register is just a magic
>>>> register for configuring it's rate adapter to ensure no wait cycles are
>>>> inserted.
>>>>
>>>
>>> If the purpose of the aggr_noc region is to configure the interconnect clock,
>>> then it should be modeled as an interconnect driver.
>> Can we use 'syscon' here, as we are not scaling the interconnect
>> frequency and this is just a single register write for setting
>> the rate adapter?
> 
> It should be done outside of the PCIe driver.
> It is not "just a single register". It is also setting the anoc/snoc
> clocks for USB. And maybe something else, which we haven't seen at
> this moment. You are still setting up the NoC, even if the icc
> frequency is not scaled.
> 
Sure Dmitry, Got it

Regards,
Devi Priya
