Return-Path: <linux-pci+bounces-11258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01234947437
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 06:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D0D28198A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3220B0F;
	Mon,  5 Aug 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ax+oYWrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8722FB6;
	Mon,  5 Aug 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831111; cv=none; b=Mm3NdZfCR6uR+2umc9O6pYk75bSQ9O2QQkoTVSfD77lV3r1HFEntsyTPsveJO8GVVe3dAmnZsvTI3+aY8jx+pZUdM58EyPLcXg/uC++BfsmxBJDzGnLRGRSPWyEvkvCn5cWeJnWnc+w/VX/1zVgFeSfGCvGwrftRUZ1jhvvi0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831111; c=relaxed/simple;
	bh=9YVuj5IH9VTEMScxtkmR5XM25RnMa8qMCnxTjVSeBFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SR3I1rL5HADERs9WyoKyFWOVD1Ljd4h1AN+KlNvmSVBrk1zSS7TsOGXPzvmMvbEWmYDzRydIYcD5tOnORwwJpcVvcV0g6rCIuXksv84eZJblqfyB2qQMcO339uf8plYpB1AeBjj58TqwMCWJrwTIN3+VLX57Q34eBfGhy2wjAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ax+oYWrJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VrmR019897;
	Mon, 5 Aug 2024 04:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cHWeBWNMlbpaFY4SJSPBXZvb2E2Q4R2izSm+7NYeqmM=; b=ax+oYWrJHlnugyX9
	FESaAkbrI7zUIprkVC8F6+TBMc3kzzLpgNuVmGLkSBIsvEyHinw272h0VWvjFRtl
	dfqUwHG7S/H+xFB9NsR35iEDxAcMkf+wNpNsC6yjyQmEDeyD+kKofNz792kqz3lZ
	WZlwWEKC+oBjmlHmet1ADbBtCHOu7CX2ccpnhIwdzFkogecXeRVPjq4TKcB54mSL
	wWxhdMaH4Dcz5Mkv8I+vupJMAxz1LazLjI9TLYTU9zO3ZdySX2qgF4EhStKYAoVk
	JahApbM5Aejwbf+BXzuU+mN3j3VHwB9mRhMlMP3UCjH2jZaSw2/4JLp3TAee1x/M
	7qgTmA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scs2trfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:11:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4754BZmA002748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 04:11:35 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 21:11:29 -0700
Message-ID: <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
Date: Mon, 5 Aug 2024 09:41:26 +0530
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
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <5f65905c-f1e4-4f52-ba7c-10c1a4892e30@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _273UVowm5fYoEDzs27SkNEg1r8BhWL1
X-Proofpoint-GUID: _273UVowm5fYoEDzs27SkNEg1r8BhWL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050028



On 8/4/2024 2:23 PM, Krzysztof Kozlowski wrote:
> On 03/08/2024 05:22, Krishna chaitanya chundru wrote:
>> Add binding describing the Qualcomm PCIe switch, QPS615,
>> which provides Ethernet MAC integrated to the 3rd downstream port
>> and two downstream PCIe ports.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,qps615.yaml       | 191 +++++++++++++++++++++
>>   1 file changed, 191 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,qps615.yaml b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>> new file mode 100644
>> index 000000000000..ea0c953ee56f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,qps615.yaml
>> @@ -0,0 +1,191 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/qcom,qps615.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QPS615 PCIe switch
>> +
>> +maintainers:
>> +  - Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm QPS615 PCIe switch has one upstream and three downstream
>> +  ports. The 3rd downstream port has integrated endpoint device of
>> +  Ethernet MAC. Other two downstream ports are supposed to connect
>> +  to external device.
>> +
>> +  The QPS615 PCIe switch can be configured through I2C interface before
>> +  PCIe link is established to change FTS, ASPM related entry delays,
>> +  tx amplitude etc for better power efficiency and functionality.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - pci1179,0623
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  qcom,qps615-controller:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Reference to the I2C client used to do configure qps615
> 
> Why?
> 
>> +
>> +  vdd18-supply: true
>> +
>> +  vdd09-supply: true
>> +
>> +  vddc-supply: true
>> +
>> +  vddio1-supply: true
>> +
>> +  vddio2-supply: true
>> +
>> +  vddio18-supply: true
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO controlling the RESX# pin.
>> +
>> +  qps615,axi-clk-freq-hz:
>> +    description:
>> +      AXI clock which internal bus of the switch.
> 
> No need, use CCF.
> 
ack
>> +
>> +  qcom,l0s-entry-delay-ns:
>> +    description: Aspm l0s entry delay in nanoseconds.
>> +
>> +  qcom,l1-entry-delay-ns:
>> +    description: Aspm l1 entry delay in nanoseconds.
>> +
>> +  qcom,tx-amplitude-millivolt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Change Tx Margin setting for low power consumption.
>> +
>> +  qcom,no-dfe:
>> +    type: boolean
>> +    description: Disables DFE (Decision Feedback Equalizer).
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
> 
ack
>> +
>> +  qcom,nfts:
>> +    $ref: /schemas/types.yaml#/definitions/uint8
>> +    description:
>> +      Fast Training Sequence (FTS) is the mechanism that
>> +      is used for bit and Symbol lock.
> 
> What are the values? Why this is uint8?
> 
These represents number of fast training sequence and doesn't have
any units and the maximum value for this is 0xFF only so we used
uint8.
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
ack.
> 
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: pci1179,0623
>> +      required:
>> +        - compatible
> 
> Why do you have entire if? You do not have multiple variants, drop.
> 
The child nodes also referencing the qcom,qps615.yaml# node, I tried
to use this way to say "the below properties are for the required for
parent and optional for child".
>> +    then:
>> +      required:
>> +        - vdd18-supply
>> +        - vdd09-supply
>> +        - vddc-supply
>> +        - vddio1-supply
>> +        - vddio2-supply
>> +        - vddio18-supply
>> +        - qcom,qps615-controller
>> +        - reset-gpios
>> +
>> +patternProperties:
>> +  "@1?[0-9a-f](,[0-7])?$":
>> +    type: object
>> +    $ref: qcom,qps615.yaml#
>> +    additionalProperties: true
> 
> Nope, drop pattern Properties or explain what is this.
> 
the child nodes represent the downstream ports of the PCIe
switch which wants to use same properties that is why
I tried to use this pattern properties.
>> +
>> +additionalProperties: true
> 
> This cannot be true,
> 
Let me check on this correct in next versions.
>> +
>> +examples:
>> +  - |
>> +
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    pcie {
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +
>> +        pcie@0 {
>> +            device_type = "pci";
>> +            reg = <0x0 0x0 0x0 0x0 0x0>;
>> +
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            ranges;
>> +
>> +            pcie@0,0 {
>> +                compatible = "pci1179,0623";
>> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +                device_type = "pci";
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                ranges;
>> +
>> +                qcom,qps615-controller = <&qps615_controller>;
>> +
>> +                vdd18-supply = <&vdd>;
>> +                vdd09-supply = <&vdd>;
>> +                vddc-supply = <&vdd>;
>> +                vddio1-supply = <&vdd>;
>> +                vddio2-supply = <&vdd>;
>> +                vddio18-supply = <&vdd>;
>> +
>> +                reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>> +
>> +                pcie@1,0 {
>> +                    reg = <0x20800 0x0 0x0 0x0 0x0>;
> 
> Where is the compatible? You claim this is the same device as child?
> 
These all the PCIe downstream nodes and compatible is optional for the
PCIe nodes.
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +
>> +                    qcom,no-dfe;
>> +                };
>> +
>> +                pcie@2,0 {
>> +                    reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +
>> +                    qcom,nfts = /bits/ 8 <10>;
>> +                };
>> +
>> +                pcie@3,0 {
>> +                    reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +                    #address-cells = <3>;
>> +                    #size-cells = <2>;
>> +                    device_type = "pci";
>> +                    ranges;
>> +
>> +                    qcom,tx-amplitude-millivolt = <10>;
>> +
>> +                         pcie@0,0 {
> 
> Total mess in indentation.
>
Let me correct in next version.

- Krishna Chaitanya.

> 
> 
> Best regards,
> Krzysztof
> 

