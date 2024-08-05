Return-Path: <linux-pci+bounces-11259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648294743B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AEA1C20AFF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BA13DDB8;
	Mon,  5 Aug 2024 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="orxK/Ga4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26A2FB6;
	Mon,  5 Aug 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831132; cv=none; b=OHYsfF8fS7FoC+H7rNUUMEm58qDnPzrnOVRyTGD2X6GwrKPCRwL0XXVnNMCBm3MhpMNgCb4lAEyQ/WZtfxyxRniOhKDxRH1p8AgF2dO814az6ScFZ03cJKGjHSm+MEKjezLPrctZ3yhwkBwMt9haDQeUNrU4nHCIPGpDxjeGqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831132; c=relaxed/simple;
	bh=Khh0W4eBzFJDYu0CCh0V7lKfy7rf/8/OG5Jdhp00m7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rjLagKh2+6Iuo1uPQo2mciSWgNmycJV5llejOI8gX6NtyfxQz0JlYrLRAuYFpaUUQIQ/zwWOGRXDjHJra2dzoe9gudX5DS2Wvs6nqGz/8H9WsYRIZVIIvD/uuHbgLbUuA2xspcnXqnyEdevB8Y2nF1HL14rXFD5bNWnxrvBigSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=orxK/Ga4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VVov021359;
	Mon, 5 Aug 2024 04:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PmszSKOE4+wJWy9Rp/UZWW0loqV916AHfwAV1ntPRH4=; b=orxK/Ga4vo+nBDrS
	wn8r/ABex6ZFT31MLzQ59hdcduEZBrilA0Z8BDuC4u+8L2TaO91BoP3ko0eg4a/d
	u9bkLkUlTT+tmR5lY0QoPJaXoHLZ2LyqYlSiwpueiHDKuTnoBqXwjuSpcfJgsE31
	Gbec/K8fE+ihfNLU5RwYnYOkICv18U/E8sQfu4pR9yE9l1CXQL4F7av8OcCxSPej
	twsI19CVO/RYLJERrlC2GYLbrU4e4VtXv0IMiASmwgiu1kZ1K4SuIKllBeVXCvEn
	0b28xpXKOEP4ylTyG3wWHGJpqfVNvTf06Zz5G1q6giXzm7OI8Rz7VeNhhHt707Ym
	+MOPFw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scmtts60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:12:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754C0sG010872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:12:00 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:11:53 -0700
Message-ID: <f9fb8763-6c65-33fd-7174-a65a19c76a61@quicinc.com>
Date: Mon, 5 Aug 2024 09:41:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/8] dt-bindings: trivial-devices: Add qcom,qps615
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
 <20240803-qps615-v2-2-9560b7c71369@quicinc.com>
 <167ca34f-54b9-4a72-bcb7-8571cef918e8@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <167ca34f-54b9-4a72-bcb7-8571cef918e8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BBgTvv54OhUpaA1F8vM8esEkad1llWo4
X-Proofpoint-GUID: BBgTvv54OhUpaA1F8vM8esEkad1llWo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=927 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050028



On 8/4/2024 2:20 PM, Krzysztof Kozlowski wrote:
> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>> qps615 is a PCIe switch which is configured through i2c.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 5d3dc952770d..7f44add21bf6 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -330,6 +330,8 @@ properties:
>>             - renesas,isl29501
>>               # Rohm DH2228FV
>>             - rohm,dh2228fv
>> +            # Qualcomm QPS615 PCIe switch control
>> +          - qcom,qps615
> 
> Don't place entries in random order. The list is alohabetically ordered.
> 
> Best regards,
> Krzysztof
> 
Ack

- krishna Chaitanya.

