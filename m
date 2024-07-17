Return-Path: <linux-pci+bounces-10455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334A934160
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC611F2263E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4D1822C0;
	Wed, 17 Jul 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WtIDneud"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061C1E526;
	Wed, 17 Jul 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236920; cv=none; b=Cu9KzS7UseEAKKJR8d9/6lYxDKdV9rw4wgDsLNk6oLVwp5L6OoXHwDpUrPLQ/VHZqG6g/JQRr7VLy/746aD8ZFBVQCoo/jz6KtCAryRCbRRdkXkde9pxw2AfJyF+jdzJ1lpEixYS0mkJSvQV9tBcQ9XRIJdYg0xq3hjnUZsiE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236920; c=relaxed/simple;
	bh=LOYQAzR1IpKOS+7iQOeSt2ATXbLm8RbC4jyBi9KUDjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k7I8BI4v7ayLTnE1wxPEmrty+b8RR08zuLLg93gwbU5UZHZCWwdXD3j2u6DwLBwgj6MQw607oLqnPJ8+kheIUrTN5VxtLReeUGSpBeMIhU5IEXRITZV8g3fXndgP9zulNkCm4G0uaxFSFtl7qeOvcz3XW+DuKdymznYOAOjOdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WtIDneud; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HEIUHm024108;
	Wed, 17 Jul 2024 17:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yyZCnApx7c/s4H/Xp0aWJIpHXD9TiJf88CC8LmS+rqQ=; b=WtIDneudaBOSuBKu
	SoZAt4fGEHsMZOrYvxDohMoV/aFZ5IcHWA9vHbrKICofobyq5l6223Rji3dec7k+
	P25dhOFGo5XovhLeem5Iilv+EpRgW1HBOsC36HKk7UhL8A43B63izWDI/2hoAOUR
	zZmg57+np/JZVOZeXromU7DGZ6P2lOc/GIPWDpWT5MfeEc6WY1Zejx9w3si88JXL
	z+8vqeixafd3pqVh6My4MrL2wDaeoFAZb6vY6ILZG0zTIrBqihjm/CrZ9HAgFElt
	+MqYvZ1opHQ3KmujEZC9B1oYnkv/LurtHlBuIDqTtSZF4sL3GKjM9j+14IlazI28
	PQ0xwg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfnk9je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 17:21:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HHKx90002795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 17:20:59 GMT
Received: from [10.110.77.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 10:20:57 -0700
Message-ID: <f06ab1ee-6078-4d89-b236-e11be4d28fc5@quicinc.com>
Date: Wed, 17 Jul 2024 10:20:57 -0700
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
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <3221423a-d5b3-47e3-8b98-623d9b26363d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SpZnw0sEu7O2R8AO4E9rLesDazYkmITV
X-Proofpoint-ORIG-GUID: SpZnw0sEu7O2R8AO4E9rLesDazYkmITV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407170132

Hi Krzysztof

On 7/16/2024 11:47 PM, Krzysztof Kozlowski wrote:
> On 17/07/2024 00:09, Mayank Rana wrote:
>> Hi Krzysztof
>>
>> On 7/16/2024 12:28 AM, Krzysztof Kozlowski wrote:
>>> On 15/07/2024 20:13, Mayank Rana wrote:
>>>> To support MSI functionality using Synopsys DesignWare PCIe controller
>>>> based MSI controller with ECAM driver, add "snps,dw-pcie-ecam-msi
>>>> compatible binding which uses provided SPIs to support MSI functionality.
>>>
>>> To support MSI, you add MSI support... That's a tautology. Describe
>>> hardware instead.
>> Ok. let me repharse it to provide more useful information.
>>>>
>>>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/pci/host-generic-pci.yaml  | 57 ++++++++++++++++++++++
>>>>    1 file changed, 57 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>> index 9c714fa..9e860d5 100644
>>>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>>> @@ -81,6 +81,12 @@ properties:
>>>>                  - marvell,armada8k-pcie-ecam
>>>>                  - socionext,synquacer-pcie-ecam
>>>>              - const: snps,dw-pcie-ecam
>>>> +      - description: |
>>>> +         Firmware is configuring Synopsys DesignWare PCIe controller in RC mode with
>>>> +         ECAM compatible fashion. To use MSI controller of Synopsys DesignWare PCIe
>>>> +         controller for MSI functionality, this compatible is used.
>>>> +        items:
>>>> +          - const: snps,dw-pcie-ecam-msi
>>>
>>> MSI is already present in the binding, isn't it?
>> It is mentioning as msi-parent usage which could be different MSI
>> controller (GIC or vendor specific one) not related to designware PCIe
>> controller based MSI controller.
>>
>>> Anyway, aren't you
>>> forgetting specific compatible? Please open your internal (quite
>>> comprehensive) guideline on bindings and DTS.
>> Here I am trying to define Designware based PCIe ECAM controller
>> supporting MSIcontroller based device. Hence I am not mentioning vendor
>> specific compatible usage
>> and keeping generic compatible binding for such device.
> 
> I know what you try, yet it feels simply wrong. Read your guideline.
> Are you sure you work on Designware core itself, not on one used in
> Qualcomm? I would expect people from Designware to design Designware
> cores and people from Qualcomm only to design licensed cores.
Ok. let me not make generic comment here. I refereed how it is done with 
other
snps based IP usage for example USB, and would follow same.
>>>
>>>>          - description:
>>>>              CAM or ECAM compliant PCI host controllers without any quirks
>>>>            enum:
>>>> @@ -116,6 +122,20 @@ properties:
>>>>          A phandle to the node that controls power or/and system resource or interface to firmware
>>>>          to enable ECAM compliant PCIe root complex.
>>>>    
>>>> +  interrupts:
>>>> +    description:
>>>> +      DWC PCIe Root Port/Complex specific MSI interrupt/IRQs.
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +
>>>> +  interrupt-names:
>>>> +    description:
>>>> +      MSI interrupt names
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +    items:
>>>> +        pattern: '^msi[0-9]+$'
>>>
>>> Why the same devices have variable numbers?
>> Max supported MSI with designware PCIe controller is 8 Only, and it
>> depends if those all are
>> used or some of used on specific vendor based device. Hence I have kept
>> it here variable names. Although here it should be [0 - 7] instead of
>> [0 - 9].
> 
> Wait, you just said there is no specific vendor device.
> 
> Sorry, bring some sanity to this
I understood that you are having concern about generic vs platform 
specific usage here in binding document. I would try avoid mixing those, 
and will try to do just platform specific usage. Thanks for having 
patience with me, and helping me to here.

Regards,
Mayank

