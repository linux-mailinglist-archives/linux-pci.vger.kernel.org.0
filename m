Return-Path: <linux-pci+bounces-11269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427C9474B1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 07:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776271C20C8E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D91419A9;
	Mon,  5 Aug 2024 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="APoVRry9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF2639;
	Mon,  5 Aug 2024 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722836047; cv=none; b=stLIaJkhPdxniD8RgLWjAa32SJmXw9KQGNfUrTz2JBXNqZROBFmkPngke+ryLCI7d4WueMZw7jDO31WZ0Jx4xA1WT23Ihg7flMumJVfJ7IGknr3zYf38JH7jwvyBU/0ew7D2WimH/dfUG7v+nyA7jg8EkfIobxw5Uk50sXB/plA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722836047; c=relaxed/simple;
	bh=A7AsuFu3J7IuwbUX+xj/MH8QGS0K6jnowqE8lE8E1Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JjsvS5WAEBKo8hek1Mx8iPJONF9ZzCfsjqnjoCnZWRp+St07Ci/iudS77dgmIbMQhS8uKozviaQkYk2p4xbukfJKFJ4ajQ9w5R9sqDvPWa5n92eXf8HbAF+rpoqTriUIS0eBTSQTHX2RuysLvI64WoKsEudALpIGcEEg3YoomwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=APoVRry9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VmEn014293;
	Mon, 5 Aug 2024 05:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nofa3nIAq87yCBtgPBTkx+5CILCHMUUE2PiL4HD1bws=; b=APoVRry9hfdIJE7e
	W4mqLqKNpCoxWU9lLJP7RBfk4UEm3ftrj4Zipvik2LeFmc6hoxeLFh1jHfQuSymU
	0TZpz5CuCiGexCODoMjiScpM3T9y2z5EFwzGyzX3Uoqn9Moct8q+6usiIGqvZ86L
	v28TyINTACRGb8biSe9Rey5UVV5PJgqmlXSp0aLYc1KTSpldoNvK7WcgjLbWtNsg
	stJ63avc8NndgxkzygDExVu8F4BR0xoJsfTo+3BNjStbLYbzeAKOHWm9W2gOc2lB
	dzbghCCnzEH6BVwsy39xJTVBibEARkuSGAEbK/ntORKFvmoJQa0bVeKdqZlF84tJ
	L8mzew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdu92tse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 05:33:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4755Xuwd011750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 05:33:56 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 22:33:50 -0700
Message-ID: <f469d04f-f539-ed53-055f-5360cddaafdd@quicinc.com>
Date: Mon, 5 Aug 2024 11:03:46 +0530
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
 <0cdaa0b2-ae50-40a1-abbb-7a6702d54ad5@kernel.org>
 <027dc9f7-6e0d-e331-8f90-92a3d56350ab@quicinc.com>
 <132a0367-596b-4ff2-b35c-e81e77f14340@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <132a0367-596b-4ff2-b35c-e81e77f14340@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IJcqCLkE_DeHsbBjYLSaAjchf77swZW1
X-Proofpoint-GUID: IJcqCLkE_DeHsbBjYLSaAjchf77swZW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408050038



On 8/5/2024 10:42 AM, Krzysztof Kozlowski wrote:
> On 05/08/2024 06:02, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 8/4/2024 2:26 PM, Krzysztof Kozlowski wrote:
>>> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>>>> Add binding describing the Qualcomm PCIe switch, QPS615,
>>>> which provides Ethernet MAC integrated to the 3rd downstream port
>>>> and two downstream PCIe ports.
>>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
>>>>    1 file changed, 191 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>>>> new file mode 100644
>>>> index 000000000000..ea0c953ee56f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>>>> @@ -0,0 +1,191 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm QPS615 PCIe switch
>>>> +
>>>> +maintainers:
>>>> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> +
>>>> +description: |
>>>> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
>>>> +  ports. The 3rd downstream port has integrated endpoint device of
>>>> +  Ethernet MAC. Other two downstream ports are supposed to connect
>>>> +  to external device.
>>>> +
>>>> +  The QPS615 PCIe switch can be configured through I2C interface before
>>>> +  PCIe link is established to change FTS, ASPM related entry delays,
>>>> +  tx amplitude etc for better power efficiency and functionality.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - pci1179,0623
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  qcom,qps615-controller:
>>>
>>> and now I see that you totally ignored comments. Repeating the same over
>>> and over is a waste of time.
>>>
>>> <form letter>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my or other reviewer's previous comments were not fully
>>> addressed. Maybe the feedback got lost between the quotes, maybe you
>>> just forgot to apply it. Please go back to the previous discussion and
>>> either implement all requested changes or keep discussing them.
>>>
>>> Thank you.
>>> </form letter>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi Krzysztof,
>>
>> In patch1 we are trying to add reference of i2c-adapter, you suggested
>> to use i2c-bus for that. we got comments on the driver code not to use
>> adapter and instead use i2c client reference. I felt i2c-bus is not
>> ideal to represent i2c client device so used this name.
> 
> You did not respond to comment of using i2c-bus, just silently decided
> to implement other property.
> 
I should have replied to v1 why we are not using this suggested way,
next time onwards I will fallow that.

> Anyway, why i2c-bus is not suitable here? I am quite surprised...
>
It was suggested by bjorn andresson in the offline review, I will check
this and get back.

- Krishna Chaitanya.
> 
> 
> Best regards,
> Krzysztof
> 

