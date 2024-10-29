Return-Path: <linux-pci+bounces-15503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF189B41C6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 06:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1797F1F22C95
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 05:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD2200BBC;
	Tue, 29 Oct 2024 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OJqtFvdA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D218858E;
	Tue, 29 Oct 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730179051; cv=none; b=pG63tzXq/ylaSvX9zeIsA9lkFPk0o9e3QkqcqDoTuSw/8GukrccFDcoht6+0lVGobGcsxupZkSdgWHKOW+g3CEG+V20tFcuS5u5WoDxksMtxxQyRZYkcIqoPSRXjQl0Hg2nhrZlqkL9XlH/q4NxKp/Et5Sg4NaEkciTC1U+HL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730179051; c=relaxed/simple;
	bh=wYzqGG4Q4km+Ns90Q8Gc0gCM5Ljv8dlXhbxvfw/BdJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6fswdRnR0JeqjshW2BYqL6rJeyr8T9R91hp7v2OwRNqxOgF8eqN25UiCPkh6M7AfMRZg7wNsMDZofNCwmAP9m/zQcBD1Y/K1s9P+FqXC8IhZQ5jbvNAUTwcFEjYmvUluMf3kZNdqWE2FZ8MoR4kQitqU82P4obkNMVnXR8qqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OJqtFvdA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKlFmP004097;
	Tue, 29 Oct 2024 05:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0MyGFX8jJVi9uGPNcl3ITQ2goh4f1GsXNKt44nFiyqg=; b=OJqtFvdALEKElghO
	Kb3d2JIGsu3a+a2FzoYefeLqMLiOwpnjbdRkBStR7xXMRyMvTirV7fgBEIgN7MEa
	a+A1tnMcRaI9Qpai/0cZzcj3iZapGShhvvDbYfPAKmfbQ2PulaCi/y+yDqFk3euY
	94Who8OOCxyE4bs8v9kNc2mYiZzTzFOZDC4AzgmG9nEmV6TMklE5lmR596axoMq/
	xW/hVuWu1tdFu9FU7x7nlnEZV73e53HF4GOGfzFQBV2+0RSrS5qR/nEG1v2vfs/5
	rf5ZVMa2f7G/Zk+iesPnmYgPT9AzMmp5CpjFrUZ9hgJ17O+Y5S3Qgh/HzUpkBf5I
	aKodrA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gnsmqf9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 05:17:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49T5H80D012175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 05:17:08 GMT
Received: from [10.216.61.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 22:17:03 -0700
Message-ID: <36ec01f4-c0fb-188e-06e9-10c7360a8ef0@quicinc.com>
Date: Tue, 29 Oct 2024 10:47:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Content-Language: en-US
To: James Quinlan <james.quinlan@broadcom.com>, Rob Herring <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "moderated
 list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20241018182247.41130-1-james.quinlan@broadcom.com>
 <20241018182247.41130-2-james.quinlan@broadcom.com>
 <20241021190334.GA953710-robh@kernel.org>
 <77d3a1a9-c22d-0fd3-5942-91b9a3d74a43@quicinc.com>
 <954d6c11-ab4e-485f-8152-94bf38625f9c@broadcom.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <954d6c11-ab4e-485f-8152-94bf38625f9c@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jcJScyLt2nHXQq_s-udtJhOC43-wGizG
X-Proofpoint-GUID: jcJScyLt2nHXQq_s-udtJhOC43-wGizG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290040



On 10/29/2024 12:21 AM, James Quinlan wrote:
> On 10/24/24 21:08, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 10/22/2024 12:33 AM, Rob Herring wrote:
>>> On Fri, Oct 18, 2024 at 02:22:45PM -0400, Jim Quinlan wrote:
>>>> Support configuration of the GEN3 preset equalization settings, aka the
>>>> Lane Equalization Control Register(s) of the Secondary PCI Express
>>>> Extended Capability.  These registers are of type HwInit/RsvdP and
>>>> typically set by FW.  In our case they are set by our RC host bridge
>>>> driver using internal registers.
>>>>
>>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>> ---
>>>>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 
>>>> ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml 
>>>> b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>> index 0925c520195a..f965ad57f32f 100644
>>>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>>> @@ -104,6 +104,18 @@ properties:
>>>>       minItems: 1
>>>>       maxItems: 3
>>>>   +  brcm,gen3-eq-presets:
>>>> +    description: |
>>>> +      A u16 array giving the GEN3 equilization presets, one for 
>>>> each lane.
>>>> +      These values are destined for the 16bit registers known as the
>>>> +      Lane Equalization Control Register(s) of the Secondary PCI 
>>>> Express
>>>> +      Extended Capability.  In the array, lane 0 is first term, 
>>>> lane 1 next,
>>>> +      etc. The contents of the entries reflect what is necessary for
>>>> +      the current board and SoC, and the details of each preset are
>>>> +      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
>>>
>>> If these are defined by the PCIe spec, then why is it Broadcom specific
>>> property?
> Yes, I will remove the "brcm," prefix.
>>>
>> Hi Rob,
>>
>> qcom pcie driver also needs to program these presets as you suggested
>> this can go to common pci bridge binding.
>>
>> from PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4.2 for data rates
>> of  8.0 GT/s, 16.0 GT/s, and 32.0 GT/s uses one class of preset (P0
>> through P10) and where as data rates of 64.0 GT/s use different class of
>> presets (Q0 through Q10) (Table 4-23). And data rates of 8.0 GT/s also
>> have optional preset hints (Table 4-24).
>>
>> And there is possibility that for each data rate we may require
>> different preset configuration.
>>
>> Can we have a dt binding for each data rate of 16 byte array.
>> like gen3-eq-preset array, gen4-eq-preset array etc.
> 
> Yes, that was the idea when using "genX-eq-preset", for X in {3,4...}.
> 
> Keep in mind that this is an RFC; I have a backlog of commit submissions 
> before I can submit the code that uses this DT property.  If you 
> (Krishna) want to submit something now I'd be quite happy to go with 
> that.  I don't believe it is acceptable to submit a bindings commit w/o 
> code that uses it (if I'm incorrect I'll be glad to do a V2).
> 
Hi Jim,

I submitted a pull request for this. if you have any other suggestions
or if we need to have any other details we can update this pull request.
https://github.com/devicetree-org/dt-schema/pull/146

- Krishna Chaitanya.
> Regards,
> 
> Jim Quinlan
> Broadcom STB/CM
> 
>>
>> - Krishna Chaitanya
>>>> +
>>>> +    $ref: /schemas/types.yaml#/definitions/uint16-array
>>>
>>> minItems: 1
>>> maxItems: 16
>>>
>>> Last I saw, you can only have up to 16 lanes.
>>>
>>> Rob
>>>
> 

