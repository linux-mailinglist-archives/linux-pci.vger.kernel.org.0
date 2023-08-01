Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA37D76A816
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 06:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHAE6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 00:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHAE6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 00:58:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC7B1FC0;
        Mon, 31 Jul 2023 21:58:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3711fvgV012636;
        Tue, 1 Aug 2023 04:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KZxbaDO7QuMFAxblJFKDY2rmUCa1JzWd9myMgUGIk38=;
 b=B5SiWdzYNVNwLOXeBOrmelu/6YBhoa9szETVNitnX72H1o0dVsTlgqypn9EEyxOyf5Gn
 yygL7kszE2g+WadPhdxwoq2CGWTDGP4aRpZUjuWn2C6z65cFqheTYljN4F785f0v2LQ6
 E0AlMEUpEojFAihm0bcCPWMjQL/z4UD42kvEuP7nM32I8tf5N0iLQJ0aqhAzPxnWZySQ
 izctGn02d2Uyvtlvo1ZAIIOrfB6Z66MVzlZBeOgzkC+GHq4iAnHM5xDcSbiV/YqFpdpW
 JlweTBsCRwHNXitF8FUNMDWVPJ1olk9MY1VSHUHZdHggpANfSB4AeAiyCZCfng+DQMv4 sQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6fak9far-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 04:58:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3714wS8t010784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 04:58:28 GMT
Received: from [10.217.219.237] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 21:58:22 -0700
Message-ID: <5481d9ca-4ba0-2545-131b-4a80669061c3@quicinc.com>
Date:   Tue, 1 Aug 2023 10:28:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe
 PHY
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
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
 <ca51b1dc-5805-5b01-01e0-a7dff535cb6c@quicinc.com>
 <y7tuvgc7r4o6jhe7hhyqxaksalld4zn5ou53ywdkwfrp2y773v@z3nvbgd2i6lz>
Content-Language: en-US
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <y7tuvgc7r4o6jhe7hhyqxaksalld4zn5ou53ywdkwfrp2y773v@z3nvbgd2i6lz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0kT6QFnbvNxd5NXSxvMwm7KtVb1BwWqB
X-Proofpoint-GUID: 0kT6QFnbvNxd5NXSxvMwm7KtVb1BwWqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_01,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/25/2023 11:21 PM, Andrew Halaney wrote:
> On Fri, Jul 21, 2023 at 04:33:20PM +0530, Mrinmay Sarkar wrote:
>> On 7/17/2023 12:55 PM, Krzysztof Kozlowski wrote:
>>> On 14/07/2023 07:08, Mrinmay Sarkar wrote:
>>>> Add devicetree YAML binding for Qualcomm QMP PCIe PHY
>>>> for SA8775p platform.
>>>>
>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>> ---
>>>>    .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 19 ++++++++++++++++++-
>>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>>>> index a0407fc..ca55ed9 100644
>>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>>>> @@ -16,6 +16,8 @@ description:
>>>>    properties:
>>>>      compatible:
>>>>        enum:
>>>> +      - qcom,sa8775p-qmp-gen4x2-pcie-phy
>>>> +      - qcom,sa8775p-qmp-gen4x4-pcie-phy
>>>>          - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>>>>          - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>>>>          - qcom,sc8280xp-qmp-gen3x4-pcie-phy
>>>> @@ -30,7 +32,7 @@ properties:
>>>>      clocks:
>>>>        minItems: 5
>>>> -    maxItems: 6
>>>> +    maxItems: 7
>>>>      clock-names:
>>>>        minItems: 5
>>>> @@ -41,6 +43,7 @@ properties:
>>>>          - const: rchng
>>>>          - const: pipe
>>>>          - const: pipediv2
>>>> +      - const: phy_aux
>>>>      power-domains:
>>>>        maxItems: 1
>>>> @@ -141,6 +144,20 @@ allOf:
>>>>            compatible:
>>>>              contains:
>>>>                enum:
>>>> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
>>>> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 7
>>>> +        clock-names:
>>>> +          minItems: 7
>>>> +
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>> This probably works but is not obvious and easy to read. You have here
>>> if:then:else: block, so else applies to your variant. Change all these
>>> if clauses for clocks into separate clauses per matching variant
>>> (if:then: ... if:then:... if:then:...)
> As far as I can tell, this actually doesn't work :(
>
>>> Best regards,
>>> Krzysztof
>> My Bad here, This patch already applied we will take care this in next patch
>> set.
>>
>> Thanks,
>> Mrinmay
>>
> Mrinmay, do you plan on spinning what Krzysztof suggested? I grabbed
> linux-next today and ran into this (looks like clocks, clock-names in
> binding is broken and looks like we're either missing the required
> power-domain in the dts or it isn't actually required):
>
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % git diff
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1 DT_SCHEMA_FILES=phy/qcom,sc8280xp-qmp-pcie-phy.yaml qcom/sa8775p-ride.dtb
>        UPD     include/config/kernel.release
>        LINT    Documentation/devicetree/bindings
>        CHKDT   Documentation/devicetree/bindings/processed-schema.json
>        SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>      /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file
>        DTC_CHK arch/arm64/boot/dts/qcom/sa8775p-ride.dtb
>      /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c04000: 'power-domains' is a required property
>          from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>      /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c04000: clocks: [[31, 66], [31, 68], [31, 94], [31, 72], [31, 74], [31, 77], [31, 70]] is too long
>          from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>      /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c04000: clock-names: ['aux', 'cfg_ahb', 'ref', 'rchng', 'pipe', 'pipediv2', 'phy_aux'] is too long
>          from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>      /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c14000: 'power-domains' is a required property
>          from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>      /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c14000: clocks: [[31, 80], [31, 82], [31, 94], [31, 86], [31, 88], [31, 91], [31, 84]] is too long
>          from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>      /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: phy@1c14000: clock-names: ['aux', 'cfg_ahb', 'ref', 'rchng', 'pipe', 'pipediv2', 'phy_aux'] is too long
>          from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>      ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1    7.65s user 0.52s system 99% cpu 8.231 total
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] %
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] %
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] %
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % # Total hack just to show our issues in current binding
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % git diff
>      diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>      index ca55ed9d74ac..5476cf2422da 100644
>      --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>      +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
>      @@ -87,7 +87,6 @@ required:
>         - reg
>         - clocks
>         - clock-names
>      -  - power-domains
>         - resets
>         - reset-names
>         - vdda-phy-supply
>      @@ -132,12 +131,6 @@ allOf:
>                 maxItems: 5
>               clock-names:
>                 maxItems: 5
>      -    else:
>      -      properties:
>      -        clocks:
>      -          minItems: 6
>      -        clock-names:
>      -          minItems: 6
>       
>         - if:
>             properties:
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1 DT_SCHEMA_FILES=phy/qcom,sc8280xp-qmp-pcie-phy.yaml qcom/sa8775p-ride.dtb
>        UPD     include/config/kernel.release
>        LINT    Documentation/devicetree/bindings
>        CHKDT   Documentation/devicetree/bindings/processed-schema.json
>        SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>      /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml: ignoring, error parsing file
>        DTC_CHK arch/arm64/boot/dts/qcom/sa8775p-ride.dtb
>      ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1    7.58s user 0.87s system 98% cpu 8.618 total
>      (dtb-checker) ahalaney@fedora ~/git/linux-next (git)-[tags/next-20230724] %
>
>
> Thanks,
> Andrew

Hi Andrew,
Yes, as I mentioned earlier we have plan to send the fixes for this.

Thanks,
Mrinmay

