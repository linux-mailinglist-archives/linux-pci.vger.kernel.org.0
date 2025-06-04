Return-Path: <linux-pci+bounces-28954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 281D7ACDB94
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1481894AD5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987C28D8C3;
	Wed,  4 Jun 2025 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KQ3jDaEv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4F28C2CC;
	Wed,  4 Jun 2025 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031367; cv=none; b=qHBZqGnCrWIzo9Skd76rdXZwMtnW3KFJBc5q1yJjj5wUjNdUfEPzp/7pSdlT3pGNjdrQRRdcvUBFzHlgTgfpjITz4uaZUBN9RsFAwr5m8lmAmGLc49tqhcRGqNHj9TB2AC6+1BjHgKJoWae2+qBfjXDjXS2rhCm6VcxZWH5q7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031367; c=relaxed/simple;
	bh=hHfwX93Z1LNoyiAbTbrxQDAYuvLkrymMo+5mny2wZDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LeJCUTVe06PidsrYchuiCrCaiRIc3XbDeu3twpHYQlWtgZVWpANEAHpN6ciL6xjLfAeaePC9Bq8r6hSPHTsfgkbWP+X4+qw6Q4AAp0TZyX5tQoHeU81zUXFGd4ywAAMFto589z6KmebH2m6H8JfmGJYBjHScKaTmVX/UNSOhd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KQ3jDaEv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554875DU013521;
	Wed, 4 Jun 2025 10:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XMWU8a/DXCAez/wWFLWi1bCf9nSDlbvC+BavkR9SOYM=; b=KQ3jDaEvx5GGJ8o4
	m5n+AGbafDd5oOq98rJZgBZknQLd+eBkzYNJLIt8I7YuRe/IRyE+to8KoufHmDKp
	mzx3szcPwOkjKSy8tCQw641WLwcoBP4bP06bmek8LEpUv34/oqGl+6I70F/MsZjQ
	AdVfEQAUAtZAcBvVHUMZqtxr5+9lvRTwM9sL5ir3VnoEBke78OlAVMKS1CfWdllo
	rBEZRPHFHRJA5MECQatsw+0N0jn2cMvrtrcui96p5U63imNpsdvenDxRg0M7OwH3
	MmhDZDwUZNDrjtXoIPMtATRoxwqF31he6qowg6hJXPt77tepnHp8DqO0WqJwG8f4
	mI58IQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8nnmx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 10:02:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 554A2Wh6005912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 10:02:32 GMT
Received: from [10.239.31.134] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 03:02:27 -0700
Message-ID: <772f5e33-5040-4a68-84f4-25e048aa4432@quicinc.com>
Date: Wed, 4 Jun 2025 18:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ziyue Zhang
	<quic_ziyuzhan@quicinc.com>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>, <kw@linux.com>,
        <conor+dt@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
 <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
 <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
 <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M78myJrI6CB7Jy1T4BD-DqDvxKB0H3iT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3NSBTYWx0ZWRfX5qxemDmXAipZ
 ZahAIbqzRnKjfSdtDOq9GBm9FSXMjDmVOsVEqjI0FJsT/CgS4CZyo33r37vFQ4sojv5JaIO8aJD
 XIbVLAx/5mkc2FTZMWqRgeAjA0p5+a/zI2+jKSOEU+jFjxMQubv4GrwfoSpbXmx2AtduwrPs1eL
 xMTUM2aahi+KZ+tb8qvhqM/hfyOdmbL3qNvPOL/LsjwjfmbjVcKmrR2lC2gxv/60ROjQEnvXBcI
 fLMvbfg6YgHI+cMZlxcDN1vFv4XvLuNN3ox4HW6aPELt7iommu0ThBOwgGpBcNH7YvyzZ8CBj7W
 2tPwUbXlhkHoPCUrfrwhcqwqDKiUs/7OiXLL2co7KY3ZW8UCzIUm9q2D+y6xNRfBmtlsw0g6Lqh
 oPM2XNdFd25s/sfIBC+NquMVzeNMDi3yKeD3TszK8WUNguXEqdKZjuLSuSFfM/rdPjC4hq9T
X-Proofpoint-ORIG-GUID: M78myJrI6CB7Jy1T4BD-DqDvxKB0H3iT
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=684019b8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8
 a=COk6AnOGAAAA:8 a=gDmLj3BAQhsnJV4uteAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040075


On 6/4/2025 5:15 PM, Dmitry Baryshkov wrote:
> On Wed, Jun 04, 2025 at 03:58:33PM +0800, Ziyue Zhang wrote:
>> On 6/3/2025 9:11 PM, Dmitry Baryshkov wrote:
>>> On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
>>>> Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
>>>> document it.
>>> I don't think it's possible to "support" reset in hardware. Either it
>>> exists and is routed, or it is not.
>> Hi Dmitry,
>>
>> I will change the commit msg to
>> 'Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
>> document it.'
>> "Supports" implies that the PCIe controller has an active role in enabling
>> or managing the reset functionality—it suggests that the controller is designed
>> to accommodate or facilitate this feature.
>>  "Includes" simply states that the reset functionality is present in the
>> hardware—it exists, whether or not it's actively managed or configurable.
>> So I think change it to includes will be better.
>>
>> BRs
>> Ziyue
>>
>>>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>>>> ---
>>>>   .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>> index e3fa232da2ca..805258cbcf2f 100644
>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
>>>> @@ -61,11 +61,14 @@ properties:
>>>>         - const: global
>>>>     resets:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>> Shouldn't we just update this to maxItems:2 / minItems:2 and drop
>>> minItems:1 from the next clause?
>> Hi Dmitry,
>>
>> link_down reset is optional. In many other platforms, like sm8550
>> and x1e80100, link_down reset is documented as a optional reset.
>> PCIe will works fine without link_down reset. So I think setting it
>> as optional is better.
> You are describing a hardware. How can a reset be optional in the
> _hardware_? It's either routed or not.
>
> I feel a bit confused. According to the theory above, everything seems to
> be non-optional when describing hardware, such as registers, clocks,
> resets, regulators, and interrupts—all of them either exist or do not.
>
> Seems like I misunderstand the concept of 'optional'? Is 'optional' only
> used for compatibility across different platforms?
>
> Additionally, we have documented the PCIe global interrupt as optional. I
> was taught that, in the PCIe driver, this interrupt is retrieved using the
> platform_get_irq_byname_optional API, so it can be documented as optional.
> However, this still seems to contradict the theory mentioned earlier.
>> BRs
>> Ziyue
>>
>>>>     reset-names:
>>>> +    minItems: 1
>>>>       items:
>>>> -      - const: pci
>>>> +      - const: pci # PCIe core reset
>>>> +      - const: link_down # PCIe link down reset
>>>>   required:
>>>>     - interconnects
>>>> @@ -161,8 +164,10 @@ examples:
>>>>               power-domains = <&gcc PCIE_0_GDSC>;
>>>> -            resets = <&gcc GCC_PCIE_0_BCR>;
>>>> -            reset-names = "pci";
>>>> +            resets = <&gcc GCC_PCIE_0_BCR>,
>>>> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
>>>> +            reset-names = "pci",
>>>> +                          "link_down";
>>>>               perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>>>               wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>>>> -- 
>>>> linux-phy mailing list
>>>> linux-phy@lists.infradead.org
>>>> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Qiang Yu


