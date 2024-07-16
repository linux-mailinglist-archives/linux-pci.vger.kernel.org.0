Return-Path: <linux-pci+bounces-10418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B732933419
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 00:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871AB1C22E2E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 22:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D313A896;
	Tue, 16 Jul 2024 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ATh8wg/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0051860;
	Tue, 16 Jul 2024 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167878; cv=none; b=OYaIfGJCBec6FsqRymSlptVr8zCEWkvp67FW9HbX7mgAyDFP4GhcRAghBAtr/IvxaddM3fDFZH5y+HS//kl9N2Dk5CnAFdkrHzT9Iu1aq4E80H3dH8LYhBKemYosXQ09OIUFqy4kbrqdvu/KZtoyhDrB6YWURYJxVGF/fTq2eTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167878; c=relaxed/simple;
	bh=LCxAGMQEngk02nzIU4XQOPqU1UpRo5VW3UslgQDW01o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VnU/D37yFA91nYVtLGLhbRxah0ig2Y/0UjAhgJD9lZ/h7je32MvjSg/0LnGplC+yN9AkMzS2skml1Uee/SBUYu6NGqUpdx7xfDF9kkZ/68pcD0iTs61p/KtkuQ7blTJ7DyMRO4XeMxieGfZtdOn/2ClnVXvtcl/Zn4YKlKTAyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ATh8wg/g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHfApB032680;
	Tue, 16 Jul 2024 22:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eM8ybAHv9Bq6WBag+D11x1Mh9KvV9kdRf1Irf8st8jU=; b=ATh8wg/gLqU0JZkv
	EJr1HiQflvO649YLE/ybQWnNcV/Hnrzfj4FRoeQ9CohOk1xjgTUmzBKcv5SrcDwk
	9HoHQVMDvvdRaYR041xiyZml42bGAUoICX/mWNbfzJDx2HIuk7exnCZgAt5xOfMx
	4LIBaiXMICdWfGg4Nv+gX0zfLtwOkKLlzEKzYHATtOComRdV4TL4TzR19/pIhW+p
	8W057eaVp6zb5EKZF+wCeFchseLDDQVgEpfo3jdtVbVnQgYpGdiRajs9DJYnUuBM
	kzd409nngw5swA7+CWDRwewPSqvx7ANPWHHd7PfMatcxVIaAfVyse+Y6CLNunCt0
	IkpqTw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs0fe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 22:09:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GM9TSt015181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 22:09:29 GMT
Received: from [10.110.79.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 15:09:28 -0700
Message-ID: <083e1e6f-714d-4a3e-a864-59e06bba0559@quicinc.com>
Date: Tue, 16 Jul 2024 15:09:28 -0700
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
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <5f029f16-2030-4e86-929b-0b2832958912@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BGc8TP0-jGkacfrCs4tQktSRNW4QT3zS
X-Proofpoint-GUID: BGc8TP0-jGkacfrCs4tQktSRNW4QT3zS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_01,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160162

Hi Krzysztof

On 7/16/2024 12:28 AM, Krzysztof Kozlowski wrote:
> On 15/07/2024 20:13, Mayank Rana wrote:
>> To support MSI functionality using Synopsys DesignWare PCIe controller
>> based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
>> compatible binding which uses provided SPIs to support MSI functionality.
> 
> To support MSI, you add MSI support... That's a tautology. Describe
> hardware instead.
Ok. let me repharse it to provide more useful information.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>> index 9c714fa..9e860d5 100644
>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>> @@ -81,6 +81,12 @@ properties:
>>                 - marvell,armada8k-pcie-ecam
>>                 - socionext,synquacer-pcie-ecam
>>             - const: snps,dw-pcie-ecam
>> +      - description: |
>> +         Firmware is configuring Synopsys DesignWare PCIe controller in RC mode with
>> +         ECAM compatible fashion. To use MSI controller of Synopsys DesignWare PCIe
>> +         controller for MSI functionality, this compatible is used.
>> +        items:
>> +          - const: snps,dw-pcie-ecam-msi
> 
> MSI is already present in the binding, isn't it? 
It is mentioning as msi-parent usage which could be different MSI 
controller (GIC or vendor specific one) not related to designware PCIe 
controller based MSI controller.

>Anyway, aren't you
> forgetting specific compatible? Please open your internal (quite
> comprehensive) guideline on bindings and DTS.
Here I am trying to define Designware based PCIe ECAM controller 
supporting MSIcontroller based device. Hence I am not mentioning vendor 
specific compatible usage
and keeping generic compatible binding for such device.
> 
>>         - description:
>>             CAM or ECAM compliant PCI host controllers without any quirks
>>           enum:
>> @@ -116,6 +122,20 @@ properties:
>>         A phandle to the node that controls power or/and system resource or interface to firmware
>>         to enable ECAM compliant PCIe root complex.
>>   
>> +  interrupts:
>> +    description:
>> +      DWC PCIe Root Port/Complex specific MSI interrupt/IRQs.
>> +    minItems: 1
>> +    maxItems: 8
>> +
>> +  interrupt-names:
>> +    description:
>> +      MSI interrupt names
>> +    minItems: 1
>> +    maxItems: 8
>> +    items:
>> +        pattern: '^msi[0-9]+$'
> 
> Why the same devices have variable numbers?
Max supported MSI with designware PCIe controller is 8 Only, and it 
depends if those all are
used or some of used on specific vendor based device. Hence I have kept 
it here variable names. Although here it should be [0 - 7] instead of
[0 - 9].
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -146,11 +166,22 @@ allOf:
>>           reg:
>>             maxItems: 1
> 
> 
> Best regards,
> Krzysztof
> 

