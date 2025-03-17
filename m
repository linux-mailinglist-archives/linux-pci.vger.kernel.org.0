Return-Path: <linux-pci+bounces-23910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C755A64793
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984751889E59
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB732222B2;
	Mon, 17 Mar 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RL+/zQP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84376222562;
	Mon, 17 Mar 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204151; cv=none; b=jxEmPaQ+HPC5z04zQ0DFPlebqoBqFxPGpWTHOY9MhLj+U/hNyU/7B8OdaOJk0Y5mnA9uu2yVYiPVJNY/3FeCQdsLMIasvj0C1dvZguep+3vUKTm3ltgOdEKwK+6aQ0NYYjkDTLVifIfUzvIsBqZM5R9gm7KFrqqZBV3Cw3/tC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204151; c=relaxed/simple;
	bh=ydKbUy0g0dQk5Pf63CXpSEv9U9PhXU/f5x0kUsp/Q/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ODWUl/xy2YKN3fZTQi5ibmk96KebvOhxXFpvLYnsiZr7dVM+v9Ja7c2hDl11aqvND0SJbYGTkSqJIJ6p8sbAcyp2RCQkH4jMCjk4yYxzaQeCs/J9CojwOp/xEQXCM5FSs2xzB4DL2X6JwLaI0FlXSEiE+ErJ224N1V0MaZqcv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RL+/zQP+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMWBiO023396;
	Mon, 17 Mar 2025 09:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qF2h5i7vKFz1+33BAtMihVx4WQ+5fW9K69V9+MemX1U=; b=RL+/zQP+0j2dklnt
	JqUWFkNg8KWRvCdSJ3T4Yq2Lf/Au5ltK5qnx/S/ZcmlQcvsUV8scogWCJD+G9GG7
	Wk+9WGYJJXeL2rz0dUmQH/ZzyeySRtog4lYzKDLSjgHEHoRO+v2bisGCIDidtKKM
	q7h9lCCorh8U8KI5kQaPmTPCpS7KUgvDgSjxkHJFwNuGJULXII1OkCVPGrFASBEX
	Uvm2Z7EV/Z1qV/jy2m3sSgcgtGmzRp8rI5DZldS1dmdoDeaWB8UkiY4j6lYEaoAE
	9ZnUfqTZK0PMmAqJN9m0btIpp/pdjRdv5Z+8h0BU8HbyG6SDCYoY3s0sKmTqH5xw
	zuyKfg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2ahc4x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 09:35:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52H9ZRS8031973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 09:35:27 GMT
Received: from [10.216.37.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Mar
 2025 02:35:21 -0700
Message-ID: <6e51e35f-78c3-5d2b-697e-ce4a7da7b15c@quicinc.com>
Date: Mon, 17 Mar 2025 15:05:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicnic.com>, <amitk@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <jorge.ramirez@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <ciqgmfi4wkvqpvaf4zsqn3k2nrllsaglbx7ve3g2nbecoj35d6@okgcsvfx27z5>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <ciqgmfi4wkvqpvaf4zsqn3k2nrllsaglbx7ve3g2nbecoj35d6@okgcsvfx27z5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ronk3wIUBrbfgaMtVsHQGd7xfCAacnwz
X-Proofpoint-GUID: Ronk3wIUBrbfgaMtVsHQGd7xfCAacnwz
X-Authority-Analysis: v=2.4 cv=R7kDGcRX c=1 sm=1 tr=0 ts=67d7ece0 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=bI46KiJKG97eG1GfczgA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170070



On 2/25/2025 5:19 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
>> Add a node for the TC956x PCIe switch, which has three downstream ports.
>> Two embedded Ethernet devices are present on one of the downstream ports.
>>
>> Power to the TC956x is supplied through two LDO regulators, controlled by
>> two GPIOs, which are added as fixed regulators. Configure the TC956x
>> through I2C.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>   2 files changed, 117 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 7a36c90ad4ec..13dbb24a3179 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -218,6 +218,31 @@ vph_pwr: vph-pwr-regulator {
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
>> +
>>   };
>>   
>>   &apps_rsc {
>> @@ -735,6 +760,75 @@ &pcie1_phy {
>>   	status = "okay";
>>   };
>>   
>> +&pcie1_port {
>> +	pcie@0,0 {
>> +		compatible = "pci1179,0623", "pciclass,0604";
>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		device_type = "pci";
>> +		ranges;
>> +		bus-range = <0x2 0xff>;
>> +
>> +		vddc-supply = <&vdd_ntn_0p9>;
>> +		vdd18-supply = <&vdd_ntn_1p8>;
>> +		vdd09-supply = <&vdd_ntn_0p9>;
>> +		vddio1-supply = <&vdd_ntn_1p8>;
>> +		vddio2-supply = <&vdd_ntn_1p8>;
>> +		vddio18-supply = <&vdd_ntn_1p8>;
>> +
>> +		i2c-parent = <&i2c0 0x77>;
>> +
>> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>> +
>> +		pcie@1,0 {
> 
> PCIe bus can be autodetected. Is there a reason for describing all the
> ports and a full topology? If so, it should be stated in the commit
> message.
> 
As these ports are fixed we are defining them here, I will mention this
in the commit message. It is similar to how we added pcieport for all
the platforms, I tried to add full topology here. And if we want to
configure any ports like l0s entry delay, l1 entry delay etc in future
we need these full topology to be present.

- Krishna Chaitanya.
>> +			reg = <0x20800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x3 0xff>;
>> +		};
>> +
>> +		pcie@2,0 {
>> +			reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x4 0xff>;
>> +		};
>> +
>> +		pcie@3,0 {
> 

