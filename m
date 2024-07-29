Return-Path: <linux-pci+bounces-10939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB593F220
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2BB1C21805
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30913FD84;
	Mon, 29 Jul 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f/VS3k0t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3178C63;
	Mon, 29 Jul 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247550; cv=none; b=ikXSTOzA0AL5Q576nXtDPAQ5mRWKeZhFh3NqHVSX9jll/39o4EImg2SVY23T6wSYB9CDUwiunLy7GbdzZcTGCjQW+fWfdnt9qY+1CDr0xZp3CTbUXhmE+wYYnGWQIKiN76fhPgqxv1O1+0z5divK02F0iHtb9j7H7SqtL7O7LIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247550; c=relaxed/simple;
	bh=xIeZBUpl39w0mdwFaFKnUTNT2nvFlYH4/evUDN5JWts=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=NdPX1R6pF1vIoyesKVu6smlIhJHJfm3wNeTyi5Qf1q63u4qHd6NXBiVwo3Y4MlAWeBXBHb1p+UkRnpLTCf6h9aLZu7Z+wv7/wTRjyJecgMbCv5uXivSCXaxWnwQ2R5844z4ybdD2Z2eGiTJ49rmJZbXiVo691uRaC7AH0OO0Rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f/VS3k0t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T0KsPh017395;
	Mon, 29 Jul 2024 10:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p7UAYzgu4NibKu/H6Nikv09jqAQ8X7Qc1Y9YTucpRpM=; b=f/VS3k0t0ZWPXlHk
	iWd+TBM/VWUh41xw69T6Ncz0PGiwuAisPEN8J5nubnhFuyiXqUC5QirNSZ4Y05l7
	hX/DwVJWaVJGLHxMi5zaXm75UXDoGl1vv7rdQ+knCkEdDX5WCTpCU6dSgalxhRc7
	iJMtPWURLFC6VUqyV0W8ImaqzhdZigPjitskNamPntpYw9wVfFftFhOJsXex6/Oq
	z1MJQxG7tonHEPr3wmqL522F7d0R/eU60/vMtzirCq5m+zpyvq6YhjAZdx2VGpuQ
	PbEdsOashPSC8+DNjUP/eFu2urRp9pQTl0t3C+uDP46Z+gdLSbvuei13p2NvPD/F
	McdPNw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40msne3pdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:05:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TA5fYo019593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:05:41 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:05:36 -0700
Message-ID: <2531cc78-6091-497c-bb36-a8a98ebcd39d@quicinc.com>
Date: Mon, 29 Jul 2024 18:05:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: Document compatible for QCS9100
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240709162912.GA176161@bhelgaas>
 <e429e0d5-ed88-44c7-aa76-62abd593a3d1@quicinc.com>
In-Reply-To: <e429e0d5-ed88-44c7-aa76-62abd593a3d1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u0sIKSz166X3jc2PufD44Lt5xx5OcYHD
X-Proofpoint-ORIG-GUID: u0sIKSz166X3jc2PufD44Lt5xx5OcYHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290068



On 7/10/2024 2:37 PM, Tengfei Fan wrote:
> 
> 
> On 7/10/2024 12:29 AM, Bjorn Helgaas wrote:
>> On Tue, Jul 09, 2024 at 10:59:29PM +0800, Tengfei Fan wrote:
>>> Document compatible for QCS9100 platform.
>>
>> Add blank line for paragraph breaks.
> 
> A blank line will be added in the next verion patch series.
> 
>>
>>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>>> platform use non-SCMI resource. In the future, the SA8775p platform will
>>> move to use SCMI resources and it will have new sa8775p-related device
>>> tree. Consequently, introduce "qcom,pcie-qcs9100" to describe non-SCMI
>>> based PCIe.
>>
>> Not connected to the patch below.  Move to where it is relevant.
> 
> As mentioned in the cover letter, we will also push the QCS9100 device 
> tree patch series to upstream after all the binding and driver patches 
> are reviewd. The QCS9100 device tree is directly renamed from the 
> SA8775p device tree.
> 
> This comment message serves to explain why we need to push this PCIe 
> binding patch, thus avoiding any questions from reviews about why we are 
> not continuing to use the "qcom,pcie-sa8775p" compatible name.
> 
> If you still think that this comment message is not necessay here, I 
> will move this comment message from binding and driver patches to the 
> cover letter.

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore all the current patches here.
Thank you for your input.

> 
>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml 
>>> b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>> index efde49d1bef8..4de33df6963f 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>> @@ -16,7 +16,10 @@ description:
>>>   properties:
>>>     compatible:
>>> -    const: qcom,pcie-sa8775p
>>> +    items:
>>> +      - enum:
>>> +          - qcom,pcie-qcs9100
>>> +          - qcom,pcie-sa8775p
>>>     reg:
>>>       minItems: 6
>>>
>>> -- 
>>> 2.25.1
>>>
> 

-- 
Thx and BRs,
Tengfei Fan

