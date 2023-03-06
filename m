Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836B6AC498
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCFPPV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjCFPPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:15:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527A28D10;
        Mon,  6 Mar 2023 07:14:58 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326BCcBo009765;
        Mon, 6 Mar 2023 15:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wg+4lrM+uJFEj915XHYQWom2ik0PMtGmy04CrQS8vaY=;
 b=fbHV66+VqDJ7NpcYcRlUug3l3i37DzGqr+G41WFWm+tv/ACMVVhmug9tN8gJ6DYuIv+U
 /uXEc4miXRWbPmU1D2JulPX1uWAUOSrYiW46iQy5RboGEzAGa9g9Rk1RtdbmsiGStE9d
 gS1fK6KhkpXzbqySgedyCmePqDF2UsivNpkzrU3+aenoZxQRmLRsEkQr041ayKzRIXxI
 Bj72KZgzug8en7P4lcZLfoMhksHFGFRJoJ4I0kG//N/OItEleyYwW8AfUGOVwwGQS3Ob
 JEkNtVRoatwI8IvFgwO8+oE8CZ22V19TkIdwVw6P3A8DlMBckKNDYtHL+WQnjKrFH2+o XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417d512t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:14:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326FEpHR010018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 15:14:51 GMT
Received: from [10.216.34.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 07:14:44 -0800
Message-ID: <785e0072-b9a1-38d5-cefc-67accf77d705@quicinc.com>
Date:   Mon, 6 Mar 2023 20:44:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5/6] ARM: dts: qcom: sdx65-mtp: Enable PCIE0 PHY
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-6-git-send-email-quic_rohiagar@quicinc.com>
 <f2660adc-e6c8-9de6-e1d6-7abdc7ad7249@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <f2660adc-e6c8-9de6-e1d6-7abdc7ad7249@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RginryrlZM-pK5PlBwNCrX6Rtbm--8PJ
X-Proofpoint-ORIG-GUID: RginryrlZM-pK5PlBwNCrX6Rtbm--8PJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=602
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/6/2023 4:00 PM, Konrad Dybcio wrote:
>
> On 6.03.2023 06:25, Rohit Agarwal wrote:
>> Enable PCIE0 PHY on SDX65 MTP for PCIE EP.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
> Status should go last. It would be nice if you could update
> that for the other nodes in this dt while at it.

Yes, Surely will do.

Thanks,
Rohit.
>
> Konrad
>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> index 85ea02d..86bb853 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> @@ -245,6 +245,13 @@
>>   	status = "okay";
>>   };
>>   
>> +&pcie0_phy {
>> +	status = "okay";
>> +
>> +	vdda-phy-supply = <&vreg_l1b_1p2>;
>> +	vdda-pll-supply = <&vreg_l4b_0p88>;
>> +};
>> +
>>   &qpic_bam {
>>   	status = "okay";
>>   };
