Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742607976E9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbjIGQSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242985AbjIGQSP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 12:18:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF059F3;
        Thu,  7 Sep 2023 09:04:03 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3879swWG020769;
        Thu, 7 Sep 2023 09:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JJN2an9C7cmZNdVoHcnWUPhZpuiuA4IshU4Q+93acDg=;
 b=krTLe3BVzK1kwTO4z/hdANOSKIW7Wnt8yVUzH5P+yZl6MK040hpCyHCvGCvd3rkxoZgw
 CuGyuIENjG4CNA8ssmIaWcjNOw/9vrIDK2EChJyIGgHiOeU3P/4y9dkMs2FsV4U+Up7A
 8WHmAYERTgVsevoY/PBagE4KVxByQbS7HX4pH+XFXDSEbgYvKdhMNqkTOWEbYL9Case5
 6TjMF5pnczV0TbV6hjL7/oHgB2/+sh2AN6eRALFKfJmB7O/v6Q+WrKS8Devj+lCRpUpI
 67v3ArK0HBrAjiaNft7vCCMWsaftQvpaFgfpn9Wxsf4WSPLMK4ki1UaKfLmsb5vclKsO uQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syaad087m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 09:56:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3879uudp008519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 09:56:57 GMT
Received: from [10.216.2.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 02:56:48 -0700
Message-ID: <347293d1-15e5-5412-9695-01be768283ad@quicinc.com>
Date:   Thu, 7 Sep 2023 15:26:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: sm8450: Add opp table support to
 PCIe
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vireshk@kernel.org>, <nm@ti.com>,
        <sboyd@kernel.org>, <mani@kernel.org>
CC:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-3-git-send-email-quic_krichai@quicinc.com>
 <38f64349-5139-4207-91eb-cd39fabd4496@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <38f64349-5139-4207-91eb-cd39fabd4496@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zu2wqzDPrSeflYuDgfDtMYFS5isYnDnA
X-Proofpoint-GUID: zu2wqzDPrSeflYuDgfDtMYFS5isYnDnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=634
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070087
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/7/2023 2:34 PM, Konrad Dybcio wrote:
> On 7.09.2023 08:00, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based up on the PCIe gen speed.
>>
>> So let's add the OPP table support to specify RPMH performance states.
>>
>> Use opp-level for the PCIe gen speed for easier use.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
> [...]
>
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
> Is gen3 not supposed to require nom like on pcie0?
This particular controller instance can operate at low svs for GEN3.
> Also, can all non-maximum OPPs run at just low_svs?
This depends on the hardware capability, for this instance expect GEN4 
remaining can operate in LOW svs. It varies from controller instance to 
instance and also from target to target.
> Konrad

- KC

