Return-Path: <linux-pci+bounces-11260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9772947444
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD14A1C20C1C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AD13D52F;
	Mon,  5 Aug 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MG6vv0cC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D42FB6;
	Mon,  5 Aug 2024 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831267; cv=none; b=hT0396LR+Fgfs48h3CMHSftY8CpkO5i5ri2NoIMpEse+axsi9fRCNf6aDFV4G3IRyxad+iKn/V+QX7PVPAubkAva2ze5KZdpR7t37P6uxsbz+VeFTJPVolX3+nwxiVSgQCo6g2Q+iVYNv9bHxectqTeGHZ/GcnWSjZaUVvBlw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831267; c=relaxed/simple;
	bh=UfiFEZjqs8cBJ4ATk86zjtPkh6B9e6s7CGtEfLaOiio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bfg2vTb+N1jXTSvBphZZS3BuR8f2B2NcGfKFfgXfsQCwMBEJYVZUPUfs0vAGJv8wCzH+q804kHSSUleT03an91H4n7jyIgn2Lf/H5j9mdmqLLYhEuvH6w7t/X9CPk58HoCnIVVgDY31W+HCItT9JQCM+OjRhiryE2V6l8hRTo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MG6vv0cC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VZaC028250;
	Mon, 5 Aug 2024 04:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SiIp8Cas0iczOm15D2IrBfEz2khbfS7fk5fN0ItLcDw=; b=MG6vv0cCjn1Ch23b
	s3V79jQknwfl5KV+20h/8+gFc00ArOCqk2ve0ha4ehfIeKQuvQ/OFsDa7fFry+/T
	Hsj1+DpogUhEeapQNJmuPwisNKTKrkSIn2ZZ44pAiSn7IMvqGsVVmbL3R57nh08I
	0lrVCaMtKl2gx9AdhpQasAsSVURsg9HAkKXHMOTHFo5/DhjmwmLntCt1Qa842Hpe
	Rle7Ne0l3vCLtMGhy1PnzoZqvi1YjgSWLcQyTeiBo3zFFaPKrj0pPv7nSeY//wcL
	BJzhcJM+ecI9wtX1ZIr8r/NFFIuhMx1PcRvAzkEYulNye5d7t4pRSyC6zhINMypk
	wnKMDA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdae2qfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:14:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754EB8K018434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:14:11 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:14:05 -0700
Message-ID: <7657a89c-498d-7cf8-f271-f1d3229b5d53@quicinc.com>
Date: Mon, 5 Aug 2024 09:44:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: qcs6490-rb3gen2: Add node for
 qps615
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-3-9560b7c71369@quicinc.com>
 <e0f61e73-3321-48b2-9fe9-1ffa547cab08@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <e0f61e73-3321-48b2-9fe9-1ffa547cab08@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b4CX-9ztDsMraAlgU7NeLADo4o3YDhNc
X-Proofpoint-GUID: b4CX-9ztDsMraAlgU7NeLADo4o3YDhNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050028



On 8/4/2024 2:24 PM, Krzysztof Kozlowski wrote:
> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>> Add QPS615 PCIe switch node which has 3 downstream ports and in one
>> downstream port two embedded ethernet devices are present.
>>
>> Power to the QPS615 is supplied through two LDO regulators, controlled
>> by two GPIOs, these are added as fixed regulators.
>>
>> Add i2c device node which is used to configure the switch.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 121 +++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>   2 files changed, 122 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 0d45662b8028..59d209768636 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -202,6 +202,30 @@ vph_pwr: vph-pwr-regulator {
>>   		regulator-min-microvolt = <3700000>;
>>   		regulator-max-microvolt = <3700000>;
>>   	};
>> +
>> +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDD_NTN_0P9";
>> +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
>> +		regulator-min-microvolt = <899400>;
>> +		regulator-max-microvolt = <899400>;
>> +		enable-active-high;
>> +		pinctrl-0 = <&ntn_0p9_en>;
>> +		pinctrl-names = "default";
>> +		regulator-enable-ramp-delay = <4300>;
>> +	};
>> +
>> +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDD_NTN_1P8";
>> +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		enable-active-high;
>> +		pinctrl-0 = <&ntn_1p8_en>;
>> +		pinctrl-names = "default";
>> +		regulator-enable-ramp-delay = <10000>;
>> +	};
>>   };
>>   
>>   &apps_rsc {
>> @@ -595,6 +619,12 @@ lt9611_out: endpoint {
>>   			};
>>   		};
>>   	};
>> +
>> +	qps615_switch: pcie-switch@77 {
>> +		compatible = "qcom,qps615";
>> +		reg = <0x77>;
>> +		status = "okay";
> 
> Where is it disabled?
> 
let me check this, I taught if we are using a
phandle it should be enabled, if not the case
I will make it as disabled only.
>> +	};
>>   };
>>   
>>   &i2c1 {
>> @@ -688,6 +718,75 @@ &pmk8350_rtc {
>>   	status = "okay";
>>   };
>>   
>> +&pcie1 {
> 
> Entries are ordered.
> 
ack.

-- Krishna Chaitanya.
>> +	status = "okay";
>> +};
> 
> 
>>
> 
> Best regards,
> Krzysztof
> 

