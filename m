Return-Path: <linux-pci+bounces-21454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C113A35E93
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 14:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B80A16E747
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F0263F2E;
	Fri, 14 Feb 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPQlIjKa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978C23A992
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538666; cv=none; b=qMYhF82oHbUTrjNcjCnARZsSmqYPOJSqo72yVYJGzLjQH9WWWntLU3LULBR4BhTFl9b0OA5wk8ebuMbRFqywUUQe4JA7I/On6Rvw5zcB5npJsWKSx4cY/8/IRLUb4Tth0g4cqqjSnZIlilmPxRrJJmrFjr8Mjriso5gTRFwQ1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538666; c=relaxed/simple;
	bh=6qmhCZ/VNbfXLMvjVMotO5S9MhLkOwAbj5PUvPSdtkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzoXqzGiGoVdU6M2dR2y33xgDuY0yrEHoVackZExZ5meiyLNgaL77nLbxlkf4W91BS1OPCX0+wW7Axw0yKvmn13O7lgRVMkii7wYclFlT4tthR4W5LnTSPKHxFnFVtq6o54ThJvDiqK3cgOh5kz1wmS32vr+pe0MTkf2KnTBnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPQlIjKa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBgqQR018132
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fTW/+eSXYK27SAIhtTq5ZN9ZI4lOMHVi64iiQFK1Qbo=; b=nPQlIjKaTrY/dTcy
	pxyj8+wG9yovtgNaXTA3gf1gCSlfA4RPjaMf4NNsWNdLFZa1KLRZuvMueopIk/aE
	LfO5NNoatF3tkqZq5IC1ny8axu+jW7Xv+09J23MqRvP7nDQK9BzxXGA5GUQK5Rkx
	WMDIJhzO9xItTp+D9qABBPKuvavlwUH4ELighfUmzLsNphcXZHR/CWcpBwqIidxV
	ub3I1aM+ce9HvBP0LkalZXIYZwsW6b1MJrssGhVo5tmdpKFWiUOQnWAqugtvdxms
	9BviAUmUs9u8oaWexzcZxmaO8hUrZhJiM5vQvclYxH53Yl1hjWSb96B32esM3u7s
	y80cKA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44t56vg6m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 13:11:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e456cecdddso3145006d6.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 05:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538661; x=1740143461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTW/+eSXYK27SAIhtTq5ZN9ZI4lOMHVi64iiQFK1Qbo=;
        b=CNqnqJn0z4lvPQlM6n3ioPuG6mY3icC/7fJbTWRjBH6taDs3WJgrwA3mLJ2KIQdzfD
         yEvms2TUxrpzWGte9Zv8MQU52hDo+3Hm8aYkEhKcOYGdj50K6ONgiyFSslhIyxo5yXJG
         AzmkyDY0VUcIWfPWwISmqYO4/SA2hs7jSukHoc0if75f/8ITfEdoiB5xKB6UqW+5crtK
         MPP6KxNUlCjNx1C0/M1BoKaIoUlV7wcCpVE19Ldnlb0hDPkhA308hwfn2fwM69Ikf4F3
         ztiXOP/Tag0tO8YejWDbNR7+PM8LjuoQUTr5f/aCySS2fMR99KEzwg+MVJKqfCKI7uYP
         oypw==
X-Forwarded-Encrypted: i=1; AJvYcCVbs2Yg8FKWfCtPBJvlmSFnGZZFcPKOavQuo6PH+6gQpzEyfK1cHHdgKIxn0TqEKeoGzjQPH5YFxjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdadKaBUMJWqL3Hxfw5Lg3Ftd2A0qizrEj/0E4Az6Ys+Z+ooP
	8cro61xGL+v5xh6wAulVTJ8rUUX2UAtLSAst7WR+QWtw038dAcJTBNyBOWUNPAtq7TeFCntMFj0
	uRRkFOb0NL6+1D0L3vz3N+0d1wv0lcF29c1OmSIIMYU42/ZhdxDTWcHF65Z8=
X-Gm-Gg: ASbGncuMS/2KYuzQ5lLEXfDdUv7ZEDPHSRB2V4JEG/FUWi4Mfw5OX4HVldpwEvKG21a
	haWVjtgM20I+G++HYyBHlB184hLxx5DQh6aXw9XnmISfiRlag1mcU3K2JFckoC/3sZOe/d5DDwE
	+JtT9fJuaNZ6SBkyh76z+jD1LeDizNOqlACYr28xbb50ppIsRqAIRwYHGt453gFIj8mM/mXAFMa
	+iSorNXDdwvosu+71oHtVqeA7ZLAwY4O6+Vddm03eZHEkfI5SIFpPinRCHtuhcsuco3NQ6lXtjW
	/NUOQpZVFJCWnd6Gi3JSStreQxJH1u/TtUIeXPcNwFGhtY9gwPGDQ6Ubt64=
X-Received: by 2002:a05:6214:301e:b0:6e6:5bd5:f3b5 with SMTP id 6a1803df08f44-6e66520e0d3mr14986756d6.8.1739538660873;
        Fri, 14 Feb 2025 05:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEij9NAIiSKVCTx7RPlhN8aNMMVTWNYr9ptSc3QOaFHm7mvQ0JMabORxG1HdQlMS7ugfZxdPQ==
X-Received: by 2002:a05:6214:301e:b0:6e6:5bd5:f3b5 with SMTP id 6a1803df08f44-6e66520e0d3mr14986596d6.8.1739538660507;
        Fri, 14 Feb 2025 05:11:00 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532832d1sm336935366b.81.2025.02.14.05.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 05:10:59 -0800 (PST)
Message-ID: <659ba3dd-0991-4660-9dd6-feda682f15e1@oss.qualcomm.com>
Date: Fri, 14 Feb 2025 14:10:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-1-cbd837d0028d@oss.qualcomm.com>
 <20250214084427.5ciy5ks6oypr3dvg@thinkpad>
 <be824a70-380e-84d0-8ada-f849b9453ac0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <be824a70-380e-84d0-8ada-f849b9453ac0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bnrMoH1Z0f9-bMxe0xWq4dJNBqmUcugx
X-Proofpoint-GUID: bnrMoH1Z0f9-bMxe0xWq4dJNBqmUcugx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140097

On 14.02.2025 9:48 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/14/2025 2:14 PM, Manivannan Sadhasivam wrote:
>> On Mon, Feb 10, 2025 at 01:00:00PM +0530, Krishna Chaitanya Chundru wrote:
>>> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
>>> rates used in lane equalization procedure.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> ---
>>> This patch depends on the this dt binding pull request which got recently
>>> merged: https://github.com/devicetree-org/dt-schema/pull/146
>>> ---
>>> ---
>>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> index 4936fa5b98ff..1b815d4eed5c 100644
>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> @@ -3209,6 +3209,11 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>>               phys = <&pcie3_phy>;
>>>               phy-names = "pciephy";
>>>   +            eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>,
>>> +                      /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
>>
>> Why 2 16bit arrays?
>>
> Just to keep line length below 100, if I use single line it is crossing
> 100 lines.

Oh I didn't notice this.. Ideally we would have <A0>, <A1>, ..., <An>;

But it seems like /bits/ applies individually to each entry? That's a bit
weird, but I'll add it to my list of things I don't like about dtc..

Let's do:
eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555
			     0x5555 0x5555 0x5555 0x5555>;

for now


Konrad

