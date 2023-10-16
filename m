Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568B7C9E2F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 06:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjJPEZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 00:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPEZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 00:25:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB9D9;
        Sun, 15 Oct 2023 21:24:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G4CmPe022920;
        Mon, 16 Oct 2023 04:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zhMBRZQhgC83YjgI57bq83F+OxOjJ6pEhJ2qxA55s4w=;
 b=MeRQseu5pig90vGmK88mdTXasRRIj2iKuSLjnaqQgg4V/La3sDgZkkWq7H3CX/il+HB9
 qCl9+kNVkbesdZX1IKfFHjYmE6GAZIH4KiYrMdGtUrkhDBO8TotxqDrCOgr+x+tvoqPj
 2peEqdZnZg5MRVYAC1i082ahwYdehL5s4MVk0uLHtFAtgm5LiQvExWD6qazhyImJtDB0
 dXBIgdt/CwfxlQ1o6txQyL+Lg9sFJyxradY3aDI9rlszCb7xH1yg+gOUZMrUd8jnsQs0
 u44U38w+8xF1ZRrbBvuPpTqysMo/LVm44eEwetMQaOLw/rcv3ItsptGmOX7hL1ngrK/d YA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqk2yu2p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 04:24:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39G4OXj2025448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 04:24:33 GMT
Received: from [10.216.20.227] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 15 Oct
 2023 21:24:26 -0700
Message-ID: <5bf1a4c5-6902-690e-78da-648ca957c5cf@quicinc.com>
Date:   Mon, 16 Oct 2023 09:54:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P
 SoC
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Rob Herring <robh@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
 <8effa7e5-a223-081b-75b8-7b94400d42e6@quicinc.com>
 <CAA8EJpp+3_A-9YXF1yOKdFweVKqrpTxvxKoJcUH6qiDHfCQ-dQ@mail.gmail.com>
 <31e6aab6-73f9-a421-9dfa-292d9d0e9649@quicinc.com>
 <CAA8EJprSxKXjZTH8tCHGvw4zBp_H-DunS9v9kvp=aFRNd55OhA@mail.gmail.com>
Content-Language: en-US
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <CAA8EJprSxKXjZTH8tCHGvw4zBp_H-DunS9v9kvp=aFRNd55OhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OwZgvf68Whj3ddHOjYGqAAzLq7KNoa59
X-Proofpoint-ORIG-GUID: OwZgvf68Whj3ddHOjYGqAAzLq7KNoa59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310160038
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/13/2023 10:08 PM, Dmitry Baryshkov wrote:
> On Fri, 13 Oct 2023 at 15:55, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>>
>> On 10/11/2023 5:13 PM, Dmitry Baryshkov wrote:
>>> On Wed, 11 Oct 2023 at 14:14, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>>>> On 10/6/2023 4:24 PM, Shazad Hussain wrote:
>>>>> On 9/22/2023 12:08 AM, Rob Herring wrote:
>>>>>> On Wed, Sep 20, 2023 at 07:25:08PM +0530, Mrinmay Sarkar wrote:
>>>>>>> Add devicetree bindings support for SA8775P SoC.
>>>>>>> Define reg and interrupt per platform.
>>>>>>>
>>>>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>>>>> ---
>>>>>>>     .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 130
>>>>>>> +++++++++++++++++----
>>>>>>>     1 file changed, 108 insertions(+), 22 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>>>> b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>>>> index a223ce0..e860e8f 100644
>>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>>>> @@ -13,6 +13,7 @@ properties:
>>>>>>>       compatible:
>>>>>>>         oneOf:
>>>>>>>           - enum:
>>>>>>> +          - qcom,sa8775p-pcie-ep
>>>>>>>               - qcom,sdx55-pcie-ep
>>>>>>>               - qcom,sm8450-pcie-ep
>>>>>>>           - items:
>>>>>>> @@ -20,29 +21,19 @@ properties:
>>>>>>>               - const: qcom,sdx55-pcie-ep
>>>>>>>         reg:
>>>>>>> -    items:
>>>>>>> -      - description: Qualcomm-specific PARF configuration registers
>>>>>>> -      - description: DesignWare PCIe registers
>>>>>>> -      - description: External local bus interface registers
>>>>>>> -      - description: Address Translation Unit (ATU) registers
>>>>>>> -      - description: Memory region used to map remote RC address space
>>>>>>> -      - description: BAR memory region
>>>>>>> +    minItems: 6
>>>>>>> +    maxItems: 7
>>>>>>>         reg-names:
>>>>>>> -    items:
>>>>>>> -      - const: parf
>>>>>>> -      - const: dbi
>>>>>>> -      - const: elbi
>>>>>>> -      - const: atu
>>>>>>> -      - const: addr_space
>>>>>>> -      - const: mmio
>>>>>>> +    minItems: 6
>>>>>>> +    maxItems: 7
>>>>>> Don't move these into if/then schemas. Then we are duplicating the
>>>>>> names, and there is no reason to keep them aligned for new compatibles.
>>>>>>
>>>>>> Rob
>>>>> Hi Rob,
>>>>> As we have one extra reg property (dma) required for sa8775p-pcie-ep,
>>>>> isn't it expected to be moved in if/then as per number of regs
>>>>> required. Anyways we would have duplication of some properties for new
>>>>> compatibles where the member numbers differs for a property.
>>>>>
>>>>> Are you suggesting to add the extra reg property (dma) in the existing
>>>>> reg and reg-names list, and add minItems/maxItems for all compatibles
>>>>> present in this file ?
>>> This is what we have been doing in other cases: if the list is an
>>> extension of the current list, there is no need to duplicate it. One
>>> can use min/maxItems instead.
>> Hi Dmitry
>>
>> we have tried using min/maxItems rather than duplicating but somehow
>> catch up with some warnings in dt_bindings check
>>
>> //local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
>> pcie-ep@1c00000: reg: [[29360128, 12288], [1073741824, 3869],
>> [1073745696, 200], [1073745920, 4096], [1073750016, 4096], [29372416,
>> 12288]] is too short//
>> //        from schema $id:
>> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
>> ///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
>> pcie-ep@1c00000: reg-names: ['parf', 'dbi', 'elbi', 'atu', 'addr_space',
>> 'mmio'] is too short//
>> //        from schema $id:
> missing min/maxItems for reg and reg-names
>
>> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
>> ///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
>> pcie-ep@1c00000: interrupts: [[0, 140, 4], [0, 145, 4]] is too short//
>> //        from schema $id:
>> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
>> ///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
>> pcie-ep@1c00000: interrupt-names: ['global', 'doorbell'] is too short//
>> //        from schema $id:
>> http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
> incorrect min/maxItems for interrupts.
I am getting the same warnings even after correcting the min/maxItems 
for interrupt.
> -Mrinmay
>> //local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:
>> pcie-ep@1c00000: interrupt-names: ['global', 'doorbell'] is too short/
>>
>> added the patch in attachment.
>>
>> --Mrinmay
>>
>>>>> -Shazad
>>>> Here we have defined reg and interrupt per platform as clocks is defined.
>>>>
>>>> -Mrinmay
>>>>
>
>
