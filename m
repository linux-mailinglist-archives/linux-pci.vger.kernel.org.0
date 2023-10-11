Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C547C514A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjJKLOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjJKLN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:13:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E407398;
        Wed, 11 Oct 2023 04:13:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B6xaWu030377;
        Wed, 11 Oct 2023 11:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bocOC/J8T706Omr3rO0oeDwb+/U0rf0qFLdx0Lbsf/Q=;
 b=dR0j1NbGAAnaOw0KK2/PTT1Tz3ewLMKOAorzCAW+OqfCVsB6v239oUwIWJP3SbwsWPjA
 GtjiMqcaCxiFli+9hj19d+JJcY8690TL1tj2YD9dIBt3Bgl1bOsuHKrty+IYDRAbJYTJ
 cqQUte+PfQT1s5/cRRP1BU1yweYaPlVwUbi3s7bWfL9RsGMKEvJldLq6E/Kk7lRRiW8e
 jVCWAoFqzVQv0cWNgOVaV8VndxJvvABSih042f7/LeZXu5lfsXQp84y8a0wh6hjNWPO7
 wN6YLwTIrXhKx0MqDPd8HplltotX5+pdfi+gdklXt5FtoWy8YIkULlJ0zWlAIWG6Twxi Ag== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tngtp9640-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 11:13:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BBDYtT009828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 11:13:34 GMT
Received: from [10.216.52.55] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 04:13:26 -0700
Message-ID: <8effa7e5-a223-081b-75b8-7b94400d42e6@quicinc.com>
Date:   Wed, 11 Oct 2023 16:43:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P
 SoC
Content-Language: en-US
To:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-2-git-send-email-quic_msarkar@quicinc.com>
 <20230921183850.GA762694-robh@kernel.org>
 <28bf111f-b965-4d38-884b-bc3a0b68a6cc@quicinc.com>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <28bf111f-b965-4d38-884b-bc3a0b68a6cc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ee4rSoIx9q09WeCGTwZYxy1bEmgTmEkg
X-Proofpoint-GUID: Ee4rSoIx9q09WeCGTwZYxy1bEmgTmEkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=852
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110098
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/6/2023 4:24 PM, Shazad Hussain wrote:
>
>
> On 9/22/2023 12:08 AM, Rob Herring wrote:
>> On Wed, Sep 20, 2023 at 07:25:08PM +0530, Mrinmay Sarkar wrote:
>>> Add devicetree bindings support for SA8775P SoC.
>>> Define reg and interrupt per platform.
>>>
>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 130 
>>> +++++++++++++++++----
>>>   1 file changed, 108 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml 
>>> b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>> index a223ce0..e860e8f 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>> @@ -13,6 +13,7 @@ properties:
>>>     compatible:
>>>       oneOf:
>>>         - enum:
>>> +          - qcom,sa8775p-pcie-ep
>>>             - qcom,sdx55-pcie-ep
>>>             - qcom,sm8450-pcie-ep
>>>         - items:
>>> @@ -20,29 +21,19 @@ properties:
>>>             - const: qcom,sdx55-pcie-ep
>>>       reg:
>>> -    items:
>>> -      - description: Qualcomm-specific PARF configuration registers
>>> -      - description: DesignWare PCIe registers
>>> -      - description: External local bus interface registers
>>> -      - description: Address Translation Unit (ATU) registers
>>> -      - description: Memory region used to map remote RC address space
>>> -      - description: BAR memory region
>>> +    minItems: 6
>>> +    maxItems: 7
>>>       reg-names:
>>> -    items:
>>> -      - const: parf
>>> -      - const: dbi
>>> -      - const: elbi
>>> -      - const: atu
>>> -      - const: addr_space
>>> -      - const: mmio
>>> +    minItems: 6
>>> +    maxItems: 7
>>
>> Don't move these into if/then schemas. Then we are duplicating the
>> names, and there is no reason to keep them aligned for new compatibles.
>>
>> Rob
>
> Hi Rob,
> As we have one extra reg property (dma) required for sa8775p-pcie-ep,
> isn't it expected to be moved in if/then as per number of regs
> required. Anyways we would have duplication of some properties for new
> compatibles where the member numbers differs for a property.
>
> Are you suggesting to add the extra reg property (dma) in the existing 
> reg and reg-names list, and add minItems/maxItems for all compatibles 
> present in this file ?
>
> -Shazad

Here we have defined reg and interrupt per platform as clocks is defined.

-Mrinmay

