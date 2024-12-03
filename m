Return-Path: <linux-pci+bounces-17564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279C9E16AB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480321608D7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0FF1DD0F9;
	Tue,  3 Dec 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ju/IGsBx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584D1CD204;
	Tue,  3 Dec 2024 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216819; cv=none; b=bhebBRmEVK/d/vPD6yi16CxXgJ/VDfTGOTNbxP6C4Rs2XE/NgI2/KRRxH/ZRriH3d8LpUMCz4C8L0rD6eMMH8s0EN+X+LXlkj2NoAxYRAiEOyuGV1QEHZ+WRDfkvsNxhJwvIblPMeSqayN7357RBMOhUoU0OdpRHIkQVFa3dda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216819; c=relaxed/simple;
	bh=PJl1OgSeGWONAc1bo6522cBNnTp+AUlrw7gcEnM0UxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G0HBGMTgdC55vzr8HHmiSTpPrtWdKAHF9oB+P9has6pJw3G9FtpOwNDnCPGXTLnpK7AnQP82pgJUqdeeA+20oZcXVfQWmwUcMktxFri/xWqGlCct5Pa6XEpyG5S9iE1HW9tfZe/MAV0J6fJ4ey8dFfku0OAWraGxNq+v2lpLF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ju/IGsBx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37qYeu003625;
	Tue, 3 Dec 2024 09:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zd6w5KfpEFKkHZqYYkf6lZZEdZ0dZ46dhuKoHtYHBfA=; b=Ju/IGsBxn9HPhQW6
	VuY2PPoxuCNIhEUTVDzdmaxhU4KbEsSzhpwSg6gt6nJ1UQYercNOXc9crYYudt1V
	DWpMaez+AF+FvLmqapTleP1MmuQvL7TcMRZ8GcU3ylz+tcJAOptWRT5VJPOgmfS3
	sZkdbQ2mJ8xQpzNHeH8741P+edvO8NduW6egvD5M+Fg+JLixhRIsuXwE0z8AydeD
	mnQ+1UyF+eBHRmVQp99KBfpZwZGJ7XK8ei2yuhPXkP8fGm4ErEk9kh7646B3mUZo
	UUUprnS2um3nlXubj3xWQU24/gm0hlZ4gDtNP5gwc4FnzrC+OeIy7UcgtHctosNe
	QiTdrQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437sq67j0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:06:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B396i7u022822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 09:06:44 GMT
Received: from [10.216.45.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 01:06:38 -0800
Message-ID: <ef4a0373-2ad0-a669-1e52-e6e81105fded@quicinc.com>
Date: Tue, 3 Dec 2024 14:36:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
 <42425b92-6e0d-a77b-8733-e50614bcb3a8@quicinc.com>
 <b203d90d-91bc-437b-9b91-1085034ed716@kernel.org>
 <cce7507f-a2c4-6f96-f993-b9a7e9217ffa@quicinc.com>
 <c81b89ff-6eb5-4a01-af84-636aa2a02a34@kernel.org>
 <20241128132432.fxvmjeluagignbph@thinkpad>
 <dtr62oy4lcdqtyvh6ffr3c7rjz65h6bj4fkknf3rmgm65zhnpo@caqdpy7xi4ue>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <dtr62oy4lcdqtyvh6ffr3c7rjz65h6bj4fkknf3rmgm65zhnpo@caqdpy7xi4ue>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cAVDdmet4GDfh2W6IcOqJKLzWQblj0EB
X-Proofpoint-ORIG-GUID: cAVDdmet4GDfh2W6IcOqJKLzWQblj0EB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=931
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030078



On 11/28/2024 7:38 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 28, 2024 at 06:54:32PM +0530, Manivannan Sadhasivam wrote:
>> On Tue, Nov 26, 2024 at 07:58:16AM +0100, Krzysztof Kozlowski wrote:
>>> On 26/11/2024 07:50, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 11/25/2024 1:10 PM, Krzysztof Kozlowski wrote:
>>>>> On 24/11/2024 02:41, Krishna Chaitanya Chundru wrote:
>>>>>>> ...
>>>>>>>
>>>>>>>> +  qps615,axi-clk-freq-hz:
>>>>>>>
>>>>>>> That's a downstream code you send us.
>>>>>>>
>>>>>>> Anyway, why assigned clock rates do not work for you? You are
>>>>>>> re-implementing legacy property now under different name :/
>>>>>>>
>>>>>>> The assigned clock rates comes in to the picture when we are
>>>>>>> using clock
>>>>>> framework to control the clocks. For this switch there are no
>>>>>> clocks needs to be control, the moment we power on the switch
>>>>>> clocks are enabled by default. This switch provides a mechanism to
>>>>>> control the frequency using i2c. And switch supports only two
>>>>>> frequencies i.e
>>>>>
>>>>>
>>>>> frequency of what, since there are no clocks?
>>>>>
>>>> The axi clock frequency internal to the switch, host can't control
>>>> the enablement of the clocks it can control only the frequency.
>>>>
>>>> we already had a discussion on this on v2[1], and we taught you agreed
>>>> on this property.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/netdev/d1af1eac-f9bd-7a8e-586b-5c2a76445145@codeaurora.org/T/#m3d5864c758f2e05fa15ba522aad6a37e3417bd9f
>>>>
>>>
>>> This points something else. I diged v2 and found many unanswered
>>> questions and unfinished discussion:
>>>
>>
>> The conversation is here:
>> https://lore.kernel.org/linux-arm-msm/20240823094028.7xul4eoiexey5xjm@thinkpad/
>>
>> But there was no explicit agreement on the usage of 'qps615,axi-clk-freq-hz'.
>>
>> If describing the PCI device's internal clock frequency is not applicable, then
>> I'd recommend to change the clock rate in the driver itself based on the number
>> of DSPs enabled (or based on other configuration).
> 
> Sounds like the best approach. Otherwise it's not obvious, what is the
> criteria for selecting this or that clock value.
> 
I will remove this property in next patch and driver code to set this 
frequency in the next patch, we will try to come up with some logic later.

- Krishna chaitanya.
>>
>> - Mani
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
> 

