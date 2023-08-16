Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422477E4B3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjHPPIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbjHPPId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 11:08:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFB1FCE;
        Wed, 16 Aug 2023 08:08:31 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCoDlL024301;
        Wed, 16 Aug 2023 15:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+yjbm2wC9dkV2R5Im5ireOw7A+fFrJDohro6OG8JEaY=;
 b=VGplMNsQmUnupi4lDvbz3S9t3T4af/fp3b0IoalR5TW3S8lMNVwyRBCaipbPfWBrsJcx
 /cOYooefwPn7YR465H7+MGm1QAWq+df3zP4Kid+vGpQIrW/dS7d4I/r1j3TuW7PEJdlI
 XkuEze2N39mvtvA3n6aqxmQsdhfeVzSkH+j/1+s3X7Mes2exrEe/KrvGRFcgcrwhSEW+
 c50gpoEEo1vnqLl0gfdn1hAM5Qah6M9mIRtlQ20jQKWWaWtHmJEXkgrxWVMKNp02g/F4
 LHrc0DoQOANhYpum1h9EV+HAvI+/pvwbVA8Bcu2rRo/DHqqGgwd0ON2uooUN5zlZo4UZ jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfxbyksxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 15:08:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GF80jJ017878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 15:08:00 GMT
Received: from [10.216.9.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 08:07:54 -0700
Message-ID: <41151f25-4622-f906-06a2-e8cd65e4b211@quicinc.com>
Date:   Wed, 16 Aug 2023 20:37:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
References: <1692192264-18515-1-git-send-email-quic_krichai@quicinc.com>
 <1692192264-18515-3-git-send-email-quic_krichai@quicinc.com>
 <CAA8EJpoi0BkuQZef=v3JxB-axXe+jB0bEWCmsk1ZJYiaWiuevw@mail.gmail.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAA8EJpoi0BkuQZef=v3JxB-axXe+jB0bEWCmsk1ZJYiaWiuevw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 31cLl94Ge3nJhP_GQHox_prnPM6hwlO2
X-Proofpoint-ORIG-GUID: 31cLl94Ge3nJhP_GQHox_prnPM6hwlO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160131
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/16/2023 7:10 PM, Dmitry Baryshkov wrote:
> On Wed, 16 Aug 2023 at 16:25, Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based upon the PCIe gen speed.
>>
>> So let's add the OPP table support to specify RPMH performance states.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 595533a..c77a683 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -1803,7 +1803,28 @@
>>                          pinctrl-names = "default";
>>                          pinctrl-0 = <&pcie0_default_state>;
>>
>> +                       operating-points-v2 = <&pcie0_opp_table>;
>> +
>>                          status = "disabled";
>> +
>> +                       pcie0_opp_table: opp-table {
>> +                               compatible = "operating-points-v2";
>> +
>> +                               opp-2500000 {
> As a random suggestion: these frequencies are calculated by the
> driver. It might be easier to use opp-level for the PCIe generation
> instead.
>
> This way this OPP entry can become:
>
> opp-1 {
>      opp-level = <1>;
>      required-opps = <&rpmhpd_opp_low_svs>;
> };

This looks good I will try to do in this approach in the next patch if 
there are no other comments.

- KC

>
>> +                                       opp-hz = /bits/ 64 <2500000>;
>> +                                       required-opps = <&rpmhpd_opp_low_svs>;
>> +                               };
>> +
>> +                               opp-5000000 {
>> +                                       opp-hz = /bits/ 64 <5000000>;
>> +                                       required-opps = <&rpmhpd_opp_low_svs>;
>> +                               };
>> +
>> +                               opp-8000000 {
>> +                                       opp-hz = /bits/ 64 <8000000>;
>> +                                       required-opps = <&rpmhpd_opp_nom>;
>> +                               };
>> +                       };
>>                  };
>>
>>                  pcie0_phy: phy@1c06000 {
>> @@ -1915,7 +1936,33 @@
>>                          pinctrl-names = "default";
>>                          pinctrl-0 = <&pcie1_default_state>;
>>
>> +                       operating-points-v2 = <&pcie1_opp_table>;
>> +
>>                          status = "disabled";
>> +
>> +                       pcie1_opp_table: opp-table {
>> +                               compatible = "operating-points-v2";
>> +
>> +                               opp-2500000 {
>> +                                       opp-hz = /bits/ 64 <2500000>;
>> +                                       required-opps = <&rpmhpd_opp_low_svs>;
>> +                               };
>> +
>> +                               opp-5000000 {
>> +                                       opp-hz = /bits/ 64 <5000000>;
>> +                                       required-opps = <&rpmhpd_opp_low_svs>;
>> +                               };
>> +
>> +                               opp-8000000 {
>> +                                       opp-hz = /bits/ 64 <8000000>;
>> +                                       required-opps = <&rpmhpd_opp_low_svs>;
>> +                               };
>> +
>> +                               opp-16000000 {
>> +                                       opp-hz = /bits/ 64 <16000000>;
>> +                                       required-opps = <&rpmhpd_opp_nom>;
>> +                               };
>> +                       };
>>                  };
>>
>>                  pcie1_phy: phy@1c0f000 {
>> --
>> 2.7.4
>>
>
