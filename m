Return-Path: <linux-pci+bounces-24067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27047A683E2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 04:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1280A3B05AD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 03:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984924E4C4;
	Wed, 19 Mar 2025 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VRV3TmjX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8A24E4B0;
	Wed, 19 Mar 2025 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355896; cv=none; b=lln6dk7lGdsb8sRvJRfLQNGiIpRfmSxjrFPzEjE7UHikAjqmEhSGfnxwnCwp7WumdT8M6l19Q9VCdEo/1Dh5fqB98Eorb4SdxI9akm5OPseUwSKL/VyyajMUavfK5v4tCHoxJfUcwNTL11xSCOeKK+ecKCh8cboP0eQqQ6cCdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355896; c=relaxed/simple;
	bh=oXAtuAdHFz5iZ9cx0ox31ViKYQo45NPqiMhhQCHFuJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WC1ZBt0XjGjF70LWFX73tfpWWCNw4xMT1E6wDJbO2UPDEjQ8HBLxdqqe1cfkVD6BNdICwyZeMIfBeIfHeQNpQ/Md/tkFljJXPro8XX8/5SbmHOcQykCXW/kbuqCFlOV+xpWfSznxOLtRJV+37jYxB5dlfpqlBo+cwoeh7x+kMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VRV3TmjX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIaeFZ028628;
	Wed, 19 Mar 2025 03:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4J85Py4sQOo5jqiP1Z7UR1KPRa6MkX//gOhRkfJNBIg=; b=VRV3TmjX9xamKLMr
	EnojEBKRDrE6EVar+ShtltQRR+XQHU5jqneT/91hGwIeuHerbtihBINmw0SnpfP6
	re2NoXYdNXR+x4zPhdvnAZFe2gRDULSWEl4fr+CddOrmHhfLE9N4AjIu58ci0l0A
	VyRrcJ2zudH1mADw75uXpU3SXa75diEuddVCmbbFM4hg2xMV+2t83GhQNb2gRL5X
	IkbhKuTw/hL4Ed9heBMW5JtBhkmSa3kpVWLiYUAvnF7Rtin9CXlnxwveEY/3+lp9
	qc2ItdvGX6Qtf9JKDRS5hNlzZeUIXzdYYMgdfaheYwDuOFPSvXUXaXCmJ1DLhrmI
	MoRLdA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtm20w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 03:44:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52J3iW1M022649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 03:44:32 GMT
Received: from [10.216.37.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Mar
 2025 20:44:26 -0700
Message-ID: <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
Date: Wed, 19 Mar 2025 09:14:22 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "Krishna Chaitanya
 Chundru" <krishna.chundru@oss.qualcomm.com>
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
        <dmitry.baryshkov@linaro.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <jorge.ramirez@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UT9JD-Wy3GimFusJAfxAfAfKPRhans7j
X-Proofpoint-ORIG-GUID: UT9JD-Wy3GimFusJAfxAfAfKPRhans7j
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67da3da1 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=9EbYfj_g6ekz_RnuEAcA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190023



On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
> On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Add a node for the TC956x PCIe switch, which has three downstream ports.
>>>> Two embedded Ethernet devices are present on one of the downstream ports.
>>>>
>>>> Power to the TC956x is supplied through two LDO regulators, controlled by
>>>> two GPIOs, which are added as fixed regulators. Configure the TC956x
>>>> through I2C.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>>>>    arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>>>>    2 files changed, 117 insertions(+), 1 deletion(-)
>>>>
>>>> @@ -735,6 +760,75 @@ &pcie1_phy {
>>>>       status = "okay";
>>>>    };
>>>>
>>>> +&pcie1_port {
>>>> +    pcie@0,0 {
>>>> +            compatible = "pci1179,0623", "pciclass,0604";
>>>> +            reg = <0x10000 0x0 0x0 0x0 0x0>;
>>>> +            #address-cells = <3>;
>>>> +            #size-cells = <2>;
>>>> +
>>>> +            device_type = "pci";
>>>> +            ranges;
>>>> +            bus-range = <0x2 0xff>;
>>>> +
>>>> +            vddc-supply = <&vdd_ntn_0p9>;
>>>> +            vdd18-supply = <&vdd_ntn_1p8>;
>>>> +            vdd09-supply = <&vdd_ntn_0p9>;
>>>> +            vddio1-supply = <&vdd_ntn_1p8>;
>>>> +            vddio2-supply = <&vdd_ntn_1p8>;
>>>> +            vddio18-supply = <&vdd_ntn_1p8>;
>>>> +
>>>> +            i2c-parent = <&i2c0 0x77>;
>>>> +
>>>> +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
>>>> +
>>>
>>> I think I've responded here, but I'm not sure where the message went:
>>> please add pinctrl entry for this pin.
>>>
>> Do we need to also add pinctrl property for this node and refer the
>> pinctrl entry for this pin?
> 
> I think that is what I've asked for, was that not?
Currently there is no pincntrl property defined for this.

- Krishna Chaitanya.
> 

