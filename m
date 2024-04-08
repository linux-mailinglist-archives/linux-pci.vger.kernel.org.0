Return-Path: <linux-pci+bounces-5896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21989CC40
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2129B1F21A1D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8A41448FD;
	Mon,  8 Apr 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hx3y1hej"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC8F51B;
	Mon,  8 Apr 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603364; cv=none; b=RoyHH2fGS95Nm8ELlu2M+IUTJiMvW/aI7GsTbxnJ9x0YJTNDCCrj8JaGpxtxnZf4KKImVMFo8RelHPpd/WJ1YyQ3S7PRbZrNu5AxHXp0F9JLDUCTPtPW1taLTzkiZbK/ggy5WS2Z9d0ebRNArLMz5yavqcdgiUaaluM/Duq53RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603364; c=relaxed/simple;
	bh=U7SlWaamETiCnfY+5UQ6kKK+bxdmnDe6vQ4vt5eDzVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O6mXJhucqBUDvO1cZm4S31BuMNYsmBwso6scfH5t8T/zrlU4FUIpJIVKyFRIpIB5167fLR5yWanQig3/RWASmfeZcL0dLG+VZMsrFvnkh4OD0eZGtrGhTU8tQMKoJNt2aox4WrKCGhHKsjJYZSMfhEg0WPa2B+maHEyWHF8wux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hx3y1hej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438IxXRd020089;
	Mon, 8 Apr 2024 19:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0SVnkQsVTBl2dJJx5q8g0sMCd0tZ2akDMqMCk6xxxLU=; b=Hx
	3y1hejC0xjHb2tua2zESy4+HgcvYV1kg4SUZeMzhu0oGhMUhMyrN4RSiY93gwnVb
	UzfV3Do5DBq+kaVy8x+cyn0a8Zjk457vOHmpa8hmy0ap9vriwqrv09TINuM6xEBE
	wEdFGPrSBQLkhBuepzbtM1lN3EBxQDNjJmnlUuY0WVR57PB5pihDLfunJt7BCosN
	pNNpTnv5wWAUXSYDLsIrCdJf4TJ4+5p8Q8e6k+2n3DhMcqOdUSfmstgm07dGNB59
	qCmWoYzHmCegdf8WfwGy8tQD3vNuPxNg46/8jnFMf1jaaOtE+/1keR1qcOp12URm
	zaQNvjLcviOyD7ECEYLg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg09pxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 19:09:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438J9CBG028387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 19:09:12 GMT
Received: from [10.110.52.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 12:09:12 -0700
Message-ID: <1d6911e2-d0ec-4cb0-b417-af5001a4f8a3@quicinc.com>
Date: Mon, 8 Apr 2024 12:09:11 -0700
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
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <51b02d02-0e20-49df-ad13-e3dbe3c3214f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pQgWknvelri6Ti57XfXZ4X23az7toq-f
X-Proofpoint-ORIG-GUID: pQgWknvelri6Ti57XfXZ4X23az7toq-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_16,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080148

Hi Krzysztof

On 4/4/2024 12:30 PM, Krzysztof Kozlowski wrote:
> On 04/04/2024 21:11, Mayank Rana wrote:
>> On some of Qualcomm platform, firmware configures PCIe controller in RC
> 
> On which?
> 
> Your commit or binding must answer to all such questions.
> 
>> mode with static iATU window mappings of configuration space for entire
>> supported bus range in ECAM compatible mode. Firmware also manages PCIe
>> PHY as well required system resources. Here document properties and
>> required configuration to power up QCOM PCIe ECAM compatible root complex
>> and PHY for PCIe functionality.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie-ecam.yaml    | 94 ++++++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
>> new file mode 100644
>> index 00000000..c209f12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/qcom,pcie-ecam.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm ECAM compliant PCI express root complex
>> +
>> +description: |
> Do not need '|' unless you need to preserve formatting.
ACK
> 
>> +  Qualcomm SOC based ECAM compatible PCIe root complex supporting MSI controller.
> 
> Which SoC?
ACK
>> +  Firmware configures PCIe controller in RC mode with static iATU window mappings
>> +  of configuration space for entire supported bus range in ECAM compatible mode.
>> +
>> +maintainers:
>> +  - Mayank Rana <quic_mrana@quicinc.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,pcie-ecam-rc
> 
> No, this must have SoC specific compatibles.
This driver is proposed to work with any PCIe controller supported ECAM 
functionality on Qualcomm platform
where firmware running on other VM/processor is controlling PCIe PHY and 
controller for PCIe link up functionality.
Do you still suggest to have SoC specific compatibles here ?
>> +
>> +  reg:
>> +    minItems: 1
> 
> maxItems instead
> 
>> +    description: ECAM address space starting from root port till supported bus range
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 8
> 
> This is way too unspecific.
will review and update.
>> +
>> +  ranges:
>> +    minItems: 2
>> +    maxItems: 3
> 
> Why variable?
It depends on how ECAM configured to support 32-bit and 64-bit based 
prefetch address space.
So there are different combination of prefetch (32-bit or 64-bit or 
both) and non-prefetch (32-bit), and IO address space available. hence 
kept it as variable with based on required use case and address space 
availability.
>> +
>> +  iommu-map:
>> +    minItems: 1
>> +    maxItems: 16
> 
> Why variable?
> 
> Open existing bindings and look how it is done.
ok. will review and update as needed.
> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +    description: A phandle to node which is able support way to communicate with firmware
>> +        for enabling PCIe controller and PHY as well managing all system resources needed to
>> +        make both controller and PHY operational for PCIe functionality.
> 
> This description does not tell me much. Say something specific. And drop
> redundant parts like phandle.
ok. will rephrase it.
> 
>> +
>> +  dma-coherent: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - ranges
>> +  - power-domains
>> +  - device_type
>> +  - linux,pci-domain
>> +  - bus-range
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        pcie0: pci@1c00000 {
>> +            compatible = "qcom,pcie-ecam-rc";
>> +            reg = <0x4 0x00000000 0 0x10000000>;
>> +            device_type = "pci";
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            ranges = <0x01000000 0x0 0x40000000 0x0 0x40000000 0x0 0x100000>,
>> +                <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
>> +                <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x100000>;
> 
> Follow DTS coding style about placement and alignment.
> 
> Best regards,
> Krzysztof
> 
Regards,
Mayank

