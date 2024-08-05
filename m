Return-Path: <linux-pci+bounces-11271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFED9474EC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 07:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAD51C20D5E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8B143C6C;
	Mon,  5 Aug 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ob7Z19Gm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E97143C4B;
	Mon,  5 Aug 2024 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837476; cv=none; b=eBewUZqf906AyS1X5LM5bKkFhl6KeknMWv0MehAIzFhpvG8UOTgJwWHAL44qOZbrbHztdDRjLEPZhzfJNS/jPliwXAfqo+inRMARsLUoHYdqY3AiOjIoU5emWsa9k+MkxaaozmROESgu5he6QrOARWsX5+4pKWCmypMe7/oYvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837476; c=relaxed/simple;
	bh=qu+yzfCh32NsS+pabuQNKzqmRPtfgtTFOkbIoXQ5gzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gvI6V/2b7mAjGS134LN7uQ0Nh785o1NUfH0i+lchJJThi6uNkpS47COmDJUFYd7Dx2I9HUkiyo/8MgPUwiTSStntY4SQ4mgkJhPb2SqkitVKBpsl7mnB6pSr1c5Es4CjxDOFMT6slyiOMpl2uGKxqTjJQ7ToYHjitDBqONKqj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ob7Z19Gm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752Vexx023857;
	Mon, 5 Aug 2024 05:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c0m0GUgmMGH4VcXYWgBHUtXWyVZrk/+pijv15cQ1x+w=; b=Ob7Z19GmpYNVu+kN
	C1c2fA8cYhZPx+syl7/RzXiaU2SiUupz0jtn/Admq86zPSNKaCjsh6tLXxTy26pW
	SHiJW0JzgGlbUl3HsPzVcq5eaSvW9UEPikPICENhKiScXgs9fU35nPcxI2+15Kx6
	DPUlLHEM5ir1b4P2xZfSOScDGdREbbEb+mZAp3apXQeDdVyzg7F/0cHvamvq5v9P
	NHjTyB/nwk2Vp+u+afRkQgVllTjzqlD062GRSUxiOC5RZXz+vIfR7WnlBj+6T1PJ
	FQrMQNMDfy7G7oDoLrJufDkb/SpMMS/VQ1pgTQaNpPB//uZoic84fxlj75n+TLBP
	gMvkUQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbgru10w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 05:57:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4755virR000531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 05:57:44 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 22:57:38 -0700
Message-ID: <7f48f71c-7f57-492c-47df-6aac1d3b794b@quicinc.com>
Date: Mon, 5 Aug 2024 11:27:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
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
 <20240803-qps615-v2-1-9560b7c71369@quicinc.com>
 <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <58317fe2-fbea-400e-bd1d-8e64d1311010@kernel.org>
 <100e27d7-2714-89ca-4a98-fccaa5b07be3@quicinc.com>
 <c80ae784-c1f3-4046-9d86-d7e57bd93669@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <c80ae784-c1f3-4046-9d86-d7e57bd93669@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OAR1W457MC8YipMhCR3X__uupBlBKkR9
X-Proofpoint-GUID: OAR1W457MC8YipMhCR3X__uupBlBKkR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050041



On 8/5/2024 10:58 AM, Krzysztof Kozlowski wrote:
> On 05/08/2024 07:26, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 8/5/2024 10:44 AM, Krzysztof Kozlowski wrote:
>>> On 05/08/2024 06:11, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>>>>> +
>>>>>> +  qcom,nfts:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>>>>> +    description:
>>>>>> +      Fast Training Sequence (FTS) is the mechanism that
>>>>>> +      is used for bit and Symbol lock.
>>>>>
>>>>> What are the values? Why this is uint8?
>>>>>
>>>> These represents number of fast training sequence and doesn't have
>>>> any units and the maximum value for this is 0xFF only so we used
>>>> uint8.
>>>>> You described the desired Linux feature or behavior, not the actual
>>>>> hardware. The bindings are about the latter, so instead you need to
>>>>> rephrase the property and its description to match actual hardware
>>>>> capabilities/features/configuration etc.
>>>> ack.
>>>>>
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
>>>>>> +  - if:
>>>>>> +      properties:
>>>>>> +        compatible:
>>>>>> +          contains:
>>>>>> +            const: pci1179,0623
>>>>>> +      required:
>>>>>> +        - compatible
>>>>>
>>>>> Why do you have entire if? You do not have multiple variants, drop.
>>>>>
>>>> The child nodes also referencing the qcom,qps615.yaml# node, I tried
>>>> to use this way to say "the below properties are for the required for
>>>> parent and optional for child".
>>>
>>> I don't understand how child device can be exactly the same as parent
>>> device. How does it look in terms of hardware? Pins and supplies?
>>>
>>>>>> +    then:
>>>>>> +      required:
>>>>>> +        - vdd18-supply
>>>>>> +        - vdd09-supply
>>>>>> +        - vddc-supply
>>>>>> +        - vddio1-supply
>>>>>> +        - vddio2-supply
>>>>>> +        - vddio18-supply
>>>>>> +        - qcom,qps615-controller
>>>>>> +        - reset-gpios
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "@1?[0-9a-f](,[0-7])?$":
>>>>>> +    type: object
>>>>>> +    $ref: qcom,qps615.yaml#
>>>>>> +    additionalProperties: true
>>>>>
>>>>> Nope, drop pattern Properties or explain what is this.
>>>>>
>>>> the child nodes represent the downstream ports of the PCIe
>>>> switch which wants to use same properties that is why
>>>> I tried to use this pattern properties.
>>>
>>> Downstream port is not the same as device. Why downstream port has the
>>> same supplies? To which pins are they connected?
>>>
>>>
>> Hi Krzysztof,
>>
>> Downstream ports dosen't have pins or supplies to power on.
>>
>> But there are properties like qcom,l0s-entry-delay-ns,
>> qcom,l1-entry-delay-ns,  qcom,tx-amplitude-millivolt etc which
>> applicable for child nodes also. Instead of re-declaring the
>> these properties again I tried to use pattern properties.
> 
> You could use $defs for them, but I don't understand how does these
> properties apply for both main device and ports. It seems you are
> writing binding to match some driver behavior. Let's start from basics -
> describe the hardware.
> 
Hi Krzysztof,

QPS615 has a 3 downstream ports and 1 upstream port as described below
diagram.
For this entire switch there are some supplies which we described in the
dt-binding (vdd18-supply, vdd09-supply etc) and one GPIO which controls
reset of the switch (reset-gpio). The switch hardware can configure the
individual ports DSP0, DSP1, DSP2, upstream port and also one integrated
ethernet endpoint which is connected to DSP2(I didn't mentioned in the
diagram) through I2C.

The properties other than supplies,i2c client, reset gpio which
are added will be applicable for all the ports.
_______________________________________________________________
|   |i2c|                   QPS615       |Supplies||Resx gpio |
|   |___|              _________________ |________||__________|
|      ________________| Upstream port |_____________         |
|      |               |_______________|            |         |
|      |                       |                    |         |
|      |                       |                    |         |
|  ____|_____              ____|_____            ___|____     |
|  |DSP 0   |              | DSP 1  |            | DSP 2|     |
|  |________|              |________|            |______|     |
|_____________________________________________________________|

- Krishna Chaitanya.
> Best regards,
> Krzysztof
> 

