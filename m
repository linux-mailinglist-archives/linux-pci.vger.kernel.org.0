Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9F6DDD20
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDKOBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 10:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjDKOBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 10:01:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D53C26;
        Tue, 11 Apr 2023 07:01:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BDREG7000410;
        Tue, 11 Apr 2023 14:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i4JXZ/+C19m2J5iqS6POWClSCNVPg9jd/RyGMq+Bk6Y=;
 b=UD9pjPxeXir2p/IXG0Hn+4Ij9yyTcgvXdK/7RLwSHldFk+900CZt0EvF1H8HVg9Hu43/
 f1vuyKdiKJb83W57c/mT3Zv7lowMsUIvnjLhGu8Xu5JVXFxMv0fdAuw+xmAduA1Pwibt
 vjwQWq8+JsTv/ncvkLbacHviS19fpSeSNbFdlhaOU4vX8kOuk/l85vYCzCfpF5CanFDd
 wxfo/LxumMsBrk/lriNdO7+fXsUxUbXHkrJZm+Y+6qjjr3tcBnhs+UWW0n9C+ddxLOSw
 CxzgnG+PXr6L/IraAhSuv9rMyLo6pr8oa0Ycgee0dwB3vColi5ruwRE8kIzXsZTs6fDj uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvvux1j00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 14:00:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BE0Tt7025460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 14:00:29 GMT
Received: from [10.216.4.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 07:00:19 -0700
Message-ID: <9fd81c81-7d54-80ef-3054-9dc3b0c379e1@quicinc.com>
Date:   Tue, 11 Apr 2023 19:30:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 5/9] dt-bindings: PCI: qcom: Add IPQ9574
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-6-quic_devipriy@quicinc.com>
 <79ddaff0-00a9-36db-2bc0-4c844ffd9528@linaro.org>
 <999dfe1c-3b0d-1cc1-7407-e0917fc62d77@quicinc.com>
 <20230411115201.GM5333@thinkpad>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230411115201.GM5333@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vHMpBYB7vrtU41ZLYNZaDoGP4xpUEXGe
X-Proofpoint-ORIG-GUID: vHMpBYB7vrtU41ZLYNZaDoGP4xpUEXGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_09,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110130
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/11/2023 5:22 PM, Manivannan Sadhasivam wrote:
> On Tue, Apr 11, 2023 at 04:27:23PM +0530, Devi Priya wrote:
>>
>>
>> On 4/5/2023 12:28 PM, Krzysztof Kozlowski wrote:
>>> On 04/04/2023 18:48, Devi Priya wrote:
>>>> Add bindings for PCIe hosts on IPQ9574 platform and allow
>>>> msi-parent property
>>>
>>> Missing full stop. Also in your other patches.
>> Okay
>>>
>>>>
>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>> ---
>>>>    Changes in V2:
>>>> 	- Updated the commit message and dropped the aggr_noc entries
>>>> 	  as it will be handled via interconnect driver
>>>>
>>>>    .../devicetree/bindings/pci/qcom,pcie.yaml    | 48 +++++++++++++++++++
>>>>    1 file changed, 48 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> index fb32c43dd12d..8657ab65008c 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>> @@ -26,6 +26,7 @@ properties:
>>>>              - qcom,pcie-ipq8064-v2
>>>>              - qcom,pcie-ipq8074
>>>>              - qcom,pcie-ipq8074-gen3
>>>> +          - qcom,pcie-ipq9574
>>>>              - qcom,pcie-msm8996
>>>>              - qcom,pcie-qcs404
>>>>              - qcom,pcie-sa8540p
>>>> @@ -105,6 +106,8 @@ properties:
>>>>        items:
>>>>          - const: pciephy
>>>> +  msi-parent: true
>>>
>>
>> Yes right, will rebase it on Mani's series.
>> But, as you have pointed out don't see the binding changes
>> in linux-next/master
>> Mani, could you please provide the tree details onto which the
>> binding change is merged?
>>
> 
> Looks like the initial msi-map binding's patch [1] never got merged even though
> the dts patch went in.
> 
> I'll squash the later fix to this, post v4 and CC you.

Thanks for that..I could see V4 posted!
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/20230102105821.28243-3-manivannan.sadhasivam@linaro.org/
> 
>>> Isn't this conflicting with Mani's series:
>>> https://lore.kernel.org/all/20230108203340.GA229573-robh@kernel.org/
>>> https://lore.kernel.org/all/20230111123004.21048-1-manivannan.sadhasivam@linaro.org/#t
>>>
>>> Although for some reason Mani's patch references non-existing commit and
>>> hunk...
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Best Regards,
>> Devi Priya
> 
