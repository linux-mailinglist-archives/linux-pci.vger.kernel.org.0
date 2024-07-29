Return-Path: <linux-pci+bounces-10938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB793F21C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A512B282229
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D311411D7;
	Mon, 29 Jul 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JDYU9+Bh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A878C9A;
	Mon, 29 Jul 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247471; cv=none; b=iPKIA2Ee+KYOjav6xatDWeIuZSjBpVI1SN3Njf35FO4b8bk525PGiUZU/jegvqWgtWgSrBXFF7cGou2Vgi0HFgeBRkP0gSmiR2raZiS7Vnt+IWwFiszR87afCC4y5+YmgMFLpa5bOGH2qZzhuapn66tfOOUnuqG2QM9gBNRG5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247471; c=relaxed/simple;
	bh=S8kzPH+k5zjd/+P9Zlhh0/3qVqwb9D/yH+JbUkti04Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K42VIdn5fPqRj46edpgt3qFnGaFRIqOU1Xga+JmZK3kfHZ2/t708w7DljJBhsMjhEHfzOraAVAEXa888+aCw/qlg0gyhsU4wnasDh0Nn5LqwPbjyO24eNRymDrOdNRpG0RklqWzDGwHMf7PEycHLtTCY3oiSHMwaAjkLdWkN5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JDYU9+Bh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SNdwqS017221;
	Mon, 29 Jul 2024 10:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	asO5kAz9XGDBDuRnVh0QHTXlxhXMwkUNYgM8CNa1sEQ=; b=JDYU9+Bh3RwBiyL0
	IICY3022ngG5owSgkMdo6yEokSikMckXHsOiymR/7vMlTKykmpU3PKKskwNhbOWB
	MhvQq/azR9BDB6VN8yo41gGahBRxEutltnoVk0bypCLYnQrdv2CjCkYkQDPT3yQy
	kOmVza2I4Iuz1zlYZj//eAA5KOvMQPbJ99U8RUn0PGewM+tzzTKPsX5zGp6/XETm
	lCD5KV1mogA7SZx9cOIgHCD1kwuOHakdMW/xst6uwg54AYLi4aMJYZDztwwWre2B
	vEw0/k9xXQ0QshQyaWDZPgPQ4u7jNAOkqqMcgH/PxziYcI7UB4zmCqg0PBs5D4fZ
	lZpUAw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40msne3pam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:04:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TA4Lu9020918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:04:21 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:04:16 -0700
Message-ID: <309cfc01-affb-4d26-a5ff-fb73b924efcd@quicinc.com>
Date: Mon, 29 Jul 2024 18:04:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add QCS9100 PCIe compatible
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
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
	<andersson@kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
 <20240709175823.GB44420@thinkpad>
 <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>
 <20240710070908.GA3731@thinkpad>
 <239f408d-7bab-48c3-bf26-3880012d9098@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <239f408d-7bab-48c3-bf26-3880012d9098@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PJ1b8dHwfVQXXyEIMt1j04LD1jinc_LO
X-Proofpoint-ORIG-GUID: PJ1b8dHwfVQXXyEIMt1j04LD1jinc_LO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290068



On 7/10/2024 6:25 PM, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/10/2024 3:09 PM, Manivannan Sadhasivam wrote:
>> On Wed, Jul 10, 2024 at 09:47:47AM +0800, Aiqun Yu (Maria) wrote:
>>>
>>>
>>> On 7/10/2024 1:58 AM, Manivannan Sadhasivam wrote:
>>>> On Tue, Jul 09, 2024 at 10:59:28PM +0800, Tengfei Fan wrote:
>>>>> Introduce support for the QCS9100 SoC device tree (DTSI) and the
>>>>> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
>>>>> While the QCS9100 platform is still in the early design stage, the
>>>>> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
>>>>> mounts the QCS9100 SoC instead of the SA8775p SoC.
>>>>>
>>>>> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
>>>>> all the compatible strings will be updated from "SA8775p" to "QCS9100".
>>>>> The QCS9100 device tree patches will be pushed after all the device tree
>>>>> bindings and device driver patches are reviewed.
>>>>>
>>>>
>>>> Are you going to remove SA8775p compatible from all drivers as well?
>>>
>>> SA8775p compatible and corresponding scmi solutions for the driver will
>>> be taken care from auto team, currently IOT team is adding QCS9100
>>> support only. Auto team have a dependency on the current QCS9100(IOT
>>> non-scmi solution) and SA8775p(AUTO SCMI solution) device tree splitting
>>> effort.
>>>
>>> More background and information can be referenced from [1].
>>> [1] v1:
>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>
>> I'm aware of the background, but what I don't understand is, why do you want to
>> keep the sa8775p compatible in both the driver and binding? Once you rename the
>> DT, these compatibles become meaningless.
>>
>> Waiting for Auto team to remove the compatible is not ideal. They may anyway
>> modify it based on SCMI design.
> 
> Got it. Will remove sa8775p compatible in next patchset version after
> discuss with Tengfei.
> 
> PCIE driver have a very good shape of resources op api, and when SCMI
> resource solution added, "sa8775p" compatible can be added at that time
> with correct SCMI resource ops.

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore all the current patches here.
Thank you for your input.

>>
>> - Mani
>>
>>>>
>>>> - Mani
>>>>
>>>>> The final dtsi will like:
>>>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
>>>>>
>>>>> The detailed cover letter reference:
>>>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>>>>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>    - Split huge patch series into different patch series according to
>>>>>      subsytems
>>>>>    - Update patch commit message
>>>>>
>>>>> prevous disscussion here:
>>>>> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>>>>
>>>>> ---
>>>>> Tengfei Fan (2):
>>>>>        dt-bindings: PCI: Document compatible for QCS9100
>>>>>        PCI: qcom: Add support for QCS9100 SoC
>>>>>
>>>>>   Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
>>>>>   drivers/pci/controller/dwc/pcie-qcom.c                       | 1 +
>>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>> ---
>>>>> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
>>>>> change-id: 20240709-add_qcs9100_pcie_compatible-ceec013a335d
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>
>>>>
>>>
>>> -- 
>>> Thx and BRs,
>>> Aiqun(Maria) Yu
>>
> 

-- 
Thx and BRs,
Tengfei Fan

