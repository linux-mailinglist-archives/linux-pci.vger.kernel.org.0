Return-Path: <linux-pci+bounces-11267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3494749E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 07:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E88E281472
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41751422AB;
	Mon,  5 Aug 2024 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bk3/Pedx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988C13D502;
	Mon,  5 Aug 2024 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722835631; cv=none; b=qtDDbw7nd1l2h8Je1lTHPi+Gb+90UnV+06h2Gt/3gbwyn1AGCVfwxRWqjthPeYPpUxmMW5/6ht6C40gC5ROcbAGiTLAHyFJVcBM9M29Y3QTsXWIlcjpm3T4H+J4LXoFJt6tgBTmxG4OmVUCRVgSFL6c9dHfouliW5B3TcPH2JQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722835631; c=relaxed/simple;
	bh=tI9tNRCltCR8jh940fZedSvpAcB+6XJTjA4IDLdrehU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I8aiq3RLab6WAEWPSJXNZBXbSDIlWsXsKwIx/xceRS2X+pG35IA9IYBJRqyF1Okvcx4xVnpoA5lHNmhsEvtp/pDg+YjVA66xDSMY0Gp/GhWFdZAa1JcFa8pSxAyY00ZhiLUflmc1USIh5gRM33mwDcmxWr7iTwjcg95xJb16A1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bk3/Pedx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4752VZh6021397;
	Mon, 5 Aug 2024 05:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4kpVqL53JluNsgI9QBDPgANuBJ8NOu5WL2jucXPZXNc=; b=Bk3/PedxATkXfZaK
	lDWpzBI84zc/I/bZC7ku8oKSsFMSSNFa1IAtZkpcqvwFEUlDfbRwiSPJThL5p1nG
	23G+ZQzUARILB/YHDdC7vsK2+iBm/Zv9iWDmAK3cf3MPdPDZiK7yYxNMzR7dABRk
	BwpKY1MLVUVq1oAjtaDrBZZM+bOWpY6xURX1FuHmCn5ZchCqnKBGRuOH9jvY8uP/
	bchulsmc0L5QmhhZN6M0h/zAJnxaGvx+4vqzexuArNXvZR50zgvlkpYuHTBk4Lp0
	sM9PMPAJ1nhXDOYwFw0ybzIciRcSvKgtsJk/lnjNYhTzkLnrnlRdxKimqFbJQ+Q/
	+LwLCA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scmttw0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 05:26:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4755Qtxj007936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 05:26:55 GMT
Received: from [10.216.50.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 4 Aug 2024
 22:26:49 -0700
Message-ID: <100e27d7-2714-89ca-4a98-fccaa5b07be3@quicinc.com>
Date: Mon, 5 Aug 2024 10:56:46 +0530
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
 <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <58317fe2-fbea-400e-bd1d-8e64d1311010@kernel.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <58317fe2-fbea-400e-bd1d-8e64d1311010@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gq9ZwccU44MqHPYee9wBL3p23haw5WPg
X-Proofpoint-GUID: gq9ZwccU44MqHPYee9wBL3p23haw5WPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050037



On 8/5/2024 10:44 AM, Krzysztof Kozlowski wrote:
> On 05/08/2024 06:11, Krishna Chaitanya Chundru wrote:
> 
> 
>>>> +
>>>> +  qcom,nfts:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>>> +    description:
>>>> +      Fast Training Sequence (FTS) is the mechanism that
>>>> +      is used for bit and Symbol lock.
>>>
>>> What are the values? Why this is uint8?
>>>
>> These represents number of fast training sequence and doesn't have
>> any units and the maximum value for this is 0xFF only so we used
>> uint8.
>>> You described the desired Linux feature or behavior, not the actual
>>> hardware. The bindings are about the latter, so instead you need to
>>> rephrase the property and its description to match actual hardware
>>> capabilities/features/configuration etc.
>> ack.
>>>
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/pci/pci-bus-common.yaml#
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: pci1179,0623
>>>> +      required:
>>>> +        - compatible
>>>
>>> Why do you have entire if? You do not have multiple variants, drop.
>>>
>> The child nodes also referencing the qcom,qps615.yaml# node, I tried
>> to use this way to say "the below properties are for the required for
>> parent and optional for child".
> 
> I don't understand how child device can be exactly the same as parent
> device. How does it look in terms of hardware? Pins and supplies?
> 
>>>> +    then:
>>>> +      required:
>>>> +        - vdd18-supply
>>>> +        - vdd09-supply
>>>> +        - vddc-supply
>>>> +        - vddio1-supply
>>>> +        - vddio2-supply
>>>> +        - vddio18-supply
>>>> +        - qcom,qps615-controller
>>>> +        - reset-gpios
>>>> +
>>>> +patternProperties:
>>>> +  "@1?[0-9a-f](,[0-7])?$":
>>>> +    type: object
>>>> +    $ref: qcom,qps615.yaml#
>>>> +    additionalProperties: true
>>>
>>> Nope, drop pattern Properties or explain what is this.
>>>
>> the child nodes represent the downstream ports of the PCIe
>> switch which wants to use same properties that is why
>> I tried to use this pattern properties.
> 
> Downstream port is not the same as device. Why downstream port has the
> same supplies? To which pins are they connected?
> 
> 
Hi Krzysztof,

Downstream ports dosen't have pins or supplies to power on.

But there are properties like qcom,l0s-entry-delay-ns,
qcom,l1-entry-delay-ns,  qcom,tx-amplitude-millivolt etc which
applicable for child nodes also. Instead of re-declaring the
these properties again I tried to use pattern properties.

- krishna Chaitanya.
> 
> 
> Best regards,
> Krzysztof
> 

