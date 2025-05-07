Return-Path: <linux-pci+bounces-27365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE77AADC35
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B9198038A
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05B211276;
	Wed,  7 May 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OWy+lrgc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6C20D50B;
	Wed,  7 May 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612483; cv=none; b=CPwGOLAQK0srno/YxfN1oUWIkYkWAI8Z8luwJhYvJuluB1uoV11xM7vpv+i5qUeiyuz+pkFh+P2D89l3s40KAXOlFwXKQq+SoENVHGJoRqIyiaosbBEC+iAwXZ26qEoUGfOronGVtKrLJIBhviN/GiVw6SP+u3IcH6V/YY6xXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612483; c=relaxed/simple;
	bh=GgBHq/ss9JLltp+XQwctnZoMcmQN2He3KQqAB5MlVdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fOIMW4KjpwAdiXOGY11FCQTOZoyS96eYS5jHitcabsLz4gi0oUk7Ut1wHE2TthwQPke05zbCF+9AMJ54JfpeZ+N48Ohaih6XGJY7w1ahAv8fD4cZxV8TB5sPJi00Dlf0rdaIUGqrcDl2R/qZdXJibN+qzvk8gPWU+92XbpsFGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OWy+lrgc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471H9ck018448;
	Wed, 7 May 2025 10:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0TBYJUUEibduVEkuEGGQEVeC5/+ntP3Yk2DalRvAxg=; b=OWy+lrgcWvQ/Xgrg
	DiAp7Nnfae+MbOOY+9wgwsxGSmq9uEwEJSB6nbXRz8vIipXAmZ4s/hUvvIzDP5KQ
	g9WshjxmUkzSy5TTpscepP8wTued4vjB6+n8kt28ytEFXzoCK21JKDwp7P9j2W7I
	UoRDonKfViIW0aR4FHjddKq3zjMbHlNthmN0zjQoDlk2lTq9ZdYtE8VIrm7zkjEA
	nNcMVjJWuvJLPmGjRnUfhTFCCqOCsqPx7QqfjxHFgJmzk1Er9nGXqm8a99d4Cx5C
	dbcx+5aF+pHKhcBF/Dv6cykwjLlU9THswMp5kzzswqK/gp2tFo3y/igP71GkqJef
	thnVxQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5tbd9t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 10:07:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547A7pS1029357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 10:07:51 GMT
Received: from [10.239.29.178] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 May 2025
 03:07:44 -0700
Message-ID: <71bca969-3423-46b8-ad69-838fa70b70fc@quicinc.com>
Date: Wed, 7 May 2025 18:07:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: qcom,pcie-sa8775p: document
 qcs8300
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ziyue Zhang
	<quic_ziyuzhan@quicinc.com>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <neil.armstrong@linaro.org>,
        <abel.vesa@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>
References: <20250507031019.4080541-1-quic_ziyuzhan@quicinc.com>
 <20250507031019.4080541-3-quic_ziyuzhan@quicinc.com>
 <20250507-quixotic-handsome-wallaby-4560e3@kuoka>
 <8fef4573-0527-44d8-a481-f3271d9ffa33@quicinc.com>
 <01b06e36-823c-4f28-8db5-dc0ee0b4c063@kernel.org>
 <c91c5357-464b-4ecc-96a5-c617048f73e5@quicinc.com>
 <574a67b7-bd57-4cf4-9ecb-cdcefafeb791@kernel.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <574a67b7-bd57-4cf4-9ecb-cdcefafeb791@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wOXB-O8ZB2DkLSBVJNot-gdVrGaNWVLX
X-Proofpoint-GUID: wOXB-O8ZB2DkLSBVJNot-gdVrGaNWVLX
X-Authority-Analysis: v=2.4 cv=doXbC0g4 c=1 sm=1 tr=0 ts=681b30f9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=Lwqc8tY7GNGPzp1I7RAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA5MyBTYWx0ZWRfXwKzCKDKlaI01
 hQk7ccUK4pGHYTV/pZdQ2FSLTCWmjoiddQ7D9EIb0Gkays3rf8Z+XwznWzc3abr0Mxu7UOoN6pA
 HyHyIa0rFJL4xsX5kTo2MbWvBKh4WacdMXQL5UKCYECjxfVrbjrc47rGdZTX6wfUUYSiAUaMpTr
 DKmL4CkBqVS+QG2k37nw920kaBk4SVhWB962AcAoVwr77NHt8aZshw8WgvhN90hOv9cQ3U6f6hf
 x6h5tKrWgJaMI9Hmv53a5f8wShEJlSLLmnm4SAaeEJIp0E3Ie8+BaYkfL4A59xztq4atEnFwCEy
 6rT+n15yMdm9vuUxEoBigTaAsme9Rf3KuWKLCy8vZc0u2UNq53QRnoCG+H8AAdaz+LJKDI/iQxt
 LbX3BrWxH/DEuPQLjrM55c5XY62uqFFViUNVt0rmBRGRYDL23K0lNDLZYbdB3GE8ungiD7/6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=978 impostorscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070093


On 5/7/2025 6:03 PM, Krzysztof Kozlowski wrote:
> On 07/05/2025 11:56, Qiang Yu wrote:
>> On 5/7/2025 4:25 PM, Krzysztof Kozlowski wrote:
>>> On 07/05/2025 10:19, Ziyue Zhang wrote:
>>>> On 5/7/2025 1:10 PM, Krzysztof Kozlowski wrote:
>>>>> On Wed, May 07, 2025 at 11:10:15AM GMT, Ziyue Zhang wrote:
>>>>>> Add compatible for qcs8300 platform, with sa8775p as the fallback.
>>>>>>
>>>>>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>>>>>> ---
>>>>>>     .../bindings/pci/qcom,pcie-sa8775p.yaml       | 26 ++++++++++++++-----
>>>>>>     1 file changed, 19 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>>>> index efde49d1bef8..154bb60be402 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>>>> @@ -16,7 +16,12 @@ description:
>>>>>>     
>>>>>>     properties:
>>>>>>       compatible:
>>>>>> -    const: qcom,pcie-sa8775p
>>>>>> +    oneOf:
>>>>>> +      - const: qcom,pcie-sa8775p
>>>>>> +      - items:
>>>>>> +          - enum:
>>>>>> +              - qcom,pcie-qcs8300
>>>>>> +          - const: qcom,pcie-sa8775p
>>>>>>     
>>>>>>       reg:
>>>>>>         minItems: 6
>>>>>> @@ -45,7 +50,7 @@ properties:
>>>>>>     
>>>>>>       interrupts:
>>>>>>         minItems: 8
>>>>>> -    maxItems: 8
>>>>>> +    maxItems: 9
>>>>> I don't understand why this is flexible for sa8775p. I assume this
>>>>> wasn't tested or finished, just like your previous patch suggested.
>>>>>
>>>>> Please send complete bindings once you finish them or explain what
>>>>> exactly changed in the meantime.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>> Hi Krzysztof
>>>> Global interrupt is optional in the PCIe driver. It is not present in
>>>> the SA8775p PCIe device tree node, but it is required for the QCS8300
>>> And hardware?
>> The PCIe controller on the SA8775p is also capable of generating a global
>> interrupt.
>>>> I did the DTBs and yaml checks before pushing this patch. This is how
>>>> I became aware that `maxItem` needed to be changed to 9.
>>> If it is required for QCS8300, then you are supposed to make it required
>>> in the binding for this device. Look at other bindings.
>> The global interrupt is not mandatory. The PCIe driver can still function
>> without this interrupt, but it will offer a better user experience when
>> the device is plugged in or removed. On other platforms, the global
>> interrupt is also optional, and `minItems` and `maxItems` are set to 8 and
>> 9 respectively. Please refer to `qcom,pcie - sm8550.yaml`,
>> `qcom,pcie - sm8450.yaml`, and `qcom,pcie - x1e80100.yaml`.
> I don't know what does it prove. You cannot add requirement of global
> interrupt to existing devices because it would be an ABI break.
IIUC, this will not break ABI because pcie_qcom.c parses this irq using
"irq = platform_get_irq_byname_optional(pdev, "global");"
>
> Best regards,
> Krzysztof

-- 
With best wishes
Qiang Yu


