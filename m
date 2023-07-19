Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4A758DD6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 08:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGSGdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 02:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGSGde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 02:33:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88E1FC0;
        Tue, 18 Jul 2023 23:33:30 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J6JvJV015401;
        Wed, 19 Jul 2023 06:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ID2LjzaUM2mPD4gOzhPYXzqyBlwYA/lCIfvD10k4Sxo=;
 b=X/koodaJIcPByRLwKyIPNYOa3TIRVKQHlpaKcq5zYE2LJco1aF7VUjGeoElhC+bxCDeQ
 Hn6eVVn/6kN9ECe2nxROVLF2qPCMawmrhLAKFvpnRYeT+YmjOzT9jZVkopIWwNpY7Eu5
 UIeVIkKsqG7dn3NoFGglXwLk/W1eceCWEKRCM5FQhpEs+Zb8q5rrZZIHEl/YVMr0SQy6
 QJLa47/dkIJDjbslhqJmjTgrfHZpNZN0P0OJ8quUW5l2SUkAvzOpl69quBWUmngp+aFc
 Y5XBOOpo0fRx0r7Uy3qYHk0t0PY7c3yi3GQC8Sp4yvfjYABgRWwHkc4xojEEhhyYy80X Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrjmwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:33:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J6XJ00024904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:33:19 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 23:33:14 -0700
Message-ID: <a3bb6e88-9b0f-c504-df35-96892395f188@quicinc.com>
Date:   Wed, 19 Jul 2023 12:03:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 3/4] arm: dts: qcom: sdx55: Add CPU PCIe interconnect
 path
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1689693645-28254-1-git-send-email-quic_krichai@quicinc.com>
 <1689693645-28254-4-git-send-email-quic_krichai@quicinc.com>
 <20230719044118.GC5990@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230719044118.GC5990@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iNjrWpmRU89S4gNbLW-v7o77PXcsuYBX
X-Proofpoint-ORIG-GUID: iNjrWpmRU89S4gNbLW-v7o77PXcsuYBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_03,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=949 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/19/2023 10:11 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 18, 2023 at 08:50:44PM +0530, Krishna chaitanya chundru wrote:
>> Add cpu-pcie interconnect path to sdx65 platform.
> sdx55 and please mention "PCIe RC". Perhaps you should also add "missing"?
>
> - Mani

I will reactify it.

for "PCIe RC" you mean "PCIe EP" as this endpoint node

-KC


>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
>> index df3cd9c..a7c0c26 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
>> @@ -422,8 +422,9 @@
>>   			interrupt-names = "global",
>>   					  "doorbell";
>>   
>> -			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
>> -			interconnect-names = "pcie-mem";
>> +			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>,
>> +					<&mem_noc MASTER_AMPSS_M0 &system_noc SLAVE_PCIE_0>;
>> +			interconnect-names = "pcie-mem", "cpu-pcie";
>>   
>>   			resets = <&gcc GCC_PCIE_BCR>;
>>   			reset-names = "core";
>> -- 
>> 2.7.4
>>
