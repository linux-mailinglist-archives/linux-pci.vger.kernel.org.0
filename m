Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2F377DCB7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbjHPIu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbjHPIuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 04:50:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41FB9;
        Wed, 16 Aug 2023 01:50:07 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G5MkpB005503;
        Wed, 16 Aug 2023 08:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=40meR9bstQDjQJbhDP4YliQdTxun7/ifk27IezbH6s4=;
 b=p7XuHbN8IQEW75/TbmD4JQTOfmqunVBGg8Wg7RczptoJO8pO1xATtMbiSOGC7QMdpj32
 9xKSCK+XvSJZfug6+QlpH6TDLZ/Grt59w4V5i+8vpgLXXiLvB0jJfPKl2ExUcvv6+ioj
 hBkYiZfiPemnggVfqYcSG8Bgi9JW1ccLwffZF9l7euqtpNEOLpMhoJ9dy26U9pdL7tQY
 QLv1H4OQIEFPQFIgrFMsOOqWBUdOodXk9K1kunS6dZQO9EDf/9VW7X6D7yCqU+dERO+s
 BfXVvrjEm7e6i3BSZ472B+0caJ1iijujZ+jz+XyXLVg7NeFLxXOJhkwAdCUkUhj67cwH NQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgf5u986j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:49:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G8nqfU006272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:49:52 GMT
Received: from [10.218.41.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 01:49:45 -0700
Message-ID: <7f5a587a-b5e9-bfb1-3025-dcd28a56d94b@quicinc.com>
Date:   Wed, 16 Aug 2023 14:19:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 1/3] dt-bindings: pci: qcom: Add binding for
 operating-points-v2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-2-git-send-email-quic_krichai@quicinc.com>
 <079b6c94-0507-4ff1-86c3-14d6a6080b4b@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <079b6c94-0507-4ff1-86c3-14d6a6080b4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 03ZeQQtt82YmqoaVk91fOYHHHeSa-dmv
X-Proofpoint-GUID: 03ZeQQtt82YmqoaVk91fOYHHHeSa-dmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_07,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160078
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/15/2023 6:00 PM, Krzysztof Kozlowski wrote:
> On 15/08/2023 14:26, Krishna chaitanya chundru wrote:
>> This adds a binding documenting operating-points-v2.
> 1. Missing blank line. Don't write patches by yourself, but use tools
> which create proper commit automatically. Every decent editor does it.
>
> 2. Please do not use "This commit/patch", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>
> 3. A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
>
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 81971be4..6bc99c5 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -121,6 +121,8 @@ properties:
>>       description: GPIO controlled connection to WAKE# signal
>>       maxItems: 1
>>   
>> +  operating-points-v2: true
> phandle without actual table (opp-table) is rather meaningless.
>
> Best regards,
> Krzysztof

I will take all your comments and will send next patch

- KC

