Return-Path: <linux-pci+bounces-10942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B63093F23E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AA91C219F2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51BD1419B5;
	Mon, 29 Jul 2024 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HNyTCjbl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FC84A50;
	Mon, 29 Jul 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247732; cv=none; b=PsX6SYGyJv+QucSe2AsjQulmg8i56N1kCSS7XySL4mhBKe95wCQDfYHaT7RU+ukZH9TT+dIKPeiuhD4OyS3lCEq5uYnoPJQZRQ9bF3b2mqEO//vjEztKcAAASohJ2H673kur1mAU3a1vDpjD3iOLPlUQsX5nE59i2WzNXKVWpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247732; c=relaxed/simple;
	bh=GJsDlRB/jKTHshokLKRbjfvkzMzXx4CtXjcvEVOz60w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QB0DnL1TXt/4+txLunTXacy/NEAi96S7A9m8gx3Syy5B5XD3aXlcwSt0ULpJYDtKECMhDitkSvgZJvbHRox7SC8RffTRt77Ku/FaH+tmzDWZY6TfxVa0bToGx8myv3M4AhfmHfebcsWxmwPOiqJYK+mNivo0KBsMq9c8juW5Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HNyTCjbl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SNbnJQ019162;
	Mon, 29 Jul 2024 10:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wmcPhemX7bB+Wag+qxO+5wdgzNP0SWQcrKJPRIYlqvE=; b=HNyTCjblMkS0GGfY
	mNEy7hq24Zvv84/Z7jJow9owbI0FRR8F0p/dIM0Q1Ztn7VB21xvdGIbbc+ZXP7fL
	onj19yNqlkxxYQdDRhPeGB06EuHAkB+svwKwsQBcrCHrMb3LH8bGkfQC7i83CKVt
	RnJfcCHEU/x9KCtH3gVBI+fWfYnQq47XL0jXgL8xSgfaknlBQBt4ypmgh8j3JMkO
	FYuJsuNSMBIHwaW5ifVDU4QHyjVN9MX7DQZO0vfOzrydrMsW2XoU2xZe7bkyWEh/
	qdPAqvsiV4pH/QiMJc4TRpeHnD1K+Dsd2BDXDyaLMltdvWXII4O2tLaOgRqd/8g2
	jqrxKg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqurksq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:08:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TA8jFG028380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:08:45 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:08:39 -0700
Message-ID: <38503bfb-1b85-49a3-8b87-72318261b5e7@quicinc.com>
Date: Mon, 29 Jul 2024 18:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom-ep: Add support for QCS9100
 SoC
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Bjorn Helgaas
	<helgaas@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <kernel@quicinc.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709162831.GA176079@bhelgaas>
 <8caad754-0fa2-4158-86cd-b04101618638@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <8caad754-0fa2-4158-86cd-b04101618638@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RuRWUWje-WVKZuWw1ovU-c0geI5Cv1Bb
X-Proofpoint-ORIG-GUID: RuRWUWje-WVKZuWw1ovU-c0geI5Cv1Bb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290068



On 7/10/2024 6:31 PM, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/10/2024 12:28 AM, Bjorn Helgaas wrote:
>> On Tue, Jul 09, 2024 at 10:53:43PM +0800, Tengfei Fan wrote:
>>> Add devicetree bindings support for QCS9100 SoC. It has DMA register
>>> space and dma interrupt to support HDMA.
>>
>> s/dma/DMA/ above for consistency.
>>
>> Add blank line here if this is a paragraph break.
>>
>>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>>> platform use non-SCMI resource. In the future, the SA8775p platform will
>>> move to use SCMI resources and it will have new sa8775p-related device
>>> tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to describe non-SCMI
>>> based PCIe.
>>
>> s/drived/derived/
>>
>> This patch doesn't add anything related to SCMI, so this paragraph
>> seems like a distraction.
> 
> The paragraph can be removed from the commit message in next patchsets.
> Let me know if others looks good to you or not.
>>
>> The first paragraph seems a bit of a distraction too, since the patch
>> doesn't say anything about DMA register space or interrupt.
> 
> agree. Suggest to remove the first paragraph as well.

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore all the current patches here.
Thank you for your input.

>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>> index 46802f7d9482..8012663e7efc 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>> @@ -13,6 +13,7 @@ properties:
>>>     compatible:
>>>       oneOf:
>>>         - enum:
>>> +          - qcom,qcs9100-pcie-ep
>>>             - qcom,sa8775p-pcie-ep
>>>             - qcom,sdx55-pcie-ep
>>>             - qcom,sm8450-pcie-ep
>>> @@ -203,6 +204,7 @@ allOf:
>>>           compatible:
>>>             contains:
>>>               enum:
>>> +              - qcom,qcs9100-pcie-ep
>>>                 - qcom,sa8775p-pcie-ep
>>>       then:
>>>         properties:
>>>
>>> -- 
>>> 2.25.1
>>>
> 

-- 
Thx and BRs,
Tengfei Fan

