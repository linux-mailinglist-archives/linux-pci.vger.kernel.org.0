Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853877DCCA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbjHPIwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbjHPIwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 04:52:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A410C8;
        Wed, 16 Aug 2023 01:52:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G7lfPA001894;
        Wed, 16 Aug 2023 08:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZfD++9r9JeIl8KODbqqMNO/rVxhbqdn9kGFpH6XB+FY=;
 b=LEIfa8mlfV2Hay55q25Ekw/SOk+ThmYZvcwWEQUWwM2/C3zICrADdu9SNCVB+/FTSCpq
 EvX/FxNb5V2lHsqUe+NHeHt4YvPEQCV174o2K1wCTgvb/vwhb/OTqXueWyr7DKhiylZ/
 l4xT6QYF7V75IOn1huOmvqaZ95kWQgxsHiV7TBe2R27cxvZS7jA+Yzmko52MuyXaKfyY
 V5idJjY9gD/a96qgV0Kh70DLr6TJeN0NNy3YQMdqhnKkaRv8k9aexNCRlWHYOFlC1sqZ
 M5HgGXlobG3edr95cyLQU1XvENFsCzFcTwEJuArGL6m95BWAOiSIGLL02jf/qxAS5+sF cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfxqru14q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:52:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G8pwsD024321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:51:59 GMT
Received: from [10.218.41.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 01:51:53 -0700
Message-ID: <fea290b8-374c-f6fd-bef1-a8944fb16c53@quicinc.com>
Date:   Wed, 16 Aug 2023 14:21:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
 <dc14acb4-9fe8-4b3b-a9da-7f7915de4d5c@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <dc14acb4-9fe8-4b3b-a9da-7f7915de4d5c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cwIP8DIqmGgk2846J7K-dV1E5DdmKBsi
X-Proofpoint-ORIG-GUID: cwIP8DIqmGgk2846J7K-dV1E5DdmKBsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_06,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=933 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160078
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/16/2023 12:35 PM, Pavan Kondeti wrote:
> On Tue, Aug 15, 2023 at 05:56:47PM +0530, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based upon the PCIe gen speed.
>>
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
> Should not we using required-opps property to pass the
> rpmhpd_opp_xxx phandle so that when this OPP is selected based on your
> clock rate, the appropriate OPP (voltage) would be selected on the RPMH side?
>
> Please see SDHCI/MMC voting (sdhc2_opp_table) as an example.

Sure I will try to use rpmhpd_opp_xxx phandle in next patch

- KC

>
> Thanks,
> Pavan
