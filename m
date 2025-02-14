Return-Path: <linux-pci+bounces-21434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2F9A35959
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096137A4209
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B880207E13;
	Fri, 14 Feb 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WieMddbH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E4275401;
	Fri, 14 Feb 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523034; cv=none; b=T80mcKscxwthnWcGt6xkDbxqGVYEf39/f9B1NtsHx9bXl6mNkJlZxUFt6568l8vaI65guaAXFrBoXGHiu6oROl9PvNNO+vAZQ3Tl7g5GPaKR75mpbGRuP3IWcidovdq38ovWjQdOgsfLmXtSSgm5p9fZkFTToH/AQUv3IunO3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523034; c=relaxed/simple;
	bh=3+AcZdnU8FdOjumClIF2GqlG4CDw+OX6zeEh4DONsJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=teqISBvNlbOd4gMjXmPpgUSM+sd5bmy9S4VMpefCAUzDbH+2CiV9fvmlM4jAeDAas6+mVmmuLP4WJtmM3eIsYAv26z0PPyelgt7vfGdenRuv2Kxt7DZS4MBUme5UkQRv+IDuOw/IO1RC6QzVsVeY4UW+VaQas+9FRAJ1UAKLa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WieMddbH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E6tEMR008247;
	Fri, 14 Feb 2025 08:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5UFHztiYBs5W6zR2fUSuxAZIpyicf7kYd3Jnr4/XuBE=; b=WieMddbHrkMECZ3h
	2pK86iWTna+RWPM4WWpSjYAYE0APL+bi9giHcOCe6ImnGpaMOMedvxHMm4GSr6ay
	g0ENvukalKw253cwkG29G4NR0PtM0deKCS3ZyDNlA/Ir8GPNe175r1W/ob9epu15
	JYPhk4nHnVaf3DlWPIZBbhiUgvz74/R3m8eoizfAJ0xKJeJld5fB57HBJBfDBzOU
	8Z1nfUk0osNguaQ0o918geDzRLPzNJVofjhwV1FZGSZi5FjEHGHIloiVhX6uBxX2
	xFJFQTwwebZZM0ngy/ANhsaqZJ8lCKP3VPCDV/Y4qCwXmW3zTXjDnOVNnR8UdDR2
	8i9nMg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewhdgqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:50:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51E8oIuJ031881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:50:18 GMT
Received: from [10.216.33.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Feb
 2025 00:50:12 -0800
Message-ID: <be824a70-380e-84d0-8ada-f849b9453ac0@quicinc.com>
Date: Fri, 14 Feb 2025 14:18:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Krishna
 Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <quic_mrana@quicinc.com>, <quic_vbadigan@quicinc.com>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
 <20250214084427.5ciy5ks6oypr3dvg@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20250214084427.5ciy5ks6oypr3dvg@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -VFvbxQa7YG4cDu-8xuobTdRL3HM24Vb
X-Proofpoint-GUID: -VFvbxQa7YG4cDu-8xuobTdRL3HM24Vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=958 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140063



On 2/14/2025 2:14 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 01:00:00PM +0530, Krishna Chaitanya Chundru wrote:
>> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
>> rates used in lane equalization procedure.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> This patch depends on the this dt binding pull request which got recently
>> merged: https://github.com/devicetree-org/dt-schema/pull/146
>> ---
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 4936fa5b98ff..1b815d4eed5c 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>   			phys = <&pcie3_phy>;
>>   			phy-names = "pciephy";
>>   
>> +			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>,
>> +					  /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
> 
> Why 2 16bit arrays?
> 
Just to keep line length below 100, if I use single line it is crossing
100 lines.

- Krishna Chaitanya.
> - Mani
> 

