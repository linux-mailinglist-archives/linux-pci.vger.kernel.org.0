Return-Path: <linux-pci+bounces-10536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B6937112
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 01:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2051C282743
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CE1465BD;
	Thu, 18 Jul 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RgnHaS42"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92248146A8C;
	Thu, 18 Jul 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721344838; cv=none; b=DlHklWxaHkgHRtsngCeyY930rxLweVTqeKwCbvfVHFo59i5hB+P7frDUgMt/1/mVJ3oTKAIVFVkeaXqGExAbJTiTxmwz201x7wUj0D3jM+F0c0EqOrY70SUtOdeZplnk1tcRmX5Az98QmOdnsvvfVocjInJ8VmRLUgciqHt2+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721344838; c=relaxed/simple;
	bh=wWm4q2M8rBlqV2ruE3JVlVBiceu4Nwap703ySxFdbUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pMyHBjm38KDmwb8/T1J18XESK+UIqmkL6wrmGsSwn8ngLYnYSsopkylTcJTDWvMl7YdOTa8MVNMqxr+wGysen0+watyz5Upd0gd0hQJrgN3gOeOV54jY5LmfNVWwCiAm92pwGKgYubUvGxVgMaGZ78b80tnKI0vJ2YHFY+LwRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RgnHaS42; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IE3LoE012817;
	Thu, 18 Jul 2024 23:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7tI6QMarTkA1Aw41GeSyr3Fblvg074vDVUe6LTv9ZP0=; b=RgnHaS42WUWWr0Eo
	lYVVmKFEACAM0oTQg8G2lRnJ/MnEXpKxMebzYj311QjuGhcWJqTsmoSALCJDqN2K
	iovuUNZpMjDEy+yHXysMLKAC0yS2KDS/snGVvajB84XquHu2VpxcNA8tBGoewsGH
	I490JZNX2ZZqnUiJ1sWl7uogAenSOO6B/vhpkleJRmyieurfuq7+FBuuYt2MpQ5N
	Hq3UGrPL0/ZjeOCxq/SetivzYO7r20pj3Kdl8rBXatqdyBlAHnvxbVdNMCyn7evp
	rVp4kBRLFwAUj8fveqR/d4cNCtncKBFpfNNDku+bDR9dh5I8y4XLoev7+W2sLvCG
	BHQ+dg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfweq7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 23:19:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46INJTFv005378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 23:19:29 GMT
Received: from [10.110.7.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Jul
 2024 16:19:28 -0700
Message-ID: <1a6f5cdf-9256-4d8d-b8c7-92bd6e7d3813@quicinc.com>
Date: Thu, 18 Jul 2024 16:19:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V226/7] dt-bindings: PCI: host-generic-pci: Add
 snps,dw-pcie-ecam-msi binding
To: Krzysztof Kozlowski <krzk@kernel.org>, <will@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-7-git-send-email-quic_mrana@quicinc.com>
 <5f029f16-2030-4e86-929b-0b2832958912@kernel.org>
 <083e1e6f-714d-4a3e-a864-59e06bba0559@quicinc.com>
 <3221423a-d5b3-47e3-8b98-623d9b26363d@kernel.org>
 <f06ab1ee-6078-4d89-b236-e11be4d28fc5@quicinc.com>
 <609c2420-4bf9-4d1b-b998-2dea825139b2@kernel.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <609c2420-4bf9-4d1b-b998-2dea825139b2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nVrTq8cQlAAkZw9qlo_w0oSRoxdazP_D
X-Proofpoint-ORIG-GUID: nVrTq8cQlAAkZw9qlo_w0oSRoxdazP_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180157

Hi Krzysztof

On 7/17/2024 11:05 PM, Krzysztof Kozlowski wrote:
> On 17/07/2024 19:20, Mayank Rana wrote:
>> Hi Krzysztof
>>
>> On 7/16/2024 11:47 PM, Krzysztof Kozlowski wrote:
>>> On 17/07/2024 00:09, Mayank Rana wrote:
>>>> Hi Krzysztof
>>>>
>>>> On 7/16/2024 12:28 AM, Krzysztof Kozlowski wrote:
>>>>> On 15/07/2024 20:13, Mayank Rana wrote:
>>>>>> To support MSI functionality using Synopsys DesignWare PCIe controller
>>>>>> based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
>>>>>> compatible binding which uses provided SPIs to support MSI functionality.
>>>>>
>>>>> To support MSI, you add MSI support... That's a tautology. Describe
>>>>> hardware instead.
>>>> Ok. let me repharse it to provide more useful information.
>>>>>>
>>>>>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
>>>>>>     1 file changed, 57 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>>>> index 9c714fa..9e860d5 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>>>> @@ -81,6 +81,12 @@ properties:
>>>>>>                   - marvell,armada8k-pcie-ecam
>>>>>>                   - socionext,synquacer-pcie-ecam
>>>>>>               - const: snps,dw-pcie-ecam
>>>>>> +      - description: |
>>>>>> +         Firmware is configuring Synopsys DesignWare PCIe controller in RC mode with
>>>>>> +         ECAM compatible fashion. To use MSI controller of Synopsys DesignWare PCIe
>>>>>> +         controller for MSI functionality, this compatible is used.
>>>>>> +        items:
>>>>>> +          - const: snps,dw-pcie-ecam-msi
>>>>>
>>>>> MSI is already present in the binding, isn't it?
>>>> It is mentioning as msi-parent usage which could be different MSI
>>>> controller (GIC or vendor specific one) not related to designware PCIe
>>>> controller based MSI controller.
>>>>
>>>>> Anyway, aren't you
>>>>> forgetting specific compatible? Please open your internal (quite
>>>>> comprehensive) guideline on bindings and DTS.
>>>> Here I am trying to define Designware based PCIe ECAM controller
>>>> supporting MSIcontroller based device. Hence I am not mentioning vendor
>>>> specific compatible usage
>>>> and keeping generic compatible binding for such device.
>>>
>>> I know what you try, yet it feels simply wrong. Read your guideline.
>>> Are you sure you work on Designware core itself, not on one used in
>>> Qualcomm? I would expect people from Designware to design Designware
>>> cores and people from Qualcomm only to design licensed cores.
>> Ok. let me not make generic comment here. I refereed how it is done with
>> other
>> snps based IP usage for example USB, and would follow same.
> 
> Well, it is not. If you read their bindings or any reviews related to
> such cores, you would see that single Designware compatible is always
> never appropriate. Such cores always have customization per user.
> 
> You can also look at the binding you are changing. Do you see Designware
> alone? No.
I found reference in this binding as below:
  79         items:
  80           - enum:
  81               - marvell,armada8k-pcie-ecam
  82               - socionext,synquacer-pcie-ecam
  83           - const: snps,dw-pcie-ecam

And as you mentioned in previous emails about how to add such usage, I 
ACKed it but let me put reason why I tried to add differently to start 
with it.

This specific driver under-discussion is really not vendor specific 
driver. It can work with any PCIe controller which is already configured 
in ECAM mode by firmware (i.e. PCIe controller from SNPS or any other 
vendor). There are few quirks only added to get specific vendor based 
SOC configuration for SNPS PCIe controller by different SOC vendors.

  90       - description:
  91           CAM or ECAM compliant PCI host controllers without any quirks
  92         enum:
  93           - pci-host-cam-generic
  94           - pci-host-ecam-generic

Above enum based usage works for SA8775P platform which is having SNPS 
PCIe controller which doesn't need any quirks, and firmware is able to 
configure PCIe controller into ECAM mode. Here I tried adding PCIe SNPS 
controller based MSI support as SA8775P doesn't support LPI/ITS for MSI. 
I need to differentiate it hence added generic enum as MSI controller is 
part of SNPS PCIe controller, and not separate MSI IP here. Although how 
many MSI can be supported it depends on how many SPIs are available/used 
with MSI controller depend on particular SOC. Hence put as 
snps,dw-pcie-ecam-msi as usage and variable number of MSI. hopefully I 
am able to convey why this driver binding modified differently.

Regards,
Mayank

