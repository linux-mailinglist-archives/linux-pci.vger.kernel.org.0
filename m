Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640926AC4A0
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFPQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFPQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:16:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64592332C;
        Mon,  6 Mar 2023 07:16:44 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32653DG6019538;
        Mon, 6 Mar 2023 15:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1SJepisM0ksPR/1P3QZffUzMQIv7G/CW+A9HLGeMBs0=;
 b=eaQ/yd+/TBA6HT+rkgL2e6qkbqQ5fv8k2dA8hAUwZdUncCTl/ASxS2n8mNOH0aC7yMEU
 afe3Jrehd1E6j6oWZhTwViz14mVNit6yTTyBJTfxTArJRzR0v32Adx94hZZR3ENl55vg
 MaKfXxuZcaNj71hi0QyfCon9WQf0NgHqu0yaiRWlCNVv97gijWxn/LL4mEQn9cB0UTtO
 r1A4QPRHG3VAUbHRcUrlmXFpIB4Cyrq9JsBPidackZXWxfeYo/RphqbGDLngO0g+HEh5
 HWStQ8aTPXHElrAGrW0+Wxhhx2Rn92sEA9luU+z55CeBShI9rmkT6mesu3t1Ip++ZtVW zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417jw2u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:16:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326FGb83027466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 15:16:37 GMT
Received: from [10.216.34.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 07:16:30 -0800
Message-ID: <27536374-7e13-8a68-fd46-66e833175770@quicinc.com>
Date:   Mon, 6 Mar 2023 20:46:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 6/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-7-git-send-email-quic_rohiagar@quicinc.com>
 <a24841f4-ad59-24dd-0110-814995d95655@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <a24841f4-ad59-24dd-0110-814995d95655@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p9jZ2mwPpEvdriWxuU9qqwpL3hvsQNh_
X-Proofpoint-ORIG-GUID: p9jZ2mwPpEvdriWxuU9qqwpL3hvsQNh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=775 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/6/2023 4:02 PM, Konrad Dybcio wrote:
>
> On 6.03.2023 06:25, Rohit Agarwal wrote:
>> Enable PCIe Endpoint controller on the SDX65 MTP board based
>> on Qualcomm SDX65 platform.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts | 46 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> index 86bb853..952de105 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> @@ -252,6 +252,14 @@
>>   	vdda-pll-supply = <&vreg_l4b_0p88>;
>>   };
>>   
>> +&pcie_ep {
>> +	status = "okay";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie_ep_clkreq_default &pcie_ep_perst_default
>> +			&pcie_ep_wake_default>;
> status last
>
> pinctrl-n goes before pinctrl-names
>> +};
>> +
>>   &qpic_bam {
>>   	status = "okay";
>>   };
>> @@ -276,6 +284,44 @@
>>   	memory-region = <&mpss_adsp_mem>;
>>   };
>>   
>> ++&tlmm {
>> +	pcie_ep_clkreq_default: pcie_ep_clkreq_default {
> No underscores in node names, pinctrl children node names
> must end in -state. Please check your patches against
> "make dtbs_check"
>> +		mux {
>> +			pins = "gpio56";
>> +			function = "pcie_clkreq";
>> +		};
>> +		config {
>> +			pins = "gpio56";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
> mux {} / config {} is unnecessary. You can simply do:
>
> {
>      pins = "gpio56";
>      function = "pcie_clkreq";
>      drive-strength = <2>;
>      bias-disable;
> };
Thanks for detailed explanation. Will rectify all in the next version.

Thanks,
Rohit.
> Konrad
>> +	};
>> +
>> +	pcie_ep_perst_default: pcie_ep_perst_default {
>> +		mux {
>> +			pins = "gpio57";
>> +			function = "gpio";
>> +		};
>> +		config {
>> +			pins = "gpio57";
>> +			drive-strength = <2>;
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	pcie_ep_wake_default: pcie_ep_wake_default {
>> +		mux {
>> +			pins = "gpio53";
>> +			function = "gpio";
>> +		};
>> +		config {
>> +			pins = "gpio53";
>> +			drive-strength = <2>;
>> +			bias-disable;
>> +		};
>> +	};
>> +};
>> +
>>   &usb {
>>   	status = "okay";
>>   };
