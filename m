Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD177DCBE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbjHPIvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbjHPIvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 04:51:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D52700;
        Wed, 16 Aug 2023 01:51:12 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G7ND39023571;
        Wed, 16 Aug 2023 08:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PSzcVYQ2yZTnZcul0dm5Q6PpJl+Zobzq+LZzBLE9u9M=;
 b=GXofoVZUDA3TbJlbJQYxCtzliBXPW0O91oZ0AxjIx+nlDW/6A4x606uGy9ESC3izK1cu
 Ns4BjrCtHrhUDJgoMGf24BWuIpCqZWfTC8oo9XzoD6CJfMa2kh6d9HAApAHSmYnBv7He
 TdgXaUqzxf5RAhfrn/8X4q7aqHb9dcCvdvJ/uroAGrW6mbNP0YgtAYQqiaLwILu1bCbV
 8qNxNvrQ/6CvM8KY2UDci5QGTVpEWboGnirr68F5JtUCnHlILTbplCkSh90qeOBfjoSn
 46kPTTfNa/QUaWwfY6e80ukynf9zPz9diDKizPD/1KEcM8IqcDEtfre5Iqw4lo8CUwKb 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgmkkrqnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:51:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G8p33v021917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:51:03 GMT
Received: from [10.218.41.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 01:50:58 -0700
Message-ID: <1a914071-d000-eaad-7941-30589f8e1da3@quicinc.com>
Date:   Wed, 16 Aug 2023 14:20:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
 <7fe554e9-27c3-9af4-8167-ae4329c40eb7@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <7fe554e9-27c3-9af4-8167-ae4329c40eb7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nEBcBHbGBzTTarXPtVQwoH4lU1xgeFAn
X-Proofpoint-GUID: nEBcBHbGBzTTarXPtVQwoH4lU1xgeFAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_07,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=922 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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


On 8/15/2023 6:01 PM, Krzysztof Kozlowski wrote:
> On 15/08/2023 14:26, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based upon the PCIe gen speed.
> This explanation should be also in bindings patch, otherwise why would
> we consider the bindings patch?
I will update binding patch with this information.
>
>> So, let's add the OPP table support to specify RPMH performance states.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 595533a..681ea9c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -381,6 +381,49 @@
>>   		};
>>   	};
>>   
>> +	pcie0_opp_table: opp-table-pcie0 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-2500000 {
>> +			opp-hz = /bits/ 64 <2500000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-5000000 {
>> +			opp-hz = /bits/ 64 <5000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-8000000 {
>> +			opp-hz = /bits/ 64 <8000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +	};
>> +
>> +	pcie1_opp_table: opp-table-pcie1 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-2500000 {
>> +			opp-hz = /bits/ 64 <2500000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-5000000 {
>> +			opp-hz = /bits/ 64 <5000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-8000000 {
>> +			opp-hz = /bits/ 64 <8000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +		};
>> +
>> +		opp-16000000 {
>> +			opp-hz = /bits/ 64 <16000000>;
>> +			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +		};
>> +	};
>> +
>>   	reserved_memory: reserved-memory {
>>   		#address-cells = <2>;
>>   		#size-cells = <2>;
>> @@ -1803,6 +1846,8 @@
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie0_default_state>;
>>   
>> +			operating-points-v2 = <&pcie0_opp_table>;
> Why the table is not here? Is it shared with multiple devices?

I will move the table to here in the next patch.

- KC

>
> Best regards,
> Krzysztof
>
