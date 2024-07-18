Return-Path: <linux-pci+bounces-10489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4932934834
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 08:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652CD2819F4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 06:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94E5FB8A;
	Thu, 18 Jul 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mf/SNGZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFB2AD29;
	Thu, 18 Jul 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284847; cv=none; b=IOiMmXf9DeuuTWnK74RSmeAKwASsBooIoCIcvEsLBz4FJKN1XG7oVJ1Qa7+7vLcIl6EHb21p2xGV0nyqMkmD/sHRwaIgzabZYRATXpB14MGVWlD6ESCs+mKFRjaiDZG28HGB0xDl7E7/oQw0pBKDbsh2jW6aQi6UaOirJ1hg+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284847; c=relaxed/simple;
	bh=HTA+V233FqmMRP9qHx6p+O71mTJRn1KqUMOrWnvAHNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OQLRlzJJF3DXfkRrnpfsxlmaMOzX36pIgP5lGDxxungbiQ2SxbeO2qqhRFFEk9rW4w4TGo3GQihzwQEF+AdoOH1LkU3es1ZvLNUQGU6njagaMRFuotBaX5pwxlE9Rhwmuc6snaHilLh5RHrQFpfmT2fxfs9Df1nzJDYTpoc5meA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mf/SNGZp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I1mLPX022963;
	Thu, 18 Jul 2024 06:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNZWhN5zHiWOEsLPu/XMpOuw4cfKJsnELGFX9qL0oUQ=; b=Mf/SNGZpSKik5zxA
	CNbqVtrFym7K2LFu150xbjAXs41cOyldxtzChYa2vQXJPiC8aPbUx+fCf3How/Ea
	vRh7KTdxVXY8ocKrLt57Bcl1eFO6QCpCgQHnzG2lxQOrlvcEZmaFDiyOwzrxFxFn
	c6MpixMCvxvc71ipwEJBCUyZYbVNH4UX664en8NjzEKxJkEQ5NqaMYAxBRIwL11Q
	wkiqbdW7nao6xfmmsiXj84QwUqLaV8qbHoqPNGeLxk37xtjeimpieUaRC3moVHYr
	88MbWYA0ILC5oeSFIf4SikpqVaPs98epvLWqI5wydAjkZpq6EU3rB2CgbVS1cGyC
	4qHQ5g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfnmnat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:40:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I6eH5Z026673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:40:17 GMT
Received: from [10.151.37.100] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 23:40:12 -0700
Message-ID: <840ba412-f4f9-494d-aee1-96d1e2b67e3f@quicinc.com>
Date: Thu, 18 Jul 2024 12:10:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/4] arm64: dts: qcom: ipq9574: Enable PCIe PHYs and
 controllers
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: devi priya <quic_devipriy@quicinc.com>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
 <20240716092347.2177153-4-quic_srichara@quicinc.com>
 <14f9f29c-2762-462f-b733-cde6a103b509@linaro.org>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <14f9f29c-2762-462f-b733-cde6a103b509@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ldrMSLeYFKTmVgBePhWv4T_iqA5bgK14
X-Proofpoint-ORIG-GUID: ldrMSLeYFKTmVgBePhWv4T_iqA5bgK14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_03,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=980 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180044



On 7/16/2024 5:33 PM, Konrad Dybcio wrote:
> On 16.07.2024 11:23 AM, Sricharan R wrote:
>> From: devi priya <quic_devipriy@quicinc.com>
>>
>> Enable the PCIe controller and PHY nodes corresponding to RDP 433.
>>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [V6] No change.
>>
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 113 ++++++++++++++++++++
>>   1 file changed, 113 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 1bb8d96c9a82..f4b6d540612c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -8,6 +8,7 @@
>>   
>>   /dts-v1/;
>>   
>> +#include <dt-bindings/gpio/gpio.h>
>>   #include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>> @@ -15,6 +16,45 @@ / {
>>   	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>>   };
>>   
>> +&pcie1_phy {
>> +	status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie1_default>;
> property-n
> property-names
ok, will fix

Regards,
  Sricharan

