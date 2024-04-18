Return-Path: <linux-pci+bounces-6459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1115B8AA259
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E391C20B04
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289AB17AD74;
	Thu, 18 Apr 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a0AHG7C9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9616F843;
	Thu, 18 Apr 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466593; cv=none; b=nI0zSNzV8ofpWQXV2iO/SuEZh8YpDDPwKaSX3FuTbdlZK0kiAoLu3OoH4jhe0TiLteGW8L61mdbSZohv3Y5210QeIaC2ko2WIqMsmtWvkKK4D8J6uNXsDCTFGbgujKotBa4+K2OzaZVTvcnkmQZeAbX84qKGMJ5ZCzoVxhhysYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466593; c=relaxed/simple;
	bh=jCAIuFUcsXQf2F7fvZuri9i30DRCKKvTTUiYa7xsW0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nFp6QmBC5G5cMA11jHUIbGRRJt49X9PysZ8YU7tXAZYfxMN+6v157J9X+K/4v74IQvs4yGPVeh6gHBkBSpb1DatcsMfo58KEggm2lZ9d8ao6QEF+Pwf2dqUTiqG9S5bnDIgrSSfujD1SxkVNbUCCiBkyxify4EfdHsTNzq08guo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a0AHG7C9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IGQNWO024563;
	Thu, 18 Apr 2024 18:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qZk8y/Ka/u6+JADvgAql2OoxA4UPD3xewpwj6kCAWPY=; b=a0
	AHG7C9EO8horbYBCgv6ZOnlo4DI/5ZOrNYf0Gfs39j8OEEulizbmNxaykqjFneph
	6XSUNSVaHQlM2h727TbYmdtqvTpQ107R47xYB9czYihDDIjNS2yUkLCskHGmzxiv
	fig2uYmACdwHJtDjkEoAcddJaGgaWhKe8m8vTDDfCC66/4Mmg+N3W8A8s0r/Oy+h
	Roc+Arsz5hMGtjsUwJqXIMlz4Apo7NcbgyMDh/zVU9H0LCMkjSpaeN6Gm2s8NN87
	7phz8zsAWKp1wUw7AHl04I4FUddXt5+FBk1+0F6ORaTbdRFAwJDa6ajEYMoCNuv7
	qKx68vQiZffe7h61jjEw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk3chgyma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 18:56:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IIuGHq022654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 18:56:16 GMT
Received: from [10.110.67.157] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:56:15 -0700
Message-ID: <708e1adf-833d-4de5-9e94-406883337d16@quicinc.com>
Date: Thu, 18 Apr 2024 11:56:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] dt-bindings: pcie: Document QCOM PCIE ECAM
 compatible root complex
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_shazhuss@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_nitegupt@quicinc.com>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-2-git-send-email-quic_mrana@quicinc.com>
 <51b02d02-0e20-49df-ad13-e3dbe3c3214f@linaro.org>
 <1d6911e2-d0ec-4cb0-b417-af5001a4f8a3@quicinc.com>
 <ce17f2dc-decf-4509-969e-e23bdef42eb9@linaro.org>
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <ce17f2dc-decf-4509-969e-e23bdef42eb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RSiBnNvXK6tSleo8rK7kkNNw5PFWqMu-
X-Proofpoint-GUID: RSiBnNvXK6tSleo8rK7kkNNw5PFWqMu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_17,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180136



On 4/8/2024 11:21 PM, Krzysztof Kozlowski wrote:
> On 08/04/2024 21:09, Mayank Rana wrote:
>>>> +  Firmware configures PCIe controller in RC mode with static iATU window mappings
>>>> +  of configuration space for entire supported bus range in ECAM compatible mode.
>>>> +
>>>> +maintainers:
>>>> +  - Mayank Rana <quic_mrana@quicinc.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>>> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,pcie-ecam-rc
>>>
>>> No, this must have SoC specific compatibles.
>> This driver is proposed to work with any PCIe controller supported ECAM
>> functionality on Qualcomm platform
>> where firmware running on other VM/processor is controlling PCIe PHY and
>> controller for PCIe link up functionality.
>> Do you still suggest to have SoC specific compatibles here ?
> 
> What does the writing-bindings document say? Why this is different than
> all other bindings?
Thank you for all your review comment and suggestions.

If it is must to have SOC name, then I am not sure how 
pci-host-generic.c driver having non SOC prefix for standard ECAM 
driver. I am here saying this is QCOM vendor specific generic ECAM 
driver. saying that it seems that I would be updating now 
pci-host-generic.c driver to add generic functionality as Rob suggested 
part of review comment. With
that I am seeing possible options as i.e. continue using default generic 
compatible as "pcie-host-ecam-generic" OR use new as 
"qcom,pcie-host-ecam-generic". will this work ?>>>> +
>>>> +  reg:
>>>> +    minItems: 1
>>>
>>> maxItems instead
>>>
>>>> +    description: ECAM address space starting from root port till supported bus range
>>>> +
>>>> +  interrupts:
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>
>>> This is way too unspecific.
>> will review and update.
>>>> +
>>>> +  ranges:
>>>> +    minItems: 2
>>>> +    maxItems: 3
>>>
>>> Why variable?
>> It depends on how ECAM configured to support 32-bit and 64-bit based
>> prefetch address space.
>> So there are different combination of prefetch (32-bit or 64-bit or
>> both) and non-prefetch (32-bit), and IO address space available. hence
>> kept it as variable with based on required use case and address space
>> availability.
> 
> Really? So same device has it configured once for 32 once for 64-bit
> address space? Randomly?
no. as binding is not saying for any specific SOC. Depends on memory map
on particular SOC, how PCIe address space available based on that this 
would change for particular SOC variant.
> Best regards,
> Krzysztof
> 

