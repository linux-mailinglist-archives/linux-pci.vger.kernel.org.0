Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F26B0835
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 14:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCHNPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 08:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCHNOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 08:14:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400DED008C;
        Wed,  8 Mar 2023 05:11:15 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328CnaIV032421;
        Wed, 8 Mar 2023 13:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aAsuReQiNd2jwcSVqHIhRcJu0mkLCAPpVs0DGN7TsXo=;
 b=CuD7mWoe6Ek5hdfPR+77cE0tOQ4DKlVVHPvhjNjqcvH6udnRWzc3l4OFBWDxMhbJxqkg
 VW0dxmHPpePfbkTB/xjKMLYTXF9Ka6aEJLdrLDixj0FlQPT77kPa7TX/atv2Rlzu63/u
 TTiTxY1hwryWc8DXftola243ngLOWvRrtwsy8RrXO+lj2zkAuHdI+DECfNLfk7qWlZYn
 klJ2WZaX2PqkiZV6eIoikUV5ddaqCc9mLETueAbNV/N+QyitOiUqyb1ba2QSlWEJ3Moj
 H6A9c1lHYMYw8TW+yIgbSvnJDhC3RK0N6XT1DZoLmPV60mxvDzOpwIuu9LbK2d97o52/ 4w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6femhmau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:10:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328DAiqI028779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 13:10:44 GMT
Received: from [10.216.42.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 05:10:38 -0800
Message-ID: <97a12bba-27e8-2cab-a211-5ed9b4ce49b6@quicinc.com>
Date:   Wed, 8 Mar 2023 18:40:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 5/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678277993-18836-6-git-send-email-quic_rohiagar@quicinc.com>
 <34e0dc8a-2879-b1c2-8567-8ac0cf0ced80@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <34e0dc8a-2879-b1c2-8567-8ac0cf0ced80@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9XQ2-K-apGTIETDH427-2Y8lUJjykygK
X-Proofpoint-ORIG-GUID: 9XQ2-K-apGTIETDH427-2Y8lUJjykygK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=568 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/8/2023 6:08 PM, Konrad Dybcio wrote:
>
> On 8.03.2023 13:19, Rohit Agarwal wrote:
>> Enable PCIe PHY on SDX65 MTP for PCIe EP. While at it,
>> updating status as last property for each node.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> index ed98c83..facb8e2 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> @@ -245,13 +245,18 @@
>>   	status = "okay";
>>   };
>>   
>> -&qpic_bam {
>> +&pcie_phy {
>> +	vdda-phy-supply = <&vreg_l1b_1p2>;
>> +	vdda-pll-supply = <&vreg_l4b_0p88>;
>> +
>>   	status = "okay";
>>   };
>>   
>> -&qpic_nand {
>> +&qpic_bam {
>>   	status = "okay";
>> +};
>>   
>> +&qpic_nand {
>>   	nand@0 {
>>   		reg = <0>;
>>   
>> @@ -262,11 +267,14 @@
>>   		secure-regions = /bits/ 64 <0x500000 0x500000
>>   					    0xa00000 0xb00000>;
>>   	};
>> +
>> +	status = "okay";
> Did you compiletest this?

So Sorry, Missed some of the patches for compiletest.
Will update immediately.

Thanks,
Rohit.
>
> Konrad
>>   };
>>   
>>   &remoteproc_mpss {
>> -	status = "okay";
>>   	memory-region = <&mpss_adsp_mem>;
>> +
>> +	status = "okay";
>>   };
>>   
>>   &usb {
>> @@ -278,14 +286,16 @@
>>   };
>>   
>>   &usb_hsphy {
>> -	status = "okay";
>>   	vdda-pll-supply = <&vreg_l4b_0p88>;
>>   	vdda33-supply = <&vreg_l10b_3p08>;
>>   	vdda18-supply = <&vreg_l5b_1p8>;
>> +
>> +	status = "okay";
>>   };
>>   
>>   &usb_qmpphy {
>> -	status = "okay";
>>   	vdda-phy-supply = <&vreg_l4b_0p88>;
>>   	vdda-pll-supply = <&vreg_l1b_1p2>;
>> +
>> +	status = "okay";
>>   };
