Return-Path: <linux-pci+bounces-24089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A0A68939
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A63AE761
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4772512E9;
	Wed, 19 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nc0uETH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029920551C;
	Wed, 19 Mar 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379397; cv=none; b=ZIk9TNY3P4ZFwp00iOXBrxOmXKrU0vvBulPmQtKcPduHeNbzwdHCQzRj4NmSYmWbOhqwtN+xv4ksVDOplsY71mUd7mAebtFN5zesLh9clQZMSoNeCylOqViRZ/eWx/+x62SmbsOxeNfY+bsumbRDekBWDWvZsosQ3Z2JZHun2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379397; c=relaxed/simple;
	bh=SEA/V2WESnwv3NkOclWHjBqJZn1kzmI5oE03F1xM+2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hmv7A3eEK5EUJ7W/uzVMAeCnug4tjB1TRLY5bxDZPCl9ARiJqw8UKmO6M79MYjhlBw28RjsH6WYg5aTAgNkuJu6WXD6Sx+auLCjrf8A/g2j/6J6qkPOWasMkBxS0V6IO/wOl+jckNTb7bFRE3EcVN2VM1pvvwONUibk6DvjuAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nc0uETH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4m0Lf019816;
	Wed, 19 Mar 2025 10:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nq8pDG5SRGKEdG2k+WiViB/TjEtQ78OLqvYgV5O5iEo=; b=nc0uETH0V1hCWaKG
	Xg0Syx6JhFaBKraL+BAj/DQBA4fxYNGoZCfx88R0ve1sKMNH/MURxVmzIligZXH8
	hmhPP/UoXZycDdBP/vnHi7s3zKkQ7CcEoA9z/+iWB008eb9qTMoWwlVVW321Trnv
	XXBVJFuinmcv9FXtjOiZBbADfVuPJ0p344qJbmrqJ1ENgmbFSsZVHSk7Lrv3jIou
	kOzkYYnPqi1HjKnuDfUjivRtxDLvzJutDFJFjt9QekOJo+BxAzOVW44x/vQdFIW5
	RFLWl9dfBCqk4AZcNpuLFw8w6VEM2AVGjmKOv30tuR3HYGX8k7HxlBx6LDfsG/tJ
	RsrZhg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1uu36x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:16:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52JAGBMw002837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:16:11 GMT
Received: from [10.216.37.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 03:16:03 -0700
Message-ID: <303194d4-d342-ea4c-0bb6-5f5d0297ba23@quicinc.com>
Date: Wed, 19 Mar 2025 15:46:00 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicnic.com>, <amitk@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <jorge.ramirez@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
 <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
 <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67da996c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=arMFPUd-6P6zm0bSz1oA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KV2koTMloLA6pRaNOAbT0W_FaxPQ0j5G
X-Proofpoint-ORIG-GUID: KV2koTMloLA6pRaNOAbT0W_FaxPQ0j5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190071



On 3/19/2025 3:43 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 09:14:22AM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
>>> On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
>>> <krishna.chundru@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> Add a node for the TC956x PCIe switch, which has three downstream ports.
>>>>>> Two embedded Ethernet devices are present on one of the downstream ports.
>>>>>>
>>>>>> Power to the TC956x is supplied through two LDO regulators, controlled by
>>>>>> two GPIOs, which are added as fixed regulators. Configure the TC956x
>>>>>> through I2C.
>>>>>>
>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>>>>>>     arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>>>>>     2 files changed, 117 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> @@ -735,6 +760,75 @@ &pcie1_phy {
>>>>>>        status = "okay";
>>>>>>     };
>>>>>>
>>>>>> +&pcie1_port {
>>>>>> +    pcie@0,0 {
>>>>>> +            compatible = "pci1179,0623", "pciclass,0604";
>>>>>> +            reg = <0x10000 0x0 0x0 0x0 0x0>;
>>>>>> +            #address-cells = <3>;
>>>>>> +            #size-cells = <2>;
>>>>>> +
>>>>>> +            device_type = "pci";
>>>>>> +            ranges;
>>>>>> +            bus-range = <0x2 0xff>;
>>>>>> +
>>>>>> +            vddc-supply = <&vdd_ntn_0p9>;
>>>>>> +            vdd18-supply = <&vdd_ntn_1p8>;
>>>>>> +            vdd09-supply = <&vdd_ntn_0p9>;
>>>>>> +            vddio1-supply = <&vdd_ntn_1p8>;
>>>>>> +            vddio2-supply = <&vdd_ntn_1p8>;
>>>>>> +            vddio18-supply = <&vdd_ntn_1p8>;
>>>>>> +
>>>>>> +            i2c-parent = <&i2c0 0x77>;
>>>>>> +
>>>>>> +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>>>>>> +
>>>>>
>>>>> I think I've responded here, but I'm not sure where the message went:
>>>>> please add pinctrl entry for this pin.
>>>>>
>>>> Do we need to also add pinctrl property for this node and refer the
>>>> pinctrl entry for this pin?
>>>
>>> I think that is what I've asked for, was that not?
>> Currently there is no pincntrl property defined for this.
> 
> Does it need to be defined separately / specially?
> 
yes we need to define this property now.

- Krishna Chaitanya.

