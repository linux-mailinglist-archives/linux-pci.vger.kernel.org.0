Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA75A5372
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiH2RqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiH2RqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 13:46:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FAE50189;
        Mon, 29 Aug 2022 10:46:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27THTQBT032586;
        Mon, 29 Aug 2022 17:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qcULhw5na7WjnVO6idPF+u7elRJBnOtSnTWNF45lrK0=;
 b=MQG854inpk+i52c05fTdp6Dn9b5i50eF+AOAc94zwO+fmY7VziZl0fJN1kXA920vQ+CV
 /bceIzxfNWfaQGYDLj5QgnAwnJ90+tf2JECHXayBSExZiGDf7w5d0hgGpr9xsPBNwem9
 EeWZ3D8woz6luJZgFhDFkUN/2o4j3Qq7Z1qbkVtkux96NwRhFCpyQVozK2/8Bpt9e8Pg
 XPTdT1p2rhy1V1tzdr08ejf32sLlIV2T0H7+QailY3E6NPPZp3vZg+acZzrsOp+Cp3JA
 sQ9fo4sSL/oZXdBZzdgs8RDH33UirKEQtxJXacj4TAsiwxGVleoMbQ9grrxouO67tLrf Zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7bndwm2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:45:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27THjtjv014865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 17:45:55 GMT
Received: from [10.216.51.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 29 Aug
 2022 10:45:47 -0700
Message-ID: <3dd98ae4-8b19-e241-3b64-fe24509d2cb4@quicinc.com>
Date:   Mon, 29 Aug 2022 23:15:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] dt-bindings: pci: QCOM Adding sc7280 aggre0,
 aggre1 clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-3-git-send-email-quic_krichai@quicinc.com>
 <1fb5f0c6-ff72-b9ba-175a-b5197ed658a7@linaro.org>
 <9de4c3a0-eb95-f4e9-b828-2343241fff41@quicinc.com>
 <75f8b257-7e0a-d871-ab30-37a72f7da56e@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <75f8b257-7e0a-d871-ab30-37a72f7da56e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i5v9jAkoA5ZchZG-MAsPuuu2LDEWx41G
X-Proofpoint-ORIG-GUID: i5v9jAkoA5ZchZG-MAsPuuu2LDEWx41G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/6/2022 8:29 PM, Krzysztof Kozlowski wrote:
> On 06/07/2022 13:55, Krishna Chaitanya Chundru wrote:
>> On 7/4/2022 1:54 PM, Krzysztof Kozlowski wrote:
>>> On 01/07/2022 18:11, Krishna chaitanya chundru wrote:
>>>> Adding aggre0 and aggre1 clock entries to PCIe node.
>>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> index 0b69b12..8f29bdd 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> @@ -423,8 +423,8 @@ allOf:
>>>>        then:
>>>>          properties:
>>>>            clocks:
>>>> -          minItems: 11
>>>> -          maxItems: 11
>>>> +          minItems: 13
>>>> +          maxItems: 13
>>>>            clock-names:
>>>>              items:
>>>>                - const: pipe # PIPE clock
>>>> @@ -437,6 +437,8 @@ allOf:
>>>>                - const: bus_slave # Slave AXI clock
>>>>                - const: slave_q2a # Slave Q2A clock
>>>>                - const: tbu # PCIe TBU clock
>>>> +            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
>>>> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
>>> You ignored my comments from v1 - please don't. This is not accepted.
>>>
>>> Also, please do not send new versions of patchset as reply to some other
>>> threads. It's extremely confusing to find it under something else.
>>>
>>> Best regards,
>>> Krzysztof
>> Hi
>>
>> Krzysztof,
>>
>> Sorry for confusion created which replying this patch.
>>
>> The only comment I got from v1 from you is to run make dtbs_check.
>>
>> I ran that command I found the errors and fixed them and I ran the make dtbs_check again
>> before on v2 and made sure there are no errors.
>>
>> Can you please tell me is there any steps I missed.
> The comment was:
> "This won't work. You need to update other entry."
>
> and then a conditional: "If you test it with
> `make dtbs_check` you will see the errors."
>
> So let's run it together:
>
> /home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
> pci@1c08000: clocks: [[42, 55], [42, 56], [41, 0], [39, 0], [42, 50],
> [42, 52], [42, 53], [42, 57], [42, 58], [42, 177], [42, 178], [42, 8],
> [42, 21]] is too long
>
> 	From schema:
> /home/krzk/dev/linux/linux/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>
> /home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/qcom/sc7280-idp.dtb:
> pci@1c08000: clock-names: ['pipe', 'pipe_mux', 'phy_pipe', 'ref', 'aux',
> 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'tbu', 'aggre0',
> 'aggre1', 'ddrss_sf_tbu'] is too long
>
>
> clocks and clock-names can be maximum 12 items, as defined by schema in
> "properties:" section. You cannot extend it in one place to 13 but leave
> 12 in other, because both constraints are applicable.
>
> If you test it, you will see the errors.
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Sorry for very late reply.

If we increase the common definitions of clocks properties to "13" it is 
sufficient right.


diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml 
b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 92402f1..c9e268d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -53,11 +53,11 @@ properties:
    # Platform constraints are described later.
    clocks:
      minItems: 3
-    maxItems: 12
+    maxItems: 13

    clock-names:
      minItems: 3
-    maxItems: 12
+    maxItems: 13

    resets:

Thanks & Regards,

Krishna Chaitanya.

