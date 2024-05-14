Return-Path: <linux-pci+bounces-7442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664168C4EE5
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B57B1C20DB1
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969627E796;
	Tue, 14 May 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TKSFLRfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC6DDC0;
	Tue, 14 May 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679426; cv=none; b=qCFgGGHcGetEHxmkdW4hRKJxelGOwRTkF+2qR7LxmIciaekL4EfYwcxJtPa7ClafQWDJuDCbje6ftd65I8QpVdy1lmNZtwnhfn7ehyEcPPLR5OQKr5JAtGgy0OcrnbVMMg8Zc8J0R1ggvQun+2WwBMXNa+O/BqOJdoBcjU+xX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679426; c=relaxed/simple;
	bh=YDR0OvydU7zH2Id5zmwZ16EB+ivVJacr3n+CDgO1iOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c2+kQ5j43HCt2DMM2Bn+t3Hm7lDEZbJCJHy+wWylWQ3mvRir5Qh02hhlfc9RDkI2Frf0FpeQWoalyGlVteYPoAUq0sGqID9DFH8GGqsBSdmU+2aEdmpB4T8/1OAfYp5p/6Tg9yNdYwgZcpcyyWZgerAaOHlnjn3SSVoOXjwj2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TKSFLRfY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E92trP023178;
	Tue, 14 May 2024 09:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BI5+3M4Cp+napxmir/qdBGnqzOR0kZqQTJ2+o6G6IA0=; b=TK
	SFLRfYlD6dI9dBhQA0ndoaBqLnU+oAXvJQ3C2xElFiqpKkZ8Krgar22YdmCadsd3
	+YENBZrt0UtmahWV568UP/5vTLAhebaTo52IMIiDajjvTOOnWUNinG3m6vxsl304
	7oN2X5/HotK6iSpK4fBxrnG3Caozh4caueoy5Wu7xrIDOUlS2qdvAhqPs8Yo91f0
	Cqq1C6TSmknlBzSghxSx6kSqrrr2Y7XoOyhHQplpN6KEgbYvP+MELSbJOogv+Yzp
	gY2F/kMHPI4eI1FhKKgRabPVL8uBvrm+/RhwSiJiRx5RgDZ0RIw8c7HF2XfyFGS3
	n3su5kJJmSvi7A5jY7+w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21eddq8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 09:36:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E9aAXA017970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 09:36:10 GMT
Received: from [10.216.46.205] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 02:36:03 -0700
Message-ID: <8b690d8f-986a-7806-b274-523b351e6e55@quicinc.com>
Date: Tue, 14 May 2024 15:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v12 6/6] PCI: qcom: Add OPP support to scale performance
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
 <20240427-opp_support-v12-6-f6beb0a1f2fc@quicinc.com>
 <20240430052613.GD3301@thinkpad>
 <8b213eba-7ab6-ae9c-7683-937a9d6aaf08@quicinc.com>
 <20240514092838.GE2463@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240514092838.GE2463@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k7TJaNxJ_yzDYhzkbemJI7DquIRd-h6P
X-Proofpoint-ORIG-GUID: k7TJaNxJ_yzDYhzkbemJI7DquIRd-h6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140067



On 5/14/2024 2:58 PM, Manivannan Sadhasivam wrote:
> On Thu, May 09, 2024 at 09:21:55PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 4/30/2024 10:56 AM, Manivannan Sadhasivam wrote:
>>> On Sat, Apr 27, 2024 at 07:22:39AM +0530, Krishna chaitanya chundru wrote:
>>>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>>>> maintains hardware state of a regulator by performing max aggregation of
>>>> the requests made by all of the clients.
>>>>
>>>> PCIe controller can operate on different RPMh performance state of power
>>>> domain based on the speed of the link. And this performance state varies
>>>> from target to target, like some controllers support GEN3 in NOM (Nominal)
>>>> voltage corner, while some other supports GEN3 in low SVS (static voltage
>>>> scaling).
>>>>
>>>> The SoC can be more power efficient if we scale the performance state
>>>> based on the aggregate PCIe link bandwidth.
>>>>
>>>> Add Operating Performance Points (OPP) support to vote for RPMh state based
>>>> on the aggregate link bandwidth.
>>>>
>>>> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
>>>> framework if OPP entries are present.
>>>>
>>>> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
>>>> is supported.
>>>>
>>>> Before PCIe link is initialized vote for highest OPP in the OPP table,
>>>> so that we are voting for maximum voltage corner for the link to come up
>>>> in maximum supported speed.
>>>>
>>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++------
>>>>    1 file changed, 67 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 465d63b4be1c..40c875c518d8 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>
>>> [...]
>>>
>>>> @@ -1661,6 +1711,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>>>    		ret = icc_disable(pcie->icc_cpu);
>>>>    		if (ret)
>>>>    			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>>>> +
>>>> +		if (!pcie->icc_mem)
>>>> +			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>>>
>>> At the start of the suspend, there is a call to icc_set_bw() for PCIe-MEM path.
>>> Don't you want to update it too?
>>>
>>> - Mani
>>>
>> if opp is supported we just need to call dev_pm_opp_set_opp() only once
>> which will take care for both PCIe-MEM & CPU-PCIe path.
>> so we are not adding explicitly there.
> 
> No, I was asking you why you are not adding a check for the existing
> icc_set_bw() at the start like you were doing elsewhere.
>Got it I will add the check in the next patch series.
- Krishna Chaitanya.
> - Mani
> 

