Return-Path: <linux-pci+bounces-12948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E086D9718B7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2921C203A7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCF1B86E1;
	Mon,  9 Sep 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oVILtiVM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6B1B86D6;
	Mon,  9 Sep 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882711; cv=none; b=E1ZS8KMwpAPioTq8MZXYt5RhNpT7dArLaAtRP0KKpHZhpEOcwdxwwV+82OGxyLAGZo30JDuk19QaNkMMNgwh13VpkYA4nizwIKWK8SaXaf449Evbn2P4/vFtRfpfc0hgTisMuytKFCrzoZYdYNul+w/taHPqVLDYDoQcYTmNpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882711; c=relaxed/simple;
	bh=YQ5U22xEPnW/cEnU9qruz0AbAVoyZQZomw6i6ZtcwkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UxQiEK3iEXfZZS/VOPTpJFYjtqGi+1b1Im19aUdFy3iuB0HE4pBPbselX4gE9FuJZtIKw00wklUy/VyP4RIhXj61isK8mMSdDPOXjT9YLfsQwyHLl2L9TMMY1nScgV7mUXML3TQ/5EC7jGKXRbsozNTLHJDGO6Z5JoT2S9FRbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oVILtiVM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899Jtrk030397;
	Mon, 9 Sep 2024 11:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qhqiYbD/RYVLfSTUpXhfOEdedQo4iJVxk+QeQnDjeRw=; b=oVILtiVM5q44EiC7
	rQUFJSeQI1uqleM9RS6wqUUlme0FIhUNjTQpupKiQ2zp+9qcnU6/ygx9dhp3DLTU
	C/ktw/zEaY677iWAGt2ebHT3+EZQo10tO+FB+C6iHbKUWB/0SDm/K8a26BXmdIoj
	pFff29/LpCGiH6yAAMrmvudBwO94vxis5Jir6GMIl8nd7La9yKJRvkY0X7gd+i0l
	AX+55DLvMrjwYtTxkp5bOEXXPr3hecllnHxYBLafuXq9ukOUjzHBQcLkrhsVkYEs
	6J7RESZeMV4HLNucvT3R0WQGTm1bmJ+XtBGrKef7B230/nnJm0Z9NyBowkb8m/b2
	h7AgMg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy72tp88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 11:51:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 489BpVKB013539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 11:51:31 GMT
Received: from [10.216.25.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 04:51:25 -0700
Message-ID: <6bdfb6fc-f375-bf03-7d39-8711c0bee40e@quicinc.com>
Date: Mon, 9 Sep 2024 17:21:22 +0530
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
To: Caleb Connolly <caleb.connolly@linaro.org>,
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
 <1932646a-b138-48f3-99bc-17354a773586@linaro.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1932646a-b138-48f3-99bc-17354a773586@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZNN7Rvbh86t0p1FtahQD6R7IwOYx3u18
X-Proofpoint-GUID: ZNN7Rvbh86t0p1FtahQD6R7IwOYx3u18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409090094



On 9/9/2024 4:59 PM, Caleb Connolly wrote:
> Hi Krishna,
> 
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
>> +	};
>>   };
>>   
>>   &i2c1 {
>> @@ -688,6 +718,75 @@ &pmk8350_rtc {
>>   	status = "okay";
>>   };
>>   
>> +&pcie1 {
>> +	status = "okay";
>> +};
> 
> Isn't it also necessary to configure the phy as well? It's also default
> disabled and has two regulators.
> 
There is one more patch series which does this.

https://lore.kernel.org/linux-arm-msm/20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com/T/

sorry for this I should have included this in cover letter.

I will squash those changes to this series or will update the cover
letter.
- Krishna Chaitanya.

> Kind regards >> +
>> +&pcieport {
>> +	pcie@0,0 {
>> +		compatible = "pci1179,0623";
>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		device_type = "pci";
>> +		ranges;
>> +
>> +		vddc-supply = <&vdd_ntn_0p9>;
>> +		vdd18-supply = <&vdd_ntn_1p8>;
>> +		vdd09-supply = <&vdd_ntn_0p9>;
>> +		vddio1-supply = <&vdd_ntn_1p8>;
>> +		vddio2-supply = <&vdd_ntn_1p8>;
>> +		vddio18-supply = <&vdd_ntn_1p8>;
>> +
>> +		qcom,qps615-controller = <&qps615_switch>;
>> +
>> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>> +
>> +		pcie@1,0 {
>> +			reg = <0x20800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +		};
>> +
>> +		pcie@2,0 {
>> +			reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +		};
>> +
>> +		pcie@3,0 {
>> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			ranges;
>> +
>> +			pcie@0,0 {
>> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
>> +			};
>> +
>> +			pcie@0,1 {
>> +				reg = <0x50100 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>   &qupv3_id_0 {
>>   	status = "okay";
>>   };
>> @@ -812,6 +911,28 @@ lt9611_rst_pin: lt9611-rst-state {
>>   	};
>>   };
>>   
>> +&pm8350c_gpios {
>> +	ntn_0p9_en: ntn-0p9-en-state {
>> +		pins = "gpio2";
>> +		function = "normal";
>> +
>> +		bias-disable;
>> +		input-disable;
>> +		output-enable;
>> +		power-source = <0>;
>> +	};
>> +
>> +	ntn_1p8_en: ntn-1p8-en-state {
>> +		pins = "gpio3";
>> +		function = "normal";
>> +
>> +		bias-disable;
>> +		input-disable;
>> +		output-enable;
>> +		power-source = <0>;
>> +	};
>> +};
>> +
>>   &tlmm {
>>   	lt9611_irq_pin: lt9611-irq-state {
>>   		pins = "gpio24";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 3d8410683402..3840f056b7f2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2279,7 +2279,7 @@ pcie1: pcie@1c08000 {
>>   
>>   			status = "disabled";
>>   
>> -			pcie@0 {
>> +			pcieport: pcie@0 {
>>   				device_type = "pci";
>>   				reg = <0x0 0x0 0x0 0x0 0x0>;
>>   				bus-range = <0x01 0xff>;
>>
> 

