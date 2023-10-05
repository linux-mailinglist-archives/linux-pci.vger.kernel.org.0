Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E066C7BA16E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjJEOut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbjJEOrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 10:47:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40424682;
        Thu,  5 Oct 2023 07:34:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3957jcwf026789;
        Thu, 5 Oct 2023 08:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eE+3lVu2w4k3uwLOxwaySx3ouHPIax279I51XhOh3ug=;
 b=Gry/b2rfE4ADnco0RlmPzyXgRrhKf36W7iHcINr8grmWGfu1fTEVPbwQhcAGM9kBy3/O
 UKE1C2vjiPntBn2lng2F4ZMmkytnS2PeItM5JLROMesiW9t0rr8wg/46W3/89Euu9weF
 jQ7ztUONtPX5DNjh7BG2anhIcmRKFlndK1DEmKqh0MS5xvhIdxUbdEa66393imoi20ce
 CQtaP76GMbQVsyUT4tK8aj2mUvuTC83MgwH7n0T3GB6iTvNr/3Udc2X0YR7N/K/k1I9+
 UrIcWSvyXiW6tbu4vWR7PKcy++QghmS6fcYXxd0RVJg76ZCQfpjXlj0geheQNKeBH/tw xA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgynhbh8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 08:53:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3958qxDO027273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 08:52:59 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 01:52:52 -0700
Message-ID: <396a55c1-8ae3-8296-2826-e7ab0f5cb103@quicinc.com>
Date:   Thu, 5 Oct 2023 14:22:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vireshk@kernel.org>, <nm@ti.com>,
        <sboyd@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-3-git-send-email-quic_krichai@quicinc.com>
 <20230928183808.GA10963@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230928183808.GA10963@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: po57y_E2hETBeVbcWCnsVmh_SpTwKbCa
X-Proofpoint-ORIG-GUID: po57y_E2hETBeVbcWCnsVmh_SpTwKbCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=992 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050067
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/29/2023 12:08 AM, Manivannan Sadhasivam wrote:
> On Thu, Sep 07, 2023 at 11:30:30AM +0530, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based up on the PCIe gen speed.
>>
>> So let's add the OPP table support to specify RPMH performance states.
>>
>> Use opp-level for the PCIe gen speed for easier use.
>>
> So, you just want to control RPMh performance state using OPP and not clock
> rates? What will happen if you switch to lowest performance state of RPMh but
> still run PCIe clocks at max rate?
>
> - Mani

Based up on the RPMH state the clock rates will be scaled accordingly.

- KC

>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 2a60cf8..a6264a5 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -1820,7 +1820,28 @@
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie0_default_state>;
>>   
>> +			operating-points-v2 = <&pcie0_opp_table>;
>> +
>>   			status = "disabled";
>> +
>> +			pcie0_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-1 {
>> +					opp-level = <1>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-2 {
>> +					opp-level = <2>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-3 {
>> +					opp-level = <3>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +				};
>> +			};
>>   		};
>>   
>>   		pcie0_phy: phy@1c06000 {
>> @@ -1932,7 +1953,33 @@
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie1_default_state>;
>>   
>> +			operating-points-v2 = <&pcie1_opp_table>;
>> +
>>   			status = "disabled";
>> +
>> +			pcie1_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-1 {
>> +					opp-level = <1>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-2 {
>> +					opp-level = <2>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-3 {
>> +					opp-level = <3>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-4 {
>> +					opp-level = <4>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +				};
>> +			};
>>   		};
>>   
>>   		pcie1_phy: phy@1c0f000 {
>> -- 
>> 2.7.4
>>
