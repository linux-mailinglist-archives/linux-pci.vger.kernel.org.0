Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672935B14D5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIHGjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 02:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIHGjB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 02:39:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73447C7BAE;
        Wed,  7 Sep 2022 23:38:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2886Q4lK025050;
        Thu, 8 Sep 2022 06:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LPgzPBamNRKA4KxAW8ALy4x4jbE4Kt2EiNmgCKQYneg=;
 b=d6wgSCVYo0O3nlKxcIiakYVxajL5ZG3zOY1iXxBXbWzIpSmVPeqK23dxrL4uZGYLY3Ut
 hK53jDNF5CYdAB6PV+LpMgwxmLnFT1MFM6TGW/ARTKRtBZXgbew2nBciTrgP7FNax97e
 JxFs3m2cozhrpgUQcmKSZEDGXWHrilNmgYmKBv7Ft2Omkz+C+FW0oQ1kdxNWYldnEEWb
 pE6xO1lwzI+ykATPtVe1l5Oj0edDu2LJgbnF2/3KtNkjYxQQv6f6rNNB3SIDFcYpveIm
 U8GwpNbT0AK0WQaSIB2DY1kVrnmrjrLn5Vwzu/RwufMkGvbAqQ6XTIAzi8ROARM1HD1i YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jequfkmrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 06:38:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2886cXHZ021247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 06:38:33 GMT
Received: from [10.216.34.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 23:38:26 -0700
Message-ID: <9609ade9-da03-6c3e-4d1a-80e97ac3b692@quicinc.com>
Date:   Thu, 8 Sep 2022 12:08:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc7280: Add missing aggre0,
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
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com>
 <1662171184-25211-4-git-send-email-quic_krichai@quicinc.com>
 <cc00fad3-08fb-462a-12ac-73143aa4206f@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <cc00fad3-08fb-462a-12ac-73143aa4206f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9tovZ1LiDMIuOSwd9RYarpfoggFYj1RV
X-Proofpoint-ORIG-GUID: 9tovZ1LiDMIuOSwd9RYarpfoggFYj1RV
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
>> Add missing aggre0, aggre1 clocks.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index e66fc67..a5ce095 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2043,6 +2043,8 @@
>>   				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
>>   				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
>>   				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
>> +				 <&gcc GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
>>   				 <&gcc GCC_DDRSS_PCIE_SF_CLK>;
>>   
>>   			clock-names = "pipe",
>> @@ -2055,6 +2057,8 @@
>>   				      "bus_slave",
>>   				      "slave_q2a",
>>   				      "tbu",
>> +				      "aggre0",
>> +				      "aggre1",
>>   				      "ddrss_sf_tbu";
>>   
> Same as binding - adding entries in the middle causes ABI issues.
>
> Best regards,
> Krzysztof
Ok I will change the order as suggested.
