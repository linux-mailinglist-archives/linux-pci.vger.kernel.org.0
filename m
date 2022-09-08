Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CDB5B14D1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIHGir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIHGib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 02:38:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9FC58EE;
        Wed,  7 Sep 2022 23:38:16 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28868lwN014949;
        Thu, 8 Sep 2022 06:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fBPBc+XaYWV7chVmMK9AD1r9uiWocLmvg51wePjBCx8=;
 b=VbWuxemMyVIRn9fH9ue0PKys8KxLTmMHSmjtBDx84UElEreFR2PQBMNqguiyCMiKKwJG
 YPLK9BCShjh1VCvLVilV52/iblNDCtTFdqUe44aFAu99w8XymKGUvbNljtuQyEbotTQG
 jTzWhykb4TIgzBaqYlo1M2gWcpX24ILE6mlgukEMxnsHJt1BzjqoFQl8FDLvvvPugyDn
 uv9+izGLBPTNK8NJ+hCDxbrZZx4G0SHAez98rnF8cx/O0+EXqRkvirW6yL6ov8+i1AxB
 7/3LXqGotEMFF789Fg2OZwZ739hPby+9+8i22iulfHaYz0oNHQYfY2GSy9fs1DBWePvc sg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jequfkmr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 06:38:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2886c76f020663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 06:38:07 GMT
Received: from [10.216.34.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 23:38:00 -0700
Message-ID: <f40002d3-8444-fe53-e54d-521bd1aae3eb@quicinc.com>
Date:   Thu, 8 Sep 2022 12:07:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] dt-bindings: pci: QCOM Add missing sc7280 aggre0,
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
References: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com>
 <1662171184-25211-3-git-send-email-quic_krichai@quicinc.com>
 <5630d0e7-bdfb-36f4-6cd8-9ca986bb2a11@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <5630d0e7-bdfb-36f4-6cd8-9ca986bb2a11@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qt6E-tX9fc7hIzNMM6EB2n2mzToraMZi
X-Proofpoint-ORIG-GUID: Qt6E-tX9fc7hIzNMM6EB2n2mzToraMZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_04,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080023
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/7/2022 5:52 PM, Krzysztof Kozlowski wrote:
> On 03/09/2022 04:13, Krishna chaitanya chundru wrote:
>> Add missing aggre0 and aggre1 clocks.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> changes since v2:
>> 	- Increase the max items of clock's in common properties.
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 0b69b12..b759465 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -53,11 +53,11 @@ properties:
>>     # Platform constraints are described later.
>>     clocks:
>>       minItems: 3
>> -    maxItems: 12
>> +    maxItems: 13
>>   
>>     clock-names:
>>       minItems: 3
>> -    maxItems: 12
>> +    maxItems: 13
>>   
>>     resets:
>>       minItems: 1
>> @@ -423,8 +423,8 @@ allOf:
>>       then:
>>         properties:
>>           clocks:
>> -          minItems: 11
>> -          maxItems: 11
>> +          minItems: 13
>> +          maxItems: 13
>>           clock-names:
>>             items:
>>               - const: pipe # PIPE clock
>> @@ -437,6 +437,8 @@ allOf:
>>               - const: bus_slave # Slave AXI clock
>>               - const: slave_q2a # Slave Q2A clock
>>               - const: tbu # PCIe TBU clock
>> +            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
>> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
>>               - const: ddrss_sf_tbu # PCIe SF TBU clock
> Why adding them in the middle, not at the end of list? It does not match
> other variants and affects the DTB ABI (order is strict).
>
> Best regards,
> Krzysztof
Ok I will change the order as suggested.
